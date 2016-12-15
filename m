Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: NickZhokhov <nick.zhokhov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluetoothd CPU 100%
Message-ID: <eb5b5ed3-353d-b650-3830-bde7e56b70f6@gmail.com>
Date: Thu, 15 Dec 2016 22:29:41 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

Distr Fedora 24 x64

bluez-5.43-1.fc24.x86_64
bluez-debuginfo-5.43-1.fc24.x86_64
glib2-2.48.2-1.fc24.x86_64
glib2-debuginfo-2.48.2-1.fc24.x86_64


After some time of working bluetoothd starts consumes 100% CPU (top output)
at this time strace -o strace.log -p <pid>
several seconds ctrl-c to stop
strace.log ~ 60 mb

...
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=7, 
events=POLLIN}, {fd=8, events=POLLIN}, {fd=9, events=POLLIN}, {fd=11, 
events=POLLIN}, {fd=12, events=POLLIN}, {fd=13, events=POLLIN}, {fd=14, 
events=POLLIN}, {fd=15, events=POLLIN}, {fd=16, events=POLLIN}, {fd=17, 
events=POLLIN}, {fd=18, events=POLLIN}, {fd=19, events=POLLIN}, {fd=20, 
events=POLLIN}, {fd=21, events=POLLIN}, {fd=23, events=POLLOUT}], 17, 
-1) = 1 ([{fd=23, revents=POLLNVAL}])
...

http://git.kernel.org/cgit/bluetooth/bluez.git/commit/?id=3b97946c32b28af92a5a809bb690dc9be3af6eaf 


It was already met in past 2007.

I found many similar reports about cpu consuming in many linux distr 
bugtrack.
And possibly it has the same mechanism as described.

Here is another excerpt strace (there is whole strace from bluetoothd 
start till appearing bluetoothd CPU 100% by top util)

socket(AF_BLUETOOTH, SOCK_SEQPACKET, 0) = 15
bind(15, {sa_family=AF_BLUETOOTH, sa_data="\21\0CM\241m\360t\0\0\0\0"}, 
14) = 0
setsockopt(15, SOL_BLUETOOTH, 4, "\1\0", 2) = 0
fstat(15, {st_mode=S_IFSOCK|0777, st_size=0, ...}) = 0
fcntl(15, F_GETFL)                      = 0x2 (flags O_RDWR)
fcntl(15, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
listen(15, 5)

...

socket(AF_BLUETOOTH, SOCK_SEQPACKET, 0) = 16
bind(16, {sa_family=AF_BLUETOOTH, sa_data="\23\0CM\241m\360t\0\0\0\0"}, 
14) = 0
setsockopt(16, SOL_BLUETOOTH, 4, "\1\0", 2) = 0
fstat(16, {st_mode=S_IFSOCK|0777, st_size=0, ...}) = 0
fcntl(16, F_GETFL)                      = 0x2 (flags O_RDWR)
fcntl(16, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
setsockopt(16, SOL_BLUETOOTH, 7, [30], 4) = 0
listen(16, 5)                           = 0

...

accept(15, NULL, NULL)                  = 24
fstat(24, {st_mode=S_IFSOCK|0777, st_size=0, ...}) = 0
fcntl(24, F_GETFL)                      = 0x2 (flags O_RDWR)
fcntl(24, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
getsockopt(24, SOL_SOCKET, SO_DOMAIN, [31], [4]) = 0
getsockopt(24, SOL_SOCKET, SO_PROTOCOL, [0], [4]) = 0
getsockname(24, {sa_family=AF_BLUETOOTH, 
sa_data="\21\0CM\241m\360t@\0\0\0"}, [14]) = 0
getsockopt(24, SOL_TCP, TCP_NODELAY, "\271\0\240\2\377\377\0\0\3\0?\0", 
[12]) = 0
getpeername(24, {sa_family=AF_BLUETOOTH, 
sa_data="\21\0\375\3\344a\7\0t\0\0\0"}, [14]) = 0

...

accept(16, NULL, NULL)                  = 25
fstat(25, {st_mode=S_IFSOCK|0777, st_size=0, ...}) = 0
fcntl(25, F_GETFL)                      = 0x2 (flags O_RDWR)
fcntl(25, F_SETFL, O_RDONLY|O_NONBLOCK) = 0
getsockopt(25, SOL_SOCKET, SO_DOMAIN, [31], [4]) = 0
getsockopt(25, SOL_SOCKET, SO_PROTOCOL, [0], [4]) = 0
getsockname(25, {sa_family=AF_BLUETOOTH, 
sa_data="\23\0CM\241m\360tA\0\0\0"}, [14]) = 0
getsockopt(25, SOL_TCP, TCP_NODELAY, "\240\2\240\2\377\377\0\1\3\0?\0", 
[12]) = 0
getpeername(25, {sa_family=AF_BLUETOOTH, 
sa_data="\23\0\375\3\344a\7\0u\0\0\0"}, [14]) = 0


...
poll([{fd=25, events=POLLOUT}], 1, 0)   = 0 (Timeout)
read(25, "", 1)                         = 0
,,,

poll([{fd=25, events=POLLNVAL}], 1, 0)  = 0 (Timeout)
getsockopt(25, SOL_SOCKET, SO_DOMAIN, [31], [4]) = 0
getsockopt(25, SOL_SOCKET, SO_PROTOCOL, [0], [4]) = 0
getsockname(25, {sa_family=AF_BLUETOOTH, 
sa_data="\23\0CM\241m\360tA\0\0\0"}, [14]) = 0
getsockopt(25, SOL_TCP, TCP_NODELAY, "\271\0\240\2\377\377\0\0\3\0?\0", 
[12]) = 0
getpeername(25, {sa_family=AF_BLUETOOTH, 
sa_data="\23\0\375\3\344a\7\0u\0\0\0"}, [14]) = 0

...

getsockopt(25, SOL_SOCKET, SO_DOMAIN, [31], [4]) = 0
getsockopt(25, SOL_SOCKET, SO_PROTOCOL, [0], [4]) = 0
setsockopt(25, SOL_BLUETOOTH, 4, "\2\0", 2) = 0
...
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=7, 
events=POLLIN}, {fd=8, events=POLLIN}, {fd=9, events=POLLIN}, {fd=11, 
events=POLLIN}, {fd=12, events=POLLIN}, {fd=13, events=POLLIN}, {fd=14, 
events=POLLIN}, {fd=15, events=POLLIN}, {fd=16, events=POLLIN}, {fd=17, 
events=POLLIN}, {fd=18, events=POLLIN}, {fd=19, events=POLLIN}, {fd=20, 
events=POLLIN}, {fd=21, events=POLLIN}, {fd=22, events=0}, {fd=23, 
events=0}, {fd=24, events=0}, {fd=25, events=POLLOUT}], 20, -1) = 3 
([{fd=8, revents=POLLIN}, {fd=24, revents=POLLERR|POLLHUP}, {fd=25, 
revents=POLLERR|POLLHUP}])
read(3, 0x7fff38f2adc0, 16)             = -1 EAGAIN (Resource 
temporarily unavailable)
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
read(8, "\f\0\0\0\10\0\375\3\344a\7\0\0\1", 512) = 14
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
close(24)                               = 0
close(25)                               = 0
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
write(3, "\1\0\0\0\0\0\0\0", 8)         = 8
poll([{fd=3, events=POLLIN}, {fd=4, events=POLLIN}, {fd=7, 
events=POLLIN}, {fd=8, events=POLLIN}, {fd=9, events=POLLIN}, {fd=11, 
events=POLLIN}, {fd=12, events=POLLIN}, {fd=13, events=POLLIN}, {fd=14, 
events=POLLIN}, {fd=15, events=POLLIN}, {fd=16, events=POLLIN}, {fd=17, 
events=POLLIN}, {fd=18, events=POLLIN}, {fd=19, events=POLLIN}, {fd=20, 
events=POLLIN}, {fd=21, events=POLLIN}, {fd=22, events=0}, {fd=23, 
events=0}, {fd=25, events=POLLOUT}], 19, 0) = 2 ([{fd=3, 
revents=POLLIN}, {fd=25, revents=POLLNVAL}])

ops fd=25 is not deleted from poll list
after that loop in poll due to invalid handle and cpu consuming.

Though if I start bluetoothctl and try connect device
CPU loading goes to normal.

In my case

Device 00:07:61:A6:61:AC Bluetooth Laser Travel Mouse
Device 00:07:61:E4:03:FD Logitech diNovo Mini

and I have suspection that problem is issued  00:07:61:E4:03:FD.

One of way to 100% reproduce problem connect  00:07:61:E4:03:FD
get it connected then press connect buttons on device.

I wonder how using glib event loop one happens that 'GSource' is not 
deleted from context or set as 'inactive' when handle is invalid.

--Nick Zhokhov


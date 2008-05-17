Return-Path: <cyrus@holtmann.org>
Date: Sun, 18 May 2008 00:52:45 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <599220.56466.qm@web52910.mail.re2.yahoo.com>
Subject: [Bluez-users] USB dongle cannot pair with A2DP speakers
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I have a pair of A2DP speakers and I am trying to pair them with a USB bluetooth adapter on Fedora
8 with a 2.6.25.4 kernel (bluez-libs,utils 3.31, bluez-gnome 0.26):

Bus 003 Device 004: ID 050d:0121 Belkin Components F5D5050 100Mbps Ethernet
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x050d Belkin Components
  idProduct          0x0121 F5D5050 100Mbps Ethernet
  bcdDevice            4.13
  iManufacturer           1 Broadcom Corp
  iProduct                2 BELKIN BLUETOOTH USB ADAPTER CL. 1
  iSerial                 3 000A3A7DFF80
  bNumConfigurations      1

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:3A:7D:FF:80 ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN 
        RX bytes:22324 acl:289 sco:0 events:655 errors:0
        TX bytes:17148 acl:288 sco:0 commands:230 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'volcano.underworld-0'
        Class: 0x080404
        Service Classes: Capturing
        Device Class: Audio/Video, Device conforms to the Headset profile
        HCI Ver: 2.0 (0x3) HCI Rev: 0x419d LMP Ver: 2.0 (0x3) LMP Subver: 0x430e
        Manufacturer: Broadcom Corporation (15)

# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:0A:3A:7D:FF:80 ACL MTU: 1017:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
                <transparent SCO> <broadcast encrypt> <EDR ACL 2 Mbps> 
                <EDR ACL 3 Mbps> <enhanced iscan> <interlaced iscan> 
                <interlaced pscan> <inquiry with RSSI> <extended SCO> 
                <EV4 packets> <EV5 packets> <AFH cap. slave> 
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features> 

However, my attempts to pair these speakers with my adapter are all failing because the connection
is being dropped before I can authenticate. This is what strace says about my "auth" command:

# strace hcitool auth 00:14:EF:00:20:05
execve("/usr/bin/hcitool", ["hcitool", "auth", "00:14:EF:00:20:05"], [/* 44 vars */]) = 0
brk(0)                                  = 0xb8c4e000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=87325, ...}) = 0
mmap2(NULL, 87325, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7efe000
close(3)                                = 0
open("/usr/lib/libbluetooth.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@A\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=87276, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7efd000
mmap2(NULL, 85936, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ee8000
mmap2(0xb7efc000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) =
0xb7efc000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360TlB4\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1692524, ...}) = 0
mmap2(NULL, 1410608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7d8f000
mmap2(0xb7ee2000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x153) =
0xb7ee2000
mmap2(0xb7ee5000, 9776, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =
0xb7ee5000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7d8e000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7d8e6c0, limit:1048575, seg_32bit:1,
contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb7ee2000, 8192, PROT_READ)   = 0
mprotect(0xb7f30000, 4096, PROT_READ)   = 0
munmap(0xb7efe000, 87325)               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 3
brk(0)                                  = 0xb8c4e000
brk(0xb8c6f000)                         = 0xb8c6f000
ioctl(3, 0x800448d2, 0xb8c4e008)        = 0
ioctl(3, 0x800448d4, 0xb8c4e090)        = 0
close(3)                                = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 3
bind(3, {sa_family=AF_BLUETOOTH, sa_data="\0\0\340\324\363\267k\266\223\277\0\0\0\0"}, 4) = 0
ioctl(3, 0x800448d5, 0xb8c4e008)        = 0
getsockopt(3, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\242\366", [16]) = 0
setsockopt(3, SOL_IP, IP_TTL, "\20\0\0\0@\300\0\0\0\0\0\0\21\4\0\0", 16) = 0
writev(3, [{"\1", 1}, {"\21\4\2", 3}, {"\f\0", 2}], 3) = 6
poll([{fd=3, events=POLLIN, revents=POLLIN}], 1, 25000) = 1
read(3, "\4\17\4\0\1\21\4", 260)        = 7
poll([{fd=3, events=POLLIN, revents=POLLIN}], 1, 24990) = 1
read(3, "\4\6\3\30\f\0", 260)           = 6
setsockopt(3, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\242\366", 16) = 0
dup(2)                                  = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(4, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f13000
_llseek(4, 0, 0xbf938f94, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(4, "HCI authentication request faile"..., 54HCI authentication request failed: Input/output
error
) = 54
close(4)                                = 0
munmap(0xb7f13000, 4096)                = 0
exit_group(1)                           = ?

I know that there's nothing wrong with the speakers because I also have a laptop with a built-in
bluetooth adapter (also F8, 2.6.25.4 kernel), and this has managed to pair with and them use the
speakers without difficulty. I can also use l2ping between my USB adapter and my speakers, despite
them not having paired:

# l2ping 00:14:EF:00:20:05
Ping: 00:14:EF:00:20:05 from 00:0A:3A:7D:FF:80 (data size 44) ...
4 bytes from 00:14:EF:00:20:05 id 0 time 7.73ms
4 bytes from 00:14:EF:00:20:05 id 1 time 22.91ms
4 bytes from 00:14:EF:00:20:05 id 2 time 21.68ms
4 bytes from 00:14:EF:00:20:05 id 3 time 20.44ms
4 bytes from 00:14:EF:00:20:05 id 4 time 19.24ms
4 bytes from 00:14:EF:00:20:05 id 5 time 11.01ms
...

However, this seems to be as much as I can do until they have bonded. (In fact, the only way that
I could keep the connection alive long enough to strace the "auth" command was by using l2ping.)

Does anyone have any suggestions for anything else to try, please?

Cheers,
Chris


      __________________________________________________________
Sent from Yahoo! Mail.
A Smarter Email http://uk.docs.yahoo.com/nowyoucan.html

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

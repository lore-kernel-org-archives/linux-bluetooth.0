Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Krisztian Mark Szentes <office@produktivit.com>
To: bluez-users@lists.sourceforge.net
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
In-Reply-To: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
MIME-Version: 1.0
Message-Id: <200305081542.17759.office@produktivit.com>
Subject: [Bluez-users] bt3c_cs time out - no firmware loaded?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 8 May 2003 15:43:44 +0200
Content-Type: text/plain; CHARSET=iso-8859-1

Hi

I have trouble with the 3COM Cardbus bluetooth card on a Powerbook Titanium (a 
powerpc notebook). I patched the 2.4.20 kernel with the mh-6 patch (and the 
benh patch which does not collide). I haven't found any hint on the list yet.

With a USB bluetooth adapter (hci_usb) everything works fine. I have a 
wonderful RFCOMM communication to a Nokia 6310 and I can get on the internet 
via GPRS.

When, however, using a 3COM Bluetooth adapter, I get 
connection timed out errors.
like:
tomcat:/home/m# hciconfig hci0 reset
Can't init device hci0. Connection timed out(110)

or:
tomcat:/home/m# strace hciconfig hci0 up
execve("/sbin/hciconfig", ["hciconfig", "hci0", "up"], [/* 24 vars */]) = 0
uname({sys="Linux", node="tomcat", ...}) = 0
brk(0)                                  = 0x10016018
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=41397, ...}) = 0
mmap(NULL, 41397, PROT_READ, MAP_PRIVATE, 3, 0) = 0x30016000
close(3)                                = 0
open("/usr/lib/libbluetooth.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0*D"..., 1024) = 
1024
fstat64(3, {st_mode=S_IFREG|0644, st_size=27132, ...}) = 0
mmap(0xffd9000, 91936, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xffd9000
mprotect(0xffe0000, 63264, PROT_NONE)   = 0
mmap(0xffe9000, 28672, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 
3, 0) = 0xffe9000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\316"..., 1024) = 
1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1273304, ...}) = 0
mmap(0xfe80000, 1343768, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfe80000
mprotect(0xffb0000, 98584, PROT_NONE)   = 0
mmap(0xffb0000, 90112, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 
3, 0x120000) = 0xffb0000
mmap(0xffc6000, 8472, PROT_READ|PROT_WRITE|PROT_EXEC, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffc6000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x30021000
mprotect(0xfe80000, 1245184, PROT_READ|PROT_WRITE) = 0
mprotect(0xfe80000, 1245184, PROT_READ|PROT_EXEC) = 0
munmap(0x30016000, 41397)               = 0
socket(0x1f /* PF_??? */, SOCK_RAW, 1)  = 3
ioctl(3, 0x400448d3, 0x10015fbc)        = 0
ioctl(3, 0x800448c9, 0)                 = -1 ETIMEDOUT (Connection timed out)
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x30016000
write(1, "Can\'t init device hci0. Connecti"..., 50Can't init device hci0. 
Connection timed out(110)
) = 50
munmap(0x30016000, 4096)                = 0
exit(1)                                 = ?
tomcat:/home/m#

then: 

tomcat:/home/m# hciconfig -a
hci0:   Type: PCCARD
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:4 acl:0 sco:0 commands:1 errors:0
        Features: 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy:
        Link mode: SLAVE ACCEPT

lsmod delivers (just relevant lines):

bt3c_cs                 9396   1
l2cap                  18416   2  (autoclean)
hci_usb                 7744   0  (autoclean) (unused)
rfcomm                 34548   2  (autoclean)
bluez                  36472   2  (autoclean) [bt3c_cs l2cap hci_usb rfcomm]
ds                      8432   1  [bt3c_cs]
yenta_socket           11088   1
pcmcia_core            42464   0  [bt3c_cs ds yenta_socket]
unix                   17528 184  (autoclean)

Booting looks like:

May  8 14:57:32 tomcat kernel: Linux Kernel Card Services 3.1.22
May  8 14:57:32 tomcat kernel:   options:  [pci] [cardbus] [pm]
May  8 14:57:32 tomcat kernel: Intel PCIC probe: not found.
May  8 14:57:33 tomcat kernel: Yenta IRQ list 0000, PCI irq58
May  8 14:57:33 tomcat kernel: Socket status: 30000086
May  8 14:57:33 tomcat cardmgr[1070]: watching 1 sockets
May  8 14:57:33 tomcat cardmgr[1071]: starting, version is 3.2.2
...
May  8 14:58:52 tomcat hcid[1428]: HCI daemon ver 2.3 started
May  8 14:58:53 tomcat kernel: BlueZ Core ver 2.2 Copyright (C) 2000,2001 
Qualcomm Inc
May  8 14:58:53 tomcat kernel: Written 2000,2001 by Maxim Krasnyansky 
<maxk@qualcomm.com>
May  8 14:58:53 tomcat kernel: register(bluetooth/rfcomm/47): could not append 
to parent, err: -17
May  8 14:58:53 tomcat kernel: devfs_register(bluetooth/rfcomm/48): could not 
append to parent, err: -17
May  8 14:58:53 tomcat kernel: devfs_register(bluetooth/rfcomm/49): could not 
append to parent, err: -17
... (this one goes up to /255, this is just because of the devfs daemon, 
without it the timeout still persists) ...
May  8 14:58:53 tomcat kernel: devfs_register(bluetooth/rfcomm/255): could not 
append to parent, err: -17
May  8 14:58:53 tomcat kernel: BlueZ RFCOMM ver 0.4
May  8 14:58:53 tomcat kernel: Copyright (C) 2002 Maxim Krasnyansky 
<maxk@qualcomm.com>
May  8 14:58:53 tomcat kernel: Copyright (C) 2002 Marcel Holtmann 
<marcel@holtmann.org>
May  8 14:58:53 tomcat kernel: BlueZ HCI USB driver ver 2.4 Copyright (C) 
2000,2001 Qualcomm Inc
May  8 14:58:53 tomcat kernel: Written 2000,2001 by Maxim Krasnyansky 
<maxk@qualcomm.com>
May  8 14:58:53 tomcat kernel: usb.c: registered new driver hci_usb
May  8 14:58:53 tomcat kernel: BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 
Qualcomm Inc
May  8 14:58:53 tomcat kernel: Written 2000,2001 by Maxim Krasnyansky 
<maxk@qualcomm.com>
May  8 14:58:54 tomcat sdpd[1436]: SDPd ver 1.1 started

then I insert the card, and it gives:

May  8 15:02:20 tomcat cardmgr[1071]: socket 0: 3Com Bluetooth PC Card
May  8 15:02:20 tomcat cardmgr[1071]: executing: 'modprobe bt3c_cs'
May  8 15:02:21 tomcat hcid[1428]: HCI dev 0 registered
May  8 15:02:31 tomcat hcid[1616]: Can't init device hci0. Connection timed 
out(110)

in dmesg a line appears:
cs: memory probe 0x80000000-0x80ffffff: excluding 0x80000000-0x800fffff


the 3COM firmware is located in /etc/bluetooth/firmware (as suggested on 
http://www.holtmann.org/linux/bluetooth/bt3c.html) and has the size:

tomcat:/home/m# ls -la /etc/bluetooth/firmware/
total 12
drwxr-xr-x    2 root     root         4096 Oct 11  2002 .
drwxr-xr-x    3 root     root         4096 May  8 12:56 ..
-r-xr-xr-x    1 h        h            3726 Oct 11  2002 BT3CPCC.bin

tomcat:/home/m# file /etc/bluetooth/firmware/BT3CPCC.bin
/etc/bluetooth/firmware/BT3CPCC.bin: Motorola S-Record; binary data in text 
format

the bluefw package is installed from sourceforge (debian):
ii  bluez-bluefw              1.0-1                     Firmware and loader 
for BCM2033-based Bluetooth devices
tomcat:/home/m# dpkg -L bluez-bluefw
/.
/etc
/etc/hotplug
/etc/hotplug/usb
/etc/hotplug/usb/bluefw.usermap
/etc/hotplug/usb/bluefw
/usr
/usr/share
/usr/share/doc
/usr/share/doc/bluez-bluefw
/usr/share/doc/bluez-bluefw/BCM-LEGAL.txt
/usr/share/doc/bluez-bluefw/README.Debian
/usr/share/doc/bluez-bluefw/copyright
/usr/share/doc/bluez-bluefw/changelog.gz
/usr/share/doc/bluez-bluefw/changelog.Debian.gz
/usr/share/bluez-bluefw
/usr/share/bluez-bluefw/BCM2033-FW.bin
/usr/share/bluez-bluefw/BCM2033-MD.hex
/usr/share/man
/usr/share/man/man8
/usr/share/man/man8/bluefw.8.gz
/usr/sbin
/usr/sbin/bluefw

and /sbin/bluefw being a symlink to /usr/sbin/bluefw

What's wrong? Am I supposed to use another bluefw executable?

Thanks,

Mark





-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

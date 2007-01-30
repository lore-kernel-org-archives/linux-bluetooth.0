Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: paivakil@gmail.com (Mahesh T. Pai)
Date: Wed, 31 Jan 2007 02:40:06 +0530
Message-ID: <87tzy89q6p.fsf@nandini.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: [Bluez-users] 'hcitool scan' failing
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--=-=-=


I  am trying to  set up  bluetooth networking  on two  systems running
debian  unstable. One  is an  i386 and  other is  running  amd64.  The
OS/software is otherwise identical for both systems.

The USB dongles are detected, and  show up in output of 'hcitool dev';
but neither  system picks up signals  from the other  - `hcitool scan'
simply fails.

Here is  is relevant output from  the i386 machine (no  network to the
amd64 machine, obviously)

Kernel version is 2.6.18-3-686 #1 SMP (it is a single processor
machine, just in case it is relevant.)

# lsmod |grep blue
bluetooth              45732  8 bnep,rfcomm,l2cap,hci_usb

# lsmod |grep usb
hci_usb                16028  2
bluetooth              45732  8 bnep,rfcomm,l2cap,hci_usb
usbcore               112676  3 hci_usb,uhci_hcd

# lsusb
lsusb
Bus 001 Device 002: ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter
Bus 001 Device 001: ID 0000:0000

(device ID is same on both systems)

Contents of /proc/bus/usb/devices is


T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 27/900 us ( 3%), #Int=  1, #Iso=  2
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-3-686 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:07.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=16 #Cfgs=  1
P:  Vendor=1131 ProdID=1001 Rev= 3.73
S:  Product=ISSCBTA
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


Output of /proc/devices is

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 29 fb
 99 ppdev
116 alsa
128 ptm
136 pts
180 usb
189 usb_device
216 rfcomm
226 drm

Block devices:
  1 ramdisk
  2 fd
  3 ide0
 22 ide1

I have attached a file which is the output of hcidump -w (as desired
in the archives).

Out put of hciconfig -a is:-

hci0:   Type: USB
        BD Address: 11:11:11:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:2473 acl:0 sco:0 events:62 errors:0
        TX bytes:983 acl:0 sco:0 commands:58 errors:0
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: MASTER
        Name: 'nandini.home-0'
        Class: 0x3e0104
        Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe
        Manufacturer: Integrated System Solution Corp. (57)


On the amd64 system, the `Link Mode:' entry is `SLAVE ACCEPT', which I
believe  is the  the way  it should  be. RSWITCH  is disabled  in Link
Policy   line.  (I   have  been   playing  around   a  lot   with  the
configuration.)

Other USB devices work fine on both systems. (printer, digital camera,
a nokia 3100 phone which will not work with gnokii... etc)

For the amd64 machine, I checked the Mother board manufacturer's site
for bios updates, and find that 4 later versions are
available. (Again, just in case the info is relevant - thinking of
bios upgrades because dmesg complains of losing clock ticks _and_ some
thing about bios handoff failure.).

Here is something which may be relevant in the logs:-

Jan 31 00:26:14 nandini pand[7138]: Accept failed. Interrupted system call(4)
Jan 31 00:26:14 nandini pand[7138]: Service record unregistration failed.
Jan 31 00:27:38 nandini pand[8330]: Accept failed. Interrupted system call(4)
Jan 31 00:27:38 nandini pand[8330]: Service record unregistration failed.
Jan 31 00:28:45 nandini pand[8357]: Accept failed. Interrupted system call(4)

(on later occassion - after a reboot).

hcid[8383]: Can't open system message bus connection:
+Failed to connect to socket /var/run/dbus/system_bus_socket: No such file or
+directory
Jan 31 01:32:06 nandini hcid[8383]: D-Bus failed to register /org/bluez/hci0
+object

[Where am I | what is] going wrong?


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=noremotedevice.log
Content-Transfer-Encoding: base64

CQAAAKeXv0W2YwEAAQEEBTOLnggABwABAKeXv0X0awEABA8EAAEBBAQAAQCxl79FAxUFAAQBAQAJ
AAAAy5e/Rb0OCQABAQQFM4ueBgAHAAEAy5e/RT4eCQAEDwQAAQEEBAABANOXv0XmOQQABAEBAAkA
AAD3mL9FvToJAAEBBAUzi54GAAcAAQD3mL9Fz0cJAAQPBAABAQQEAAEA/5i/RZRfBAAEAQEACQAA
ACOav0UeVwkAAQEEBTOLngYABwABACOav0WqZQkABA8EAAEBBAQAAQArmr9FWYEEAAQBAQAJAAAA
T5u/RW9zCQABAQQFM4ueBgAHAAEAT5u/RbJ/CQAEDwQAAQEEBAABAFebv0VllwQABAEBAAkAAAB7
nL9Fs8gJAAEBBAUzi54GAAcAAQB7nL9FL9gJAAQPBAABAQQEAAEAg5y/Rb3zBAAEAQEACQAAAKed
v0U46gkAAQEEBTOLngYABwABAKedv0UL+gkABA8EAAEBBAQAAQCvnb9F3BEFAAQBAQAJAAAA056/
RZ5CCgABAQQFM4ueBgAHAAEA056/RT9SCgAEDwQAAQEEBAABANuev0UmagUABAEBAAkAAAD/n79F
MF8KAAEBBAUzi54GAAcAAQD/n79FMWwKAAQPBAABAQQEAAEAB6C/RQCIBQAEAQEACQAAACuhv0Xb
egoAAQEEBTOLngYABwABACuhv0UOigoABA8EAAEBBAQAAQAzob9F16EFAAQBAQAJAAAAV6K/ReCW
CgABAQQFM4ueBgAHAAEAV6K/RSakCgAEDwQAAQEEBAABAF+iv0WwvwUABAEBAAkAAAA6o79FcM8E
AAEBBAUzi54IAAcAAQA6o79FCN8EAAQPBAABAQQEAAEARKO/RR+ECAAEAQEACQAAAIOjv0VwsgoA
AQEEBTOLngYABwABAIOjv0XcwQoABA8EAAEBBAQAAQCLo79Fn9kFAAQBAQA=
--=-=-=

 
(PS:- I am not subscribed - I use the gmane archives).

-- 
 Mahesh T. Pai <<>> http://paivakil.blogspot.com/
Free Software - it is free as in FREEDOM

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-=-=--

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <c93f2a2905012302107465ea43@mail.gmail.com>
From: Embedded System <embed.sys@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Can't init device hci0 (all information included), help! Thanx a lot!!!
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 23 Jan 2005 18:10:50 +0800

hi, everyone

when I call "hciconfig hci0 up", it prints:
Can't init device hci0: Connection timed out (110)

Working environment is as follows:
1, Vmware workstation 5.0 + Redhat 9.0, with kernel 2.6.8.1, bluez 2.14
2, Bluetooth subsystem enabled
3, Billionton BlueTooth Dongle Class I USBBTC1A
4, "/etc/rc.d/init.d/bluetooth start" already run

Outputs (lspci, lsmod, /proc/bus/usb/devices/,hciconfig, dmesg)
1, output from lspci
	00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB

2, output from lsmod
	Module                  Size  Used by
	ehci_hcd               42688  0 
	hci_usb                13184  0 
	rfcomm                 38712  0 
	l2cap                  24128  3 rfcomm
	autofs                 15520  0 
	ohci1394               34912  0 
	ieee1394              110384  1 ohci1394
	parport_pc             25696  0 
	parport                40672  1 parport_pc
	bluetooth              48292  3 hci_usb,rfcomm,l2cap
	usbhid                 24800  0 
	uhci_hcd               33160  0 
	usbcore               127540  6 ehci_hcd,hci_usb,usbhid,uhci_hcd

3, output from /proc/bus/usb/devices

	T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
	B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
	D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
	P:  Vendor=0000 ProdID=0000 Rev= 2.06
	S:  Manufacturer=Linux 2.6.8.1 uhci_hcd
	S:  Product=Intel Corp. 82371AB/EB/MB PIIX4 USB
	S:  SerialNumber=0000:00:07.2
	C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
	I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
	E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
	
	T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
	D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
	P:  Vendor=0a12 ProdID=0001 Rev= 4.87
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

4, output from hciconfig
	hci0:	Type: USB
		BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
		DOWN 
		RX bytes:0 acl:0 sco:0 events:0 errors:0
		TX bytes:0 acl:0 sco:0 commands:0 errors:0
		Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
		Packet type: DM1 DH1 HV1 
		Link policy: 
		Link mode: SLAVE ACCEPT 

8, output from dmesg
	uhci_hcd 0000:00:07.2: suspend_hc
	uhci_hcd 0000:00:07.2: wakeup_hc
	uhci_hcd 0000:00:07.2: port 1 portsc 0083
	hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
	hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
	usb 1-1: new full speed USB device using address 3
	usb 1-1: skipped 1 descriptor after interface
	usb 1-1: new device strings: Mfr=0, Product=0, SerialNumber=0
	usb 1-1: hotplug
	usb 1-1: adding 1-1:1.0 (config #1, interface 0)
	usb 1-1:1.0: hotplug
	hci_usb 1-1:1.0: usb_probe_interface
	hci_usb 1-1:1.0: usb_probe_interface - got id
	usb 1-1: adding 1-1:1.1 (config #1, interface 1)
	usb 1-1:1.1: hotplug
	usb 1-1: adding 1-1:1.2 (config #1, interface 2)
	usb 1-1:1.2: hotplug
	hci_usb 1-1:1.2: usb_probe_interface
	hci_usb 1-1:1.2: usb_probe_interface - got id


I really appreciate your kindly help and your time! if you need any
further information
please let me know, thanx again!

Is it a kernel problem? Bluez bug? Configuration Problem? Vmware
Restrictions? or what else?

-andy


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

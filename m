Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: D-Link DBT-120 destroyed? (with bluefw)
From: Marcel Holtmann <marcel@holtmann.org>
To: Roger Larsson <roger.larsson@norran.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200406090101.19410.roger.larsson@norran.net>
References: <200405290103.26485.roger.larsson@norran.net>
	 <200406082235.59864.roger.larsson@norran.net>
	 <1086727565.5040.48.camel@pegasus>
	 <200406090101.19410.roger.larsson@norran.net>
Content-Type: text/plain
Message-Id: <1086736428.5040.56.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 09 Jun 2004 01:13:48 +0200

Hi Roger,

> > > > > > > The D-Link does not light up any more - can it be repaired?
> > > >
> > > > I don't know. What does dmesg say? What is in the log files?
> > >
> > > Nothing! lsusb does not find it anymore...
> >
> > Check dmesg, /var/log/syslog, /proc/bus/usb/devices etc.
> 
> I get nothing extra in dmesg when removing/inserting the DBT-120
> This is what I get when starting rchotplug...
> 
> Loglevel set to 9
> uhci.c: USB Universal Host Controller Interface driver v1.1
> usb-uhci.c: $Revision: 1.275 $ time 01:32:39 Apr 27 2004
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> 
> # lsmod
> rfcomm                 32064   0  (autoclean)
> l2cap                  17520   2  (autoclean) [rfcomm]
> bluez                  31524   2  [rfcomm l2cap hci_vhci]
> 
> # modprobe hci_usb
> gave a little in dmesg
> BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> usb.c: registered new driver hci_usb
> 
> # hciconfig
> hci0:   Type: VHCI
>         BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:4 acl:0 sco:0 commands:1 errors:0
> 
> In /var/log/messages
> Jun  9 00:52:55 jeloin kernel: uhci.c: USB Universal Host Controller Interface 
> driver v1.1
> Jun  9 00:52:55 jeloin kernel: usb-uhci.c: $Revision: 1.275 $ time 01:32:39 
> Apr 27 2004
> Jun  9 00:52:55 jeloin kernel: usb-uhci.c: High bandwidth mode enabled
> Jun  9 00:52:55 jeloin kernel: usb-uhci.c: v1.275:USB Universal Host 
> Controller Interface driver
> Jun  9 00:52:55 jeloin /etc/hotplug/usb.rc[16701]: loaded HCD: usb-ohci
> Jun  9 00:52:55 jeloin /etc/hotplug/usb.rc[16701]: loaded HCD: ehci-hcd
> Jun  9 00:55:42 jeloin kernel: BlueZ HCI USB driver ver 2.4 Copyright (C) 
> 2000,2001 Qualcomm Inc
> Jun  9 00:55:42 jeloin kernel: Written 2000,2001 by Maxim Krasnyansky 
> <maxk@qualcomm.com>
> Jun  9 00:55:42 jeloin kernel: usb.c: registered new driver hci_usb
> 
> # cat /proc/bus/usb/devices
> T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.04
> S:  Manufacturer=Linux 2.4.21-215-athlon ehci_hcd
> S:  Product=PCI device 1039:7002 (Silicon Integrated Systems [SiS])
> S:  SerialNumber=00:03.2
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
> P:  Vendor=04b8 ProdID=011b Rev= 1.00
> S:  Manufacturer=EPSON
> S:  Product=EPSON Scanner
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 0.00
> S:  Product=USB OHCI Root Hub
> S:  SerialNumber=e081b000
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 3
> B:  Alloc= 11/900 us ( 1%), #Int=  1, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 0.00
> S:  Product=USB OHCI Root Hub
> S:  SerialNumber=e0819000
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=03f0 ProdID=6004 Rev= 1.00
> S:  Manufacturer=hp
> S:  Product=deskjet 5550
> S:  SerialNumber=MY29G1K1SP2L
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  2mA
> I:  If#= 0 Alt= 0 #EPs= 2 Cls=07(print) Sub=01 Prot=02 Driver=(none)
> E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 4
> D:  Ver= 1.01 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=05e3 ProdID=0604 Rev= 0.12
> S:  Product=USB Hub
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
> T:  Bus=01 Lev=02 Prnt=03 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=056a ProdID=0042 Rev= 1.26
> S:  Manufacturer=Tablet
> S:  Product=XD-0608-U
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=140mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
> E:  Ad=81(I) Atr=03(Int.) MxPS=  10 Ivl=5ms
> 
> (It should be located on the hub together with the wacom tablet)

it seems that your dongle is really broken. Use the D-Link RMA support
to get you a new one. Non of use can help here.

Actually I don't know how bluefw can kill a CSR based dongle, but it
seems that this happens :(

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

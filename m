Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <6.1.2.0.2.20050124192058.04bee240@pop.gmx.net>
To: bluez-users@lists.sourceforge.net
From: George <george.news@gmx.net>
Subject: Re: [Bluez-users] Bluez BNEP connection close
In-Reply-To: <6.1.2.0.2.20050124182813.04216860@pop.gmx.net>
References: <6.1.2.0.2.20050124165802.04168330@luna.tlmat.unican.es>
 <1106581771.8058.49.camel@pegasus>
 <6.1.2.0.2.20050124172931.041a03a0@pop.gmx.net>
 <1106583831.8058.52.camel@pegasus>
 <6.1.2.0.2.20050124180402.041c1eb0@pop.gmx.net>
 <1106585260.8058.56.camel@pegasus>
 <6.1.2.0.2.20050124182813.04216860@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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
Date: Mon, 24 Jan 2005 19:24:39 +0100

OOpssss ... It wasn't the solution

I have remove the SCO totally removed and still facing the same problem. 
Thanks for your help and sorry for bothering all of you, but I have to show 
my application in a short while and I want it to be as stable as possible.


And my .config for the USB Devices

#
# Bluetooth support
#
CONFIG_BLUEZ=y
CONFIG_BLUEZ_L2CAP=y
# CONFIG_BLUEZ_SCO is not set
CONFIG_BLUEZ_RFCOMM=y
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=y
CONFIG_BLUEZ_BNEP_MC_FILTER=y
CONFIG_BLUEZ_BNEP_PROTO_FILTER=y
CONFIG_BLUEZ_HIDP=y

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=y
# CONFIG_BLUEZ_HCIUSB_SCO is not set
CONFIG_BLUEZ_HCIUART=y
CONFIG_BLUEZ_HCIUART_H4=y
CONFIG_BLUEZ_HCIUART_BCSP=y
CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=y
CONFIG_BLUEZ_HCIBFUSB=y
CONFIG_BLUEZ_HCIVHCI=y


Here it is my /proc/bus/usb/devices

[root@s root]# cat /proc/bus/usb/devices
T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=1860
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 23/900 us ( 3%), #Int=  1, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=1840
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 5.25
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI-alt Root Hub
S:  SerialNumber=1820
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.04
S:  Manufacturer=Linux 2.4.28-mh1 ehci_hcd
S:  Product=Intel Corp. 82801DB USB2
S:  SerialNumber=00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms


At 18:33 24/01/2005, George wrote:
 >At 17:47 24/01/2005, Marcel Holtmann wrote:
 >
 > >is the SCO support for the hci_usb driver compiled in? Maybe this takes
 > >away the USB bandwidth and this can result in troubles with a 2.4 kernel
 > >and its USB subsystem. With a 2.6 kernel you can disable this with the
 > >module parameter isoc, but I doubt that this is possible with a 2.4
 > >kernel.
 >
 >Great... I have the SCO support compiled. So you recommend that I remove 
it???
 >
 >I will do so and hope it works ;)
 >
 >Let you know in a while ;)
 >
 >REgards.
 >
 > >
 > >Regards
 > >
 > >Marcel
 > >
 > >
 > >
 > >
 > >-------------------------------------------------------
 > >This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
 > >Tool for open source databases. Create drag-&-drop reports. Save time
 > >by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
 > >Download a FREE copy at http://www.intelliview.com/go/osdn_nl
 > >_______________________________________________
 > >Bluez-users mailing list
 > >Bluez-users@lists.sourceforge.net
 > >https://lists.sourceforge.net/lists/listinfo/bluez-users
 >
 >
 >
 >-------------------------------------------------------
 >This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
 >Tool for open source databases. Create drag-&-drop reports. Save time
 >by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
 >Download a FREE copy at http://www.intelliview.com/go/osdn_nl
 >_______________________________________________
 >Bluez-users mailing list
 >Bluez-users@lists.sourceforge.net
 >https://lists.sourceforge.net/lists/listinfo/bluez-users
 >
 > 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <231dafb50612160114y6ee8b889ibbe71cd96dbd79b9@mail.gmail.com>
Date: Sat, 16 Dec 2006 02:14:08 -0700
From: "Dark Shadow" <shadowofdarkness@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1166262274.6557.1.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <231dafb50612152211h1bc9ca42lade6687ac51c0@mail.gmail.com>
	<adf2d65c0612152357m5886f77coff5a7d227dd7d4e6@mail.gmail.com>
	<1166262274.6557.1.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Trouble loading firmware with bcm203x
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

On 12/16/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
> > > I just bought a Bluetooth dongle that uses the Broadcom 4503 chipset
> > > and I am having trouble getting stable use out of it. I have got it to
> > > work twice before with the following steps
> > >
> > > plug it in
> > > modprobe bcm203x
> > > hciconfig up
> > > hciconfig reset (hours of googling to find out this is required)
> >
> > For my Broadcom BCM2045B2 chipset dongle loading the hci_usb module
> > with "reset=1" worked wonderfully.
>
> if you post the content of /proc/bus/usb/devices, I can make the reset
> option permanent for this dongle and you don't have to worry about it
> anymore.
>
> Regards
>
> Marcel
>
>
Here is the output. Note that the firmware is not loaded. When it does
load it adds a fourth entry in lsusb with 0a5c:2120 (Note the device
may be wrong since it is from memory) this one is the one that gets
ran by the hci_usb before the firmware is loaded the dongle +
mouse(included in package) work like any wireless usb mouse.
I also in my first message mixed up the chipset info it is a 2045 I
accidently wrote the device id
If I ever get the firmware loaded again I will get the devices output from then.

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 8
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-ck1shadow ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:13.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 4
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-ck1shadow ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:13.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 4
B:  Alloc=  3/900 us ( 0%), #Int=  3, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-ck1shadow ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:13.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 32 Spd=12  MxCh= 3
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4500 Rev= 1.00
S:  Manufacturer=Broadcom
S:  Product=BCM2045B2
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=32 Port=01 Cnt=01 Dev#= 33 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4502 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=BCM2045B3 ROM
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=32 Port=02 Cnt=02 Dev#= 34 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4503 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=BCM2045B3 ROM
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

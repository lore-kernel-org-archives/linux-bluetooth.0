Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <5926256.1078727778744.JavaMail.ngmail@webmail04.arcor-online.net>
From: damou@nexgo.de
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Toshiba Portege M200 internal bluetooth adapter
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
Date: Mon, 8 Mar 2004 07:36:18 +0100 (CET)


> Message: 1
> Date: Sun, 07 Mar 2004 00:00:49 -0700
> From: Brad Midgley <bmidgley@xmission.com>
> To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
> Subject: Re: [Bluez-users] Toshiba Portege M200 internal bluetooth adapter
> 
> Marcel
> 
> dmabt doesn't compile for me unless I make this change (but I'm not 
> totally sure it's the right change):
> 
> --- dmabt-0.2/dmabt.c   Sat Jun  8 10:17:18 2002
> +++ ../dmabt-0.2/dmabt.c        Sat Mar  6 23:46:29 2004
> @@ -37,7 +37,7 @@
>   #include <sys/ioctl.h>              // for ioctl
> 
>   #define TOSH_DEVICE "/dev/toshiba"
> -#define TOSH_SMM _IOWR('t',0x90,24)
> +#define TOSH_SMM _IOWR('t',0x90,SMMRegisters)
> 
>   #define SLEEP 1 // duration of break between activating and attching
>   #define TITLE "DMABTenable Version 0.2\n"
> 
> but even then it doesn't like the result:
> 
> jabbed:/usr/src/dmabt-0.2# ./dmabt
> Can't access Toshiba device /dev/toshiba.
> bmidgley@jabbed:~$ ls -l /dev/toshiba
> crw-rw-rw-    1 root     root      10, 181 2004-03-06 17:07 /dev/toshiba
> 
> jabbed:/usr/src/dmabt-0.2# lsmod|grep tosh
> toshiba_acpi            6108  0
> toshiba                 4672  0
> 
> toshset has an option to turn on bluetooth but it doesn't do anything.
> 
> jabbed:/home/bmidgley# toshset -bluetooth on
> 
> jabbed:/home/bmidgley# more /proc/bus/usb/devices
> 
> T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.3-mh4 uhci_hcd
> S:  Product=UHCI Host Controller
> S:  SerialNumber=0000:00:1d.2
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.3-mh4 uhci_hcd
> S:  Product=UHCI Host Controller
> S:  SerialNumber=0000:00:1d.1
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.3-mh4 uhci_hcd
> S:  Product=UHCI Host Controller
> S:  SerialNumber=0000:00:1d.0
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.3-mh4 ehci_hcd
> S:  Product=EHCI Host Controller
> S:  SerialNumber=0000:00:1d.7
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
> 
> Does any of this require an APM bios? the M200 can't load the apm kernel 
> mod because it has no APM bios.
> 
> Brad
> 
> >>I'm not totally sure how to use the internal bluetooth on my toshiba
> >>portege m200. I saw reports of "hci_usb + toshiba" for similar models
> >>but I have no idea what that means. usbfs doesn't show anything that
> >>looks like bluetooth but lspci -v reports one device I'm not sure about.
> >>Maybe that's it...
> >>
> >>02:0d.0 System peripheral: Toshiba America Info Systems: Unknown device
> >>0805 (rev 05)
> >>	Subsystem: Toshiba America Info Systems: Unknown device 0001
> >>	Flags: medium devsel, IRQ 11
> >>	Memory at 20000c00 (32-bit, non-prefetchable) [disabled] [size=512]
> >>	Capabilities: [80] Power Management version 2
> >>
> >>Does anyone know if there's a chance it's supported?
> > 
> > 
> > I am sure that your device is supported and I am sure that it is an USB
> > Bluetooth adapter, but you have to activate it first. Take a look at
> > this page
> > 
> > 	http://www.holtmann.org/linux/bluetooth/toshiba.html
> > 
> > and search through the mailing list archives.
> > 
> > Regards
> > 
> > Marcel
> > 
> > 
Hi,

I just checked the Portege M200 with a BT patched Knoppix 3.2(Kernel 2.4.20) and dmabt is working.
You should compile dmabt without any changes in the sourcecode! 
Make sure that you have installed Toshiba Tools before you compile dmabt. 
AFAIK dmabt doesn't work with an ACPI enabled Kernel.

I did the following to activate BT
> dmabt
> hciconfig hci0 up
> hciconfig -a    //to get some informations on stdout

Result:
hci0:	Type: USB 
	BD Address: 00:03:7A:09:AD:06 ACL MTU: 192:8  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:376 acl:0 sco:0 events:16 errors:0
	TX bytes:305 acl:0 sco:0 commands:15 errors:0
	Features: 0xff 0xff 0x0f 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'BlueZ (0)'
	Class: 0x000100
	Service Classes: Unspecified
	Device Class: Computer, Uncategorized
	HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
	Manufacturer: Cambridge Silicon Radio (10)

cu
Martl







-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

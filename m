Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Philipp Sandhaus <philipp.sandhaus@gmx.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] driver support for sitecom cn-510 bluetooth usb Adapter
References: <200511281541.06119.philipp.sandhaus@gmx.de> <1133210331.31513.62.camel@blade>
In-Reply-To: <1133210331.31513.62.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511291306.57234.philipp.sandhaus@gmx.de>
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
Date: Tue, 29 Nov 2005 13:06:57 +0100

Am Montag, 28. November 2005 21:38 schrieb Marcel Holtmann:
> Hi Philipp,
>
> > I've trouble getting an usb bluetooth adapter getting to work. When I
> > plug the devvice into my computer it somehow get's recognized, because
> > the modul hci_usb automatically get's loaded. However, I see nothing
> > about that in the kernel log and "hcitool dev" doesn't list any devices.
> > Any ideas, how I could get this thing to work? I've, that the sitecom
> > cn-500 adapter is supported, but I didn't find anything about the cn-510
> > on the internet.
>
> check with "hciconfig -a" and look at /proc/bus/usb/devices.
hciconfig -a says: 
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
        DOWN 
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0

and cat /proc/bus/usb/devices:

.....
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=200a Rev= 0.01
S:  Manufacturer=Broadcom
S:  Product=Bluetooth USB Dongle
S:  SerialNumber=2035B0000001
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
...

but hciconfig dev says:

Devices:



-- 
Philipp Sandhaus
Stedinger Str. 92
26135 Oldenburg
Tel.: 0441-2330107
Mobil: 0179-7912909


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: <darrylkuhn@cox.net>
To: <bluez-users@lists.sourceforge.net>
Subject: Re: Re: [Bluez-users] Bluetooth on d610
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20060124194237.GRIJ25099.fed1rmmtao09.cox.net@[172.18.180.8]>
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
Date: Tue, 24 Jan 2006 14:42:30 -0500

Marcel,

`lsmod | egrep 'hci|usb'` gives me:
usbhid                 31040  0
ohci1394               33668  0
ieee1394              106296  1 ohci1394
usb_storage            64448  0
ehci_hcd               32260  0
uhci_hcd               32272  0
usbcore               115064  5 usbhid,usb_storage,ehci_hcd,uhci_hcd

So it looks like I'm missing hci_usb (or at least it's not loaded)

I do see /usr/src/kernel-source-2.6.10/include/config/bt/hciusb.h, but I'm unsure where to proceed from there.

As for my distribution I'm using Linspire 5.0.347 which is a debian based dist.

Thanks again!
-Darryl

> 
> From: Marcel Holtmann <marcel@holtmann.org>
> Date: 2006/01/24 Tue PM 02:10:42 EST
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Bluetooth on d610
> 
> Hi Darryl,
> 
> > Thanks kindly for the quick response!
> > 
> > Here's the relevant portion of /proc/bus/usb/devices:
> > ...
> > T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
> > D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=413c ProdID=8103 Rev=16.57
> > C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
> > I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> > ...
> > 
> > Looks like the driver isn't attached. How might I attach the driver to this device?
> 
> first you should check with "lsmod" if it is loaded. Then check its
> version with "modinfo hci_usb". What distribution are you using?
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

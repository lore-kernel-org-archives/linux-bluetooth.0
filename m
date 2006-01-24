Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth on d610
References: <20060124194237.GRIJ25099.fed1rmmtao09.cox.net@[172.18.180.8]>
In-Reply-To: <20060124194237.GRIJ25099.fed1rmmtao09.cox.net@[172.18.180.8]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601242046.42577.cijoml@volny.cz>
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
Date: Tue, 24 Jan 2006 20:46:42 +0100

Hi,

try apt-get install hotplug

Michal

Dne =FAt 24. ledna 2006 20:42 darrylkuhn@cox.net napsal(a):
> Marcel,
>
> `lsmod | egrep 'hci|usb'` gives me:
> usbhid                 31040  0
> ohci1394               33668  0
> ieee1394              106296  1 ohci1394
> usb_storage            64448  0
> ehci_hcd               32260  0
> uhci_hcd               32272  0
> usbcore               115064  5 usbhid,usb_storage,ehci_hcd,uhci_hcd
>
> So it looks like I'm missing hci_usb (or at least it's not loaded)
>
> I do see /usr/src/kernel-source-2.6.10/include/config/bt/hciusb.h, but I'm
> unsure where to proceed from there.
>
> As for my distribution I'm using Linspire 5.0.347 which is a debian based
> dist.
>
> Thanks again!
> -Darryl
>
> > From: Marcel Holtmann <marcel@holtmann.org>
> > Date: 2006/01/24 Tue PM 02:10:42 EST
> > To: bluez-users@lists.sourceforge.net
> > Subject: Re: [Bluez-users] Bluetooth on d610
> >
> > Hi Darryl,
> >
> > > Thanks kindly for the quick response!
> > >
> > > Here's the relevant portion of /proc/bus/usb/devices:
> > > ...
> > > T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  7 Spd=3D1=
2  MxCh=3D 0
> > > D:  Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D=
  1
> > > P:  Vendor=3D413c ProdID=3D8103 Rev=3D16.57
> > > C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D  0mA
> > > I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
> > > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> > > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > > E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> > > I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> > > I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
> > > E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> > > I:  If#=3D 2 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Dr=
iver=3D(none)
> > > ...
> > >
> > > Looks like the driver isn't attached. How might I attach the driver to
> > > this device?
> >
> > first you should check with "lsmod" if it is loaded. Then check its
> > version with "modinfo hci_usb". What distribution are you using?
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> > files for problems?  Stop!  Download the new AJAX search engine that
> > makes searching your log files as easy as surfing the  web.  DOWNLOAD
> > SPLUNK!
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

=2D-=20
S pozdravem

Michal Semler


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

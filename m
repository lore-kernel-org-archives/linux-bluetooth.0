Return-Path: <cyrus@holtmann.org>
Message-ID: <COL102-W408BFF23C6594401E02286A8FC0@phx.gbl>
From: Evgenios Metaxas <eumetaxas@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Sun, 7 Dec 2008 18:41:46 +0000
In-Reply-To: <1228670319.28839.64.camel@violet.holtmann.net>
References: <COL102-W12443FB0254944C58D2F2FA8020@phx.gbl>
	<e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
	<BAY127-W1206CF6F607105AA558C2DA8FE0@phx.gbl>
	<89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
	<COL102-W7079DBA98D2EA5B8835568A8FF0@phx.gbl>
	<e343e5940812061301w368d0614s85e4f82938e76c3a@mail.gmail.com>
	<1228598050.28839.47.camel@violet.holtmann.net>
	<BAY124-W46E88B992073AAD609A3BDA8FC0@phx.gbl>
	<1228670319.28839.64.camel@violet.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] MA-720 does not work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3912350858312957982=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============3912350858312957982==
Content-Type: multipart/alternative;
	boundary="_995ab143-b666-49f0-b87a-269cf4b350cd_"

--_995ab143-b666-49f0-b87a-269cf4b350cd_
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable


Thanx for the quick answer.
It is a bluetooth dongle. Using the provided drivers under XP=2C works as a=
 bluetooth dongle and managed  to sync my Pocket pc with Outlook=2C transfe=
r files etc  on an old Compaq 1200. When i got it (~3 years ago) it was adv=
ertised as a new kind of bluetooth dongle=2C and to support sound over blue=
tooth (Until now if you Google for ma-720  you'll find the adds). I bought =
it to use my bluetooth headset with skype/voipbuster (never did thow cause =
i'm on Ubuntu ever since:)). Maybe the sound thing causes the problem and m=
aking it an anusual dongle .

Thank you again for your time and help!

Regards

Eugenios


> From: marcel@holtmann.org
> To: bluez-devel@lists.sourceforge.net
> Date: Sun=2C 7 Dec 2008 18:18:39 +0100
> Subject: Re: [Bluez-devel] MA-720 does not work
>=20
> Hi Evgenios=2C
>=20
> > and after mounting /proc/bus/usb/devices using  "sudo mount -t usbfs
> > usbfs /proc/bus/usb"
> >=20
> > T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D1.5=
 MxCh=3D 0
> > D:  Ver=3D 1.00 Cls=3Dff(vend.) Sub=3Dff Prot=3D00 MxPS=3D 8 #Cfgs=3D  =
1
> > P:  Vendor=3D0df7 ProdID=3D0722 Rev=3D 0.00
> > S:  Manufacturer=3DMobileAction Technology Inc.
> > S:  Product=3DBluetooth Dongle
> > C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D100mA
> > I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driv=
er=3D(none)
> > E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
> > E:  Ad=3D02(O) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
>=20
> this is not a Bluetooth dongle. At least not an usual one. It should
> look like this:
>=20
> T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  7 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D53.60
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
>=20
> That is the bare minimum that btusb/hci_usb need as endpoints to
> actually work properly.
>=20
> If this is really a Bluetooth dongle=2C then it needs a custom driver to
> make it work.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> SF.Net email is Sponsored by MIX09=2C March 18-20=2C 2009 in Las Vegas=2C=
 Nevada.
> The future of the web can't happen without you.  Join us at MIX09 to help
> pave the way to the Next Web now. Learn more and register at
> http://ad.doubleclick.net/clk=3B208669438=3B13503038=3Bi?http://2009.visi=
tmix.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3Den-US&form=3DQBR=
E=

--_995ab143-b666-49f0-b87a-269cf4b350cd_
Content-Type: text/html; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Thanx for the quick answer.<br>It is a bluetooth dongle. Using the provided=
 drivers under XP=2C works as a bluetooth dongle and managed&nbsp=3B to syn=
c my Pocket pc with Outlook=2C transfer files etc&nbsp=3B on an old Compaq =
1200. When i got it (~3 years ago) it was advertised as a new kind of bluet=
ooth dongle=2C and to support sound over bluetooth (Until now if you Google=
 for ma-720&nbsp=3B you'll find the adds). I bought it to use my bluetooth =
headset with skype/voipbuster (never did thow cause i'm on Ubuntu ever sinc=
e:)). Maybe the sound thing causes the problem and making it an anusual don=
gle .<br><br>Thank you again for your time and help!<br><br>Regards<br><br>=
Eugenios<br><br><br>&gt=3B From: marcel@holtmann.org<br>&gt=3B To: bluez-de=
vel@lists.sourceforge.net<br>&gt=3B Date: Sun=2C 7 Dec 2008 18:18:39 +0100<=
br>&gt=3B Subject: Re: [Bluez-devel] MA-720 does not work<br>&gt=3B <br>&gt=
=3B Hi Evgenios=2C<br>&gt=3B <br>&gt=3B &gt=3B and after mounting /proc/bus=
/usb/devices using  "sudo mount -t usbfs<br>&gt=3B &gt=3B usbfs /proc/bus/u=
sb"<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=
=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D1.5 MxCh=3D 0<br>&gt=3B &gt=3B D:  Ver=3D 1=
.00 Cls=3Dff(vend.) Sub=3Dff Prot=3D00 MxPS=3D 8 #Cfgs=3D  1<br>&gt=3B &gt=
=3B P:  Vendor=3D0df7 ProdID=3D0722 Rev=3D 0.00<br>&gt=3B &gt=3B S:  Manufa=
cturer=3DMobileAction Technology Inc.<br>&gt=3B &gt=3B S:  Product=3DBlueto=
oth Dongle<br>&gt=3B &gt=3B C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D100mA<=
br>&gt=3B &gt=3B I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff P=
rot=3Dff Driver=3D(none)<br>&gt=3B &gt=3B E:  Ad=3D81(I) Atr=3D03(Int.) MxP=
S=3D   8 Ivl=3D10ms<br>&gt=3B &gt=3B E:  Ad=3D02(O) Atr=3D03(Int.) MxPS=3D =
  8 Ivl=3D10ms<br>&gt=3B <br>&gt=3B this is not a Bluetooth dongle. At leas=
t not an usual one. It should<br>&gt=3B look like this:<br>&gt=3B <br>&gt=
=3B T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  7 Spd=3D12 =
 MxCh=3D 0<br>&gt=3B D:  Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxP=
S=3D64 #Cfgs=3D  1<br>&gt=3B P:  Vendor=3D0a12 ProdID=3D0001 Rev=3D53.60<br=
>&gt=3B C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA<br>&gt=3B I:* If#=3D=
 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dbtusb<br>=
&gt=3B E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms<br>&gt=3B E:  Ad=
=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms<br>&gt=3B E:  Ad=3D82(I) Atr=
=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms<br>&gt=3B <br>&gt=3B That is the bare min=
imum that btusb/hci_usb need as endpoints to<br>&gt=3B actually work proper=
ly.<br>&gt=3B <br>&gt=3B If this is really a Bluetooth dongle=2C then it ne=
eds a custom driver to<br>&gt=3B make it work.<br>&gt=3B <br>&gt=3B Regards=
<br>&gt=3B <br>&gt=3B Marcel<br>&gt=3B <br>&gt=3B <br>&gt=3B <br>&gt=3B ---=
---------------------------------------------------------------------------=
<br>&gt=3B SF.Net email is Sponsored by MIX09=2C March 18-20=2C 2009 in Las=
 Vegas=2C Nevada.<br>&gt=3B The future of the web can't happen without you.=
  Join us at MIX09 to help<br>&gt=3B pave the way to the Next Web now. Lear=
n more and register at<br>&gt=3B http://ad.doubleclick.net/clk=3B208669438=
=3B13503038=3Bi?http://2009.visitmix.com/<br>&gt=3B _______________________=
________________________<br>&gt=3B Bluez-devel mailing list<br>&gt=3B Bluez=
-devel@lists.sourceforge.net<br>&gt=3B https://lists.sourceforge.net/lists/=
listinfo/bluez-devel<br><br /><hr />Discover the new Windows Vista <a href=
=3D'http://search.msn.com/results.aspx?q=3Dwindows+vista&mkt=3Den-US&form=
=3DQBRE' target=3D'_new'>Learn more!</a></body>
</html>=

--_995ab143-b666-49f0-b87a-269cf4b350cd_--


--===============3912350858312957982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
--===============3912350858312957982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============3912350858312957982==--

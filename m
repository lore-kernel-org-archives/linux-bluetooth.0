Return-Path: <cyrus@holtmann.org>
Message-Id: <1fff674d79c13fd42799538a328119a8490dc2cb@altmail.blacknight.com>
From: "Ken O'Brien" <kernel@kenobrien.org>
To: "Ken O'Brien" <kernel@kenobrien.org>,
 "Gustavo Padovan" <gustavo@padovan.org>
Cc: marcel@holtmann.org,
 johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
in-reply-to: <1379628457.2494.1.camel@mjolnir.site>
Subject: Re: [PATCH] bluetooth: btusb: Added support for Belkin F8065bf usb bluetooth device
Date: Thu, 19 Sep 2013 23:44:47 +0100
Content-Type: multipart/alternative;
 boundary="=_9fa23efb327882a0d2994209bc0aedda"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

--=_9fa23efb327882a0d2994209bc0aedda
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=C2=A0Apologies. This was supposed to be in the commit log. I'll resubmi=
t=0Athe patch and I notice it's another instance of an existing bcm=0Ade=
vice. I'll update the patch accordingly.=C2=A0=0AKen=0A=0A----- Original=
 Message -----=0AFrom: "Ken O'Brien" =0ATo:"Gustavo Padovan" =0ACc:, , ,=
 =0ASent:Thu, 19 Sep 2013 23:07:37 +0100=0ASubject:Re: [PATCH] bluetooth=
: btusb: Added support for Belkin F8065bf=0Ausb bluetooth device=0A=0A H=
ere is the output:=0A=0A T: Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D=
01 Dev#=3D 2 Spd=3D12 MxCh=3D 0=0A D: Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D=
01 Prot=3D01 MxPS=3D64 #Cfgs=3D 1=0A P: Vendor=3D050d ProdID=3D065a Rev=
=3D 1.12=0A S: Manufacturer=3DBroadcom Corp=0A S: Product=3DBCM20702A0=
=0A S: SerialNumber=3D0002723E2D29=0A C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3Da0 M=
xPwr=3D100mA=0A I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01=
 Prot=3D01 Driver=3Dbtusb=0A E: Ad=3D81(I) Atr=3D03(Int.) MxPS=3D 16 Ivl=
=3D1ms=0A E: Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms=0A E: Ad=3D0=
2(O) Atr=3D02(Bulk) MxPS=3D 64 Ivl=3D0ms=0A I:* If#=3D 1 Alt=3D 0 #EPs=
=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb=0A E: Ad=3D83(I)=
 Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms=0A E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=
=3D 0 Ivl=3D1ms=0A I: If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D=
01 Prot=3D01 Driver=3Dbtusb=0A E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 9 Iv=
l=3D1ms=0A E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms=0A I: If#=3D=
 1 Alt=3D 2 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb=
=0A E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms=0A E: Ad=3D03(O) A=
tr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms=0A I: If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=
=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb=0A E: Ad=3D83(I) Atr=3D01=
(Isoc) MxPS=3D 25 Ivl=3D1ms=0A E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 25 I=
vl=3D1ms=0A I: If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=
=3D01 Driver=3Dbtusb=0A E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1m=
s=0A E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms=0A I: If#=3D 1 Al=
t=3D 5 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb=0A E:=
 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms=0A E: Ad=3D03(O) Atr=3D0=
1(Isoc) MxPS=3D 49 Ivl=3D1ms=0A I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff=
(vend.) Sub=3Dff Prot=3Dff Driver=3D(none)=0A E: Ad=3D84(I) Atr=3D02(Bul=
k) MxPS=3D 32 Ivl=3D0ms=0A E: Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 32 Ivl=
=3D0ms=0A I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=
=3D01 Driver=3D(none)=0A=0A On Thu, 2013-09-19 at 14:24 -0500, Gustavo P=
adovan wrote:=0A > Hi Ken,=0A > =0A > 2013-09-19 Ken O'Brien :=0A > =0A=
 > > Belkin bluetooth device's usb device id added to generic usb=0Ablue=
tooth driver.=0A > > =0A > > Signed-off-by: Ken O'Brien =0A > > ---=0A >=
 > drivers/bluetooth/btusb.c | 3 +++=0A > > 1 file changed, 3 insertions=
(+)=0A > > =0A > > diff --git a/drivers/bluetooth/btusb.c=0Ab/drivers/bl=
uetooth/btusb.c=0A > > index 8e16f0a..117b90c 100644=0A > > --- a/driver=
s/bluetooth/btusb.c=0A > > +++ b/drivers/bluetooth/btusb.c=0A > > @@ -11=
1,6 +111,9 @@ static struct usb_device_id btusb_table[] =3D {=0A > > =0A=
 > > /*Broadcom devices with vendor specific id */=0A > > { USB_VENDOR_A=
ND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },=0A > > +=0A > > + /* Belk=
in F8T065bf */=0A > > + { USB_DEVICE(0x050d, 0x065a) },=0A > =0A > Could=
 you please add the output of /sys/kernel/debug/usb/devices=0Afor this=
=0A > bluetooth controller to the commit messages, like we do for any ne=
w=0Adevice id=0A > we add to btusb. Thanks.=0A > =0A > Gustavo=0A > --=
=0A > To unsubscribe from this list: send the line "unsubscribe=0Alinux-=
kernel" in=0A > the body of a message to majordomo@vger.kernel.org=0A >=
 More majordomo info at http://vger.kernel.org/majordomo-info.html=0A >=
 Please read the FAQ at http://www.tux.org/lkml/=0A=0A --=0A To unsubscr=
ibe from this list: send the line "unsubscribe=0Alinux-kernel" in=0A the=
 body of a message to majordomo@vger.kernel.org=0A More majordomo info a=
t http://vger.kernel.org/majordomo-info.html=0A Please read the FAQ at h=
ttp://www.tux.org/lkml/=0A

--=_9fa23efb327882a0d2994209bc0aedda
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body>=C2=A0Apologies. This was supposed to be in the commit log.=
 I'll resubmit the patch and I notice it's another instance of an existi=
ng bcm device. I'll update the patch accordingly.=C2=A0<div><br /></div>=
<div>Ken<br /><blockquote><br />----- Original Message -----<br /><div s=
tyle=3D"width:100%;background:rgb(228,228,228);"><div style=3D"font-weig=
ht:bold;">From:</div> "Ken O'Brien" &lt;kernel@kenobrien.org&gt;</div><b=
r /><div style=3D"font-weight:bold;">To:</div>"Gustavo Padovan" &lt;gust=
avo@padovan.org&gt;<br /><div style=3D"font-weight:bold;">Cc:</div>&lt;m=
arcel@holtmann.org&gt;, &lt;johan.hedberg@gmail.com&gt;, &lt;linux-bluet=
ooth@vger.kernel.org&gt;, &lt;linux-kernel@vger.kernel.org&gt;<br /><div=
 style=3D"font-weight:bold;">Sent:</div>Thu, 19 Sep 2013 23:07:37 +0100<=
br /><div style=3D"font-weight:bold;">Subject:</div>Re: [PATCH] bluetoot=
h: btusb: Added support for Belkin F8065bf usb bluetooth device<br /><br=
 /><br />=0AHere is the output:<br /><br />=0AT:  Bus=3D03 Lev=3D01 Prnt=
=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12   MxCh=3D 0<br />=0AD:  Ver=
=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1<br />=
=0AP:  Vendor=3D050d ProdID=3D065a Rev=3D 1.12<br />=0AS:  Manufacturer=
=3DBroadcom Corp<br />=0AS:  Product=3DBCM20702A0<br />=0AS:  SerialNumb=
er=3D0002723E2D29<br />=0AC:* #Ifs=3D 4 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA=
<br />=0AI:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=
=3D01 Driver=3Dbtusb<br />=0AE:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 I=
vl=3D1ms<br />=0AE:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms<br=
 />=0AE:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms<br />=0AI:* If=
#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbt=
usb<br />=0AE:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms<br />=0A=
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms<br />=0AI:  If#=3D 1=
 Alt=3D 1 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb<br=
 />=0AE:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms<br />=0AE:  Ad=
=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms<br />=0AI:  If#=3D 1 Alt=
=3D 2 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb<br />=
=0AE:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms<br />=0AE:  Ad=3D=
03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms<br />=0AI:  If#=3D 1 Alt=3D 3=
 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb<br />=0AE:=
  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms<br />=0AE:  Ad=3D03(O)=
 Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms<br />=0AI:  If#=3D 1 Alt=3D 4 #EPs=
=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb<br />=0AE:  Ad=
=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms<br />=0AE:  Ad=3D03(O) Atr=
=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms<br />=0AI:  If#=3D 1 Alt=3D 5 #EPs=3D=
 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Driver=3Dbtusb<br />=0AE:  Ad=3D83=
(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms<br />=0AE:  Ad=3D03(O) Atr=3D01=
(Isoc) MxPS=3D  49 Ivl=3D1ms<br />=0AI:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=
=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=3D(none)<br />=0AE:  Ad=3D84(I) A=
tr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms<br />=0AE:  Ad=3D04(O) Atr=3D02(Bulk=
) MxPS=3D  32 Ivl=3D0ms<br />=0AI:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe=
(app. ) Sub=3D01 Prot=3D01 Driver=3D(none)<br /><br /><br />=0AOn Thu, 2=
013-09-19 at 14:24 -0500, Gustavo Padovan wrote:<br />=0A&gt; Hi Ken,<br=
 />=0A&gt; <br />=0A&gt; 2013-09-19 Ken O'Brien &lt;kernel@kenobrien.org=
&gt;:<br />=0A&gt; <br />=0A&gt; &gt; Belkin bluetooth device's usb devi=
ce id added to generic usb bluetooth driver.<br />=0A&gt; &gt; <br />=0A=
&gt; &gt; Signed-off-by: Ken O'Brien &lt;kernel@kenobrien.org&gt;<br />=
=0A&gt; &gt; ---<br />=0A&gt; &gt;  drivers/bluetooth/btusb.c | 3 +++<br=
 />=0A&gt; &gt;  1 file changed, 3 insertions(+)<br />=0A&gt; &gt; <br /=
>=0A&gt; &gt; diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth=
/btusb.c<br />=0A&gt; &gt; index 8e16f0a..117b90c 100644<br />=0A&gt; &g=
t; --- a/drivers/bluetooth/btusb.c<br />=0A&gt; &gt; +++ b/drivers/bluet=
ooth/btusb.c<br />=0A&gt; &gt; @@ -111,6 +111,9 @@ static struct usb_dev=
ice_id btusb_table[] =3D {<br />=0A&gt; &gt;  <br />=0A&gt; &gt;  =09/*B=
roadcom devices with vendor specific id */<br />=0A&gt; &gt;  =09{ USB_V=
ENDOR_AND_INTERFACE_INFO(0x0a5c, 0xff, 0x01, 0x01) },<br />=0A&gt; &gt;=
 +<br />=0A&gt; &gt; +=09/* Belkin F8T065bf */<br />=0A&gt; &gt; +=09{ U=
SB_DEVICE(0x050d, 0x065a) },<br />=0A&gt; <br />=0A&gt; Could you please=
 add the output of /sys/kernel/debug/usb/devices for this<br />=0A&gt; b=
luetooth controller to the commit messages, like we do for any new devic=
e id<br />=0A&gt; we add to btusb. Thanks.<br />=0A&gt; <br />=0A&gt;=
 =09Gustavo<br />=0A&gt; --<br />=0A&gt; To unsubscribe from this list:=
 send the line "unsubscribe linux-kernel" in<br />=0A&gt; the body of a=
 message to majordomo@vger.kernel.org<br />=0A&gt; More majordomo info a=
t  http://vger.kernel.org/majordomo-info.html<br />=0A&gt; Please read t=
he FAQ at  http://www.tux.org/lkml/<br /><br /><br />=0A--<br />=0ATo un=
subscribe from this list: send the line "unsubscribe linux-kernel" in<br=
 />=0Athe body of a message to majordomo@vger.kernel.org<br />=0AMore ma=
jordomo info at  http://vger.kernel.org/majordomo-info.html<br />=0APlea=
se read the FAQ at  http://www.tux.org/lkml/<br /></blockquote></div></b=
ody></html>

--=_9fa23efb327882a0d2994209bc0aedda--

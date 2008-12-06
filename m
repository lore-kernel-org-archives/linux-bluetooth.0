Return-Path: <cyrus@holtmann.org>
Message-ID: <COL102-W7079DBA98D2EA5B8835568A8FF0@phx.gbl>
From: Evgenios Metaxas <eumetaxas@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Sat, 6 Dec 2008 18:55:09 +0000
In-Reply-To: <89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
References: <COL102-W12443FB0254944C58D2F2FA8020@phx.gbl>
	<e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
	<BAY127-W1206CF6F607105AA558C2DA8FE0@phx.gbl>
	<89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2717441880434290826=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2717441880434290826==
Content-Type: multipart/alternative;
	boundary="_3679ae7f-c24c-4c91-bf87-d459012d7ef6_"

--_3679ae7f-c24c-4c91-bf87-d459012d7ef6_
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable


Hi=2C

i did at first pass all 3 in a single line and did not work=2C
then i've read somewhere at modprobe uses only one "module" at a time and t=
ried one by one=2C which did not work either.

thanx for answering

Eugene

> Date: Fri=2C 5 Dec 2008 18:20:22 +0100
> From: patrys@pld-linux.org
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] MA-720 does not work
>=20
> On Fri=2C Dec 5=2C 2008 at 6:10 PM=2C Evgenios Metaxas <eumetaxas@hotmail=
.com> wrote:
> > Thank you for your answer=2C
> >
> > modprobe hci_usb gives no error=2C but
> >
> > modprobe  vendor=3D0df7 or modprobe product=3D0722
> > gives
> >
> > FATAL: Module vendor=3D0df7 not found
>=20
> You are supposed to pass all 3 in a single line. product and vendor
> are options for the hci_usb module.
>=20
> --=20
> Patryk Zawadzki
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
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us=

--_3679ae7f-c24c-4c91-bf87-d459012d7ef6_
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
Hi=2C<br><br>i did at first pass all 3 in a single line and did not work=2C=
<br>then i've read somewhere at modprobe uses only one "module" at a time a=
nd tried one by one=2C which did not work either.<br><br>thanx for answerin=
g<br><br>Eugene<br><br>&gt=3B Date: Fri=2C 5 Dec 2008 18:20:22 +0100<br>&gt=
=3B From: patrys@pld-linux.org<br>&gt=3B To: bluez-devel@lists.sourceforge.=
net<br>&gt=3B Subject: Re: [Bluez-devel] MA-720 does not work<br>&gt=3B <br=
>&gt=3B On Fri=2C Dec 5=2C 2008 at 6:10 PM=2C Evgenios Metaxas &lt=3Beumeta=
xas@hotmail.com&gt=3B wrote:<br>&gt=3B &gt=3B Thank you for your answer=2C<=
br>&gt=3B &gt=3B<br>&gt=3B &gt=3B modprobe hci_usb gives no error=2C but<br=
>&gt=3B &gt=3B<br>&gt=3B &gt=3B modprobe  vendor=3D0df7 or modprobe product=
=3D0722<br>&gt=3B &gt=3B gives<br>&gt=3B &gt=3B<br>&gt=3B &gt=3B FATAL: Mod=
ule vendor=3D0df7 not found<br>&gt=3B <br>&gt=3B You are supposed to pass a=
ll 3 in a single line. product and vendor<br>&gt=3B are options for the hci=
_usb module.<br>&gt=3B <br>&gt=3B -- <br>&gt=3B Patryk Zawadzki<br>&gt=3B <=
br>&gt=3B -----------------------------------------------------------------=
-------------<br>&gt=3B SF.Net email is Sponsored by MIX09=2C March 18-20=
=2C 2009 in Las Vegas=2C Nevada.<br>&gt=3B The future of the web can't happ=
en without you.  Join us at MIX09 to help<br>&gt=3B pave the way to the Nex=
t Web now. Learn more and register at<br>&gt=3B http://ad.doubleclick.net/c=
lk=3B208669438=3B13503038=3Bi?http://2009.visitmix.com/<br>&gt=3B _________=
______________________________________<br>&gt=3B Bluez-devel mailing list<b=
r>&gt=3B Bluez-devel@lists.sourceforge.net<br>&gt=3B https://lists.sourcefo=
rge.net/lists/listinfo/bluez-devel<br><br /><hr />Invite your mail contacts=
 to join your friends list with Windows Live Spaces. It's easy! <a href=3D'=
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us' target=3D'_new'>Try it!</a></body>
</html>=

--_3679ae7f-c24c-4c91-bf87-d459012d7ef6_--


--===============2717441880434290826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
--===============2717441880434290826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2717441880434290826==--

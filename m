Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] motorola HS820 headset doesn't work
From: Cristiano De Michele <demichel@na.infn.it>
To: Peter Robinson <pbrobinson@gmail.com>, bluez-devel@lists.sourceforge.net
Cc: demichel@na.infn.it
In-Reply-To: <5256d0b05042604372879b077@mail.gmail.com>
References: <1114435410.8571.3.camel@localhost>
	 <5256d0b05042604372879b077@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aD3ESjAyLTGB9qEo7vq8"
Message-Id: <1114530221.14631.9.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 26 Apr 2005 17:43:40 +0200


--=-aD3ESjAyLTGB9qEo7vq8
Content-Type: multipart/alternative; boundary="=-D/eQTdUk9oirFEIt9xOw"


--=-D/eQTdUk9oirFEIt9xOw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-26 at 12:37 +0100, Peter Robinson wrote:

> > Hi,
> > if I do
> >=20
> > > modprobe snd_bt_sco
> > > esdctl stop
> > > hciconfig hci0 voice 0x0060
> > > btsco <address_of_my_headset>
> > > aplay -B 1000000 -D plughw:Headset <some wav file>
> >=20
> > I can't hear anything else than a bip in my headset,
> > that is properly paired (I checked with 'hcitool con')
> > 'dmesg' gives me what follows:
>=20

Hi Peter,

> When you type in btsco addr do you then hit the connect button on your
> headset this was the problem I was having with the motorola headsets
> I've tested (HS-810 and HS-850).

do you mean that I shouldn't press connect button?


> I wasn't using aplay but rather just using gnomemeeting and the
> headset just came up in the list of devices.

I also tried to cat a .wav file straight to /dev/dsp1 (supposed to be the h=
eadset device)
and I didn't hear anything, but maybe this is not the right way to get some=
thing, isn't it?



> Regards
> Peter

many thanks=20

Cristiano


>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20

--=20
Cristiano De Michele, Ph.D.          E-mail: cristiano.demichele@phys.uniro=
ma1.it
Department of Physics                Tel.  : +390649913435
University of Rome  "La Sapienza"    Fax   : +39064463158
Piazzale Aldo Moro 2
I-00185 Roma - Italy   =20
------
"Shoot for the moon. Even if you miss, you'll land among the stars."

--=-D/eQTdUk9oirFEIt9xOw
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; CHARSET=3DUTF-8">
  <META NAME=3D"GENERATOR" CONTENT=3D"GtkHTML/3.6.2">
</HEAD>
<BODY>
On Tue, 2005-04-26 at 12:37 +0100, Peter Robinson wrote:
<BLOCKQUOTE TYPE=3DCITE>
<PRE>
<FONT COLOR=3D"#000000">&gt; Hi,</FONT>
<FONT COLOR=3D"#000000">&gt; if I do</FONT>
<FONT COLOR=3D"#000000">&gt; </FONT>
<FONT COLOR=3D"#000000">&gt; &gt; modprobe snd_bt_sco</FONT>
<FONT COLOR=3D"#000000">&gt; &gt; esdctl stop</FONT>
<FONT COLOR=3D"#000000">&gt; &gt; hciconfig hci0 voice 0x0060</FONT>
<FONT COLOR=3D"#000000">&gt; &gt; btsco &lt;address_of_my_headset&gt;</FONT=
>
<FONT COLOR=3D"#000000">&gt; &gt; aplay -B 1000000 -D plughw:Headset &lt;so=
me wav file&gt;</FONT>
<FONT COLOR=3D"#000000">&gt; </FONT>
<FONT COLOR=3D"#000000">&gt; I can't hear anything else than a bip in my he=
adset,</FONT>
<FONT COLOR=3D"#000000">&gt; that is properly paired (I checked with 'hcito=
ol con')</FONT>
<FONT COLOR=3D"#000000">&gt; 'dmesg' gives me what follows:</FONT>

</PRE>
</BLOCKQUOTE>
Hi Peter,
<BLOCKQUOTE TYPE=3DCITE>
<PRE>
<FONT COLOR=3D"#000000">When you type in btsco addr do you then hit the con=
nect button on your</FONT>
<FONT COLOR=3D"#000000">headset this was the problem I was having with the =
motorola headsets</FONT>
<FONT COLOR=3D"#000000">I've tested (HS-810 and HS-850).</FONT>
</PRE>
</BLOCKQUOTE>
do you mean that I shouldn't press connect button?<BR>
<BR>
<BLOCKQUOTE TYPE=3DCITE>
<PRE>
<FONT COLOR=3D"#000000">I wasn't using aplay but rather just using gnomemee=
ting and the</FONT>
<FONT COLOR=3D"#000000">headset just came up in the list of devices.</FONT>
</PRE>
</BLOCKQUOTE>
<PRE>
I also tried to cat a .wav file straight to /dev/dsp1 (supposed to be the h=
eadset device)
and I didn't hear anything, but maybe this is not the right way to get some=
thing, isn't it?
</PRE>
<BR>
<BLOCKQUOTE TYPE=3DCITE>
<PRE>
<FONT COLOR=3D"#000000">Regards</FONT>
<FONT COLOR=3D"#000000">Peter</FONT>
</PRE>
</BLOCKQUOTE>
<PRE>
many thanks=20
</PRE>
Cristiano<BR>
<BR>
<BLOCKQUOTE TYPE=3DCITE>
<PRE>

<FONT COLOR=3D"#000000">---------------------------------------------------=
----</FONT>
<FONT COLOR=3D"#000000">SF email is sponsored by - The IT Product Guide</FO=
NT>
<FONT COLOR=3D"#000000">Read honest &amp; candid reviews on hundreds of IT =
Products from real users.</FONT>
<FONT COLOR=3D"#000000">Discover which products truly live up to the hype. =
Start reading now.</FONT>
<FONT COLOR=3D"#000000"><A HREF=3D"http://ads.osdn.com/?ad_ide95&alloc_id">=
http://ads.osdn.com/?ad_ide95&amp;alloc_id</A>&#20;396&amp;op=3Dclick</FONT=
>
<FONT COLOR=3D"#000000">_______________________________________________</FO=
NT>
<FONT COLOR=3D"#000000">Bluez-devel mailing list</FONT>
<FONT COLOR=3D"#000000"><A HREF=3D"mailto:Bluez-devel@lists.sourceforge.net=
">Bluez-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR=3D"#000000"><A HREF=3D"https://lists.sourceforge.net/lists/list=
info/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel<=
/A></FONT>

</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD>
<PRE>
--=20
Cristiano De Michele, Ph.D.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; E-mail: <A HREF=3D"mailto:cristiano.demichele@phys.uniroma1.it">cris=
tiano.demichele@phys.uniroma1.it</A>
Department of Physics&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tel.&nbsp; : +390649913435
University of Rome&nbsp; &quot;La Sapienza&quot;&nbsp;&nbsp;&nbsp; Fax&nbsp=
;&nbsp; : +39064463158
Piazzale Aldo Moro 2
I-00185 Roma - Italy&nbsp;&nbsp;&nbsp;&nbsp;
------
&quot;Shoot for the moon. Even if you miss, you'll land among the stars.&qu=
ot;
</PRE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-D/eQTdUk9oirFEIt9xOw--

--=-aD3ESjAyLTGB9qEo7vq8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCbmGrcBhvg6IwkBkRAt45AKDQAfixoX2wnC3qD/e/Rm+Iegjv4gCg4uXx
nyYn7Z1vsg/7o1T/nnRFsQI=
=4E3b
-----END PGP SIGNATURE-----

--=-aD3ESjAyLTGB9qEo7vq8--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

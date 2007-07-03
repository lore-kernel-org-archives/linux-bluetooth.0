Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100707031525v3766d2f3s2bdb2974f93c25c6@mail.gmail.com>
Date: Tue, 3 Jul 2007 19:25:59 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>
MIME-Version: 1.0
References: <46852386.8050608@free.fr>
	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
	<46892FEC.7000705@free.fr>
	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>
	<468A02F2.7030903@free.fr>
	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>
	<d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0168701228=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0168701228==
Content-Type: multipart/alternative;
	boundary="----=_Part_135848_6256363.1183501559104"

------=_Part_135848_6256363.1183501559104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Brad,

It is on cvs already, about the plugin I guess we cannot simple switch to
wired device if we do that we probably leave the application using it with
no clue that it switch to wired device on purposed. The routing stuff in my
opinion belong to the system audio server (pulse, esd), they could provide
a good ui in witch we can configure the fallback device depend on various
situations, if we do the rerouting on plugin we would break those
configurations.

On 7/3/07, Brad Midgley <bmidgley@gmail.com> wrote:
>
> Luiz
>
> > stream. Do you guys see any value in having a device connected but not
> > streaming?
>
> When no device is connected, the plugin will discard or (more
> preferably) send audio to the wired device. We use connected as a cue
> that the user wants to use that device for audio.
>
> Are your latest developments in cvs these days or do I need to check git?
>
> Brad
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

------=_Part_135848_6256363.1183501559104
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Brad,<br><br>It is on cvs already, about the plugin I guess we cannot si=
mple switch to<br>wired device if we do that we probably leave the applicat=
ion using it with<br>no clue that it switch to wired device on purposed. Th=
e routing stuff in my
<br>opinion belong to the system audio server (pulse, esd), they could prov=
ide<br>a good ui in witch we can configure the fallback device depend on va=
rious<br>situations, if we do the rerouting on plugin we would break those =
configurations.
<br><br><div><span class=3D"gmail_quote">On 7/3/07, <b class=3D"gmail_sende=
rname">Brad Midgley</b> &lt;<a href=3D"mailto:bmidgley@gmail.com">bmidgley@=
gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
Luiz<br><br>&gt; stream. Do you guys see any value in having a device conne=
cted but not<br>&gt; streaming?<br><br>When no device is connected, the plu=
gin will discard or (more<br>preferably) send audio to the wired device. We=
 use connected as a cue
<br>that the user wants to use that device for audio.<br><br>Are your lates=
t developments in cvs these days or do I need to check git?<br><br>Brad<br>=
<br>-----------------------------------------------------------------------=
--
<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C=
 - the FREE version of DB2 express and take<br>control of your XML. No limi=
ts. Just data. Click to get it now.<br><a href=3D"http://sourceforge.net/po=
werbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________=
________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-dev=
el@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=
=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br><br clear=3D"all"><br>-- <br>Luiz Augusto von Dentz<br>Engenhei=
ro de Computa=E7=E3o

------=_Part_135848_6256363.1183501559104--


--===============0168701228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0168701228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0168701228==--

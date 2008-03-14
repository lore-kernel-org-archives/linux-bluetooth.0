Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W836C1CD8A589599577B91F00A0@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 14 Mar 2008 14:20:49 +0000
In-Reply-To: <63E1C59E-6425-4B25-B5F2-44CF0107BADD@holtmann.org>
References: <1205440348.12951.9.camel@californication>
	<47DA5229.3050605@aircable.net>
	<9D26A74C-6B7C-48A7-BFA1-A5128475F01B@holtmann.org>
	<47DA813E.7060503@aircable.net>
	<63E1C59E-6425-4B25-B5F2-44CF0107BADD@holtmann.org>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Moving towards a new API for BlueZ 4.0
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0038026288=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0038026288==
Content-Type: multipart/alternative;
	boundary="_84824cab-c491-422e-9dbd-564ad1d1e435_"

--_84824cab-c491-422e-9dbd-564ad1d1e435_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
> I am not sure. The code to make this all work is so complicated that I > =
really wanna remove it when we hit 4.0. Ping me again at some point. > For =
now we are going without allowing discovery without resolving the > name.
I can imagine this must be a difficult decision to be making, I can appreci=
ate that you want to keep the API and its supporting code as clean as possi=
ble.
=20
However, I'm going to +1 with Manuel on this one, my business requirements =
mean that discovery speed is quite important for me, in fact, I would proba=
bly say it was 'vital'. I can appreciate from your stand point that many de=
velopers working on gnome bluetooth and dealing with a small number of remo=
te devices it might not be such an issue, however, I think that in a commer=
cial or industrial environment when dealing with M2M communications, knowin=
g the name of a device is pretty insignificant compared to the desire to di=
scover devices efficiently.
=20
It would be a shame to see this feature dropped from the 4.0 build as it wo=
uld likely mean I am unable to upgrade, I'm also quite sure many other deve=
lopers working in the industrial sector with M2M and suchlike, such as Manu=
el, would also be forced into using legacy builds of the stack.
=20
On the flip side, all the other changes to the API look EXCELLENT! I'm look=
ing forward to working with it to see exactly how it implements.
=20
Thanks Marcel,
=20
Robert
_________________________________________________________________
Who's friends with who and co-starred in what?
http://www.searchgamesbox.com/celebrityseparation.shtml=

--_84824cab-c491-422e-9dbd-564ad1d1e435_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>Hi Marcel,<BR>
<BR>&gt; I am not sure. The code to make this all work is so complicated th=
at I <BR>&gt; really wanna remove it when we hit 4.0. Ping me again at some=
 point. <BR>&gt; For now we are going without allowing discovery without re=
solving the <BR>&gt; name.<BR><BR>
I can imagine this must be a difficult decision to be making, I can appreci=
ate that you want to keep the API and its supporting code as clean as possi=
ble.<BR>
&nbsp;<BR>
However, I'm going to +1 with Manuel on this one, my business requirements =
mean that discovery speed is quite important for me, in fact, I would proba=
bly say it was 'vital'. I can appreciate from your stand point that many de=
velopers working on gnome bluetooth and dealing with a&nbsp;small number of=
 remote&nbsp;devices it might not be such an issue, however, I think that i=
n a commercial or industrial environment when dealing with M2M communicatio=
ns, knowing the name of a device is pretty insignificant compared to the de=
sire to discover devices efficiently.<BR>
&nbsp;<BR>
It would be a shame to see this feature dropped from the 4.0 build as it wo=
uld likely mean I am unable to upgrade, I'm also quite sure many other deve=
lopers working in the industrial sector with M2M and suchlike, such as Manu=
el, would also be forced into using legacy builds of the stack.<BR>
&nbsp;<BR>
On the flip side, all the other changes to the API look EXCELLENT! I'm look=
ing forward to working with it to see exactly how it implements.<BR>
&nbsp;<BR>
Thanks Marcel,<BR>
&nbsp;<BR>
Robert<BR><br /><hr />Sounds like? How many syllables? <a href=3D'http://ww=
w.searchcharades.com' target=3D'_new'>Guess and win prizes with Search Char=
ades!</a></body>
</html>=

--_84824cab-c491-422e-9dbd-564ad1d1e435_--


--===============0038026288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0038026288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0038026288==--

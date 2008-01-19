Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W21F3A05A9C61191631E145F0430@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sat, 19 Jan 2008 16:16:40 +0000
In-Reply-To: <200801182017.36181.chick@computergeek.freeserve.co.uk>
References: <BAY102-W17970DD14D6076D3F44BCBF0420@phx.gbl>
	<200801182017.36181.chick@computergeek.freeserve.co.uk>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Same Old Speed Issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0739626127=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0739626127==
Content-Type: multipart/alternative;
	boundary="_6a9d7e0e-91c2-4e70-91e7-d40bdb7bc8c7_"

--_6a9d7e0e-91c2-4e70-91e7-d40bdb7bc8c7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Tim,
=20
Thanks for getting back me on this. I've not tried changing the block size =
at all, I would love to give that a go. Would you mind giving me a little a=
dvice on how to do so? I had a quick google around but couldn't really find=
 anything related to obex block sizes.
=20
As a little addition to the information I posted yesterday, I've done some =
more testing this morning. I built a system on different architecture and u=
sing a slackware linux instead of debian and still had the same issues. I a=
lso went out and bought myself a totally different dongle from a different =
manufacturer which also has this slow transmit speed, so I can definitely c=
onfirm this doesn't appear to be a hardware or OS related issue, I'm guessi=
ng something config related.
=20
If you wouldn't mind giving me a little advice on how to change that block =
size I would love to give that a shot.
=20
Thanks mate for your time,
=20
Rob



> From: chick@computergeek.freeserve.co.uk> To: bluez-devel@lists.sourcefor=
ge.net> Date: Fri, 18 Jan 2008 20:17:35 +0000> Subject: Re: [Bluez-devel] S=
ame Old Speed Issues> > On Friday 18 January 2008 15:04:58 Robert Rawlins w=
rote:> > At the moment I've tried using both ussp-push and open-obex push c=
lients to> > transfer the file, both giving me the same results. I'm achiev=
ing roughly> > 25Kbytes/s transfer speed both up and down. I've tried runni=
ng these same> > dongles from my Windows PC and achieve well over 100kBytes=
/s. (This is> > transmitting to a Sony k850i handset which is v2.0 + EDR). =
This would lead> > me to believe its not an issue with the Dongle, more lik=
ely something with> > my Linux configuration> >> > Have you tried changing =
the OBEX block size - try forcing the minimum size to > 64kB-1?> > Cheers,>=
 Tim> > > -----------------------------------------------------------------=
--------> This SF.net email is sponsored by: Microsoft> Defy all challenges=
. Microsoft(R) Visual Studio 2008.> http://clk.atdmt.com/MRT/go/vse01200000=
70mrt/direct/01/> _______________________________________________> Bluez-de=
vel mailing list> Bluez-devel@lists.sourceforge.net> https://lists.sourcefo=
rge.net/lists/listinfo/bluez-devel
_________________________________________________________________
Telly addicts unite!
http://www.searchgamesbox.com/tvtown.shtml=

--_6a9d7e0e-91c2-4e70-91e7-d40bdb7bc8c7_
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
<body class=3D'hmmessage'>Hello Tim,<BR>
&nbsp;<BR>
Thanks for getting back me on this. I've not tried changing the block size =
at all, I would love to give that a go. Would you mind giving me a little a=
dvice on how to do so? I had a quick google around but couldn't really find=
 anything related to obex block sizes.<BR>
&nbsp;<BR>
As a little addition to the information I posted yesterday, I've done some =
more testing this morning. I built a system on different architecture and u=
sing a slackware linux instead of debian and still had the same issues. I a=
lso went out and bought myself a totally different dongle from a different =
manufacturer&nbsp;which also has this slow transmit speed, so I can definit=
ely confirm this doesn't appear to be a hardware or&nbsp;OS&nbsp;related is=
sue, I'm guessing something config related.<BR>
&nbsp;<BR>
If you wouldn't mind giving me a little advice on how to change that block =
size I would love to give that a shot.<BR>
&nbsp;<BR>
Thanks mate for your time,<BR>
&nbsp;<BR>
Rob<BR><BR><BR>

<HR id=3DstopSpelling>
<BR>
&gt; From: chick@computergeek.freeserve.co.uk<BR>&gt; To: bluez-devel@lists=
.sourceforge.net<BR>&gt; Date: Fri, 18 Jan 2008 20:17:35 +0000<BR>&gt; Subj=
ect: Re: [Bluez-devel] Same Old Speed Issues<BR>&gt; <BR>&gt; On Friday 18 =
January 2008 15:04:58 Robert Rawlins wrote:<BR>&gt; &gt; At the moment I've=
 tried using both ussp-push and open-obex push clients to<BR>&gt; &gt; tran=
sfer the file, both giving me the same results. I'm achieving roughly<BR>&g=
t; &gt; 25Kbytes/s transfer speed both up and down. I've tried running thes=
e same<BR>&gt; &gt; dongles from my Windows PC and achieve well over 100kBy=
tes/s. (This is<BR>&gt; &gt; transmitting to a Sony k850i handset which is =
v2.0 + EDR). This would lead<BR>&gt; &gt; me to believe its not an issue wi=
th the Dongle, more likely something with<BR>&gt; &gt; my Linux configurati=
on<BR>&gt; &gt;<BR>&gt; <BR>&gt; Have you tried changing the OBEX block siz=
e - try forcing the minimum size to <BR>&gt; 64kB-1?<BR>&gt; <BR>&gt; Cheer=
s,<BR>&gt; Tim<BR>&gt; <BR>&gt; <BR>&gt; ----------------------------------=
---------------------------------------<BR>&gt; This SF.net email is sponso=
red by: Microsoft<BR>&gt; Defy all challenges. Microsoft(R) Visual Studio 2=
008.<BR>&gt; http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/<BR>&gt=
; _______________________________________________<BR>&gt; Bluez-devel maili=
ng list<BR>&gt; Bluez-devel@lists.sourceforge.net<BR>&gt; https://lists.sou=
rceforge.net/lists/listinfo/bluez-devel<BR><BR><br /><hr />Messenger on the=
 move. <a href=3D'http://mobile.uk.msn.com/pc/messenger.aspx ' target=3D'_n=
ew'>Text MSN to 63463 now!</a></body>
</html>=

--_6a9d7e0e-91c2-4e70-91e7-d40bdb7bc8c7_--


--===============0739626127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0739626127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0739626127==--

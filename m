Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W36661CB968B8B2AE2B4103F03D0@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 21 Jan 2008 16:11:14 +0000
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
Content-Type: multipart/mixed; boundary="===============1471283814=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1471283814==
Content-Type: multipart/alternative;
	boundary="_5c2aa693-e333-42a2-a38e-f66364440fbf_"

--_5c2aa693-e333-42a2-a38e-f66364440fbf_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
I've been playing around with this again today, looking into ALC MTU's and =
things like that but really can't find any resources to suggest why I might=
 be getting such poor speeds, I thought it would be a plug-and-play kinds o=
f affair.=20
=20
I also made an effort to try a couple of other kernel versions, just in cas=
e, but they all gave the same results as 2.6.23.
=20
Thanks for any further advice guys. Is it worth me giving you some HCI_DUMP=
 information? Is that likely to hold any clues as to what's going wrong?
=20
Cheers,
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
Share what Santa brought you
https://www.mycooluncool.com=

--_5c2aa693-e333-42a2-a38e-f66364440fbf_
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
<body class=3D'hmmessage'><P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm =
0pt"><FONT size=3D3><FONT color=3D#000000><FONT face=3DConsolas>Hello Guys,=
<?xml:namespace prefix =3D o ns =3D "urn:schemas-microsoft-com:office:offic=
e" /><o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT face=3DCon=
solas color=3D#000000 size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><FONT size=3D3><FONT =
color=3D#000000><FONT face=3DConsolas>I've been playing around with this ag=
ain today, looking into ALC MTU's and things like that but really can't fin=
d any resources to suggest why I might be getting such poor speeds, I thoug=
ht it would be a plug-and-play kinds of affair. <o:p></o:p></FONT></FONT></=
FONT></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT face=3DCon=
solas color=3D#000000 size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><FONT size=3D3><FONT =
color=3D#000000><FONT face=3DConsolas>I also made an effort to try a couple=
 of other kernel versions, just in case, but they all gave the same results=
 as 2.6.23.<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT face=3DCon=
solas color=3D#000000 size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><FONT size=3D3><FONT =
color=3D#000000><FONT face=3DConsolas>Thanks for any further advice guys. I=
s it worth me giving you some HCI_DUMP information? Is that likely to hold =
any clues as to what's going wrong?<o:p></o:p></FONT></FONT></FONT></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT face=3DCon=
solas color=3D#000000 size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><FONT size=3D3><FONT =
color=3D#000000><FONT face=3DConsolas>Cheers,<o:p></o:p></FONT></FONT></FON=
T></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><o:p><FONT face=3DCon=
solas color=3D#000000 size=3D3>&nbsp;</FONT></o:p></P>
<P class=3DMsoPlainText style=3D"MARGIN: 0cm 0cm 0pt"><FONT size=3D3><FONT =
color=3D#000000><FONT face=3DConsolas>Rob</FONT></FONT></FONT><BR><BR><BR>
<HR id=3DstopSpelling>
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
rceforge.net/lists/listinfo/bluez-devel<BR></P><br /><hr />Everything in on=
e place. <a href=3D'http://www.windowslive.co.uk/get-live' target=3D'_new'>=
All new Windows Live!</a></body>
</html>=

--_5c2aa693-e333-42a2-a38e-f66364440fbf_--


--===============1471283814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1471283814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1471283814==--

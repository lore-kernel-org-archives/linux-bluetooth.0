Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W618F2CC7E41A78CBBCE7CF0390@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 25 Jan 2008 10:28:36 +0000
In-Reply-To: <BAY102-W36661CB968B8B2AE2B4103F03D0@phx.gbl>
References: <BAY102-W17970DD14D6076D3F44BCBF0420@phx.gbl>
	<200801182017.36181.chick@computergeek.freeserve.co.uk>
	<BAY102-W36661CB968B8B2AE2B4103F03D0@phx.gbl>
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
Content-Type: multipart/mixed; boundary="===============0767169468=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0767169468==
Content-Type: multipart/alternative;
	boundary="_f350a030-60c8-4368-ba0b-20e8e6914312_"

--_f350a030-60c8-4368-ba0b-20e8e6914312_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Good morning,
=20
Another update on my progress with the problem. This morning I had two new =
version 2.0 + EDR dongles arrive in the post, both from different manufactu=
rer and both listed on the compatibility list for bluez.
=20
I've run some tests this morning on these other two dongles and receive the=
 exact same problem, still not getting anything over 25kBytes/s.
=20
I'm running out of different tests to run, I've tried different dongles, sy=
stem boards, linux builds, kernel versions, bluez versions and every single=
 one keep presenting the same problems, Am I missing something?
=20
Thanks guys, I would really appreciate any ideas you might have.
=20
Rob


From: robert_rawlins@hotmail.comTo: bluez-devel@lists.sourceforge.netDate: =
Mon, 21 Jan 2008 16:11:14 +0000Subject: Re: [Bluez-devel] Same Old Speed Is=
sues



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


Everything in one place. All new Windows Live!=20
_________________________________________________________________
Share what Santa brought you
https://www.mycooluncool.com=

--_f350a030-60c8-4368-ba0b-20e8e6914312_
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
<body class=3D'hmmessage'>Good morning,<BR>
&nbsp;<BR>
Another update on my progress with the problem. This morning I had two new =
version 2.0 + EDR dongles arrive in the post, both from different manufactu=
rer and both listed on the compatibility list for bluez.<BR>
&nbsp;<BR>
I've run some tests this morning on these other two dongles and receive the=
 exact same problem, still not getting anything over 25kBytes/s.<BR>
&nbsp;<BR>
I'm running out of different tests to run, I've tried different dongles, sy=
stem boards, linux builds, kernel versions, bluez versions and every single=
 one keep presenting the same problems, Am I missing something?<BR>
&nbsp;<BR>
Thanks guys, I would really appreciate any ideas you might have.<BR>
&nbsp;<BR>
Rob<BR>
<BLOCKQUOTE>
<HR id=3DEC_stopSpelling>
From: robert_rawlins@hotmail.com<BR>To: bluez-devel@lists.sourceforge.net<B=
R>Date: Mon, 21 Jan 2008 16:11:14 +0000<BR>Subject: Re: [Bluez-devel] Same =
Old Speed Issues<BR><BR>
<META content=3D"Microsoft SafeHTML" name=3DGenerator>
<STYLE>
.ExternalClass .EC_hmmessage P
{padding:0px;}
.ExternalClass EC_body.hmmessage
{font-size:10pt;font-family:Tahoma;}
</STYLE>

<P class=3DEC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT face=
=3DConsolas>Hello Guys,</FONT></FONT></FONT></P>
<P class=3DEC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D3>&=
nbsp;</FONT></P>
<P class=3DEC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT face=
=3DConsolas>I've been playing around with this again today, looking into AL=
C MTU's and things like that but really can't find any resources to suggest=
 why I might be getting such poor speeds, I thought it would be a plug-and-=
play kinds of affair. </FONT></FONT></FONT></P>
<P class=3DEC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D3>&=
nbsp;</FONT></P>
<P class=3DEC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT face=
=3DConsolas>I also made an effort to try a couple of other kernel versions,=
 just in case, but they all gave the same results as 2.6.23.</FONT></FONT><=
/FONT></P>
<P class=3DEC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D3>&=
nbsp;</FONT></P>
<P class=3DEC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT face=
=3DConsolas>Thanks for any further advice guys. Is it worth me giving you s=
ome HCI_DUMP information? Is that likely to hold any clues as to what's goi=
ng wrong?</FONT></FONT></FONT></P>
<P class=3DEC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D3>&=
nbsp;</FONT></P>
<P class=3DEC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT face=
=3DConsolas>Cheers,</FONT></FONT></FONT></P>
<P class=3DEC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D3>&=
nbsp;</FONT></P>
<P class=3DEC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT face=
=3DConsolas>Rob</FONT></FONT></FONT><BR><BR><BR>
<HR id=3DEC_stopSpelling>
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
rceforge.net/lists/listinfo/bluez-devel<BR>
<BR><BR>
<HR>
Everything in one place. <A href=3D"http://www.windowslive.co.uk/get-live" =
target=3D_blank>All new Windows Live!</A> </BLOCKQUOTE><br /><hr />Everythi=
ng in one place. <a href=3D'http://www.windowslive.co.uk/get-live' target=
=3D'_new'>All new Windows Live!</a></body>
</html>=

--_f350a030-60c8-4368-ba0b-20e8e6914312_--


--===============0767169468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0767169468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0767169468==--

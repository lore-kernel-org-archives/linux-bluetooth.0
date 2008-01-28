Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W375A5FB8242F3B1245148AF0340@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 28 Jan 2008 12:59:19 +0000
In-Reply-To: <BAY102-W618F2CC7E41A78CBBCE7CF0390@phx.gbl>
References: <BAY102-W17970DD14D6076D3F44BCBF0420@phx.gbl>
	<200801182017.36181.chick@computergeek.freeserve.co.uk>
	<BAY102-W36661CB968B8B2AE2B4103F03D0@phx.gbl>
	<BAY102-W618F2CC7E41A78CBBCE7CF0390@phx.gbl>
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
Content-Type: multipart/mixed; boundary="===============1014768585=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1014768585==
Content-Type: multipart/alternative;
	boundary="_5ddae0f8-29af-404e-9cce-ba1914aa8df7_"

--_5ddae0f8-29af-404e-9cce-ba1914aa8df7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Afternoon Guys,
=20
I know that you're probably getting tired of hearing about this problem but=
 thought I would post some more information in the hope that it might shed =
some light on the situation and hopefully solve the problem. I just wanted =
to get your opinion on the HCI dump information which gets output when a fi=
le is transferred.
=20
It generally seems to be the following repeated continuously throughout the=
 transfer:
=20
< ACL data: handle 42 flags 0x02 dlen 25    L2CAP(d): cid 0x004f len 21 [ps=
m 3]      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 17 fcs 0x4f > HCI Event: N=
umber of Completed Packets (0x13) plen 5> HCI Event: Number of Completed Pa=
ckets (0x13) plen 5> HCI Event: Number of Completed Packets (0x13) plen 5> =
ACL data: handle 42 flags 0x02 dlen 12    L2CAP(d): cid 0x0040 len 8 [psm 3=
]      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 2< ACL dat=
a: handle 42 flags 0x02 dlen 310< ACL data: handle 42 flags 0x01 dlen 310< =
ACL data: handle 42 flags 0x01 dlen 310< ACL data: handle 42 flags 0x01 dle=
n 86    L2CAP(d): cid 0x004f len 1012 [psm 3]      RFCOMM(d): UIH: cr 1 dlc=
i 12 pf 0 ilen 1007 fcs 0x4f=20
Does that look normal to you guys are should it be looking any different? I=
 know this is a bit of a tedious thread but I really would appreciate some =
help solving this as it seems to be driving me a little crazy, Even if you =
can point me in the direction of a dongle you are using which you are SURE =
works at full speed, just so I can test it out.
=20
Thanks guys,
=20
Rob


From: robert_rawlins@hotmail.comTo: bluez-devel@lists.sourceforge.netDate: =
Fri, 25 Jan 2008 10:28:36 +0000Subject: Re: [Bluez-devel] Same Old Speed Is=
sues


Good morning, Another update on my progress with the problem. This morning =
I had two new version 2.0 + EDR dongles arrive in the post, both from diffe=
rent manufacturer and both listed on the compatibility list for bluez. I've=
 run some tests this morning on these other two dongles and receive the exa=
ct same problem, still not getting anything over 25kBytes/s. I'm running ou=
t of different tests to run, I've tried different dongles, system boards, l=
inux builds, kernel versions, bluez versions and every single one keep pres=
enting the same problems, Am I missing something? Thanks guys, I would real=
ly appreciate any ideas you might have. Rob


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

Everything in one place. All new Windows Live!=20
_________________________________________________________________
Free games, great prizes - get gaming at Gamesbox.=20
http://www.searchgamesbox.com=

--_5ddae0f8-29af-404e-9cce-ba1914aa8df7_
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
<body class=3D'hmmessage'>Afternoon Guys,<BR>
&nbsp;<BR>
I know that you're probably getting tired of hearing about this problem but=
 thought I would post some more information in the hope that it might shed =
some light on the situation and hopefully solve the problem. I just wanted =
to get your opinion on the HCI dump information which gets output when a fi=
le is transferred.<BR>
&nbsp;<BR>
It generally seems to be the following repeated continuously throughout the=
 transfer:<BR>
&nbsp;<BR>
&lt; ACL data: handle 42 flags 0x02 dlen 25<BR>&nbsp;&nbsp;&nbsp; L2CAP(d):=
 cid 0x004f len 21 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH=
: cr 1 dlci 12 pf 0 ilen 17 fcs 0x4f <BR>&gt; HCI Event: Number of Complete=
d Packets (0x13) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x1=
3) plen 5<BR>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<BR>&=
gt; ACL data: handle 42 flags 0x02 dlen 12<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): =
cid 0x0040 len 8 [psm 3]<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: =
cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 2<BR>&lt; ACL data: handle 42 fla=
gs 0x02 dlen 310<BR>&lt; ACL data: handle 42 flags 0x01 dlen 310<BR>&lt; AC=
L data: handle 42 flags 0x01 dlen 310<BR>&lt; ACL data: handle 42 flags 0x0=
1 dlen 86<BR>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x004f len 1012 [psm 3]<BR>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 1007 fc=
s 0x4f <BR><BR><BR>
Does that look normal to you guys are should it be looking any different? I=
 know this is a bit of a tedious thread but I really would appreciate some =
help solving this as it seems to be driving me a little crazy, Even if you =
can point me in the direction of a dongle you are using which you are SURE =
works at full speed, just so I can test it out.<BR>
&nbsp;<BR>
Thanks guys,<BR>
&nbsp;<BR>
Rob<BR><BR>
<BLOCKQUOTE>
<HR id=3DEC_stopSpelling>
From: robert_rawlins@hotmail.com<BR>To: bluez-devel@lists.sourceforge.net<B=
R>Date: Fri, 25 Jan 2008 10:28:36 +0000<BR>Subject: Re: [Bluez-devel] Same =
Old Speed Issues<BR><BR>
<META content=3D"Microsoft SafeHTML" name=3DGenerator>
<STYLE>
.ExternalClass .EC_hmmessage P
{padding:0px;}
.ExternalClass EC_body.hmmessage
{font-size:10pt;font-family:Tahoma;}
</STYLE>
Good morning,<BR>&nbsp;<BR>Another update on my progress with the problem. =
This morning I had two new version 2.0 + EDR dongles arrive in the post, bo=
th from different manufacturer and both listed on the compatibility list fo=
r bluez.<BR>&nbsp;<BR>I've run some tests this morning on these other two d=
ongles and receive the exact same problem, still not getting anything over =
25kBytes/s.<BR>&nbsp;<BR>I'm running out of different tests to run, I've tr=
ied different dongles, system boards, linux builds, kernel versions, bluez =
versions and every single one keep presenting the same problems, Am I missi=
ng something?<BR>&nbsp;<BR>Thanks guys, I would really appreciate any ideas=
 you might have.<BR>&nbsp;<BR>Rob<BR>
<BLOCKQUOTE>
<HR id=3DEC_EC_stopSpelling>
From: robert_rawlins@hotmail.com<BR>To: bluez-devel@lists.sourceforge.net<B=
R>Date: Mon, 21 Jan 2008 16:11:14 +0000<BR>Subject: Re: [Bluez-devel] Same =
Old Speed Issues<BR><BR>
<STYLE>
.ExternalClass .EC_hmmessage P
{padding:0px;}
.ExternalClass EC_body.hmmessage
{font-size:10pt;font-family:Tahoma;}
</STYLE>

<P class=3DEC_EC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT fa=
ce=3DConsolas>Hello Guys,</FONT></FONT></FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D=
3>&nbsp;</FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT fa=
ce=3DConsolas>I've been playing around with this again today, looking into =
ALC MTU's and things like that but really can't find any resources to sugge=
st why I might be getting such poor speeds, I thought it would be a plug-an=
d-play kinds of affair. </FONT></FONT></FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D=
3>&nbsp;</FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT fa=
ce=3DConsolas>I also made an effort to try a couple of other kernel version=
s, just in case, but they all gave the same results as 2.6.23.</FONT></FONT=
></FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D=
3>&nbsp;</FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT fa=
ce=3DConsolas>Thanks for any further advice guys. Is it worth me giving you=
 some HCI_DUMP information? Is that likely to hold any clues as to what's g=
oing wrong?</FONT></FONT></FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D=
3>&nbsp;</FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT fa=
ce=3DConsolas>Cheers,</FONT></FONT></FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT face=3DConsolas color=3D#000000 size=3D=
3>&nbsp;</FONT></P>
<P class=3DEC_EC_MsoPlainText><FONT size=3D3><FONT color=3D#000000><FONT fa=
ce=3DConsolas>Rob</FONT></FONT></FONT><BR><BR><BR>
<HR id=3DEC_EC_stopSpelling>
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
rceforge.net/lists/listinfo/bluez-devel<BR><BR><BR>
<HR>
Everything in one place. <A href=3D"http://www.windowslive.co.uk/get-live" =
target=3D_blank>All new Windows Live!</A> </BLOCKQUOTE><BR>
<HR>
Everything in one place. <A href=3D"http://www.windowslive.co.uk/get-live" =
target=3D_blank>All new Windows Live!</A> </BLOCKQUOTE><br /><hr />She said=
 what? About who? <a href=3D'http://www.msnsearchstar.com' target=3D'_new'>=
Shameful celebrity quotes on Search Star!</a></body>
</html>=

--_5ddae0f8-29af-404e-9cce-ba1914aa8df7_--


--===============1014768585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1014768585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1014768585==--

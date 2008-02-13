Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY102-W41CC3B366D95758BEC82D0F0240@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Wed, 13 Feb 2008 16:58:28 +0000
In-Reply-To: <1202920228.7664.419.camel@violet>
References: <5d5443650802080456p78f33f07s3ec6ac4c4c1e789c@mail.gmail.com>
	<20080208141056.GZ24072@matthew.ath.cx>
	<5d5443650802110839u2f12eb01j603dcc436085c84d@mail.gmail.com>
	<20080211164102.GA8137@berrange.com>
	<BAY102-W409DB55A6A242470BDB930F02B0@phx.gbl>
	<BAY102-W220E308B67B2F42DCEB5FFF0240@phx.gbl>
	<1202920228.7664.419.camel@violet>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Asynchronous SDP With DBUS API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1722045774=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1722045774==
Content-Type: multipart/alternative;
	boundary="_1a8bbde9-f39c-4a54-afbd-dbca2b67159e_"

--_1a8bbde9-f39c-4a54-afbd-dbca2b67159e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
=20
> Hi Robert,> > > I've been playing around with the DBUS API over the past =
week or two> > and notice a large number of the methods implemented are asy=
nchronous> > and send back signals when results from them are returned, how=
ever,> > this doesn't appear to be the case with an SDP enquiry placed thro=
ugh> > the service which appears to run synchronously.> > > > What's the re=
ason behind this? are we not able to have it emit a> > signal such as 'serv=
iceFound()' or something to that effect? is this> > down to a limitation of=
 the hardware? the stack? or am I just coding> > against the API incorrectl=
y?> > > > Has anyone been able to find an Asynchronous implementation for S=
DP> > enquiries? even if its some form of threaded work around.> > actually=
 D-Bus method calls are always asynchronous.> > Regards> > Marcel
Ok, I see.
=20
Well, perhaps you can help me on an issue I've been having. At the moment I=
 find myself having two problems, firstly, it appears that whenever I perfo=
rm an SDP within the application on an adapter which is in the middle of an=
 enquiry, the enquiry is terminated, is this usual behaviour? Should I perh=
aps be looking at using the periodic discovery (which i note is listed as n=
on blocking) and then terminate it once I've acquired the devices I require=
?
=20
The reason I'm after asynchronous behaviour in my SDP enquiry is that at pr=
esent, if I have a device in the office such as one of the girls down at re=
ception who is a long distance away then they're phone takes a long time to=
 reply to an sdp request, resulting in the rest of my application having to=
 wait upon its response and unable to do anything else like running SDP's o=
n other devices. In an ideal world the application would continue through i=
ts processes able to perform service enquires on another device or two.
=20
What would you suggest as the best way to implement that behaviour?
=20
Thanks for your time Marcel,
=20
Robert
_________________________________________________________________
Telly addicts unite!
http://www.searchgamesbox.com/tvtown.shtml=

--_1a8bbde9-f39c-4a54-afbd-dbca2b67159e_
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
&nbsp;<BR>
&gt; Hi Robert,<BR>&gt; <BR>&gt; &gt; I've been playing around with the DBU=
S API over the past week or two<BR>&gt; &gt; and notice a large number of t=
he methods implemented are asynchronous<BR>&gt; &gt; and send back signals =
when results from them are returned, however,<BR>&gt; &gt; this doesn't app=
ear to be the case with an SDP enquiry placed through<BR>&gt; &gt; the serv=
ice which appears to run synchronously.<BR>&gt; &gt; <BR>&gt; &gt; What's t=
he reason behind this? are we not able to have it emit a<BR>&gt; &gt; signa=
l such as 'serviceFound()' or something to that effect? is this<BR>&gt; &gt=
; down to a limitation of the hardware? the stack? or am I just coding<BR>&=
gt; &gt; against the API incorrectly?<BR>&gt; &gt; <BR>&gt; &gt; Has anyone=
 been able to find an Asynchronous implementation for SDP<BR>&gt; &gt; enqu=
iries? even if its some form of threaded work around.<BR>&gt; <BR>&gt; actu=
ally D-Bus method calls are always asynchronous.<BR>&gt; <BR>&gt; Regards<B=
R>&gt; <BR>&gt; Marcel<BR><BR>
Ok, I see.<BR>
&nbsp;<BR>
Well, perhaps you can help me on&nbsp;an issue I've been having. At the mom=
ent I find myself having two problems, firstly, it appears that whenever I =
perform an SDP within the application on an adapter which is in the middle =
of an enquiry, the enquiry is terminated, is this usual behaviour? Should I=
 perhaps be looking at using the periodic discovery (which i note is listed=
 as non blocking) and then terminate it once I've acquired the devices I re=
quire?<BR>
&nbsp;<BR>
The reason I'm after asynchronous behaviour in my SDP enquiry is that at pr=
esent, if I have a device in the office such as one of the girls down at re=
ception who is a long distance away then they're phone takes a long time to=
 reply to an sdp request, resulting in the rest of my application having to=
 wait upon its response and unable to do anything else like running SDP's o=
n other devices. In an ideal world the application would continue through i=
ts processes able to perform service enquires on another device or two.<BR>
&nbsp;<BR>
What would you suggest as the best way to implement that behaviour?<BR>
&nbsp;<BR>
Thanks for your time Marcel,<BR>
&nbsp;<BR>
Robert<BR><br /><hr />Messenger on the move. <a href=3D'http://mobile.uk.ms=
n.com/pc/messenger.aspx ' target=3D'_new'>Text MSN to 63463 now!</a></body>
</html>=

--_1a8bbde9-f39c-4a54-afbd-dbca2b67159e_--


--===============1722045774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1722045774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1722045774==--

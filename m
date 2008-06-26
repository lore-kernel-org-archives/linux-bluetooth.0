Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU120-W31892B117FCE752B773847A6A30@phx.gbl>
From: Carlo Giuseppe Monaco <carlogmonaco@hotmail.it>
To: <bluez-devel@lists.sourceforge.net>
Date: Thu, 26 Jun 2008 15:27:18 +0200
In-Reply-To: <BLU120-W31FBA90BA2C2FBD7924E54A6A30@phx.gbl>
References: <a1c657a80806252303p2563497fs70b548dbbe4f3388@mail.gmail.com>
	<BLU120-W31FBA90BA2C2FBD7924E54A6A30@phx.gbl>
MIME-Version: 1.0
Subject: [Bluez-devel] adding PDU and debbugging sdp daemon
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1895806975=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1895806975==
Content-Type: multipart/alternative;
	boundary="_734ca61f-a1a8-4433-bc40-8b70cec42b34_"

--_734ca61f-a1a8-4433-bc40-8b70cec42b34_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable








=20


Dear Sir,

I'm modifying bluez-libs and bluez-utils (i'm using
3.9 version) to introduce new pdu relating to registration, request and
response of new services.
For example  i'm adding new pdu types, defining them into  bluez-libs-3.9/i=
nclude/sdp.h=20

# define SDP_NEW_REGISTER_REQ 0x85

But
during debugging I returned errno =3D EINVAL (set by sdp_device_record_regi=
ster_binary written in sdp.c ) and the sdp daemon log file=20
gets the following result:=20

Jun 25 21:26:31 pinta-desktop hcid[4967]: Unknown PDU ID : 0x85 received=20
(i thintk it's a message sent from function process_request
written in bluez_utils_3.9/sdpd/request.c )
=20
How can i accept new types of pdu declared?
Is
there a way to debug sdp daemon alternative to log file, for example
using gdb o using particular options in ./configure command? I tried
using --enable-debug option for configure and launching gdb, but they
don't work.


Thanks for your support and sorry for my english.

Best Regards,
Carlo M.=20

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Space=
s. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.=
aspx&mkt=3Den-us=

--_734ca61f-a1a8-4433-bc40-8b70cec42b34_
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
<body class=3D'hmmessage'>


<blockquote><meta name=3D"Generator" content=3D"Microsoft SafeHTML">
<style>
.ExternalClass .EC_hmmessage P
{padding:0px;}
.ExternalClass body.EC_hmmessage
{font-size:10pt;font-family:Tahoma;}
</style>


<blockquote> <style>
.ExternalClass EC_ExternalClass .EC_EC_hmmessage P
{padding:0px;}
.ExternalClass body.EC_hmmessage
{font-size:10pt;font-family:Tahoma;}
</style>


<blockquote><style>
.ExternalClass .EC_hmmessage P
{padding:0px;}
</style>Dear Sir,<br><br>I'm modifying bluez-libs and bluez-utils (i'm usin=
g
3.9 version) to introduce new pdu relating to registration, request and
response of new services.<br>For example&nbsp; i'm adding new pdu types, de=
fining them into&nbsp; bluez-libs-3.9/include/sdp.h <br><br># define SDP_NE=
W_REGISTER_REQ 0x85<br><br>But
during debugging I returned errno =3D EINVAL (set by sdp_device_record_regi=
ster_binary written in sdp.c ) and the sdp daemon log file&nbsp;
gets the following result: <br><br>Jun 25 21:26:31 pinta-desktop hcid[4967]=
: Unknown PDU ID : 0x85 received <br>(i thintk it's a message sent from fun=
ction process_request
written in bluez_utils_3.9/sdpd/request.c )<br> <br>How can i accept new ty=
pes of pdu declared?<br>Is
there a way to debug sdp daemon alternative to log file, for example
using gdb o using particular options in ./configure command? I tried
using --enable-debug option for configure and launching gdb, but they
don't work.<br><br><br>Thanks for your support and sorry for my english.<br=
><br>Best Regards,<br>Carlo M.</blockquote></blockquote><a href=3D"http://i=
magine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&amp;source=3D=
wlmailtagline" target=3D"_blank"> </a>
</blockquote><br /><hr />Invite your mail contacts to join your friends lis=
t with Windows Live Spaces. It's easy! <a href=3D'http://spaces.live.com/sp=
acesapi.aspx?wx_action=3Dcreate&wx_url=3D/friends.aspx&mkt=3Den-us' target=
=3D'_new'>Try it!</a></body>
</html>=

--_734ca61f-a1a8-4433-bc40-8b70cec42b34_--


--===============1895806975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1895806975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1895806975==--

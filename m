Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU120-W31FBA90BA2C2FBD7924E54A6A30@phx.gbl>
From: Carlo Giuseppe Monaco <carlogmonaco@hotmail.it>
To: <bluez-devel@lists.sourceforge.net>
Date: Thu, 26 Jun 2008 15:22:44 +0200
In-Reply-To: <a1c657a80806252303p2563497fs70b548dbbe4f3388@mail.gmail.com>
References: <a1c657a80806252303p2563497fs70b548dbbe4f3388@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1569693557=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1569693557==
Content-Type: multipart/alternative;
	boundary="_599a52ea-7ab8-4a97-924b-61d740a654f6_"

--_599a52ea-7ab8-4a97-924b-61d740a654f6_
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
during debugging I returned errno =3D EINVAL (in function process_request
written in bluez_utils_3.9/sdpd/request.c )and the sdp daemon log file=20
gets the following result:=20

Jun 25 21:26:31 pinta-desktop hcid[4967]: Unknown PDU ID : 0x85 received
=20
How can i accept new types of pdu declared?
Is
there a way to debug sdp daemon alternative to log file, for example
using gdb o using particular options in ./configure command? I tried
using --enable-debug option for configure and launching gdb, but they
don't work.


Thanks for your support and sorry for my english.

Best Regards,
Carlo M.


_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=

--_599a52ea-7ab8-4a97-924b-61d740a654f6_
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
<blockquote> <style>ExternalClass .EC_hmmessage P
{padding:0px;}
.ExternalClass body.EC_hmmessage
{font-size:10pt;font-family:Tahoma;}
</style>


<blockquote><style>.ExternalClass .EC_hmmessage P
{padding:0px;}
</style>Dear Sir,<br><br>I'm modifying bluez-libs and bluez-utils (i'm usin=
g
3.9 version) to introduce new pdu relating to registration, request and
response of new services.<br>For example&nbsp; i'm adding new pdu types, de=
fining them into&nbsp; bluez-libs-3.9/include/sdp.h <br><br># define SDP_NE=
W_REGISTER_REQ 0x85<br><br>But
during debugging I returned errno =3D EINVAL (in function process_request
written in bluez_utils_3.9/sdpd/request.c )and the sdp daemon log file&nbsp=
;
gets the following result: <br><br>Jun 25 21:26:31 pinta-desktop hcid[4967]=
: Unknown PDU ID : 0x85 received<br> <br>How can i accept new types of pdu =
declared?<br>Is
there a way to debug sdp daemon alternative to log file, for example
using gdb o using particular options in ./configure command? I tried
using --enable-debug option for configure and launching gdb, but they
don't work.<br><br><br>Thanks for your support and sorry for my english.<br=
><br>Best Regards,<br>Carlo M.</blockquote><a href=3D"http://www.live.com/g=
etstarted.aspx%20" target=3D"_blank"><br></a>
</blockquote><br /><hr />Connect to the next generation of MSN Messenger=A0=
  <a href=3D'http://imagine-msn.com/messenger/launch80/default.aspx?locale=
=3Den-us&source=3Dwlmailtagline' target=3D'_new'>Get it now! </a></body>
</html>=

--_599a52ea-7ab8-4a97-924b-61d740a654f6_--


--===============1569693557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1569693557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1569693557==--

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W27ED8AC7D297D3969CA322F0060@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 9 Jul 2007 12:34:17 +0000
MIME-Version: 1.0
Subject: Re: [Bluez-users] configure: error: Bluetooth library is required
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0286480531=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0286480531==
Content-Type: multipart/alternative;
	boundary="_6a25a44e-c268-4f50-a670-b0cd0d8ff088_"

--_6a25a44e-c268-4f50-a670-b0cd0d8ff088_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thank you Mats,
=20
I ran the commands that you gave me and they appeared to run ok, and when i=
 ls the /usr/local/bluetooth/ folder it displays the following files:
=20
bluetooth.h  bnep.h  cmtp.h  hci.h  hci_lib.h  hidp.h  l2cap.h  rfcomm.h  s=
co.h  sdp.h  sdp_lib.h
However, i still get this error when using the configure :-s it really is m=
ost odd. I notice in your last mail that you mention the static and shared =
libraries, i'm not sure if this is of any use, but here is a little more in=
formation from my ./configure on the utils, notice it says build static ...=
 no? is that normal?
=20
checking whether to build shared libraries... yeschecking whether to build =
static libraries... noconfigure: creating libtoolchecking for ppoll... noch=
ecking for pkg-config... nochecking for BLUEZ... configure: error: Bluetoot=
h library is required
Thanks for all your help on this mats, I'm sure we're getting closer,
=20
Thanks,
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalised homepage with all the things you car=
e about in one place.
http://www.live.com/?mkt=3Den-gb  =

--_6a25a44e-c268-4f50-a670-b0cd0d8ff088_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
P
{
margin:0px;
padding:0px
}
body
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body>Thank you Mats,<BR>
&nbsp;<BR>
I ran the commands that you gave me and they appeared to run ok, and when i=
 ls the /usr/local/bluetooth/ folder it displays the following files:<BR>
&nbsp;<BR>
bluetooth.h&nbsp; bnep.h&nbsp; cmtp.h&nbsp; hci.h&nbsp; hci_lib.h&nbsp; hid=
p.h&nbsp; l2cap.h&nbsp; rfcomm.h&nbsp; sco.h&nbsp; sdp.h&nbsp; sdp_lib.h<BR=
><BR>
However, i still get this error when using the configure :-s it really is m=
ost odd. I notice in your last mail that you mention the static and shared =
libraries, i'm not sure if this is of any use, but here is a little more in=
formation from my ./configure on the utils, notice it says build static ...=
 no? is that normal?<BR>
&nbsp;<BR>
checking whether to build shared libraries... yes<BR>checking whether to bu=
ild static libraries... no<BR>configure: creating libtool<BR>checking for p=
poll... no<BR>checking for pkg-config... no<BR>checking for BLUEZ... config=
ure: error: Bluetooth library is required<BR><BR>
Thanks for all your help on this mats, I'm sure we're getting closer,<BR>
&nbsp;<BR>
Thanks,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />Are you the Quizmaster?  <a href=3D'http://specials.uk.m=
sn.com/brainbattle' target=3D'_new'>Play BrainBattle with a friend now! </a=
></body>
</html>=

--_6a25a44e-c268-4f50-a670-b0cd0d8ff088_--


--===============0286480531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0286480531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0286480531==--

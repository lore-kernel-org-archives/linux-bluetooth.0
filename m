Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W2144AB1EDD689C5C67C353F0600@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 2 Apr 2007 20:34:23 +0000
MIME-Version: 1.0
Subject: [Bluez-users] DBus API Version?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1671089449=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1671089449==
Content-Type: multipart/alternative;
	boundary="_584226b9-63e9-4e55-8f11-95d43d2eacb2_"

--_584226b9-63e9-4e55-8f11-95d43d2eacb2_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
I've finally managed to get my Dbus issues sort i think, i'm no longer gett=
ing those same error messages, the error i get now seems to be more 'code' =
related, so thought i'd come here for a little help. I'm still trying to ru=
n Marcels demo code from one of his presentations, it simple gets and sets =
the device name. But i get the following error.
=20
Traceback (most recent call last):File "test.py", line 4, in ?obj =3D bus.g=
et_object('org.bluez', '/org/bluez')AttributeError: SystemBus instance has =
no attribute 'get_object'
After speaking to one of the guys on a dbus list he seemed to think that pe=
rhaps the code i'm using isn't compatible with my dbus-python API as its un=
able to find the basic get_object method.
=20
Does anyone know why this might be? I'm using this http://packages.debian.o=
rg/stable/python/python2.3-dbus version of the python dbus api, all working=
 on python 2.3 which i've seen listed as the latest stable release.
=20
Thanks guys, i know i've been a pain with all this posting, the moment the =
damn code is working in its basic form i'm sure i'll be fine with it.
=20
Thanks,
=20
Rob=20
_________________________________________________________________
Try Live.com - your fast, personalized homepage with all the things you car=
e about in one place.
http://www.live.com/getstarted=

--_584226b9-63e9-4e55-8f11-95d43d2eacb2_
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
<body>Hello Guys,<BR>
&nbsp;<BR>
I've finally managed to get my Dbus issues sort i think, i'm no longer gett=
ing those same error messages, the error i get now seems to be more 'code' =
related, so thought i'd come here for a little help. I'm still trying to ru=
n Marcels demo code from one of his presentations, it simple gets and sets =
the device name. But i get the following error.<BR>
&nbsp;<BR>
Traceback (most recent call last):<BR>File "test.py", line 4, in ?<BR>obj =
=3D bus.<FONT face=3D"">get_object</FONT>('org.bluez', '/org/bluez')<BR>Att=
ributeError: SystemBus instance has no attribute 'get_object'<BR><BR>
After speaking to one of the guys on a dbus list he seemed to think that pe=
rhaps the code i'm using isn't compatible with my dbus-python&nbsp;API as i=
ts unable to find the basic get_object method.<BR>
&nbsp;<BR>
Does&nbsp;anyone know why this might be? I'm using&nbsp;this <A href=3D"htt=
p://packages.debian.org/stable/python/python2.3-dbus">http://packages.debia=
n.org/stable/python/python2.3-dbus</A>&nbsp;version of the python&nbsp;dbus=
 api, all working on python 2.3 which i've seen listed as the latest stable=
 release.<BR>
&nbsp;<BR>
Thanks guys, i know i've been a pain with all this posting, the moment the =
damn&nbsp;code is working in its basic form i'm sure i'll be fine with it.<=
BR>
&nbsp;<BR>
Thanks,<BR>
&nbsp;<BR>
Rob&nbsp;<BR><BR><br /><hr />Express yourself instantly with Windows Live M=
essenger, the future of MSN Messenger! <a href=3D'http://imagine-msn.com/me=
ssenger/launch/en-GB/' target=3D'_new'>Windows Live Messenger, the future o=
f MSN Messenger!</a></body>
</html>=

--_584226b9-63e9-4e55-8f11-95d43d2eacb2_--


--===============1671089449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1671089449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1671089449==--

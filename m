Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W69DF635E82A29A17B512DF00A0@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 27 Jun 2007 16:31:57 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Service Discovery Issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1104518834=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1104518834==
Content-Type: multipart/alternative;
	boundary="_7bfe8c27-f28e-4e18-acfa-a29d46360344_"

--_7bfe8c27-f28e-4e18-acfa-a29d46360344_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
I'm trying to use the DBUS API to query a device for a service using the ex=
ample python code from the WIKI documents:
=20
import dbus
bus =3D dbus.SystemBus();
obj =3D bus.get_object('org.bluez', '/org/bluez/hci0')
adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')
handles =3D adapter.GetRemoteServiceHandles('00:17:B0:A0:E7:09', 'opp')
for handle in handles:
print adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', handle)
=20
However when running this code i get the following error message displayed:
=20
  File "./test.py", line 13, in ?    print adapter.GetRemoteServiceRecordAs=
XML('00:17:B0:A0:E7:09', handle)  File "/var/lib/python-support/python2.4/d=
bus/proxies.py", line 169, in __call__    reply_message =3D self._connectio=
n.send_message_with_reply_and_block(message, timeout)dbus.DBusException: or=
g.bluez.Error.UnknownMethod: Method "GetRemoteServiceRecordAsXML" with sign=
ature "su" on interface "org.bluez.Adapter" doesn't exist
Do you have any ideas what might be causing this?
=20
Thanks guys,
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalised homepage with all the things you car=
e about in one place.
http://www.live.com/?mkt=3Den-gb  =

--_7bfe8c27-f28e-4e18-acfa-a29d46360344_
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
I'm trying to use the DBUS API to query a device for a service using the ex=
ample python code from the WIKI documents:<BR>
&nbsp;<BR><FONT size=3D1>
import dbus<BR>
bus =3D dbus.SystemBus();<BR>
obj =3D bus.get_object('org.bluez', '/org/bluez/hci0')<BR>
adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')<BR>
handles =3D adapter.GetRemoteServiceHandles('00:17:B0:A0:E7:09', '</FONT><F=
ONT face=3D"Courier New" size=3D1>opp</FONT><FONT face=3D"" size=3D1>')<BR>
for handle in handles</FONT><FONT face=3D"Courier New" size=3D1>:<BR></FONT=
><FONT size=3D1>
print adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', handle)<BR>
&nbsp;<BR>
However when running this code i get the following error message displayed:=
<BR>
&nbsp;<BR>
&nbsp; File "./test.py", line 13, in ?<BR>&nbsp;&nbsp;&nbsp; print adapter.=
GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', handle)<BR>&nbsp; File "/v=
ar/lib/python-support/python2.4/dbus/proxies.py", line 169, in __call__<BR>=
&nbsp;&nbsp;&nbsp; reply_message =3D self._connection.send_message_with_rep=
ly_and_block(message, timeout)<BR>dbus.DBusException: org.bluez.Error.Unkno=
wnMethod: Method "GetRemoteServiceRecordAsXML" with signature "su" on inter=
face "org.bluez.Adapter" doesn't exist<BR><BR>
Do you have any ideas what might be causing this?<BR>
&nbsp;<BR>
Thanks guys,<BR>
&nbsp;<BR>
Rob<BR></FONT><br /><hr />Are you the Quizmaster?  <a href=3D'http://specia=
ls.uk.msn.com/brainbattle' target=3D'_new'>Play BrainBattle with a friend n=
ow! </a></body>
</html>=

--_7bfe8c27-f28e-4e18-acfa-a29d46360344_--


--===============1104518834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1104518834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1104518834==--

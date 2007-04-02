Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W1057D97DDDA39F4D245DDFF0600@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 2 Apr 2007 09:00:11 +0000
MIME-Version: 1.0
Subject: Re: [Bluez-users] Pyhton - ImportError: No module named dbus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1485979816=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1485979816==
Content-Type: multipart/alternative;
	boundary="_f09355ec-068f-4b07-8f17-46f930618762_"

--_f09355ec-068f-4b07-8f17-46f930618762_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Another Update,
=20
I've now installed the latest versions i could find of all the software, in=
cluding.
=20
DBus 1.0.2
Dbus-Glib 0.72
Dbus-Python 0.80.2
Pyrex 0.9.5
=20
And i'm now getting a different error message.
=20
Introspect error: The name org.bluez was not provided by any .service files=
Traceback (most recent call last):  File "test.py", line 6, in ?    obj =3D=
 bus.get_object('org.bluez', manager.DefaultAdapter())  File "/usr/lib/pyth=
on2.4/site-packages/dbus/proxies.py", line 25, in __call__    ret =3D self.=
_proxy_method (*args, **keywords)  File "/usr/lib/python2.4/site-packages/d=
bus/proxies.py", line 102, in __call__    reply_message =3D self._connectio=
n.send_with_reply_and_block(message, timeout)  File "dbus_bindings.pyx", li=
ne 455, in dbus_bindings.Connection.send_with_reply_and_blockdbus_bindings.=
DBusException: The name org.bluez was not provided by any .service files
Thanks guys,
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalized homepage with all the things you car=
e about in one place.
http://www.live.com/getstarted=

--_f09355ec-068f-4b07-8f17-46f930618762_
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
<body>Another Update,<BR>
&nbsp;<BR>
I've now installed the latest versions i could find of all the software, in=
cluding.<BR>
&nbsp;<BR>
DBus 1.0.2<BR>
Dbus-Glib 0.72<BR>
Dbus-Python 0.80.2<BR>
Pyrex 0.9.5<BR>
&nbsp;<BR>
And i'm now getting a different error message.<BR>
&nbsp;<BR>
<BR>Introspect error: The name org.bluez was not provided by any .service f=
iles<BR>Traceback (most recent call last):<BR>&nbsp; File "test.py", line 6=
, in ?<BR>&nbsp;&nbsp;&nbsp; obj =3D bus.get_object('org.bluez', manager.De=
faultAdapter())<BR>&nbsp; File "/usr/lib/python2.4/site-packages/dbus/proxi=
es.py", line 25, in __call__<BR>&nbsp;&nbsp;&nbsp; ret =3D self._proxy_meth=
od (*args, **keywords)<BR>&nbsp; File "/usr/lib/python2.4/site-packages/dbu=
s/proxies.py", line 102, in __call__<BR>&nbsp;&nbsp;&nbsp; reply_message =
=3D self._connection.send_with_reply_and_block(message, timeout)<BR>&nbsp; =
File "<FONT face=3D"">dbus_bindings.pyx</FONT>", line 455, in dbus_bindings=
.Connection.send_with_reply_and_block<BR>dbus_bindings.DBusException: The n=
ame org.bluez was not provided by any .service files<BR><BR>
Thanks guys,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />With Live Spaces email straight to your blog. Upload jok=
es, photos and more. It's free! <a href=3D'http://specials.uk.msn.com/space=
s/default.aspx' target=3D'_new'>It's free!</a></body>
</html>=

--_f09355ec-068f-4b07-8f17-46f930618762_--


--===============1485979816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1485979816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1485979816==--

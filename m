Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W1D7E3D7B6E739304A4A46F0600@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 2 Apr 2007 10:09:15 +0000
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
Content-Type: multipart/mixed; boundary="===============0381903929=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0381903929==
Content-Type: multipart/alternative;
	boundary="_a536b9a9-2960-48df-b16f-06d8da5db03c_"

--_a536b9a9-2960-48df-b16f-06d8da5db03c_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Another update guys,
=20
I went back to the drawing board and reinstalled everything, Python 2.5, g-=
libs, pyrex and dbus-python, and all seemed to go fine, but i now get this =
error message when trying to run my file :-D
=20
/usr/local/lib/python2.5/site-packages/dbus/exceptions.py:8: RuntimeWarning=
: Python C API version mismatch for module _dbus_bindings: This Python has =
API version 1013, module _dbus_bindings has version 1012.  import _dbus_bin=
dingsTraceback (most recent call last):  File "test.py", line 3, in <module=
>    bus =3D dbus.SystemBus();  File "/usr/local/lib/python2.5/site-package=
s/dbus/_dbus.py", line 652, in __new__    private=3Dprivate)  File "/usr/lo=
cal/lib/python2.5/site-packages/dbus/_dbus.py", line 293, in __new__    mai=
nloop=3Dmainloop)dbus.DBusException: org.freedesktop.DBus.Error.NoServer: F=
ailed to connect to socket /var/run/dbus/system_bus_socket: Connection refu=
sed
If anyone has the slightest idea as to what is causing this problem i'd lov=
e to hear from you, if i had any hair i'd be tearing it out :-D
=20
Thanks,
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalized homepage with all the things you car=
e about in one place.
http://www.live.com/getstarted=

--_a536b9a9-2960-48df-b16f-06d8da5db03c_
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
<body>Another update guys,<BR>
&nbsp;<BR>
I went back to the drawing board and reinstalled everything, Python 2.5, g-=
libs, pyrex and dbus-python, and all seemed to go fine, but i now get this =
error message when trying to run my file :-D<BR>
&nbsp;<BR>
/usr/local/lib/python2.5/site-packages/dbus/exceptions.py:8: RuntimeWarning=
: Python C API version mismatch for module _dbus_bindings: This Python has =
API version 1013, module _dbus_bindings has version 1012.<BR>&nbsp; import =
_dbus_bindings<BR>Traceback (most recent call last):<BR>&nbsp; File "test.p=
y", line 3, in &lt;module&gt;<BR>&nbsp;&nbsp;&nbsp; bus =3D dbus.SystemBus(=
);<BR>&nbsp; File "/usr/local/lib/python2.5/site-packages/dbus/_dbus.py", l=
ine 652, in __new__<BR>&nbsp;&nbsp;&nbsp; private=3Dprivate)<BR>&nbsp; File=
 "/usr/local/lib/python2.5/site-packages/dbus/_dbus.py", line 293, in __new=
__<BR>&nbsp;&nbsp;&nbsp; mainloop=3Dmainloop)<BR>dbus.DBusException: org.fr=
eedesktop.DBus.Error.NoServer: Failed to connect to socket /var/run/dbus/sy=
stem_bus_socket: Connection refused<BR><BR>
If anyone has the slightest idea as to what is causing this problem i'd lov=
e to hear from you, if i had any hair i'd be tearing it out :-D<BR>
&nbsp;<BR>
Thanks,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />With Live Spaces email straight to your blog. Upload jok=
es, photos and more. It's free! <a href=3D'http://specials.uk.msn.com/space=
s/default.aspx' target=3D'_new'>It's free!</a></body>
</html>=

--_a536b9a9-2960-48df-b16f-06d8da5db03c_--


--===============0381903929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0381903929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0381903929==--

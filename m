Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W237E8945524E41C6D6D133F0610@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Sun, 1 Apr 2007 17:02:05 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Pyhton - ImportError: No module named dbus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0489267546=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0489267546==
Content-Type: multipart/alternative;
	boundary="_785c3890-08ea-4446-a2c8-e6cb008cfcf0_"

--_785c3890-08ea-4446-a2c8-e6cb008cfcf0_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Chaps,
=20
I took the Marcel's and started to try and play around with Python this aft=
ernoon. I've got the following code, from one of your tutorials i think Mar=
cel.
=20
#!/usr/bin/python
import dbus
bus =3D dbus.SystemBus();
obj =3D bus.get_object('org.bluez', '/org/bluez')
manager =3D dbus.Interface(obj,'org.bluez.Manager')
obj =3D bus.get_object('org.bluez', manager.DefaultAdapter())
adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')
print adapter.GetName()
adapter.SetName('My Bluetooth dongle')
=20
I have this file saved as 'test.py' which i then try and execute like 'pyth=
on test.py' from my shell, but it throws back the error 'ImportError: No mo=
dule named dbus'. I'm pretty sure this is nothing major, but being new to b=
oth python and dbus, i'm a little lost.
=20
Thanks guys,
=20
Rob
_________________________________________________________________
Try Live.com: where your online world comes together - with news, sports, w=
eather, and much more.
http://www.live.com/getstarted=

--_785c3890-08ea-4446-a2c8-e6cb008cfcf0_
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
<body><FONT size=3D3>Hello Chaps,</FONT><BR>
<FONT size=3D3></FONT>&nbsp;<BR>
<FONT size=3D3>I took the Marcel's and started to try and play around with =
Python this afternoon. I've got the following code, from one of your tutori=
als i think Marcel.</FONT><BR>
<FONT size=3D3></FONT>&nbsp;<BR><FONT size=3D1>
<FONT size=3D3>#!/usr/bin/python</FONT><BR>
<FONT size=3D3>import dbus</FONT><BR>
<FONT size=3D3>bus =3D dbus.SystemBus();</FONT><BR>
<FONT size=3D3>obj =3D bus.get_object('org.bluez', '/org/bluez')</FONT><BR>
<FONT size=3D3>manager =3D dbus.Interface(obj,'org.bluez.Manager')</FONT><B=
R>
<FONT size=3D3>obj =3D bus.get_object('org.bluez', manager.DefaultAdapter()=
)</FONT><BR>
<FONT size=3D3>adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')</FONT><=
BR>
<FONT size=3D3>print adapter.GetName()</FONT><BR>
<FONT size=3D3>adapter.SetName('My Bluetooth dongle')</FONT><BR>
<FONT size=3D3></FONT>&nbsp;<BR>
<FONT size=3D3>I have this file saved as 'test.py' which i then try and exe=
cute like 'python test.py' from my shell, but it throws back the error 'Imp=
ortError: No module named dbus'. I'm pretty sure this is nothing major, but=
 being new to both python and dbus, i'm a little lost.</FONT><BR>
<FONT size=3D3></FONT>&nbsp;<BR>
<FONT size=3D3>Thanks guys,</FONT><BR>
<FONT size=3D3></FONT>&nbsp;<BR>
<FONT size=3D3>Rob<BR></FONT><BR></FONT><br /><hr />Be one of the first to =
try Windows Live Mail. <a href=3D'http://ideas.live.co.uk/ProgramPage.aspx?=
versionId=3D5d21c51a-b161-4314-9b0e-4911fb2b2e6d&pageId=3D0' target=3D'_new=
'>Windows Live Mail.</a></body>
</html>=

--_785c3890-08ea-4446-a2c8-e6cb008cfcf0_--


--===============0489267546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0489267546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0489267546==--

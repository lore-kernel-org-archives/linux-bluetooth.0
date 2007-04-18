Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W50DD99F5B6C54741E366C6F0500@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 18 Apr 2007 08:11:52 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Listening For Signals
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1043241357=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1043241357==
Content-Type: multipart/alternative;
	boundary="_b6ab9737-5882-49b6-8052-ce669af6f71d_"

--_b6ab9737-5882-49b6-8052-ce669af6f71d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
I'm trying to listen for signals posted by the API, but I'm struggling to g=
et it working properly, here is the code i'm attempting to run at the momen=
t.
=20
#!/usr/bin/python
import dbus, signal, time
bus =3D dbus.SystemBus()
obj =3D bus.get_object('org.bluez', '/org/bluez')
obj =3D bus.get_object('org.bluez', '/org/bluez/hci0')
adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')
def remote_device_found(addr, class_, rssi):
print 'Device Found:', addr
adapter.connect_to_signal('RemoteDeviceFound', remote_device_found)
def main():
adapter.DiscoverDevices()
main()
=20
The code runs without error, but it doesn't print the found devices, what a=
m i missing?
=20
Thanks guys,
=20
Rob
_________________________________________________________________
Try Live.com: where your online world comes together - with news, sports, w=
eather, and much more.
http://www.live.com/getstarted=

--_b6ab9737-5882-49b6-8052-ce669af6f71d_
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
I'm trying to listen for signals posted by the API, but I'm struggling to g=
et it working properly, here is the code i'm attempting to run at the momen=
t.<BR>
&nbsp;<BR>
#!/usr/bin/python<BR>
import dbus, signal<FONT face=3D"Courier New">, time<BR></FONT>
bus =3D dbus.SystemBus()<BR>
obj =3D bus.get_object('org.bluez', '/org/bluez')<BR>
obj =3D bus.get_object('org.bluez', '/org/bluez/hci0')<BR>
adapter =3D dbus.Interface(obj, 'org.bluez.Adapter')<BR>
def remote_device_found(addr, class_, rssi):<BR><FONT face=3D"Courier New">
</FONT><FONT face=3D"Times New Roman">print '</FONT><FONT face=3D"Courier N=
ew">Device </FONT><FONT face=3D"Times New Roman">Found:', addr<BR>
adapter.connect_to_signal('RemoteDeviceFound', remote_device_found)<BR></FO=
NT><FONT face=3D"Courier New">
def main():<BR>
adapter.DiscoverDevices()<BR></FONT><FONT face=3D"Courier New" size=3D1>
<FONT size=3D2>main()</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT face=3D"" size=3D2>The code runs without error, but it doesn't print =
the found devices, what am i missing?</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Thanks guys,</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Rob</FONT><BR></FONT><br /><hr />Be one of the first to try =
Windows Live Mail. <a href=3D'http://ideas.live.co.uk/ProgramPage.aspx?vers=
ionId=3D5d21c51a-b161-4314-9b0e-4911fb2b2e6d&pageId=3D0' target=3D'_new'>Wi=
ndows Live Mail.</a></body>
</html>=

--_b6ab9737-5882-49b6-8052-ce669af6f71d_--


--===============1043241357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1043241357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1043241357==--

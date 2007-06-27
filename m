Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W10EBD65660A4371E5650A1F00A0@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 27 Jun 2007 18:26:43 +0000
MIME-Version: 1.0
Subject: Re: [Bluez-users] Service Discovery Issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0953422072=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0953422072==
Content-Type: multipart/alternative;
	boundary="_f641cc81-a498-40ea-85ee-e5bcb2c9c283_"

--_f641cc81-a498-40ea-85ee-e5bcb2c9c283_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Marcel,
=20
Thanks for the quick response.
=20
>> try wrapping the handle with dbus.Uint32() to get the right type.
I've tried wrapping that now so the line of code now looks like:
=20
print adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', dbus.Uint32(=
handle))
=20
But I get a different error this time around:
=20
AttributeError: 'module' object has no attribute 'Uint32'
I'm not too bothered if we're not able to get this XML version working, I j=
ust need a method of getting the channel/port from the device, which ever s=
olution is simplest and fastest.
=20
Thanks for your help Marcel,
=20
Rob
_________________________________________________________________
Feel like a local wherever you go with BackOfMyHand.com
http://www.backofmyhand.com=

--_f641cc81-a498-40ea-85ee-e5bcb2c9c283_
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
<body>Hello Marcel,<BR>
&nbsp;<BR>
Thanks for the quick response.<BR>
&nbsp;<BR>
&gt;&gt; try wrapping the handle with dbus.Uint32() to get the right type.<=
BR><BR>
I've tried wrapping that now so the line of code now looks like:<BR>
&nbsp;<BR><FONT size=3D1>
print adapter.GetRemoteServiceRecordAsXML('00:17:B0:A0:E7:09', </FONT><FONT=
 face=3D"Courier New" size=3D1>d</FONT><FONT face=3D"" size=3D1>bus.Uint32(=
handle</FONT><FONT face=3D"Courier New" size=3D1>)</FONT><FONT face=3D"" si=
ze=3D1>)</FONT><BR>
<FONT size=3D1></FONT>&nbsp;<BR>
<FONT size=3D1>But I get a different error this time around:</FONT><BR>
<FONT size=3D1></FONT>&nbsp;<BR>
<FONT face=3D"" size=3D1>AttributeError: 'module' object has no attribute '=
Uint32'<BR></FONT><BR>
<FONT face=3D"" size=3D1>I'm not too bothered if we're not able to get this=
 XML version working, I just need a method of getting the channel/port from=
 the device, which ever solution is simplest and fastest.</FONT><BR>
<FONT face=3D"" size=3D1></FONT>&nbsp;<BR>
<FONT face=3D"" size=3D1>Thanks for your help Marcel,</FONT><BR>
<FONT face=3D"" size=3D1></FONT>&nbsp;<BR>
<FONT face=3D"" size=3D1>Rob<BR></FONT><br /><hr />Email straight to your b=
log, upload jokes, photos and more.  <a href=3D'http://specials.uk.msn.com/=
spaces/default.aspx ' target=3D'_new'>Windows Live Spaces, it's FREE!</a></=
body>
</html>=

--_f641cc81-a498-40ea-85ee-e5bcb2c9c283_--


--===============0953422072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0953422072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0953422072==--

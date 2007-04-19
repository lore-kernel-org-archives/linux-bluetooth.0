Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W8A5D9430F86B9B51DEFEFF0570@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 19 Apr 2007 12:02:21 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Obex Push Channel
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0926235728=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0926235728==
Content-Type: multipart/alternative;
	boundary="_ebb60954-767c-4b7a-b32a-d7574616724d_"

--_ebb60954-767c-4b7a-b32a-d7574616724d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
I've managed to solve my device Inquiry woes with the Dbus API now, Its wor=
king a real charm. However I'm not a little confused as to how i can extrac=
t the channel/port from the results returned by
=20
result =3D adapter.GetRemoteServiceHandles("00:17:B0:A0:E7:09", "opp")
=20
When i Print result i just get something like [64112L] which as i understan=
d it is a dbus UInt32 array, but I have no idea what to do with this to get=
 my hands on the OPP channel or port number to be able to push a file to th=
e device.
=20
Can anyone give me advice on how to do this?
=20
Thanks allot for any help,
=20
Rob
_________________________________________________________________
Try Live.com: where your online world comes together - with news, sports, w=
eather, and much more.
http://www.live.com/getstarted=

--_ebb60954-767c-4b7a-b32a-d7574616724d_
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
I've managed to solve my device Inquiry woes with the Dbus API now, Its wor=
king a real charm. However I'm not a little confused as to how i can extrac=
t the channel/port from the results returned by<BR>
<FONT size=3D1>&nbsp;<BR>
<FONT size=3D2>result =3D adapter.GetRemoteServiceHandles("00:17:B0:A0:E7:0=
9", "opp")<BR>
<FONT size=3D2>&nbsp;<BR>
<FONT size=3D2>When i Print result i just get something like [64112L] which=
 as i understand it is a dbus UInt32 array, but I have no idea what to do w=
ith this to get my hands on the OPP channel or port number to be able to pu=
sh a file to the device.</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Can anyone give me advice on how to do this?</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT face=3D"" size=3D2>Thanks allot for any help,</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Rob</FONT><BR></FONT></FONT></FONT><br /><hr />With Live Spa=
ces email straight to your blog. Upload jokes, photos and more. It's free! =
<a href=3D'http://specials.uk.msn.com/spaces/default.aspx ' target=3D'_new'=
>It's free!</a></body>
</html>=

--_ebb60954-767c-4b7a-b32a-d7574616724d_--


--===============0926235728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0926235728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0926235728==--

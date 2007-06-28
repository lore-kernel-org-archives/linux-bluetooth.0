Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W1B22F7EE02594921509C3F0090@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 28 Jun 2007 16:26:23 +0000
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
Content-Type: multipart/mixed; boundary="===============0245524404=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0245524404==
Content-Type: multipart/alternative;
	boundary="_34eef4dc-13bb-4dad-adb7-fafa212410cc_"

--_34eef4dc-13bb-4dad-adb7-fafa212410cc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
=20
Thanks for getting back to me, you were correct to say that it is UInt32, H=
owever even with that implemented, we're then back to the original error me=
ssage again stating that the function doesn't exist, is it possible that I =
have a version of the API with that method missing? or it has perhaps been =
depreciated or renamed?
=20
However, the standard GetRemoteServiceRecord() method appears to be in the =
API and I can get that to return the byte array to me, unfortunately I have=
 no idea how to turn the byte array into anything useful for me to be able =
to extract the channel/port from, after speaking with quite a few people on=
 the python and dbus mailing lists they were all a little stumped too.
=20
I'd love to hear any more advice you can offer on either the XML or the Byt=
eArray methods,
=20
Thanks mate,
=20
Rob
_________________________________________________________________
The next generation of MSN Hotmail has arrived - Windows Live Hotmail
http://www.newhotmail.co.uk=

--_34eef4dc-13bb-4dad-adb7-fafa212410cc_
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
<body>Hi Marcel,<BR>
&nbsp;<BR>
Thanks for getting back to me, you were correct to say that it is UInt32, H=
owever even with that implemented, we're then back to the original error me=
ssage&nbsp;again stating that the function doesn't exist, is it possible th=
at I have a version of the API with that method missing? or it has perhaps =
been depreciated or renamed?<BR>
&nbsp;<BR>
However, the standard GetRemoteServiceRecord() method appears to be in the =
API and I can get that to return the byte array to me, unfortunately I have=
 no idea how to turn the byte array into anything useful for me to be able =
to extract the channel/port from, after speaking with quite a few people on=
 the python and dbus mailing lists they were all a little stumped too.<BR>
&nbsp;<BR>
I'd love to hear any more advice you can offer on either the XML or the Byt=
eArray methods,<BR>
&nbsp;<BR>
Thanks mate,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />Play Movie Mash-up and win  <a href=3D'https://www.movie=
mashup.co.uk' target=3D'_new'>BIG prizes! </a></body>
</html>=

--_34eef4dc-13bb-4dad-adb7-fafa212410cc_--


--===============0245524404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0245524404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0245524404==--

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W23476BE4A95129E0C076DBF0070@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Sun, 8 Jul 2007 16:52:34 +0000
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
Content-Type: multipart/mixed; boundary="===============1710223324=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1710223324==
Content-Type: multipart/alternative;
	boundary="_c14bd8b3-6228-4a5c-997d-43a12cbb7f72_"

--_c14bd8b3-6228-4a5c-997d-43a12cbb7f72_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks guys for your help on this so far,
=20
I've now tried the following command when configuring my utils:
=20
./configure --with-bluez=3D/usr/local/lib
=20
and
=20
./configure --with-bluez=3D/usr/local
And still come up against the same issue with the configuration telling me =
that it cannot find bluez, which really is bizarre and the make install for=
 the libs confirms where they have been install as /usr/local/lib.
=20
inside that directory i can see the folowing files:
=20
libbluetooth.so.2.7.0
libbluetooth.so.2
libbluetooth.a
libbluetooth.la
libbluetooth.so
=20
Is there anything missing? Any other ideas? I'm running debian and have apt=
-get which i used to use for this kind of thing, unfortunately the only rel=
ease of bluez i can find on there is a 3.7 and we really need to be working=
 with the latest build on this project. I believe there is some kind of svn=
 for the latest build on debian but i wasted a couple of hours trying to ge=
t that working with no luck.
=20
Thanks for any further advice guys,
=20
Rob
_________________________________________________________________
The next generation of MSN Hotmail has arrived - Windows Live Hotmail
http://www.newhotmail.co.uk=

--_c14bd8b3-6228-4a5c-997d-43a12cbb7f72_
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
<body>Thanks guys for your help on this so far,<BR>
&nbsp;<BR>
I've now tried the following command when configuring my utils:<BR>
&nbsp;<BR>
./configure --with-bluez=3D/usr/local/lib<BR>
&nbsp;<BR>
and<BR>
&nbsp;<BR>
./configure --with-bluez=3D/usr/local<BR><BR>
And still come up against the same issue with the configuration telling me =
that it cannot find bluez, which really is bizarre and the make install for=
 the libs confirms where they have been install as /usr/local/lib.<BR>
&nbsp;<BR>
inside that directory i can see the folowing files:<BR>
&nbsp;<BR>
libbluetooth.so.2.7.0<BR>
libbluetooth.so.2<BR>
libbluetooth.a<BR>
libbluetooth.la<BR>
libbluetooth.so<BR>
&nbsp;<BR>
Is there anything missing? Any other ideas? I'm running debian and&nbsp;hav=
e apt-get which i used to use for this kind of thing, unfortunately the onl=
y release of bluez i can find on there is a 3.7 and we really need to be wo=
rking with the latest build on this project. I believe there is some kind o=
f svn for the latest build on debian but i wasted a couple of hours trying =
to get that working with no luck.<BR>
&nbsp;<BR>
Thanks for any further advice guys,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />Play Movie Mash-up and win  <a href=3D'https://www.movie=
mashup.co.uk' target=3D'_new'>BIG prizes! </a></body>
</html>=

--_c14bd8b3-6228-4a5c-997d-43a12cbb7f72_--


--===============1710223324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1710223324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1710223324==--

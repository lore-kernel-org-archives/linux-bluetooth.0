Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W2777B5DBF6DAA26AA0CA9EF0010@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 6 Jul 2007 16:57:52 +0000
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
Content-Type: multipart/mixed; boundary="===============1275679593=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1275679593==
Content-Type: multipart/alternative;
	boundary="_f43b9bb2-8156-4f67-b8af-9093360e162d_"

--_f43b9bb2-8156-4f67-b8af-9093360e162d_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Just as an extra note, during the make install all the libs it says:
=20
Libraries have been installed in:   /usr/local/lib
If you ever happen to want to link against installed librariesin a given di=
rectory, LIBDIR, you must either use libtool, andspecify the full pathname =
of the library, or use the `-LLIBDIR'flag during linking and do at least on=
e of the following:   - add LIBDIR to the `LD_LIBRARY_PATH' environment var=
iable     during execution   - add LIBDIR to the `LD_RUN_PATH' environment =
variable     during linking   - use the `-Wl,--rpath -Wl,LIBDIR' linker fla=
g   - have your system administrator add LIBDIR to `/etc/ld.so.conf'
See any operating system documentation about shared libraries formore infor=
mation, such as the ld(1) and ld.so(8) manual pages.
And then when trying to configure my bluez utils i use
=20
./configure BLUEZ_LIBS=3D/usr/local/lib
=20
And i still get the same issue that it cannot find the bluetooth libraries.
=20
Thanks,
=20
Rob
_________________________________________________________________
100=92s of Music vouchers to be won with MSN Music
https://www.musicmashup.co.uk/index.html=

--_f43b9bb2-8156-4f67-b8af-9093360e162d_
Content-Type: text/html; charset="Windows-1252"
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
<body>Just as an extra note, during the make install all the libs it says:<=
BR>
&nbsp;<BR>
Libraries have been installed in:<BR>&nbsp;&nbsp; /usr/local/lib<BR>
If you ever happen to want to link against installed libraries<BR>in a give=
n directory, LIBDIR, you must either use libtool, and<BR>specify the full p=
athname of the library, or use the `-LLIBDIR'<BR>flag during linking and do=
 at least one of the following:<BR>&nbsp;&nbsp; - add LIBDIR to the `LD_LIB=
RARY_PATH' environment variable<BR>&nbsp;&nbsp;&nbsp;&nbsp; during executio=
n<BR>&nbsp;&nbsp; - add LIBDIR to the `LD_RUN_PATH' environment variable<BR=
>&nbsp;&nbsp;&nbsp;&nbsp; during linking<BR>&nbsp;&nbsp; - use the `-Wl,--r=
path -Wl,LIBDIR' linker flag<BR>&nbsp;&nbsp; - have your system administrat=
or add LIBDIR to `/etc/ld.so.conf'<BR>
See any operating system documentation about shared libraries for<BR>more i=
nformation, such as the ld(1) and ld.so(8) manual pages.<BR><BR>
And then when trying to configure my bluez utils i use<BR>
&nbsp;<BR>
./configure BLUEZ_LIBS=3D/usr/local/lib<BR>
&nbsp;<BR>
And i still get the same issue that it cannot find the bluetooth libraries.=
<BR>
&nbsp;<BR>
Thanks,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />The next generation of MSN Hotmail has arrived -  <a hre=
f=3D'http://www.newhotmail.co.uk' target=3D'_new'>Windows Live Hotmail</a><=
/body>
</html>=

--_f43b9bb2-8156-4f67-b8af-9093360e162d_--


--===============1275679593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1275679593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1275679593==--

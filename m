Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY114-W266FADABD770552606A55AD7AF0@phx.gbl>
From: Mikael Bengtsson <micke_b.b@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Wed, 3 Oct 2007 10:40:08 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] Problem detecting closed connection
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0274116202=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0274116202==
Content-Type: multipart/alternative;
	boundary="_9b3277a9-560e-453f-8b46-a0e30b142212_"

--_9b3277a9-560e-453f-8b46-a0e30b142212_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello!
=20
I have a problem detecting a device that has closed it's connection.
=20
The software I'm developing sends and receives data through sockets to a sl=
ave device. When I switch of the slave device I expect that send and receiv=
e should return the value 0, as in ordinary sockets programming for TCP and=
 UDP sockets. But instead send happily always returns a value which is bigg=
er than 0. Why? Shouldn't Bluetooth sockets behave the same way as ordinary=
 sockets? I have a quite old Bluez, version 2.15. Is there another way of d=
etecting closed connections?
=20
Regards:
-Mikael
_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=

--_9b3277a9-560e-453f-8b46-a0e30b142212_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Hello!<BR>
&nbsp;<BR>
I have a problem detecting a device that has closed it's connection.<BR>
&nbsp;<BR>
The software I'm developing sends and receives data through sockets to a sl=
ave device. When I switch of the slave device I expect that send and receiv=
e should return the value 0, as in ordinary sockets programming for TCP and=
 UDP sockets. But instead send happily always returns a value which is bigg=
er than 0. Why? Shouldn't Bluetooth sockets behave the same way as ordinary=
 sockets? I have a quite old Bluez, version 2.15. Is there another way of d=
etecting closed connections?<BR>
&nbsp;<BR>
Regards:<BR>
-Mikael<BR><br /><hr />Express yourself instantly with MSN Messenger! <a hr=
ef=3D'http://clk.atdmt.com/AVE/go/onm00200471ave/direct/01/' target=3D'_new=
'>MSN Messenger</a></body>
</html>=

--_9b3277a9-560e-453f-8b46-a0e30b142212_--


--===============0274116202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0274116202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0274116202==--

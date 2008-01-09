Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY114-W11FC5ABD9C41BFDB590860D7490@phx.gbl>
From: Mikael Bengtsson <micke_b.b@hotmail.com>
To: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>
Date: Wed, 9 Jan 2008 14:42:45 +0100
MIME-Version: 1.0
Subject: [Bluez-devel] Impossible to restart slave
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0315435970=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0315435970==
Content-Type: multipart/alternative;
	boundary="_4f8ea4b1-6404-4054-8169-2871f9730cb5_"

--_4f8ea4b1-6404-4054-8169-2871f9730cb5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I'm developing an application which has one master device and three slave d=
evices. The communication links are the following:
=20
Slave device 1: RFCOMM and SCO
Slave device 2: RFCOMM and SCO
Slave device 3: RFCOMM
=20
If for example slave device 3 should crash or other reason, the master shal=
l automatically try to restart it. But this seems impossible if the other d=
evices are up and running. If I then for example power-off slave device 2, =
slave device 3 will start immediately. Thereafter, when I power-on slave de=
vice 2 again, this device will start too and everything is up and running.
=20
I suspect that it is practically impossible to start slave device 3 since t=
here are 2 SCO connections up and running which consumes much bandwidth. Co=
uld this be the fact?
=20
Is it possible to use hold mode for slave device 2 for a short period of ti=
me until slave device 3 starts? What is the BlueZ command for that, I have =
only seen hci_park_mode.
=20
Another solution may be to close down one SCO connection for a short moment=
 and restart it after slave device 3 has started.
=20
Are there any other method which can be used?
_________________________________________________________________
Ladda ner hela Windows Live gratis och uppt=E4ck f=F6rdelarna!
http://get.live.com/ =

--_4f8ea4b1-6404-4054-8169-2871f9730cb5_
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
I'm developing an application which has one master device and three slave d=
evices. The communication links are the following:<BR>
&nbsp;<BR>
Slave device 1: RFCOMM and SCO<BR>
Slave device 2: RFCOMM and SCO<BR>
Slave device 3: RFCOMM<BR>
&nbsp;<BR>
If for example slave device&nbsp;3 should crash or other reason, the master=
 shall automatically try to restart it. But this seems impossible if the ot=
her devices are up and running. If I then for example power-off slave devic=
e 2, slave device 3 will start immediately. Thereafter, when I power-on sla=
ve device 2 again, this device will start too and everything is up and runn=
ing.<BR>
&nbsp;<BR>
I suspect that it is practically impossible to start slave device 3 since t=
here are 2 SCO connections up and running which consumes much bandwidth. Co=
uld this be the fact?<BR>
&nbsp;<BR>
Is it possible to use hold mode for slave device 2 for a short period of ti=
me until slave device 3 starts? What is the BlueZ command for that, I have =
only seen hci_park_mode.<BR>
&nbsp;<BR>
Another solution may be to close down one SCO connection for a short moment=
 and restart it after slave device 3 has started.<BR>
&nbsp;<BR>
Are there any other method which can be used?<BR><br /><hr />Sugen p=E5 att=
 bli tokk=E4r? H=E4r finns massor av singlar som k=E4nner likadant! <a href=
=3D'http://match.se.msn.com/channel/index.aspx?trackingid=3D1002952' target=
=3D'_new'>MSN Dejting</a></body>
</html>=

--_4f8ea4b1-6404-4054-8169-2871f9730cb5_--


--===============0315435970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0315435970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0315435970==--

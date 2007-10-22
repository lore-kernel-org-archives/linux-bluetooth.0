Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY102-W11B9C20DCF53865C058207F09A0@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 22 Oct 2007 09:44:07 +0000
MIME-Version: 1.0
Subject: [Bluez-users] DiscoveryStarted / DiscoveryComplete Signal Not Sent
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0630376665=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0630376665==
Content-Type: multipart/alternative;
	boundary="_f26f206b-5030-41c3-adb7-4dac90cf3c44_"

--_f26f206b-5030-41c3-adb7-4dac90cf3c44_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hey Guys,
=20
I'm using the D-Bus API for an application and have recently started playin=
g around with the periodic discovery process, however it seems that the Dis=
coveryStrarted and DiscoveryComplete signals are not sent at the beginning =
and end of each scan 'period'. Is this usual behaviour? I notice in the API=
 documentation there are two functions for start and end of a period scan, =
however these don't seem to run at the start and end of every period, only =
the entire scanning process, is that correct?
=20
It would be great to know when each scan starts and completes as I plan to =
use it to action a cleanup operation on variables and objects created durin=
g the scan process.
=20
Thanks for any information you can offer guys,
=20
Rob
_________________________________________________________________
100=92s of Music vouchers to be won with MSN Music
https://www.musicmashup.co.uk=

--_f26f206b-5030-41c3-adb7-4dac90cf3c44_
Content-Type: text/html; charset="Windows-1252"
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
<body class=3D'hmmessage'>Hey Guys,<BR>
&nbsp;<BR>
I'm using the D-Bus API for an application and have recently started playin=
g around with the periodic discovery process, however it seems that the Dis=
coveryStrarted and DiscoveryComplete signals are not sent at the beginning =
and end of each scan 'period'. Is this usual behaviour? I notice in the API=
 documentation there are two functions for start and end of a period scan, =
however these don't seem to run at the start and end of every period, only =
the entire scanning process, is that correct?<BR>
&nbsp;<BR>
It would be great to know when each scan starts and completes as I plan to =
use it to action a cleanup operation on variables and objects created durin=
g the scan process.<BR>
&nbsp;<BR>
Thanks for any information you can offer guys,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />The next generation of MSN Hotmail has arrived -  <a hre=
f=3D'http://www.newhotmail.co.uk' target=3D'_new'>Windows Live Hotmail</a><=
/body>
</html>=

--_f26f206b-5030-41c3-adb7-4dac90cf3c44_--


--===============0630376665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0630376665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0630376665==--

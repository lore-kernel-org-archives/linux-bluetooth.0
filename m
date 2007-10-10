Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY122-W50DCD42B80D0F4AF45DCA88A60@phx.gbl>
From: Jacob Miner <jacob_miner@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Tue, 9 Oct 2007 21:00:35 -0600
MIME-Version: 1.0
Subject: [Bluez-users] Can't connect OpenSuse 10.3 apple bluetooth keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0738200482=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0738200482==
Content-Type: multipart/alternative;
	boundary="_0db6a6e9-e2ca-4ae4-80ac-9cd5982d4edd_"

--_0db6a6e9-e2ca-4ae4-80ac-9cd5982d4edd_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi All,
=20
  I installed OpenSuse 10.3 on my HP zd8000 laptop.  My bluetooth device is=
 discovered as
"HP Integrated Bluetooth module" and the driver is hci_usb.  *Note I also t=
ried a Dlink BT-120 revision 4, and got the exact same behavior.
=20
I did the following:
=20
put apple keyboard into discovery mode=20
=20
1. ran in one terminal /usr/bin/passkey-agent 1234 00:0A:95:4A:FC:D0
2. then in another terminal ran hcitool cc 00:0A:95:4a:FC:D0
3. typed 1234 <enter> on apple keyboard
=20
the following is the output from hcidump -X -V.  So what is the deal?  the =
keyboard disconnects immediately...
=20
< HCI Command: Create Connection (0x01|0x0005) plen 13
bdaddr 00:0A:95:4A:FC:D0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5=20
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
bdaddr 00:0A:95:4A:FC:D0
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
bdaddr 00:0A:95:4A:FC:D0 len 4 pin '1234'
> HCI Event: Command Complete (0x0e) plen 10
PIN Code Request Reply (0x01|0x000d) ncmd 1
status 0x00 bdaddr 00:0A:95:4A:FC:D0
> HCI Event: Link Key Notification (0x18) plen 23
bdaddr 00:0A:95:4A:FC:D0 key 8C2741B6F8635F8D0AD9CA43CD1A7EF8 type 0
Type: Combination Key
> HCI Event: Connect Complete (0x03) plen 11
status 0x00 handle 6 bdaddr 00:0A:95:4A:FC:D0 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
handle 6
> HCI Event: Command Status (0x0f) plen 4
Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
handle 6 policy 0x0f
Link policy: RSWITCH HOLD SNIFF PARK=20
> HCI Event: Command Complete (0x0e) plen 6
Write Link Policy Settings (0x02|0x000d) ncmd 1
status 0x00 handle 6
> HCI Event: Read Remote Supported Features (0x0b) plen 11
status 0x00 handle 6
Features: 0xbc 0x02 0x04 0x00 0x08 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
bdaddr 00:0A:95:4A:FC:D0 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
status 0x00 bdaddr 00:0A:95:4A:FC:D0 name 'jkbd'
< HCI Command: Disconnect (0x01|0x0006) plen 3
handle 6 reason 0x13
Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
status 0x00 handle 6 reason 0x16
Reason: Connection Terminated by Local Host
=20
Any Ideas, any help greatly appreciated!
=20
=20
-=3D[ Jake ]=3D-
_________________________________________________________________
Windows Live Hotmail and Microsoft Office Outlook =96 together at last. =A0=
Get it now.
http://office.microsoft.com/en-us/outlook/HA102225181033.aspx?pid=3DCL10062=
6971033=

--_0db6a6e9-e2ca-4ae4-80ac-9cd5982d4edd_
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
<body class=3D'hmmessage'>Hi All,<BR>
&nbsp;<BR>
&nbsp; I installed OpenSuse 10.3 on my HP zd8000 laptop.&nbsp; My bluetooth=
 device is discovered as<BR>
"HP Integrated Bluetooth module" and the driver is hci_usb.&nbsp; *Note I a=
lso tried a Dlink BT-120 revision 4, and got the exact same behavior.<BR>
&nbsp;<BR>
I did the following:<BR>
&nbsp;<BR>
put apple keyboard into discovery mode <BR>
&nbsp;<BR>
1. ran in one terminal /usr/bin/passkey-agent 1234 00:0A:95:4A:FC:D0<BR>
2. then in another terminal ran hcitool cc 00:0A:95:4a:FC:D0<BR>
3. typed 1234 &lt;enter&gt; on apple keyboard<BR>
&nbsp;<BR>
the following is the output from hcidump -X -V.&nbsp; So what is the deal?&=
nbsp; the keyboard disconnects immediately...<BR>
&nbsp;<BR><FONT size=3D2>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<BR>
bdaddr 00:0A:95:4A:FC:D0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000<BR>
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 <BR>
&gt; HCI Event: Command Status (0x0f) plen 4<BR>
Create Connection (0x01|0x0005) status 0x00 ncmd 1<BR>
&gt; HCI Event: PIN Code Request (0x16) plen 6<BR>
bdaddr 00:0A:95:4A:FC:D0<BR>
&lt; HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23<BR>
bdaddr 00:0A:95:4A:FC:D0 len 4 pin '1234'<BR>
&gt; HCI Event: Command Complete (0x0e) plen 10<BR>
PIN Code Request Reply (0x01|0x000d) ncmd 1<BR>
status 0x00 bdaddr 00:0A:95:4A:FC:D0<BR>
&gt; HCI Event: Link Key Notification (0x18) plen 23<BR>
bdaddr 00:0A:95:4A:FC:D0 key 8C2741B6F8635F8D0AD9CA43CD1A7EF8 type 0<BR>
Type: Combination Key<BR>
&gt; HCI Event: Connect Complete (0x03) plen 11<BR>
status 0x00 handle 6 bdaddr 00:0A:95:4A:FC:D0 type ACL encrypt 0x00<BR>
&lt; HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2<BR>
handle 6<BR>
&gt; HCI Event: Command Status (0x0f) plen 4<BR>
Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1<BR>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<BR>
handle 6 policy 0x0f<BR>
Link policy: RSWITCH HOLD SNIFF PARK <BR>
&gt; HCI Event: Command Complete (0x0e) plen 6<BR>
Write Link Policy Settings (0x02|0x000d) ncmd 1<BR>
status 0x00 handle 6<BR>
&gt; HCI Event: Read Remote Supported Features (0x0b) plen 11<BR>
status 0x00 handle 6<BR>
Features: 0xbc 0x02 0x04 0x00 0x08 0x00 0x00 0x00<BR>
&lt; HCI Command: Remote Name Request (0x01|0x0019) plen 10<BR>
bdaddr 00:0A:95:4A:FC:D0 mode 2 clkoffset 0x0000<BR>
&gt; HCI Event: Command Status (0x0f) plen 4<BR>
Remote Name Request (0x01|0x0019) status 0x00 ncmd 1<BR>
&gt; HCI Event: Remote Name Req Complete (0x07) plen 255<BR>
status 0x00 bdaddr 00:0A:95:4A:FC:D0 name 'jkbd'<BR>
&lt; HCI Command: Disconnect (0x01|0x0006) plen 3<BR>
handle 6 reason 0x13<BR>
Reason: Remote User Terminated Connection<BR>
&gt; HCI Event: Command Status (0x0f) plen 4<BR>
Disconnect (0x01|0x0006) status 0x00 ncmd 1<BR>
&gt; HCI Event: Disconn Complete (0x05) plen 4<BR>
status 0x00 handle 6 reason 0x16<BR>
Reason: Connection Terminated by Local Host<BR>
&nbsp;<BR>
</FONT>Any Ideas, any help greatly appreciated!<BR>
&nbsp;<BR>
&nbsp;<BR>
<BR><BR>-=3D[&nbsp;Jake&nbsp;]=3D-<BR><BR><br /><hr />Windows Live Hotmail =
and Microsoft Office Outlook =96 together at last. <a href=3D'http://office=
.microsoft.com/en-us/outlook/HA102225181033.aspx?pid=3DCL100626971033' targ=
et=3D'_new'>Get it now!</a></body>
</html>=

--_0db6a6e9-e2ca-4ae4-80ac-9cd5982d4edd_--


--===============0738200482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0738200482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0738200482==--

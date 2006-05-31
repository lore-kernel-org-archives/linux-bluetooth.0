Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <447E0B1B.1010100@gnunux.info>
Date: Wed, 31 May 2006 23:31:07 +0200
From: Emmanuel GARETTE <gnunux@gnunux.info>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Can't create HID control channel: Connection refused
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1465390879=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1465390879==
Content-Type: multipart/alternative;
	boundary="------------040304050007010008040603"

This is a multi-part message in MIME format.
--------------040304050007010008040603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm using bluez stack in maemo 
(http://770.fs-security.com/maemo-bt-plugin/). I've bought a Com one 
KB600's keyboard.

When I scan, I can see my device :

// # hcitool scan
Scanning ...
        00:0A:3A:32:97:11       KEYBOARD
/
I have information from this device :

// # hcitool info 00:0A:3A:32:97:11
Requesting information ...
        BD Address:  00:0A:3A:32:97:11
        Device Name: KEYBOARD
        LMP Version: 1.1 (0x1) LMP Subversion: 0x2c2
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbc 0x06 0x07 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role 
switch>                <sniff mode> <RSSI> <channel quality> <CVSD> 
<paging scheme>                <power control>
/
I can ping it :

// # l2ping -c 2 00:0A:3A:32:97:11
Ping: 00:0A:3A:32:97:11 from 08:00:28:45:55:BB (data size 20) ...
44 bytes from 00:0A:3A:32:97:11 id 0 time 67.57ms
44 bytes from 00:0A:3A:32:97:11 id 1 time 30.91ms
2 sent, 2 received, 0% loss
/
But i can't connect to it :

// # hidd --connect 00:0A:3A:32:97:11
Can't create HID control channel: Connection refused
/
What "Connection refused" refered to ? How to solve this problem ?

Regards.

--------------040304050007010008040603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I'm using bluez stack in maemo
(<a class="moz-txt-link-freetext" href="http://770.fs-security.com/maemo-bt-plugin/">http://770.fs-security.com/maemo-bt-plugin/</a>). I've bought a Com one
KB600's keyboard.<br>
<br>
When I scan, I can see my device :<br>
<br>
<i>/ # hcitool scan<br>
Scanning ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:0A:3A:32:97:11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KEYBOARD<br>
</i><br>
I have information from this device :<br>
<br>
<i>/ # hcitool info 00:0A:3A:32:97:11<br>
Requesting information ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0A:3A:32:97:11<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: KEYBOARD<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x2c2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbc 0x06 0x07 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing
accuracy&gt; &lt;role switch&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;sniff mode&gt;
&lt;RSSI&gt; &lt;channel quality&gt; &lt;CVSD&gt; &lt;paging
scheme&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt;<br>
</i><br>
I can ping it :<br>
<br>
<i>/ # l2ping -c 2 00:0A:3A:32:97:11<br>
Ping: 00:0A:3A:32:97:11 from 08:00:28:45:55:BB (data size 20) ...<br>
44 bytes from 00:0A:3A:32:97:11 id 0 time 67.57ms<br>
44 bytes from 00:0A:3A:32:97:11 id 1 time 30.91ms<br>
2 sent, 2 received, 0% loss<br>
</i><br>
But i can't connect to it :<br>
<br>
<i>/ # hidd --connect 00:0A:3A:32:97:11<br>
Can't create HID control channel: Connection refused<br>
</i><br>
What "Connection refused" refered to ? How to solve this problem ?<br>
<br>
Regards.<br>
</body>
</html>

--------------040304050007010008040603--


--===============1465390879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1465390879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1465390879==--

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40FE8D68.9040007@nokia.com>
From: Thomas Luby <thomas.luby@nokia.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/html; charset=us-ascii
Subject: [Bluez-users] Serial connection between two Linux machines
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 21 Jul 2004 18:36:08 +0300

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1">Hi<br>
<br>
I have two Linux machines. I wish to connect to one from the other
using a terminal over Bluetooth<br>
<br>
The problem I have is annoying because it basically works. Anyway, here
is the problem<br>
<br>
Master (USB bluetooth):<br>
<br>
modprobe hci_usb<br>
hciconfig hci0 up<br>
hciconfig<br>
<br>
mknod -m 666 /dev/rfcomm0 c 216 0<br>
rfcomm bind 0 00:60:57:18:FB:6E 1<br>
<br>
Slave (UART bluetooth):<br>
<br>
hciattach /dev/ttyS0 -s 115200 csr<br>
hciconfig hci0 up<br>
hcid<br>
dund --persist --listen<br>
sdpd<br>
sdptool add SP --channel=1<br>
<br>
<br>
I open a terminal on the master. A connection is present.<br>
<br>
I type echo "Hello" &gt; /dev/bluetooth/rfcomm/0<br>
<br>
and on the master terminal I see "Hello"<br>
<br>
And this is where the problem comes. If I repeat the echo, I get:<br>
cannot create /dev/rfcomm0: No such device<br>
<br>
because the connection was closed<br>
<br>
I have sent huge files down the link with no problem...but when it
reaches the end of the file, the connection closes everytime!<br>
<br>
If anyone knows what Im doing wrong I would appreciate it! I have
searched for 2 days now and not managed to find the solution<br>
<br>
Regards<br>
<br>
Tom<br>
<br>
</font>
</body>
</html>


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

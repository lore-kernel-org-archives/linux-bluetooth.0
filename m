Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Date: Fri, 15 Jun 2007 17:44:36 +0100
Message-Id: <1181925876.31424.326.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] HID initiated connections and input service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Heya,

(As promised to Claudio)

2(3) HID devices I own have the same problem with BlueZ when using the
input service. Both use HID initiated connections, rather than the Host
initiated connection use case you would see when addind a Bluetooth
mouse to a laptop for example.

* First device: Logitech MX5000 mouse/keyboard combo

When not switched into HCI mode, the device works as a normal USB HID.
On boot, hid2hci is run, and the 2 devices (mouse and keyboard) try to
connect to bluetooth dongle (ex-USB wireless dongle).
There's no bluetooth-applet, or other services, and the requests are
dropped to the floor, and I end up with a Bluetooth HCI device, and no
keyboard or mouse (unplug/replug "fixes" the problem though).

Could we integrate hid2hci into the input service, so that it would only
be started when a session is available? I'm not sure how to handle the
pairing without a keyboard or mouse though...

* Second device: Sixaxis PS3 Bluetooth joypad

Again, 2 connections modes. Firstly, there's no pairing, the joypad
knows about the computer when one runs sixpair when the pad is connected
via USB, as per:
http://www.pabr.org/sixlinux/sixlinux.en.html
(Marcel talked about integrating this with udev, which should be pretty
straight forward)

Once disconnected from USB, and turned on, the device will try to
connect to the computer. bluetooth-applet will request auth, and ask us
whether we want to allow the connection. But as the device was never
discovered/setup using CreateDevice, the get_store_device_info in
input/server.c will fail.

You can't use CreateDevice with the device, as it's either connecting to
our computer, or off, and connection requests will fail.

Any idea on how to handle those type of devices using the Input Service
and giving good user experience?

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1181925876.31424.326.camel@cookie.hadess.net>
References: <1181925876.31424.326.camel@cookie.hadess.net>
Date: Sat, 16 Jun 2007 09:25:54 +0200
Message-Id: <1181978755.6846.46.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] HID initiated connections and input service
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

Hi Bastien,

> 2(3) HID devices I own have the same problem with BlueZ when using the
> input service. Both use HID initiated connections, rather than the
> Host
> initiated connection use case you would see when addind a Bluetooth
> mouse to a laptop for example.
> 
> * First device: Logitech MX5000 mouse/keyboard combo
> 
> When not switched into HCI mode, the device works as a normal USB HID.
> On boot, hid2hci is run, and the 2 devices (mouse and keyboard) try to
> connect to bluetooth dongle (ex-USB wireless dongle).
> There's no bluetooth-applet, or other services, and the requests are
> dropped to the floor, and I end up with a Bluetooth HCI device, and no
> keyboard or mouse (unplug/replug "fixes" the problem though).
> 
> Could we integrate hid2hci into the input service, so that it would only
> be started when a session is available? I'm not sure how to handle the
> pairing without a keyboard or mouse though...

after catching up with the IRC, I realized another problem with this HID
proxy dongles. We can fix that for the original firmwares from CSR that
are used by Apple, but for the Logitech's (they are slightly modified) I
am not sure.

So when you switch a HID proxy dongle from HID mode into HCI, you have
to read its information about stored devices and their link keys. These
information have then to be put into /var/lib/bluetooth. This leaves out
the HID report descriptor that we also need. So that needs to be gotten
while it is still in USB mode.

Getting the HID report descriptor over USB makes always the assumption
that it is exactly the same as on Bluetooth. This should be checked.

We can't use 2 L2CAP connections and SDP at the same time, because some
devices are limited of the maximum L2CAP connection. If the HID report
descriptors are different then this is all becomes a little bit more
trickier. In general it is possible since you first have to disconnect
the interrupt channel of HID and then do SDP and re-connect it. If I
remember the specification correctly, this should work.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

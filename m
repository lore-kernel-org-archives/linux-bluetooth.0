Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can only start Bluetooth once on my Sony
	Picturebook
From: Marcel Holtmann <marcel@holtmann.org>
To: tim@birdsnest.maths.tcd.ie
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405101325.18922.tim@birdsnest.maths.tcd.ie>
References: <200405101325.18922.tim@birdsnest.maths.tcd.ie>
Content-Type: multipart/mixed; boundary="=-7gKLN9Wo0sAsk8Pg+ce4"
Message-Id: <1084193820.4017.25.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 10 May 2004 14:57:00 +0200


--=-7gKLN9Wo0sAsk8Pg+ce4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Timothy,

> A little query which does not really matter,
> but which leaves me slightly puzzled.
> 
> I'm running linux-2.6.6-rc2 under Fedora-1
> on my Sony C1VFK Picturebook.
> This has in-built Bluetooth.
> To start this running, I say "spicctrl -l1"
> (when the blue Bluetooth light on my laptop comes on)
> followed by "service bluetooth restart".
> 
> All this works perfectly.
> But if I give the command "spicctrl -l0"
> to stop the inbuilt Bluetooth
> I am never able to restart it,
> except by re-booting.
> 
> I couldn't see from a very brief (and ignorant) look at the source
> why the sonypi_ioctl() call couldn't be reversed.
> 
> Perhaps there is some command I could give
> to restart Bluetooth, short of re-booting?

you can keep every Bluetooth daemon running even if no device is
attached. They will re-init themself if you power-up your internal
Bluetooth device. What I think that happens is that the stopping with
spicctrl is the same as a physical unplug and this causes a kernel oops.
Check if you have CONFIG_BT_HCIUSB_SCO enabled, if yes, disable for now
or apply the attached patch.

Regards

Marcel


--=-7gKLN9Wo0sAsk8Pg+ce4
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/bluetooth/hci_usb.c 1.49 vs edited =====
--- 1.49/drivers/bluetooth/hci_usb.c	Sat Apr 17 00:23:48 2004
+++ edited/drivers/bluetooth/hci_usb.c	Mon May 10 12:03:05 2004
@@ -976,11 +971,13 @@
 static void hci_usb_disconnect(struct usb_interface *intf)
 {
 	struct hci_usb *husb = usb_get_intfdata(intf);
-	struct hci_dev *hdev = husb->hdev;
+	struct hci_dev *hdev;
 
-	if (!husb)
+	if (!husb || intf == husb->isoc_iface)
 		return;
+
 	usb_set_intfdata(intf, NULL);
+	hdev = husb->hdev;
 
 	BT_DBG("%s", hdev->name);
 

--=-7gKLN9Wo0sAsk8Pg+ce4--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

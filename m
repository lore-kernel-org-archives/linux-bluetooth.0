Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Oops in hci_usb
From: Marcel Holtmann <marcel@holtmann.org>
To: fd@cisco.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1083936143.8935.5.camel@metal.cisco.com>
References: <20040501173626.GA3866@kos.to>
	 <1083785352.4420.33.camel@pegasus> <20040506184816.GA7468@kos.to>
	 <200405062128.42044.cijoml@volny.cz>  <1083877415.4420.75.camel@pegasus>
	 <1083936143.8935.5.camel@metal.cisco.com>
Content-Type: multipart/mixed; boundary="=-wO/hYzGzif35h1lrp5Ip"
Message-Id: <1084195273.4017.34.camel@pegasus>
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
Date: Mon, 10 May 2004 15:21:14 +0200


--=-wO/hYzGzif35h1lrp5Ip
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Frederic

> I have those Oopses too with the Acer BT dongle (bt-600). Disabling SCO
> solves the problem.

try the attached patch if it solves the problem.

Regards

Marcel


--=-wO/hYzGzif35h1lrp5Ip
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
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
 

--=-wO/hYzGzif35h1lrp5Ip--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

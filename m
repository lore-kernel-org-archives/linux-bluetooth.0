Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [patch]removal of unnecessary ignore module parameter
Date: Wed, 6 Aug 2008 10:28:03 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808061028.04343.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This removes the ignore parameter, which is useless. There are alternate
methodes of kicking a driver off a usb device.

Signed-off-by: Oliver Neukum <oneukum@suse.de>

	Regards
		Oliver

---

--- linux-2.6.27-rc2/drivers/bluetooth/hci_usb.c.alt	2008-08-06 10:08:49.000000000 +0200
+++ linux-2.6.27-rc2/drivers/bluetooth/hci_usb.c	2008-08-06 10:25:06.000000000 +0200
@@ -62,7 +62,6 @@
 #define URB_ZERO_PACKET 0
 #endif
 
-static int ignore;
 static int ignore_dga;
 static int ignore_csr;
 static int ignore_sniffer;
@@ -801,7 +800,7 @@ static int hci_usb_probe(struct usb_inte
 			id = match;
 	}
 
-	if (ignore || id->driver_info & HCI_IGNORE)
+	if (id->driver_info & HCI_IGNORE)
 		return -ENODEV;
 
 	if (ignore_dga && id->driver_info & HCI_DIGIANSWER)
@@ -1108,9 +1107,6 @@ static void __exit hci_usb_exit(void)
 module_init(hci_usb_init);
 module_exit(hci_usb_exit);
 
-module_param(ignore, bool, 0644);
-MODULE_PARM_DESC(ignore, "Ignore devices from the matching table");
-
 module_param(ignore_dga, bool, 0644);
 MODULE_PARM_DESC(ignore_dga, "Ignore devices with id 08fd:0001");
 

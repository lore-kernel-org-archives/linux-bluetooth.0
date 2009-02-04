Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Feb 2009 13:52:13 +0000 (GMT)
From: Jamie Lentin <jm@lentin.co.uk>
To: marcel@holtmann.org
cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hci_usb: Add support for OQO Model 01+
Message-ID: <alpine.DEB.2.00.0902041341380.16577@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Add USB device ID for OQO 01+'s internal USB bluetooth

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

---

Whilst knowledge of the actual chipset is ropey (apparently manufactured 
by CSR), it seems to work fine. I've used pand, hidd & obexftp with no 
problems.

--- a/drivers/bluetooth/hci_usb.c       2009-02-04 12:34:40.000000000 
+0000
+++ b/drivers/bluetooth/hci_usb.c       2009-02-04 12:35:31.000000000 
+0000
@@ -97,6 +97,9 @@ static struct usb_device_id bluetooth_id
  	/* Canyon CN-BTU1 with HID interfaces */
  	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = HCI_RESET },

+	/* OQO Model 01+ internal bluetooth */
+	{ USB_DEVICE(0x1557, 0x0003) },
+
  	{ }     /* Terminating entry */
  };

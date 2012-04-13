Return-Path: <cyrus@holtmann.org>
From: Steven Harms <sjharms@gmail.com>
To: Steven Harms <sjharms@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Add bluetooth support for Foxconn - Hon Hai bluetooth usb present in Acer TimelineX AS4830TG-6808
Date: Fri, 13 Apr 2012 09:47:07 -0400
Message-Id: <1334324827-6017-1-git-send-email-sjharms@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Steven Harms <sjharms@gmail.com>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3311b81..7d7d614 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -107,6 +107,9 @@ static struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x0a5c, 0x21f3) },
 	{ USB_DEVICE(0x413c, 0x8197) },
 
+	/* Foxconn - Hon Hai */
+	{ USB_DEVICE(0x0489, 0xe033) },
+
 	{ }	/* Terminating entry */
 };
 
-- 
1.7.9.5

Return-Path: <cyrus@holtmann.org>
Message-ID: <4E7840CF.5010805@canonical.com>
Date: Tue, 20 Sep 2011 15:29:19 +0800
From: Jesse Sung <jesse.sung@canonical.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: 854399@bugs.launchpad.net
Subject: [PATCH] Bluetooth: Add support for Broadcom BCM20702A0.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new entry (413c:8197) to device ID table.

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
  drivers/bluetooth/btusb.c |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 91d13a9..d786bb8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -91,6 +91,9 @@ static struct usb_device_id btusb_table[] = {
  	/* Canyon CN-BTU1 with HID interfaces */
  	{ USB_DEVICE(0x0c10, 0x0000) },

+	/* Broadcom BCM20702A0 */
+	{ USB_DEVICE(0x413c, 0x8197) },
+
  	{ }	/* Terminating entry */
  };

-- 
1.7.6.3


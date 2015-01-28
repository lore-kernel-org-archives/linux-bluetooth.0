Return-Path: <cyrus@holtmann.org>
From: Adam Lee <adam.lee@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH] Bluetooth: ath3k: workaround the compatibility issue with xHCI controller
Date: Wed, 28 Jan 2015 14:52:32 -0500
Message-Id: <1422474752-26871-1-git-send-email-adam.lee@canonical.com>
List-ID: <linux-bluetooth.vger.kernel.org>

BugLink: https://bugs.launchpad.net/bugs/1400215

ath3k devices fail to load firmwares on xHCI buses, but work well on
EHCI, this might be a compatibility issue between xHCI and ath3k chips.
As my testing result, those chips will work on xHCI buses again with
this patch.

This workaround is from Qualcomm, they also did some workarounds in
Windows driver.

Signed-off-by: Adam Lee <adam.lee@canonical.com>
---
 drivers/bluetooth/ath3k.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 1ee27ac..98ae0b1 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -174,6 +174,7 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 #define USB_REQ_DFU_DNLOAD	1
 #define BULK_SIZE		4096
 #define FW_HDR_SIZE		20
+#define TIMEGAP_US		100
 
 static int ath3k_load_firmware(struct usb_device *udev,
 				const struct firmware *firmware)
@@ -205,6 +206,9 @@ static int ath3k_load_firmware(struct usb_device *udev,
 	pipe = usb_sndbulkpipe(udev, 0x02);
 
 	while (count) {
+		/* workaround the compatibility issue with xHCI controller*/
+		usleep_range(TIMEGAP_US - 50, TIMEGAP_US);
+
 		size = min_t(uint, count, BULK_SIZE);
 		memcpy(send_buf, firmware->data + sent, size);
 
@@ -302,6 +306,9 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 	pipe = usb_sndbulkpipe(udev, 0x02);
 
 	while (count) {
+		/* workaround the compatibility issue with xHCI controller*/
+		usleep_range(TIMEGAP_US - 50, TIMEGAP_US);
+
 		size = min_t(uint, count, BULK_SIZE);
 		memcpy(send_buf, firmware->data + sent, size);
 
-- 
2.1.4

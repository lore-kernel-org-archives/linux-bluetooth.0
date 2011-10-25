Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2] Bluetooth: ath3k: Use GFP_KERNEL instead of GFP_ATOMIC
Date: Tue, 25 Oct 2011 12:09:52 +0200
Message-Id: <1319537392-4993-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1319536194-4720-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319536194-4720-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are allowed to sleep here so no need to use GFP_ATOMIC. The caller
(ath3k_probe) calls request_firmware() which definitely sleeps. Hence, we should
avoid using GFP_ATOMIC.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
V2: This fixes both occurences of GFP_ATOMIC in one patch.

 drivers/bluetooth/ath3k.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index db7cb81..106beb1 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -105,7 +105,7 @@ static int ath3k_load_firmware(struct usb_device *udev,
 
 	pipe = usb_sndctrlpipe(udev, 0);
 
-	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
+	send_buf = kmalloc(BULK_SIZE, GFP_KERNEL);
 	if (!send_buf) {
 		BT_ERR("Can't allocate memory chunk for firmware");
 		return -ENOMEM;
@@ -176,7 +176,7 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 
 	count = firmware->size;
 
-	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
+	send_buf = kmalloc(BULK_SIZE, GFP_KERNEL);
 	if (!send_buf) {
 		BT_ERR("Can't allocate memory chunk for firmware");
 		return -ENOMEM;
-- 
1.7.7.1


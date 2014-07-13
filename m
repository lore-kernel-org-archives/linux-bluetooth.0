Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allocate struct inquiry_entry with GFP_KERNEL
Date: Sun, 13 Jul 2014 17:22:25 +0200
Message-Id: <1405264945-15164-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The allocation of inquiry cache entries is triggered as a result of
processing HCI events. Since the processing is done in the context
of a workqueue, there is no needed to allocate with GFP_ATOMIC in
that case. Switch it to GFP_KERNEL.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 188bfd3d7c43..172041e2b15a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2088,7 +2088,7 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 	}
 
 	/* Entry not in the cache. Add new one. */
-	ie = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
+	ie = kzalloc(sizeof(struct inquiry_entry), GFP_KERNEL);
 	if (!ie) {
 		flags |= MGMT_DEV_FOUND_CONFIRM_NAME;
 		goto done;
-- 
1.9.3


Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove redundant NULL check
Date: Tue, 25 Mar 2014 12:06:18 +0200
Message-Id: <1395741979-23319-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All callers of hci_inquiry_cache_update() pass a non-NULL ssp pointer to
it and even the function itself assumes in another place that the
pointer is non-NULL. Therefore, remove the redundant check.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bfc6f810554e..c6189d9b6c09 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2028,8 +2028,7 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 	hci_remove_remote_oob_data(hdev, &data->bdaddr);
 
-	if (ssp)
-		*ssp = data->ssp_mode;
+	*ssp = data->ssp_mode;
 
 	ie = hci_inquiry_cache_lookup(hdev, &data->bdaddr);
 	if (ie) {
-- 
1.8.5.3


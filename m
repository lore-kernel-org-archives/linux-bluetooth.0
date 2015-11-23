Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix returning proper HCI status from __hci_req_sync
Date: Mon, 23 Nov 2015 14:40:47 +0200
Message-Id: <1448282447-27618-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There were a couple of code paths missed by the previous patch that
added a HCI status return parameter to __hci_req_sync. This patch adds
the missing assignments for them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 76bd912be9fe..e639671f54bd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -220,8 +220,14 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		 * trigger any commands to be sent. This is normal behavior
 		 * and should not trigger an error return.
 		 */
-		if (err == -ENODATA)
+		if (err == -ENODATA) {
+			if (hci_status)
+				*hci_status = 0;
 			return 0;
+		}
+
+		if (hci_status)
+			*hci_status = HCI_ERROR_UNSPECIFIED;
 
 		return err;
 	}
-- 
2.5.0


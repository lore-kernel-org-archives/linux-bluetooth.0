Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/12] Bluetooth: Make __hci_update_background_scan private to hci_request.c
Date: Wed, 11 Nov 2015 08:11:22 +0200
Message-Id: <1447222287-4288-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
References: <1447222287-4288-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are no more external users so this API can be made private.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 2 +-
 net/bluetooth/hci_request.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c0ea310a116a..8aa06cc545c3 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -670,7 +670,7 @@ void hci_update_page_scan(struct hci_dev *hdev)
  *
  * This function requires the caller holds hdev->lock.
  */
-void __hci_update_background_scan(struct hci_request *req)
+static void __hci_update_background_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 8441d12a62dd..1f1194628652 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -64,8 +64,6 @@ void __hci_update_page_scan(struct hci_request *req);
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      u8 *own_addr_type);
 
-void __hci_update_background_scan(struct hci_request *req);
-
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
 		      u8 reason);
-- 
2.5.0


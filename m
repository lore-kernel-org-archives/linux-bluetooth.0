Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix BR/EDR Page Scan update with Add Device
Date: Wed, 11 Nov 2015 10:30:31 +0200
Message-Id: <1447230631-29973-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The recent changes to remove dependency on HCI in Add Device missed
out relevant changes for BR/EDR. This patch removes the left-overs and
ensures the right HCI command gets queued for BR/EDR.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8cdacef6b108..4fb5c3265adb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5894,8 +5894,6 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
 	struct mgmt_cp_add_device *cp = data;
-	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u8 auto_conn, addr_type;
 	int err;
 
@@ -5912,19 +5910,11 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 					 MGMT_STATUS_INVALID_PARAMS,
 					 &cp->addr, sizeof(cp->addr));
 
-	hci_req_init(&req, hdev);
-
 	hci_dev_lock(hdev);
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_DEVICE, hdev, data, len);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto unlock;
-	}
-
-	cmd->cmd_complete = addr_cmd_complete;
-
 	if (cp->addr.type == BDADDR_BREDR) {
+		struct hci_request req;
+
 		/* Only incoming connections action is supported for now */
 		if (cp->action != 0x01) {
 			err = mgmt_cmd_complete(sk, hdev->id,
@@ -5939,7 +5929,9 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		if (err)
 			goto unlock;
 
+		hci_req_init(&req, hdev);
 		__hci_update_page_scan(&req);
+		hci_req_run(&req, NULL);
 
 		goto added;
 	}
-- 
2.5.0


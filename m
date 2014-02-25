Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/17] Bluetooth: Create hci_req_add_le_scan_disable helper
Date: Tue, 25 Feb 2014 18:01:28 -0300
Message-Id: <1393362104-12175-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves stop LE scanning duplicate code to one single
place and reuses it. This will avoid more duplicate code in
upcoming patches.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 14 ++++++++++----
 net/bluetooth/mgmt.c             | 12 ++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 269c820..bef65d0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1129,6 +1129,8 @@ void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 		    const void *param, u8 event);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
 
+void hci_req_add_le_scan_disable(struct hci_request *req);
+
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 669c76e..9a078cf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3318,7 +3318,6 @@ static void le_scan_disable_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    le_scan_disable.work);
-	struct hci_cp_le_set_scan_enable cp;
 	struct hci_request req;
 	int err;
 
@@ -3326,9 +3325,7 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	hci_req_init(&req, hdev);
 
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_DISABLE;
-	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	hci_req_add_le_scan_disable(&req);
 
 	err = hci_req_run(&req, le_scan_disable_work_complete);
 	if (err)
@@ -4872,3 +4869,12 @@ static void hci_cmd_work(struct work_struct *work)
 		}
 	}
 }
+
+void hci_req_add_le_scan_disable(struct hci_request *req)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_DISABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d6e2692..cfcaf97 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1052,11 +1052,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		disable_advertising(&req);
 
 	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
-		struct hci_cp_le_set_scan_enable cp;
-
-		memset(&cp, 0, sizeof(cp));
-		cp.enable = LE_SCAN_DISABLE;
-		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+		hci_req_add_le_scan_disable(&req);
 	}
 
 	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
@@ -3527,7 +3523,6 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct hci_cp_remote_name_req_cancel cp;
 	struct inquiry_entry *e;
 	struct hci_request req;
-	struct hci_cp_le_set_scan_enable enable_cp;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3563,10 +3558,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		} else {
 			cancel_delayed_work(&hdev->le_scan_disable);
 
-			memset(&enable_cp, 0, sizeof(enable_cp));
-			enable_cp.enable = LE_SCAN_DISABLE;
-			hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE,
-				    sizeof(enable_cp), &enable_cp);
+			hci_req_add_le_scan_disable(&req);
 		}
 
 		break;
-- 
1.8.5.4


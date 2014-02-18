Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v9 01/10] Bluetooth: Create hci_req_add_le_scan_disable helper
Date: Tue, 18 Feb 2014 14:54:52 -0300
Message-Id: <1392746101-5981-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves stop LE scanning duplicate code to one single
place and reuses it. This will avoid more duplicate code in
upcoming patches.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 14 ++++++++++----
 net/bluetooth/mgmt.c             |  6 +-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4461c00..6a24756 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1112,6 +1112,7 @@ void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 void hci_req_add_ev(struct hci_request *req, u16 opcode, u32 plen,
 		    const void *param, u8 event);
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
+void hci_req_add_le_scan_disable(struct hci_request *req);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			       const void *param, u32 timeout);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cdba470..6a21dcf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3147,7 +3147,6 @@ static void le_scan_disable_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    le_scan_disable.work);
-	struct hci_cp_le_set_scan_enable cp;
 	struct hci_request req;
 	int err;
 
@@ -3155,9 +3154,7 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	hci_req_init(&req, hdev);
 
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_DISABLE;
-	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	hci_req_add_le_scan_disable(&req);
 
 	err = hci_req_run(&req, le_scan_disable_work_complete);
 	if (err)
@@ -4628,3 +4625,12 @@ static void hci_cmd_work(struct work_struct *work)
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
index 90aac90..25a0c46 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3411,7 +3411,6 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct hci_cp_remote_name_req_cancel cp;
 	struct inquiry_entry *e;
 	struct hci_request req;
-	struct hci_cp_le_set_scan_enable enable_cp;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3447,10 +3446,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
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


Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v8 01/10] Bluetooth: Create hci_stop_le_scan_req() helper
Date: Wed,  5 Feb 2014 19:23:17 -0300
Message-Id: <1391639006-26311-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves stop LE scanning duplicate code to one single
place and reuses it. This will avoid more duplicate code in
upcoming patches.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 14 ++++++++++----
 net/bluetooth/mgmt.c             |  6 +-----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 92fa75f..8aff7f9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1212,4 +1212,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
 
+void hci_stop_le_scan_req(struct hci_request *req);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e774669..6529f4a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3058,7 +3058,6 @@ static void le_scan_disable_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    le_scan_disable.work);
-	struct hci_cp_le_set_scan_enable cp;
 	struct hci_request req;
 	int err;
 
@@ -3066,9 +3065,7 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	hci_req_init(&req, hdev);
 
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = LE_SCAN_DISABLE;
-	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	hci_stop_le_scan_req(&req);
 
 	err = hci_req_run(&req, le_scan_disable_work_complete);
 	if (err)
@@ -4523,3 +4520,12 @@ static void hci_cmd_work(struct work_struct *work)
 		}
 	}
 }
+
+void hci_stop_le_scan_req(struct hci_request *req)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_DISABLE;
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ce7ef33..5c0d55d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3400,7 +3400,6 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct hci_cp_remote_name_req_cancel cp;
 	struct inquiry_entry *e;
 	struct hci_request req;
-	struct hci_cp_le_set_scan_enable enable_cp;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3436,10 +3435,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		} else {
 			cancel_delayed_work(&hdev->le_scan_disable);
 
-			memset(&enable_cp, 0, sizeof(enable_cp));
-			enable_cp.enable = LE_SCAN_DISABLE;
-			hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE,
-				    sizeof(enable_cp), &enable_cp);
+			hci_stop_le_scan_req(&req);
 		}
 
 		break;
-- 
1.8.5.3


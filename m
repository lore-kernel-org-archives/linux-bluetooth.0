Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Update hci_le_scan to use HCI request
Date: Wed,  6 Mar 2013 16:10:54 -0300
Message-Id: <1362597059-4102-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org>
References: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes hci_le_scan helper so it uses the HCI request
framework to enable LE scanning.

Also, the LE scanning disable timeout was removed from the helper
and it is now handled in mgmt start_discovery code.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  3 +--
 net/bluetooth/hci_core.c         | 45 ++++++++++++++++++++++++++----------
 net/bluetooth/mgmt.c             | 49 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 494f8f5..9efb571 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1169,8 +1169,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
-int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
-		int timeout);
+int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 window);
 int hci_cancel_le_scan(struct hci_dev *hdev);
 
 u8 bdaddr_to_le(u8 bdaddr_type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7635c2e..160bfe3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1943,27 +1943,48 @@ static void le_scan_work(struct work_struct *work)
 		       param->timeout);
 }
 
-int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
-		int timeout)
+static int set_le_scan_param(struct hci_request *req, u8 type, u16 interval,
+			     u16 window)
 {
-	struct le_scan_params *param = &hdev->le_scan_params;
+	struct hci_cp_le_set_scan_param cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.type = type;
+	cp.interval = cpu_to_le16(interval);
+	cp.window = cpu_to_le16(window);
+
+	return hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
+}
+
+static int enable_le_scan(struct hci_request *req)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 1;
+	cp.filter_dup = 1;
+
+	return hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
+int hci_le_scan(struct hci_request *req, u8 type, u16 interval, u16 window)
+{
+	struct hci_dev *hdev = req->hdev;
+	int err;
 
 	BT_DBG("%s", hdev->name);
 
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
 		return -ENOTSUPP;
 
-	if (work_busy(&hdev->le_scan))
-		return -EINPROGRESS;
-
-	param->type = type;
-	param->interval = interval;
-	param->window = window;
-	param->timeout = timeout;
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+		return -EALREADY;
 
-	queue_work(system_long_wq, &hdev->le_scan);
+	err = set_le_scan_param(req, type, interval, window);
+	if (err < 0)
+		return err;
 
-	return 0;
+	return enable_le_scan(req);
 }
 
 /* Alloc HCI device */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39395c7..b444b19 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2428,11 +2428,34 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 	return err;
 }
 
+static void enable_le_scan_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("status %d", status);
+
+	if (status)
+		return;
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_LE:
+		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+				   msecs_to_jiffies(LE_SCAN_TIMEOUT_LE_ONLY));
+		break;
+
+	case DISCOV_TYPE_INTERLEAVED:
+		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+				   msecs_to_jiffies(LE_SCAN_TIMEOUT_BREDR_LE));
+		break;
+	default:
+		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
+	}
+}
+
 static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2485,8 +2508,17 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
-				  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
+		hci_req_init(&req, hdev);
+
+		err = hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
+				  LE_SCAN_WIN);
+		if (err < 0) {
+			mgmt_pending_remove(cmd);
+			hci_req_cleanup(&req);
+			goto failed;
+		}
+
+		err = hci_req_run(&req, enable_le_scan_complete);
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
@@ -2497,8 +2529,17 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT, LE_SCAN_WIN,
-				  LE_SCAN_TIMEOUT_BREDR_LE);
+		hci_req_init(&req, hdev);
+
+		err = hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
+				  LE_SCAN_WIN);
+		if (err < 0) {
+			mgmt_pending_remove(cmd);
+			hci_req_cleanup(&req);
+			goto failed;
+		}
+
+		err = hci_req_run(&req, enable_le_scan_complete);
 		break;
 
 	default:
-- 
1.8.1.2


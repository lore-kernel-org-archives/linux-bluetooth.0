Return-Path: <cyrus@holtmann.org>
From: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
Subject: [RFC 8/9] Bluetooth: Refactor le scan helpers to enable observer support
Date: Wed, 24 Oct 2012 12:58:14 -0300
Message-Id: <1351094295-10418-9-git-send-email-aloisio.almeida@openbossa.org>
In-Reply-To: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
References: <1351094295-10418-1-git-send-email-aloisio.almeida@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It was added a parameter called 'reason' to le scan helpers (hci_do_le_scan and
hci_cancel_le_scan). Distinguishing the reason to enbale/disable le scan will be
important when both discovery and observer are implemented.

'reason' was also added do hdev structure (hdev.le_scan_req_reason) in order
to make hci_cc_le_set_scan_enable behave correctly.

Signed-off-by: Aloisio Almeida Jr <aloisio.almeida@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   11 +++++--
 net/bluetooth/hci_core.c         |   63 +++++++++++++++++++++++---------------
 net/bluetooth/mgmt.c             |   10 +++---
 3 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fc26210..6ef8660 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -121,6 +121,7 @@ struct le_scan_params {
 	u16 interval;
 	u16 window;
 	int timeout;
+	u8 reason;
 };
 
 struct controller_data {
@@ -131,6 +132,10 @@ struct controller_data {
 	u8 data[0];
 };
 
+enum {
+	LE_SCAN_REQ_REASON_DISCOVERY,
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 struct amp_assoc {
@@ -285,6 +290,7 @@ struct hci_dev {
 
 	struct work_struct	le_scan;
 	struct le_scan_params	le_scan_params;
+	__u8			le_scan_req_reason;
 
 	__s8			adv_tx_power;
 
@@ -1139,9 +1145,10 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
+
 int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
-		int timeout);
-int hci_cancel_le_scan(struct hci_dev *hdev);
+		int timeout, u8 reason);
+int hci_cancel_le_scan(struct hci_dev *hdev, u8 reason);
 
 u8 bdaddr_to_le(u8 bdaddr_type);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2c2f3aa..fbf0ba1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1538,20 +1538,20 @@ static void le_scan_param_req(struct hci_dev *hdev, unsigned long opt)
 
 static void le_scan_enable_req(struct hci_dev *hdev, unsigned long opt)
 {
-	struct hci_cp_le_set_scan_enable cp;
+	struct hci_cp_le_set_scan_enable *cp;
 
-	memset(&cp, 0, sizeof(cp));
-	cp.enable = 1;
-	cp.filter_dup = 1;
+	cp = (struct hci_cp_le_set_scan_enable *) opt;
 
-	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
+		     sizeof(struct hci_cp_le_set_scan_enable), cp);
 }
 
 static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
-			  u16 window, int timeout)
+			  u16 window, int timeout, u8 reason)
 {
 	long timeo = msecs_to_jiffies(3000);
 	struct le_scan_params param;
+	struct hci_cp_le_set_scan_enable cp;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -1563,38 +1563,52 @@ static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
 	param.interval = interval;
 	param.window = window;
 
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 1;
+	if (reason == LE_SCAN_REQ_REASON_DISCOVERY)
+		cp.filter_dup = 1;
+
+	hci_dev_lock(hdev);
+	hdev->le_scan_req_reason = reason;
+	hci_dev_unlock(hdev);
+
 	hci_req_lock(hdev);
 
 	err = __hci_request(hdev, le_scan_param_req, (unsigned long) &param,
 			    timeo);
-	if (!err)
-		err = __hci_request(hdev, le_scan_enable_req, 0, timeo);
+	if (err)
+		goto unlock;
 
-	hci_req_unlock(hdev);
-
-	if (err < 0)
-		return err;
+	err = __hci_request(hdev, le_scan_enable_req, (unsigned long) &cp,
+			    timeo);
+	if (err)
+		goto unlock;
 
-	schedule_delayed_work(&hdev->le_scan_disable,
-			      msecs_to_jiffies(timeout));
+	if (timeout > 0)
+		schedule_delayed_work(&hdev->le_scan_disable,
+				      msecs_to_jiffies(timeout));
 
-	return 0;
+unlock:
+	hci_req_unlock(hdev);
+	return err;
 }
 
-int hci_cancel_le_scan(struct hci_dev *hdev)
+int hci_cancel_le_scan(struct hci_dev *hdev, u8 reason)
 {
+	struct hci_cp_le_set_scan_enable cp;
+
 	BT_DBG("%s", hdev->name);
 
 	if (!test_bit(HCI_LE_SCAN, &hdev->dev_flags))
 		return -EALREADY;
 
-	if (cancel_delayed_work(&hdev->le_scan_disable)) {
-		struct hci_cp_le_set_scan_enable cp;
+	if (reason == LE_SCAN_REQ_REASON_DISCOVERY)
+		if (!cancel_delayed_work(&hdev->le_scan_disable))
+			return 0;
 
-		/* Send HCI command to disable LE Scan */
-		memset(&cp, 0, sizeof(cp));
-		hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
-	}
+	/* Send HCI command to disable LE Scan */
+	memset(&cp, 0, sizeof(cp));
+	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 
 	return 0;
 }
@@ -1620,11 +1634,11 @@ static void le_scan_work(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	hci_do_le_scan(hdev, param->type, param->interval, param->window,
-		       param->timeout);
+		       param->timeout, param->reason);
 }
 
 int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
-		int timeout)
+		int timeout, u8 reason)
 {
 	struct le_scan_params *param = &hdev->le_scan_params;
 
@@ -1637,6 +1651,7 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 	param->interval = interval;
 	param->window = window;
 	param->timeout = timeout;
+	param->reason = reason;
 
 	queue_work(system_long_wq, &hdev->le_scan);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 705859f..46a45e7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2364,7 +2364,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_LE:
 		if (lmp_host_le_capable(hdev))
 			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
-					  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
+					  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY,
+					  LE_SCAN_REQ_REASON_DISCOVERY);
 		else
 			err = -ENOTSUPP;
 		break;
@@ -2372,8 +2373,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_INTERLEAVED:
 		if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
 			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
-					  LE_SCAN_WIN,
-					  LE_SCAN_TIMEOUT_BREDR_LE);
+					  LE_SCAN_WIN, LE_SCAN_TIMEOUT_BREDR_LE,
+					  LE_SCAN_REQ_REASON_DISCOVERY);
 		else
 			err = -ENOTSUPP;
 		break;
@@ -2430,7 +2431,8 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_INQUIRY, &hdev->flags))
 			err = hci_cancel_inquiry(hdev);
 		else
-			err = hci_cancel_le_scan(hdev);
+			err = hci_cancel_le_scan(hdev,
+						 LE_SCAN_REQ_REASON_DISCOVERY);
 
 		break;
 
-- 
1.7.10.4


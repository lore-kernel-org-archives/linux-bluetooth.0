Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 7/7] Bluetooth: Add support for adv instance timeout
Date: Fri, 20 Mar 2015 19:48:10 -0700
Message-Id: <1426906090-9026-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1426906090-9026-1-git-send-email-armansito@chromium.org>
References: <1426906090-9026-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements support for the timeout parameter of the
Add Advertising command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 include/net/bluetooth/hci_core.h |   2 +
 net/bluetooth/mgmt.c             | 101 +++++++++++++++++++++++++++++++--------
 2 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2d853d8..f97ea79 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -156,8 +156,10 @@ struct oob_data {
 };
 
 struct adv_info {
+	struct delayed_work timeout_exp;
 	__u8 instance;
 	__u32 flags;
+	__u16 timeout;
 	__u16 adv_data_len;
 	__u8 adv_data[HCI_MAX_AD_LENGTH];
 	__u16 scan_rsp_len;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 02bb42f..9af5a88 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1307,6 +1307,49 @@ static bool hci_stop_discovery(struct hci_request *req)
 	return false;
 }
 
+static void advertising_added(struct sock *sk, struct hci_dev *hdev,
+			      u8 instance)
+{
+	struct mgmt_ev_advertising_added ev;
+
+	ev.instance = instance;
+
+	mgmt_event(MGMT_EV_ADVERTISING_ADDED, hdev, &ev, sizeof(ev), sk);
+}
+
+static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
+				u8 instance)
+{
+	struct mgmt_ev_advertising_removed ev;
+
+	ev.instance = instance;
+
+	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
+}
+
+static void clear_adv_instance(struct hci_dev *hdev)
+{
+	struct hci_request req;
+
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+		return;
+
+	if (hdev->adv_instance.timeout)
+		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
+
+	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
+	advertising_removed(NULL, hdev, 1);
+	hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
+
+	if (!hdev_is_powered(hdev) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
+		return;
+
+	hci_req_init(&req, hdev);
+	disable_advertising(&req);
+	hci_req_run(&req, NULL);
+}
+
 static int clean_up_hci_state(struct hci_dev *hdev)
 {
 	struct hci_request req;
@@ -1322,6 +1365,9 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	}
 
+	if (hdev->adv_instance.timeout)
+		clear_adv_instance(hdev);
+
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 		disable_advertising(&req);
 
@@ -6446,26 +6492,6 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 	return true;
 }
 
-static void advertising_added(struct sock *sk, struct hci_dev *hdev,
-			      u8 instance)
-{
-	struct mgmt_ev_advertising_added ev;
-
-	ev.instance = instance;
-
-	mgmt_event(MGMT_EV_ADVERTISING_ADDED, hdev, &ev, sizeof(ev), sk);
-}
-
-static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
-				u8 instance)
-{
-	struct mgmt_ev_advertising_removed ev;
-
-	ev.instance = instance;
-
-	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
-}
-
 static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
@@ -6502,6 +6528,18 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static void adv_timeout_expired(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    adv_instance.timeout_exp.work);
+
+	hdev->adv_instance.timeout = 0;
+
+	hci_dev_lock(hdev);
+	clear_adv_instance(hdev);
+	hci_dev_unlock(hdev);
+}
+
 static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 data_len)
 {
@@ -6509,6 +6547,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_rp_add_advertising rp;
 	u32 flags;
 	u8 status;
+	u16 timeout;
 	int err;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
@@ -6521,6 +6560,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 				       status);
 
 	flags = __le32_to_cpu(cp->flags);
+	timeout = __le16_to_cpu(cp->timeout);
 
 	/* The current implementation only supports adding one instance and
 	 * doesn't support flags.
@@ -6531,6 +6571,12 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
+	if (timeout && !hdev_is_powered(hdev)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_REJECTED);
+		goto unlock;
+	}
+
 	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
 	    pending_find(MGMT_OP_REMOVE_ADVERTISING, hdev) ||
 	    pending_find(MGMT_OP_SET_LE, hdev)) {
@@ -6547,6 +6593,8 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	INIT_DELAYED_WORK(&hdev->adv_instance.timeout_exp, adv_timeout_expired);
+
 	hdev->adv_instance.flags = flags;
 	hdev->adv_instance.adv_data_len = cp->adv_data_len;
 	hdev->adv_instance.scan_rsp_len = cp->scan_rsp_len;
@@ -6558,6 +6606,16 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		memcpy(hdev->adv_instance.scan_rsp_data,
 		       cp->data + cp->adv_data_len, cp->scan_rsp_len);
 
+	if (hdev->adv_instance.timeout)
+		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
+
+	hdev->adv_instance.timeout = timeout;
+
+	if (timeout)
+		queue_delayed_work(hdev->workqueue,
+				   &hdev->adv_instance.timeout_exp,
+				   msecs_to_jiffies(timeout * 1000));
+
 	if (!hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE))
 		advertising_added(sk, hdev, 1);
 
@@ -6660,6 +6718,9 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	if (hdev->adv_instance.timeout)
+		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
+
 	memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
 
 	advertising_removed(sk, hdev, 1);
-- 
2.2.0.rc0.207.ga3a616c


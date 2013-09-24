Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Use async request for LE enable/disable
Date: Tue, 24 Sep 2013 17:02:41 +0300
Message-Id: <1380031363-1266-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the code to use an asynchronous request for handling
the enabling and disabling of LE support. This refactoring is necessary
as a preparation for adding advertising support, since when LE is
disabled we should also disable advertising, and the cleanest way to do
this is to perform the two respective HCI commands in the same
asynchronous request.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_event.c        | 11 -------
 net/bluetooth/mgmt.c             | 69 +++++++++++++++++-----------------------
 3 files changed, 29 insertions(+), 52 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3ede820..26cc9f7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1168,7 +1168,6 @@ int mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 					    u8 *randomizer, u8 status);
-int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name,
 		      u8 ssp, u8 *eir, u16 eir_len);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 94aab73..835a384 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -911,13 +911,6 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
-	if (!status) {
-		if (*sent)
-			set_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
-		else
-			clear_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
-	}
-
 	if (!test_bit(HCI_INIT, &hdev->flags)) {
 		struct hci_request req;
 
@@ -1004,10 +997,6 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 		else
 			hdev->features[1][0] &= ~LMP_HOST_LE_BREDR;
 	}
-
-	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
-	    !test_bit(HCI_INIT, &hdev->flags))
-		mgmt_le_enable_complete(hdev, sent->le, status);
 }
 
 static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 47f4c07..e595b59 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1354,11 +1354,34 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	return send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
 }
 
+static void le_enable_complete(struct hci_dev *hdev, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
+				     &mgmt_err);
+		return;
+	}
+
+	change_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+
+	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
+
+	new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+}
+
 static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct hci_cp_write_le_host_supported hci_cp;
 	struct pending_cmd *cmd;
+	struct hci_request req;
 	int err;
 	u8 val, enabled;
 
@@ -1419,8 +1442,12 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		hci_cp.simul = lmp_le_br_capable(hdev);
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
-			   &hci_cp);
+	hci_req_init(&req, hdev);
+
+	hci_req_add(&req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(hci_cp),
+		    &hci_cp);
+
+	err = hci_req_run(&req, le_enable_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -4141,44 +4168,6 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 	return err;
 }
 
-int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
-{
-	struct cmd_lookup match = { NULL, hdev };
-	bool changed = false;
-	int err = 0;
-
-	if (status) {
-		u8 mgmt_err = mgmt_status(status);
-
-		if (enable && test_and_clear_bit(HCI_LE_ENABLED,
-						 &hdev->dev_flags))
-			err = new_settings(hdev, NULL);
-
-		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
-				     &mgmt_err);
-
-		return err;
-	}
-
-	if (enable) {
-		if (!test_and_set_bit(HCI_LE_ENABLED, &hdev->dev_flags))
-			changed = true;
-	} else {
-		if (test_and_clear_bit(HCI_LE_ENABLED, &hdev->dev_flags))
-			changed = true;
-	}
-
-	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
-
-	if (changed)
-		err = new_settings(hdev, match.sk);
-
-	if (match.sk)
-		sock_put(match.sk);
-
-	return err;
-}
-
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, u8 *dev_class, s8 rssi, u8 cfm_name, u8
 		      ssp, u8 *eir, u16 eir_len)
-- 
1.8.4.rc3


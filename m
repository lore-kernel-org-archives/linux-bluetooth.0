Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: mgmt: Make Set SSP command callable while powered off
Date: Wed, 22 Feb 2012 13:12:52 +0200
Message-Id: <1329909172-19958-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
References: <1329909172-19958-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes it possible to enable SSP through mgmt even when
powered off. The setting will then get automatically actiated when
powering on.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_event.c        |   20 +++++++---------
 net/bluetooth/mgmt.c             |   44 +++++++++++++++++++++++++++++++-------
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 094b5db..6ba3a4b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1006,7 +1006,7 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						u8 addr_type, u8 status);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
-int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status);
+int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1b1c348..240dc16 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -427,21 +427,18 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
-	if (status)
-		goto done;
-
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SSP_MODE);
 	if (!sent)
 		return;
 
-	if (*((u8 *) sent))
-		set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
-	else
-		clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
-
-done:
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		mgmt_ssp_enable_complete(hdev, status);
+		mgmt_ssp_enable_complete(hdev, *((u8 *) sent), status);
+	else if (!status) {
+		if (*((u8 *) sent))
+			set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+		else
+			clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+	}
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
@@ -560,7 +557,8 @@ static void hci_setup(struct hci_dev *hdev)
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
-	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
+	if (hdev->features[6] & LMP_SIMPLE_PAIR &&
+				test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 		u8 mode = 0x01;
 		hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, sizeof(mode), &mode);
 	}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 69d4e1a..eefd084 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1138,9 +1138,23 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
+	val = !!cp->val;
+
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_SSP,
-						MGMT_STATUS_NOT_POWERED);
+		bool changed = false;
+
+		if (val != test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
+			change_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
+		if (err < 0)
+			goto failed;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
 		goto failed;
 	}
 
@@ -1155,8 +1169,6 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	val = !!cp->val;
-
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) == val) {
 		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
 		goto failed;
@@ -3393,21 +3405,37 @@ static int clear_eir(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 }
 
-int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status)
+int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	int err;
+	bool changed = false;
+	int err = 0;
 
 	if (status) {
 		u8 mgmt_err = mgmt_status(status);
+
+		if (enable && test_and_clear_bit(HCI_SSP_ENABLED,
+							&hdev->dev_flags))
+			err = new_settings(hdev, NULL);
+
 		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev,
 						cmd_status_rsp, &mgmt_err);
-		return 0;
+
+		return err;
+	}
+
+	if (enable) {
+		if (!test_and_set_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+			changed = true;
+	} else {
+		if (test_and_clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+			changed = true;
 	}
 
 	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
 
-	err = new_settings(hdev, match.sk);
+	if (changed)
+		err = new_settings(hdev, match.sk);
 
 	if (match.sk) {
 		sock_put(match.sk);
-- 
1.7.9


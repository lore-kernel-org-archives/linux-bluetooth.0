Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: mgmt: Implement Set LE command
Date: Wed, 22 Feb 2012 16:53:12 +0200
Message-Id: <1329922392-25089-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329922392-25089-1-git-send-email-johan.hedberg@gmail.com>
References: <1329922392-25089-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch implements support for the Set LE mgmt command. Now, in
addition to the enable_le module parameter user space needs to send an
explicit Enable LE command to enable LE support.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    7 ++-
 net/bluetooth/mgmt.c             |  119 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 806eb41..c97cf08 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -96,6 +96,7 @@ enum {
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
 	HCI_HS_ENABLED,
+	HCI_LE_ENABLED,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LINK_SECURITY,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6ba3a4b..abdaa79 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1010,6 +1010,7 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
+int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					u8 addr_type, u8 *dev_class, s8 rssi,
 					u8 cfm_name, u8 *eir, u16 eir_len);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3476d5c..498b71a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -539,7 +539,7 @@ static void hci_set_le_support(struct hci_dev *hdev)
 
 	memset(&cp, 0, sizeof(cp));
 
-	if (enable_le) {
+	if (enable_le && test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 		cp.le = 1;
 		cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
 	}
@@ -1130,10 +1130,15 @@ static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
 	struct hci_cp_read_local_ext_features cp;
+	struct hci_cp_write_le_host_supported *sent;
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
+	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED);
+	if (sent && test_bit(HCI_MGMT, &hdev->dev_flags))
+		mgmt_le_enable_complete(hdev, sent->le, status);
+
 	if (status)
 		return;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ac8ba83..8bc6a7a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -407,7 +407,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (!(hdev->features[4] & LMP_NO_BREDR))
 		settings |= MGMT_SETTING_BREDR;
 
-	if (hdev->host_features[0] & LMP_HOST_LE)
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LE;
 
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
@@ -1231,6 +1231,82 @@ failed:
 	return err;
 }
 
+static int set_le(struct sock *sk, u16 index, void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	struct hci_cp_write_le_host_supported hci_cp;
+	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
+	int err;
+	u8 val;
+
+	BT_DBG("request for hci%u", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_LE,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_SET_LE,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	if (!enable_le || !(hdev->features[4] & LMP_LE)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LE,
+						MGMT_STATUS_NOT_SUPPORTED);
+		goto failed;
+	}
+
+	val = !!cp->val;
+
+	if (!hdev_is_powered(hdev)) {
+		bool changed = false;
+
+		if (val != test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+			change_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
+		if (err < 0)
+			goto failed;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
+		goto failed;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LE, MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LE, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	memset(&hci_cp, 0, sizeof(hci_cp));
+
+	if (val) {
+		hci_cp.le = val;
+		hci_cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED,
+						sizeof(hci_cp), &hci_cp);
+	if (err < 0) {
+		mgmt_pending_remove(cmd);
+		goto failed;
+	}
+
+failed:
+	hci_dev_put(hdev);
+	return err;
+}
+
 static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
@@ -2816,6 +2892,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_HS:
 		err = set_hs(sk, index, cp, len);
 		break;
+	case MGMT_OP_SET_LE:
+		err = set_le(sk, index, cp, len);
+		break;
 	case MGMT_OP_ADD_UUID:
 		err = add_uuid(sk, index, cp, len);
 		break;
@@ -3521,6 +3600,44 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 	return err;
 }
 
+int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	bool changed = false;
+	int err = 0;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		if (enable && test_and_clear_bit(HCI_LE_ENABLED,
+							&hdev->dev_flags))
+			err = new_settings(hdev, NULL);
+
+		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev,
+						cmd_status_rsp, &mgmt_err);
+
+		return err;
+	}
+
+	if (enable) {
+		if (!test_and_set_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+			changed = true;
+	} else {
+		if (test_and_clear_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+			changed = true;
+	}
+
+	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, settings_rsp, &match);
+
+	if (changed)
+		err = new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	return err;
+}
+
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 				u8 addr_type, u8 *dev_class, s8 rssi,
 				u8 cfm_name, u8 *eir, u16 eir_len)
-- 
1.7.9


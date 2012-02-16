Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: mgmt: Implement Set SSP command
Date: Fri, 17 Feb 2012 01:22:57 +0200
Message-Id: <1329434578-5928-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Set SSP mgmt command can be used for enabling and disabling Secure
Simple Pairing support for controllers that support it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    6 ++-
 net/bluetooth/mgmt.c             |   79 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 66f84ad..43e0b1e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -995,6 +995,7 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						u8 addr_type, u8 status);
 int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
+int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 239e9fb..179d127 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -447,7 +447,7 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%x", hdev->name, status);
 
 	if (status)
-		return;
+		goto done;
 
 	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_SSP_MODE);
 	if (!sent)
@@ -457,6 +457,10 @@ static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		set_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
 	else
 		clear_bit(HCI_SSP_ENABLED, &hdev->dev_flags);
+
+done:
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		mgmt_ssp_enable_complete(hdev, status);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e38b3cb..ecfb747 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1017,6 +1017,58 @@ failed:
 	return err;
 }
 
+static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
+	uint8_t val;
+	int err;
+
+	BT_DBG("request for hci%u", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_SET_SSP,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_SET_SSP,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_SSP, MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
+	val = !!cp->val;
+
+	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) == val) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_SSP, hdev);
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_SSP, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE, sizeof(val), &val);
+	if (err < 0) {
+		mgmt_pending_remove(cmd);
+		goto failed;
+	}
+
+failed:
+	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
@@ -2499,6 +2551,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_LINK_SECURITY:
 		err = set_link_security(sk, index, cp, len);
 		break;
+	case MGMT_OP_SET_SSP:
+		err = set_ssp(sk, index, cp, len);
+		break;
 	case MGMT_OP_ADD_UUID:
 		err = add_uuid(sk, index, cp, len);
 		break;
@@ -3046,6 +3101,30 @@ int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
+int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	__le32 ev;
+	int err;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev,
+						cmd_status_rsp, &mgmt_err);
+		return 0;
+	}
+
+	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, settings_rsp, &match);
+
+	ev = cpu_to_le32(get_current_settings(hdev));
+	err = mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	return err;
+}
+
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
 {
 	struct pending_cmd *cmd;
-- 
1.7.9


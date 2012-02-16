Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: mgmt: Add support for Set Link Security command
Date: Fri, 17 Feb 2012 01:22:56 +0200
Message-Id: <1329434578-5928-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
References: <1329434578-5928-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Set Link Security mgmt command is used to enable or disable link
level security, also known as Security Mode 3. This is rarely enabled in
modern systems but the command needs to be available for completeness,
qualification purposes and those few systems that actually want to
enable it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    3 +
 net/bluetooth/mgmt.c             |   81 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b20d990..66f84ad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -994,6 +994,7 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					u8 link_type, u8 addr_type, u8 status);
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 						u8 addr_type, u8 status);
+int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b0784ee..239e9fb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -254,6 +254,9 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 			clear_bit(HCI_AUTH, &hdev->flags);
 	}
 
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		mgmt_auth_enable_complete(hdev, status);
+
 	hci_req_complete(hdev, HCI_OP_WRITE_AUTH_ENABLE, status);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5520858..e38b3cb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -964,6 +964,59 @@ failed:
 	return err;
 }
 
+static int set_link_security(struct sock *sk, u16 index, void *data, u16 len)
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
+		return cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
+						MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (mgmt_pending_find(MGMT_OP_SET_LINK_SECURITY, hdev)) {
+		err = cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
+							MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
+	val = !!cp->val;
+
+	if (test_bit(HCI_AUTH, &hdev->flags) == val) {
+		err = send_settings_rsp(sk, MGMT_OP_SET_LINK_SECURITY, hdev);
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LINK_SECURITY, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	err = hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE, sizeof(val), &val);
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
@@ -2443,6 +2496,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_PAIRABLE:
 		err = set_pairable(sk, index, cp, len);
 		break;
+	case MGMT_OP_SET_LINK_SECURITY:
+		err = set_link_security(sk, index, cp, len);
+		break;
 	case MGMT_OP_ADD_UUID:
 		err = add_uuid(sk, index, cp, len);
 		break;
@@ -2965,6 +3021,31 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
 }
 
+int mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	__le32 ev;
+	int err;
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+		mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev,
+						cmd_status_rsp, &mgmt_err);
+		return 0;
+	}
+
+	mgmt_pending_foreach(MGMT_OP_SET_LINK_SECURITY, hdev, settings_rsp,
+								&match);
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


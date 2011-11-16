Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v3 4/9] Bluetooth: Add User Passkey Response handling
Date: Wed, 16 Nov 2011 10:37:48 -0800
Message-Id: <1321468673-13925-5-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321468673-13925-1-git-send-email-bgix@codeaurora.org>
References: <1321468673-13925-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For some MITM protection pairing scenarios, the user is
required to enter or accept a 6 digit passkey.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/mgmt.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b1d4f05..8a48193 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1487,7 +1487,15 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 	}
 
 	/* Continue with pairing via HCI */
-	err = hci_send_cmd(hdev, hci_op, sizeof(*bdaddr), bdaddr);
+	if (hci_op == HCI_OP_USER_PASSKEY_REPLY) {
+		struct hci_cp_user_passkey_reply cp;
+
+		bacpy(&cp.bdaddr, bdaddr);
+		cp.passkey = passkey;
+		err = hci_send_cmd(hdev, hci_op, sizeof(cp), &cp);
+	} else
+		err = hci_send_cmd(hdev, hci_op, sizeof(*bdaddr), bdaddr);
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -1529,6 +1537,37 @@ static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
 			HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
 }
 
+static int user_passkey_reply(struct sock *sk, u16 index, void *data, u16 len)
+{
+	struct mgmt_cp_user_passkey_reply *cp = (void *) data;
+
+	BT_DBG("");
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
+									EINVAL);
+
+	return user_pairing_resp(sk, index, &cp->bdaddr,
+			MGMT_OP_USER_PASSKEY_REPLY,
+			HCI_OP_USER_PASSKEY_REPLY, cp->passkey);
+}
+
+static int user_passkey_neg_reply(struct sock *sk, u16 index, void *data,
+									u16 len)
+{
+	struct mgmt_cp_user_passkey_neg_reply *cp = (void *) data;
+
+	BT_DBG("");
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
+									EINVAL);
+
+	return user_pairing_resp(sk, index, &cp->bdaddr,
+			MGMT_OP_USER_PASSKEY_NEG_REPLY,
+			HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
+}
+
 static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
@@ -1971,6 +2010,13 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = user_confirm_neg_reply(sk, index, buf + sizeof(*hdr),
 									len);
 		break;
+	case MGMT_OP_USER_PASSKEY_REPLY:
+		err = user_passkey_reply(sk, index, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
+		err = user_passkey_neg_reply(sk, index, buf + sizeof(*hdr),
+									len);
+		break;
 	case MGMT_OP_SET_LOCAL_NAME:
 		err = set_local_name(sk, index, buf + sizeof(*hdr), len);
 		break;
@@ -2327,6 +2373,18 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 									NULL);
 }
 
+int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct mgmt_ev_user_passkey_request ev;
+
+	BT_DBG("%s", hdev->name);
+
+	bacpy(&ev.bdaddr, bdaddr);
+
+	return mgmt_event(MGMT_EV_USER_PASSKEY_REQUEST, hdev, &ev, sizeof(ev),
+									NULL);
+}
+
 static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 							u8 status, u8 opcode)
 {
@@ -2361,6 +2419,20 @@ int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
 
+int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 status)
+{
+	return user_pairing_resp_complete(hdev, bdaddr, status,
+						MGMT_OP_USER_PASSKEY_REPLY);
+}
+
+int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev,
+						bdaddr_t *bdaddr, u8 status)
+{
+	return user_pairing_resp_complete(hdev, bdaddr, status,
+					MGMT_OP_USER_PASSKEY_NEG_REPLY);
+}
+
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status)
 {
 	struct mgmt_ev_auth_failed ev;
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

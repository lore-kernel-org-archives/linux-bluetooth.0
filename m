Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <padovan@profusion.mobi>, Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Verify a pin code in pin_code_reply
Date: Wed, 1 Jun 2011 17:28:48 +0200
Message-ID: <1306942128-5325-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1306942128-5325-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1306942128-5325-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we cannot relay on a userspace mgmt api implementation we should verify
if pin_code_reply in fact contains the secure pin code.

If userspace replied with unsecure pincode when secure was required we will
send pin_code_neg_reply to the controller.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/mgmt.c |   50 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 78d1a5f..7cdf606 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1108,11 +1108,32 @@ unlock:
 	return err;
 }
 
+static int send_pin_code_neg_reply(struct sock *sk, u16 index,
+		struct hci_dev *hdev, struct mgmt_cp_pin_code_neg_reply *cp)
+{
+	struct pending_cmd *cmd;
+	int err;
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, index, cp,
+								sizeof(*cp));
+	if (!cmd)
+		return -ENOMEM;
+
+	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(cp->bdaddr),
+								&cp->bdaddr);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+	return err;
+}
+
 static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 									u16 len)
 {
 	struct hci_dev *hdev;
+	struct hci_conn *conn;
 	struct mgmt_cp_pin_code_reply *cp;
+	struct mgmt_cp_pin_code_neg_reply ncp;
 	struct hci_cp_pin_code_reply reply;
 	struct pending_cmd *cmd;
 	int err;
@@ -1135,6 +1156,23 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (!conn) {
+		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENOTCONN);
+		goto failed;
+	}
+
+	if (conn->pending_sec_level == BT_SECURITY_HIGH && cp->pin_len != 16) {
+		bacpy(&ncp.bdaddr, &cp->bdaddr);
+
+		err = send_pin_code_neg_reply(sk, index, hdev, &ncp);
+		if (err >= 0)
+			err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+								EINVAL);
+
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_REPLY, index, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
@@ -1185,17 +1223,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_PIN_CODE_NEG_REPLY, index,
-								data, len);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto failed;
-	}
-
-	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(cp->bdaddr),
-								&cp->bdaddr);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
+	err = send_pin_code_neg_reply(sk, index, hdev, cp);
 
 failed:
 	hci_dev_unlock(hdev);
-- 
1.7.4.1


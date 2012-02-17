Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: mgmt: Add address type to PIN code messages
Date: Fri, 17 Feb 2012 14:32:26 +0200
Message-Id: <1329481947-19108-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
References: <1329481947-19108-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The latest mgmt API includes address types for all messages containing
an address. This patch updates the PIN code messages to match this.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    8 ++++----
 net/bluetooth/mgmt.c         |   22 +++++++++++++---------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 5aafe92..eb584cc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -199,18 +199,18 @@ struct mgmt_rp_get_connections {
 
 #define MGMT_OP_PIN_CODE_REPLY		0x0016
 struct mgmt_cp_pin_code_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 pin_len;
 	__u8 pin_code[16];
 } __packed;
 struct mgmt_rp_pin_code_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	uint8_t status;
 } __packed;
 
 #define MGMT_OP_PIN_CODE_NEG_REPLY	0x0017
 struct mgmt_cp_pin_code_neg_reply {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 } __packed;
 
 #define MGMT_OP_SET_IO_CAPABILITY	0x0018
@@ -377,7 +377,7 @@ struct mgmt_ev_connect_failed {
 
 #define MGMT_EV_PIN_CODE_REQUEST	0x000E
 struct mgmt_ev_pin_code_request {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 secure;
 } __packed;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b0de719..6862340 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1528,8 +1528,8 @@ static int send_pin_code_neg_reply(struct sock *sk, u16 index,
 	if (!cmd)
 		return -ENOMEM;
 
-	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(cp->bdaddr),
-								&cp->bdaddr);
+	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
+				sizeof(cp->addr.bdaddr), &cp->addr.bdaddr);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
@@ -1541,7 +1541,6 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 	struct hci_dev *hdev;
 	struct hci_conn *conn;
 	struct mgmt_cp_pin_code_reply *cp = data;
-	struct mgmt_cp_pin_code_neg_reply ncp;
 	struct hci_cp_pin_code_reply reply;
 	struct pending_cmd *cmd;
 	int err;
@@ -1565,7 +1564,7 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
 	if (!conn) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_NOT_CONNECTED);
@@ -1573,7 +1572,9 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (conn->pending_sec_level == BT_SECURITY_HIGH && cp->pin_len != 16) {
-		bacpy(&ncp.bdaddr, &cp->bdaddr);
+		struct mgmt_cp_pin_code_neg_reply ncp;
+
+		memcpy(&ncp.addr, &cp->addr, sizeof(ncp.addr));
 
 		BT_ERR("PIN code is not 16 bytes long");
 
@@ -1592,7 +1593,7 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 	}
 
-	bacpy(&reply.bdaddr, &cp->bdaddr);
+	bacpy(&reply.bdaddr, &cp->addr.bdaddr);
 	reply.pin_len = cp->pin_len;
 	memcpy(reply.pin_code, cp->pin_code, sizeof(reply.pin_code));
 
@@ -2945,7 +2946,8 @@ int mgmt_pin_code_request(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 secure)
 {
 	struct mgmt_ev_pin_code_request ev;
 
-	bacpy(&ev.bdaddr, bdaddr);
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = MGMT_ADDR_BREDR;
 	ev.secure = secure;
 
 	return mgmt_event(MGMT_EV_PIN_CODE_REQUEST, hdev, &ev, sizeof(ev),
@@ -2963,7 +2965,8 @@ int mgmt_pin_code_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!cmd)
 		return -ENOENT;
 
-	bacpy(&rp.bdaddr, bdaddr);
+	bacpy(&rp.addr.bdaddr, bdaddr);
+	rp.addr.type = MGMT_ADDR_BREDR;
 	rp.status = mgmt_status(status);
 
 	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_REPLY, &rp,
@@ -2985,7 +2988,8 @@ int mgmt_pin_code_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!cmd)
 		return -ENOENT;
 
-	bacpy(&rp.bdaddr, bdaddr);
+	bacpy(&rp.addr.bdaddr, bdaddr);
+	rp.addr.type = MGMT_ADDR_BREDR;
 	rp.status = mgmt_status(status);
 
 	err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY, &rp,
-- 
1.7.9


Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Fix mgmt_pin_code_reply return parameters
Date: Sat, 19 Feb 2011 12:05:59 -0300
Message-Id: <1298127962-18576-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
References: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The command complete event for mgmt_pin_code_reply &
mgmt_pin_code_neg_reply should have the adapter index, Bluetooth address
as well as the status.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/mgmt.h |    5 +++++
 net/bluetooth/mgmt.c         |   23 +++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 52376a3..5aee200 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -147,6 +147,11 @@ struct mgmt_cp_pin_code_reply {
 	__u8 pin_len;
 	__u8 pin_code[16];
 } __packed;
+struct mgmt_rp_pin_code_reply {
+	__le16 index;
+	bdaddr_t bdaddr;
+	uint8_t status;
+} __packed;
 
 #define MGMT_OP_PIN_CODE_NEG_REPLY	0x0012
 struct mgmt_cp_pin_code_neg_reply {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d1d9b8c..0d3d613 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1558,17 +1558,18 @@ int mgmt_pin_code_request(u16 index, bdaddr_t *bdaddr)
 int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 {
 	struct pending_cmd *cmd;
+	struct mgmt_rp_pin_code_reply rp;
 	int err;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_REPLY, index);
 	if (!cmd)
 		return -ENOENT;
 
-	if (status != 0)
-		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_REPLY, status);
-	else
-		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_REPLY,
-						bdaddr, sizeof(*bdaddr));
+	put_unaligned_le16(index, &rp.index);
+	bacpy(&rp.bdaddr, bdaddr);
+	rp.status = status;
+
+	err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_REPLY, &rp, sizeof(rp));
 
 	list_del(&cmd->list);
 	mgmt_pending_free(cmd);
@@ -1579,17 +1580,19 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 {
 	struct pending_cmd *cmd;
+	struct mgmt_rp_pin_code_reply rp;
 	int err;
 
 	cmd = mgmt_pending_find(MGMT_OP_PIN_CODE_NEG_REPLY, index);
 	if (!cmd)
 		return -ENOENT;
 
-	if (status != 0)
-		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY, status);
-	else
-		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY,
-						bdaddr, sizeof(*bdaddr));
+	put_unaligned_le16(index, &rp.index);
+	bacpy(&rp.bdaddr, bdaddr);
+	rp.status = status;
+
+	err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY,
+							&rp, sizeof(rp));
 
 	list_del(&cmd->list);
 	mgmt_pending_free(cmd);
-- 
1.7.4.1


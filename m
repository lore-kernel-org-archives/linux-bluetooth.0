Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Return success instead of EALREADY for mgmt commands
Date: Fri, 11 Nov 2011 16:18:52 +0200
Message-Id: <1321021134-31809-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the adapter state is already what is requested it's more friendly
to user-space to simply report success than to send a EALREADY error
message.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3d33168..52f85ec 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -290,6 +290,15 @@ static void mgmt_pending_remove(struct pending_cmd *cmd)
 	mgmt_pending_free(cmd);
 }
 
+static int send_mode_rsp(struct sock *sk, u16 opcode, u16 index, u8 val)
+{
+	struct mgmt_mode rp;
+
+	rp.val = val;
+
+	return cmd_complete(sk, index, opcode, &rp, sizeof(rp));
+}
+
 static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct mgmt_mode *cp;
@@ -312,7 +321,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_POWERED, EALREADY);
+		err = send_mode_rsp(sk, index, MGMT_OP_SET_POWERED, cp->val);
 		goto failed;
 	}
 
@@ -375,7 +384,8 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 
 	if (cp->val == test_bit(HCI_ISCAN, &hdev->flags) &&
 					test_bit(HCI_PSCAN, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, EALREADY);
+		err = send_mode_rsp(sk, index, MGMT_OP_SET_DISCOVERABLE,
+								cp->val);
 		goto failed;
 	}
 
@@ -440,7 +450,8 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 	}
 
 	if (cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, EALREADY);
+		err = send_mode_rsp(sk, index, MGMT_OP_SET_CONNECTABLE,
+								cp->val);
 		goto failed;
 	}
 
@@ -495,15 +506,6 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
 	return 0;
 }
 
-static int send_mode_rsp(struct sock *sk, u16 opcode, u16 index, u8 val)
-{
-	struct mgmt_mode rp;
-
-	rp.val = val;
-
-	return cmd_complete(sk, index, opcode, &rp, sizeof(rp));
-}
-
 static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 									u16 len)
 {
-- 
1.7.7.2


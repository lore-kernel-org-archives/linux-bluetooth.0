Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v3 1/2] Bluetooth: Refactor PIN code rejection to use
 user_pairing_resp()
Date: Mon, 09 Jul 2012 16:11:51 +0530
Message-id: <1341830512-10865-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reuse user_pairing_resp() to send PIN code negative reply

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/mgmt.c |   35 ++++++++++++-----------------------
 1 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e83368f..0475f37 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1778,29 +1778,6 @@ failed:
 	return err;
 }
 
-static int pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
-			      void *data, u16 len)
-{
-	struct mgmt_cp_pin_code_neg_reply *cp = data;
-	int err;
-
-	BT_DBG("");
-
-	hci_dev_lock(hdev);
-
-	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
-				 MGMT_STATUS_NOT_POWERED);
-		goto failed;
-	}
-
-	err = send_pin_code_neg_reply(sk, hdev, cp);
-
-failed:
-	hci_dev_unlock(hdev);
-	return err;
-}
-
 static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 			     u16 len)
 {
@@ -2083,6 +2060,18 @@ done:
 	return err;
 }
 
+static int pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+	struct mgmt_cp_pin_code_neg_reply *cp = data;
+
+	BT_DBG("");
+
+	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+				MGMT_OP_PIN_CODE_NEG_REPLY,
+				HCI_OP_PIN_CODE_NEG_REPLY, 0);
+}
+
 static int user_confirm_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
-- 
1.7.1


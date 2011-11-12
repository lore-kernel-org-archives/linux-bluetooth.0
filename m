Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/5] Bluetooth: Add SMP support to user_confirm_reply
Date: Fri, 11 Nov 2011 16:23:57 -0800
Message-Id: <1321057441-7921-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
References: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

to enable User Confirmation during LE-SMP pairing.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/mgmt.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5562c21..129424e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1445,6 +1445,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 	u16 mgmt_op, hci_op;
 	struct pending_cmd *cmd;
 	struct hci_dev *hdev;
+	struct hci_conn *conn;
 	int err;
 
 	BT_DBG("");
@@ -1468,20 +1469,35 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
-		goto failed;
+		goto done;
+	}
+
+	/* Route command to HCI (if ACL Link) or SMP (if LE Link) */
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+	if (!conn) {
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+		if (!conn) {
+			err = cmd_status(sk, index, mgmt_op, ENOTCONN);
+			goto done;
+		}
+
+		/* Forward Confirm response to SMP */
+
+		err = cmd_status(sk, index, mgmt_op, 0);
+		goto done;
 	}
 
 	cmd = mgmt_pending_add(sk, mgmt_op, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
-		goto failed;
+		goto done;
 	}
 
 	err = hci_send_cmd(hdev, hci_op, sizeof(cp->bdaddr), &cp->bdaddr);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-failed:
+done:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 

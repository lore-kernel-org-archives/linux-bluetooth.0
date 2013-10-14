Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Add missing error handling for Set Connectable
Date: Mon, 14 Oct 2013 16:20:05 +0300
Message-Id: <1381756807-14900-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
References: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the HCI commands related to the Set Connectable command fail we will
get a non-zero status in the request completion callback. In such a case
we must respond with the appropriate command status message to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8dcea77..a5c015c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1086,6 +1086,12 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		goto unlock;
 
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
+		goto remove_cmd;
+	}
+
 	cp = cmd->param;
 	if (cp->val)
 		changed = !test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
@@ -1097,6 +1103,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 	if (changed)
 		new_settings(hdev, cmd->sk);
 
+remove_cmd:
 	mgmt_pending_remove(cmd);
 
 unlock:
-- 
1.8.3.1


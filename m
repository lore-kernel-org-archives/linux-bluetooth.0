Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Remove redundant hci_dev comparisons in mgmt lookups
Date: Wed,  9 Nov 2011 13:58:57 +0200
Message-Id: <1320839938-24873-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
References: <1320839938-24873-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that pending commands are hci_dev specific there's no need to check
whether a command matches hci_dev when iterating through them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a849428..a6720c6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -268,9 +268,6 @@ static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 		if (opcode > 0 && cmd->opcode != opcode)
 			continue;
 
-		if (hdev && cmd->index != hdev->id)
-			continue;
-
 		cb(cmd, data);
 	}
 }
@@ -280,13 +277,8 @@ static struct pending_cmd *mgmt_pending_find(u16 opcode, struct hci_dev *hdev)
 	struct pending_cmd *cmd;
 
 	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (cmd->opcode != opcode)
-			continue;
-
-		if (hdev && cmd->index != hdev->id)
-			continue;
-
-		return cmd;
+		if (cmd->opcode == opcode)
+			return cmd;
 	}
 
 	return NULL;
@@ -1300,9 +1292,6 @@ static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
 		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
 			continue;
 
-		if (cmd->index != hdev->id)
-			continue;
-
 		if (cmd->user_data != conn)
 			continue;
 
-- 
1.7.7.1


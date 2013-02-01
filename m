Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Refactor mgmt_pending_foreach
Date: Fri,  1 Feb 2013 11:21:30 -0300
Message-Id: <1359728490-26097-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a trivial refactor in mgmt_pending_foreach function.
It replaces list_for_each_safe by list_for_each_entry_safe, simplifying
the function.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3bd4c41..39395c7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -760,13 +760,9 @@ static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 					    void *data),
 				 void *data)
 {
-	struct list_head *p, *n;
-
-	list_for_each_safe(p, n, &hdev->mgmt_pending) {
-		struct pending_cmd *cmd;
-
-		cmd = list_entry(p, struct pending_cmd, list);
+	struct pending_cmd *cmd, *tmp;
 
+	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
 		if (opcode > 0 && cmd->opcode != opcode)
 			continue;
 
-- 
1.8.1.1


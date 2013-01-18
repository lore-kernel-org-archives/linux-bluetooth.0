Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/10] Bluetooth: Fix returning proper cmd_complete for mgmt_block/unblock
Date: Fri, 18 Jan 2013 15:25:58 +0200
Message-Id: <1358515558-17861-11-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Block/Unblock Device Management commands should return Command
Complete instead of Command Status whenever possible so that user space
can distinguish exactly which command failed in the case of multiple
commands. This patch does the necessary changes in the command handler
to return the right event to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 184673e..50daae8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2599,8 +2599,9 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("%s", hdev->name);
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_status(sk, hdev->id, MGMT_OP_BLOCK_DEVICE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
@@ -2628,8 +2629,9 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("%s", hdev->name);
 
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_status(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
-- 
1.7.10.4


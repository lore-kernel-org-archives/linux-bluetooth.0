Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove redundant code from mgmt_block & mgmt_unblock
Date: Tue,  8 Nov 2011 12:25:52 +0200
Message-Id: <1320747952-10748-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no need to deal with mgmt_pending_cmd when blocking and
unblocking devices since these actions are synchronous.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 950242e..4cb2f95 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1699,7 +1699,6 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
 	struct hci_dev *hdev;
-	struct pending_cmd *cmd;
 	struct mgmt_cp_block_device *cp = (void *) data;
 	int err;
 
@@ -1716,23 +1715,13 @@ static int block_device(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock_bh(hdev);
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_BLOCK_DEVICE, index, NULL, 0);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto failed;
-	}
-
 	err = hci_blacklist_add(hdev, &cp->bdaddr);
-
 	if (err < 0)
 		err = cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE, -err);
 	else
 		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
 							NULL, 0);
 
-	mgmt_pending_remove(cmd);
-
-failed:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
@@ -1743,7 +1732,6 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
 	struct hci_dev *hdev;
-	struct pending_cmd *cmd;
 	struct mgmt_cp_unblock_device *cp = (void *) data;
 	int err;
 
@@ -1760,12 +1748,6 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 
 	hci_dev_lock_bh(hdev);
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_UNBLOCK_DEVICE, index, NULL, 0);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto failed;
-	}
-
 	err = hci_blacklist_del(hdev, &cp->bdaddr);
 
 	if (err < 0)
@@ -1774,9 +1756,6 @@ static int unblock_device(struct sock *sk, u16 index, unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
 								NULL, 0);
 
-	mgmt_pending_remove(cmd);
-
-failed:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 
-- 
1.7.7.1


Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: mgmt: Fix (Un)Block Device return parameters
Date: Sun, 19 Feb 2012 13:54:28 +0200
Message-Id: <1329652469-28973-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The same address as was passed to the (Un)Block Device command should
also be returned in the command response message.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 258adf4..c7e9a45 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2384,6 +2384,7 @@ static int block_device(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_block_device *cp = data;
+	u8 status;
 	int err;
 
 	BT_DBG("hci%u", index);
@@ -2394,18 +2395,20 @@ static int block_device(struct sock *sk, u16 index, void *data, u16 len)
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
+		return cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_add(hdev, &cp->addr.bdaddr, cp->addr.type);
 	if (err < 0)
-		err = cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
-							MGMT_STATUS_FAILED);
+		status = MGMT_STATUS_FAILED;
 	else
-		err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE, 0,
-								NULL, 0);
+		status = 0;
+
+	err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE, status,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -2417,6 +2420,7 @@ static int unblock_device(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_unblock_device *cp = data;
+	u8 status;
 	int err;
 
 	BT_DBG("hci%u", index);
@@ -2427,19 +2431,20 @@ static int unblock_device(struct sock *sk, u16 index, void *data, u16 len)
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
+		return cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_del(hdev, &cp->addr.bdaddr, cp->addr.type);
-
 	if (err < 0)
-		err = cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
+		status = MGMT_STATUS_INVALID_PARAMS;
 	else
-		err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE, 0,
-								NULL, 0);
+		status = 0;
+
+	err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE, status,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
1.7.9


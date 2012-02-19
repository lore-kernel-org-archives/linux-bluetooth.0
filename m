Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: mgmt: Fix OOB command response parameters
Date: Sun, 19 Feb 2012 13:54:29 +0200
Message-Id: <1329652469-28973-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The response to the Add/Remove Out Of Band Data commands should include
the same address as was given in the command itself.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c7e9a45..952c0a8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2094,6 +2094,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, void *data,
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_add_remote_oob_data *cp = data;
+	u8 status;
 	int err;
 
 	BT_DBG("hci%u ", index);
@@ -2104,19 +2105,21 @@ static int add_remote_oob_data(struct sock *sk, u16 index, void *data,
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS);
+		return cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
 	err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr, cp->hash,
 								cp->randomizer);
 	if (err < 0)
-		err = cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
-							MGMT_STATUS_FAILED);
+		status = MGMT_STATUS_FAILED;
 	else
-		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, 0,
-								NULL, 0);
+		status = 0;
+
+	err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, status,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -2129,6 +2132,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_remove_remote_oob_data *cp = data;
+	u8 status;
 	int err;
 
 	BT_DBG("hci%u ", index);
@@ -2139,18 +2143,20 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS);
+		return cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+						MGMT_STATUS_INVALID_PARAMS,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_lock(hdev);
 
 	err = hci_remove_remote_oob_data(hdev, &cp->addr.bdaddr);
 	if (err < 0)
-		err = cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS);
+		status = MGMT_STATUS_INVALID_PARAMS;
 	else
-		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-								0, NULL, 0);
+		status = 0;
+
+	err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA, status,
+						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
1.7.9


Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: mgmt: Add missing hci_dev locking to set_le()
Date: Wed, 29 Feb 2012 19:55:35 -0800
Message-Id: <1330574135-5889-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The set_le() function was missing hci_dev locking which is e.g. critical
for the mgmt pending command adding/removing.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b0c43fe..1f9558b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1273,10 +1273,12 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_SET_LE,
 						MGMT_STATUS_INVALID_PARAMS);
 
+	hci_dev_lock(hdev);
+
 	if (!enable_le || !(hdev->features[4] & LMP_LE)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_LE,
 						MGMT_STATUS_NOT_SUPPORTED);
-		goto failed;
+		goto unlock;
 	}
 
 	val = !!cp->val;
@@ -1292,23 +1294,23 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_LE, hdev);
 		if (err < 0)
-			goto failed;
+			goto unlock;
 
 		if (changed)
 			err = new_settings(hdev, sk);
 
-		goto failed;
+		goto unlock;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_LE, MGMT_STATUS_BUSY);
-		goto failed;
+		goto unlock;
 	}
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
-		goto failed;
+		goto unlock;
 	}
 
 	memset(&hci_cp, 0, sizeof(hci_cp));
@@ -1322,10 +1324,11 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
 						sizeof(hci_cp), &hci_cp);
 	if (err < 0) {
 		mgmt_pending_remove(cmd);
-		goto failed;
+		goto unlock;
 	}
 
-failed:
+unlock:
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
-- 
1.7.9.1


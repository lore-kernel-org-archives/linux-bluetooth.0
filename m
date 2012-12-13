Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Bluetooth: mgmt: Remove not needed restriction on add/remove OOB data
Date: Thu, 13 Dec 2012 15:11:20 +0100
Message-ID: <1355407881-22110-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those commands don't send any HCI commands to controller so there is no
need to restrict them to only powered up controller. This also makes
implementation more consistent as already stored remote OOB data
persist power toggle.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5d0ef75..65f9a2d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2252,13 +2252,6 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
-				   MGMT_STATUS_NOT_POWERED, &cp->addr,
-				   sizeof(cp->addr));
-		goto unlock;
-	}
-
 	err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr, cp->hash,
 				      cp->randomizer);
 	if (err < 0)
@@ -2269,7 +2262,6 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA, status,
 			   &cp->addr, sizeof(cp->addr));
 
-unlock:
 	hci_dev_unlock(hdev);
 	return err;
 }
@@ -2285,14 +2277,6 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, hdev->id,
-				   MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-				   MGMT_STATUS_NOT_POWERED, &cp->addr,
-				   sizeof(cp->addr));
-		goto unlock;
-	}
-
 	err = hci_remove_remote_oob_data(hdev, &cp->addr.bdaddr);
 	if (err < 0)
 		status = MGMT_STATUS_INVALID_PARAMS;
@@ -2302,7 +2286,6 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 			   status, &cp->addr, sizeof(cp->addr));
 
-unlock:
 	hci_dev_unlock(hdev);
 	return err;
 }
-- 
1.8.0


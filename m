Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Fix busy return for mgmt_set_powered in some cases
Date: Tue, 24 Sep 2013 17:02:39 +0300
Message-Id: <1380031363-1266-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should return a "busy" error always when there is another
mgmt_set_powered operation in progress. Previously when powering on
while the auto off timer was still set the code could have let two or
more pending power on commands to be queued. This patch fixes the issue
by moving the check for duplicate commands to an earlier point in the
set_powered handler.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5319a94..2a91346 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -807,6 +807,12 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
+				 MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
 		cancel_delayed_work(&hdev->power_off);
 
@@ -823,12 +829,6 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
-				 MGMT_STATUS_BUSY);
-		goto failed;
-	}
-
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_POWERED, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
-- 
1.8.4.rc3


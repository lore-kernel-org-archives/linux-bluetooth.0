Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable passive scanning whenever we're connectable
Date: Mon,  7 Jul 2014 14:40:22 +0300
Message-Id: <1404733222-28820-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Enabling passive scanning always when we're connectable aligns us with
the BR/EDR page scanning. This is also consistent with the fact that the
code dealing with passive scanning results will actively try to connect
any direct advertising event when we're connectable.

This patch implements the feature by adding the connectable condition to
hci_update_background_scan() checks for starting scanning and by calling
hci_update_background_scan() whenever the connectable state changes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 3 ++-
 net/bluetooth/mgmt.c     | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4f8ba49ac49d..6790dc8cff99 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5409,7 +5409,8 @@ void hci_update_background_scan(struct hci_dev *hdev)
 
 	hci_req_init(&req, hdev);
 
-	if (list_empty(&hdev->pend_le_conns) &&
+	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags) &&
+	    list_empty(&hdev->pend_le_conns) &&
 	    list_empty(&hdev->pend_le_reports)) {
 		/* If there is no pending LE connections or devices
 		 * to be scanned for, we should stop the background
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 40244fc0e326..ef675acbcfce 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1750,8 +1750,10 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
 
-	if (changed)
+	if (changed) {
 		new_settings(hdev, cmd->sk);
+		hci_update_background_scan(hdev);
+	}
 
 remove_cmd:
 	mgmt_pending_remove(cmd);
-- 
1.9.3


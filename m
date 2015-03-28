Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 1/3] Bluetooth: Fix using global connectable settings for adv
Date: Sat, 28 Mar 2015 12:38:58 -0700
Message-Id: <1427571540-29166-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug where ADV_NONCONN_IND was being used for
advertising instances >0 while the global connectable setting was
set to "on".

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 net/bluetooth/mgmt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fb2e764..d998ec3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -985,9 +985,10 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 	/* Instance 0 always manages the "Tx Power" and "Flags" fields */
 	flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
 
-	/* For instance 0, assemble the flags from global settings */
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE) ||
-	    get_connectable(hdev))
+	/* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting corresponds
+	 * to the "connectable" instance flag.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
 		flags |= MGMT_ADV_FLAG_CONNECTABLE;
 
 	return flags;
@@ -1242,7 +1243,12 @@ static void enable_advertising(struct hci_request *req)
 
 	instance = get_current_adv_instance(hdev);
 	flags = get_adv_instance_flags(hdev, instance);
-	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE);
+
+	/* If the "connectable" instance flag was not set, then choose between
+	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 */
+	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
+		      get_connectable(hdev);
 
 	/* Set require_privacy to true only when non-connectable
 	 * advertising is used. In that case it is fine to use a
-- 
2.2.0.rc0.207.ga3a616c


Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Update discovery state earlier in hci_discovery_set_state
Date: Mon,  7 Jul 2014 13:24:58 +0300
Message-Id: <1404728699-11268-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In a subsequent patch the hci_update_background_scan() function will
depend on being able to know the current discovery state. For this to be
possible we need to set the new state early in the function. Since we
also need to check what the old state was this patch introduces an extra
variable for tracking it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 623ffe0da4a6..6a0e39f69e03 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1903,16 +1903,20 @@ bool hci_discovery_active(struct hci_dev *hdev)
 
 void hci_discovery_set_state(struct hci_dev *hdev, int state)
 {
+	int old_state = hdev->discovery.state;
+
 	BT_DBG("%s state %u -> %u", hdev->name, hdev->discovery.state, state);
 
-	if (hdev->discovery.state == state)
+	if (old_state == state)
 		return;
 
+	hdev->discovery.state = state;
+
 	switch (state) {
 	case DISCOVERY_STOPPED:
 		hci_update_background_scan(hdev);
 
-		if (hdev->discovery.state != DISCOVERY_STARTING)
+		if (old_state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
 	case DISCOVERY_STARTING:
@@ -1925,8 +1929,6 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 	case DISCOVERY_STOPPING:
 		break;
 	}
-
-	hdev->discovery.state = state;
 }
 
 void hci_inquiry_cache_flush(struct hci_dev *hdev)
-- 
1.9.3


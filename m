Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add helper function for clearing the discovery filter
Date: Fri,  5 Dec 2014 11:45:21 +0100
Message-Id: <1417776323-131063-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The discovery filter allocates memory for its UUID list. So use
a helper function to free it and reset it to default states.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 8 ++++++++
 net/bluetooth/hci_core.c         | 5 +----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 83ca58b9f4c1..f07b1450b3c2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -509,6 +509,14 @@ static inline void discovery_init(struct hci_dev *hdev)
 	hdev->discovery.rssi = HCI_RSSI_INVALID;
 }
 
+static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
+{
+	hdev->discovery.rssi = HCI_RSSI_INVALID;
+	hdev->discovery.uuid_count = 0;
+	kfree(hdev->discovery.uuids);
+	hdev->discovery.uuids = NULL;
+}
+
 bool hci_discovery_active(struct hci_dev *hdev);
 
 void hci_discovery_set_state(struct hci_dev *hdev, int state);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 42f86dc3fb40..3c81b5cdda83 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2061,10 +2061,7 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 		 * count, it is important to actually free the allocated
 		 * list of UUIDs here.
 		 */
-		hdev->discovery.rssi = HCI_RSSI_INVALID;
-		hdev->discovery.uuid_count = 0;
-		kfree(hdev->discovery.uuids);
-		hdev->discovery.uuids = NULL;
+		hci_discovery_filter_clear(hdev);
 
 		if (old_state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
-- 
1.9.3


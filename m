Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH v4 1/4] Bluetooth: Move discovery state check inside
 hci_dev_lock()
Date: Mon, 21 Jan 2013 19:43:36 +0530
Message-id: <1358777619-27018-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After checking the discovery state, if other thread modifies it
then it will be overwritten by the assignment in the first thread.

Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
---
 net/bluetooth/hci_event.c |    9 ++++-----
 net/bluetooth/mgmt.c      |    4 ----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 705078a..97b4828 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1273,14 +1273,13 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
+		hci_dev_lock(hdev);
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    hdev->discovery.state == DISCOVERY_FINDING) {
+		    hdev->discovery.state == DISCOVERY_FINDING)
 			mgmt_interleaved_discovery(hdev);
-		} else {
-			hci_dev_lock(hdev);
+		else
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-			hci_dev_unlock(hdev);
-		}
+		hci_dev_unlock(hdev);
 
 		break;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 37add53..a7865ad 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2333,14 +2333,10 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_dev_lock(hdev);
-
 	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
 	if (err < 0)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-	hci_dev_unlock(hdev);
-
 	return err;
 }
 
-- 
1.7.9.5


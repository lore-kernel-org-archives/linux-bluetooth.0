Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 3/3] Bluetooth: Use advertising cache thread-safe functions
Date: Tue,  7 Feb 2012 01:29:57 -0300
Message-Id: <1328588997-25029-4-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces some advertising cache unsafe function calls
by its thread-safe versions where applicable.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 net/bluetooth/hci_core.c  |    6 +-----
 net/bluetooth/hci_event.c |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 536248d..24b7621 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1532,11 +1532,7 @@ static void hci_clear_adv_cache(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 							adv_work.work);
 
-	hci_dev_lock(hdev);
-
-	__hci_adv_entries_clear(hdev);
-
-	hci_dev_unlock(hdev);
+	hci_adv_entries_clear(hdev);
 }
 
 /* Must be holding hdev->lock */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6808069..3933ccd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3255,12 +3255,10 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	void *ptr = &skb->data[1];
 	s8 rssi;
 
-	hci_dev_lock(hdev);
-
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
-		__hci_add_adv_entry(hdev, ev);
+		hci_add_adv_entry(hdev, ev);
 
 		rssi = ev->data[ev->length];
 		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
@@ -3268,8 +3266,6 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 
 		ptr += sizeof(*ev) + ev->length + 1;
 	}
-
-	hci_dev_unlock(hdev);
 }
 
 static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
-- 
1.7.9


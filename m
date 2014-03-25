Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Store also RSSI for pending advertising reports
Date: Tue, 25 Mar 2014 14:35:00 +0200
Message-Id: <1395750900-10755-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395750900-10755-1-git-send-email-johan.hedberg@gmail.com>
References: <1395750900-10755-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Especially in crowded environments it can become frequent that we have
to send out whatever pending event there is stored. Since user space
has its own filtering of small RSSI changes sending a 0 value will
essentially force user space to wake up the higher layers (e.g. over
D-Bus) even though the RSSI didn't actually change more than the
threshold value.

This patch adds storing also of the RSSI for pending advertising reports
so that we report an as accurate RSSI as possible when we have to send
out the stored information to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_event.c        | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0ba7617ceb27..f5d665ff6111 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -70,6 +70,7 @@ struct discovery_state {
 	__u32			timestamp;
 	bdaddr_t		last_adv_addr;
 	u8			last_adv_addr_type;
+	s8			rssi;
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
 };
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1b2221d62007..3ba783576879 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1049,12 +1049,13 @@ static void clear_pending_adv_report(struct hci_dev *hdev)
 }
 
 static void store_pending_adv_report(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				     u8 bdaddr_type, u8 *data, u8 len)
+				     s8 rssi, u8 bdaddr_type, u8 *data, u8 len)
 {
 	struct discovery_state *d = &hdev->discovery;
 
 	bacpy(&d->last_adv_addr, bdaddr);
 	d->last_adv_addr_type = bdaddr_type;
+	d->rssi = rssi;
 	memcpy(d->last_adv_data, data, len);
 	d->last_adv_data_len = len;
 }
@@ -4040,7 +4041,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
-						 data, len);
+						 rssi, data, len);
 			return;
 		}
 
@@ -4061,7 +4062,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		/* Send out whatever is in the cache, but skip duplicates */
 		if (!match)
 			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
-					  d->last_adv_addr_type, NULL, 0,
+					  d->last_adv_addr_type, NULL, d->rssi,
 					  0, 1, d->last_adv_data,
 					  d->last_adv_data_len, NULL, 0);
 
@@ -4070,7 +4071,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		if (type == LE_ADV_IND || type == LE_ADV_SCAN_IND) {
 			store_pending_adv_report(hdev, bdaddr, bdaddr_type,
-						 data, len);
+						 rssi, data, len);
 			return;
 		}
 
-- 
1.8.5.3


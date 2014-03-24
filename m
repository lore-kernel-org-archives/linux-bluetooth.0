Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: Don't send device found events during passive scanning
Date: Mon, 24 Mar 2014 10:48:01 +0200
Message-Id: <1395650883-25577-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com>
References: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Passive LE scanning is only used by the kernel-internal connection
establishment procedure. It makes therefore little sense to send device
found events to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 43872af20aa4..403c1d96331a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3944,8 +3944,12 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
 {
-	if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
-		check_pending_le_conn(hdev, bdaddr, bdaddr_type);
+	/* Passive scanning shouldn't trigger any device found events */
+	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
+		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
+			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
+	    return;
+	}
 
 	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
 			  data, len);
-- 
1.8.5.3


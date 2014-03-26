Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix RSSI value in device found event from disabling scan
Date: Wed, 26 Mar 2014 14:17:12 +0200
Message-Id: <1395836232-10425-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When sending a pending device found event triggered by disabling LE
scanning we should use the stored RSSI instead of sending a zero value.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2ecb34f2e2ad..ddb518c62ed1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1091,8 +1091,9 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 			struct discovery_state *d = &hdev->discovery;
 
 			mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
-					  d->last_adv_addr_type, NULL, 0, 0,
-					  1, d->last_adv_data,
+					  d->last_adv_addr_type, NULL,
+					  d->last_adv_rssi, 0, 1,
+					  d->last_adv_data,
 					  d->last_adv_data_len, NULL, 0);
 		}
 
-- 
1.9.0


Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix merge of advertising data and scan response data
Date: Tue,  1 Jul 2014 13:59:15 +0200
Message-Id: <1404215955-39965-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The advertising data and scan response data are merged in the wrong
order. It should be advertsing data first and then scan response data
and not the other way around.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f7c2f40f1eac..8097559ebb48 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4301,7 +4301,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 */
 	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 			  d->last_adv_addr_type, NULL, rssi, d->last_adv_flags,
-			  data, len, d->last_adv_data, d->last_adv_data_len);
+			  d->last_adv_data, d->last_adv_data_len, data, len);
 	clear_pending_adv_report(hdev);
 }
 
-- 
1.9.3


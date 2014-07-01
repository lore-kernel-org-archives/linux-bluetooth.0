Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Fix merge of advertising data and scan response data
Date: Tue,  1 Jul 2014 14:11:19 +0200
Message-Id: <1404216681-51713-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The advertising data and scan response data are merged in the wrong
order. It should be advertsing data first and then scan response data
and not the other way around.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org # 3.16
---
 net/bluetooth/hci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fe7a54b65e55..ea155183c1d6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4270,8 +4270,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * sending a merged device found event.
 	 */
 	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
-			  d->last_adv_addr_type, NULL, rssi, 0, 1, data, len,
-			  d->last_adv_data, d->last_adv_data_len);
+			  d->last_adv_addr_type, NULL, rssi, 0, 1,
+			  d->last_adv_data, d->last_adv_data_len, data, len);
 	clear_pending_adv_report(hdev);
 }
 
-- 
1.9.3


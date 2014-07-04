Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't take actions on blocked devices when scanning
Date: Fri,  4 Jul 2014 16:15:49 +0300
Message-Id: <1404479749-7816-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If a found device is marked as blocked while doing passive LE scanning,
neither report it nor try to connect to it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c380545f1e92..27c1d2edeebe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4239,6 +4239,10 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			bdaddr_type = irk->addr_type;
 		}
 
+		/* Ignore if the device is blocked */
+		if (hci_blacklist_lookup(hdev, bdaddr, bdaddr_type))
+			return;
+
 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND) {
 			if (check_pending_le_conn(hdev, bdaddr, bdaddr_type))
 				return;
-- 
1.9.3


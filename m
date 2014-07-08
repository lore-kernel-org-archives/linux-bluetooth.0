Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix clearing HCI_LE_ADV for LE connections
Date: Tue,  8 Jul 2014 17:21:51 +0300
Message-Id: <1404829311-6903-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All LE controllers always implicitly stop advertising when establishing
connections. Therefore, be sure to clear the flag in the event handler
for new LE connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2b3d366e5d98..f6997901bdd7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4097,6 +4097,11 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
+	/* All controllers implicitly stop advertising in the event of a
+	 * connection, so ensure that the state bit is cleared.
+	 */
+	clear_bit(HCI_LE_ADV, &hdev->dev_flags);
+
 	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 	if (!conn) {
 		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
-- 
1.9.3


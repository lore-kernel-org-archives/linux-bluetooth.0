Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Update source address and type for incoming LE connections
Date: Sun, 13 Oct 2013 07:25:18 -0700
Message-Id: <1381674318-6590-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The incoming LE connections do not have a proper source address and
address type set. The connection needs to be set with the same values
as used for advertising parameters.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bbe2d29..aa6fed3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3477,6 +3477,17 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		conn->dst_type = ev->bdaddr_type;
 
+		/* The advertising parameters for own address type
+		 * define which source address and source address
+		 * type this connections has.
+		 */
+		if (bacmp(&conn->src, BDADDR_ANY)) {
+			conn->src_type = ADDR_LE_DEV_PUBLIC;
+		} else {
+			bacpy(&conn->src, &hdev->static_addr);
+			conn->src_type = ADDR_LE_DEV_RANDOM;
+		}
+
 		if (ev->role == LE_CONN_ROLE_MASTER) {
 			conn->out = true;
 			conn->link_mode |= HCI_LM_MASTER;
-- 
1.8.3.1


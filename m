Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Report identity address when remote device connects
Date: Tue, 18 Feb 2014 14:22:19 -0800
Message-Id: <1392762140-18655-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the remote device has been successfully connected, report the
identity address (public address or static random address).

Currently the address from the HCI_LE_Connection_Complete event is
used. This was no problem so far, but since now known resolvable
random addresses are converted into identities, it is important to
use the identity of the connection and not the address report by
HCI event.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 49a2d4d841df..d7c709519e31 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3618,7 +3618,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
+		mgmt_device_connected(hdev, &conn->dst, conn->type,
 				      conn->dst_type, 0, NULL, 0, NULL);
 
 	conn->sec_level = BT_SECURITY_LOW;
-- 
1.8.5.3


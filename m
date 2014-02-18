Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use connection address for reporting connection failures
Date: Tue, 18 Feb 2014 14:22:20 -0800
Message-Id: <1392762140-18655-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When reporting connect failed events to userspace, use the address
of the connection and not the address from the HCI event.

This change is strictly speaking not needed since BR/EDR does not
have the concept of resolvable random addresses. It is more for
making the code consistent.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d7c709519e31..22bfc5c17e7f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1704,7 +1704,7 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	} else {
 		conn->state = BT_CLOSED;
 		if (conn->type == ACL_LINK)
-			mgmt_connect_failed(hdev, &ev->bdaddr, conn->type,
+			mgmt_connect_failed(hdev, &conn->dst, conn->type,
 					    conn->dst_type, ev->status);
 	}
 
-- 
1.8.5.3


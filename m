Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/2] Bluetooth: Add support for sending connection events for LE links
Date: Fri,  6 May 2011 18:41:43 -0300
Message-Id: <1304718104-6448-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to be able for receive events notifying that the connection
was established, the connection attempt failed or that disconnection
happened.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_event.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d5aa97e..f13ddbf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1440,7 +1440,7 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	conn->state = BT_CLOSED;
 
-	if (conn->type == ACL_LINK)
+	if (conn->type == ACL_LINK || conn->type == LE_LINK)
 		mgmt_disconnected(hdev->id, &conn->dst);
 
 	hci_proto_disconn_cfm(conn, ev->reason);
@@ -2659,12 +2659,15 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	}
 
 	if (ev->status) {
+		mgmt_connect_failed(hdev->id, &ev->bdaddr, ev->status);
 		hci_proto_connect_cfm(conn, ev->status);
 		conn->state = BT_CLOSED;
 		hci_conn_del(conn);
 		goto unlock;
 	}
 
+	mgmt_connected(hdev->id, &ev->bdaddr);
+
 	conn->handle = __le16_to_cpu(ev->handle);
 	conn->state = BT_CONNECTED;
 
-- 
1.7.4.3


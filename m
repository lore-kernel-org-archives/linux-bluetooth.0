Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 1/4] Bluetooth: Add 'dst_type' field to struct hci_conn
Date: Tue, 31 May 2011 14:20:54 -0300
Message-Id: <1306862457-20310-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new field (dst_type) to the struct hci_conn which
holds the type of the destination address (bdaddr_t dst). This
approach is needed in order to use the struct hci_conn as an
abstraction of LE connections in HCI Layer. For non-LE this field
is ignored.

This patch also set properly the 'dst_type' field after initializing
LE hci_conn structures.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_event.c        |    8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index af4b0ed..539eb85 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -224,6 +224,7 @@ struct hci_conn {
 	spinlock_t	lock;
 
 	bdaddr_t	dst;
+	__u8            dst_type;
 	__u16		handle;
 	__u16		state;
 	__u8		mode;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c456f9c..6cb73dd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1236,10 +1236,12 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 	} else {
 		if (!conn) {
 			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr);
-			if (conn)
+			if (conn) {
+				conn->dst_type = cp->peer_addr_type;
 				conn->out = 1;
-			else
+			} else {
 				BT_ERR("No memory for new connection");
+			}
 		}
 	}
 
@@ -2689,6 +2691,8 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 			hci_dev_unlock(hdev);
 			return;
 		}
+
+		conn->dst_type = ev->bdaddr_type;
 	}
 
 	if (ev->status) {
-- 
1.7.4.1


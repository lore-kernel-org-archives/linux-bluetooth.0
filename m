Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] Bluetooth: Fix typo on hci_event.c
Date: Sun, 18 Jul 2010 15:13:37 -0300
Message-Id: <1279476817-15721-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

memmory -> memory

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_event.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a969800..2069c3b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -584,7 +584,7 @@ static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 				conn->out = 1;
 				conn->link_mode |= HCI_LM_MASTER;
 			} else
-				BT_ERR("No memmory for new connection");
+				BT_ERR("No memory for new connection");
 		}
 	}
 
@@ -965,7 +965,7 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 		if (!conn) {
 			if (!(conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr))) {
-				BT_ERR("No memmory for new connection");
+				BT_ERR("No memory for new connection");
 				hci_dev_unlock(hdev);
 				return;
 			}
-- 
1.7.1.1

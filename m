Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 4/6] Bluetooth: Check advertising cache in hci_connect()
Date: Fri, 11 Mar 2011 10:32:55 -0300
Message-Id: <1299850377-3734-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
References: <1299850377-3734-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When connecting to a LE device, we need to check the advertising cache
in order to know the bdaddr_type of that device. Additionally,
hci_le_connect() was changed to handle the bdaddr_type info.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9a4a769..2d3197a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -45,7 +45,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-static void hci_le_connect(struct hci_conn *conn)
+static void hci_le_connect(struct hci_conn *conn, u8 bdaddr_type)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_conn cp;
@@ -59,6 +59,7 @@ static void hci_le_connect(struct hci_conn *conn)
 	cp.scan_interval = cpu_to_le16(0x0004);
 	cp.scan_window = cpu_to_le16(0x0004);
 	bacpy(&cp.peer_addr, &conn->dst);
+	cp.peer_addr_type = bdaddr_type;
 	cp.conn_interval_min = cpu_to_le16(0x0008);
 	cp.conn_interval_max = cpu_to_le16(0x0100);
 	cp.supervision_timeout = cpu_to_le16(0x0064);
@@ -482,8 +483,13 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
-		if (le->state == BT_OPEN)
-			hci_le_connect(le);
+		if (le->state == BT_OPEN) {
+			struct adv_entry *entry = hci_find_adv_entry(hdev, dst);
+			if (!entry)
+				return ERR_PTR(-EHOSTUNREACH);
+
+			hci_le_connect(le, entry->bdaddr_type);
+		}
 
 		hci_conn_hold(le);
 
-- 
1.7.1


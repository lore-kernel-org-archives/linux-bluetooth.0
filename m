Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 3/5] Bluetooth: Add device addr type to hci_le_connect
Date: Mon, 14 Feb 2011 18:59:58 -0300
Message-Id: <4d59a603.859ddc0a.46cb.514b@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch improves hci_connect and hci_le_connect in order to use the
remote address type stored in advertise reports list.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ee7dcdd..2c91f4e 100644
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
@@ -461,8 +462,13 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 			le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
 			return NULL;
-		if (le->state == BT_OPEN)
-			hci_le_connect(le);
+		if (le->state == BT_OPEN) {
+			struct adv_entry *entry = hci_find_adv_entry(hdev, dst);
+			if (entry)
+				hci_le_connect(le, entry->bdaddr_type);
+			else
+				hci_le_connect(le, ADDR_DEV_PUBLIC);
+		}
 
 		hci_conn_hold(le);
 
-- 
1.7.1


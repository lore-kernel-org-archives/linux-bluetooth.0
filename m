Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Store the source address type of LE connections
Date: Sun, 13 Oct 2013 03:57:39 -0700
Message-Id: <1381661859-32200-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When establishing LE connections, it is possible to use a public
address (if available) or a random address. The type of address
is only known when creating connections, so make sure it is
stored in hci_conn structure.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7889495..714da9e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -300,6 +300,7 @@ struct hci_conn {
 
 	bdaddr_t	dst;
 	__u8		dst_type;
+	__u8		src_type;
 	__u16		handle;
 	__u16		state;
 	__u8		mode;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bb32f48..d9f7f93 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -566,10 +566,7 @@ static int hci_create_le_conn(struct hci_conn *conn)
 	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
 	bacpy(&cp.peer_addr, &conn->dst);
 	cp.peer_addr_type = conn->dst_type;
-	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
-	else
-		cp.own_address_type = ADDR_LE_DEV_RANDOM;
+	cp.own_address_type = conn->src_type;
 	cp.conn_interval_min = __constant_cpu_to_le16(0x0028);
 	cp.conn_interval_max = __constant_cpu_to_le16(0x0038);
 	cp.supervision_timeout = __constant_cpu_to_le16(0x002a);
@@ -626,6 +623,12 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		conn->dst_type = ADDR_LE_DEV_PUBLIC;
 	else
 		conn->dst_type = ADDR_LE_DEV_RANDOM;
+
+	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+		conn->src_type = ADDR_LE_DEV_PUBLIC;
+	else
+		conn->src_type = ADDR_LE_DEV_RANDOM;
+
 	conn->state = BT_CONNECT;
 	conn->out = true;
 	conn->link_mode |= HCI_LM_MASTER;
-- 
1.8.3.1


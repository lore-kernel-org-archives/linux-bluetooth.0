Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 01/35] emulator: Add support for multiple connections
Date: Wed, 12 Jun 2013 08:56:47 -0400
Message-Id: <1371041841-21793-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

In order to support multiple connections in emulator, we need to change
any access from btdev->conn to connection_list helpers.
Each time a connection is established, a handle is created to identify
this connection. That way a btdev can have more than one connection at
same time.
---
 emulator/btdev.c |  143 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 108 insertions(+), 35 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d88c853..4baf019 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -45,8 +45,6 @@
 struct btdev {
 	enum btdev_type type;
 
-	struct btdev *conn;
-
 	btdev_command_func command_handler;
 	void *command_data;
 
@@ -100,6 +98,16 @@ struct btdev {
 
 static struct btdev *btdev_list[MAX_BTDEV_ENTRIES] = { };
 
+struct connection {
+	uint16_t handle;
+	struct btdev *dev1;
+	struct btdev *dev2;
+};
+
+#define MAX_CONNECTION_ENTRIES 32
+
+static struct connection *connection_list[MAX_CONNECTION_ENTRIES] = { };
+
 static inline int add_btdev(struct btdev *btdev)
 {
 	int i, index = -1;
@@ -142,6 +150,67 @@ static inline struct btdev *find_btdev_by_bdaddr(const uint8_t *bdaddr)
 	return NULL;
 }
 
+static struct connection *add_connection(struct btdev *dev1, struct btdev *dev2)
+{
+	static uint16_t actual_handle = 1;
+	struct connection *conn = NULL;
+	int i;
+
+	for (i = 0; i < MAX_CONNECTION_ENTRIES; i++) {
+		if (connection_list[i] == NULL) {
+			conn = malloc(sizeof(*conn));
+			memset(conn, 0, sizeof(*conn));
+			conn->handle = actual_handle++;
+			conn->dev1 = dev1;
+			conn->dev2 = dev2;
+			connection_list[i] = conn;
+			break;
+		}
+	}
+
+	return conn;
+}
+
+static void del_connection(struct connection *conn)
+{
+	int i;
+
+	for (i = 0; i < MAX_CONNECTION_ENTRIES; i++) {
+		if (connection_list[i] == conn) {
+			free(conn);
+			connection_list[i] = NULL;
+			break;
+		}
+	}
+}
+
+static struct connection *find_connection_by_handle(uint16_t handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_CONNECTION_ENTRIES; i++)
+		if (connection_list[i] && connection_list[i]->handle == handle)
+			return connection_list[i];
+
+	return NULL;
+}
+
+static struct btdev *find_remote_of_connection(struct btdev *local,
+								uint16_t handle)
+{
+	struct btdev *remote = NULL;
+	struct connection *conn = find_connection_by_handle(handle);
+
+	if (conn) {
+		if (conn->dev1 == local)
+			remote = conn->dev2;
+		else
+			remote = conn->dev1;
+	}
+
+	return remote;
+}
+
 static void hexdump(const unsigned char *buf, uint16_t len)
 {
 	static const char hexdigits[] = "0123456789abcdef";
@@ -548,18 +617,15 @@ static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
 	send_event(btdev, BT_HCI_EVT_CMD_STATUS, &cs, sizeof(cs));
 }
 
-static void num_completed_packets(struct btdev *btdev)
+static void num_completed_packets(struct btdev *btdev, uint16_t handle)
 {
-	if (btdev->conn) {
-		struct bt_hci_evt_num_completed_packets ncp;
+	struct bt_hci_evt_num_completed_packets ncp;
 
-		ncp.num_handles = 1;
-		ncp.handle = cpu_to_le16(42);
-		ncp.count = cpu_to_le16(1);
+	ncp.num_handles = 1;
+	ncp.handle = cpu_to_le16(handle);
+	ncp.count = cpu_to_le16(1);
 
-		send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS,
-							&ncp, sizeof(ncp));
-	}
+	send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS, &ncp, sizeof(ncp));
 }
 
 static void inquiry_complete(struct btdev *btdev, uint8_t status)
@@ -630,20 +696,18 @@ static void conn_complete(struct btdev *btdev,
 
 	if (!status) {
 		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
-
-		btdev->conn = remote;
-		remote->conn = btdev;
+		struct connection *conn = add_connection(btdev, remote);
 
 		cc.status = status;
 		memcpy(cc.bdaddr, btdev->bdaddr, 6);
 		cc.encr_mode = 0x00;
 
-		cc.handle = cpu_to_le16(42);
+		cc.handle = cpu_to_le16(conn->handle);
 		cc.link_type = 0x01;
 
 		send_event(remote, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
 
-		cc.handle = cpu_to_le16(42);
+		cc.handle = cpu_to_le16(conn->handle);
 		cc.link_type = 0x01;
 	} else {
 		cc.handle = cpu_to_le16(0x0000);
@@ -681,7 +745,7 @@ static void disconnect_complete(struct btdev *btdev, uint16_t handle,
 							uint8_t reason)
 {
 	struct bt_hci_evt_disconnect_complete dc;
-	struct btdev *remote;
+	struct connection *conn;
 
 	if (!btdev) {
 		dc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
@@ -697,13 +761,14 @@ static void disconnect_complete(struct btdev *btdev, uint16_t handle,
 	dc.handle = cpu_to_le16(handle);
 	dc.reason = reason;
 
-	remote = btdev->conn;
-
-	btdev->conn = NULL;
-	remote->conn = NULL;
-
-	send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
-	send_event(remote, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
+	conn = find_connection_by_handle(handle);
+	if (conn) {
+		send_event(conn->dev1, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc,
+								sizeof(dc));
+		send_event(conn->dev2, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc,
+								sizeof(dc));
+		del_connection(conn);
+	}
 }
 
 static void name_request_complete(struct btdev *btdev,
@@ -731,11 +796,12 @@ static void name_request_complete(struct btdev *btdev,
 static void remote_features_complete(struct btdev *btdev, uint16_t handle)
 {
 	struct bt_hci_evt_remote_features_complete rfc;
+	struct btdev *remote = find_remote_of_connection(btdev, handle);
 
-	if (btdev->conn) {
+	if (remote) {
 		rfc.status = BT_HCI_ERR_SUCCESS;
 		rfc.handle = cpu_to_le16(handle);
-		memcpy(rfc.features, btdev->conn->features, 8);
+		memcpy(rfc.features, remote->features, 8);
 	} else {
 		rfc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		rfc.handle = cpu_to_le16(handle);
@@ -750,8 +816,9 @@ static void remote_ext_features_complete(struct btdev *btdev, uint16_t handle,
 								uint8_t page)
 {
 	struct bt_hci_evt_remote_ext_features_complete refc;
+	struct btdev *remote = find_remote_of_connection(btdev, handle);
 
-	if (btdev->conn && page < 0x02) {
+	if (remote && page < 0x02) {
 		refc.handle = cpu_to_le16(handle);
 		refc.page = page;
 		refc.max_page = 0x01;
@@ -759,7 +826,7 @@ static void remote_ext_features_complete(struct btdev *btdev, uint16_t handle,
 		switch (page) {
 		case 0x00:
 			refc.status = BT_HCI_ERR_SUCCESS;
-			memcpy(refc.features, btdev->conn->features, 8);
+			memcpy(refc.features, remote->features, 8);
 			break;
 		case 0x01:
 			refc.status = BT_HCI_ERR_SUCCESS;
@@ -785,13 +852,14 @@ static void remote_ext_features_complete(struct btdev *btdev, uint16_t handle,
 static void remote_version_complete(struct btdev *btdev, uint16_t handle)
 {
 	struct bt_hci_evt_remote_version_complete rvc;
+	struct btdev *remote = find_remote_of_connection(btdev, handle);
 
-	if (btdev->conn) {
+	if (remote) {
 		rvc.status = BT_HCI_ERR_SUCCESS;
 		rvc.handle = cpu_to_le16(handle);
-		rvc.lmp_ver = btdev->conn->version;
-		rvc.manufacturer = cpu_to_le16(btdev->conn->manufacturer);
-		rvc.lmp_subver = cpu_to_le16(btdev->conn->revision);
+		rvc.lmp_ver = remote->version;
+		rvc.manufacturer = cpu_to_le16(remote->manufacturer);
+		rvc.lmp_subver = cpu_to_le16(remote->revision);
 	} else {
 		rvc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		rvc.handle = cpu_to_le16(handle);
@@ -1563,6 +1631,8 @@ static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 {
 	uint8_t pkt_type;
+	uint16_t handle;
+	struct btdev *remote;
 
 	if (!btdev)
 		return;
@@ -1577,9 +1647,12 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 		process_cmd(btdev, data + 1, len - 1);
 		break;
 	case BT_H4_ACL_PKT:
-		if (btdev->conn)
-			send_packet(btdev->conn, data, len);
-		num_completed_packets(btdev);
+		handle = le16_to_cpu(((const uint16_t *) (data + 1))[0]);
+		remote = find_remote_of_connection(btdev, handle);
+		if (remote) {
+			send_packet(remote, data, len);
+			num_completed_packets(btdev, handle);
+		}
 		break;
 	default:
 		printf("Unsupported packet 0x%2.2x\n", pkt_type);
-- 
1.7.9.5


Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 08/35] emulator: Implement basic LE create connection
Date: Wed, 12 Jun 2013 08:56:54 -0400
Message-Id: <1371041841-21793-9-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Bind two LE virtual devices.
---
 emulator/btdev.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 171ca68..178971f 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -930,6 +930,43 @@ static void le_set_scan_enable_complete(struct btdev *btdev)
 	}
 }
 
+static void le_conn_complete(struct btdev *btdev, const uint8_t *bdaddr,
+						uint16_t handle, uint8_t role)
+{
+	struct __packed {
+		uint8_t subevent;
+		struct bt_hci_evt_le_conn_complete lcc;
+	} meta_event;
+
+	memset(&meta_event, 0, sizeof(meta_event));
+	meta_event.subevent = BT_HCI_EVT_LE_CONN_COMPLETE;
+	meta_event.lcc.handle = cpu_to_le16(handle);
+	meta_event.lcc.role = role;
+	memcpy(meta_event.lcc.peer_addr, bdaddr, 8);
+	/* 67.50 msec */
+	meta_event.lcc.interval = cpu_to_le16(54);
+
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, &meta_event,
+							sizeof(meta_event));
+}
+
+static void le_conn_request(struct btdev *btdev, const uint8_t *bdaddr)
+{
+	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+
+	/* TODO: check if is ADV connectable */
+	if (remote && remote->le_adv_enable) {
+		struct connection *conn = add_connection(btdev, remote);
+		/* disable advertising after connection succeeds */
+		remote->le_adv_enable = 0;
+
+		/* notify starter (Master) */
+		le_conn_complete(btdev, bdaddr, conn->handle, 0);
+		/* notify receiver (Slave) */
+		le_conn_complete(remote, btdev->bdaddr, conn->handle, 1);
+	}
+}
+
 static void default_cmd(struct btdev *btdev, uint16_t opcode,
 						const void *data, uint8_t len)
 {
@@ -965,6 +1002,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_set_adv_data *lsad;
 	const struct bt_hci_cmd_le_set_adv_enable *lsae;
 	const struct bt_hci_cmd_le_set_scan_enable *lsse;
+	const struct bt_hci_cmd_le_create_conn *lcc;
 	struct bt_hci_rsp_read_default_link_policy rdlp;
 	struct bt_hci_rsp_read_stored_link_key rslk;
 	struct bt_hci_rsp_write_stored_link_key wslk;
@@ -1614,6 +1652,14 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			le_set_scan_enable_complete(btdev);
 		break;
 
+	case BT_HCI_CMD_LE_CREATE_CONN:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		lcc = data;
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		le_conn_request(btdev, lcc->peer_addr);
+		break;
+
 	case BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE:
 		if (btdev->type == BTDEV_TYPE_BREDR)
 			goto unsupported;
-- 
1.7.9.5


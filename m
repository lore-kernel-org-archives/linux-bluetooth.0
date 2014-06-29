Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add support for Add/Remove Device management commands
Date: Sun, 29 Jun 2014 19:44:03 +0200
Message-Id: <1404063843-48945-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows adding or removing devices from the background scanning
list the kernel maintains. Device flagged for auto-connection will
be automatically connected if they are found.

The passive scanning required for auto-connection will be started
and stopped on demand.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 13 ++++++
 net/bluetooth/mgmt.c         | 99 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3109dec13409..bc9b105f2b50 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -436,6 +436,19 @@ struct mgmt_rp_get_clock_info {
 	__le16  accuracy;
 } __packed;
 
+#define MGMT_OP_ADD_DEVICE		0x0033
+struct mgmt_cp_add_device {
+	struct mgmt_addr_info addr;
+	__u8	action;
+} __packed;
+#define MGMT_ADD_DEVICE_SIZE		(MGMT_ADDR_INFO_SIZE + 1)
+
+#define MGMT_OP_REMOVE_DEVICE		0x0034
+struct mgmt_cp_remove_device {
+	struct mgmt_addr_info addr;
+} __packed;
+#define MGMT_REMOVE_DEVICE_SIZE		MGMT_ADDR_INFO_SIZE
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 41b1aec0c5dc..64b55c7881ee 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -86,6 +86,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_LOAD_IRKS,
 	MGMT_OP_GET_CONN_INFO,
 	MGMT_OP_GET_CLOCK_INFO,
+	MGMT_OP_ADD_DEVICE,
+	MGMT_OP_REMOVE_DEVICE,
 };
 
 static const u16 mgmt_events[] = {
@@ -4966,6 +4968,100 @@ unlock:
 	return err;
 }
 
+static int add_device(struct sock *sk, struct hci_dev *hdev,
+		      void *data, u16 len)
+{
+	struct mgmt_cp_add_device *cp = data;
+	u8 auto_conn, addr_type;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!bdaddr_type_is_le(cp->addr.type) ||
+	    !bacmp(&cp->addr.bdaddr, BDADDR_ANY))
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &cp->addr, sizeof(cp->addr));
+
+	if (cp->action != 0x00 && cp->action != 0x01)
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &cp->addr, sizeof(cp->addr));
+
+	hci_dev_lock(hdev);
+
+	if (cp->addr.type == BDADDR_LE_PUBLIC)
+		addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		addr_type = ADDR_LE_DEV_RANDOM;
+
+	if (cp->action)
+		auto_conn = HCI_AUTO_CONN_ALWAYS;
+	else
+		auto_conn = HCI_AUTO_CONN_DISABLED;
+
+	if (hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type, auto_conn,
+				hdev->le_conn_min_interval,
+				hdev->le_conn_max_interval) < 0) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+				   MGMT_STATUS_FAILED,
+				   &cp->addr, sizeof(cp->addr));
+		goto unlock;
+	}
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int remove_device(struct sock *sk, struct hci_dev *hdev,
+			 void *data, u16 len)
+{
+	struct mgmt_cp_remove_device *cp = data;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	if (bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
+		u8 addr_type;
+
+		if (!bdaddr_type_is_le(cp->addr.type)) {
+			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
+					   MGMT_STATUS_INVALID_PARAMS,
+					   &cp->addr, sizeof(cp->addr));
+			goto unlock;
+		}
+
+		if (cp->addr.type == BDADDR_LE_PUBLIC)
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		else
+			addr_type = ADDR_LE_DEV_RANDOM;
+
+		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
+	} else {
+		if (cp->addr.type) {
+			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
+					   MGMT_STATUS_INVALID_PARAMS,
+					   &cp->addr, sizeof(cp->addr));
+			goto unlock;
+		}
+
+		hci_conn_params_clear(hdev);
+	}
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_DEVICE,
+			   MGMT_STATUS_SUCCESS, &cp->addr, sizeof(cp->addr));
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5023,9 +5119,10 @@ static const struct mgmt_handler {
 	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
 	{ get_conn_info,          false, MGMT_GET_CONN_INFO_SIZE },
 	{ get_clock_info,         false, MGMT_GET_CLOCK_INFO_SIZE },
+	{ add_device,             false, MGMT_ADD_DEVICE_SIZE },
+	{ remove_device,          false, MGMT_REMOVE_DEVICE_SIZE },
 };
 
-
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	void *buf;
-- 
1.9.3


Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 03/15] Bluetooth: Mgmt command for removing connection parameters
Date: Wed, 16 Oct 2013 20:17:53 -0300
Message-Id: <1381965485-9159-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the MGMT_OP_REMOVE_CONN_PARAM which removes from
the controller's list the connection parameters from a given device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/mgmt.h |  6 ++++++
 net/bluetooth/mgmt.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index ed689b5..a79100a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -378,6 +378,12 @@ struct mgmt_cp_add_conn_param {
 } __packed;
 #define MGMT_ADD_CONN_PARAM_SIZE	(MGMT_ADDR_INFO_SIZE + 5)
 
+#define MGMT_OP_REMOVE_CONN_PARAM	0x002E
+struct mgmt_cp_remove_conn_param {
+	struct mgmt_addr_info addr;
+} __packed;
+#define MGMT_REMOVE_CONN_PARAM_SIZE	MGMT_ADDR_INFO_SIZE
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5d1a2e8..c68aea5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -80,6 +80,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
 	MGMT_OP_ADD_CONN_PARAM,
+	MGMT_OP_REMOVE_CONN_PARAM,
 };
 
 static const u16 mgmt_events[] = {
@@ -4059,6 +4060,33 @@ static int add_conn_param(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			    NULL, 0);
 }
 
+static int remove_conn_param(struct sock *sk, struct hci_dev *hdev,
+			     void *cp_data, u16 len)
+{
+	struct mgmt_cp_remove_conn_param *cp = cp_data;
+	u8 status;
+	u8 addr_type;
+
+	if (cp->addr.type == BDADDR_BREDR)
+		return cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_CONN_PARAM,
+				    MGMT_STATUS_NOT_SUPPORTED, NULL, 0);
+
+	status = mgmt_le_support(hdev);
+	if (status)
+		return cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_CONN_PARAM,
+				    status, NULL, 0);
+
+	if (cp->addr.type == BDADDR_LE_PUBLIC)
+		addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		addr_type = ADDR_LE_DEV_RANDOM;
+
+	hci_remove_conn_param(hdev, &cp->addr.bdaddr, addr_type);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_CONN_PARAM,
+			    MGMT_STATUS_SUCCESS, NULL, 0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -4111,6 +4139,7 @@ static const struct mgmt_handler {
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
 	{ add_conn_param,         false, MGMT_ADD_CONN_PARAM_SIZE },
+	{ remove_conn_param,      false, MGMT_REMOVE_CONN_PARAM_SIZE },
 };
 
 
-- 
1.8.4


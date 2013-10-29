Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 15/15] Bluetooth: Mgmt command for removing connection parameters
Date: Tue, 29 Oct 2013 10:26:00 -0300
Message-Id: <1383053160-10175-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the MGMT_OP_REMOVE_CONN_PARAMS which removes
from hdev's list the connection parameters from a given device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/mgmt.h |  6 ++++++
 net/bluetooth/mgmt.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a16924f..92154c4 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -378,6 +378,12 @@ struct mgmt_cp_add_conn_params {
 } __packed;
 #define MGMT_ADD_CONN_PARAMS_SIZE	(MGMT_ADDR_INFO_SIZE + 5)
 
+#define MGMT_OP_REMOVE_CONN_PARAMS	0x002E
+struct mgmt_cp_remove_conn_params {
+	struct mgmt_addr_info addr;
+} __packed;
+#define MGMT_REMOVE_CONN_PARAMS_SIZE	MGMT_ADDR_INFO_SIZE
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b8e0f12..5056560 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -80,6 +80,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
 	MGMT_OP_ADD_CONN_PARAMS,
+	MGMT_OP_REMOVE_CONN_PARAMS,
 };
 
 static const u16 mgmt_events[] = {
@@ -4127,6 +4128,35 @@ static int add_conn_params(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			    MGMT_STATUS_SUCCESS, NULL, 0);
 }
 
+static int remove_conn_params(struct sock *sk, struct hci_dev *hdev,
+			      void *cp_data, u16 len)
+{
+	struct mgmt_cp_remove_conn_params *cp = cp_data;
+	u8 status;
+	u8 addr_type;
+
+	if (!bdaddr_type_is_le(cp->addr.type))
+		return cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_CONN_PARAMS,
+				    MGMT_STATUS_NOT_SUPPORTED, NULL, 0);
+
+	status = mgmt_le_support(hdev);
+	if (status)
+		return cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_CONN_PARAMS,
+				    status, NULL, 0);
+
+	if (cp->addr.type == BDADDR_LE_PUBLIC)
+		addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		addr_type = ADDR_LE_DEV_RANDOM;
+
+	hci_remove_conn_params(hdev, &cp->addr.bdaddr, addr_type);
+
+	hci_remove_pending_auto_conn(hdev, &cp->addr.bdaddr, addr_type);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_CONN_PARAMS,
+			    MGMT_STATUS_SUCCESS, NULL, 0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -4179,6 +4209,7 @@ static const struct mgmt_handler {
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
 	{ add_conn_params,        false, MGMT_ADD_CONN_PARAMS_SIZE },
+	{ remove_conn_params,     false, MGMT_REMOVE_CONN_PARAMS_SIZE },
 };
 
 
-- 
1.8.4


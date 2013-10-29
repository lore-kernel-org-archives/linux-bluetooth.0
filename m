Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 14/15] Bluetooth: Mgmt command for adding connection parameters
Date: Tue, 29 Oct 2013 10:25:59 -0300
Message-Id: <1383053160-10175-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a new Mgmt command (MGMT_OP_ADD_CONN_PARAMS)
to specify the connection parameters the kernel should use when
establishing connections to a certain device. Moreover, this command
also specifies the auto connection option the device requires.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/mgmt.h |  9 +++++++++
 net/bluetooth/mgmt.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 518c5c8..a16924f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -369,6 +369,15 @@ struct mgmt_cp_set_scan_params {
 } __packed;
 #define MGMT_SET_SCAN_PARAMS_SIZE	4
 
+#define MGMT_OP_ADD_CONN_PARAMS		0x002D
+struct mgmt_cp_add_conn_params {
+	struct mgmt_addr_info addr;
+	__u8 auto_connect;
+	__le16 min_conn_interval;
+	__le16 max_conn_interval;
+} __packed;
+#define MGMT_ADD_CONN_PARAMS_SIZE	(MGMT_ADDR_INFO_SIZE + 5)
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d396e47..b8e0f12 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -79,6 +79,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_BREDR,
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
+	MGMT_OP_ADD_CONN_PARAMS,
 };
 
 static const u16 mgmt_events[] = {
@@ -4080,6 +4081,52 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int add_conn_params(struct sock *sk, struct hci_dev *hdev, void *cp_data,
+			  u16 len)
+{
+	struct mgmt_cp_add_conn_params *cp = cp_data;
+	u8 status;
+	u8 addr_type;
+	int err;
+
+	if (!bdaddr_type_is_le(cp->addr.type))
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAMS,
+				    MGMT_STATUS_NOT_SUPPORTED, NULL, 0);
+
+	status = mgmt_le_support(hdev);
+	if (status)
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAMS,
+				    status, NULL, 0);
+
+	if (cp->addr.type == BDADDR_LE_PUBLIC)
+		addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		addr_type = ADDR_LE_DEV_RANDOM;
+
+	err = hci_add_conn_params(hdev, &cp->addr.bdaddr, addr_type,
+				  cp->auto_connect,
+				  __le16_to_cpu(cp->min_conn_interval),
+				  __le16_to_cpu(cp->max_conn_interval));
+	if (err)
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAMS,
+				    MGMT_STATUS_FAILED, NULL, 0);
+
+	if (cp->auto_connect == HCI_AUTO_CONN_ALWAYS) {
+		err = hci_add_pending_auto_conn(hdev, &cp->addr.bdaddr,
+						addr_type);
+		if (err) {
+			hci_remove_conn_params(hdev, &cp->addr.bdaddr,
+					       addr_type);
+			return cmd_complete(sk, hdev->id,
+					    MGMT_OP_ADD_CONN_PARAMS,
+					    MGMT_STATUS_FAILED, NULL, 0);
+		}
+	}
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAMS,
+			    MGMT_STATUS_SUCCESS, NULL, 0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -4131,6 +4178,7 @@ static const struct mgmt_handler {
 	{ set_bredr,              false, MGMT_SETTING_SIZE },
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
+	{ add_conn_params,        false, MGMT_ADD_CONN_PARAMS_SIZE },
 };
 
 
-- 
1.8.4


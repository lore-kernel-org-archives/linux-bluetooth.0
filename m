Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 02/15] Bluetooth: Mgmt command for adding connection parameters
Date: Wed, 16 Oct 2013 20:17:52 -0300
Message-Id: <1381965485-9159-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a new Mgmt command (MGMT_OP_ADD_CONN_PARAM) which
adds the connection parameters to controller's connection parameters
list. These parameters will be used by the kernel when it establishes a
connection with the given device.

This patch also moves the 'auto_connect' enum from hci_core.h to
bluetooth.h since the will accessed used by userspace in order to
send the MGMT_OP_ADD_CONN_PARAM command.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/bluetooth.h |  6 ++++++
 include/net/bluetooth/hci_core.h  |  6 +-----
 include/net/bluetooth/mgmt.h      |  9 +++++++++
 net/bluetooth/mgmt.c              | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bf2ddff..8509520 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -354,4 +354,10 @@ void sco_exit(void);
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
+enum {
+	BT_AUTO_CONN_DISABLED,
+	BT_AUTO_CONN_ALWAYS,
+	BT_AUTO_CONN_LINK_LOSS,
+};
+
 #endif /* __BLUETOOTH_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5052bf0..98be273 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -376,11 +376,7 @@ struct hci_conn_param {
 	bdaddr_t addr;
 	u8 addr_type;
 
-	enum {
-		HCI_AUTO_CONN_DISABLED,
-		HCI_AUTO_CONN_ALWAYS,
-		HCI_AUTO_CONN_LINK_LOSS,
-	} auto_connect;
+	u8 auto_connect;
 
 	u16 min_conn_interval;
 	u16 max_conn_interval;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 518c5c8..ed689b5 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -369,6 +369,15 @@ struct mgmt_cp_set_scan_params {
 } __packed;
 #define MGMT_SET_SCAN_PARAMS_SIZE	4
 
+#define MGMT_OP_ADD_CONN_PARAM		0x002D
+struct mgmt_cp_add_conn_param {
+	struct mgmt_addr_info addr;
+	__u8 auto_connect;
+	__le16 min_conn_interval;
+	__le16 max_conn_interval;
+} __packed;
+#define MGMT_ADD_CONN_PARAM_SIZE	(MGMT_ADDR_INFO_SIZE + 5)
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a727b47..5d1a2e8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -79,6 +79,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_BREDR,
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
+	MGMT_OP_ADD_CONN_PARAM,
 };
 
 static const u16 mgmt_events[] = {
@@ -4025,6 +4026,39 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int add_conn_param(struct sock *sk, struct hci_dev *hdev, void *cp_data,
+			  u16 len)
+{
+	struct mgmt_cp_add_conn_param *cp = cp_data;
+	u8 status;
+	u8 addr_type;
+
+	if (cp->addr.type == BDADDR_BREDR)
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM,
+				    MGMT_STATUS_NOT_SUPPORTED, NULL, 0);
+
+	status = mgmt_le_support(hdev);
+	if (status)
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM,
+				    status, NULL, 0);
+
+	if (cp->addr.type == BDADDR_LE_PUBLIC)
+		addr_type = ADDR_LE_DEV_PUBLIC;
+	else
+		addr_type = ADDR_LE_DEV_RANDOM;
+
+	if (hci_add_conn_param(hdev, &cp->addr.bdaddr, addr_type,
+			       cp->auto_connect,
+			       __le16_to_cpu(cp->min_conn_interval),
+			       __le16_to_cpu(cp->max_conn_interval)))
+		status = MGMT_STATUS_FAILED;
+	else
+		status = MGMT_STATUS_SUCCESS;
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM, status,
+			    NULL, 0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -4076,6 +4110,7 @@ static const struct mgmt_handler {
 	{ set_bredr,              false, MGMT_SETTING_SIZE },
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
+	{ add_conn_param,         false, MGMT_ADD_CONN_PARAM_SIZE },
 };
 
 
-- 
1.8.4


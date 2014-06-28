Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add support for Get Clock Info mgmt command
Date: Sat, 28 Jun 2014 17:54:07 +0300
Message-Id: <1403967247-15728-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com>
References: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch implements support for the Get Clock Information mgmt
command. This is done by performing one or two HCI_Read_Clock commands
and creating the response from the stored values in the hci_dev and
hci_conn structs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  12 ++++
 net/bluetooth/mgmt.c         | 145 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bcffc9ae0c89..d3f27bb46f89 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -424,6 +424,18 @@ struct mgmt_rp_get_conn_info {
 	__s8	max_tx_power;
 } __packed;
 
+#define MGMT_OP_GET_CLOCK_INFO		0x0033
+struct mgmt_cp_get_clock_info {
+	struct mgmt_addr_info addr;
+} __packed;
+#define MGMT_GET_CLOCK_INFO_SIZE	MGMT_ADDR_INFO_SIZE
+struct mgmt_rp_get_clock_info {
+	struct mgmt_addr_info addr;
+	__le32  local_clock;
+	__le32  piconet_clock;
+	__le16  accuracy;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 03fa50d1ff05..7a4f5b45a4fc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -85,6 +85,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_PRIVACY,
 	MGMT_OP_LOAD_IRKS,
 	MGMT_OP_GET_CONN_INFO,
+	MGMT_OP_GET_CLOCK_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -571,6 +572,22 @@ static struct pending_cmd *mgmt_pending_find(u16 opcode, struct hci_dev *hdev)
 	return NULL;
 }
 
+static struct pending_cmd *mgmt_pending_find_data(u16 opcode,
+						  struct hci_dev *hdev,
+						  const void *data)
+{
+	struct pending_cmd *cmd;
+
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (cmd->user_data != data)
+			continue;
+		if (cmd->opcode == opcode)
+			return cmd;
+	}
+
+	return NULL;
+}
+
 static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0;
@@ -4820,6 +4837,132 @@ unlock:
 	return err;
 }
 
+static void get_clock_info_complete(struct hci_dev *hdev, u8 status)
+{
+	struct mgmt_cp_get_clock_info *cp;
+	struct mgmt_rp_get_clock_info rp;
+	struct hci_cp_read_clock *hci_cp;
+	struct pending_cmd *cmd;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status %u", hdev->name, status);
+
+	hci_dev_lock(hdev);
+
+	hci_cp = hci_sent_cmd_data(hdev, HCI_OP_READ_CLOCK);
+	if (!hci_cp)
+		goto unlock;
+
+	if (hci_cp->which) {
+		u16 handle = __le16_to_cpu(hci_cp->handle);
+		conn = hci_conn_hash_lookup_handle(hdev, handle);
+	} else {
+		conn = NULL;
+	}
+
+	cmd = mgmt_pending_find_data(MGMT_OP_GET_CLOCK_INFO, hdev, conn);
+	if (!cmd)
+		goto unlock;
+
+	cp = cmd->param;
+
+	memset(&rp, 0, sizeof(rp));
+	memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
+
+	if (status)
+		goto send_rsp;
+
+	rp.local_clock = cpu_to_le32(hdev->clock);
+
+	if (conn) {
+		rp.piconet_clock = cpu_to_le32(conn->clock);
+		rp.accuracy = cpu_to_le16(conn->clock_accuracy);
+	}
+
+send_rsp:
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(status),
+		     &rp, sizeof(rp));
+	mgmt_pending_remove(cmd);
+	if (conn)
+		hci_conn_put(conn);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static int get_clock_info(struct sock *sk, struct hci_dev *hdev, void *data,
+			 u16 len)
+{
+	struct mgmt_cp_get_clock_info *cp = data;
+	struct mgmt_rp_get_clock_info rp;
+	struct hci_cp_read_clock hci_cp;
+	struct pending_cmd *cmd;
+	struct hci_request req;
+	struct hci_conn *conn;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
+	if (cp->addr.type != BDADDR_BREDR)
+		return cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CLOCK_INFO,
+				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
+		goto unlock;
+	}
+
+	if (bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
+		if (!conn || conn->state != BT_CONNECTED) {
+			err = cmd_complete(sk, hdev->id,
+					   MGMT_OP_GET_CLOCK_INFO,
+					   MGMT_STATUS_NOT_CONNECTED,
+					   &rp, sizeof(rp));
+			goto unlock;
+		}
+	} else {
+		conn = NULL;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_GET_CLOCK_INFO, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	hci_req_init(&req, hdev);
+
+	memset(&hci_cp, 0, sizeof(hci_cp));
+	hci_req_add(&req, HCI_OP_READ_CLOCK, sizeof(hci_cp), &hci_cp);
+
+	if (conn) {
+		hci_conn_hold(conn);
+		cmd->user_data = conn;
+
+		hci_cp.handle = cpu_to_le16(conn->handle);
+		hci_cp.which = 0x01; /* Piconet clock */
+		hci_req_add(&req, HCI_OP_READ_CLOCK, sizeof(hci_cp), &hci_cp);
+	}
+
+	err = hci_req_run(&req, get_clock_info_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -4876,6 +5019,8 @@ static const struct mgmt_handler {
 	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
 	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
 	{ get_conn_info,          false, MGMT_GET_CONN_INFO_SIZE },
+	{ NULL }, /* Load Connection Parameters - not yet implemented */
+	{ get_clock_info,         false, MGMT_GET_CLOCK_INFO_SIZE },
 };
 
 
-- 
1.9.3


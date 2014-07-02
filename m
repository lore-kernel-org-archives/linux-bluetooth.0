Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] Bluetooth: Add Load Connection Parameters command
Date: Wed,  2 Jul 2014 17:37:29 +0300
Message-Id: <1404311854-12233-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch implements the new Load Connection Parameters mgmt command
that's intended to load the desired connection parameters for LE
devices.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h | 15 +++++++++
 net/bluetooth/mgmt.c         | 79 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3c0f29614d1b..5b3e8009eddd 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -449,6 +449,21 @@ struct mgmt_cp_remove_device {
 } __packed;
 #define MGMT_REMOVE_DEVICE_SIZE		MGMT_ADDR_INFO_SIZE
 
+struct mgmt_conn_param {
+	struct mgmt_addr_info addr;
+	__le16 min_interval;
+	__le16 max_interval;
+	__le16 latency;
+	__le16 timeout;
+} __packed;
+
+#define MGMT_OP_LOAD_CONN_PARAM		0x0035
+struct mgmt_cp_load_conn_param {
+	__le16 param_count;
+	struct mgmt_conn_param params[0];
+} __packed;
+#define MGMT_LOAD_CONN_PARAM_SIZE	2
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 574dd9f7c39e..59bf1ac41429 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -88,6 +88,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_GET_CLOCK_INFO,
 	MGMT_OP_ADD_DEVICE,
 	MGMT_OP_REMOVE_DEVICE,
+	MGMT_OP_LOAD_CONN_PARAM,
 };
 
 static const u16 mgmt_events[] = {
@@ -5134,6 +5135,83 @@ unlock:
 	return err;
 }
 
+static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 len)
+{
+	struct mgmt_cp_load_conn_param *cp = data;
+	u16 param_count, expected_len;
+	int i;
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	param_count = __le16_to_cpu(cp->param_count);
+
+	expected_len = sizeof(*cp) + param_count *
+					sizeof(struct mgmt_conn_param);
+	if (expected_len != len) {
+		BT_ERR("load_conn_param: expected %u bytes, got %u bytes",
+		       expected_len, len);
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM,
+				  MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	BT_DBG("%s param_count %u", hdev->name, param_count);
+
+	hci_dev_lock(hdev);
+
+	hci_conn_params_clear_disabled(hdev);
+
+	for (i = 0; i < param_count; i++) {
+		struct mgmt_conn_param *param = &cp->params[i];
+		struct hci_conn_params *hci_param;
+		u16 min, max, latency, timeout;
+		u8 addr_type;
+
+		BT_DBG("Adding %pMR (type %u)", &param->addr.bdaddr,
+		       param->addr.type);
+
+		if (param->addr.type == BDADDR_LE_PUBLIC) {
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		} else if (param->addr.type == BDADDR_LE_RANDOM) {
+			addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			BT_ERR("Ignoring invalid connection parameters");
+			continue;
+		}
+
+		min = le16_to_cpu(param->min_interval);
+		max = le16_to_cpu(param->max_interval);
+		latency = le16_to_cpu(param->latency);
+		timeout = le16_to_cpu(param->timeout);
+
+		BT_DBG("min 0x%04x max 0x%04x latency 0x%04x timeout 0x%04x",
+		       min, max, latency, timeout);
+
+		if (hci_check_conn_params(min, max, latency, timeout) < 0) {
+			BT_ERR("Ignoring invalid connection parameters");
+			continue;
+		}
+
+		hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
+						addr_type);
+		if (!hci_param) {
+			BT_ERR("Failed to add connection parameters");
+			continue;
+		}
+
+		hci_param->conn_min_interval = min;
+		hci_param->conn_max_interval = max;
+		hci_param->conn_latency = latency;
+		hci_param->supervision_timeout = timeout;
+	}
+
+	hci_dev_unlock(hdev);
+
+	return cmd_complete(sk, hdev->id, MGMT_OP_LOAD_CONN_PARAM, 0, NULL, 0);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5193,6 +5271,7 @@ static const struct mgmt_handler {
 	{ get_clock_info,         false, MGMT_GET_CLOCK_INFO_SIZE },
 	{ add_device,             false, MGMT_ADD_DEVICE_SIZE },
 	{ remove_device,          false, MGMT_REMOVE_DEVICE_SIZE },
+	{ load_conn_param,        true, MGMT_LOAD_CONN_PARAM_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
-- 
1.9.3


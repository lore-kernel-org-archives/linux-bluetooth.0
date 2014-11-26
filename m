Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v11 3/3] Bluetooth: start and stop service discovery
Date: Wed, 26 Nov 2014 14:51:25 -0800
Message-Id: <1417042285-4779-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1417042285-4779-1-git-send-email-jpawlowski@google.com>
References: <1417042285-4779-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces start service discovery method. The reason
behind that is to enable users to find specific services in range
by UUID. Whole filtering is done in mgmt_device_found.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   6 +
 include/net/bluetooth/mgmt.h     |   9 ++
 net/bluetooth/hci_core.c         |   2 +
 net/bluetooth/mgmt.c             | 277 +++++++++++++++++++++++++++++++++++----
 5 files changed, 268 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a8784e6..a88acee 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -211,6 +211,7 @@ enum {
  */
 enum {
 	HCI_LE_SCAN_RESTARTING,
+	HCI_SERVICE_FILTER,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7e10308..8017808 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -76,6 +76,11 @@ struct discovery_state {
 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
 	u8			last_adv_data_len;
 	unsigned long		flags;
+
+	/* sd prefix stands for service discovery related properties */
+	s8			sd_rssi;
+	u16			sd_num_uuid;
+	u8			(*sd_uuid)[16];
 };
 
 struct hci_conn_hash {
@@ -1396,6 +1401,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 u16 max_interval, u16 latency, u16 timeout);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
+void mgmt_clean_up_service_discovery(struct hci_dev *hdev);
 
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index b391fd6..dc21a5a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -495,6 +495,15 @@ struct mgmt_cp_set_public_address {
 } __packed;
 #define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
 
+#define MGMT_OP_START_SERVICE_DISCOVERY	0x003A
+struct mgmt_cp_start_service_discovery {
+	__u8 type;
+	__s8 rssi_threshold;
+	__le16 num_uuid;
+	__u8 uuid[0][16];
+} __packed;
+#define MGMT_START_SERVICE_DISCOVERY_SIZE 4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 688e2ca..c56c132 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3853,6 +3853,7 @@ static void le_scan_disable_work(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
+	mgmt_clean_up_service_discovery(hdev);
 
 	hci_req_init(&req, hdev);
 
@@ -3897,6 +3898,7 @@ static void le_scan_restart_work(struct work_struct *work)
 
 	memset(&cp, 0, sizeof(cp));
 	cp.enable = LE_SCAN_ENABLE;
+	cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 
 	set_bit(HCI_LE_SCAN_RESTARTING, &hdev->discovery.flags);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3e2ba4c..f6d9da7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -93,6 +93,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_CONFIG_INFO,
 	MGMT_OP_SET_EXTERNAL_CONFIG,
 	MGMT_OP_SET_PUBLIC_ADDRESS,
+	MGMT_OP_START_SERVICE_DISCOVERY,
 };
 
 static const u16 mgmt_events[] = {
@@ -1258,6 +1259,18 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
+/* cleans up the state set up by the start_service_discovery function. */
+void mgmt_clean_up_service_discovery(struct hci_dev *hdev)
+{
+	if (!test_and_clear_bit(HCI_SERVICE_FILTER, &hdev->discovery.flags))
+		return;
+
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+	if (hdev->discovery.sd_num_uuid > 0)
+		kfree(hdev->discovery.sd_uuid);
+	hdev->discovery.sd_num_uuid = 0;
+}
+
 static bool hci_stop_discovery(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1270,6 +1283,7 @@ static bool hci_stop_discovery(struct hci_request *req)
 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 		} else {
 			cancel_delayed_work(&hdev->le_scan_disable);
+			mgmt_clean_up_service_discovery(hdev);
 			hci_req_add_le_scan_disable(req);
 		}
 
@@ -3737,42 +3751,83 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
 }
 
+static int init_service_discovery(struct hci_dev *hdev, s8 rssi, u16 num_uuid,
+				  u8 (*uuid)[16])
+{
+	hdev->discovery.sd_rssi = rssi;
+	hdev->discovery.sd_num_uuid = num_uuid;
+
+	if (num_uuid > 0) {
+		hdev->discovery.sd_uuid = kmalloc(16 * num_uuid, GFP_KERNEL);
+		if (!hdev->discovery.sd_uuid)
+			return -ENOMEM;
+		memcpy(hdev->discovery.sd_uuid, uuid, 16 * num_uuid);
+	}
+
+	set_bit(HCI_SERVICE_FILTER, &hdev->discovery.flags);
+	return 0;
+}
+
 static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 				   void *data, u16 len, u16 opcode)
 {
-	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
 	struct hci_cp_le_set_scan_param param_cp;
 	struct hci_cp_le_set_scan_enable enable_cp;
 	struct hci_cp_inquiry inq_cp;
 	struct hci_request req;
 	/* General inquiry access code (GIAC) */
+	s8 sd_rssi = 0;
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	u8 status, own_addr_type;
+	u8 status, own_addr_type, type;
+	u8 (*sd_uuid)[16] = NULL;
+	u16 sd_num_uuid = 0;
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
+	if (opcode == MGMT_OP_START_SERVICE_DISCOVERY) {
+		struct mgmt_cp_start_service_discovery *cp = data;
+		u16 expected_len, num_uuid_tmp;
+
+		type = cp->type;
+		num_uuid_tmp = __le16_to_cpu(cp->num_uuid);
+		expected_len = sizeof(*cp) + num_uuid_tmp * 16;
+
+		if (expected_len != len) {
+			return cmd_complete(sk, hdev->id, opcode,
+					    MGMT_STATUS_INVALID_PARAMS, &type,
+					    sizeof(type));
+		}
+
+		sd_rssi = cp->rssi_threshold;
+		sd_num_uuid = num_uuid_tmp;
+		if (sd_num_uuid > 0)
+			sd_uuid = cp->uuid;
+	} else {
+		struct mgmt_cp_start_discovery *cp = data;
+
+		type = cp->type;
+	}
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
 		err = cmd_complete(sk, hdev->id, opcode,
-				   MGMT_STATUS_NOT_POWERED,
-				   &cp->type, sizeof(cp->type));
+				   MGMT_STATUS_NOT_POWERED, &type,
+				   sizeof(type));
 		goto failed;
 	}
 
 	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, opcode,
-				   MGMT_STATUS_BUSY, &cp->type,
-				   sizeof(cp->type));
+				   MGMT_STATUS_BUSY, &type, sizeof(type));
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
 		err = cmd_complete(sk, hdev->id, opcode,
-				   MGMT_STATUS_BUSY, &cp->type,
-				   sizeof(cp->type));
+				   MGMT_STATUS_BUSY, &type, sizeof(type));
 		goto failed;
 	}
 
@@ -3782,7 +3837,7 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	hdev->discovery.type = cp->type;
+	hdev->discovery.type = type;
 
 	hci_req_init(&req, hdev);
 
@@ -3790,16 +3845,16 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_BREDR:
 		status = mgmt_bredr_support(hdev);
 		if (status) {
-			err = cmd_complete(sk, hdev->id, opcode, status,
-					   &cp->type, sizeof(cp->type));
+			err = cmd_complete(sk, hdev->id, opcode, status, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
 			err = cmd_complete(sk, hdev->id, opcode,
-					   MGMT_STATUS_BUSY, &cp->type,
-					   sizeof(cp->type));
+					   MGMT_STATUS_BUSY, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3816,8 +3871,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_INTERLEAVED:
 		status = mgmt_le_support(hdev);
 		if (status) {
-			err = cmd_complete(sk, hdev->id, opcode, status,
-					   &cp->type, sizeof(cp->type));
+			err = cmd_complete(sk, hdev->id, opcode, status, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3825,8 +3880,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 			err = cmd_complete(sk, hdev->id, opcode,
-					   MGMT_STATUS_NOT_SUPPORTED,
-					   &cp->type, sizeof(cp->type));
+					   MGMT_STATUS_NOT_SUPPORTED, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3839,9 +3894,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
 						       BT_CONNECT)) {
 				err = cmd_complete(sk, hdev->id, opcode,
-						   MGMT_STATUS_REJECTED,
-						   &cp->type,
-						   sizeof(cp->type));
+						   MGMT_STATUS_REJECTED, &type,
+						   sizeof(type));
 				mgmt_pending_remove(cmd);
 				goto failed;
 			}
@@ -3865,8 +3919,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 		err = hci_update_random_address(&req, true, &own_addr_type);
 		if (err < 0) {
 			err = cmd_complete(sk, hdev->id, opcode,
-					   MGMT_STATUS_FAILED,
-					   &cp->type, sizeof(cp->type));
+					   MGMT_STATUS_FAILED, &type,
+					   sizeof(type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3887,13 +3941,21 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	default:
 		err = cmd_complete(sk, hdev->id, opcode,
-				   MGMT_STATUS_INVALID_PARAMS,
-				   &cp->type, sizeof(cp->type));
+				   MGMT_STATUS_INVALID_PARAMS, &type,
+				   sizeof(type));
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
+	if (opcode == MGMT_OP_START_SERVICE_DISCOVERY) {
+		err = init_service_discovery(hdev, sd_rssi, sd_num_uuid,
+					     sd_uuid);
+		if (err)
+			goto failed;
+	}
+
 	err = hci_req_run(&req, start_discovery_complete);
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
@@ -5685,6 +5747,13 @@ unlock:
 	return err;
 }
 
+static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len)
+{
+	return generic_start_discovery(sk, hdev, data, len,
+				       MGMT_OP_START_SERVICE_DISCOVERY);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5749,6 +5818,7 @@ static const struct mgmt_handler {
 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
+	{ start_service_discovery, true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -6815,6 +6885,127 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 	mgmt_pending_remove(cmd);
 }
 
+struct parsed_uuid {
+	struct list_head list;
+	u8 uuid[16];
+};
+
+/* this is reversed hex representation of bluetooth base uuid. We need it for
+ * service uuid parsing in eir.
+ */
+static const u8 reverse_base_uuid[] = {
+			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static int add_uuid_to_list(struct list_head *uuids, u8 *uuid)
+{
+	struct parsed_uuid *tmp_uuid;
+
+	tmp_uuid = kmalloc(sizeof(*tmp_uuid), GFP_KERNEL);
+	if (tmp_uuid == NULL)
+		return -ENOMEM;
+
+	memcpy(tmp_uuid->uuid, uuid, 16);
+	INIT_LIST_HEAD(&tmp_uuid->list);
+	list_add(&tmp_uuid->list, uuids);
+	return 0;
+}
+
+static void free_uuids_list(struct list_head *uuids)
+{
+	struct parsed_uuid *uuid, *tmp;
+
+	list_for_each_entry_safe(uuid, tmp, uuids, list) {
+		__list_del_entry(&uuid->list);
+		kfree(uuid);
+	}
+}
+
+static int eir_parse(u8 *eir, u8 eir_len, struct list_head *uuids)
+{
+	size_t offset;
+	u8 uuid[16];
+	int i, ret;
+
+	offset = 0;
+	while (offset < eir_len) {
+		uint8_t field_len = eir[0];
+
+		/* Check for the end of EIR */
+		if (field_len == 0)
+			break;
+
+		if (offset + field_len > eir_len)
+			return -EINVAL;
+
+		switch (eir[1]) {
+		case EIR_UUID16_ALL:
+		case EIR_UUID16_SOME:
+			for (i = 0; i + 3 <= field_len; i += 2) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				uuid[13] = eir[i + 3];
+				uuid[12] = eir[i + 2];
+				ret = add_uuid_to_list(uuids, uuid);
+				if (ret)
+					return ret;
+			}
+			break;
+		case EIR_UUID32_ALL:
+		case EIR_UUID32_SOME:
+			for (i = 0; i + 5 <= field_len; i += 4) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				uuid[15] = eir[i + 5];
+				uuid[14] = eir[i + 4];
+				uuid[13] = eir[i + 3];
+				uuid[12] = eir[i + 2];
+				ret = add_uuid_to_list(uuids, uuid);
+				if (ret)
+					return ret;
+			}
+			break;
+		case EIR_UUID128_ALL:
+		case EIR_UUID128_SOME:
+			for (i = 0; i + 17 <= field_len; i += 16) {
+				memcpy(uuid, eir + i + 2, 16);
+				ret = add_uuid_to_list(uuids, uuid);
+				if (ret)
+					return ret;
+			}
+			break;
+		}
+
+		offset += field_len + 1;
+		eir += field_len + 1;
+	}
+	return 0;
+}
+
+enum {
+	NO_MATCH,
+	SERVICE_MATCH,
+	FULL_MATCH
+};
+
+static u8 find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids)
+{
+	struct parsed_uuid *uuidptr, *tmp_uuid;
+	int i, match_type = NO_MATCH, min_rssi = hdev->discovery.sd_rssi;
+
+	list_for_each_entry_safe(uuidptr, tmp_uuid, uuids, list) {
+		for (i = 0; i < hdev->discovery.sd_num_uuid; i++) {
+			u8 *filter_uuid = hdev->discovery.sd_uuid[i];
+
+			if (memcmp(filter_uuid, uuidptr->uuid, 16) != 0)
+				continue;
+			if (rssi >= min_rssi)
+				return FULL_MATCH;
+			match_type = SERVICE_MATCH;
+		}
+	}
+	return match_type;
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
@@ -6822,6 +7013,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
+	LIST_HEAD(uuids);
+	int err = 0;
+	u8 match_type;
 
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
@@ -6860,7 +7054,31 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+	if (!test_bit(HCI_SERVICE_FILTER, &hdev->discovery.flags) ||
+	    (hdev->discovery.sd_rssi == 127 &&
+	     hdev->discovery.sd_num_uuid == 0)) {
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+		return;
+	}
+
+	err = eir_parse(eir, eir_len, &uuids);
+	if (err) {
+		free_uuids_list(&uuids);
+		return;
+	}
+
+	match_type = find_matches(hdev, rssi, &uuids);
+	free_uuids_list(&uuids);
+
+	if (match_type == NO_MATCH)
+		return;
+
+	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))
+		hci_restart_le_scan(hdev);
+
+	if (match_type == FULL_MATCH)
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
+			   ev_size, NULL);
 }
 
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
@@ -6893,10 +7111,15 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 
 	BT_DBG("%s discovering %u", hdev->name, discovering);
 
-	if (discovering)
+	if (discovering) {
 		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
-	else
+		if (cmd == NULL)
+			cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY,
+						hdev);
+
+	} else {
 		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
+	}
 
 	if (cmd != NULL) {
 		u8 type = hdev->discovery.type;
-- 
2.2.0.rc0.207.ga3a616c


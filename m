Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v8 3/3] Bluetooth: start and stop service discovery
Date: Fri, 21 Nov 2014 10:00:24 -0800
Message-Id: <1416592824-10087-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1416592824-10087-1-git-send-email-jpawlowski@google.com>
References: <1416592824-10087-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces start service discovery and stop service
discovery methods. The reason behind that is to enable users to find
specific services in range by UUID. Whole filtering is done in
mgmt_device_found.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h  |   1 +
 include/net/bluetooth/mgmt.h |  20 +++
 net/bluetooth/hci_core.c     |   1 +
 net/bluetooth/mgmt.c         | 352 ++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 338 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2f0bce2..97b0893 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -204,6 +204,7 @@ enum {
 	HCI_BREDR_ENABLED,
 	HCI_LE_SCAN_INTERRUPTED,
 	HCI_LE_SCAN_RESTARTING,
+	HCI_SERVICE_FILTER,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index b391fd6..513e469 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -495,6 +495,26 @@ struct mgmt_cp_set_public_address {
 } __packed;
 #define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
 
+#define MGMT_OP_START_SERVICE_DISCOVERY	0x003A
+#define MGMT_START_SERVICE_DISCOVERY_SIZE 1
+
+struct mgmt_uuid_filter {
+	__s8 rssi;
+	__u8 uuid[16];
+} __packed;
+
+struct mgmt_cp_start_service_discovery {
+	__u8 type;
+	__le16 filter_count;
+	struct mgmt_uuid_filter filter[0];
+} __packed;
+
+#define MGMT_OP_STOP_SERVICE_DISCOVERY	0x003B
+struct mgmt_cp_stop_service_discovery {
+	__u8 type;
+} __packed;
+#define MGMT_STOP_SERVICE_DISCOVERY_SIZE 1
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1c3d6e6..e3a9773 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3853,6 +3853,7 @@ static void le_scan_disable_work(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
+	mgmt_clean_up_service_discovery(hdev);
 
 	hci_req_init(&req, hdev);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2687fc2..2accf94 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -93,6 +93,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_CONFIG_INFO,
 	MGMT_OP_SET_EXTERNAL_CONFIG,
 	MGMT_OP_SET_PUBLIC_ADDRESS,
+	MGMT_OP_START_SERVICE_DISCOVERY,
+	MGMT_OP_STOP_SERVICE_DISCOVERY,
 };
 
 static const u16 mgmt_events[] = {
@@ -1258,6 +1260,24 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
+/* cleans up the state set up by the start_service_discovery function. */
+void mgmt_clean_up_service_discovery(struct hci_dev *hdev)
+{
+	struct uuid_filter *filter;
+	struct uuid_filter *tmp;
+
+	if (!test_and_clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags))
+		return;
+
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
+	list_for_each_entry_safe(filter, tmp, &hdev->discovery.uuid_filter,
+				 list) {
+		__list_del_entry(&filter->list);
+		kfree(filter);
+	}
+}
+
 static bool hci_stop_discovery(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1270,6 +1290,7 @@ static bool hci_stop_discovery(struct hci_request *req)
 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 		} else {
 			cancel_delayed_work(&hdev->le_scan_disable);
+			mgmt_clean_up_service_discovery(hdev);
 			hci_req_add_le_scan_disable(req);
 		}
 
@@ -3742,42 +3763,94 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	generic_start_discovery_complete(hdev, status, MGMT_OP_START_DISCOVERY);
 }
 
+static void start_service_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	generic_start_discovery_complete(hdev, status,
+					 MGMT_OP_START_SERVICE_DISCOVERY);
+}
+
+static int init_service_discovery(struct hci_dev *hdev,
+				  struct mgmt_uuid_filter *filters,
+				  u16 filter_cnt)
+{
+	int i;
+
+	for (i = 0; i < filter_cnt; i++) {
+		struct mgmt_uuid_filter *key = &filters[i];
+		struct uuid_filter *tmp;
+
+		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		memcpy(tmp->uuid, key->uuid, 16);
+		tmp->rssi = key->rssi;
+		INIT_LIST_HEAD(&tmp->list);
+
+		list_add(&tmp->list, &hdev->discovery.uuid_filter);
+	}
+	set_bit(HCI_SERVICE_FILTER, &hdev->dev_flags);
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
+	struct mgmt_uuid_filter *serv_filters = NULL;
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	u8 status, own_addr_type;
+	u8 status, own_addr_type, type;
 	int err;
+	u16 serv_filter_cnt = 0;
 
 	BT_DBG("%s", hdev->name);
 
+	if (opcode == MGMT_OP_START_SERVICE_DISCOVERY) {
+		struct mgmt_cp_start_service_discovery *cp = data;
+		u16 expected_len, filter_count;
+
+		type = cp->type;
+		filter_count = __le16_to_cpu(cp->filter_count);
+		expected_len = sizeof(*cp) +
+			filter_count * sizeof(struct mgmt_uuid_filter);
+
+		if (expected_len != len) {
+			return cmd_complete(sk, hdev->id, opcode,
+					    MGMT_STATUS_INVALID_PARAMS, &type,
+					    sizeof(type));
+		}
+
+		serv_filters = cp->filter;
+		serv_filter_cnt = filter_count;
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
 
@@ -3787,7 +3860,7 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	hdev->discovery.type = cp->type;
+	hdev->discovery.type = type;
 
 	hci_req_init(&req, hdev);
 
@@ -3795,16 +3868,16 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
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
@@ -3821,8 +3894,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
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
@@ -3830,8 +3903,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
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
@@ -3844,9 +3917,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
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
@@ -3870,8 +3942,8 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
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
@@ -3892,13 +3964,24 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	default:
 		err = cmd_complete(sk, hdev->id, opcode,
-				   MGMT_STATUS_INVALID_PARAMS,
-				   &cp->type, sizeof(cp->type));
+				   MGMT_STATUS_INVALID_PARAMS, &type,
+				   sizeof(type));
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
 
-	err = hci_req_run(&req, start_discovery_complete);
+	if (serv_filters != NULL) {
+		err = init_service_discovery(hdev, serv_filters,
+					     serv_filter_cnt);
+		if (err)
+			goto failed;
+	}
+
+	if (opcode == MGMT_OP_START_SERVICE_DISCOVERY)
+		err = hci_req_run(&req, start_service_discovery_complete);
+	else
+		err = hci_req_run(&req, start_discovery_complete);
+
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
@@ -3956,29 +4039,44 @@ static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
 	generic_stop_discovery_complete(hdev, status, MGMT_OP_STOP_DISCOVERY);
 }
 
+static void stop_service_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	generic_stop_discovery_complete(hdev, status,
+					MGMT_OP_STOP_SERVICE_DISCOVERY);
+}
+
 static int generic_stop_discovery(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 len, u16 opcode)
 {
-	struct mgmt_cp_stop_discovery *mgmt_cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
 	int err;
+	u8 type;
 
 	BT_DBG("%s", hdev->name);
 
+	if (opcode == MGMT_OP_STOP_SERVICE_DISCOVERY) {
+		struct mgmt_cp_stop_service_discovery *mgmt_cp = data;
+
+		type = mgmt_cp->type;
+	} else {
+		struct mgmt_cp_stop_discovery *mgmt_cp = data;
+
+		type = mgmt_cp->type;
+	}
+
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
 		err = cmd_complete(sk, hdev->id, opcode,
-				   MGMT_STATUS_REJECTED, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+				   MGMT_STATUS_REJECTED, &type, sizeof(type));
 		goto unlock;
 	}
 
-	if (hdev->discovery.type != mgmt_cp->type) {
+	if (hdev->discovery.type != type) {
 		err = cmd_complete(sk, hdev->id, opcode,
-				   MGMT_STATUS_INVALID_PARAMS, &mgmt_cp->type,
-				   sizeof(mgmt_cp->type));
+				   MGMT_STATUS_INVALID_PARAMS, &type,
+				   sizeof(type));
 		goto unlock;
 	}
 
@@ -3992,7 +4090,10 @@ static int generic_stop_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	hci_stop_discovery(&req);
 
-	err = hci_req_run(&req, stop_discovery_complete);
+	if (opcode == MGMT_OP_STOP_SERVICE_DISCOVERY)
+		err = hci_req_run(&req, stop_service_discovery_complete);
+	else
+		err = hci_req_run(&req, stop_discovery_complete);
 
 	if (!err) {
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
@@ -4004,7 +4105,7 @@ static int generic_stop_discovery(struct sock *sk, struct hci_dev *hdev,
 	/* If no HCI commands were sent we're done */
 	if (err == -ENODATA) {
 		err = cmd_complete(sk, hdev->id, opcode, 0,
-				   &mgmt_cp->type, sizeof(mgmt_cp->type));
+				   &type, sizeof(type));
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	}
 
@@ -5705,6 +5806,20 @@ unlock:
 	return err;
 }
 
+static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len)
+{
+	return generic_start_discovery(sk, hdev, data, len,
+				       MGMT_OP_START_SERVICE_DISCOVERY);
+}
+
+static int stop_service_discovery(struct sock *sk, struct hci_dev *hdev,
+				  void *data, u16 len)
+{
+	return generic_stop_discovery(sk, hdev, data, len,
+				      MGMT_OP_STOP_SERVICE_DISCOVERY);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5769,6 +5884,8 @@ static const struct mgmt_handler {
 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
+	{ start_service_discovery, true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
+	{ stop_service_discovery, false, MGMT_STOP_SERVICE_DISCOVERY_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -6835,6 +6952,135 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
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
+static u8 find_match(struct uuid_filter *filter, u8 uuid[16], s8 rssi)
+{
+	if (memcmp(filter->uuid, uuid, 16) != 0)
+		return NO_MATCH;
+	if (rssi >= filter->rssi)
+		return FULL_MATCH;
+
+	return SERVICE_MATCH;
+}
+
+static u8 find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids)
+{
+	struct uuid_filter *filter;
+	struct parsed_uuid *uuidptr, *tmp_uuid;
+	int match_type = NO_MATCH, tmp;
+
+	list_for_each_entry_safe(uuidptr, tmp_uuid, uuids, list) {
+		list_for_each_entry(filter, &hdev->discovery.uuid_filter,
+				    list) {
+			tmp = find_match(filter, uuidptr->uuid, rssi);
+			if (tmp > match_type)
+				match_type = tmp;
+		}
+	}
+	return match_type;
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
@@ -6842,6 +7088,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
+	LIST_HEAD(uuids);
+	int err = 0;
+	u8 match_type;
 
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
@@ -6880,7 +7129,30 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+	if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags) ||
+	    list_empty(&hdev->discovery.uuid_filter)) {
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
@@ -6913,10 +7185,18 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 
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
+		if (cmd == NULL)
+			cmd = mgmt_pending_find(MGMT_OP_STOP_SERVICE_DISCOVERY,
+						hdev);
+	}
 
 	if (cmd != NULL) {
 		u8 type = hdev->discovery.type;
-- 
2.1.0.rc2.206.gedb03e5


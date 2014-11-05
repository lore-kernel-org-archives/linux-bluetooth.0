Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 3/3] Bluetooth: start service discovery and stop service discovery
Date: Wed,  5 Nov 2014 14:37:26 -0800
Message-Id: <1415227046-28448-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1415227046-28448-1-git-send-email-jpawlowski@google.com>
References: <1415227046-28448-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces start service discovery and stop service
discovery methods. The reason behind that is to enable users to find
specific services in range by UUID. Whole filtering is done in
mgmt_device_found.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |  11 ++
 include/net/bluetooth/mgmt.h     |  24 ++++
 net/bluetooth/hci_core.c         |   3 +
 net/bluetooth/mgmt.c             | 274 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 308 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8d43a50..8ca1aeda 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -204,6 +204,7 @@ enum {
 	HCI_BREDR_ENABLED,
 	HCI_LE_SCAN_INTERRUPTED,
 	HCI_LE_SCAN_RESTARTING,
+	HCI_SERVICE_FILTER,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1b7f9a6..be7e28b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -143,6 +143,12 @@ struct oob_data {
 	u8 randomizer256[16];
 };
 
+struct uuid_filter {
+	struct list_head list;
+	s8 rssi;
+	u8 uuid[16];
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 /* Default LE RPA expiry time, 15 minutes */
@@ -307,6 +313,8 @@ struct hci_dev {
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
 
+	struct list_head discov_uuid_filter;
+
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
 	struct list_head	whitelist;
@@ -1325,6 +1333,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 
+#define DISCOV_LE_RESTART_DELAY msecs_to_jiffies(300)
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
@@ -1391,6 +1401,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 u16 max_interval, u16 latency, u16 timeout);
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
+void mgmt_clean_up_service_discovery(struct hci_dev *hdev);
 
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 414cd2f..a87a4e0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -495,6 +495,30 @@ struct mgmt_cp_set_public_address {
 } __packed;
 #define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
 
+#define MGMT_OP_START_SERVICE_DISCOVERY	0x003A
+#define MGMT_START_SERVICE_DISCOVERY_SIZE 1
+
+#define MGMT_RANGE_NONE			0x00
+#define MGMT_RANGE_RSSI			0x01
+#define MGMT_RANGE_PATHLOSS		0x02
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
index b926b6a..f861314 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3828,6 +3828,7 @@ static void le_scan_disable_work(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
+	mgmt_clean_up_service_discovery(hdev);
 
 	hci_req_init(&req, hdev);
 
@@ -4028,6 +4029,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
 
+	INIT_LIST_HEAD(&hdev->discov_uuid_filter);
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b700bfd..858920c 100644
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
@@ -1258,6 +1260,23 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
+void mgmt_clean_up_service_discovery(struct hci_dev *hdev)
+{
+	struct uuid_filter *filter;
+	struct uuid_filter *tmp;
+
+	if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags))
+		return;
+
+	clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
+	list_for_each_entry_safe(filter, tmp, &hdev->discov_uuid_filter, list) {
+		__list_del_entry(&filter->list);
+		kfree(filter);
+	}
+}
+
 static bool hci_stop_discovery(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -1270,6 +1289,7 @@ static bool hci_stop_discovery(struct hci_request *req)
 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 		} else {
 			cancel_delayed_work(&hdev->le_scan_disable);
+			mgmt_clean_up_service_discovery(hdev);
 			hci_req_add_le_scan_disable(req);
 		}
 
@@ -3715,10 +3735,35 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	generic_start_discovery_complete(hdev, status, MGMT_OP_START_DISCOVERY);
 }
 
+int init_service_discovery(struct hci_dev *hdev,
+			   struct mgmt_uuid_filter *filters, __le16 filter_cnt)
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
+		list_add(&tmp->list, &hdev->discov_uuid_filter);
+	}
+	set_bit(HCI_SERVICE_FILTER, &hdev->dev_flags);
+	return 0;
+}
+
 static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 				   uint16_t opcode,
 			void (*complete_cb)(struct hci_dev *hdev, u8 status),
-				   u8 type)
+				   u8 type,
+				   struct mgmt_uuid_filter *serv_filters,
+				   __le16 serv_filter_cnt)
 {
 	struct pending_cmd *cmd;
 	struct hci_cp_le_set_scan_param param_cp;
@@ -3871,6 +3916,13 @@ static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	if (serv_filters != NULL) {
+		err = init_service_discovery(hdev, serv_filters,
+					     serv_filter_cnt);
+		if (err != 0)
+			goto failed;
+	}
+
 	err = hci_req_run(&req, complete_cb);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
@@ -3888,7 +3940,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_cp_start_discovery *cp = data;
 
 	return generic_start_discovery(sk, hdev, MGMT_OP_START_DISCOVERY,
-				       start_discovery_complete, cp->type);
+				       start_discovery_complete, cp->type, NULL,
+				       0);
 }
 
 static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status,
@@ -5680,6 +5733,53 @@ unlock:
 	return err;
 }
 
+static void start_service_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	generic_start_discovery_complete(hdev, status,
+					 MGMT_OP_START_SERVICE_DISCOVERY);
+}
+
+static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len)
+{
+	struct mgmt_cp_start_service_discovery *cp = data;
+	u16 expected_len, filter_count;
+
+	BT_DBG("%s", hdev->name);
+
+	filter_count = __le16_to_cpu(cp->filter_count);
+
+	expected_len = sizeof(*cp) +
+		       filter_count * sizeof(struct mgmt_uuid_filter);
+	if (expected_len != len) {
+		BT_ERR("start_service_discovery: expected %u, got %u bytes",
+		       expected_len, len);
+
+		return cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
+				  MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	return generic_start_discovery(sk, hdev,
+				       MGMT_OP_START_SERVICE_DISCOVERY,
+				       start_service_discovery_complete,
+				       cp->type, cp->filter, cp->filter_count);
+}
+
+static void stop_service_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	generic_stop_discovery_complete(hdev, status,
+					MGMT_OP_STOP_SERVICE_DISCOVERY);
+}
+
+static int stop_service_discovery(struct sock *sk, struct hci_dev *hdev,
+				  void *data, u16 len)
+{
+	struct mgmt_cp_stop_service_discovery *mgmt_cp = data;
+
+	return generic_stop_discovery(sk, hdev, mgmt_cp->type,
+					stop_service_discovery_complete);
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5744,6 +5844,8 @@ static const struct mgmt_handler {
 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
+	{ start_service_discovery, true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
+	{ stop_service_discovery, false, MGMT_STOP_SERVICE_DISCOVERY_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -6813,6 +6915,135 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
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
+void free_uuids_list(struct list_head *uuids)
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
+uint8_t find_match(struct uuid_filter *filter, u8 *uuid, s8 rssi)
+{
+	if (memcmp(filter->uuid, uuid, 16) != 0)
+		return NO_MATCH;
+
+	if (rssi >= filter->rssi)
+		return FULL_MATCH;
+
+	return SERVICE_MATCH;
+}
+
+int find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids)
+{
+	struct uuid_filter *filter;
+	struct parsed_uuid *uuidptr, *tmp_uuid;
+	int match_type = NO_MATCH, tmp;
+
+	list_for_each_entry_safe(uuidptr, tmp_uuid, uuids, list) {
+		list_for_each_entry(filter, &hdev->discov_uuid_filter, list) {
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
@@ -6820,6 +7051,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
+	LIST_HEAD(uuids);
+	int ret = 0;
+	u8 match_type;
 
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
@@ -6858,7 +7092,29 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+	if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags)) {
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+		return;
+	}
+
+	ret = eir_parse(eir, eir_len, &uuids);
+	if (list_empty(&uuids) || ret != 0)
+		return;
+
+	match_type = find_matches(hdev, rssi, &uuids);
+	free_uuids_list(&uuids);
+
+	if (match_type == NO_MATCH)
+		return;
+
+	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks)) {
+		queue_delayed_work(hdev->workqueue,
+				   &hdev->le_scan_restart,
+				   DISCOV_LE_RESTART_DELAY);
+	}
+	if (match_type == FULL_MATCH)
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
+			   ev_size, NULL);
 }
 
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
@@ -6891,10 +7147,18 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 
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


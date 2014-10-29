Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 4/4] start service discovery and stop service discovery
Date: Wed, 29 Oct 2014 11:24:31 -0700
Message-Id: <1414607071-9801-4-git-send-email-jpawlowski@google.com>
In-Reply-To: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
References: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
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
 include/net/bluetooth/mgmt.h     |  26 +++++
 net/bluetooth/hci_core.c         |   3 +
 net/bluetooth/mgmt.c             | 243 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 281 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index d8a8e0d..f04a816 100644
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
index e8e55f0..67fed97 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -143,6 +143,14 @@ struct oob_data {
 	u8 randomizer256[16];
 };
 
+struct uuid_filter {
+	struct list_head list;
+	u8 range_method;
+	s8 pathloss;
+	s8 rssi;
+	u8 uuid[16];
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 /* Default LE RPA expiry time, 15 minutes */
@@ -307,6 +315,8 @@ struct hci_dev {
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
 
+	struct list_head discov_uuid_filter;
+
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
 	struct list_head	whitelist;
@@ -1373,6 +1383,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 void mgmt_reenable_advertising(struct hci_dev *hdev);
 void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 void restart_le_scan(struct hci_dev *hdev, unsigned long delay);
+void clean_up_service_discovery(struct hci_dev *hdev);
 
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 414cd2f..46588d7 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -495,6 +495,32 @@ struct mgmt_cp_set_public_address {
 } __packed;
 #define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
 
+#define MGMT_OP_START_SERVICE_DISCOVERY		0x003A
+#define MGMT_START_SERVICE_DISCOVERY_SIZE	1
+
+#define MGMT_RANGE_NONE     0X00
+#define MGMT_RANGE_RSSI     0X01
+#define MGMT_RANGE_PATHLOSS 0X02
+
+struct mgmt_uuid_filter {
+	__u8 range_method;
+	__s8 pathloss;
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
+#define MGMT_OP_STOP_SERVICE_DISCOVERY		0x003B
+struct mgmt_cp_stop_service_discovery {
+	__u8 type;
+} __packed;
+#define MGMT_STOP_SERVICE_DISCOVERY_SIZE	1
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 85bca9c..ec66f87 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3848,6 +3848,7 @@ static void le_scan_disable_work(struct work_struct *work)
 	BT_DBG("%s", hdev->name);
 
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
+	clean_up_service_discovery(hdev);
 
 	hci_req_init(&req, hdev);
 
@@ -4048,6 +4049,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
 
+	INIT_LIST_HEAD(&hdev->discov_uuid_filter);
+
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fb7b4f..3a88605 100644
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
@@ -1258,6 +1260,26 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
+void clean_up_service_discovery(struct hci_dev *hdev)
+{
+	struct uuid_filter *filter = NULL;
+	struct uuid_filter *tmp = NULL;
+
+	if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags))
+		return;
+
+	clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags);
+	cancel_delayed_work_sync(&hdev->le_scan_restart);
+
+	if (list_empty(&hdev->discov_uuid_filter))
+		return;
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
@@ -1270,6 +1292,7 @@ static bool hci_stop_discovery(struct hci_request *req)
 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 		} else {
 			cancel_delayed_work(&hdev->le_scan_disable);
+			clean_up_service_discovery(hdev);
 			hci_req_add_le_scan_disable(req);
 		}
 
@@ -5676,6 +5699,53 @@ unlock:
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
@@ -5740,6 +5810,8 @@ static const struct mgmt_handler {
 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
+	{ start_service_discovery, true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
+	{ stop_service_discovery, false, MGMT_STOP_SERVICE_DISCOVERY_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -6809,6 +6881,138 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
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
+static s8 add_uuid_to_list(struct list_head *uuids, u8 *uuid)
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
+static s8 eir_parse(u8 *eir, u8 eir_len, struct list_head *uuids,
+		    u8 *txpwr_present, s8 *txpwr)
+{
+	size_t offset;
+	u8 uuid[16];
+	int loop, ret;
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
+			return -1;
+
+		switch (eir[1]) {
+		case EIR_TX_POWER:
+			*txpwr_present = 1;
+			*txpwr = eir[2];
+			break;
+		case EIR_UUID16_ALL:
+		case EIR_UUID16_SOME:
+			for (loop = 0; loop + 3 <= field_len; loop += 2) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				uuid[13] = eir[loop + 3];
+				uuid[12] = eir[loop + 2];
+				ret = add_uuid_to_list(uuids, uuid);
+				if (ret)
+					return ret;
+			}
+			break;
+		case EIR_UUID32_ALL:
+		case EIR_UUID32_SOME:
+			for (loop = 0; loop + 5 <= field_len; loop += 4) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				uuid[15] = eir[loop + 5];
+				uuid[14] = eir[loop + 4];
+				uuid[13] = eir[loop + 3];
+				uuid[12] = eir[loop + 2];
+				ret = add_uuid_to_list(uuids, uuid);
+				if (ret)
+					return ret;
+			}
+			break;
+		case EIR_UUID128_ALL:
+		case EIR_UUID128_SOME:
+			for (loop = 0; loop + 17 <= field_len; loop += 4) {
+				memcpy(uuid, eir + loop + 2, 16);
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
+/* return 0 for no match, 1 for service match (no proximity match), and 2 for
+ * full match
+ */
+uint8_t find_match(struct uuid_filter *filter, u8 *uuid, s8 rssi, s8 *txpwr)
+{
+	if (memcmp(filter->uuid, uuid, 16) != 0)
+		return 0;
+
+	if (filter->range_method == MGMT_RANGE_NONE)
+		return 2;
+
+	if ((filter->range_method & MGMT_RANGE_PATHLOSS) && txpwr != NULL &&
+	    (*txpwr - rssi) <= filter->pathloss)
+		return 2;
+
+	if ((filter->range_method & MGMT_RANGE_RSSI) && rssi >= filter->rssi)
+		return 2;
+
+	return 1;
+}
+
+int find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids,
+		 s8 *txpwr)
+{
+	struct uuid_filter *filter = NULL;
+	struct parsed_uuid *uuidptr = NULL;
+	struct parsed_uuid *tmp_uuid = NULL;
+	u8 match_type = 0, tmp;
+
+	list_for_each_entry_safe(uuidptr, tmp_uuid, uuids, list) {
+		list_for_each_entry(filter, &hdev->discov_uuid_filter, list) {
+			tmp = find_match(filter, uuidptr->uuid, rssi, txpwr);
+			if (tmp > match_type)
+				match_type = tmp;
+			__list_del_entry(&uuidptr->list);
+			kfree(uuidptr);
+		}
+	}
+	return match_type;
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
@@ -6816,6 +7020,10 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
+	LIST_HEAD(uuids);
+	s8 txpwr = 0, ret = 0;
+	u8 txpwr_present = 0;
+	u8 match_type = 0;
 
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
@@ -6854,7 +7062,28 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
 
-	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+	if (test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags)) {
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
+		return;
+	}
+
+	ret = eir_parse(eir, eir_len, &uuids, &txpwr_present, &txpwr);
+	if (list_empty(&uuids) || ret != 0)
+		return;
+
+	match_type = find_matches(hdev, rssi, &uuids,
+				  txpwr_present ? &txpwr : NULL);
+	if (match_type == 0)
+		return;
+
+	if (test_bit(HCI_QUIRK_DUPLICATION, &hdev->quirks)) {
+		queue_delayed_work(hdev->workqueue,
+				   &hdev->le_scan_restart,
+				   DISCOV_LE_RESTART_DELAY);
+	}
+	if (match_type == 2)
+		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
+			   ev_size, NULL);
 }
 
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
@@ -6887,10 +7116,18 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 
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


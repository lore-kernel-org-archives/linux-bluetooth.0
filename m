Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 08/25] mgmt: Add set controller data command
Date: Fri, 21 Dec 2012 16:26:35 -0400
Message-Id: <1356121612-15172-9-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

Implement new Set Controller Data command in MGMT API. The maximum size
for new data is 27 bytes. The data sent using this command will be
stored in internal list and it will be set in adapter after receiving a
Set Broadcaster with TRUE.
---
 src/adapter.c |    8 ++++++
 src/adapter.h |    3 +++
 src/mgmt.c    |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/mgmt.h    |    3 +++
 4 files changed, 92 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 6ff20e1..d741ae1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -563,6 +563,10 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 				(const uint8_t *) name, strlen(name));
 }
 
+void adapter_set_controller_data_complete(struct btd_adapter *adapter)
+{
+}
+
 int adapter_set_name(struct btd_adapter *adapter, const char *name)
 {
 	char maxname[MAX_NAME_LENGTH + 1];
@@ -1150,6 +1154,10 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+void adapter_set_controller_data_failed(struct btd_adapter *adapter)
+{
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("StartDiscovery", NULL, NULL,
 			adapter_start_discovery) },
diff --git a/src/adapter.h b/src/adapter.h
index d35b8db..ad79ae1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -236,3 +236,6 @@ void adapter_store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
 void btd_adapter_for_each_device(struct btd_adapter *adapter,
 			void (*cb)(struct btd_device *device, void *data),
 			void *data);
+
+void adapter_set_controller_data_complete(struct btd_adapter *adapter);
+void adapter_set_controller_data_failed(struct btd_adapter *adapter);
diff --git a/src/mgmt.c b/src/mgmt.c
index 0f212b2..d1b5043 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1426,6 +1426,28 @@ static void start_discovery_complete(int sk, uint16_t index, uint8_t status,
 		adapter_set_discovering(adapter, FALSE);
 }
 
+static void set_controller_data_complete(int sk, uint16_t index, void *buf,
+								size_t len)
+{
+	struct btd_adapter *adapter;
+
+	DBG("hci%d", index);
+
+	if (index > max_index) {
+		error("Unexpected index %u in set_controller data complete",
+									index);
+		return;
+	}
+
+	adapter = manager_find_adapter_by_id(index);
+	if (adapter == NULL) {
+		DBG("Adapter not found");
+		return;
+	}
+
+	adapter_set_controller_data_complete(adapter);
+}
+
 static void read_local_oob_data_failed(int sk, uint16_t index)
 {
 	struct btd_adapter *adapter;
@@ -1443,6 +1465,23 @@ static void read_local_oob_data_failed(int sk, uint16_t index)
 		adapter_read_local_oob_data_complete(adapter, NULL, NULL);
 }
 
+static void set_controller_data_failed(int sk, uint16_t index)
+{
+	struct btd_adapter *adapter;
+
+	if (index > max_index) {
+		error("Unexpected index %u in set_controller_data_failed",
+								index);
+		return;
+	}
+
+	DBG("hci%u", index);
+
+	adapter = manager_find_adapter_by_id(index);
+	if (adapter)
+		adapter_set_controller_data_failed(adapter);
+}
+
 static void handle_pending_uuids(uint16_t index)
 {
 	struct controller_info *info;
@@ -1651,6 +1690,10 @@ static void mgmt_cmd_complete(int sk, uint16_t index, void *buf, size_t len)
 	case MGMT_OP_SET_DEVICE_ID:
 		DBG("set_did complete");
 		break;
+	case MGMT_OP_SET_CONTROLLER_DATA:
+		DBG("set_controller_data complete");
+		set_controller_data_complete(sk, index, ev->data, len);
+		break;
 	case MGMT_OP_SET_BROADCASTER:
 		DBG("set_broadcaster complete");
 		break;
@@ -1701,6 +1744,9 @@ static void mgmt_cmd_status(int sk, uint16_t index, void *buf, size_t len)
 			return;
 		}
 		break;
+	case MGMT_OP_SET_CONTROLLER_DATA:
+		set_controller_data_failed(sk, index);
+		break;
 	}
 
 	error("hci%u: %s (0x%04x) failed: %s (0x%02x)", index,
@@ -2821,3 +2867,35 @@ int mgmt_ssp_enabled(int index)
 
 	return mgmt_ssp(info->current_settings);
 }
+
+int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
+					uint8_t *data, uint8_t data_length)
+{
+	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_set_controller_data) +
+							HCI_MAX_EIR_LENGTH];
+	struct mgmt_hdr *hdr = (void *) buf;
+	struct mgmt_cp_set_controller_data *cp = (void *) &buf[sizeof(*hdr)];
+	uint16_t cp_size;
+	int err = 0;
+
+	DBG("hci%d flags %d data_type 0x%hhx data_length %d", index, flags,
+							data_type, data_length);
+
+	memset(buf, 0, sizeof(buf));
+
+	cp_size = sizeof(*cp) + data_length;
+
+	hdr->opcode = htobs(MGMT_OP_SET_CONTROLLER_DATA);
+	hdr->index = htobs(index);
+	hdr->len = htobs(cp_size);
+
+	cp->flags = flags;
+	cp->type = data_type;
+	cp->length = data_length;
+	memcpy(cp->data, data, data_length);
+
+	if (write(mgmt_sock, buf, sizeof(*hdr) + cp_size) < 0)
+		err = -errno;
+
+	return err;
+}
diff --git a/src/mgmt.h b/src/mgmt.h
index 1607a95..92b4757 100644
--- a/src/mgmt.h
+++ b/src/mgmt.h
@@ -84,3 +84,6 @@ int mgmt_confirm_name(int index, const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							gboolean name_known);
 
 int mgmt_ssp_enabled(int index);
+
+int mgmt_set_controller_data(int index, uint8_t flags, uint8_t data_type,
+					uint8_t *data, uint8_t data_length);
-- 
1.7.9.5


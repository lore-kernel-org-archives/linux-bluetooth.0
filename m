Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/1] Adding start_discovery functionality to hciops plugin.
Date: Thu, 21 May 2009 18:54:49 +0530
Message-Id: <1242912289-9864-1-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

Adding adapter_discovery_begin and adapter_discovery_result
callback functions.
---
 plugins/hciops.c |   56 ++++++++++++++
 src/adapter.c    |  211 +++++++++++++++++++++++++++++-------------------------
 src/adapter.h    |    5 +-
 src/dbus-hci.c   |  161 -----------------------------------------
 src/security.c   |   60 ++++++++++++---
 5 files changed, 222 insertions(+), 271 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 8f9ee06..c4c084e 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -561,6 +561,61 @@ done:
 	return err;
 }
 
+static int hciops_start_discovery(int index)
+{
+	struct btd_adapter *adapter;
+	inquiry_cp inq_cp;
+	periodic_inquiry_cp cp;
+	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return dd;
+
+	if (main_opts.discov_interval)
+		goto standard;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.lap, lap, 3);
+	cp.max_period = htobs(24);
+	cp.min_period = htobs(16);
+	cp.length  = 0x08;
+	cp.num_rsp = 0x00;
+
+	err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_PERIODIC_INQUIRY,
+					PERIODIC_INQUIRY_CP_SIZE, &cp);
+
+	goto done;
+
+standard:
+
+	adapter = manager_find_adapter_by_id(index);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		hci_close_dev(dd);
+		return -EINVAL;
+	}
+
+	pending_remote_name_cancel(adapter);
+
+	memset(&inq_cp, 0, sizeof(inq_cp));
+	memcpy(&inq_cp.lap, lap, 3);
+	inq_cp.length = 0x08;
+	inq_cp.num_rsp = 0x00;
+
+	err = hci_send_cmd(dd, OGF_LINK_CTL, OCF_INQUIRY,
+					INQUIRY_CP_SIZE, &inq_cp);
+
+done:
+	if (err < 0)
+		err = -errno;
+
+	hci_close_dev(dd);
+
+	return err;
+}
+
 static struct btd_adapter_ops hci_ops = {
 	.setup = hciops_setup,
 	.cleanup = hciops_cleanup,
@@ -570,6 +625,7 @@ static struct btd_adapter_ops hci_ops = {
 	.set_connectable = hciops_connectable,
 	.set_discoverable = hciops_discoverable,
 	.set_limited_discoverable = hciops_set_limited_discoverable,
+	.start_discovery = hciops_start_discovery,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 25ec33a..bdb8dfb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -186,6 +186,25 @@ static inline DBusMessage *unsupported_major_class(DBusMessage *msg)
 			"Unsupported Major Class");
 }
 
+static char *extract_eir_name(uint8_t *data, uint8_t *type)
+{
+	if (!data || !type)
+		return NULL;
+
+	if (data[0] == 0)
+		return NULL;
+
+	*type = data[1];
+
+	switch (*type) {
+	case 0x08:
+	case 0x09:
+		return strndup((char *) (data + 2), data[0] - 1);
+	}
+
+	return NULL;
+}
+
 static int found_device_cmp(const struct remote_dev_info *d1,
 			const struct remote_dev_info *d2)
 {
@@ -945,106 +964,113 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 	return adapter_create_device(conn, adapter, address);
 }
 
-static int start_inquiry(struct btd_adapter *adapter)
+void adapter_discovery_begin(struct btd_adapter *adapter, gboolean periodic)
 {
-	inquiry_cp cp;
-	evt_cmd_status rp;
-	struct hci_request rq;
-	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
-	int dd, err;
+	if (periodic) {
+		adapter->state |= PERIODIC_INQUIRY;
+		return;
+	} else
+		adapter->state |= STD_INQUIRY;
 
-	pending_remote_name_cancel(adapter);
+	/*
+	 * Cancel pending remote name request and clean the device list
+	 * when inquiry is supported in periodic inquiry idle state.
+	 */
+	if (adapter->state & PERIODIC_INQUIRY)
+		pending_remote_name_cancel(adapter);
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return dd;
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.length = 0x08;
-	cp.num_rsp = 0x00;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf = OGF_LINK_CTL;
-	rq.ocf = OCF_INQUIRY;
-	rq.cparam = &cp;
-	rq.clen = INQUIRY_CP_SIZE;
-	rq.rparam = &rp;
-	rq.rlen = EVT_CMD_STATUS_SIZE;
-	rq.event = EVT_CMD_STATUS;
-
-	if (hci_send_req(dd, &rq, HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
-		error("Unable to start inquiry: %s (%d)",
-						strerror(errno), errno);
-		hci_close_dev(dd);
-		return err;
-	}
+	/* Disable name resolution for non D-Bus clients */
+	if (!adapter->disc_sessions)
+		adapter->state &= ~RESOLVE_NAME;
+}
 
-	if (rp.status) {
-		error("HCI_Inquiry command failed with status 0x%02x",
-			rp.status);
-		hci_close_dev(dd);
-		return -bt_error(rp.status);
+void adapter_discovery_result(struct btd_adapter *adapter, bdaddr_t *bdaddr,
+				uint32_t class, int8_t rssi, uint8_t *data)
+{
+	char filename[PATH_MAX + 1];
+	struct btd_device *device;
+	char srcaddr[18], dstaddr[18], *alias, *name, *tmp_name;
+	struct remote_dev_info *dev, match;
+	uint8_t name_type = 0x00;
+	name_status_t name_status;
+	dbus_bool_t legacy;
+
+	ba2str(bdaddr, dstaddr);
+	ba2str(&adapter->bdaddr, srcaddr);
+
+	device = adapter_find_device(adapter, dstaddr);
+	if (device) {
+		error("device already found");
+		return;
 	}
 
-	hci_close_dev(dd);
+	write_remote_class(&adapter->bdaddr, bdaddr, class);
 
-	if (main_opts.name_resolv)
-		adapter->state |= RESOLVE_NAME;
+	if (data)
+		write_remote_eir(&adapter->bdaddr, bdaddr, data);
 
-	return 0;
-}
+	/*
+	 * workaround to identify situation when the daemon started and
+	 * a standard inquiry or periodic inquiry was already running
+	 */
+	if (!(adapter->state & STD_INQUIRY) &&
+					!(adapter->state & PERIODIC_INQUIRY))
+		adapter->state |= PERIODIC_INQUIRY;
 
-static int start_periodic_inquiry(struct btd_adapter *adapter)
-{
-	periodic_inquiry_cp cp;
-	struct hci_request rq;
-	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
-	uint8_t status;
-	int dd, err;
+	legacy = (data == NULL);
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0)
-		return dd;
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, 3);
-	cp.max_period = htobs(24);
-	cp.min_period = htobs(16);
-	cp.length  = 0x08;
-	cp.num_rsp = 0x00;
-
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_PERIODIC_INQUIRY;
-	rq.cparam = &cp;
-	rq.clen   = PERIODIC_INQUIRY_CP_SIZE;
-	rq.rparam = &status;
-	rq.rlen   = sizeof(status);
-	rq.event  = EVT_CMD_COMPLETE;
-
-	if (hci_send_req(dd, &rq, HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
-		error("Unable to start periodic inquiry: %s (%d)",
-						strerror(errno), errno);
-		hci_close_dev(dd);
-		return err;
+	memset(&match, 0, sizeof(struct remote_dev_info));
+	bacpy(&match.bdaddr, bdaddr);
+	match.name_status = NAME_SENT;
+	/* if found: don't send the name again */
+	dev = adapter_search_found_devices(adapter, &match);
+	if (dev) {
+		adapter_update_found_devices(adapter, bdaddr, rssi, class,
+						NULL, NULL, legacy,
+						NAME_NOT_REQUIRED);
+		return;
 	}
 
-	if (status) {
-		error("HCI_Periodic_Inquiry_Mode failed with status 0x%02x",
-				status);
-		hci_close_dev(dd);
-		return -bt_error(status);
+	/* the inquiry result can be triggered by NON D-Bus client */
+	if (adapter->state & RESOLVE_NAME)
+		name_status = NAME_REQUIRED;
+	else
+		name_status = NAME_NOT_REQUIRED;
+
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "aliases");
+	alias = textfile_get(filename, dstaddr);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "names");
+	name = textfile_get(filename, dstaddr);
+
+	tmp_name = extract_eir_name(data, &name_type);
+	if (tmp_name) {
+		if (name_type == 0x09) {
+			write_device_name(&adapter->bdaddr, bdaddr, tmp_name);
+			name_status = NAME_NOT_REQUIRED;
+
+			if (name)
+				g_free(name);
+
+			name = tmp_name;
+		} else {
+			if (name)
+				free(tmp_name);
+			else
+				name = tmp_name;
+		}
 	}
 
-	hci_close_dev(dd);
 
-	if (main_opts.name_resolv)
-		adapter->state |= RESOLVE_NAME;
+	if (name && name_type != 0x08)
+		name_status = NAME_SENT;
 
-	return 0;
+	/* add in the list to track name sent/pending */
+	adapter_update_found_devices(adapter, bdaddr, rssi, class, name, alias,
+					legacy, name_status);
+
+	g_free(name);
+	g_free(alias);
 }
 
 static DBusMessage *adapter_start_discovery(DBusConnection *conn,
@@ -1067,11 +1093,10 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	if (adapter->disc_sessions)
 		goto done;
 
-	if (main_opts.discov_interval)
-		err = start_inquiry(adapter);
-	else
-		err = start_periodic_inquiry(adapter);
+	if (main_opts.name_resolv)
+		adapter->state |= RESOLVE_NAME;
 
+	err = adapter_ops->start_discovery(adapter->dev_id);
 	if (err < 0)
 		return failed_strerror(msg, -err);
 
@@ -2441,7 +2466,7 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 	else if (adapter->disc_sessions && main_opts.discov_interval)
 		adapter->scheduler_id = g_timeout_add_seconds(
 						main_opts.discov_interval,
-						(GSourceFunc) start_inquiry,
+						(GSourceFunc) adapter_ops->start_discovery,
 						adapter);
 
 	/* Send out of range */
@@ -2783,14 +2808,6 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 	}
 }
 
-gboolean adapter_has_discov_sessions(struct btd_adapter *adapter)
-{
-	if (!adapter || !adapter->disc_sessions)
-		return FALSE;
-
-	return TRUE;
-}
-
 int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 {
 	GSList *adapters;
diff --git a/src/adapter.h b/src/adapter.h
index a94edc6..2fc4234 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -123,7 +123,9 @@ void adapter_add_connection(struct btd_adapter *adapter,
 				struct btd_device *device, uint16_t handle);
 void adapter_remove_connection(struct btd_adapter *adapter,
 				struct btd_device *device, uint16_t handle);
-gboolean adapter_has_discov_sessions(struct btd_adapter *adapter);
+void adapter_discovery_begin(struct btd_adapter *adapter, gboolean periodic);
+void adapter_discovery_result(struct btd_adapter *adapter, bdaddr_t *peer,
+				uint32_t class, int8_t rssi, uint8_t *data);
 
 struct btd_adapter_driver {
 	const char *name;
@@ -157,6 +159,7 @@ struct btd_adapter_ops {
 	int (*set_discoverable) (int index);
 	int (*set_limited_discoverable) (int index, const uint8_t *cls,
 						gboolean limited);
+	int (*start_discovery) (int index);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 65ac12b..c503a71 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -434,35 +434,6 @@ void hcid_dbus_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer,
 	device_simple_pairing_complete(device, status);
 }
 
-void hcid_dbus_inquiry_start(bdaddr_t *local)
-{
-	struct btd_adapter *adapter;
-	int state;
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("Unable to find matching adapter");
-		return;
-	}
-
-	state = adapter_get_state(adapter);
-	state |= STD_INQUIRY;
-	adapter_set_state(adapter, state);
-	/*
-	 * Cancel pending remote name request and clean the device list
-	 * when inquiry is supported in periodic inquiry idle state.
-	 */
-	if (adapter_get_state(adapter) & PERIODIC_INQUIRY)
-		pending_remote_name_cancel(adapter);
-
-	/* Disable name resolution for non D-Bus clients */
-	if (!adapter_has_discov_sessions(adapter)) {
-		state = adapter_get_state(adapter);
-		state &= ~RESOLVE_NAME;
-		adapter_set_state(adapter, state);
-	}
-}
-
 static int found_device_req_name(struct btd_adapter *adapter)
 {
 	struct hci_request rq;
@@ -574,26 +545,6 @@ void hcid_dbus_inquiry_complete(bdaddr_t *local)
 	adapter_set_state(adapter, state);
 }
 
-void hcid_dbus_periodic_inquiry_start(bdaddr_t *local, uint8_t status)
-{
-	struct btd_adapter *adapter;
-	int state;
-
-	/* Don't send the signal if the cmd failed */
-	if (status)
-		return;
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("No matching adapter found");
-		return;
-	}
-
-	state = adapter_get_state(adapter);
-	state |= PERIODIC_INQUIRY;
-	adapter_set_state(adapter, state);
-}
-
 void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status)
 {
 	struct btd_adapter *adapter;
@@ -616,118 +567,6 @@ void hcid_dbus_periodic_inquiry_exit(bdaddr_t *local, uint8_t status)
 	adapter_set_state(adapter, state);
 }
 
-static char *extract_eir_name(uint8_t *data, uint8_t *type)
-{
-	if (!data || !type)
-		return NULL;
-
-	if (data[0] == 0)
-		return NULL;
-
-	*type = data[1];
-
-	switch (*type) {
-	case 0x08:
-	case 0x09:
-		return strndup((char *) (data + 2), data[0] - 1);
-	}
-
-	return NULL;
-}
-
-void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
-				int8_t rssi, uint8_t *data)
-{
-	char filename[PATH_MAX + 1];
-	struct btd_adapter *adapter;
-	struct btd_device *device;
-	char local_addr[18], peer_addr[18], *alias, *name, *tmp_name;
-	struct remote_dev_info *dev, match;
-	uint8_t name_type = 0x00;
-	name_status_t name_status;
-	int state;
-	dbus_bool_t legacy;
-
-	ba2str(local, local_addr);
-	ba2str(peer, peer_addr);
-
-	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE)) {
-		error("No matching adapter found");
-		return;
-	}
-
-	write_remote_class(local, peer, class);
-
-	if (data)
-		write_remote_eir(local, peer, data);
-
-	/*
-	 * workaround to identify situation when the daemon started and
-	 * a standard inquiry or periodic inquiry was already running
-	 */
-	if (!(adapter_get_state(adapter) & STD_INQUIRY) &&
-			!(adapter_get_state(adapter) & PERIODIC_INQUIRY)) {
-		state = adapter_get_state(adapter);
-		state |= PERIODIC_INQUIRY;
-		adapter_set_state(adapter, state);
-	}
-
-	legacy = (data == NULL);
-
-	memset(&match, 0, sizeof(struct remote_dev_info));
-	bacpy(&match.bdaddr, peer);
-	match.name_status = NAME_SENT;
-	/* if found: don't send the name again */
-	dev = adapter_search_found_devices(adapter, &match);
-	if (dev) {
-		adapter_update_found_devices(adapter, peer, rssi, class,
-						NULL, NULL, legacy,
-						NAME_NOT_REQUIRED);
-		return;
-	}
-
-	/* the inquiry result can be triggered by NON D-Bus client */
-	if (adapter_get_state(adapter) & RESOLVE_NAME)
-		name_status = NAME_REQUIRED;
-	else
-		name_status = NAME_NOT_REQUIRED;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "aliases");
-	alias = textfile_get(filename, peer_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "names");
-	name = textfile_get(filename, peer_addr);
-
-	tmp_name = extract_eir_name(data, &name_type);
-	if (tmp_name) {
-		if (name_type == 0x09) {
-			write_device_name(local, peer, tmp_name);
-			name_status = NAME_NOT_REQUIRED;
-
-			if (name)
-				g_free(name);
-
-			name = tmp_name;
-		} else {
-			if (name)
-				free(tmp_name);
-			else
-				name = tmp_name;
-		}
-	}
-
-
-	if (name && name_type != 0x08)
-		name_status = NAME_SENT;
-
-	/* add in the list to track name sent/pending */
-	adapter_update_found_devices(adapter, peer, rssi, class, name, alias,
-					legacy, name_status);
-
-	g_free(name);
-	g_free(alias);
-}
-
 void hcid_dbus_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
 {
 	uint32_t old_class = 0;
diff --git a/src/security.c b/src/security.c
index a61d75f..5dee961 100644
--- a/src/security.c
+++ b/src/security.c
@@ -51,6 +51,7 @@
 #include "textfile.h"
 
 #include "adapter.h"
+#include "manager.h"
 #include "dbus-hci.h"
 #include "storage.h"
 
@@ -545,12 +546,19 @@ static inline void cmd_status(int dev, bdaddr_t *sba, void *ptr)
 {
 	evt_cmd_status *evt = ptr;
 	uint16_t opcode = btohs(evt->opcode);
+	struct btd_adapter *adapter;
 
 	if (evt->status)
 		return;
 
+	adapter = manager_find_adapter(sba);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
 	if (opcode == cmd_opcode_pack(OGF_LINK_CTL, OCF_INQUIRY))
-		hcid_dbus_inquiry_start(sba);
+		adapter_discovery_begin(adapter, FALSE);
 }
 
 static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
@@ -558,11 +566,21 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 	evt_cmd_complete *evt = ptr;
 	uint16_t opcode = btohs(evt->opcode);
 	uint8_t status;
+	struct btd_adapter *adapter;
 
 	switch (opcode) {
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_PERIODIC_INQUIRY):
 		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
-		hcid_dbus_periodic_inquiry_start(sba, status);
+		if (status)
+			return;
+
+		adapter = manager_find_adapter(sba);
+		if (!adapter) {
+			error("Unable to find matching adapter");
+			return;
+		}
+
+		adapter_discovery_begin(adapter, TRUE);
 		break;
 	case cmd_opcode_pack(OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY):
 		status = *((uint8_t *) ptr + EVT_CMD_COMPLETE_SIZE);
@@ -630,17 +648,23 @@ static inline void inquiry_complete(int dev, bdaddr_t *sba, void *ptr)
 
 static inline void inquiry_result(int dev, bdaddr_t *sba, int plen, void *ptr)
 {
+	struct btd_adapter *adapter;
 	uint8_t num = *(uint8_t *) ptr++;
 	int i;
 
+	adapter = manager_find_adapter(sba);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
 	for (i = 0; i < num; i++) {
 		inquiry_info *info = ptr;
 		uint32_t class = info->dev_class[0]
 			| (info->dev_class[1] << 8)
 			| (info->dev_class[2] << 16);
 
-		hcid_dbus_inquiry_result(sba, &info->bdaddr, class, 0, NULL);
-
+		adapter_discovery_result(adapter, &info->bdaddr, class, 0, NULL);
 		update_lastseen(sba, &info->bdaddr);
 
 		ptr += INQUIRY_INFO_SIZE;
@@ -649,12 +673,19 @@ static inline void inquiry_result(int dev, bdaddr_t *sba, int plen, void *ptr)
 
 static inline void inquiry_result_with_rssi(int dev, bdaddr_t *sba, int plen, void *ptr)
 {
+	struct btd_adapter *adapter;
 	uint8_t num = *(uint8_t *) ptr++;
 	int i;
 
 	if (!num)
 		return;
 
+	adapter = manager_find_adapter(sba);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
 	if ((plen - 1) / num == INQUIRY_INFO_WITH_RSSI_AND_PSCAN_MODE_SIZE) {
 		for (i = 0; i < num; i++) {
 			inquiry_info_with_rssi_and_pscan_mode *info = ptr;
@@ -662,9 +693,8 @@ static inline void inquiry_result_with_rssi(int dev, bdaddr_t *sba, int plen, vo
 				| (info->dev_class[1] << 8)
 				| (info->dev_class[2] << 16);
 
-			hcid_dbus_inquiry_result(sba, &info->bdaddr,
-						class, info->rssi, NULL);
-
+			adapter_discovery_result(adapter, &info->bdaddr,
+					class, info->rssi, NULL);
 			update_lastseen(sba, &info->bdaddr);
 
 			ptr += INQUIRY_INFO_WITH_RSSI_AND_PSCAN_MODE_SIZE;
@@ -676,9 +706,8 @@ static inline void inquiry_result_with_rssi(int dev, bdaddr_t *sba, int plen, vo
 				| (info->dev_class[1] << 8)
 				| (info->dev_class[2] << 16);
 
-			hcid_dbus_inquiry_result(sba, &info->bdaddr,
-						class, info->rssi, NULL);
-
+			adapter_discovery_result(adapter, &info->bdaddr,
+					class, info->rssi, NULL);
 			update_lastseen(sba, &info->bdaddr);
 
 			ptr += INQUIRY_INFO_WITH_RSSI_SIZE;
@@ -688,17 +717,24 @@ static inline void inquiry_result_with_rssi(int dev, bdaddr_t *sba, int plen, vo
 
 static inline void extended_inquiry_result(int dev, bdaddr_t *sba, int plen, void *ptr)
 {
+	struct btd_adapter *adapter;
 	uint8_t num = *(uint8_t *) ptr++;
 	int i;
 
+	adapter = manager_find_adapter(sba);
+	if (!adapter) {
+		error("Unable to find matching adapter");
+		return;
+	}
+
 	for (i = 0; i < num; i++) {
 		extended_inquiry_info *info = ptr;
 		uint32_t class = info->dev_class[0]
 			| (info->dev_class[1] << 8)
 			| (info->dev_class[2] << 16);
 
-		hcid_dbus_inquiry_result(sba, &info->bdaddr, class,
-						info->rssi, info->data);
+		adapter_discovery_result(adapter, &info->bdaddr,
+				class, info->rssi, info->data);
 
 		update_lastseen(sba, &info->bdaddr);
 
-- 
1.5.6.3

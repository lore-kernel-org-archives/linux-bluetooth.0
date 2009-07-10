Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/2] Adding set_name to hciops plugin.
Date: Fri, 10 Jul 2009 15:16:00 +0530
Message-Id: <1247219161-7917-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   23 ++++++++++++
 src/adapter.c    |  105 ++++++++++++++++++++++++++++--------------------------
 src/adapter.h    |    5 ++-
 src/dbus-hci.c   |   47 ------------------------
 src/dbus-hci.h   |    1 -
 src/security.c   |    6 +++-
 6 files changed, 86 insertions(+), 101 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 659f754..7f63a49 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -682,6 +682,28 @@ static int hciops_resolve_name(int index, bdaddr_t *bdaddr)
 	return err;
 }
 
+static int hciops_set_name(int index, const char *name)
+{
+	change_local_name_cp cp;
+	int dd, err = 0;
+
+	dd = hci_open_dev(index);
+	if (dd < 0)
+		return -EIO;
+
+	memset(&cp, 0, sizeof(cp));
+	strncpy((char *) cp.name, name, sizeof(cp.name));
+
+	err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME,
+					CHANGE_LOCAL_NAME_CP_SIZE, &cp);
+	if (err < 0)
+		err = -errno;
+
+	hci_close_dev(dd);
+
+	return err;
+}
+
 static int hciops_cancel_resolve_name(int index, bdaddr_t *bdaddr)
 {
 	remote_name_req_cancel_cp cp;
@@ -717,6 +739,7 @@ static struct btd_adapter_ops hci_ops = {
 	.stop_discovery = hciops_stop_discovery,
 	.resolve_name = hciops_resolve_name,
 	.cancel_resolve_name = hciops_cancel_resolve_name,
+	.set_name = hciops_set_name,
 };
 
 static int hciops_init(void)
diff --git a/src/adapter.c b/src/adapter.c
index 289f1f3..4b94ed8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -838,76 +838,93 @@ static void update_ext_inquiry_response(struct btd_adapter *adapter)
 	hci_close_dev(dd);
 }
 
-void adapter_name_changed(struct btd_adapter *adapter, const char *name)
+void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr)
 {
-	struct hci_dev *dev = &adapter->dev;
+	read_local_name_rp rp;
+	struct hci_dev *dev;
+	struct btd_adapter *adapter;
+	gchar *name;
 
-	if (strncmp(name, (char *) dev->name, MAX_NAME_LENGTH) == 0)
+	if (status)
+		return;
+
+	adapter = manager_find_adapter(bdaddr);
+	if (!adapter) {
+		error("Unable to find matching adapter");
 		return;
+	}
 
-	write_local_name(&adapter->bdaddr, (char *) name);
+	dev = &adapter->dev;
 
-	strncpy((char *) dev->name, name, MAX_NAME_LENGTH);
+	memcpy(&rp, ptr, MAX_NAME_LENGTH);
+	if (strncmp((char *) rp.name, (char *) dev->name, MAX_NAME_LENGTH) == 0)
+		return;
+
+	strncpy((char *) dev->name, (char *) rp.name, MAX_NAME_LENGTH);
+
+	write_local_name(bdaddr, (char *) dev->name);
 
 	update_ext_inquiry_response(adapter);
 
-	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
+	name = g_strdup((char *) dev->name);
+
+	if (connection)
+		emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
 				"Name", DBUS_TYPE_STRING, &name);
+	g_free(name);
 }
 
-static int adapter_set_name(struct btd_adapter *adapter, const char *name)
+void adapter_setname_complete(bdaddr_t *local, uint8_t status)
 {
-	struct hci_dev *dev = &adapter->dev;
+	struct btd_adapter *adapter;
 	int dd, err;
 
-	write_local_name(&adapter->bdaddr, (char *) name);
-
-	strncpy((char *) dev->name, name, MAX_NAME_LENGTH);
+	if (status)
+		return;
 
-	if (!adapter->up)
-		return 0;
+	adapter = manager_find_adapter(local);
+	if (!adapter) {
+		error("No matching adapter found");
+		return;
+	}
 
 	dd = hci_open_dev(adapter->dev_id);
 	if (dd < 0) {
-		err = -errno;
-		error("Can't open device hci%d: %s (%d)",
-				adapter->dev_id, strerror(errno), errno);
-		return err;
+		error("HCI device open failed: hci%d", adapter->dev_id);
+		return;
 	}
 
-	if (hci_write_local_name(dd, name, HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
-		error("Can't write name for hci%d: %s (%d)",
-				adapter->dev_id, strerror(errno), errno);
-		hci_close_dev(dd);
-		return err;
-	}
+	err = hci_send_cmd(dd, OGF_HOST_CTL, OCF_READ_LOCAL_NAME, 0, 0);
+	if (err < 0)
+		error("Sending getting name command failed: %s (%d)",
+						strerror(errno), errno);
 
 	hci_close_dev(dd);
-
-	update_ext_inquiry_response(adapter);
-
-	return 0;
 }
 
 static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
 					const char *name, void *data)
 {
 	struct btd_adapter *adapter = data;
-	int ecode;
+	struct hci_dev *dev = &adapter->dev;
+	int err;
 
 	if (!g_utf8_validate(name, -1, NULL)) {
 		error("Name change failed: supplied name isn't valid UTF-8");
 		return invalid_args(msg);
 	}
 
-	ecode = adapter_set_name(adapter, name);
-	if (ecode < 0)
-		return failed_strerror(msg, -ecode);
+	if (strncmp(name, (char *) dev->name, MAX_NAME_LENGTH) == 0)
+		goto done;
 
-	emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
-				"Name", DBUS_TYPE_STRING, &name);
+	if (!adapter->up)
+		return failed_strerror(msg, -EHOSTDOWN);
 
+	err = adapter_ops->set_name(adapter->dev_id, name);
+	if (err < 0)
+		return failed_strerror(msg, err);
+
+done:
 	return dbus_message_new_method_return(msg);
 }
 
@@ -1784,12 +1801,8 @@ static int adapter_setup(struct btd_adapter *adapter)
 						sizeof(events), events);
 	}
 
-	if (read_local_name(&adapter->bdaddr, name) == 0) {
-		memcpy(dev->name, name, MAX_NAME_LENGTH);
-		hci_write_local_name(dd, name, HCI_REQ_TIMEOUT);
-	}
-
-	update_ext_inquiry_response(adapter);
+	if (read_local_name(&adapter->bdaddr, name) == 0)
+		adapter_ops->set_name(adapter->dev_id, name);
 
 	inqmode = get_inquiry_mode(dev);
 	if (inqmode < 1)
@@ -2058,7 +2071,6 @@ int adapter_start(struct btd_adapter *adapter)
 	struct hci_version ver;
 	uint8_t features[8];
 	int dd, err;
-	char name[MAX_NAME_LENGTH + 1];
 
 	if (hci_devinfo(adapter->dev_id, &di) < 0)
 		return -errno;
@@ -2120,16 +2132,7 @@ int adapter_start(struct btd_adapter *adapter)
 		return err;
 	}
 
-	if (hci_read_local_name(dd, sizeof(name), name,
-						HCI_REQ_TIMEOUT) < 0) {
-		err = -errno;
-		error("Can't read local name on %s: %s (%d)",
-					adapter->path, strerror(errno), errno);
-		hci_close_dev(dd);
-		return err;
-	}
-
-	memcpy(dev->name, name, MAX_NAME_LENGTH);
+	hci_send_cmd(dd, OGF_HOST_CTL, OCF_READ_LOCAL_NAME, 0, 0);
 
 	if (!(features[6] & LMP_SIMPLE_PAIR))
 		goto setup;
diff --git a/src/adapter.h b/src/adapter.h
index 183af05..9845ac7 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -121,7 +121,9 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 				struct remote_dev_info *dev);
 void adapter_update_oor_devices(struct btd_adapter *adapter);
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
-void adapter_name_changed(struct btd_adapter *adapter, const char *name);
+void adapter_setname_complete(bdaddr_t *local, uint8_t status);
+void adapter_update_local_name(bdaddr_t *bdaddr, uint8_t status, void *ptr);
+
 struct agent *adapter_get_agent(struct btd_adapter *adapter);
 void adapter_add_connection(struct btd_adapter *adapter,
 				struct btd_device *device, uint16_t handle);
@@ -171,6 +173,7 @@ struct btd_adapter_ops {
 	int (*stop_discovery) (int index);
 	int (*resolve_name) (int index, bdaddr_t *bdaddr);
 	int (*cancel_resolve_name) (int index, bdaddr_t *bdaddr);
+	int (*set_name) (int index, const char *name);
 };
 
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index 1e6ec43..221c185 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -727,53 +727,6 @@ void hcid_dbus_disconn_complete(bdaddr_t *local, uint8_t status,
 
 /* Section reserved to device HCI callbacks */
 
-void hcid_dbus_setname_complete(bdaddr_t *local)
-{
-	struct btd_adapter *adapter;
-	int id, dd = -1;
-	read_local_name_rp rp;
-	struct hci_request rq;
-	const char *pname = (char *) rp.name;
-	char name[MAX_NAME_LENGTH + 1];
-
-	adapter = manager_find_adapter(local);
-	if (!adapter) {
-		error("No matching adapter found");
-		return;
-	}
-
-	id = adapter_get_dev_id(adapter);
-	dd = hci_open_dev(id);
-	if (dd < 0) {
-		error("HCI device open failed: hci%d", id);
-		memset(&rp, 0, sizeof(rp));
-	} else {
-		memset(&rq, 0, sizeof(rq));
-		rq.ogf    = OGF_HOST_CTL;
-		rq.ocf    = OCF_READ_LOCAL_NAME;
-		rq.rparam = &rp;
-		rq.rlen   = READ_LOCAL_NAME_RP_SIZE;
-		rq.event  = EVT_CMD_COMPLETE;
-
-		if (hci_send_req(dd, &rq, HCI_REQ_TIMEOUT) < 0) {
-			error("Sending getting name command failed: %s (%d)",
-						strerror(errno), errno);
-			rp.name[0] = '\0';
-		} else if (rp.status) {
-			error("Getting name failed with status 0x%02x",
-					rp.status);
-			rp.name[0] = '\0';
-		}
-		hci_close_dev(dd);
-	}
-
-	strncpy(name, pname, sizeof(name) - 1);
-	name[MAX_NAME_LENGTH] = '\0';
-	pname = name;
-
-	adapter_name_changed(adapter, pname);
-}
-
 void hcid_dbus_setscan_enable_complete(bdaddr_t *local)
 {
 	struct btd_adapter *adapter;
diff --git a/src/dbus-hci.h b/src/dbus-hci.h
index d6d9a11..382e59e 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -30,7 +30,6 @@ void hcid_dbus_conn_complete(bdaddr_t *local, uint8_t status, uint16_t handle, b
 void hcid_dbus_disconn_complete(bdaddr_t *local, uint8_t status, uint16_t handle, uint8_t reason);
 void hcid_dbus_bonding_process_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
 void hcid_dbus_simple_pairing_complete(bdaddr_t *local, bdaddr_t *peer, uint8_t status);
-void hcid_dbus_setname_complete(bdaddr_t *local);
 void hcid_dbus_setscan_enable_complete(bdaddr_t *local);
 void hcid_dbus_write_class_complete(bdaddr_t *local);
 void hcid_dbus_write_simple_pairing_mode_complete(bdaddr_t *local);
diff --git a/src/security.c b/src/security.c
index 905cf61..646921b 100644
--- a/src/security.c
+++ b/src/security.c
@@ -677,7 +677,7 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 		inquiry_complete(sba, status, FALSE);
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_CHANGE_LOCAL_NAME):
-		hcid_dbus_setname_complete(sba);
+		adapter_setname_complete(sba, status);
 		break;
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE):
 		hcid_dbus_setscan_enable_complete(sba);
@@ -688,6 +688,10 @@ static inline void cmd_complete(int dev, bdaddr_t *sba, void *ptr)
 	case cmd_opcode_pack(OGF_HOST_CTL, OCF_WRITE_SIMPLE_PAIRING_MODE):
 		hcid_dbus_write_simple_pairing_mode_complete(sba);
 		break;
+	case cmd_opcode_pack(OGF_HOST_CTL, OCF_READ_LOCAL_NAME):
+		ptr += sizeof(evt_cmd_complete);
+		adapter_update_local_name(sba, status, ptr);
+		break;
 	};
 }
 
-- 
1.5.6.3


Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/1] Fixing bluetoothd to avoid passing device descriptor
Date: Tue,  7 Jul 2009 16:32:57 +0530
Message-Id: <1246964577-25157-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hal.c  |    4 +-
 src/adapter.c  |  131 ++++++++++++++++++++++++++++++++++++++++++--------------
 src/adapter.h  |    5 ++-
 src/dbus-hci.c |   45 +------------------
 src/dbus-hci.h |    4 --
 5 files changed, 107 insertions(+), 82 deletions(-)

diff --git a/plugins/hal.c b/plugins/hal.c
index 5b7e4b2..6815f28 100644
--- a/plugins/hal.c
+++ b/plugins/hal.c
@@ -90,9 +90,9 @@ static void formfactor_reply(DBusPendingCall *call, void *user_data)
 	/* Computer major class */
 	debug("Setting 0x%06x for major/minor device class", (1 << 8) | minor);
 
-	set_major_and_minor_class(dd, cls, 0x01, minor);
-
 	hci_close_dev(dd);
+
+	set_major_and_minor_class(adapter, 0x01, minor);
 }
 
 static DBusConnection *connection;
diff --git a/src/adapter.c b/src/adapter.c
index 3fd0a9b..3d4769f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -224,6 +224,73 @@ void clear_found_devices_list(struct btd_adapter *adapter)
 	adapter->found_devices = NULL;
 }
 
+static int set_service_classes(struct btd_adapter *adapter, uint8_t value)
+{
+	struct hci_dev *dev = &adapter->dev;
+	const uint8_t *cls = dev->class;
+	uint32_t dev_class;
+	int dd, err;
+
+	if (cls[2] == value)
+		return 0; /* Already set */
+
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0) {
+		err = -errno;
+		error("Can't open device hci%d: %s (%d)",
+				adapter->dev_id, strerror(errno), errno);
+		return err;
+	}
+
+	dev_class = (value << 16) | (cls[1] << 8) | cls[0];
+
+	debug("Changing service classes to 0x%06x", dev_class);
+
+	if (hci_write_class_of_dev(dd, dev_class, HCI_REQ_TIMEOUT) < 0) {
+		err = -errno;
+		error("Can't write class of device: %s (%d)",
+						strerror(errno), errno);
+		hci_close_dev(dd);
+		return err;
+	}
+
+	hci_close_dev(dd);
+
+	return 0;
+}
+
+int set_major_and_minor_class(struct btd_adapter *adapter, uint8_t major, uint8_t minor)
+{
+	struct hci_dev *dev = &adapter->dev;
+	const uint8_t *cls = dev->class;
+	uint32_t dev_class;
+	int dd, err;
+
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0) {
+		err = -errno;
+		error("Can't open device hci%d: %s (%d)",
+				adapter->dev_id, strerror(errno), errno);
+		return err;
+	}
+
+	dev_class = (cls[2] << 16) | ((cls[1] & 0x20) << 8) |
+						((major & 0xdf) << 8) | minor;
+
+	debug("Changing major/minor class to 0x%06x", dev_class);
+
+	if (hci_write_class_of_dev(dd, dev_class, HCI_REQ_TIMEOUT) < 0) {
+		int err = -errno;
+		error("Can't write class of device: %s (%d)",
+						strerror(errno), errno);
+		hci_close_dev(dd);
+		return err;
+	}
+
+	hci_close_dev(dd);
+	return 0;
+}
+
 int pending_remote_name_cancel(struct btd_adapter *adapter)
 {
 	struct remote_dev_info *dev, match;
@@ -744,15 +811,21 @@ static DBusMessage *set_pairable_timeout(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static void update_ext_inquiry_response(int dd, struct hci_dev *dev)
+static void update_ext_inquiry_response(struct btd_adapter *adapter)
 {
 	uint8_t fec = 0, data[240];
+	struct hci_dev *dev = &adapter->dev;
+	int dd;
 
 	if (!(dev->features[6] & LMP_EXT_INQ))
 		return;
 
 	memset(data, 0, sizeof(data));
 
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0)
+		return;
+
 	if (dev->ssp_mode > 0)
 		create_ext_inquiry_response((char *) dev->name, data);
 
@@ -760,12 +833,13 @@ static void update_ext_inquiry_response(int dd, struct hci_dev *dev)
 						HCI_REQ_TIMEOUT) < 0)
 		error("Can't write extended inquiry response: %s (%d)",
 						strerror(errno), errno);
+
+	hci_close_dev(dd);
 }
 
 void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 {
 	struct hci_dev *dev = &adapter->dev;
-	int dd;
 
 	if (strncmp(name, (char *) dev->name, MAX_NAME_LENGTH) == 0)
 		return;
@@ -774,11 +848,7 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 
 	strncpy((char *) dev->name, name, MAX_NAME_LENGTH);
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd >= 0) {
-		update_ext_inquiry_response(dd, dev);
-		hci_close_dev(dd);
-	}
+	update_ext_inquiry_response(adapter);
 
 	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
 				"Name", DBUS_TYPE_STRING, &name);
@@ -812,10 +882,10 @@ static int adapter_set_name(struct btd_adapter *adapter, const char *name)
 		return err;
 	}
 
-	update_ext_inquiry_response(dd, dev);
-
 	hci_close_dev(dd);
 
+	update_ext_inquiry_response(adapter);
+
 	return 0;
 }
 
@@ -1664,14 +1734,22 @@ static int adapter_read_bdaddr(uint16_t dev_id, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static int adapter_setup(struct btd_adapter *adapter, int dd)
+static int adapter_setup(struct btd_adapter *adapter)
 {
 	struct hci_dev *dev = &adapter->dev;
 	uint8_t events[8] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0x1f, 0x00, 0x00 };
 	uint8_t inqmode;
-	int err;
+	int err , dd;
 	char name[MAX_NAME_LENGTH + 1];
 
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0) {
+		err = -errno;
+		error("Can't open device hci%d: %s (%d)",
+					adapter->dev_id, strerror(errno), errno);
+		return err;
+	}
+
 	if (dev->lmp_ver > 1) {
 		if (dev->features[5] & LMP_SNIFF_SUBR)
 			events[5] |= 0x20;
@@ -1710,11 +1788,11 @@ static int adapter_setup(struct btd_adapter *adapter, int dd)
 		hci_write_local_name(dd, name, HCI_REQ_TIMEOUT);
 	}
 
-	update_ext_inquiry_response(dd, dev);
+	update_ext_inquiry_response(adapter);
 
 	inqmode = get_inquiry_mode(dev);
 	if (inqmode < 1)
-		return 0;
+		goto done;
 
 	if (hci_write_inquiry_mode(dd, inqmode, HCI_REQ_TIMEOUT) < 0) {
 		err = -errno;
@@ -1724,6 +1802,8 @@ static int adapter_setup(struct btd_adapter *adapter, int dd)
 		return err;
 	}
 
+done:
+	hci_close_dev(dd);
 	return 0;
 }
 
@@ -2068,10 +2148,10 @@ int adapter_start(struct btd_adapter *adapter)
 setup:
 	hci_send_cmd(dd, OGF_LINK_POLICY, OCF_READ_DEFAULT_LINK_POLICY,
 								0, NULL);
-
-	adapter_setup(adapter, dd);
 	hci_close_dev(dd);
 
+	adapter_setup(adapter);
+
 	if (!adapter->initialized && adapter->already_up) {
 		debug("Stopping Inquiry at adapter startup");
 		adapter_ops->stop_discovery(adapter->dev_id);
@@ -2182,7 +2262,6 @@ int adapter_stop(struct btd_adapter *adapter)
 int adapter_update(struct btd_adapter *adapter, uint8_t new_svc)
 {
 	struct hci_dev *dev = &adapter->dev;
-	int dd;
 	uint8_t svclass;
 
 	if (dev->ignore)
@@ -2198,20 +2277,10 @@ int adapter_update(struct btd_adapter *adapter, uint8_t new_svc)
 	else
 		svclass = adapter->svc_cache;
 
-	dd = hci_open_dev(adapter->dev_id);
-	if (dd < 0) {
-		int err = -errno;
-		error("Can't open adapter %s: %s (%d)",
-					adapter->path, strerror(errno), errno);
-		return err;
-	}
-
 	if (svclass)
-		set_service_classes(dd, adapter->dev.class, svclass);
-
-	update_ext_inquiry_response(dd, dev);
+		set_service_classes(adapter, svclass);
 
-	hci_close_dev(dd);
+	update_ext_inquiry_response(adapter);
 
 	return 0;
 }
@@ -2248,15 +2317,13 @@ int adapter_set_class(struct btd_adapter *adapter, uint8_t *cls)
 	return 0;
 }
 
-int adapter_update_ssp_mode(struct btd_adapter *adapter, int dd, uint8_t mode)
+int adapter_update_ssp_mode(struct btd_adapter *adapter, uint8_t mode)
 {
 	struct hci_dev *dev = &adapter->dev;
 
 	dev->ssp_mode = mode;
 
-	update_ext_inquiry_response(dd, dev);
-
-	hci_close_dev(dd);
+	update_ext_inquiry_response(adapter);
 
 	return 0;
 }
diff --git a/src/adapter.h b/src/adapter.h
index ff599da..b4a3989 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -81,7 +81,7 @@ int adapter_get_class(struct btd_adapter *adapter, uint8_t *cls);
 
 int adapter_set_class(struct btd_adapter *adapter, uint8_t *cls);
 
-int adapter_update_ssp_mode(struct btd_adapter *adapter, int dd, uint8_t mode);
+int adapter_update_ssp_mode(struct btd_adapter *adapter, uint8_t mode);
 
 struct btd_device *adapter_get_device(DBusConnection *conn,
 				struct btd_adapter *adapter, const char *address);
@@ -131,6 +131,9 @@ gboolean adapter_has_discov_sessions(struct btd_adapter *adapter);
 
 struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter);
 void btd_adapter_unref(struct btd_adapter *adapter);
+int set_major_and_minor_class(struct btd_adapter *adapter,
+						uint8_t major, uint8_t minor);
+
 
 struct btd_adapter_driver {
 	const char *name;
diff --git a/src/dbus-hci.c b/src/dbus-hci.c
index bd5200f..1e6ec43 100644
--- a/src/dbus-hci.c
+++ b/src/dbus-hci.c
@@ -725,47 +725,6 @@ void hcid_dbus_disconn_complete(bdaddr_t *local, uint8_t status,
 	adapter_remove_connection(adapter, device, handle);
 }
 
-int set_service_classes(int dd, const uint8_t *cls, uint8_t value)
-{
-	uint32_t dev_class;
-
-	if (cls[2] == value)
-		return 0; /* Already set */
-
-	dev_class = (value << 16) | (cls[1] << 8) | cls[0];
-
-	debug("Changing service classes to 0x%06x", dev_class);
-
-	if (hci_write_class_of_dev(dd, dev_class, HCI_REQ_TIMEOUT) < 0) {
-		int err = -errno;
-		error("Can't write class of device: %s (%d)",
-						strerror(errno), errno);
-		return err;
-	}
-
-	return 0;
-}
-
-int set_major_and_minor_class(int dd, const uint8_t *cls,
-						uint8_t major, uint8_t minor)
-{
-	uint32_t dev_class;
-
-	dev_class = (cls[2] << 16) | ((cls[1] & 0x20) << 8) |
-						((major & 0xdf) << 8) | minor;
-
-	debug("Changing major/minor class to 0x%06x", dev_class);
-
-	if (hci_write_class_of_dev(dd, dev_class, HCI_REQ_TIMEOUT) < 0) {
-		int err = -errno;
-		error("Can't write class of device: %s (%d)",
-						strerror(errno), errno);
-		return err;
-	}
-
-	return 0;
-}
-
 /* Section reserved to device HCI callbacks */
 
 void hcid_dbus_setname_complete(bdaddr_t *local)
@@ -930,9 +889,9 @@ void hcid_dbus_write_simple_pairing_mode_complete(bdaddr_t *local)
 		return;
 	}
 
-	adapter_update_ssp_mode(adapter, dd, mode);
-
 	hci_close_dev(dd);
+
+	adapter_update_ssp_mode(adapter, mode);
 }
 
 int hcid_dbus_get_io_cap(bdaddr_t *local, bdaddr_t *remote,
diff --git a/src/dbus-hci.h b/src/dbus-hci.h
index ff8961a..d6d9a11 100644
--- a/src/dbus-hci.h
+++ b/src/dbus-hci.h
@@ -47,10 +47,6 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
 
 DBusMessage *new_authentication_return(DBusMessage *msg, uint8_t status);
 
-int set_service_classes(int dd, const uint8_t *cls, uint8_t value);
-int set_major_and_minor_class(int dd, const uint8_t *cls,
-						uint8_t major, uint8_t minor);
-
 const char *class_to_icon(uint32_t class);
 
 void set_dbus_connection(DBusConnection *conn);
-- 
1.5.6.3


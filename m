Return-Path: <cyrus@holtmann.org>
Message-ID: <49ADD4C8.8040705@trolltech.com>
Date: Wed, 04 Mar 2009 11:09:28 +1000
From: Bea Lam <bea.lam@trolltech.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add "Class" property to org.bluez.Adapter
Content-Type: multipart/mixed;
 boundary="------------030302050107000206080401"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030302050107000206080401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Marcel,

I mentioned on IRC a while back that a "Class" property for the Adapter
interface might be useful. I've attached a patch to this effect. Please
let me know if there are any issues.

cheers,

Bea



--------------030302050107000206080401
Content-Type: text/x-patch;
 name="adapter-class-property.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adapter-class-property.patch"

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index eb973ec..1e03b4e 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -210,6 +210,10 @@ Properties	string Address [readonly]
 			The Bluetooth friendly name. This value can be
 			changed and a PropertyChanged signal will be emitted.
 
+		uint32 Class [readonly]
+
+			The Bluetooth class of device.
+
 		boolean Powered [readwrite]
 
 			Switch an adapter on or off. This will also set the
diff --git a/src/adapter.c b/src/adapter.c
index 52b58c4..c48ec68 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1192,6 +1192,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	char str[249], srcaddr[18];
+	uint32_t class;
 	gboolean value;
 	char **devices;
 	int i;
@@ -1224,6 +1225,12 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &property);
 
+	/* Class */
+	class = adapter->dev.class[0]
+		| (adapter->dev.class[1] << 8)
+		| (adapter->dev.class[2] << 16);
+	dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32, &class);
+
 	/* Powered */
 	value = adapter->up ? TRUE : FALSE;
 	dict_append_entry(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
@@ -2326,6 +2333,8 @@ int adapter_get_class(struct btd_adapter *adapter, uint8_t *cls)
 int adapter_set_class(struct btd_adapter *adapter, uint8_t *cls)
 {
 	struct hci_dev *dev = &adapter->dev;
+	int dd;
+	uint32_t class;
 
 	if (memcmp(dev->class, cls, 3) == 0)
 		return 0;
@@ -2334,6 +2343,17 @@ int adapter_set_class(struct btd_adapter *adapter, uint8_t *cls)
 
 	write_local_class(&adapter->bdaddr, cls);
 
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd >= 0) {
+		update_ext_inquiry_response(dd, dev);
+		hci_close_dev(dd);
+	}
+
+	class = cls[0] | (cls[1] << 8) | (cls[2] << 16);
+
+	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
+				"Class", DBUS_TYPE_UINT32, &class);
+
 	return 0;
 }
 

--------------030302050107000206080401--

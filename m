Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org,
	johan.hedberg@intel.com,
	marcel@holtmann.org,
	deymo@chromium.org
Subject: [PATCH] Add GetCachedServices to device API.
Date: Fri,  1 Mar 2013 17:22:30 -0800
Message-Id: <1362187350-23421-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This fix implements a new GetCachedServices() function with similar
functionality as DiscoverServices(), except it only retrieves information
from an internal cache.

Signed-off-by: Alex Deymo <deymo@chromium.org>

---

Some background:
Currently, only the device properties are always available while the device
is off or out of range, but the service records are not. The
org.bluez.Device.ServiceRecords() call fails if the device is off, but some
important information relevant to the connection is present only there. For
example, for mice and keyboard, the HIDNormallyConnectable and
HIDReconnectInitiate tells if we are supposed to initiate a connection to
the device while it is off. When bluetoothd restarts and has such a divice
paired in its records, there is no way from the DBus interface to tell if
this device is "normally connectable" or not. This GetCachedServices() aims
to solve this problem.

 doc/device-api.txt |  19 ++++++++
 src/device.c       | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 0f916c7..4d4f698 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -92,6 +92,25 @@ Methods		void Connect()
 			Possible errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.Failed
 
+		dict GetCachedServices(string pattern)
+
+			This method is similar to DiscoverServices(pattern)
+			except that the retrieved service records are from
+			an internal cache instead of initiating a remote
+			service discovery. This cache is updated every time
+			DiscoverServices() returns any result. The pattern
+			parameter can be used to specify specific UUIDs.
+			An empty string will return all the records known for
+			this device.
+
+			The return value is a dictionary with the record
+			handles as keys and the service record in XML format
+			as values. The key is uint32 and the value a string
+			for this dictionary. If the cache is empty, an empty
+			dictionary is returned.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
diff --git a/src/device.c b/src/device.c
index 4320234..deb5a22 100644
--- a/src/device.c
+++ b/src/device.c
@@ -216,6 +216,7 @@ static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 							gboolean secure);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 							gboolean reverse);
+static sdp_list_t *read_device_records(struct btd_device *device);
 
 static gboolean store_device_info_cb(gpointer user_data)
 {
@@ -960,6 +961,140 @@ static void discover_services_req_exit(DBusConnection *conn, void *user_data)
 	browse_request_cancel(req);
 }
 
+static DBusMessage *build_services_reply(struct browse_req *req, int err,
+							sdp_list_t *recs)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, dict;
+	sdp_list_t *seq;
+
+	if (err) {
+		const char *err_if;
+
+		if (err == -EHOSTDOWN)
+			err_if = ERROR_INTERFACE ".ConnectionAttemptFailed";
+		else
+			err_if = ERROR_INTERFACE ".Failed";
+
+		reply = dbus_message_new_error(req->msg, err_if,
+							strerror(-err));
+		return reply;
+	}
+
+	reply = dbus_message_new_method_return(req->msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_UINT32_AS_STRING DBUS_TYPE_STRING_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	for (seq = recs; seq; seq = seq->next) {
+		sdp_record_t *rec = (sdp_record_t *) seq->data;
+		GString *result;
+
+		if (!rec)
+			break;
+
+		result = g_string_new(NULL);
+
+		convert_sdp_record_to_xml(rec, result,
+				(void *) g_string_append);
+
+		if (result->len)
+			iter_append_record(&dict, rec->handle, result->str);
+
+		g_string_free(result, TRUE);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *device_cached_sdp(struct btd_device *device,
+					DBusMessage *msg, uuid_t *search)
+{
+	DBusMessage *reply = NULL;
+	struct btd_adapter *adapter = device->adapter;
+	struct browse_req *req;
+	sdp_list_t *records;
+	const bdaddr_t *src;
+
+	if (!msg)
+		return NULL;
+
+	src = adapter_get_address(adapter);
+
+	req = g_new0(struct browse_req, 1);
+	req->device = btd_device_ref(device);
+
+	req->msg = dbus_message_ref(msg);
+
+	if (search) {
+		sdp_list_t *tmp_records = NULL;
+		sdp_record_t *rec = NULL;
+		gchar *uuid;
+		tmp_records = read_device_records(device);
+
+		uuid = bt_uuid2string(search);
+		if (uuid)
+			rec = find_record_in_list(tmp_records, uuid);
+		if (rec) {
+			records = sdp_list_append(NULL, rec);
+			tmp_records = sdp_list_remove(tmp_records, rec);
+		} else
+			records = NULL;
+
+		if (tmp_records)
+			sdp_list_free(tmp_records,
+					(sdp_free_func_t) sdp_record_free);
+		if (uuid)
+			g_free(uuid);
+	} else {
+		records = read_device_records(device);
+	}
+
+	reply = build_services_reply(req, 0, records);
+
+	if (records)
+		sdp_list_free(records, (sdp_free_func_t) sdp_record_free);
+
+	browse_request_free(req);
+
+	return reply;
+}
+
+static DBusMessage *get_cached_services(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_device *device = user_data;
+	const char *pattern;
+	DBusMessage *reply = NULL;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
+						DBUS_TYPE_INVALID) == FALSE)
+		return btd_error_invalid_args(msg);
+
+	if (strlen(pattern) == 0) {
+		reply = device_cached_sdp(device, msg, NULL);
+	} else {
+		uuid_t uuid;
+
+		if (bt_string2uuid(&uuid, pattern) < 0)
+			return btd_error_invalid_args(msg);
+
+		sdp_uuid128_to_uuid(&uuid);
+
+		reply = device_cached_sdp(device, msg, &uuid);
+	}
+
+	return reply;
+}
+
 static void bonding_request_cancel(struct bonding_req *bonding)
 {
 	struct btd_device *device = bonding->device;
@@ -1595,6 +1730,10 @@ static const GDBusMethodTable device_methods[] = {
 						NULL, disconnect_profile) },
 	{ GDBUS_ASYNC_METHOD("Pair", NULL, NULL, pair_device) },
 	{ GDBUS_METHOD("CancelPairing", NULL, NULL, cancel_pairing) },
+	{ GDBUS_METHOD("GetCachedServices",
+			GDBUS_ARGS({ "pattern", "s" }),
+			GDBUS_ARGS({ "services", "a{us}" }),
+			get_cached_services) },
 	{ }
 };
 
-- 
1.8.1.3

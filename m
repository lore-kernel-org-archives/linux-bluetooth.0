Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 4/8] dbusoob: Change AddRemoteData to match new API
Date: Mon, 13 Aug 2012 12:46:36 +0200
Message-ID: <1344854800-20972-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
References: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AddRemoteData now expect dictionary for data instead of hardcoded pair
of arrays.

---
 plugins/dbusoob.c |  126 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 108 insertions(+), 18 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 92c4df1..2ae80fa 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -51,6 +51,12 @@ struct oob_request {
 	DBusMessage *msg;
 };
 
+struct oob_data {
+	char *addr;
+	uint8_t *hash;
+	uint8_t *randomizer;
+};
+
 static GSList *oob_requests = NULL;
 static DBusConnection *connection = NULL;
 
@@ -142,28 +148,113 @@ static DBusMessage *read_local_data(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
+{
+	while (dbus_message_iter_get_arg_type(data) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(data, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "Hash") == 0) {
+			DBusMessageIter array;
+			int size;
+
+			if (var != DBUS_TYPE_ARRAY)
+				return FALSE;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array,
+						&remote_data->hash, &size);
+
+			if (size != 16)
+				return FALSE;
+		} else if (strcasecmp(key, "Randomizer") == 0) {
+			DBusMessageIter array;
+			int size;
+
+			if (var != DBUS_TYPE_ARRAY)
+				return FALSE;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array,
+						&remote_data->randomizer,
+						&size);
+
+			if (size != 16)
+				return FALSE;
+		}
+
+		dbus_message_iter_next(data);
+	}
+
+	if (dbus_message_iter_get_arg_type(data) != DBUS_TYPE_INVALID)
+		return FALSE;
+
+	/* If randomizer is provided, hash also needs to be provided. */
+	if (remote_data->randomizer && !remote_data->hash)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
 {
-	struct btd_adapter *adapter = data;
-	uint8_t *hash, *randomizer;
-	int32_t hlen, rlen;
-	const char *addr;
 	bdaddr_t bdaddr;
 
-	if (!dbus_message_get_args(msg, NULL,
-			DBUS_TYPE_STRING, &addr,
-			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &hash, &hlen,
-			DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE, &randomizer, &rlen,
-			DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
+	str2ba(data->addr, &bdaddr);
+
+	if (data->hash) {
+		uint8_t empty_randomizer[16];
 
-	if (hlen != 16 || rlen != 16 || bachk(addr))
+		if (!data->randomizer) {
+			memset(empty_randomizer, 0, sizeof(empty_randomizer));
+			data->randomizer = empty_randomizer;
+		}
+
+		if (btd_adapter_add_remote_oob_data(adapter, &bdaddr,
+					data->hash, data->randomizer) < 0)
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
+static DBusMessage *add_remote_data(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessageIter args;
+	DBusMessageIter data;
+	struct oob_data remote_data;
+	struct btd_device *device;
+
+	memset(&remote_data, 0, sizeof(remote_data));
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &remote_data.addr);
+	dbus_message_iter_next(&args);
+
+	if (bachk(remote_data.addr) < 0)
 		return btd_error_invalid_args(msg);
 
-	str2ba(addr, &bdaddr);
+	device = adapter_find_device(adapter, remote_data.addr);
+	if (device && device_is_paired(device))
+		return btd_error_already_exists(msg);
+
+	dbus_message_iter_recurse(&args, &data);
+
+	if (!parse_data(&data, &remote_data))
+		return btd_error_invalid_args(msg);
 
-	if (btd_adapter_add_remote_oob_data(adapter, &bdaddr, hash, randomizer))
+	if (!store_data(adapter, &remote_data))
 		return btd_error_failed(msg, "Request failed");
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
@@ -191,9 +282,8 @@ static DBusMessage *remove_remote_data(DBusConnection *conn, DBusMessage *msg,
 
 static const GDBusMethodTable oob_methods[] = {
 	{ GDBUS_METHOD("AddRemoteData",
-			GDBUS_ARGS({ "address", "s" }, { "hash", "ay" },
-					{ "randomizer", "ay" }), NULL,
-			add_remote_data) },
+			GDBUS_ARGS({ "address", "s" }, { "data", "a{sv}"}),
+			NULL, add_remote_data) },
 	{ GDBUS_METHOD("RemoveRemoteData",
 			GDBUS_ARGS({ "address", "s" }), NULL,
 			remove_remote_data) },
-- 
1.7.9.5


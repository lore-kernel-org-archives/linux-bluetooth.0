Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH BlueZ v2 3/3] Add support for name in OOB SetRemoteProperties
Date: Mon, 22 Aug 2011 14:09:04 +0200
Message-Id: <1314014944-21554-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314014944-21554-1-git-send-email-bulislaw@linux.com>
References: <1314014944-21554-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/oob-api.txt   |    1 +
 plugins/dbusoob.c |   34 ++++++++++++++++++++++++++++++++++
 src/storage.c     |    2 +-
 src/storage.h     |    2 +-
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index 500ef15..2d0d096 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -49,6 +49,7 @@ Methods		array{byte} hash, array{byte} randomizer ReadLocalData()
 				Class		uint32
 				Hash		array{byte}
 				Randomizer	array{byte}
+				Name		String
 
 			Possible errors: org.bluez.Error.Failed
 					 org.bluez.Error.InvalidArguments
diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index f0bbd14..412cd67 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -59,6 +59,7 @@ struct oob_remote_parameters {
 	uint32_t class;
 	uint8_t *hash;
 	uint8_t *randomizer;
+	const char *name;
 	gboolean device_found;
 };
 
@@ -191,6 +192,10 @@ static void emit_device_found(const char *path,
 		dict_append_entry(&dict, "Class", DBUS_TYPE_UINT32,
 							&params->class);
 
+	if (params->name != NULL)
+		dict_append_entry(&dict, "Name", DBUS_TYPE_STRING,
+							&params->name);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	g_dbus_send_message(connection, signal);
@@ -255,6 +260,29 @@ static void set_oob_data(struct btd_adapter *adapter,
 		error("Adding remote OOB data failed");
 }
 
+static DBusMessage *parse_name(DBusMessageIter *value,
+			struct oob_remote_parameters *params, DBusMessage *msg)
+{
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(value, &params->name);
+
+	return NULL;
+}
+
+static void set_name(struct oob_remote_parameters *params)
+{
+	if (write_device_name(&params->local, &params->peer,
+							params->name) < 0) {
+		error("Setting device name failed");
+
+		return;
+	}
+
+	params->device_found = TRUE;
+}
+
 static DBusMessage *parse_property(const char *property,
 				DBusMessageIter *value, DBusMessage *msg,
 				struct oob_remote_parameters *params)
@@ -262,6 +290,9 @@ static DBusMessage *parse_property(const char *property,
 	if (g_str_equal("Class", property))
 		return parse_class(value, params, msg);
 
+	if (g_str_equal("Name", property))
+		return parse_name(value, params, msg);
+
 	if (g_str_equal("Hash", property))
 		return parse_oob_data(value, &params->hash, msg);
 
@@ -277,6 +308,9 @@ static void set_properties(struct btd_adapter *adapter,
 	if (params->class != 0)
 		set_class(params);
 
+	if (params->name != NULL)
+		set_name(params);
+
 	if (params->hash != NULL && params->randomizer != NULL)
 		set_oob_data(adapter, params);
 
diff --git a/src/storage.c b/src/storage.c
index 1f3da6e..414d158 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -321,7 +321,7 @@ int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class)
 	return 0;
 }
 
-int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name)
+int write_device_name(bdaddr_t *local, bdaddr_t *peer, const char *name)
 {
 	char filename[PATH_MAX + 1], addr[18], str[249];
 	int i;
diff --git a/src/storage.h b/src/storage.h
index bb64727..78513ac 100644
--- a/src/storage.h
+++ b/src/storage.h
@@ -38,7 +38,7 @@ int write_local_class(bdaddr_t *bdaddr, uint8_t *class);
 int read_local_class(bdaddr_t *bdaddr, uint8_t *class);
 int write_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class);
 int read_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t *class);
-int write_device_name(bdaddr_t *local, bdaddr_t *peer, char *name);
+int write_device_name(bdaddr_t *local, bdaddr_t *peer, const char *name);
 int read_device_name(const char *src, const char *dst, char *name);
 int write_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data);
 int read_remote_eir(bdaddr_t *local, bdaddr_t *peer, uint8_t *data);
-- 
1.7.4.1


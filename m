Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/4] client: Add authorization request handling for attribute operations
Date: Tue, 20 Mar 2018 15:05:19 +0100
Message-Id: <20180320140519.6285-4-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180320140519.6285-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180320140519.6285-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds optional authorization request for reading, writing of
gatt database attributes.
---
 client/gatt.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/main.c |  11 +++--
 2 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 3fa490b1a..930a64699 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -75,6 +75,8 @@ struct chrc {
 	uint16_t mtu;
 	struct io *write_io;
 	struct io *notify_io;
+	bool authorization_req;
+	bool authorized;
 };
 
 struct service {
@@ -91,6 +93,7 @@ static GList *characteristics;
 static GList *descriptors;
 static GList *managers;
 static GList *uuids;
+static DBusMessage *pending_message = NULL;
 
 struct pipe_io {
 	GDBusProxy *proxy;
@@ -1462,17 +1465,81 @@ static DBusMessage *read_value(DBusMessage *msg, uint8_t *value,
 	return reply;
 }
 
+struct authorize_attribute_data {
+	DBusConnection *conn;
+	void *attribute;
+	uint16_t offset;
+};
+
+static void authorize_read_response(const char *input, void *user_data)
+{
+	struct authorize_attribute_data *aad = user_data;
+	struct chrc *chrc = aad->attribute;
+	DBusMessage *reply;
+	char *err;
+
+	if (!strcmp(input, "no")) {
+		err = "org.bluez.Error.NotAuthorized";
+
+		goto error;
+	}
+
+	if (aad->offset > chrc->value_len) {
+		err = "org.bluez.Error.InvalidOffset";
+
+		goto error;
+	}
+
+	reply = read_value(pending_message, &chrc->value[aad->offset],
+						chrc->value_len - aad->offset);
+
+	chrc->authorized = true;
+
+	g_dbus_send_message(aad->conn, reply);
+
+	g_free(aad);
+
+	return;
+
+error:
+	g_dbus_send_error(aad->conn, pending_message, err, NULL);
+	g_free(aad);
+}
+
 static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct chrc *chrc = user_data;
 	DBusMessageIter iter;
 	uint16_t offset = 0;
+	char *str;
 
 	dbus_message_iter_init(msg, &iter);
 
 	parse_offset(&iter, &offset);
 
+	if (chrc->authorization_req && offset == 0)
+		chrc->authorized = false;
+
+	if (chrc->authorization_req && !chrc->authorized) {
+		struct authorize_attribute_data *aad;
+
+		aad = g_new0(struct authorize_attribute_data, 1);
+		aad->conn = conn;
+		aad->attribute = chrc;
+		aad->offset = offset;
+
+		str = g_strdup_printf("Authorize attribute(%s) read (yes/no):",
+								chrc->path);
+
+		bt_shell_prompt_input("gatt", str, authorize_read_response,
+									aad);
+
+		pending_message = dbus_message_ref(msg);
+
+		return NULL;
+	}
+
 	if (offset > chrc->value_len)
 		return g_dbus_create_error(msg, "org.bluez.Error.InvalidOffset",
 									NULL);
@@ -1493,14 +1560,74 @@ static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
 	return 0;
 }
 
+static void authorize_write_response(const char *input, void *user_data)
+{
+	struct authorize_attribute_data *aad = user_data;
+	struct chrc *chrc = aad->attribute;
+	DBusMessageIter iter;
+	DBusMessage *reply;
+	char *err;
+
+	dbus_message_iter_init(pending_message, &iter);
+
+	if (!strcmp(input, "no")) {
+		err = "org.bluez.Error.NotAuthorized";
+
+		goto error;
+	}
+
+	chrc->authorized = true;
+
+	if (parse_value_arg(&iter, &chrc->value, &chrc->value_len)) {
+		err = "org.bluez.Error.InvalidArguments";
+
+		goto error;
+	}
+
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
+
+	g_dbus_emit_property_changed(aad->conn, chrc->path, CHRC_INTERFACE,
+								"Value");
+
+	reply = g_dbus_create_reply(pending_message, DBUS_TYPE_INVALID);
+	g_dbus_send_message(aad->conn, reply);
+
+	g_free(aad);
+
+	return;
+
+error:
+	g_dbus_send_error(aad->conn, pending_message, err, NULL);
+	g_free(aad);
+}
+
 static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct chrc *chrc = user_data;
 	DBusMessageIter iter;
+	char *str;
 
 	dbus_message_iter_init(msg, &iter);
 
+	if (chrc->authorization_req && !chrc->authorized) {
+		struct authorize_attribute_data *aad;
+
+		aad = g_new0(struct authorize_attribute_data, 1);
+		aad->conn = conn;
+		aad->attribute = chrc;
+
+		str = g_strdup_printf("Authorize attribute(%s) write (yes/no):",
+								chrc->path);
+
+		bt_shell_prompt_input("gatt", str, authorize_write_response,
+									aad);
+
+		pending_message = dbus_message_ref(msg);
+
+		return NULL;
+	}
+
 	if (parse_value_arg(&iter, &chrc->value, &chrc->value_len))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
@@ -1763,6 +1890,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc->uuid = g_strdup(argv[1]);
 	chrc->path = g_strdup_printf("%s/chrc%p", service->path, chrc);
 	chrc->flags = g_strsplit(argv[2], ",", -1);
+	chrc->authorization_req = argc > 3 ? true : false;
 
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
 					chrc_methods, NULL, chrc_properties,
diff --git a/client/main.c b/client/main.c
index a83010b48..f962e9a43 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2011,6 +2011,11 @@ static void cmd_register_characteristic(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
+	if (argc > 3 && strcmp(argv[3], "authz-req")) {
+		bt_shell_printf("Wrong authorization argument\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
 	gatt_register_chrc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -2428,9 +2433,9 @@ static const struct bt_shell_menu gatt_menu = {
 					"Register application service."  },
 	{ "unregister-service", "<UUID/object>", cmd_unregister_service,
 					"Unregister application service" },
-	{ "register-characteristic", "<UUID> <Flags=read,write,notify...>",
-					cmd_register_characteristic,
-					"Register application characteristic" },
+	{ "register-characteristic", "<UUID> <Flags=read,write,notify...> "
+				"[authz-req]", cmd_register_characteristic,
+				"Register application characteristic" },
 	{ "unregister-characteristic", "<UUID/object>",
 				cmd_unregister_characteristic,
 				"Unregister application characteristic" },
-- 
2.13.6


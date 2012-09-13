Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/8] client: Add MessageAccess.ListFilterFields
Date: Thu, 13 Sep 2012 16:06:56 +0300
Message-Id: <1347541621-26858-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
References: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/map.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/client/map.c b/client/map.c
index 6d1b0f2..cf3d8ed 100644
--- a/client/map.c
+++ b/client/map.c
@@ -1011,6 +1011,41 @@ static DBusMessage *map_list_messages(DBusConnection *connection,
 	return get_message_listing(map, message, folder, apparam);
 }
 
+static gchar **get_filter_strs(uint64_t filter, gint *size)
+{
+	gchar **list, **item;
+	gint i;
+
+	list = g_malloc0(sizeof(gchar **) * (FILTER_BIT_MAX + 2));
+
+	item = list;
+
+	for (i = 0; filter_list[i] != NULL; i++)
+		if (filter & (1ULL << i))
+			*(item++) = g_strdup(filter_list[i]);
+
+	*item = NULL;
+	*size = item - list;
+	return list;
+}
+
+static DBusMessage *map_list_filter_fields(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	gchar **filters = NULL;
+	gint size;
+	DBusMessage *reply;
+
+	filters = get_filter_strs(FILTER_ALL, &size);
+	reply = dbus_message_new_method_return(message);
+	dbus_message_append_args(reply, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING, &filters, size,
+				DBUS_TYPE_INVALID);
+
+	g_strfreev(filters);
+	return reply;
+}
+
 static const GDBusMethodTable map_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "s" }), NULL,
@@ -1023,6 +1058,10 @@ static const GDBusMethodTable map_methods[] = {
 			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{sv}" }),
 			GDBUS_ARGS({ "messages", "a{oa{sv}}" }),
 			map_list_messages) },
+	{ GDBUS_METHOD("ListFilterFields",
+			NULL,
+			GDBUS_ARGS({ "fields", "as" }),
+			map_list_filter_fields) },
 	{ }
 };
 
-- 
1.7.11.4


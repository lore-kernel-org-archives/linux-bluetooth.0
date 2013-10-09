Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] obexd/MAP: Fix parsing message handles as decimal numbers
Date: Wed,  9 Oct 2013 14:11:41 +0300
Message-Id: <1381317105-10729-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
References: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec clearly states the handles are hexadecimal:

MAP 1.2 - Page 29

  ""handle" is the message handle in hexadecimal representation with up
  to 16 digits; leading zero digits may be used so the MCE shall accept
  both handles with and without leading zeros (e.g.,"00000012345678AB"
  or "12345678AB")."
---
 obexd/client/map.c | 12 ++++++------
 obexd/client/mns.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 9d90a92..d2d3d81 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -435,7 +435,7 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 	GError *err = NULL;
 	DBusMessage *reply;
 	GObexApparam *apparam;
-	char handle[21];
+	char handle[17];
 
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &target_file,
@@ -444,7 +444,7 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 
-	if (snprintf(handle, sizeof(handle), "%" PRIu64, msg->handle) < 0)
+	if (snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle) < 0)
 		goto fail;
 
 	transfer = obc_transfer_get("x-bt/message", handle, target_file, &err);
@@ -730,7 +730,7 @@ static void set_status(const GDBusPropertyTable *property,
 	GError *err = NULL;
 	GObexApparam *apparam;
 	char contents[1];
-	char handle[21];
+	char handle[17];
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN) {
 		g_dbus_pending_property_error(id,
@@ -743,7 +743,7 @@ static void set_status(const GDBusPropertyTable *property,
 
 	contents[0] = FILLER_BYTE;
 
-	if (snprintf(handle, sizeof(handle), "%" PRIu64, msg->handle) < 0)
+	if (snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle) < 0)
 		goto fail;
 
 	transfer = obc_transfer_put("x-bt/messageStatus", handle, NULL,
@@ -1110,7 +1110,7 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 			break;
 	}
 
-	handle = strtoull(values[i], NULL, 10);
+	handle = strtoull(values[i], NULL, 16);
 
 	msg = g_hash_table_lookup(data->messages, &handle);
 	if (msg == NULL) {
@@ -1897,7 +1897,7 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 
 	DBG("Event report for %s:%d", obc_session_get_destination(map->session),
 							map->mas_instance_id);
-	DBG("type=%x handle=%" PRIu64 " folder=%s old_folder=%s msg_type=%s",
+	DBG("type=%x handle=%" PRIx64 " folder=%s old_folder=%s msg_type=%s",
 		event->type, event->handle, event->folder, event->old_folder,
 		event->msg_type);
 
diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 2d2730d..d638886 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -185,7 +185,7 @@ static void parse_event_report_type(struct map_event *event, const char *value)
 static void parse_event_report_handle(struct map_event *event,
 							const char *value)
 {
-	event->handle = strtoull(value, NULL, 10);
+	event->handle = strtoull(value, NULL, 16);
 }
 
 static void parse_event_report_folder(struct map_event *event,
-- 
1.8.3.1


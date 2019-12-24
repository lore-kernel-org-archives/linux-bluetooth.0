Return-Path: <SRS0=L7UJ=2O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCABC2D0C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 05:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2EA206CB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 05:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfLXF0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Dec 2019 00:26:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:5863 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfLXF0x (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Dec 2019 00:26:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 21:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; 
   d="scan'208";a="249713664"
Received: from unknown (HELO ajay-desktop.iind.intel.com) ([10.223.96.133])
  by fmsmga002.fm.intel.com with ESMTP; 23 Dec 2019 21:26:50 -0800
From:   Ajay Kishore <ajay.kishore@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] obexd: Add parser for conversation element
Date:   Tue, 24 Dec 2019 10:33:01 +0530
Message-Id: <1577163782-28759-1-git-send-email-ajay.kishore@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Changes made to define convo parser function to iterate through
all supported conversation elements and parse their values.

Co-authored-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
---
 obexd/client/map.c | 427 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 obexd/src/map_ap.h |  40 ++---
 2 files changed, 446 insertions(+), 21 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index f2f2b73..9757b99 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -139,12 +139,35 @@ struct map_msg {
 	GDBusPendingPropertySet pending;
 };
 
+struct map_convo {
+	struct map_data *data;
+	char *path;
+	uint64_t id;
+	char *convo_name;
+	char *convo_last_activity;
+	char *read_status;
+	char *summary;
+	char *uci;
+	char *display_name;
+	uint8_t chat_state;
+	char *last_activity;
+	char *x_bt_uid;
+	char *name;
+	uint8_t presence_availability;
+	char *presence_text;
+	int8_t priority;
+	char *folder;
+};
+
 struct map_parser {
 	struct pending_request *request;
 	DBusMessageIter *iter;
 };
 
 static DBusConnection *conn = NULL;
+DBusMessageIter convo_entry, *convo_iter;
+struct map_convo *conversation;
+static bool convo_element_end = FALSE;
 
 static struct pending_request *pending_request_new(struct map_data *map,
 							DBusMessage *message)
@@ -837,6 +860,8 @@ static void parse_type(struct map_msg *msg, const char *value)
 		type = "email";
 	else if (strcasecmp(value, "MMS") == 0)
 		type = "mms";
+	else if (strcasecmp(value, "IM") == 0)
+		type = "IM";
 
 	if (g_strcmp0(msg->type, type) == 0)
 		return;
@@ -1074,6 +1099,285 @@ static void parse_protected(struct map_msg *msg, const char *value)
 						MAP_MSG_INTERFACE, "Protected");
 }
 
+static void map_convo_free(void *data)
+{
+	struct map_convo *convo = data;
+
+	g_free(convo->path);
+	g_free(convo->convo_name);
+	g_free(convo->folder);
+	g_free(convo->convo_last_activity);
+	g_free(convo->read_status);
+	g_free(convo->summary);
+	g_free(convo->uci);
+	g_free(convo->display_name);
+	g_free(convo->last_activity);
+	g_free(convo->x_bt_uid);
+	g_free(convo->name);
+	g_free(convo->presence_text);
+	g_free(convo);
+}
+
+static gboolean convo_name_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct map_convo *convo = data;
+
+	return convo->convo_name != NULL;
+}
+
+static gboolean get_convo_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_convo *convo = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+						&convo->convo_name);
+
+	return TRUE;
+}
+
+static gboolean summary_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct map_convo *convo = data;
+
+	return convo->summary != NULL;
+}
+
+static gboolean get_summary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_convo *convo = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&convo->summary);
+
+	return TRUE;
+}
+
+static gboolean uci_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_convo *convo = data;
+
+	return convo->uci != NULL;
+}
+
+static gboolean get_uci(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_convo *convo = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&convo->uci);
+
+	return TRUE;
+}
+
+static gboolean display_name_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct map_convo *convo = data;
+
+	return convo->display_name != NULL;
+}
+
+static gboolean get_display_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_convo *convo = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+						&convo->display_name);
+
+	return TRUE;
+}
+
+static gboolean x_bt_uid_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct map_convo *convo = data;
+
+	return convo->x_bt_uid != NULL;
+}
+
+static gboolean get_x_bt_uid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_convo *convo = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64,
+							&convo->x_bt_uid);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable map_convo_properties[] = {
+	{ "ConvoName", "s", get_convo_name, NULL, convo_name_exists },
+	{ "Summary", "s", get_summary, NULL, summary_exists },
+	{ "Uci", "s", get_uci, NULL, uci_exists },
+	{ "DisplayName", "s", get_display_name, NULL, display_name_exists },
+	{ "XBtUid", "s", get_x_bt_uid, NULL, x_bt_uid_exists},
+	{ }
+};
+
+static void parse_convo_name(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->convo_name, value) == 0)
+		return;
+	g_free(convo->convo_name);
+	convo->convo_name = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+				MAP_CONV_INTERFACE, "ConvoName");
+}
+
+static void parse_convo_last_activity(struct map_convo *convo,
+							const char *value)
+{
+	if (g_strcmp0(convo->convo_last_activity, value) == 0)
+		return;
+
+	g_free(convo->convo_last_activity);
+	convo->convo_last_activity = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+				MAP_CONV_INTERFACE, "ConvoLastActivity");
+}
+
+static void parse_read_status(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->read_status, value) == 0)
+		return;
+
+	g_free(convo->read_status);
+	convo->read_status = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+				MAP_CONV_INTERFACE, "ReadStatus");
+}
+
+static void parse_summary(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->summary, value) == 0)
+		return;
+
+	g_free(convo->summary);
+	convo->summary = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "Summary");
+}
+
+static void parse_uci(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->uci, value) == 0)
+		return;
+
+	g_free(convo->uci);
+	convo->uci = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "Uci");
+}
+
+static void parse_display_name(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->display_name, value) == 0)
+		return;
+
+	g_free(convo->display_name);
+	convo->display_name = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "DisplayName");
+}
+
+static void parse_chat_state(struct map_convo *convo, const char *value)
+{
+	uint8_t chat_state = g_ascii_strtoll(value, NULL, 10);
+
+	if (convo->chat_state == chat_state)
+		return;
+
+	convo->chat_state = chat_state;
+
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "ChatState");
+}
+
+static void parse_last_activity(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->last_activity, value) == 0)
+		return;
+
+	g_free(convo->last_activity);
+	convo->last_activity = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "LastActivity");
+}
+
+static void parse_x_bt_uid(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->x_bt_uid, value) == 0)
+		return;
+
+	g_free(convo->x_bt_uid);
+	convo->x_bt_uid = g_strdup(value);
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "X_BT_UID");
+}
+
+static void parse_name(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->name, value) == 0)
+		return;
+
+	g_free(convo->name);
+	convo->name = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "Name");
+}
+
+static void parse_presence_availability(struct map_convo *convo,
+							const char *value)
+{
+	uint8_t presence_availability = g_ascii_strtoll(value, NULL, 10);
+
+	if (convo->presence_availability == presence_availability)
+		return;
+
+	convo->presence_availability = presence_availability;
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE,
+					"PresenceAvailability");
+}
+
+static void parse_presence_text(struct map_convo *convo, const char *value)
+{
+	if (g_strcmp0(convo->presence_text, value) == 0)
+		return;
+
+	g_free(convo->presence_text);
+	convo->presence_text = g_strdup(value);
+
+	g_dbus_emit_property_changed(conn, convo->path,
+					MAP_CONV_INTERFACE, "PresenceText");
+}
+
+static void parse_convo_priority(struct map_convo *convo, const char *value)
+{
+	int8_t priority = g_ascii_strtoll(value, NULL, 10);
+
+	if (convo->priority == priority)
+		return;
+
+	convo->priority = priority;
+	g_dbus_emit_property_changed(conn, convo->path,
+				MAP_CONV_INTERFACE, "Priority");
+}
+
 static struct map_msg_parser {
 	const char *name;
 	void (*func) (struct map_msg *msg, const char *value);
@@ -1097,6 +1401,55 @@ static struct map_msg_parser {
 		{ }
 };
 
+static struct map_convo_parser {
+	const char *name;
+	void (*func)(struct map_convo *convo, const char *value);
+} convo_parsers[] = {
+		{ "name", parse_convo_name },
+		{ "last_activity", parse_convo_last_activity },
+		{ "read_status", parse_read_status },
+		{ "summary", parse_summary },
+		{ "x_bt_uci", parse_uci },
+		{ "display_name", parse_display_name },
+		{ "chat_state", parse_chat_state },
+		{ "last_activity", parse_last_activity },
+		{ "x_bt_uid", parse_x_bt_uid },
+		{ "name", parse_name },
+		{ "presence_availability", parse_presence_availability },
+		{ "presence_text", parse_presence_text },
+		{ "priority", parse_convo_priority },
+		{ }
+};
+
+static struct map_convo *map_convo_create(struct map_data *data,
+						uint64_t id,
+						const char *folder,
+						const char *type)
+{
+	struct map_convo *convo;
+
+	convo = g_new0(struct map_convo, 1);
+	convo->data = data;
+	convo->id = id;
+
+	convo->path = g_strdup_printf("%s/message%" PRIu64,
+					obc_session_get_path(data->session),
+					convo->id);
+
+	convo->folder = g_strdup(folder);
+
+	if (!g_dbus_register_interface(conn, convo->path, MAP_CONV_INTERFACE,
+						map_msg_methods, NULL,
+						map_convo_properties,
+						convo, map_convo_free)) {
+		map_convo_free(convo);
+		return NULL;
+	}
+	g_hash_table_insert(data->messages, &convo->id, convo);
+
+	return convo;
+}
+
 static void msg_element(GMarkupParseContext *ctxt, const char *element,
 				const char **names, const char **values,
 				gpointer user_data, GError **gerr)
@@ -1150,6 +1503,72 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 	dbus_message_iter_close_container(iter, &entry);
 }
 
+static void start_convo_element(GMarkupParseContext *ctxt, const char *element,
+				const char **names, const char **values,
+				gpointer user_data, GError **gerr)
+{
+	struct map_parser *parser = user_data;
+	struct map_data *data = parser->request->map;
+	uint32_t id = 0;
+	const char *key;
+	int i;
+	DBusMessageIter *iter = parser->iter;
+
+	for (i = 0, key = names[i]; key; key = names[++i]) {
+		if (strcasecmp(key, "id") == 0) {
+			id = strtoull(values[i], NULL, 32);
+			break;
+		}
+	}
+
+	if (id == 0)
+		return;
+
+	conversation = g_hash_table_lookup(data->messages, &id);
+	if (conversation == NULL) {
+		conversation = map_convo_create(data, id,
+					parser->request->folder, NULL);
+		if (conversation == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY, NULL,
+								&convo_entry);
+	dbus_message_iter_append_basic(&convo_entry, DBUS_TYPE_OBJECT_PATH,
+							&conversation->path);
+
+	for (i = 0, key = names[i]; key; key = names[++i]) {
+		struct map_convo_parser *parser;
+
+		for (parser = convo_parsers; parser && parser->name; parser++) {
+			if (strcasecmp(key, parser->name) == 0) {
+				if (values[i])
+					parser->func(conversation, values[i]);
+					break;
+			}
+		}
+	}
+
+	g_dbus_get_properties(conn, conversation->path, MAP_CONV_INTERFACE,
+								&convo_entry);
+	dbus_message_iter_close_container(iter, &convo_entry);
+}
+
+static void end_convo_element(GMarkupParseContext *ctxt, const char *element,
+					gpointer user_data, GError **gerr)
+{
+	if (strcasecmp("MAP-convo-listing", element) == 0)
+		convo_element_end = TRUE;
+}
+
+static const GMarkupParser convo_parser = {
+	start_convo_element,
+	end_convo_element,
+	NULL,
+	NULL,
+	NULL
+};
+
 static const GMarkupParser msg_parser = {
 	msg_element,
 	NULL,
@@ -1268,9 +1687,15 @@ static void conversation_listing_cb(struct obc_session *session,
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&array);
-
+	parser = g_new(struct map_parser, 1);
+	parser->request = request;
+	parser->iter = &array;
+	ctxt = g_markup_parse_context_new(&convo_parser, 0, parser, NULL);
+	g_markup_parse_context_parse(ctxt, contents, size, NULL);
+	g_markup_parse_context_free(ctxt);
 	dbus_message_iter_close_container(&iter, &array);
 	g_free(contents);
+	g_free(parser);
 
 done:
 	if (convo_element_end)
diff --git a/obexd/src/map_ap.h b/obexd/src/map_ap.h
index 3773859..d6577fd 100644
--- a/obexd/src/map_ap.h
+++ b/obexd/src/map_ap.h
@@ -30,25 +30,25 @@ enum map_ap_tag {
 	MAP_AP_FILTERPERIODEND		= 0x05,		/* char *	*/
 	MAP_AP_FILTERREADSTATUS		= 0x06,		/* uint8_t	*/
 	MAP_AP_FILTERRECIPIENT		= 0x07,		/* char *	*/
-	MAP_AP_FILTERORIGINATOR		= 0x08,		/* char *	*/
-	MAP_AP_FILTERLASTACTIVITYBEGIN	= 0x08,		/* char *       */
-	MAP_AP_FILTERLASTACTIVITYEND	= 0x09,		/* char *       */
-	MAP_AP_FILTERPRIORITY		= 0x09,		/* uint8_t	*/
-	MAP_AP_ATTACHMENT		= 0x0A,		/* uint8_t	*/
-	MAP_AP_TRANSPARENT		= 0x0B,		/* uint8_t	*/
-	MAP_AP_RETRY			= 0x0C,		/* uint8_t	*/
-	MAP_AP_NEWMESSAGE		= 0x0D,		/* uint8_t	*/
-	MAP_AP_NOTIFICATIONSTATUS	= 0x0E,		/* uint8_t	*/
-	MAP_AP_MASINSTANCEID		= 0x0F,		/* uint8_t	*/
-	MAP_AP_PARAMETERMASK		= 0x10,		/* uint32_t	*/
-	MAP_AP_FOLDERLISTINGSIZE	= 0x11,		/* uint16_t	*/
-	MAP_AP_MESSAGESLISTINGSIZE	= 0x12,		/* uint16_t	*/
-	MAP_AP_SUBJECTLENGTH		= 0x13,		/* uint8_t	*/
-	MAP_AP_CHARSET			= 0x14,		/* uint8_t	*/
-	MAP_AP_FRACTIONREQUEST		= 0x15,		/* uint8_t	*/
-	MAP_AP_FRACTIONDELIVER		= 0x16,		/* uint8_t	*/
-	MAP_AP_STATUSINDICATOR		= 0x17,		/* uint8_t	*/
-	MAP_AP_STATUSVALUE		= 0x18,		/* uint8_t	*/
-	MAP_AP_MSETIME			= 0x19,		/* char *	*/
+	MAP_AP_FILTERLASTACTIVITYBEGIN	= 0x08,         /* char *       */
+	MAP_AP_FILTERLASTACTIVITYEND	= 0x09,         /* char *       */
+	MAP_AP_FILTERORIGINATOR		= 0x0A,		/* char *	*/
+	MAP_AP_FILTERPRIORITY		= 0x0B,		/* uint8_t	*/
+	MAP_AP_ATTACHMENT		= 0x0C,		/* uint8_t	*/
+	MAP_AP_TRANSPARENT		= 0x0D,		/* uint8_t	*/
+	MAP_AP_RETRY			= 0x0E,		/* uint8_t	*/
+	MAP_AP_NEWMESSAGE		= 0x0F,		/* uint8_t	*/
+	MAP_AP_NOTIFICATIONSTATUS	= 0x10,		/* uint8_t	*/
+	MAP_AP_MASINSTANCEID		= 0x11,		/* uint8_t	*/
+	MAP_AP_PARAMETERMASK		= 0x12,		/* uint32_t	*/
+	MAP_AP_FOLDERLISTINGSIZE	= 0x13,		/* uint16_t	*/
+	MAP_AP_MESSAGESLISTINGSIZE	= 0x14,		/* uint16_t	*/
+	MAP_AP_SUBJECTLENGTH		= 0x15,		/* uint8_t	*/
+	MAP_AP_CHARSET			= 0x16,		/* uint8_t	*/
+	MAP_AP_FRACTIONREQUEST		= 0x17,		/* uint8_t	*/
+	MAP_AP_FRACTIONDELIVER		= 0x18,		/* uint8_t	*/
+	MAP_AP_STATUSINDICATOR		= 0x19,		/* uint8_t	*/
+	MAP_AP_STATUSVALUE		= 0x1A,		/* uint8_t	*/
+	MAP_AP_MSETIME			= 0x1B,		/* char *	*/
 	MAP_AP_CONVERSATIONID		= 0x1C,		/* uint32_t     */
 };
-- 
2.7.4


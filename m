Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 6/8] MAP Tracker: Add support for pulling messages
Date: Fri,  2 Sep 2011 10:57:58 +0200
Message-Id: <1314953880-4663-6-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
References: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am                |    3 +-
 plugins/bmsg.c             |  322 ++++++++++++++++++++++++++++++++++++++++++++
 plugins/bmsg.h             |   86 ++++++++++++
 plugins/messages-tracker.c |  171 ++++++++++++++++++++++--
 4 files changed, 569 insertions(+), 13 deletions(-)
 create mode 100644 plugins/bmsg.c
 create mode 100644 plugins/bmsg.h

diff --git a/Makefile.am b/Makefile.am
index 374fa1d..9cf3d02 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -66,7 +66,8 @@ builtin_sources += plugins/pbap.c plugins/phonebook.h \
 			plugins/vcard.h plugins/vcard.c
 
 builtin_modules += mas
-builtin_sources += plugins/mas.c plugins/messages.h
+builtin_sources += plugins/mas.c plugins/messages.h \
+			   plugins/bmsg.h plugins/bmsg.c
 
 builtin_modules += irmc
 builtin_sources += plugins/irmc.c
diff --git a/plugins/bmsg.c b/plugins/bmsg.c
new file mode 100644
index 0000000..b843ff3
--- /dev/null
+++ b/plugins/bmsg.c
@@ -0,0 +1,322 @@
+/*
+ *  bMessage (MAP) format helpers
+ *
+ *  Copyright (C) 2010, 2011  Bartosz Szatkowski <bulislaw@linux.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "bmsg.h"
+
+static GString *parse_vcard(struct bmsg_vcard *vcard)
+{
+	GString *buf;
+
+	if (vcard == NULL)
+		return NULL;
+
+	if (vcard->version == NULL)
+		return NULL;
+
+	if (vcard->n == NULL)
+		return NULL;
+
+	buf = g_string_new("");
+
+	g_string_append_printf(buf, "BEGIN:VCARD\r\n");
+	g_string_append_printf(buf, "VERSION:%s\r\n", vcard->version);
+
+	if (vcard->n != NULL)
+		g_string_append_printf(buf, "N:%s\r\n", vcard->n);
+
+	if (vcard->fn != NULL)
+		g_string_append_printf(buf, "FN:%s\r\n", vcard->fn);
+
+	if (vcard->tel != NULL)
+		g_string_append_printf(buf, "TEL:%s\r\n", vcard->tel);
+
+	if (vcard->email != NULL)
+		g_string_append_printf(buf, "EMAIL:%s\r\n", vcard->email);
+
+	g_string_append_printf(buf, "END:VCARD\r\n");
+
+	return buf;
+}
+
+static void free_glist_vcard(void *item, void *user_data)
+{
+	struct bmsg_vcard *tmp = item;
+
+	if (tmp == NULL)
+		return;
+
+	g_free(tmp->version);
+	g_free(tmp->n);
+	g_free(tmp->fn);
+	g_free(tmp->tel);
+	g_free(tmp->email);
+	g_free(item);
+}
+
+static void string_append_glist_vcard(void *list_item, void *list)
+{
+	GString *buf = list;
+	GString *item = parse_vcard(list_item);
+
+	g_string_append(buf, item->str);
+
+	g_string_free(item, TRUE);
+}
+
+static void envelope_destroy(struct bmsg_envelope *env)
+{
+	if (env->recipients) {
+		g_list_foreach(env->recipients, free_glist_vcard, NULL);
+		g_list_free(env->recipients);
+	}
+
+	if (env->content == NULL)
+		return;
+
+	g_free(env->content->encoding);
+	g_free(env->content->charset);
+	g_free(env->content->lang);
+	g_free(env->content->content);
+	g_free(env->content);
+}
+
+void bmsg_init(struct bmsg *msg, const char *version, const char *status,
+		const char *type, const char *folder)
+{
+	msg->version = g_strdup(version);
+	msg->status = g_strdup(status);
+	msg->type = g_strdup(type);
+	msg->folder = g_strdup(folder);
+	msg->envelopes = g_array_sized_new(FALSE, TRUE,
+					sizeof(struct bmsg_envelope *),
+					MAX_ENVELOPES_NUM);
+}
+
+void bmsg_destroy(struct bmsg *msg)
+{
+	unsigned i;
+
+	g_free(msg->version);
+	g_free(msg->status);
+	g_free(msg->type);
+	g_free(msg->folder);
+
+	if (msg->originators) {
+		g_list_foreach(msg->originators, free_glist_vcard, NULL);
+		g_list_free(msg->originators);
+	}
+
+	if (msg->envelopes == NULL)
+		return;
+
+	for (i = 0; i < msg->envelopes->len; i++) {
+		struct bmsg_envelope *tmp = g_array_index(msg->envelopes,
+						struct bmsg_envelope *, i);
+
+		envelope_destroy(tmp);
+		g_free(tmp);
+	}
+
+	g_array_free(msg->envelopes, TRUE);
+
+	g_free(msg);
+}
+
+static struct bmsg_vcard *make_vcard(const char *version, const char *name,
+					const char *fullname, const char *tel,
+					const char *email)
+{
+	struct bmsg_vcard *vcard = g_new0(struct bmsg_vcard, 1);
+
+	vcard->version = g_strdup(version);
+	vcard->n = g_strdup(name);
+	vcard->fn = g_strdup(fullname);
+	vcard->tel = g_strdup(tel);
+	vcard->email = g_strdup(email);
+
+	return vcard;
+}
+
+void bmsg_add_originator(struct bmsg *msg, const char *version,
+				 const char *name, const char *fullname,
+				 const char *tel, const char *email)
+{
+	struct bmsg_vcard *buf = make_vcard(version, name, fullname, tel,
+									email);
+	msg->originators = g_list_append(msg->originators, buf);
+}
+
+gboolean bmsg_add_envelope(struct bmsg *msg)
+{
+	struct bmsg_envelope *tmp;
+
+	if (msg->envelopes->len == MAX_ENVELOPES_NUM)
+		return FALSE;
+
+	if (msg->envelopes->len && g_array_index(msg->envelopes,
+				struct bmsg_envelope *,
+				msg->envelopes->len - 1)->content != NULL)
+		 return FALSE;
+
+	tmp = g_new0(struct bmsg_envelope, 1);
+
+	g_array_append_val(msg->envelopes, tmp);
+
+	return TRUE;
+}
+
+gboolean bmsg_add_content(struct bmsg *msg, gint32 part_id, char *encoding,
+			char *charset, char *lang, const char *content)
+{
+	struct bmsg_envelope *tmp;
+	struct bmsg_content *cont;
+
+	if (content == NULL)
+		return FALSE;
+
+	if (msg->envelopes->len == 0)
+		return FALSE;
+
+	tmp = g_array_index(msg->envelopes, struct bmsg_envelope *,
+						msg->envelopes->len - 1);
+
+	if (tmp->content != NULL)
+		return FALSE;
+
+	cont = g_new0(struct bmsg_content, 1);
+	cont->part_id = part_id;
+
+	if (encoding)
+		cont->encoding = g_strdup(encoding);
+
+	if (charset)
+		cont->charset = g_strdup(charset);
+
+	if (lang)
+		cont->lang = g_strdup(lang);
+
+	cont->content = g_strdup(content);
+
+	tmp->content = cont;
+
+	return TRUE;
+}
+
+static GString *parse_content(struct bmsg_content *cont)
+{
+	GString *buf = g_string_new("");
+
+	g_string_append_printf(buf, "BEGIN:BBODY\r\n");
+
+	if (cont->part_id != -1)
+		g_string_append_printf(buf, "PARTID:%d\r\n", cont->part_id);
+
+	if (cont->encoding != NULL)
+		g_string_append_printf(buf, "ENCODING:%s\r\n", cont->encoding);
+
+	if (cont->charset != NULL)
+		g_string_append_printf(buf, "CHARSET:%s\r\n", cont->charset);
+
+	if (cont->lang != NULL)
+		g_string_append_printf(buf, "LANGUAGE:%s\r\n", cont->lang);
+
+	if (cont->len > 0)
+		g_string_append_printf(buf, "LENGTH:%d\r\n", cont->len);
+	else
+		g_string_append_printf(buf, "LENGTH:%d\r\n",
+							strlen(cont->content) +
+							BMESSAGE_BASE_LEN);
+
+	g_string_append_printf(buf, "BEGIN:MSG\r\n%s\r\nEND:MSG\r\n",
+								cont->content);
+	g_string_append_printf(buf, "END:BBODY\r\n");
+
+	return buf;
+}
+
+static GString *parse_envelope(struct bmsg *msg, unsigned num)
+{
+	GString *buf;
+	struct bmsg_envelope *env;
+	GString *tmp;
+
+	if (num >= msg->envelopes->len)
+		return NULL;
+
+	buf = g_string_new("");
+
+	env = g_array_index(msg->envelopes, struct bmsg_envelope *, num);
+
+	g_string_append_printf(buf, "BEGIN:BENV\r\n");
+	g_list_foreach(env->recipients, string_append_glist_vcard, buf);
+
+	tmp = parse_envelope(msg, num + 1);
+	if (tmp == NULL) {
+		if (env->content == NULL) {
+			g_string_free(buf, TRUE);
+
+			return NULL;
+		}
+
+		tmp = parse_content(env->content);
+	}
+
+	g_string_append_printf(buf, "%s", tmp->str);
+	g_string_free(tmp, TRUE);
+
+	g_string_append_printf(buf, "END:BENV\r\n");
+
+	return buf;
+}
+
+char *bmsg_text(struct bmsg *msg)
+{
+	GString *buf = g_string_new("");
+	GString *env;
+	char *ret;
+
+	g_string_append_printf(buf, "BEGIN:BMSG\r\n");
+
+	g_string_append_printf(buf, "VERSION:%s\r\n", msg->version);
+	g_string_append_printf(buf, "STATUS:%s\r\n", msg->status);
+	g_string_append_printf(buf, "TYPE:%s\r\n", msg->type);
+	g_string_append_printf(buf, "FOLDER:%s\r\n", msg->folder);
+
+	g_list_foreach(msg->originators, string_append_glist_vcard, buf);
+
+	env = parse_envelope(msg, 0);
+	if (env == NULL) {
+		g_string_free(buf, TRUE);
+
+		return NULL;
+	}
+
+	g_string_append_printf(buf, "%s", env->str);
+	g_string_free(env, TRUE);
+
+	g_string_append_printf(buf, "END:BMSG\r\n");
+
+	ret = g_strdup(buf->str);
+	g_string_free(buf, TRUE);
+
+	return ret;
+}
diff --git a/plugins/bmsg.h b/plugins/bmsg.h
new file mode 100644
index 0000000..9aba380
--- /dev/null
+++ b/plugins/bmsg.h
@@ -0,0 +1,86 @@
+/*
+ *  bMessage (MAP) format helpers
+ *
+ *  Copyright (C) 2010, 2011  Bartosz Szatkowski <bulislaw@linux.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdio.h>
+#include <glib.h>
+#include <string.h>
+
+#define MAX_ENVELOPES_NUM 3
+
+#define BMSG_VERSION_1_0 "1.0"
+
+#define BMSG_READ "READ"
+#define BMSG_UNREAD "UNREAD"
+
+#define BMSG_EMAIL "EMAIL"
+#define BMSG_SMS "SMS_GSM"
+#define BMSG_CDMA "SMS_CDMA"
+#define BMSG_MMS "MMS"
+
+/*
+ * As stated in MAP errata bmessage-body-content-length-property should be
+ * length of: "BEGIN:MSG<CRLF>" + <message content> + "END:MSG<CRLF>"
+ */
+#define BMESSAGE_BASE_LEN (9 + 2 + 2 + 7 + 2)
+
+struct bmsg_vcard {
+	char *version;
+	char *n;
+	char *fn;
+	char *tel;
+	char *email;
+};
+
+struct bmsg_content {
+	gint32 part_id;
+	unsigned int len;
+	char *encoding;
+	char *charset;
+	char *lang;
+	char *content;
+};
+
+struct bmsg_envelope {
+	GList *recipients;
+	struct bmsg_content *content;
+};
+
+struct bmsg {
+	char *version;
+	char *status;
+	char *type;
+	char *folder;
+	GList *originators;
+	GArray *envelopes;
+};
+
+void bmsg_init(struct bmsg *msg, const char *version, const char *status,
+					const char *type, const char *folder);
+void bmsg_destroy(struct bmsg *msg);
+void bmsg_add_originator(struct bmsg *msg, const char *version,
+				const char *name, const char *fullname,
+				const char *tel, const char *email);
+gboolean bmsg_add_envelope(struct bmsg *msg);
+gboolean bmsg_add_content(struct bmsg *msg, gint32 part_id, char *encoding,
+			char *charset, char *lang, const char* content);
+struct bmsg * bmsg_parse(char *string);
+char * bmsg_text(struct bmsg *msg);
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 8624381..f00ab6d 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -32,6 +32,7 @@
 
 #include "log.h"
 #include "messages.h"
+#include "bmsg.h"
 
 #define TRACKER_SERVICE "org.freedesktop.Tracker1"
 #define TRACKER_RESOURCES_PATH "/org/freedesktop/Tracker1/Resources"
@@ -41,11 +42,9 @@
 #define MESSAGE_HANDLE_SIZE 16
 #define MESSAGE_HANDLE_PREFIX_LEN 8
 
-/*
- * As stated in MAP errata bmessage-body-content-length-property should be
- * length of: "BEGIN:MSG<CRLF>" + <message content> + "END:MSG<CRLF>"
- */
-#define BMESSAGE_BASE_LEN (9 + 2 + 2 + 7 + 2)
+#define SMS_DEFAULT_CHARSET "UTF-8"
+
+#define MESSAGES_FILTER_BY_HANDLE "FILTER (xsd:string(?msg) = \"message:%s\" ) ."
 
 #define MESSAGE_HANDLE 0
 #define MESSAGE_SUBJECT 1
@@ -127,9 +126,11 @@ struct session {
 	gboolean aborted;
 	reply_list_foreach_cb generate_response;
 	struct messages_filter *filter;
+	unsigned long flags;
 	union {
 		messages_folder_listing_cb folder_list;
 		messages_get_messages_listing_cb messages_list;
+		messages_get_message_cb message;
 	} cb;
 };
 
@@ -188,6 +189,26 @@ static struct messages_filter *copy_messages_filter(
 	return filter;
 }
 
+static char *fill_handle(const char *handle)
+{
+	int fill_size = MESSAGE_HANDLE_SIZE - strlen(handle);
+	char *fill = g_strnfill(fill_size, '0');
+	char *ret = g_strdup_printf("%s%s", fill, handle);
+
+	g_free(fill);
+
+	return ret;
+}
+
+static char *strip_handle(const char *handle)
+{
+	const char *ptr_new = handle;
+
+	while (*ptr_new++ == '0') ;
+
+	return g_strdup(ptr_new - 1);
+}
+
 static char **string_array_from_iter(DBusMessageIter iter, int array_len)
 {
 	DBusMessageIter sub;
@@ -258,7 +279,9 @@ static void query_reply(DBusPendingCall *call, void *user_data)
 
 		node = string_array_from_iter(element, QUERY_RESPONSE_SIZE);
 
-		session->generate_response((const char **) node, session);
+		if (node != NULL)
+			session->generate_response((const char **) node,
+								session);
 
 		g_free(node);
 
@@ -430,6 +453,39 @@ static char *merge_names(const char *name, const char *lastname)
 	return tmp;
 }
 
+static char *message2folder(const struct messages_message *data)
+{
+	if (data->sent == TRUE)
+		return g_strdup("telecom/msg/sent");
+
+	if (data->sent == FALSE)
+		return g_strdup("telecom/msg/inbox");
+
+	return NULL;
+}
+
+static char *path2query(const char *folder, const char *query,
+							const char *user_rule)
+{
+	if (g_str_has_suffix(folder, "telecom/msg/inbox") == TRUE)
+		return g_strdup_printf(query, "?msg nmo:isSent \"false\" ; "
+					"nmo:isDeleted \"false\" ; "
+					"nmo:isDraft \"false\". ", user_rule);
+
+	if (g_str_has_suffix(folder, "telecom/msg/sent") == TRUE)
+		return g_strdup_printf(query, "?msg nmo:isSent \"true\" ; "
+				"nmo:isDeleted \"false\" . ", user_rule);
+
+	if (g_str_has_suffix(folder, "telecom/msg/deleted") == TRUE)
+		return g_strdup_printf(query, "?msg nmo:isDeleted \"true\" . ",
+					user_rule);
+
+	if (g_str_has_suffix(folder, "telecom/msg") == TRUE)
+		return g_strdup_printf(query, "", user_rule);
+
+	return NULL;
+}
+
 static DBusConnection *dbus_get_connection(DBusBusType type)
 {
 	DBusError err;
@@ -646,6 +702,64 @@ done:
 	g_free(session->filter);
 }
 
+static void get_message_resp(const char **reply, void *s)
+{
+	struct session *session = s;
+	struct messages_message *msg_data;
+	struct bmsg *bmsg;
+	char *final_bmsg, *status, *folder, *handle;
+	int err;
+
+	DBG("reply %p", reply);
+
+	if (reply == NULL)
+		goto done;
+
+	if (session->aborted)
+		goto aborted;
+
+	msg_data = pull_message_data(reply);
+	handle = fill_handle(msg_data->handle);
+	g_free(msg_data->handle);
+	msg_data->handle = handle;
+
+	status = msg_data->read ? "READ" : "UNREAD";
+
+	folder = message2folder(msg_data);
+
+	bmsg = g_new0(struct bmsg, 1);
+	bmsg_init(bmsg, BMSG_VERSION_1_0, status, BMSG_SMS, folder);
+	bmsg_add_originator(bmsg, "2.1", reply[MESSAGE_FROM_LASTN],
+					msg_data->sender_name,
+					msg_data->sender_addressing, NULL);
+	bmsg_add_envelope(bmsg);
+	bmsg_add_content(bmsg, -1, NULL, SMS_DEFAULT_CHARSET, NULL,
+						reply[MESSAGE_CONTENT]);
+
+	final_bmsg = bmsg_text(bmsg);
+
+	session->cb.message(session, 0, FALSE, final_bmsg, session->user_data);
+
+	bmsg_destroy(bmsg);
+	g_free(folder);
+	g_free(final_bmsg);
+
+	session->count++;
+
+	return;
+
+done:
+	if (session->count == 0)
+		err = -ENOENT;
+	else
+		err = 0;
+
+	session->cb.message(session, err, FALSE, NULL, session->user_data);
+
+aborted:
+	g_free(session->name);
+}
+
 int messages_init(void)
 {
 	DBusError err;
@@ -870,13 +984,46 @@ int messages_get_messages_listing(void *s, const char *name,
 	return err;
 }
 
-int messages_get_message(void *session,
-		const char *handle,
-		unsigned long flags,
-		messages_get_message_cb callback,
-		void *user_data)
+int messages_get_message(void *s, const char *h, unsigned long flags,
+				messages_get_message_cb cb, void *user_data)
 {
-	return -EINVAL;
+	struct session *session = s;
+	DBusPendingCall *call;
+	int err = 0;
+	char *handle = strip_handle(h);
+	char *query_handle = g_strdup_printf(MESSAGES_FILTER_BY_HANDLE, handle);
+	char *query = path2query("telecom/msg", LIST_MESSAGES_QUERY,
+								 query_handle);
+
+	if (query == NULL) {
+		err = -ENOENT;
+
+		goto failed;
+	}
+
+	if (flags & MESSAGES_FRACTION || flags & MESSAGES_NEXT) {
+		err = -EBADR;
+
+		goto failed;
+	}
+
+	session->name = g_strdup(handle);
+	session->flags = flags;
+	session->cb.message = cb;
+	session->generate_response = get_message_resp;
+	session->user_data = user_data;
+	session->aborted = FALSE;
+
+	call = query_tracker(query, session, &err);
+	if (err == 0)
+		new_call(call);
+
+failed:
+	g_free(query_handle);
+	g_free(query);
+	g_free(handle);
+
+	return err;
 }
 
 void messages_abort(void *s)
-- 
1.7.4.1


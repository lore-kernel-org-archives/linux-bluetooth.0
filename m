Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 5/8] MAP Tracker Add filter support in messages listing
Date: Fri,  2 Sep 2011 10:57:57 +0200
Message-Id: <1314953880-4663-5-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
References: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |  102 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 96a180e..8624381 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -126,6 +126,7 @@ struct session {
 	gboolean new_message;
 	gboolean aborted;
 	reply_list_foreach_cb generate_response;
+	struct messages_filter *filter;
 	union {
 		messages_folder_listing_cb folder_list;
 		messages_get_messages_listing_cb messages_list;
@@ -171,6 +172,22 @@ static void free_msg_data(struct messages_message *msg)
 	g_free(msg);
 }
 
+static struct messages_filter *copy_messages_filter(
+					const struct messages_filter *orig)
+{
+	struct messages_filter *filter = g_new0(struct messages_filter, 1);
+	filter->parameter_mask = orig->parameter_mask;
+	filter->type = orig->type;
+	filter->period_begin = g_strdup(orig->period_begin);
+	filter->period_end = g_strdup(orig->period_end);
+	filter->read_status = orig->read_status;
+	filter->recipient = g_strdup(orig->recipient);
+	filter->originator = g_strdup(orig->originator);
+	filter->priority = orig->priority;
+
+	return filter;
+}
+
 static char **string_array_from_iter(DBusMessageIter iter, int array_len)
 {
 	DBusMessageIter sub;
@@ -433,6 +450,81 @@ static DBusConnection *dbus_get_connection(DBusBusType type)
 	return tmp;
 }
 
+static gboolean filter_message(struct messages_message *message,
+						struct messages_filter *filter)
+{
+	if (filter->type != 0) {
+		if (g_strcmp0(message->type, "SMS_GSM") == 0 &&
+				(filter->type & 0x01))
+			return FALSE;
+
+		if (g_strcmp0(message->type, "SMS_CDMA") == 0 &&
+				(filter->type & 0x02))
+			return FALSE;
+
+		if (g_strcmp0(message->type, "SMS_EMAIL") == 0 &&
+				(filter->type & 0x04))
+			return FALSE;
+
+		if (g_strcmp0(message->type, "SMS_MMS") == 0 &&
+				(filter->type & 0x08))
+			return FALSE;
+	}
+
+	if (filter->read_status != 0) {
+		if (filter->read_status == 0x01 && message->read != FALSE)
+			return FALSE;
+
+		if (filter->read_status == 0x02 && message->read != TRUE)
+			return FALSE;
+	}
+
+	if (filter->priority != 0) {
+		if (filter->priority == 0x01 && message->priority == FALSE)
+			return FALSE;
+
+		if (filter->priority == 0x02 && message->priority == TRUE)
+			return FALSE;
+	}
+
+	if (filter->period_begin != NULL &&
+			g_strcmp0(filter->period_begin, message->datetime) > 0)
+		return FALSE;
+
+	if (filter->period_end != NULL &&
+			g_strcmp0(filter->period_end, message->datetime) < 0)
+		return FALSE;
+
+	if (filter->originator != NULL) {
+		char *orig = g_strdup_printf("*%s*", filter->originator);
+
+		if (g_pattern_match_simple(orig,
+					message->sender_addressing) == FALSE &&
+				g_pattern_match_simple(orig,
+					message->sender_name) == FALSE) {
+			g_free(orig);
+			return FALSE;
+		}
+		g_free(orig);
+	}
+
+	if (filter->recipient != NULL) {
+		char *recip = g_strdup_printf("*%s*", filter->recipient);
+
+		if (g_pattern_match_simple(recip,
+					message->recipient_addressing) == FALSE
+				&& g_pattern_match_simple(recip,
+					message->recipient_name) == FALSE) {
+			g_free(recip);
+			return FALSE;
+		}
+
+		g_free(recip);
+	}
+
+	return TRUE;
+}
+
 static struct messages_message *pull_message_data(const char **reply)
 {
 	struct messages_message *data = g_new0(struct messages_message, 1);
@@ -533,7 +625,8 @@ static void get_messages_listing_resp(const char **reply, void *user_data)
 		return;
 	}
 
-	if (session->size > session->offset)
+	if (session->size > session->offset &&
+				filter_message(msg_data, session->filter))
 		session->cb.messages_list(session, -EAGAIN, 1,
 						session->new_message, msg_data,
 						session->user_data);
@@ -545,6 +638,12 @@ done:
 	session->cb.messages_list(session, 0, session->size,
 						session->new_message, NULL,
 						session->user_data);
+
+	g_free(session->filter->period_begin);
+	g_free(session->filter->period_end);
+	g_free(session->filter->originator);
+	g_free(session->filter->recipient);
+	g_free(session->filter);
 }
 
 int messages_init(void)
@@ -745,6 +844,7 @@ int messages_get_messages_listing(void *s, const char *name,
 	if (query == NULL)
 		return -ENOENT;
 
+	session->filter = copy_messages_filter(filter);
 	session->generate_response = get_messages_listing_resp;
 	session->cb.messages_list = callback;
 	session->offset = offset;
-- 
1.7.4.1


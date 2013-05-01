Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 03/16] obexd: Get rid of gint
Date: Wed,  1 May 2013 02:11:58 -0300
Message-Id: <1367385131-24034-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367385131-24034-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int, so it's safe to use it even for callbacks with glib.
---
 obexd/client/ftp.c             |  2 +-
 obexd/client/map.c             | 10 +++++-----
 obexd/client/mns.c             |  2 +-
 obexd/client/pbap.c            |  6 +++---
 obexd/client/session.c         |  4 ++--
 obexd/client/transfer.c        |  2 +-
 obexd/plugins/messages-dummy.c |  2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index a4cf3fc..fa85708 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -106,7 +106,7 @@ static void xml_element(GMarkupParseContext *ctxt,
 {
 	DBusMessageIter dict, *iter = user_data;
 	char *key;
-	gint i;
+	int i;
 
 	if (strcasecmp("folder", element) != 0 && strcasecmp("file", element) != 0)
 		return;
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 2e09030..0285286 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -184,7 +184,7 @@ static void folder_element(GMarkupParseContext *ctxt, const char *element,
 {
 	DBusMessageIter dict, *iter = user_data;
 	const char *key;
-	gint i;
+	int i;
 
 	if (strcasecmp("folder", element) != 0)
 		return;
@@ -976,7 +976,7 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
 	DBusMessageIter entry, dict, *iter = parser->iter;
 	struct map_msg *msg;
 	const char *key;
-	gint i;
+	int i;
 
 	if (strcasecmp("msg", element) != 0)
 		return;
@@ -1411,10 +1411,10 @@ static DBusMessage *map_list_messages(DBusConnection *connection,
 	return get_message_listing(map, message, folder, apparam);
 }
 
-static char **get_filter_strs(uint64_t filter, gint *size)
+static char **get_filter_strs(uint64_t filter, int *size)
 {
 	char **list, **item;
-	gint i;
+	int i;
 
 	list = g_malloc0(sizeof(char **) * (FILTER_BIT_MAX + 2));
 
@@ -1433,7 +1433,7 @@ static DBusMessage *map_list_filter_fields(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	char **filters = NULL;
-	gint size;
+	int size;
 	DBusMessage *reply;
 
 	filters = get_filter_strs(FILTER_ALL, &size);
diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 9a86462..8095b9e 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -220,7 +220,7 @@ static void event_report_element(GMarkupParseContext *ctxt,
 {
 	struct map_event *event = user_data;
 	const char *key;
-	gint i;
+	int i;
 
 	if (strcasecmp("event", element) != 0)
 		return;
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 25cc17c..2089860 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -876,10 +876,10 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 	return pull_phonebook(pbap, message, GETPHONEBOOKSIZE, NULL, apparam);
 }
 
-static char **get_filter_strs(uint64_t filter, gint *size)
+static char **get_filter_strs(uint64_t filter, int *size)
 {
 	char **list, **item;
-	gint i;
+	int i;
 
 	list = g_malloc0(sizeof(char **) * (FILTER_BIT_MAX + 2));
 
@@ -902,7 +902,7 @@ static DBusMessage *pbap_list_filter_fields(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	char **filters = NULL;
-	gint size;
+	int size;
 	DBusMessage *reply;
 
 	filters = get_filter_strs(FILTER_ALL, &size);
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 32c847c..0fbfe41 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -83,7 +83,7 @@ struct setpath_data {
 
 struct obc_session {
 	guint id;
-	gint refcount;
+	int refcount;
 	char *source;
 	char *destination;
 	uint8_t channel;
@@ -721,7 +721,7 @@ static void session_process_queue(struct obc_session *session)
 	obc_session_unref(session);
 }
 
-static gint pending_transfer_cmptransfer(gconstpointer a, gconstpointer b)
+static int pending_transfer_cmptransfer(gconstpointer a, gconstpointer b)
 {
 	const struct pending_request *p = a;
 	const struct obc_transfer *transfer = b;
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 427eab7..4b1def3 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -536,7 +536,7 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 	struct obc_transfer *transfer = user_data;
 
 	if (transfer->fd > 0) {
-		gint w;
+		int w;
 
 		w = write(transfer->fd, buf, len);
 		if (w < 0)
diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 4c66f51..bb0627f 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -57,7 +57,7 @@ struct folder_listing_data {
  * seem to follow the fig. 3-2 from MAP specification v1.0, and I've seen a
  * test suite requiring folder listing to be in that order.
  */
-static gint folder_names_cmp(gconstpointer a, gconstpointer b,
+static int folder_names_cmp(gconstpointer a, gconstpointer b,
 						gpointer user_data)
 {
 	static const char *order[] = {
-- 
1.8.2.2


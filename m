Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/6] Add update phonebook_pull
Date: Wed, 24 Nov 2010 17:07:13 +0200
Message-Id: <1290611236-25656-4-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1290611236-25656-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1290611236-25656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook request pointer to pending call in PBAP object.

Phonebook_pull function prototype is updated to return void
pointer to backend specific request and error code. All backend
handlers updated accordingly (phonebook-tracker.c,
phonebook-dummy.c, and phonebook-ebook.c).

Phonebook request is stored only for tracker. It is canceled
when PBAP object is destroyed, or IRMC close method invoked.

query_tracker is updated to return pending call request.

IRMC is updated to handle pending request when phonebook is pulled.

phonebook-dummy.c and phonebook-ebook.c are updated also with
phonebook_req_cancel function.
---
 plugins/irmc.c              |   14 +++++++-------
 plugins/pbap.c              |   20 +++++++++++++++-----
 plugins/phonebook-dummy.c   |   21 ++++++++++++++++-----
 plugins/phonebook-ebook.c   |   13 ++++++++++---
 plugins/phonebook-tracker.c |   34 ++++++++++++++++++++++------------
 plugins/phonebook.h         |    4 ++--
 6 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index f7ad33b..4c11933 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -110,6 +110,7 @@ struct irmc_session {
 	char did[DID_LEN];
 	char manu[DID_LEN];
 	char model[DID_LEN];
+	void *request;
 };
 
 #define IRMC_TARGET_SIZE 9
@@ -210,11 +211,8 @@ static void *irmc_connect(struct obex_session *os, int *err)
 	param->maxlistcount = 0; /* to count the number of vcards... */
 	param->filter = 0x200085; /* UID TEL N VERSION */
 	irmc->params = param;
-	phonebook_pull("telecom/pb.vcf", irmc->params, phonebook_size_result,
-									irmc);
-
-	if (err)
-		*err = 0;
+	irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
+					phonebook_size_result, irmc, err);
 
 	return irmc;
 }
@@ -298,8 +296,8 @@ static void *irmc_open_pb(const char *name, struct irmc_session *irmc,
 
 	if (!g_strcmp0(name, ".vcf")) {
 		/* how can we tell if the vcard count call already finished? */
-		ret = phonebook_pull("telecom/pb.vcf", irmc->params,
-							query_result, irmc);
+		irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
+						query_result, irmc, &ret);
 		if (ret < 0) {
 			DBG("phonebook_pull failed...");
 			goto fail;
@@ -435,6 +433,8 @@ static int irmc_close(void *object)
 		irmc->buffer = NULL;
 	}
 
+	phonebook_req_cancel(irmc->request);
+
 	return 0;
 }
 
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 1a7d001..0ceaf95 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -147,6 +147,7 @@ struct pbap_session {
 struct pbap_object {
 	GString *buffer;
 	struct pbap_session *session;
+	void *request;
 };
 
 static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
@@ -697,13 +698,15 @@ static struct obex_service_driver pbap = {
 	.chkput = pbap_chkput
 };
 
-static struct pbap_object *vobject_create(struct pbap_session *pbap)
+static struct pbap_object *vobject_create(struct pbap_session *pbap,
+								void *request)
 {
 	struct pbap_object *obj;
 
 	obj = g_new0(struct pbap_object, 1);
 	obj->session = pbap;
 	pbap->obj = obj;
+	obj->request = request;
 
 	return obj;
 }
@@ -714,6 +717,7 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 	struct pbap_session *pbap = context;
 	phonebook_cb cb;
 	int ret;
+	void *request = NULL;
 
 	DBG("name %s context %p maxlistcount %d", name, context,
 						pbap->params->maxlistcount);
@@ -733,11 +737,15 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 	else
 		cb = query_result;
 
-	ret = phonebook_pull(name, pbap->params, cb, pbap);
+	request = phonebook_pull(name, pbap->params, cb, pbap, &ret);
+
 	if (ret < 0)
 		goto fail;
 
-	return vobject_create(pbap);
+	if (err)
+		*err = ret;
+
+	return vobject_create(pbap, request);
 
 fail:
 	if (err)
@@ -787,7 +795,7 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 
 done:
-	return vobject_create(pbap);
+	return vobject_create(pbap, NULL);
 
 fail:
 	if (err)
@@ -836,7 +844,7 @@ done:
 	if (ret < 0)
 		goto fail;
 
-	return vobject_create(pbap);
+	return vobject_create(pbap, NULL);
 
 fail:
 	if (err)
@@ -912,6 +920,8 @@ static int vobject_close(void *object)
 	if (obj->buffer)
 		g_string_free(obj->buffer, TRUE);
 
+	phonebook_req_cancel(obj->request);
+
 	g_free(obj);
 
 	return 0;
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index 7c549fa..d9a5a29 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -447,8 +447,12 @@ done:
 	return relative;
 }
 
-int phonebook_pull(const char *name, const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void phonebook_req_cancel(void *request)
+{
+}
+
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct dummy_data *dummy;
 	char *filename, *folder;
@@ -463,14 +467,18 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 
 	if (!g_str_has_suffix(filename, ".vcf")) {
 		g_free(filename);
-		return -EBADR;
+		if (err)
+			*err = -EBADR;
+		return NULL;
 	}
 
 	folder = g_strndup(filename, strlen(filename) - 4);
 	g_free(filename);
 	if (!is_dir(folder)) {
 		g_free(folder);
-		return -ENOENT;
+		if (err)
+			*err = -ENOENT;
+		return NULL;
 	}
 
 	dummy = g_new0(struct dummy_data, 1);
@@ -482,7 +490,10 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 
 	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_dir, dummy, dummy_free);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return NULL;
 }
 
 int phonebook_get_entry(const char *folder, const char *id,
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 073ff33..9097a0b 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -408,8 +408,12 @@ done:
 	return fullname;
 }
 
-int phonebook_pull(const char *name, const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void phonebook_req_cancel(void *request)
+{
+}
+
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct contacts_query *data;
 	EBookQuery *query;
@@ -425,7 +429,10 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 
 	e_book_query_unref(query);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return NULL;
 }
 
 int phonebook_get_entry(const char *folder, const char *id,
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 5fd0074..c8c8e54 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1198,8 +1198,8 @@ done:
 	g_free(pending);
 }
 
-static int query_tracker(const char *query, int num_fields,
-				reply_list_foreach_t callback, void *user_data)
+static DBusPendingCall *query_tracker(const char *query, int num_fields,
+		reply_list_foreach_t callback, void *user_data,	int *err)
 {
 	struct pending_reply *pending;
 	DBusPendingCall *call;
@@ -1219,7 +1219,9 @@ static int query_tracker(const char *query, int num_fields,
 							-1) == FALSE) {
 		error("Could not send dbus message");
 		dbus_message_unref(msg);
-		return -EPERM;
+		if (err)
+			*err = -EPERM;
+		return NULL;
 	}
 
 	pending = g_new0(struct pending_reply, 1);
@@ -1228,10 +1230,12 @@ static int query_tracker(const char *query, int num_fields,
 	pending->num_fields = num_fields;
 
 	dbus_pending_call_set_notify(call, query_reply, pending, NULL);
-	dbus_pending_call_unref(call);
 	dbus_message_unref(msg);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return call;
 }
 
 static char *iso8601_utc_to_localtime(const char *datetime)
@@ -1810,8 +1814,8 @@ void phonebook_req_cancel(void *request)
 	dbus_pending_call_unref(call);
 }
 
-int phonebook_pull(const char *name, const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct phonebook_data *data;
 	const char *query;
@@ -1830,15 +1834,18 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 		pull_cb = pull_contacts;
 	}
 
-	if (query == NULL)
-		return -ENOENT;
+	if (query == NULL) {
+		if (err)
+			*err = -ENOENT;
+		return NULL;
+	}
 
 	data = g_new0(struct phonebook_data, 1);
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
 
-	return query_tracker(query, col_amount, pull_cb, data);
+	return query_tracker(query, col_amount, pull_cb, data, err);
 }
 
 int phonebook_get_entry(const char *folder, const char *id,
@@ -1865,7 +1872,7 @@ int phonebook_get_entry(const char *folder, const char *id,
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
 
-	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
+	query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data, &ret);
 
 	g_free(query);
 
@@ -1877,6 +1884,7 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 {
 	struct cache_data *cache;
 	const char *query;
+	int ret;
 
 	DBG("name %s", name);
 
@@ -1889,5 +1897,7 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	cache->ready_cb = ready_cb;
 	cache->user_data = user_data;
 
-	return query_tracker(query, 7, add_to_cache, cache);
+	query_tracker(query, 7, add_to_cache, cache, &ret);
+
+	return ret;
 }
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index 7ae5ccc..951b370 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -86,8 +86,8 @@ char *phonebook_set_folder(const char *current_folder,
  * entries of a given folder. The back-end MUST return only the content based
  * on the application parameters requested by the client.
  */
-int phonebook_pull(const char *name, const struct apparam_field *params,
-					phonebook_cb cb, void *user_data);
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err);
 
 /*
  * Function used to retrieve a contact from the backend. Only contacts
-- 
1.7.0.4


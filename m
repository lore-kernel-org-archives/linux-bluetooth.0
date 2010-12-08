Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/3 v3] Add handing of backend pending request
Date: Wed,  8 Dec 2010 23:15:55 +0200
Message-Id: <1291842956-8610-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1291842956-8610-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1291842956-8610-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add phonebook_req_cancel function prototype in phonebook.h to cancel
pending request if it is not completed, and to unref pointer to pending
request if such is applicable.

It does the following, depending on phonebook backend:
- for phonebook-tracker.c backend driver, it cancels pending DBus call,
- for phonebook-dummy.c, it removes GSource with a given id,
- for phonebook-ebook.c, it cancels last, still running, asynchronous
operation.

The following modifcations are donein the code. Phonebook request
pointer is added in PBAP object and IRMC session data to provide
reference for pending call. Phonebook callbacks are updated in PBAP
and IRMC to unref request upon completion and clear pointers, if such
is applicable.

PBAP and IRMC are updated to cancel pending request, if any, when OBEX
object is closed.

Phonebook_pull, phonebook_get_entry, phonebook_create_cache functions
are updated to return void pointer to backend specific request and error
code. All backend drivers updated accordingly to the modified API, which
are phonebook-tracker.c, phonebook-dummy.c, and phonebook-ebook.c, to be
specific.

In phonebook-tracker.c, query_tracker is updated to return pending DBus
call request. Allocated pending_reply and phonebook_data are destroyed
after call is unrefed. For this purpose new query_free_data function is
created.

Call is unrefed either if request succeeded or in phonebook_req_cancel
if terminated.

Such fix prevents obexd crash on unexpected OBEX session close. E.g.,
OBEX session is closed before reply comes from phonebook backend. In
that case, both session and object are destroyed, and dereferencing of
object in associated callback function causes crash.
---
 plugins/irmc.c              |   27 ++++++++---
 plugins/pbap.c              |   69 ++++++++++++++++++++------
 plugins/phonebook-dummy.c   |   70 +++++++++++++++++++--------
 plugins/phonebook-ebook.c   |   95 +++++++++++++++++++++++++++++-------
 plugins/phonebook-tracker.c |  113 ++++++++++++++++++++++++++++++++----------
 plugins/phonebook.h         |   17 ++++--
 6 files changed, 296 insertions(+), 95 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index f7ad33b..ede5554 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -110,6 +110,7 @@ struct irmc_session {
 	char did[DID_LEN];
 	char manu[DID_LEN];
 	char model[DID_LEN];
+	void *request;
 };
 
 #define IRMC_TARGET_SIZE 9
@@ -139,6 +140,11 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	DBG("vcards %d", vcards);
 
 	irmc->params->maxlistcount = vcards;
+
+	if (irmc->request) {
+		phonebook_req_cancel(irmc->request);
+		irmc->request = NULL;
+	}
 }
 
 static void query_result(const char *buffer, size_t bufsize, int vcards,
@@ -149,6 +155,11 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 
 	DBG("bufsize %zu vcards %d missed %d", bufsize, vcards, missed);
 
+	if (irmc->request) {
+		phonebook_req_cancel(irmc->request);
+		irmc->request = NULL;
+	}
+
 	/* first add a 'owner' vcard */
 	if (!irmc->buffer)
 		irmc->buffer = g_string_new(owner_vcard);
@@ -210,11 +221,8 @@ static void *irmc_connect(struct obex_session *os, int *err)
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
@@ -298,8 +306,8 @@ static void *irmc_open_pb(const char *name, struct irmc_session *irmc,
 
 	if (!g_strcmp0(name, ".vcf")) {
 		/* how can we tell if the vcard count call already finished? */
-		ret = phonebook_pull("telecom/pb.vcf", irmc->params,
-							query_result, irmc);
+		irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
+						query_result, irmc, &ret);
 		if (ret < 0) {
 			DBG("phonebook_pull failed...");
 			goto fail;
@@ -435,6 +443,11 @@ static int irmc_close(void *object)
 		irmc->buffer = NULL;
 	}
 
+	if (irmc->request) {
+		phonebook_req_cancel(irmc->request);
+		irmc->request = NULL;
+	}
+
 	return 0;
 }
 
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 4086227..a8e1ec6 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -147,6 +147,7 @@ struct pbap_session {
 struct pbap_object {
 	GString *buffer;
 	struct pbap_session *session;
+	void *request;
 };
 
 static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
@@ -231,6 +232,11 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	struct aparam_header *hdr = (struct aparam_header *) aparam;
 	uint16_t phonebooksize;
 
+	if (pbap->obj->request) {
+		phonebook_req_cancel(pbap->obj->request);
+		pbap->obj->request = NULL;
+	}
+
 	if (vcards < 0)
 		vcards = 0;
 
@@ -254,6 +260,11 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 
 	DBG("");
 
+	if (pbap->obj->request) {
+		phonebook_req_cancel(pbap->obj->request);
+		pbap->obj->request = NULL;
+	}
+
 	if (vcards <= 0) {
 		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
 		return;
@@ -466,8 +477,11 @@ static void cache_entry_done(void *user_data)
 		return;
 	}
 
-	ret = phonebook_get_entry(pbap->folder, id, pbap->params,
-						query_result, pbap);
+	/* Unref previous request, associated data will be freed. */
+	phonebook_req_cancel(pbap->obj->request);
+	/* Get new pointer to pending call. */
+	pbap->obj->request = phonebook_get_entry(pbap->folder, id,
+				pbap->params, query_result, pbap, &ret);
 	if (ret < 0)
 		obex_object_set_io_flags(pbap->obj, G_IO_ERR, ret);
 }
@@ -709,13 +723,15 @@ static struct obex_service_driver pbap = {
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
@@ -726,6 +742,7 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 	struct pbap_session *pbap = context;
 	phonebook_cb cb;
 	int ret;
+	void *request;
 
 	DBG("name %s context %p maxlistcount %d", name, context,
 						pbap->params->maxlistcount);
@@ -745,11 +762,15 @@ static void *vobject_pull_open(const char *name, int oflag, mode_t mode,
 	else
 		cb = query_result;
 
-	ret = phonebook_pull(name, pbap->params, cb, pbap);
+	request = phonebook_pull(name, pbap->params, cb, pbap, &ret);
+
 	if (ret < 0)
 		goto fail;
 
-	return vobject_create(pbap);
+	if (err)
+		*err = 0;
+
+	return vobject_create(pbap, request);
 
 fail:
 	if (err)
@@ -770,6 +791,11 @@ static int vobject_close(void *object)
 	if (obj->buffer)
 		g_string_free(obj->buffer, TRUE);
 
+	if (obj->request) {
+		phonebook_req_cancel(obj->request);
+		obj->request = NULL;
+	}
+
 	g_free(obj);
 
 	return 0;
@@ -781,6 +807,7 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 	struct pbap_session *pbap = context;
 	struct pbap_object *obj = NULL;
 	int ret;
+	void *request;
 
 	DBG("name %s context %p valid %d", name, context, pbap->cache.valid);
 
@@ -796,13 +823,19 @@ static void *vobject_list_open(const char *name, int oflag, mode_t mode,
 
 	/* PullvCardListing always get the contacts from the cache */
 
-	obj = vobject_create(pbap);
-
-	if (pbap->cache.valid)
+	if (pbap->cache.valid) {
+		obj = vobject_create(pbap, NULL);
 		ret = generate_response(pbap);
-	else
-		ret = phonebook_create_cache(name, cache_entry_notify,
-						cache_ready_notify, pbap);
+	} else {
+		request = phonebook_create_cache(name, cache_entry_notify,
+					cache_ready_notify, pbap, &ret);
+		/*
+		 * This is not to do memory allocation since if request
+		 * fails, then memory is freed when object is closed below.
+		 */
+		if (ret == 0)
+			obj = vobject_create(pbap, request);
+	}
 	if (ret < 0)
 		goto fail;
 
@@ -828,6 +861,7 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 	const char *id;
 	uint32_t handle;
 	int ret;
+	void *request;
 
 	DBG("name %s context %p valid %d", name, context, pbap->cache.valid);
 
@@ -843,8 +877,8 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 
 	if (pbap->cache.valid == FALSE) {
 		pbap->find_handle = handle;
-		ret = phonebook_create_cache(pbap->folder, cache_entry_notify,
-						cache_entry_done, pbap);
+		request = phonebook_create_cache(pbap->folder,
+			cache_entry_notify, cache_entry_done, pbap, &ret);
 		goto done;
 	}
 
@@ -854,14 +888,17 @@ static void *vobject_vcard_open(const char *name, int oflag, mode_t mode,
 		goto fail;
 	}
 
-	ret = phonebook_get_entry(pbap->folder, id, pbap->params, query_result,
-									pbap);
+	request = phonebook_get_entry(pbap->folder, id, pbap->params,
+						query_result, pbap, &ret);
 
 done:
 	if (ret < 0)
 		goto fail;
 
-	return vobject_create(pbap);
+	if (err)
+		*err = 0;
+
+	return vobject_create(pbap, request);
 
 fail:
 	if (err)
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index 7c549fa..efb1430 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -447,11 +447,19 @@ done:
 	return relative;
 }
 
-int phonebook_pull(const char *name, const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void phonebook_req_cancel(void *request)
+{
+	guint id = GPOINTER_TO_INT(request);
+
+	g_source_remove(id);
+}
+
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct dummy_data *dummy;
 	char *filename, *folder;
+	guint ret;
 
 	/*
 	 * Main phonebook objects will be created dinamically based on the
@@ -463,14 +471,18 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 
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
@@ -480,26 +492,32 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 	dummy->folder = folder;
 	dummy->fd = -1;
 
-	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_dir, dummy, dummy_free);
+	ret = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_dir, dummy,
+								dummy_free);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return GINT_TO_POINTER(ret);
 }
 
-int phonebook_get_entry(const char *folder, const char *id,
-					const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void *phonebook_get_entry(const char *folder, const char *id,
+			const struct apparam_field *params, phonebook_cb cb,
+			void *user_data, int *err)
 {
 	struct dummy_data *dummy;
 	char *filename;
 	int fd;
+	guint ret;
 
 	filename = g_build_filename(root_folder, folder, id, NULL);
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0) {
-		int err = errno;
-		DBG("open(): %s(%d)", strerror(err), err);
-		return -ENOENT;
+		DBG("open(): %s(%d)", strerror(errno), errno);
+		if (err)
+			*err = -ENOENT;
+		return NULL;
 	}
 
 	dummy = g_new0(struct dummy_data, 1);
@@ -508,26 +526,32 @@ int phonebook_get_entry(const char *folder, const char *id,
 	dummy->apparams = params;
 	dummy->fd = fd;
 
-	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_entry, dummy, dummy_free);
+	ret = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_entry, dummy,
+								dummy_free);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return GINT_TO_POINTER(ret);
 }
 
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-		phonebook_cache_ready_cb ready_cb, void *user_data)
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
 	struct cache_query *query;
 	char *foldername;
 	DIR *dp;
+	guint ret;
 
 	foldername = g_build_filename(root_folder, name, NULL);
 	dp = opendir(foldername);
 	g_free(foldername);
 
 	if (dp == NULL) {
-		int err = errno;
-		DBG("opendir(): %s(%d)", strerror(err), err);
-		return -ENOENT;
+		DBG("opendir(): %s(%d)", strerror(errno), errno);
+		if (err)
+			*err = -ENOENT;
+		return NULL;
 	}
 
 	query = g_new0(struct cache_query, 1);
@@ -536,7 +560,11 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	query->user_data = user_data;
 	query->dp = dp;
 
-	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache, query,
+	ret = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache, query,
 								query_free);
-	return 0;
+
+	if (err)
+		*err = 0;
+
+	return GINT_TO_POINTER(ret);
 }
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index b9d297a..c079de7 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -46,6 +46,7 @@
 #define QUERY_PHONE "(contains \"phone\" \"%s\")"
 
 struct context_query {
+	gboolean completed;
 	const struct apparam_field *params;
 	phonebook_cb contacts_cb;
 	phonebook_entry_cb entry_cb;
@@ -142,6 +143,11 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 	unsigned int count = 0, maxcount;
 	GList *l;
 
+	if (estatus == E_BOOK_ERROR_CANCELLED) {
+		error("E-Book operation was cancelled: status %d", estatus);
+		goto fail;
+	}
+
 	if (estatus != E_BOOK_ERROR_OK) {
 		error("E-Book query failed: status %d", estatus);
 		goto done;
@@ -178,10 +184,14 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 
 
 done:
+	data->completed = TRUE;
 	data->contacts_cb(string->str, string->len, count, 0, data->user_data);
 
+fail:
 	g_string_free(string, TRUE);
-	g_free(data);
+
+	if (data->completed)
+		g_free(data);
 }
 
 static void ebook_entry_cb(EBook *book, EBookStatus estatus,
@@ -192,11 +202,17 @@ static void ebook_entry_cb(EBook *book, EBookStatus estatus,
 	char *vcard;
 	size_t len;
 
+	if (estatus == E_BOOK_ERROR_CANCELLED) {
+		error("E-Book operation was cancelled: status %d", estatus);
+		goto fail;
+	}
+
+	data->completed = TRUE;
+
 	if (estatus != E_BOOK_ERROR_OK) {
 		error("E-Book query failed: status %d", estatus);
 		data->contacts_cb(NULL, 0, 1, 0, data->user_data);
-		g_free(data);
-		return;
+		goto fail;
 	}
 
 	evcard = E_VCARD(contact);
@@ -209,7 +225,10 @@ static void ebook_entry_cb(EBook *book, EBookStatus estatus,
 	data->contacts_cb(vcard, len, 1, 0, data->user_data);
 
 	g_free(vcard);
-	g_free(data);
+
+fail:
+	if (data->completed)
+		g_free(data);
 }
 
 static char *evcard_name_attribute_to_string(EVCard *evcard)
@@ -248,6 +267,13 @@ static void cache_cb(EBook *book, EBookStatus estatus, GList *contacts,
 	struct context_query *data = user_data;
 	GList *l;
 
+	if (estatus == E_BOOK_ERROR_CANCELLED) {
+		error("E-Book operation was cancelled: status %d", estatus);
+		goto fail;
+	}
+
+	data->completed = TRUE;
+
 	if (estatus != E_BOOK_ERROR_OK) {
 		error("E-Book query failed: status %d", estatus);
 		goto done;
@@ -285,6 +311,10 @@ static void cache_cb(EBook *book, EBookStatus estatus, GList *contacts,
 	}
 done:
 	data->ready_cb(data->user_data);
+
+fail:
+	if (data->completed)
+		g_free(data);
 }
 
 int phonebook_init(void)
@@ -404,8 +434,21 @@ done:
 	return fullname;
 }
 
-int phonebook_pull(const char *name, const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void phonebook_req_cancel(void *request)
+{
+	struct context_query *data = request;
+
+	if (!data)
+		return;
+
+	if (!data->completed) {
+		data->completed = TRUE;
+		e_book_cancel_async_op(ebook, NULL);
+	}
+}
+
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct context_query *data;
 	EBookQuery *query;
@@ -421,12 +464,15 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 
 	e_book_query_unref(query);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return data;
 }
 
-int phonebook_get_entry(const char *folder, const char *id,
-					const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void *phonebook_get_entry(const char *folder, const char *id,
+				const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct context_query *data;
 
@@ -437,21 +483,29 @@ int phonebook_get_entry(const char *folder, const char *id,
 
 	if (e_book_async_get_contact(ebook, id, ebook_entry_cb, data)) {
 		g_free(data);
-		return -ENOENT;
+		if (err)
+			*err = -ENOENT;
+		return NULL;
 	}
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return data;
 }
 
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-			phonebook_cache_ready_cb ready_cb, void *user_data)
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
 	struct context_query *data;
 	EBookQuery *query;
 	gboolean ret;
 
-	if (g_strcmp0("/telecom/pb", name) != 0)
-		return -ENOENT;
+	if (g_strcmp0("/telecom/pb", name) != 0) {
+		if (err)
+			*err = -ENOENT;
+		return NULL;
+	}
 
 	query = e_book_query_any_field_contains("");
 
@@ -464,8 +518,13 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	e_book_query_unref(query);
 	if (ret != FALSE) {
 		g_free(data);
-		return -EFAULT;
+		if (err)
+			*err = -EFAULT;
+		return NULL;
 	}
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return data;
 }
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index cdc1008..92299a0 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -807,6 +807,7 @@ struct pending_reply {
 	reply_list_foreach_t callback;
 	void *user_data;
 	int num_fields;
+	GDestroyNotify destroy;
 };
 
 struct contact_data {
@@ -996,11 +997,30 @@ done:
 	pending->callback(NULL, err, pending->user_data);
 
 	dbus_message_unref(reply);
+
+	/*
+	 * pending data is freed in query_free_data after call is unreffed.
+	 * Same holds for pending->user_data which is not freed in callback
+	 * but in query_free_data.
+	 */
+}
+
+static void query_free_data(void *user_data)
+{
+	struct pending_reply *pending = user_data;
+
+	if (!pending)
+		return;
+
+	if (pending->destroy)
+		pending->destroy(pending->user_data);
+
 	g_free(pending);
 }
 
-static int query_tracker(const char *query, int num_fields,
-				reply_list_foreach_t callback, void *user_data)
+static DBusPendingCall *query_tracker(const char *query, int num_fields,
+				reply_list_foreach_t callback, void *user_data,
+				GDestroyNotify destroy, int *err)
 {
 	struct pending_reply *pending;
 	DBusPendingCall *call;
@@ -1020,19 +1040,27 @@ static int query_tracker(const char *query, int num_fields,
 							-1) == FALSE) {
 		error("Could not send dbus message");
 		dbus_message_unref(msg);
-		return -EPERM;
+		if (err)
+			*err = -EPERM;
+		/* user_data is freed otherwise only if call was sent */
+		g_free(user_data);
+		return NULL;
 	}
 
 	pending = g_new0(struct pending_reply, 1);
 	pending->callback = callback;
 	pending->user_data = user_data;
 	pending->num_fields = num_fields;
+	pending->destroy = destroy;
 
-	dbus_pending_call_set_notify(call, query_reply, pending, NULL);
-	dbus_pending_call_unref(call);
+	dbus_pending_call_set_notify(call, query_reply, pending,
+							query_free_data);
 	dbus_message_unref(msg);
 
-	return 0;
+	if (err)
+		*err = 0;
+
+	return call;
 }
 
 static char *iso8601_utc_to_localtime(const char *datetime)
@@ -1245,7 +1273,7 @@ static void pull_contacts_size(char **reply, int num_fields, void *user_data)
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, data->user_data);
-		goto fail;
+		return;
 	}
 
 	if (reply != NULL) {
@@ -1255,8 +1283,11 @@ static void pull_contacts_size(char **reply, int num_fields, void *user_data)
 
 	data->cb(NULL, 0, data->index, 0, data->user_data);
 
-fail:
-	g_free(data);
+	/*
+	 * phonebook_data is freed in query_free_data after call is unreffed.
+	 * It is accessible by pointer from data (pending) associated to call.
+	 * Useful in cases when call was terminated.
+	 */
 }
 
 static void add_affiliation(char **field, const char *value)
@@ -1482,9 +1513,14 @@ done:
 	g_string_free(vcards, TRUE);
 fail:
 	g_slist_free(data->contacts);
-	g_free(data);
 	g_free(temp_id);
 	temp_id = NULL;
+
+	/*
+	 * phonebook_data is freed in query_free_data after call is unreffed.
+	 * It is accessible by pointer from data (pending) associated to call.
+	 * Useful in cases when call was terminated.
+	 */
 }
 
 static void add_to_cache(char **reply, int num_fields, void *user_data)
@@ -1529,7 +1565,11 @@ done:
 	if (num_fields <= 0)
 		cache->ready_cb(cache->user_data);
 
-	g_free(cache);
+	/*
+	 * cache is freed in query_free_data after call is unreffed.
+	 * It is accessible by pointer from data (pending) associated to call.
+	 * Useful in cases when call was terminated.
+	 */
 }
 
 int phonebook_init(void)
@@ -1617,8 +1657,20 @@ done:
 	return path;
 }
 
-int phonebook_pull(const char *name, const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void phonebook_req_cancel(void *request)
+{
+	struct DBusPendingCall *call = request;
+
+	DBG("");
+
+	if (!dbus_pending_call_get_completed(call))
+		dbus_pending_call_cancel(call);
+
+	dbus_pending_call_unref(call);
+}
+
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct phonebook_data *data;
 	const char *query;
@@ -1637,24 +1689,27 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
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
+	return query_tracker(query, col_amount, pull_cb, data, g_free, err);
 }
 
-int phonebook_get_entry(const char *folder, const char *id,
-					const struct apparam_field *params,
-					phonebook_cb cb, void *user_data)
+void *phonebook_get_entry(const char *folder, const char *id,
+				const struct apparam_field *params,
+				phonebook_cb cb, void *user_data, int *err)
 {
 	struct phonebook_data *data;
 	char *query;
-	int ret;
+	DBusPendingCall *call;
 
 	DBG("folder %s id %s", folder, id);
 
@@ -1672,15 +1727,16 @@ int phonebook_get_entry(const char *folder, const char *id,
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
 
-	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
+	call = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts,
+							data, g_free, err);
 
 	g_free(query);
 
-	return ret;
+	return call;
 }
 
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-			phonebook_cache_ready_cb ready_cb, void *user_data)
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
 	struct cache_data *cache;
 	const char *query;
@@ -1688,13 +1744,16 @@ int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	DBG("name %s", name);
 
 	query = folder2query(name);
-	if (query == NULL)
-		return -ENOENT;
+	if (query == NULL) {
+		if (err)
+			*err = -ENOENT;
+		return NULL;
+	}
 
 	cache = g_new0(struct cache_data, 1);
 	cache->entry_cb = entry_cb;
 	cache->ready_cb = ready_cb;
 	cache->user_data = user_data;
 
-	return query_tracker(query, 7, add_to_cache, cache);
+	return query_tracker(query, 7, add_to_cache, cache, g_free, err);
 }
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index d7cfa46..687feb8 100644
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
@@ -95,9 +95,9 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
  * return only the content based on the application parameters requested
  * by the client.
  */
-int phonebook_get_entry(const char *folder, const char *id,
+void *phonebook_get_entry(const char *folder, const char *id,
 				const struct apparam_field *params,
-				phonebook_cb cb, void *user_data);
+				phonebook_cb cb, void *user_data, int *err);
 
 /*
  * PBAP core will keep the contacts cache per folder. SetPhoneBook or
@@ -105,5 +105,10 @@ int phonebook_get_entry(const char *folder, const char *id,
  * Cache will store only the necessary information required to reply to
  * PullvCardListing request and verify if a given contact belongs to the source.
  */
-int phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-			phonebook_cache_ready_cb ready_cb, void *user_data);
+void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
+		phonebook_cache_ready_cb ready_cb, void *user_data, int *err);
+
+/*
+ * Cancels pending call to phonebook backend.
+ */
+void phonebook_req_cancel(void *request);
-- 
1.7.0.4


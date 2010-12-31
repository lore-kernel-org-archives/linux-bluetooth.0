Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 3/4] New NewMissedCalls added for phonebook_pull.
Date: Fri, 31 Dec 2010 09:45:01 +0200
Message-Id: <1293781502-2709-4-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1293781502-2709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

NewMissedCalls is added to MCH phone book pull function for tracker
back-end (see PBAP specification pp.25,41). A new query is added to
phonebook-tracker.c result of which is at most 40 sorted by time and
date phone numbers from missed calls history with read/not read flags.

New missed calls are acquired from the list locally. This query always
submitted first to have data for the first OBEX packet (see PBAP
specification p.33).

Canceling of pending DBus call was changed to conform introduced
modifications. More specifically, phonebook_pull, phonebook_get_entry,
phonebook_create_cache functions return pointer to phonebook_data
structure that holds DBus pending call instead of pointer to the call.

phonebook_data memory deallocation is moved to finalize function. This
data is not freed after each query since two successive queries may be
carried out and this structure holds pointer to the corresponding requests.

pbap.c and obex.c are updated to add NewMissedCalls application parameter
to first response OBEX packet. It is done only in the case when number of
new missed calls is larger than 0. Therefore, other than tracker phone
book back-ends are not affected.

mimetype.h, filesystem.c, irmc.c, nokia-backup.c, syncevolution.c are
updated to return flag parameter. OBEX_FL_FIT_ONE_PACKET flag is set only
for PBAP if number of new missed calls larger than 0 when pulling
phone book.
---
 plugins/filesystem.c        |   16 ++++-
 plugins/irmc.c              |    6 ++-
 plugins/nokia-backup.c      |    6 ++-
 plugins/pbap.c              |   52 ++++++++++++--
 plugins/phonebook-tracker.c |  168 +++++++++++++++++++++++++++++++++++--------
 plugins/syncevolution.c     |    6 ++-
 src/mimetype.h              |    3 +-
 src/obex.c                  |   11 ++--
 8 files changed, 219 insertions(+), 49 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index b4ff556..7bfe673 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -210,7 +210,7 @@ static int filesystem_close(void *object)
 }
 
 static ssize_t filesystem_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+					uint8_t *hi, unsigned int *flags)
 {
 	ssize_t ret;
 
@@ -218,6 +218,9 @@ static ssize_t filesystem_read(void *object, void *buf, size_t count,
 	if (ret < 0)
 		return -errno;
 
+	if (flags)
+		*flags = 0;
+
 	*hi = OBEX_HDR_BODY;
 
 	return ret;
@@ -499,17 +502,24 @@ ssize_t string_read(void *object, void *buf, size_t count)
 	return len;
 }
 
-static ssize_t folder_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t folder_read(void *object, void *buf, size_t count,
+					uint8_t *hi, unsigned int *flags)
 {
+	if (flags)
+		*flags = 0;
+
 	*hi = OBEX_HDR_BODY;
 	return string_read(object, buf, count);
 }
 
 static ssize_t capability_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+					uint8_t *hi, unsigned int *flags)
 {
 	struct capability_object *obj = object;
 
+	if (flags)
+		*flags = 0;
+
 	*hi = OBEX_HDR_BODY;
 
 	if (obj->buffer)
diff --git a/plugins/irmc.c b/plugins/irmc.c
index a281341..0488cae 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -451,7 +451,8 @@ static int irmc_close(void *object)
 	return 0;
 }
 
-static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi,
+							unsigned int *flags)
 {
 	struct irmc_session *irmc = object;
 	int len;
@@ -460,6 +461,9 @@ static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi)
 	if (!irmc->buffer)
                 return -EAGAIN;
 
+	if (flags)
+		*flags = 0;
+
 	*hi = OBEX_HDR_BODY;
 	len = string_read(irmc->buffer, buf, count);
 	DBG("returning %d bytes", len);
diff --git a/plugins/nokia-backup.c b/plugins/nokia-backup.c
index 6ae4082..4a69d8f 100644
--- a/plugins/nokia-backup.c
+++ b/plugins/nokia-backup.c
@@ -222,13 +222,17 @@ static int backup_close(void *object)
 	return 0;
 }
 
-static ssize_t backup_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t backup_read(void *object, void *buf, size_t count,
+					uint8_t *hi, unsigned int *flags)
 {
 	struct backup_object *obj = object;
 	ssize_t ret = 0;
 
 	*hi = OBEX_HDR_BODY;
 
+	if (flags)
+		*flags = 0;
+
 	if (obj->pending_call) {
 		DBG("cmd = %s, IN WAITING STAGE", obj->cmd);
 		return -EAGAIN;
diff --git a/plugins/pbap.c b/plugins/pbap.c
index c0093de..aa3e4dd 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -147,6 +147,7 @@ struct pbap_session {
 struct pbap_object {
 	GString *buffer;
 	GByteArray *aparams;
+	gboolean firstpacket;
 	struct pbap_session *session;
 	void *request;
 };
@@ -238,6 +239,15 @@ static GByteArray *append_aparam_header(GByteArray *buf, uint8_t tag,
 		memcpy(hdr->val, val, PHONEBOOKSIZE_LEN);
 
 		return g_byte_array_append(buf,	aparam,	sizeof(aparam));
+	} else if (tag == NEWMISSEDCALLS_TAG) {
+		uint8_t aparam[sizeof(struct aparam_header) + sizeof(uint8_t)];
+		struct aparam_header *hdr = (struct aparam_header *) aparam;
+
+		hdr->tag = NEWMISSEDCALLS_TAG;
+		hdr->len = NEWMISSEDCALLS_LEN;
+		hdr->val[0] = *val;
+
+		return g_byte_array_append(buf,	aparam,	sizeof(aparam));
 	}
 
 	return buf;
@@ -265,6 +275,13 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
 			PHONEBOOKSIZE_TAG, (uint8_t*) &phonebooksize);
 
+	if (missed > 0)	{
+		DBG("missed %d", missed);
+
+		pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
+				NEWMISSEDCALLS_TAG, (uint8_t*) &missed);
+	}
+
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
@@ -291,6 +308,16 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 		pbap->obj->buffer = g_string_append_len(pbap->obj->buffer,
 							buffer,	bufsize);
 
+	if (missed > 0)	{
+		DBG("missed %d", missed);
+
+		pbap->obj->firstpacket = TRUE;
+
+		pbap->obj->aparams = g_byte_array_new();
+		pbap->obj->aparams = append_aparam_header(pbap->obj->aparams,
+				NEWMISSEDCALLS_TAG, (uint8_t*) &missed);
+	}
+
 	obex_object_set_io_flags(pbap->obj, G_IO_IN, 0);
 }
 
@@ -487,9 +514,7 @@ static void cache_entry_done(void *user_data)
 		return;
 	}
 
-	/* Unref previous request, associated data will be freed. */
 	phonebook_req_finalize(pbap->obj->request);
-	/* Get new pointer to pending call. */
 	pbap->obj->request = phonebook_get_entry(pbap->folder, id,
 				pbap->params, query_result, pbap, &ret);
 	if (ret < 0)
@@ -931,7 +956,7 @@ ssize_t array_read(GByteArray *array, void *buf, size_t count)
 }
 
 static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+					uint8_t *hi, unsigned int *flags)
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
@@ -945,16 +970,27 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 	if (pbap->params->maxlistcount == 0) {
 		/* PhoneBookSize */
 		*hi = OBEX_HDR_APPARAM;
+		if (flags)
+			*flags = 0;
+		return array_read(obj->aparams, buf, count);
+	} else if (obj->firstpacket) {
+		/* NewMissedCalls */
+		*hi = OBEX_HDR_APPARAM;
+		obj->firstpacket = FALSE;
+		if (flags)
+			*flags = OBEX_FL_FIT_ONE_PACKET;
 		return array_read(obj->aparams, buf, count);
 	} else {
 		/* Stream data */
 		*hi = OBEX_HDR_BODY;
+		if (flags)
+			*flags = 0;
 		return string_read(obj->buffer, buf, count);
 	}
 }
 
 static ssize_t vobject_list_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+					uint8_t *hi, unsigned int *flags)
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
@@ -966,6 +1002,9 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 	if (!pbap->cache.valid)
 		return -EAGAIN;
 
+	if (flags)
+		*flags = 0;
+
 	if (pbap->params->maxlistcount == 0) {
 		*hi = OBEX_HDR_APPARAM;
 		return array_read(obj->aparams, buf, count);
@@ -976,7 +1015,7 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 }
 
 static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+					uint8_t *hi, unsigned int *flags)
 {
 	struct pbap_object *obj = object;
 
@@ -985,6 +1024,9 @@ static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
 	if (!obj->buffer)
 		return -EAGAIN;
 
+	if (flags)
+		*flags = 0;
+
 	*hi = OBEX_HDR_BODY;
 	return string_read(obj->buffer, buf, count);
 }
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index cc4b49f..a6a2e47 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -919,6 +919,41 @@
 	"}"								\
 	"}"
 
+#define NEW_MISSED_CALLS_LIST						\
+	"SELECT ?c "							\
+	"nco:phoneNumber(?h) "						\
+	"nmo:isRead(?call) "						\
+	"WHERE { "							\
+	"{"								\
+		"?c a nco:Contact . "					\
+		"?c nco:hasPhoneNumber ?h . "				\
+		"?call a nmo:Call ; "					\
+		"nmo:from ?c ; "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered false ."				\
+	"}UNION{"							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h . "				\
+		"?call a nmo:Call ; "					\
+		"nmo:from ?x ; "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered false ."				\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasPhoneNumber ?h . "				\
+	"} UNION { "							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h . "				\
+		"?call a nmo:Call ; "					\
+		"nmo:from ?x ; "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered false ."				\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasAffiliation ?a . "				\
+		"?a nco:hasPhoneNumber ?h . "				\
+	"} "								\
+	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call)) "	\
+	"LIMIT 40"
+
 typedef void (*reply_list_foreach_t) (char **reply, int num_fields,
 							void *user_data);
 
@@ -943,6 +978,8 @@ struct phonebook_data {
 	GSList *contacts;
 	phonebook_cache_ready_cb ready_cb;
 	phonebook_entry_cb entry_cb;
+	int newmissedcalls;
+	DBusPendingCall *call;
 };
 
 struct phonebook_index {
@@ -1111,11 +1148,7 @@ done:
 
 	dbus_message_unref(reply);
 
-	/*
-	 * pending data is freed in query_free_data after call is unreffed.
-	 * Same holds for pending->user_data which is not freed in callback
-	 * but in query_free_data.
-	 */
+	/* pending data is freed in query_free_data after call is unreffed. */
 }
 
 static void query_free_data(void *user_data)
@@ -1155,8 +1188,6 @@ static DBusPendingCall *query_tracker(const char *query, int num_fields,
 		dbus_message_unref(msg);
 		if (err)
 			*err = -EPERM;
-		/* user_data is freed otherwise only if call was sent */
-		g_free(user_data);
 		return NULL;
 	}
 
@@ -1394,12 +1425,11 @@ static void pull_contacts_size(char **reply, int num_fields, void *user_data)
 		return;
 	}
 
-	data->cb(NULL, 0, data->index, 0, data->user_data);
+	data->cb(NULL, 0, data->index, data->newmissedcalls, data->user_data);
 
 	/*
-	 * phonebook_data is freed in query_free_data after call is unreffed.
-	 * It is accessible by pointer from data (pending) associated to call.
-	 * Useful in cases when call was terminated.
+	 * phonebook_data is freed in phonebook_req_finalize. Useful in
+	 * cases when call is terminated.
 	 */
 }
 
@@ -1682,19 +1712,17 @@ done:
 
 	if (num_fields == 0)
 		data->cb(vcards->str, vcards->len,
-					g_slist_length(data->contacts), 0,
-					data->user_data);
+					g_slist_length(data->contacts),
+					data->newmissedcalls, data->user_data);
 
 	g_string_free(vcards, TRUE);
 fail:
-	g_slist_free(data->contacts);
 	g_free(temp_id);
 	temp_id = NULL;
 
 	/*
-	 * phonebook_data is freed in query_free_data after call is unreffed.
-	 * It is accessible by pointer from data (pending) associated to call.
-	 * Useful in cases when call was terminated.
+	 * phonebook_data is freed in phonebook_req_finalize. Useful in
+	 * cases when call is terminated.
 	 */
 }
 
@@ -1741,9 +1769,8 @@ done:
 		data->ready_cb(data->user_data);
 
 	/*
-	 * data is freed in query_free_data after call is unreffed.
-	 * It is accessible by pointer from data (pending) associated to call.
-	 * Useful in cases when call was terminated.
+	 * phonebook_data is freed in phonebook_req_finalize. Useful in
+	 * cases when call is terminated.
 	 */
 }
 
@@ -1834,14 +1861,87 @@ done:
 
 void phonebook_req_finalize(void *request)
 {
-	struct DBusPendingCall *call = request;
+	struct phonebook_data *data = request;
 
 	DBG("");
 
-	if (!dbus_pending_call_get_completed(call))
-		dbus_pending_call_cancel(call);
+	if (!data)
+		return;
+
+	if (!dbus_pending_call_get_completed(data->call))
+		dbus_pending_call_cancel(data->call);
 
-	dbus_pending_call_unref(call);
+	dbus_pending_call_unref(data->call);
+
+	g_slist_free(data->contacts);
+	g_free(data);
+}
+
+static gboolean find_checked_number(GSList *numbers, const char *number)
+{
+	GSList *l;
+
+	for (l = numbers; l; l = l->next) {
+		GString *ph_num = l->data;
+		if (g_strcmp0(ph_num->str, number) == 0)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+static void gstring_free_helper(gpointer data, gpointer user_data)
+{
+	g_string_free(data, TRUE);
+}
+
+static void pull_newmissedcalls(char **reply, int num_fields, void *user_data)
+{
+	struct phonebook_data *data = user_data;
+	reply_list_foreach_t pull_cb;
+	int col_amount, err;
+	const char *query;
+
+	if (num_fields < 0 || reply == NULL)
+		goto done;
+
+	if (!find_checked_number(data->contacts, reply[1])) {
+		if (g_strcmp0(reply[2], "false") == 0)
+			data->newmissedcalls++;
+		else {
+			GString *number = g_string_new(reply[1]);
+			data->contacts = g_slist_append(data->contacts,
+								number);
+		}
+	}
+	return;
+
+done:
+	DBG("newmissedcalls %d", data->newmissedcalls);
+	g_slist_foreach(data->contacts, gstring_free_helper, NULL);
+	g_slist_free(data->contacts);
+	data->contacts = NULL;
+
+	if (num_fields < 0) {
+		data->cb(NULL, 0, num_fields, 0, data->user_data);
+		return;
+	}
+
+	if (data->params->maxlistcount == 0) {
+		query = name2count_query("telecom/mch.vcf");
+		col_amount = COUNT_QUERY_COL_AMOUNT;
+		pull_cb = pull_contacts_size;
+	} else {
+		query = name2query("telecom/mch.vcf");
+		col_amount = PULL_QUERY_COL_AMOUNT;
+		pull_cb = pull_contacts;
+	}
+
+	dbus_pending_call_unref(data->call);
+	data->call = query_tracker(query, col_amount, pull_cb, data, NULL,
+								&err);
+	if (err < 0)
+		data->cb(NULL, 0, err, 0, data->user_data);
 }
 
 void *phonebook_pull(const char *name, const struct apparam_field *params,
@@ -1854,7 +1954,11 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 
 	DBG("name %s", name);
 
-	if (params->maxlistcount == 0) {
+	if (g_strcmp0(name, "telecom/mch.vcf") == 0) {
+		query = NEW_MISSED_CALLS_LIST;
+		col_amount = PULL_QUERY_COL_AMOUNT;
+		pull_cb = pull_newmissedcalls;
+	} else if (params->maxlistcount == 0) {
 		query = name2count_query(name);
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts_size;
@@ -1874,8 +1978,10 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
+	data->call = query_tracker(query, col_amount, pull_cb, data, NULL,
+									err);
 
-	return query_tracker(query, col_amount, pull_cb, data, g_free, err);
+	return data;
 }
 
 void *phonebook_get_entry(const char *folder, const char *id,
@@ -1884,7 +1990,6 @@ void *phonebook_get_entry(const char *folder, const char *id,
 {
 	struct phonebook_data *data;
 	char *query;
-	DBusPendingCall *call;
 
 	DBG("folder %s id %s", folder, id);
 
@@ -1902,12 +2007,12 @@ void *phonebook_get_entry(const char *folder, const char *id,
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
 
-	call = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts,
-							data, g_free, err);
+	data->call = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts,
+							data, NULL, err);
 
 	g_free(query);
 
-	return call;
+	return data;
 }
 
 void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
@@ -1929,6 +2034,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
+	data->call = query_tracker(query, 7, add_to_cache, data, NULL, err);
 
-	return query_tracker(query, 7, add_to_cache, data, g_free, err);
+	return data;
 }
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index 8041df6..a000b36 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -331,7 +331,8 @@ done:
 	return 0;
 }
 
-static ssize_t synce_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t synce_read(void *object, void *buf, size_t count,
+					uint8_t *hi, unsigned int *flags)
 {
 	struct synce_context *context = object;
 	DBusConnection *conn;
@@ -342,6 +343,9 @@ static ssize_t synce_read(void *object, void *buf, size_t count, uint8_t *hi)
 	gboolean authenticate;
 	DBusPendingCall *call;
 
+	if (flags)
+		*flags = 0;
+
 	if (context->buffer) {
 		*hi = OBEX_HDR_BODY;
 		return string_read(context->buffer, buf, count);
diff --git a/src/mimetype.h b/src/mimetype.h
index 200b950..ff16a8c 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -33,7 +33,8 @@ struct obex_mime_type_driver {
 	void *(*open) (const char *name, int oflag, mode_t mode,
 			void *driver_data, size_t *size, int *err);
 	int (*close) (void *object);
-	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi);
+	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi,
+							unsigned int *flags);
 	ssize_t (*write) (void *object, const void *buf, size_t count);
 	int (*remove) (const char *name);
 	int (*set_io_watch) (void *object, obex_object_io_func func,
diff --git a/src/obex.c b/src/obex.c
index e7d40dd..c36e4dc 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -634,16 +634,18 @@ static int obex_write_stream(struct obex_session *os,
 	if (os->aborted)
 		return -EPERM;
 
+	ptr = os->buf + os->offset;
+
 	if (os->object == NULL) {
 		if (os->buf == NULL && os->finished == FALSE)
 			return -EIO;
 
 		len = MIN(os->size - os->offset, os->tx_mtu);
-		ptr = os->buf + os->offset;
+		flags = 0;
 		goto add_header;
 	}
 
-	len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
+	len = os->driver->read(os->object, ptr, os->tx_mtu, &hi, &flags);
 	if (len < 0) {
 		error("read(): %s (%zd)", strerror(-len), -len);
 		if (len == -EAGAIN)
@@ -656,18 +658,15 @@ static int obex_write_stream(struct obex_session *os,
 		return len;
 	}
 
-	ptr = os->buf;
-
 add_header:
 
 	hd.bs = ptr;
 
 	switch (hi) {
 	case OBEX_HDR_BODY:
-		flags = len ? OBEX_FL_STREAM_DATA : OBEX_FL_STREAM_DATAEND;
+		flags |= len ? OBEX_FL_STREAM_DATA : OBEX_FL_STREAM_DATAEND;
 		break;
 	case OBEX_HDR_APPARAM:
-		flags =  0;
 		break;
 	default:
 		error("read(): unkown header type %u", hi);
-- 
1.7.0.4


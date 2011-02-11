Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 5/7 v2] Add support for notyfying pbap about more parts from backend
Date: Fri, 11 Feb 2011 16:05:37 +0200
Message-Id: <1297433139-10923-5-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added new parameter to phonebook_cb - lastpart variable.
If backend want to notify that more parts of current
request will be delivered later, it should use lastpart=FALSE.
Because of that, PBAP core will 'know' that should not finalize
request immediately after receiving data and wait for more
parts to come.
If result is returned in one part and no more responses part
will be sent later, then backend should use lastparam=TRUE.
Previously results of request from backend was always returned
in one part to PBAP core.
---
 plugins/irmc.c              |    5 +++--
 plugins/pbap.c              |   10 +++++++---
 plugins/phonebook-dummy.c   |    4 ++--
 plugins/phonebook-ebook.c   |    7 ++++---
 plugins/phonebook-tracker.c |   13 +++++++------
 plugins/phonebook.h         |    2 +-
 6 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 0488cae..e1e83f9 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -133,7 +133,8 @@ static const char *owner_vcard =
 		"END:VCARD\r\n";
 
 static void phonebook_size_result(const char *buffer, size_t bufsize,
-				int vcards, int missed, void *user_data)
+					int vcards, int missed,
+					gboolean lastpart, void *user_data)
 {
 	struct irmc_session *irmc = user_data;
 
@@ -148,7 +149,7 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 }
 
 static void query_result(const char *buffer, size_t bufsize, int vcards,
-					int missed, void *user_data)
+				int missed, gboolean lastpart, void *user_data)
 {
 	struct irmc_session *irmc = user_data;
 	const char *s, *t;
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 6579d09..5775eea 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -148,6 +148,7 @@ struct pbap_object {
 	GString *buffer;
 	GByteArray *aparams;
 	gboolean firstpacket;
+	gboolean lastpart;
 	struct pbap_session *session;
 	void *request;
 };
@@ -254,7 +255,8 @@ static GByteArray *append_aparam_header(GByteArray *buf, uint8_t tag,
 }
 
 static void phonebook_size_result(const char *buffer, size_t bufsize,
-				int vcards, int missed, void *user_data)
+					int vcards, int missed,
+					gboolean lastpart, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 	uint16_t phonebooksize;
@@ -286,17 +288,19 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 }
 
 static void query_result(const char *buffer, size_t bufsize, int vcards,
-					int missed, void *user_data)
+				int missed, gboolean lastpart, void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 
 	DBG("");
 
-	if (pbap->obj->request) {
+	if (pbap->obj->request && lastpart) {
 		phonebook_req_finalize(pbap->obj->request);
 		pbap->obj->request = NULL;
 	}
 
+	pbap->obj->lastpart = lastpart;
+
 	if (vcards <= 0) {
 		obex_object_set_io_flags(pbap->obj, G_IO_ERR, -ENOENT);
 		return;
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index 60b7640..76dd550 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -248,7 +248,7 @@ static gboolean read_dir(void *user_data)
 	closedir(dp);
 done:
 	/* FIXME: Missing vCards fields filtering */
-	dummy->cb(buffer->str, buffer->len, count, 0, dummy->user_data);
+	dummy->cb(buffer->str, buffer->len, count, 0, TRUE, dummy->user_data);
 
 	g_string_free(buffer, TRUE);
 
@@ -346,7 +346,7 @@ static gboolean read_entry(void *user_data)
 
 	/* FIXME: Missing vCards fields filtering */
 
-	dummy->cb(buffer, count, 1, 0, dummy->user_data);
+	dummy->cb(buffer, count, 1, 0, TRUE, dummy->user_data);
 
 	return FALSE;
 }
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 70b9c02..6cc4f31 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -186,7 +186,8 @@ static void ebookpull_cb(EBook *book, EBookStatus estatus, GList *contacts,
 
 done:
 	data->completed = TRUE;
-	data->contacts_cb(string->str, string->len, count, 0, data->user_data);
+	data->contacts_cb(string->str, string->len, count, 0, TRUE,
+							data->user_data);
 
 fail:
 	g_string_free(string, TRUE);
@@ -212,7 +213,7 @@ static void ebook_entry_cb(EBook *book, EBookStatus estatus,
 
 	if (estatus != E_BOOK_ERROR_OK) {
 		error("E-Book query failed: status %d", estatus);
-		data->contacts_cb(NULL, 0, 1, 0, data->user_data);
+		data->contacts_cb(NULL, 0, 1, 0, TRUE, data->user_data);
 		goto fail;
 	}
 
@@ -223,7 +224,7 @@ static void ebook_entry_cb(EBook *book, EBookStatus estatus,
 
 	len = vcard ? strlen(vcard) : 0;
 
-	data->contacts_cb(vcard, len, 1, 0, data->user_data);
+	data->contacts_cb(vcard, len, 1, 0, TRUE, data->user_data);
 
 	g_free(vcard);
 
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index afd738c..0762787 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1334,7 +1334,7 @@ static int pull_contacts_size(const char **reply, int num_fields,
 	struct phonebook_data *data = user_data;
 
 	if (num_fields < 0) {
-		data->cb(NULL, 0, num_fields, 0, data->user_data);
+		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
 		return -EINTR;
 	}
 
@@ -1343,7 +1343,8 @@ static int pull_contacts_size(const char **reply, int num_fields,
 		return 0;
 	}
 
-	data->cb(NULL, 0, data->index, data->newmissedcalls, data->user_data);
+	data->cb(NULL, 0, data->index, data->newmissedcalls, TRUE,
+							data->user_data);
 
 	return 0;
 	/*
@@ -1561,7 +1562,7 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 	static char *temp_id = NULL;
 
 	if (num_fields < 0) {
-		data->cb(NULL, 0, num_fields, 0, data->user_data);
+		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
 		goto fail;
 	}
 
@@ -1641,7 +1642,7 @@ done:
 	vcards = gen_vcards(data->contacts, params);
 
 	data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
-					data->newmissedcalls, data->user_data);
+				data->newmissedcalls, TRUE, data->user_data);
 
 	g_string_free(vcards, TRUE);
 fail:
@@ -1868,7 +1869,7 @@ done:
 	data->contacts = NULL;
 
 	if (num_fields < 0) {
-		data->cb(NULL, 0, num_fields, 0, data->user_data);
+		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
 		return -EINTR;
 	}
 
@@ -1884,7 +1885,7 @@ done:
 
 	err = query_tracker(query, col_amount, pull_cb, data);
 	if (err < 0) {
-		data->cb(NULL, 0, err, 0, data->user_data);
+		data->cb(NULL, 0, err, 0, TRUE, data->user_data);
 
 		return -EINTR;
 	}
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index bfbae0f..f6df164 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -50,7 +50,7 @@ struct apparam_field {
  * Contacts will be returned in the vcard format.
  */
 typedef void (*phonebook_cb) (const char *buffer, size_t bufsize,
-		int vcards, int missed, void *user_data);
+		int vcards, int missed, gboolean lastpart, void *user_data);
 
 /*
  * Interface between the PBAP core and backends to
-- 
1.7.0.4


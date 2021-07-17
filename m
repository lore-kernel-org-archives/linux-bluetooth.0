Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AF6C636C9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 12:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEBE613D9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhGQM6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhGQM6Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Jul 2021 08:58:24 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F04C061764
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 05:55:28 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4GRp4G3nnQzQjmP;
        Sat, 17 Jul 2021 14:55:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1626526526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VlVQCk/DbrNmONIxVAhykbdAlCP2s0iTIup8g7WTAZs=;
        b=j+3vfUByokE8yksXFejSXbp1yyArNoyC3U3+WQ0DxQioawuXSzSMAVwYBsC2CLbKflfmU/
        SVN82ZHwM0tzv7mukcxVIoy94tnDk1AtI/EgSwnRERfk6wYKoole3HqTzfcWMKPZWIulwr
        9xmRj1YjjCZRLJ65m6yMNgQsxiY6Lf6ouVv2S8K+HCo8p9CnaxWf0vY0rEBb8A+zFdxrfs
        zfcvyHcKluuUjD3/U7NFG/9PlUCITRIjYCnLMSPFicGjr23xUYz+zkPGtZ0cLa3ICR+8U9
        o7dAC1rrhl5Zu/j1Lkt4Kj0JBKcUuWFCUHr/yqBxI3lqrDzHXLvzUaz0sQp/8A==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id yAxS3q0ReomD; Sat, 17 Jul 2021 14:55:21 +0200 (CEST)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 1/4] obexd: phonebook-ebook: modernize
Date:   Sat, 17 Jul 2021 14:55:05 +0200
Message-Id: <20210717125508.29186-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0EF8D183A
X-Rspamd-UID: 50ca98
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Modernize PBAP phonebook-ebook plugin for newer libebook version
of the Evolution Data Server.

The ebook plugin was introduced during GSoC 2011 [1] and allows
BlueZ to share contacts stored in the Evolution Data Server to
connected clients such as car multimedia systems.
With the rise of Mobile Linux thanks to the PinePhone and Librem 5,
this plugin was modernized to compile with newer libebook versions
because the API was changed [2].

[1] http://www.bluez.org/gsoc-eds-backend-of-phonebook-access-profilepbap/
[2] https://wiki.gnome.org/Apps/Evolution/ESourceMigrationGuide

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 obexd/plugins/phonebook-ebook.c | 676 +++++++++++++++-----------------
 1 file changed, 327 insertions(+), 349 deletions(-)

diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index 30be9d921..491aef7ff 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -3,8 +3,9 @@
  *
  *  OBEX Server
  *
- *  Copyright (C) 2009-2010  Intel Corporation
- *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009-2021  Intel Corporation
+ *  Copyright (C) 2007-2021  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2021       Dylan Van Assche <me@dylanvanassche.be>
  *
  *
  */
@@ -13,35 +14,44 @@
 #include <config.h>
 #endif
 
-#include <string.h>
+#define _GNU_SOURCE
+#include <dirent.h>
 #include <errno.h>
-
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
 #include <glib.h>
-#include <libebook/e-book.h>
-
-#include "lib/bluetooth.h"
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <libebook/libebook.h>
+#include <libedataserver/libedataserver.h>
 
 #include "obexd/src/log.h"
-#include "obexd/src/obex.h"
-#include "obexd/src/service.h"
 #include "phonebook.h"
 
-#define QUERY_FN "(contains \"family_name\" \"%s\")"
-#define QUERY_NAME "(contains \"given_name\" \"%s\")"
-#define QUERY_PHONE "(contains \"phone\" \"%s\")"
+#define CONNECTION_TIMEOUT 30  // seconds
+#define PB_FORMAT_VCARD21	0
+#define PB_FORMAT_VCARD30	1
+#define PB_FORMAT_NONE		2
+
+ESourceRegistry *registry;
+ESource *address_book;
+EBookClient *book_client;
 
 struct query_context {
 	const struct apparam_field *params;
 	phonebook_cb contacts_cb;
 	phonebook_entry_cb entry_cb;
 	phonebook_cache_ready_cb ready_cb;
-	EBookQuery *query;
+	gchar *query;
 	unsigned int count;
 	GString *buf;
-	char *id;
+	char *uid;
 	unsigned queued_calls;
 	void *user_data;
-	GSList *ebooks;
 	gboolean canceled;
 };
 
@@ -76,39 +86,30 @@ static char *attribute_mask[] = {
 		"SORT-STRING",
 /* 28 */	"X-IRMC-CALL-DATETIME",
 		NULL
-
 };
 
-static void close_ebooks(GSList *ebooks)
-{
-	g_slist_free_full(ebooks, g_object_unref);
-}
-
 static void free_query_context(struct query_context *data)
 {
-	g_free(data->id);
+	g_free(data->uid);
 
 	if (data->buf != NULL)
 		g_string_free(data->buf, TRUE);
 
 	if (data->query != NULL)
-		e_book_query_unref(data->query);
-
-	close_ebooks(data->ebooks);
+		g_free(data->query);
 
 	g_free(data);
 }
 
 static char *evcard_to_string(EVCard *evcard, unsigned int format,
-							uint64_t filter)
+			      uint64_t filter)
 {
 	EVCard *evcard2;
 	GList *l;
 	char *vcard;
 
 	if (!filter)
-		return e_vcard_to_string(evcard, EVC_FORMAT_VCARD_30);
-		/* XXX There is no support for VCARD 2.1 at this time */
+		return e_vcard_to_string(evcard, format);
 
 	/*
 	 * Mandatory attributes for vCard 2.1 are VERSION ,N and TEL.
@@ -134,8 +135,7 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 			if (g_strcmp0(name, attribute_mask[i]) != 0)
 				continue;
 
-			e_vcard_add_attribute(evcard2,
-					e_vcard_attribute_copy(attrib));
+			e_vcard_add_attribute(evcard2, e_vcard_attribute_copy(attrib));
 		}
 	}
 
@@ -145,25 +145,151 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 	return vcard;
 }
 
-static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
-							void *user_data)
+char *phonebook_set_folder(const char *current_folder,
+			   const char *new_folder, uint8_t flags, int *err)
+{
+	gboolean root, child;
+	char *fullname = NULL, *tmp1, *tmp2, *base;
+	int ret = 0, len;
+
+	root = (g_strcmp0("/", current_folder) == 0);
+	child = (new_folder && strlen(new_folder) != 0);
+
+	/* Evolution back-end will support /telecom/pb folder only */
+	switch (flags) {
+	case 0x02:
+		/* Go back to root */
+		if (!child) {
+			fullname = g_strdup("/");
+			goto done;
+		}
+
+		/* Go down 1 level */
+		fullname = g_build_filename(current_folder, new_folder, NULL);
+		if (strcmp(PB_TELECOM_FOLDER, fullname) != 0 &&
+				strcmp(PB_CONTACTS_FOLDER, fullname) != 0) {
+			g_free(fullname);
+			fullname = NULL;
+			ret = -ENOENT;
+		}
+
+		break;
+	case 0x03:
+		/* Go up 1 level */
+		if (root) {
+			/* Already root */
+			ret = -EBADR;
+			goto done;
+		}
+
+		/*
+		 * Removing one level of the current folder. Current folder
+		 * contains AT LEAST one level since it is not at root folder.
+		 * Use glib utility functions to handle invalid chars in the
+		 * folder path properly.
+		 */
+		tmp1 = g_path_get_basename(current_folder);
+		tmp2 = g_strrstr(current_folder, tmp1);
+		len = tmp2 - (current_folder + 1);
+
+		g_free(tmp1);
+
+		if (len == 0)
+			base = g_strdup("/");
+		else
+			base = g_strndup(current_folder, len);
+
+		/* Return one level only */
+		if (!child) {
+			fullname = base;
+			goto done;
+		}
+
+		fullname = g_build_filename(base, new_folder, NULL);
+		if (strcmp(fullname, PB_TELECOM_FOLDER) != 0 &&
+				strcmp(fullname, PB_CONTACTS_FOLDER) != 0) {
+			g_free(fullname);
+			fullname = NULL;
+			ret = -ENOENT;
+		}
+
+		g_free(base);
+
+		break;
+	default:
+		ret = -EBADR;
+		break;
+	}
+
+done:
+	if (err)
+		*err = ret;
+
+	return fullname;
+}
+
+void phonebook_req_finalize(void *request)
+{
+	/* Free resources after pull request */
+	struct query_context *data = request;
+
+	if (data->queued_calls == 0)
+		free_query_context(data);
+	else
+		data->canceled = TRUE;
+}
+
+void *phonebook_pull(const char *name, const struct apparam_field *params,
+		     phonebook_cb cb, void *user_data, int *err)
+{
+	/* Prepare pull request, return the prepared request which is passed to phonebook_pull_read */
+	struct query_context *data;
+	EBookQuery *query;
+
+	/* Request should be for '/telecom/pb.vcf', reject others */
+	if (g_strcmp0(PB_CONTACTS, name) != 0) {
+		if (err)
+			*err = -ENOENT;
+		return NULL;
+	}
+
+	data = g_new0(struct query_context, 1);
+	data->contacts_cb = cb;
+	data->params = params;
+	data->user_data = user_data;
+	data->buf = g_string_new("");
+	query = e_book_query_any_field_contains("");  // all contacts
+	data->query = e_book_query_to_string(query);
+	e_book_query_unref(query);
+
+	return data;
+}
+
+static void phonebook_pull_read_ready (GObject *source_object,
+				       GAsyncResult *result,
+				       gpointer user_data)
 {
 	struct query_context *data = user_data;
-	GList *l;
+	GSList *l = NULL;
+	GSList *contacts = NULL;
+	GError *gerr = NULL;
 	unsigned int count, maxcount;
 
+	/* Finish async call to retrieve contacts */
 	data->queued_calls--;
 
 	if (data->canceled)
 		goto canceled;
 
+	e_book_client_get_contacts_finish (E_BOOK_CLIENT (source_object),
+					   result, &contacts, &gerr);
+
 	if (gerr != NULL) {
-		error("E-Book query failed: %s", gerr->message);
+		error("Failed to retrieve contacts, invalid query");
+		g_error_free(gerr);
 		goto done;
 	}
 
-	DBG("");
-
 	/*
 	 * When MaxListCount is zero, PCE wants to know the number of used
 	 * indexes in the phonebook of interest. All other parameters that
@@ -171,42 +297,46 @@ static void ebookpull_cb(EBook *book, const GError *gerr, GList *contacts,
 	 */
 	maxcount = data->params->maxlistcount;
 	if (maxcount == 0) {
-		data->count += g_list_length(contacts);
+		data->count += g_slist_length(contacts);
 		goto done;
 	}
 
-	l = g_list_nth(contacts, data->params->liststartoffset);
-
-	for (count = 0; l && count + data->count < maxcount; l = g_list_next(l),
-								count++) {
+	/*
+	* Convert each contact to a vCard and append the card to the buffer string.
+	*/
+	l = g_slist_nth(contacts, data->params->liststartoffset);
+	for (count = 0; l && count + data->count < maxcount; l = g_slist_next(l), count++) {
 		EContact *contact = E_CONTACT(l->data);
 		EVCard *evcard = E_VCARD(contact);
 		char *vcard;
 
-		vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_30,
-						data->params->filter);
+		if (data->params->format == PB_FORMAT_VCARD30)
+			vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_30,
+						 data->params->filter);
+		else if (data->params->format == PB_FORMAT_VCARD21)
+			vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_21,
+						 data->params->filter);
+		else
+			error("vCard format unknown: %d", data->params->format);
 
 		data->buf = g_string_append(data->buf, vcard);
 		data->buf = g_string_append(data->buf, "\r\n");
 		g_free(vcard);
 	}
 
-	DBG("collected %d vcards", count);
+	DBG("collected %d contacts", count);
 
 	data->count += count;
-
-	g_list_free_full(contacts, g_object_unref);
+	g_slist_free_full (contacts, (GDestroyNotify) g_object_unref);
 
 done:
 	if (data->queued_calls == 0) {
 		GString *buf = data->buf;
 		data->buf = NULL;
 
-		data->contacts_cb(buf->str, buf->len, data->count,
-						0, TRUE, data->user_data);
-
+		data->contacts_cb(buf->str, buf->len, data->count, 0,
+				  TRUE, data->user_data);
 		g_string_free(buf, TRUE);
-
 	}
 
 	return;
@@ -216,9 +346,34 @@ canceled:
 		free_query_context(data);
 }
 
-static void ebook_entry_cb(EBook *book, const GError *gerr,
-				EContact *contact, void *user_data)
+int phonebook_pull_read(void *request)
 {
+	/* Retrieve results from the backend, based on the request. Return 0 on success. */
+	struct query_context *data = request;
+	GError *gerr = NULL;
+
+	if (!data) {
+		error("Request data is empty");
+		return -ENOENT;
+	}
+
+	DBG("retrieving all contacts");
+
+	/* Fetch async contacts from default address book */
+	e_book_client_get_contacts(book_client, data->query, NULL,
+				   (GAsyncReadyCallback) phonebook_pull_read_ready,
+				   data);
+	data->queued_calls++;
+
+	return 0;
+}
+
+static void phonebook_get_entry_ready(GObject *source_object,
+				      GAsyncResult *result,
+				      gpointer user_data)
+{
+	GError *gerr = NULL;
+	EContact *contact = NULL;
 	struct query_context *data = user_data;
 	EVCard *evcard;
 	char *vcard;
@@ -226,20 +381,27 @@ static void ebook_entry_cb(EBook *book, const GError *gerr,
 
 	data->queued_calls--;
 
+	e_book_client_get_contact_finish(E_BOOK_CLIENT (source_object),
+					 result, &contact, &gerr);
 	if (data->canceled)
 		goto done;
 
 	if (gerr != NULL) {
-		error("E-Book query failed: %s", gerr->message);
+		error("Getting contact failed: %s", gerr->message);
+		g_error_free(gerr);
 		goto done;
 	}
 
-	DBG("");
-
 	evcard = E_VCARD(contact);
 
-	vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_30,
-					data->params->filter);
+	if (data->params->format == PB_FORMAT_VCARD30)
+		vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_30,
+					 data->params->filter);
+	else if (data->params->format == PB_FORMAT_VCARD21)
+		vcard = evcard_to_string(evcard, EVC_FORMAT_VCARD_21,
+					 data->params->filter);
+	else
+		error("Unknown vCard format: %d", data->params->format);
 
 	len = vcard ? strlen(vcard) : 0;
 
@@ -247,18 +409,47 @@ static void ebook_entry_cb(EBook *book, const GError *gerr,
 	data->contacts_cb(vcard, len, 1, 0, TRUE, data->user_data);
 
 	g_free(vcard);
-	g_object_unref(contact);
 
-	return;
+	DBG("retrieving entry successful");
 
 done:
 	if (data->queued_calls == 0) {
 		if (data->count == 0)
 			data->contacts_cb(NULL, 0, 1, 0, TRUE,
-						data->user_data);
+					  data->user_data);
 		else if (data->canceled)
 			free_query_context(data);
 	}
+
+	g_object_unref(contact);
+}
+
+void *phonebook_get_entry(const char *folder, const char *id,
+			  const struct apparam_field *params, phonebook_cb cb,
+			  void *user_data, int *err)
+{
+	/* Get a contact from the backend, contact must be in cache to succeed */
+	struct query_context *data;
+	GSList *l;
+
+	DBG("retrieving entry: %s", id);
+
+	data = g_new0(struct query_context, 1);
+	data->contacts_cb = cb;
+	data->params = params;
+	data->user_data = user_data;
+	data->uid = g_strdup(id);
+
+	/* Fetch async contacts from default address book */
+	e_book_client_get_contact(book_client, data->uid, NULL,
+				  (GAsyncReadyCallback) phonebook_get_entry_ready,
+				  data);
+	data->queued_calls++;
+
+	if (err)
+		*err = (data->queued_calls == 0 ? -ENOENT : 0);
+
+	return data;
 }
 
 static char *evcard_name_attribute_to_string(EVCard *evcard)
@@ -291,25 +482,29 @@ static char *evcard_name_attribute_to_string(EVCard *evcard)
 	return g_string_free(name, FALSE);
 }
 
-static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
-							void *user_data)
+static void phonebook_create_cache_ready(GObject *source_object,
+					 GAsyncResult *result,
+					 gpointer user_data)
 {
 	struct query_context *data = user_data;
-	GList *l;
+	GSList *l = NULL;
+	GSList *contacts = NULL;
+	GError *gerr = NULL;
 
 	data->queued_calls--;
 
 	if (data->canceled)
 		goto canceled;
 
+	e_book_client_get_contacts_finish (E_BOOK_CLIENT (source_object),
+					   result, &contacts, &gerr);
+
 	if (gerr != NULL) {
-		error("E-Book operation failed: %s", gerr->message);
+		error("Getting contacts failed: %s", gerr->message);
 		goto done;
 	}
 
-	DBG("");
-
-	for (l = contacts; l; l = g_list_next(l)) {
+	for (l = contacts; l; l = g_slist_next(l)) {
 		EContact *contact = E_CONTACT(l->data);
 		EVCard *evcard = E_VCARD(contact);
 		EVCardAttribute *attrib;
@@ -341,7 +536,9 @@ static void cache_cb(EBook *book, const GError *gerr, GList *contacts,
 		g_free(tel);
 	}
 
-	g_list_free_full(contacts, g_object_unref);
+	DBG("caching successful");
+
+	g_slist_free_full(contacts, (GDestroyNotify) g_object_unref);
 
 done:
 	if (data->queued_calls == 0)
@@ -354,275 +551,16 @@ canceled:
 		free_query_context(data);
 }
 
-static GSList *traverse_sources(GSList *ebooks, GSList *sources,
-							char **default_src) {
-	GError *gerr = NULL;
-
-	for (; sources != NULL; sources = g_slist_next(sources)) {
-		char *uri;
-		ESource *source = E_SOURCE(sources->data);
-		EBook *ebook = e_book_new(source, &gerr);
-
-		if (ebook == NULL) {
-			error("Can't create user's address book: %s",
-								gerr->message);
-			g_clear_error(&gerr);
-			continue;
-		}
-
-		uri = e_source_get_uri(source);
-		if (g_strcmp0(*default_src, uri) == 0) {
-			g_free(uri);
-			continue;
-		}
-		g_free(uri);
-
-		if (e_book_open(ebook, FALSE, &gerr) == FALSE) {
-			error("Can't open e-book address book: %s",
-							gerr->message);
-			g_object_unref(ebook);
-			g_clear_error(&gerr);
-			continue;
-		}
-
-		if (*default_src == NULL)
-			*default_src = e_source_get_uri(source);
-
-		DBG("%s address book opened", e_source_peek_name(source));
-
-		ebooks = g_slist_append(ebooks, ebook);
-	}
-
-	return ebooks;
-}
-
-int phonebook_init(void)
-{
-	g_type_init();
-
-	return 0;
-}
-
-static GSList *open_ebooks(void)
-{
-	GError *gerr = NULL;
-	ESourceList *src_list;
-	GSList *list;
-	char *default_src = NULL;
-	GSList *ebooks = NULL;
-
-	if (e_book_get_addressbooks(&src_list, &gerr) == FALSE) {
-		error("Can't list user's address books: %s", gerr->message);
-		g_error_free(gerr);
-		return NULL;
-	}
-
-	list = e_source_list_peek_groups(src_list);
-	while (list != NULL) {
-		ESourceGroup *group = E_SOURCE_GROUP(list->data);
-		GSList *sources = e_source_group_peek_sources(group);
-
-		ebooks = traverse_sources(ebooks, sources, &default_src);
-
-		list = list->next;
-	}
-
-	g_free(default_src);
-	g_object_unref(src_list);
-
-	return ebooks;
-}
-
-void phonebook_exit(void)
-{
-}
-
-char *phonebook_set_folder(const char *current_folder,
-		const char *new_folder, uint8_t flags, int *err)
-{
-	gboolean root, child;
-	char *fullname = NULL, *tmp1, *tmp2, *base;
-	int ret = 0, len;
-
-	root = (g_strcmp0("/", current_folder) == 0);
-	child = (new_folder && strlen(new_folder) != 0);
-
-	/* Evolution back-end will support /telecom/pb folder only */
-
-	switch (flags) {
-	case 0x02:
-		/* Go back to root */
-		if (!child) {
-			fullname = g_strdup("/");
-			goto done;
-		}
-
-		/* Go down 1 level */
-		fullname = g_build_filename(current_folder, new_folder, NULL);
-		if (strcmp(PB_TELECOM_FOLDER, fullname) != 0 &&
-				strcmp(PB_CONTACTS_FOLDER, fullname) != 0) {
-			g_free(fullname);
-			fullname = NULL;
-			ret = -ENOENT;
-		}
-
-		break;
-	case 0x03:
-		/* Go up 1 level */
-		if (root) {
-			/* Already root */
-			ret = -EBADR;
-			goto done;
-		}
-
-		/*
-		 * Removing one level of the current folder. Current folder
-		 * contains AT LEAST one level since it is not at root folder.
-		 * Use glib utility functions to handle invalid chars in the
-		 * folder path properly.
-		 */
-		tmp1 = g_path_get_basename(current_folder);
-		tmp2 = g_strrstr(current_folder, tmp1);
-		len = tmp2 - (current_folder + 1);
-
-		g_free(tmp1);
-
-		if (len == 0)
-			base = g_strdup("/");
-		else
-			base = g_strndup(current_folder, len);
-
-		/* Return one level only */
-		if (!child) {
-			fullname = base;
-			goto done;
-		}
-
-		fullname = g_build_filename(base, new_folder, NULL);
-		if (strcmp(fullname, PB_TELECOM_FOLDER) != 0 &&
-				strcmp(fullname, PB_CONTACTS_FOLDER) != 0) {
-			g_free(fullname);
-			fullname = NULL;
-			ret = -ENOENT;
-		}
-
-		g_free(base);
-
-		break;
-	default:
-		ret = -EBADR;
-		break;
-	}
-
-done:
-	if (err)
-		*err = ret;
-
-	return fullname;
-}
-
-void phonebook_req_finalize(void *request)
-{
-	struct query_context *data = request;
-
-	if (data->queued_calls == 0)
-		free_query_context(data);
-	else
-		data->canceled = TRUE;
-}
-
-void *phonebook_pull(const char *name, const struct apparam_field *params,
-				phonebook_cb cb, void *user_data, int *err)
-{
-	struct query_context *data;
-
-	if (g_strcmp0(PB_CONTACTS, name) != 0) {
-		if (err)
-			*err = -ENOENT;
-
-		return NULL;
-	}
-
-	data = g_new0(struct query_context, 1);
-	data->contacts_cb = cb;
-	data->params = params;
-	data->user_data = user_data;
-	data->buf = g_string_new("");
-	data->query = e_book_query_any_field_contains("");
-	data->ebooks = open_ebooks();
-
-	if (err)
-		*err = data->ebooks == NULL ? -EIO : 0;
-
-	return data;
-}
-
-int phonebook_pull_read(void *request)
-{
-	struct query_context *data = request;
-	GSList *l;
-
-	if (!data)
-		return -ENOENT;
-
-	for (l = data->ebooks; l != NULL; l = g_slist_next(l)) {
-		EBook *ebook = l->data;
-
-		if (e_book_is_opened(ebook) == FALSE)
-			continue;
-
-		if (e_book_get_contacts_async(ebook, data->query,
-						ebookpull_cb, data) == TRUE)
-			data->queued_calls++;
-	}
-
-	if (data->queued_calls == 0)
-		return -ENOENT;
-
-	return 0;
-}
-
-void *phonebook_get_entry(const char *folder, const char *id,
-				const struct apparam_field *params,
-				phonebook_cb cb, void *user_data, int *err)
-{
-	struct query_context *data;
-	GSList *l;
-
-	data = g_new0(struct query_context, 1);
-	data->contacts_cb = cb;
-	data->params = params;
-	data->user_data = user_data;
-	data->id = g_strdup(id);
-	data->ebooks = open_ebooks();
-
-	for (l = data->ebooks; l != NULL; l = g_slist_next(l)) {
-		EBook *ebook = l->data;
-
-		if (e_book_is_opened(ebook) == FALSE)
-			continue;
-
-		if (e_book_get_contact_async(ebook, data->id,
-						ebook_entry_cb, data) == TRUE)
-			data->queued_calls++;
-	}
-
-	if (err)
-		*err = (data->queued_calls == 0 ? -ENOENT : 0);
-
-	return data;
-}
-
 void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
-		phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
+			     phonebook_cache_ready_cb ready_cb, void *user_data, int *err)
 {
+	/* Build a cache of contacts */
 	struct query_context *data;
 	EBookQuery *query;
-	GSList *l;
 	EContact *me;
+	EBookClient *me_client;
 	EVCard *evcard;
 	GError *gerr = NULL;
-	EBook *eb;
 	EVCardAttribute *attrib;
 	char *uid, *tel, *cname;
 
@@ -633,23 +571,25 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 		return NULL;
 	}
 
-	DBG("");
-
-	query = e_book_query_any_field_contains("");
+	DBG("creating cache");
 
 	data = g_new0(struct query_context, 1);
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
-	data->query = query;
-	data->ebooks = open_ebooks();
+	query = e_book_query_any_field_contains("");  // all contacts
+	data->query = e_book_query_to_string(query);
+	e_book_query_unref(query);
 
-	/* Add 0.vcf */
-	if (e_book_get_self(&me, &eb, &gerr) == FALSE) {
+	/* Myself as contact should always be 0.vcf if found in address book */
+	if (!e_book_client_get_self(registry, &me, &me_client, &gerr)) {
+		DBG("owner is not in address book: %s", gerr->message);
 		g_error_free(gerr);
 		goto next;
 	}
 
+	DBG("caching address book owner");
+
 	evcard = E_VCARD(me);
 
 	cname = evcard_name_attribute_to_string(evcard);
@@ -668,28 +608,66 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 		tel = g_strdup("");
 
 	data->entry_cb(uid, 0, cname, NULL, tel, data->user_data);
-
 	data->count++;
 
 	g_free(cname);
 	g_free(uid);
 	g_free(tel);
-	g_object_unref(eb);
 
 next:
-	for (l = data->ebooks; l != NULL; l = g_slist_next(l)) {
-		EBook *ebook = l->data;
-
-		if (e_book_is_opened(ebook) == FALSE)
-			continue;
-
-		if (e_book_get_contacts_async(ebook, query,
-						cache_cb, data) == TRUE)
-			data->queued_calls++;
-	}
+	/* Fetch async contacts from default address book */
+	DBG("caching contacts");
+	e_book_client_get_contacts(book_client, data->query, NULL,
+				   (GAsyncReadyCallback) phonebook_create_cache_ready,
+				   data);
+	data->queued_calls++;
 
 	if (err)
 		*err = (data->queued_calls == 0 ? -ENOENT : 0);
 
 	return data;
 }
+
+int phonebook_init(void)
+{
+	EClient *client;
+	GError *gerr = NULL;
+
+	/* Acquire ESource Registry */
+	registry = e_source_registry_new_sync(NULL, &gerr);
+	if (gerr != NULL) {
+		error("Unable to acquire registery: %s\n", gerr->message);
+		g_error_free(gerr);
+		return -1;
+	}
+
+	/* Get ref to default address book */
+	address_book = e_source_registry_ref_default_address_book(registry);
+	if (address_book == NULL) {
+		error("Unable to get reference to default address book");
+		return -2;
+	}
+
+	/* Allocate e-book client for address book */
+	gerr = NULL;
+	client = e_book_client_connect_sync(address_book, CONNECTION_TIMEOUT,
+					    NULL, &gerr);
+	if (gerr != NULL || client == NULL) {
+		error("Cannot connect ebook client to EDS: %s",
+		      gerr != NULL? gerr->message: "NULL");
+		g_error_free(gerr);
+		return -3;
+	}
+	book_client = E_BOOK_CLIENT(client);
+
+	DBG("created address book client");
+
+	return 0;
+}
+
+void phonebook_exit(void)
+{
+	g_object_unref(book_client);
+	g_object_unref(address_book);
+	g_object_unref(registry);
+}
-- 
2.32.0


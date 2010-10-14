Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not responding Not Found when no entry is found
Date: Thu, 14 Oct 2010 16:34:03 +0300
Message-Id: <1287063243-23296-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Accourding to PBAP spec PSE must reply Not Found when:

"The function was recognized and all the parameters are proper, but the
vCard handle or the phone book object could not be found."
---
 plugins/pbap.c              |   15 +++++++++++++++
 plugins/phonebook-tracker.c |   12 +++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 948f9df..13742da 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -228,6 +228,9 @@ static void phonebook_size_result(const char *buffer, size_t bufsize,
 	struct aparam_header *hdr = (struct aparam_header *) aparam;
 	uint16_t phonebooksize;
 
+	if (vcards < 0)
+		vcards = 0;
+
 	DBG("vcards %d", vcards);
 
 	phonebooksize = htons(vcards);
@@ -248,6 +251,11 @@ static void query_result(const char *buffer, size_t bufsize, int vcards,
 
 	DBG("");
 
+	if (vcards < 0) {
+		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
+		return;
+	}
+
 	if (!pbap->buffer)
 		pbap->buffer = g_string_new_len(buffer, bufsize);
 	else
@@ -389,6 +397,13 @@ static void cache_ready_notify(void *user_data)
 		pbap->buffer = g_string_new_len(aparam, sizeof(aparam));
 		goto done;
 	}
+
+	if (pbap->cache.entries == NULL) {
+		pbap->cache.valid = TRUE;
+		obex_object_set_io_flags(pbap, G_IO_ERR, -ENOENT);
+		return;
+	}
+
 	/*
 	 * Don't free the sorted list content: this list contains
 	 * only the reference for the "real" cache entry.
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 39e4c81..2da825b 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -924,6 +924,11 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 	gboolean cdata_present = FALSE;
 	char *home_addr, *work_addr;
 
+	if (num_fields < 0) {
+		data->cb(NULL, 0, num_fields, 0, data->user_data);
+		goto fail;
+	}
+
 	DBG("reply %p", reply);
 
 	if (reply == NULL)
@@ -1031,8 +1036,9 @@ done:
 				g_slist_length(data->contacts), 0,
 				data->user_data);
 
-	g_slist_free(data->contacts);
 	g_string_free(vcards, TRUE);
+fail:
+	g_slist_free(data->contacts);
 	g_free(data);
 }
 
@@ -1042,7 +1048,7 @@ static void add_to_cache(char **reply, int num_fields, void *user_data)
 	char *formatted;
 	int i;
 
-	if (reply == NULL)
+	if (reply == NULL || num_fields < 0)
 		goto done;
 
 	/* the first element is the URI, always not empty */
@@ -1075,7 +1081,7 @@ static void add_to_cache(char **reply, int num_fields, void *user_data)
 	return;
 
 done:
-	if (num_fields == 0)
+	if (num_fields <= 0)
 		cache->ready_cb(cache->user_data);
 
 	g_free(cache);
-- 
1.7.1


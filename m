Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Don Zickus <dzickus@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, mkasik@redhat.com,
	Don Zickus <dzickus@redhat.com>
Subject: [PATCH 2/3] obexd: Return dummy_data instead of int in phonebook-dummy
Date: Thu, 30 Jun 2016 17:01:28 -0400
Message-Id: <1467320489-127890-3-git-send-email-dzickus@redhat.com>
In-Reply-To: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
References: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are two functions in phonebook-dummy that were returning
'int's instead of 'struct dummy_data'

phonebook_create_cache
phonebook_get_entry

As a result, when an obex-client sends the GetSize command, the obexd
on the server segfaults.

Fix this by storing the id and returning the dummy_data struct.

The GetSize test now passes correctly.

Patch from Marek Kasik <mkasik@redhat.com>
---
 obexd/plugins/phonebook-dummy.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index eeb078f..9ad9cac 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -538,13 +538,13 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	dummy->apparams = params;
 	dummy->fd = fd;
 
-	ret = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_entry, dummy,
+	dummy->id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, read_entry, dummy,
 								dummy_free);
 
 	if (err)
 		*err = 0;
 
-	return GINT_TO_POINTER(ret);
+	return dummy;
 }
 
 void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
@@ -554,6 +554,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	char *foldername;
 	DIR *dp;
 	guint ret;
+	struct dummy_data *dummy;
 
 	foldername = g_build_filename(root_folder, name, NULL);
 	dp = opendir(foldername);
@@ -572,11 +573,13 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	query->user_data = user_data;
 	query->dp = dp;
 
-	ret = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache, query,
+	dummy = g_new0(struct dummy_data, 1);
+
+	dummy->id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache, query,
 								query_free);
 
 	if (err)
 		*err = 0;
 
-	return GINT_TO_POINTER(ret);
+	return dummy;
 }
-- 
1.8.3.1


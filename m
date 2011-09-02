Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 7/8] MAP Tracker: Add abort support in folder listing
Date: Fri,  2 Sep 2011 10:57:59 +0200
Message-Id: <1314953880-4663-7-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
References: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index f00ab6d..29f3ccd 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -869,6 +869,9 @@ static gboolean async_get_folder_listing(void *s) {
 	if (session->name && strchr(session->name, '/') != NULL)
 		goto done;
 
+	if (session->aborted)
+		goto aborted;
+
 	path = g_build_filename(session->cwd, session->name, NULL);
 
 	if (path == NULL || strlen(path) == 0)
@@ -895,11 +898,13 @@ static gboolean async_get_folder_listing(void *s) {
 					dir_data->name, session->user_data);
 	}
 
- done:
+done:
 	session->cb.folder_list(session, 0, folder_count, NULL,
 							session->user_data);
 
 	g_free(path);
+
+aborted:
 	g_free(session->name);
 
 	return FALSE;
@@ -916,6 +921,7 @@ int messages_get_folder_listing(void *s, const char *name,
 	session->offset = offset;
 	session->cb.folder_list = callback;
 	session->user_data = user_data;
+	session->aborted = FALSE;
 
 	g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, async_get_folder_listing,
 						session, NULL);
-- 
1.7.4.1


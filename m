Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 2/8] MAP Tracker: Fix memory issue in folder listing
Date: Fri,  2 Sep 2011 10:57:54 +0200
Message-Id: <1314953880-4663-2-git-send-email-bulislaw@linux.com>
In-Reply-To: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
References: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index eebfca3..218a016 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -40,7 +40,7 @@ struct message_folder {
 struct session {
 	char *cwd;
 	struct message_folder *folder;
-	const char *name;
+	char *name;
 	uint16_t max;
 	uint16_t offset;
 	void *user_data;
@@ -279,6 +279,7 @@ static gboolean async_get_folder_listing(void *s) {
 							session->user_data);
 
 	g_free(path);
+	g_free(session->name);
 
 	return FALSE;
 }
@@ -289,7 +290,7 @@ int messages_get_folder_listing(void *s, const char *name,
 					void *user_data)
 {
 	struct session *session = s;
-	session->name = name;
+	session->name = g_strdup(name);
 	session->max = max;
 	session->offset = offset;
 	session->folder_list_cb = callback;
-- 
1.7.4.1


Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/8] MAP Tracker: Fix folder and path handling
Date: Fri,  2 Sep 2011 10:57:53 +0200
Message-Id: <1314953880-4663-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index 43321f6..eebfca3 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -124,13 +124,13 @@ static void create_folder_tree()
 {
 	struct message_folder *parent, *child;
 
-	folder_tree = create_folder("/", NULL);
+	folder_tree = create_folder("/", "FILTER (!BOUND(?msg))");
 
-	parent = create_folder("telecom", NULL);
+	parent = create_folder("telecom", "FILTER (!BOUND(?msg))");
 	folder_tree->subfolders = g_slist_append(folder_tree->subfolders,
 								parent);
 
-	child = create_folder("msg", NULL);
+	child = create_folder("msg", "FILTER (!BOUND(?msg))");
 	parent->subfolders = g_slist_append(parent->subfolders, child);
 
 	parent = child;
@@ -217,7 +217,10 @@ int messages_set_folder(void *s, const char *name, gboolean cdup)
 									NULL);
 	g_free(tmp);
 
-	newabs = g_build_filename("/", newrel, NULL);
+	if (newrel[0] != '/')
+		newabs = g_build_filename("/", newrel, NULL);
+	else
+		newabs = g_strdup(newrel);
 
 	session->folder = get_folder(newabs);
 	if (session->folder == NULL) {
-- 
1.7.4.1


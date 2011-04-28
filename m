Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Cleanup functions that update found UUIDs(EIR)
Date: Thu, 28 Apr 2011 19:34:29 -0300
Message-Id: <1304030070-6575-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8dbd62c..f7bbc3e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3059,11 +3059,11 @@ static struct remote_dev_info *get_found_dev(struct btd_adapter *adapter,
 static void remove_same_uuid(gpointer data, gpointer user_data)
 {
 	struct remote_dev_info *dev = user_data;
+	const char *new_uuid = data;
 	GSList *l;
 
 	for (l = dev->services; l; l = l->next) {
 		char *current_uuid = l->data;
-		char *new_uuid = data;
 
 		if (strcmp(current_uuid, new_uuid) == 0) {
 			g_free(current_uuid);
@@ -3076,7 +3076,7 @@ static void remove_same_uuid(gpointer data, gpointer user_data)
 static void dev_prepend_uuid(gpointer data, gpointer user_data)
 {
 	struct remote_dev_info *dev = user_data;
-	char *new_uuid = data;
+	const char *new_uuid = data;
 
 	dev->services = g_slist_prepend(dev->services, g_strdup(new_uuid));
 }
-- 
1.7.5.rc3


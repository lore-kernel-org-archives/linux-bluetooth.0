Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/5] MAP/dummy: Add basic logic for folder listing
Date: Tue,  6 Mar 2012 18:42:25 +0100
Message-Id: <1331055748-14212-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331055748-14212-1-git-send-email-lkslawek@gmail.com>
References: <1331055748-14212-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-dummy.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index 3ba333c..db15a75 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -25,6 +25,8 @@
 #include <config.h>
 #endif
 
+#include <sys/types.h>
+#include <dirent.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
@@ -48,8 +50,39 @@ struct folder_listing_data {
 	void *user_data;
 };
 
+static ssize_t get_subdirs(struct folder_listing_data *fld, GSList **list)
+{
+	return 0;
+}
+
+static void return_folder_listing(struct folder_listing_data *fld, GSList *list)
+{
+	struct session *session = fld->session;
+
+	fld->callback(session, 0, 0, NULL, fld->user_data);
+}
+
 static gboolean get_folder_listing(void *d)
 {
+	struct folder_listing_data *fld = d;
+	ssize_t n;
+	GSList *list = NULL;
+
+	n = get_subdirs(fld, &list);
+
+	if (n < 0) {
+		fld->callback(fld->session, n, 0, NULL, fld->user_data);
+		return FALSE;
+	}
+
+	if (fld->max == 0) {
+		fld->callback(fld->session, 0, n, NULL, fld->user_data);
+		return FALSE;
+	}
+
+	return_folder_listing(fld, list);
+	g_slist_free_full(list, g_free);
+
 	return FALSE;
 }
 
-- 
1.7.5.1


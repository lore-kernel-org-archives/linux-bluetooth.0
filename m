Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 8/8] ftp: fix coding style
Date: Wed,  2 Nov 2011 15:09:55 +0200
Message-Id: <1320239395-29819-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
References: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make use of tabs instead of spaces
---
 plugins/ftp.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 30edc6b..0586326 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -358,26 +358,26 @@ done:
 
 static gboolean is_valid_path(const char *path)
 {
-        gchar **elements, **cur;
-        int depth = 0;
+	gchar **elements, **cur;
+	int depth = 0;
 
-        elements = g_strsplit(path, "/", 0);
+	elements = g_strsplit(path, "/", 0);
 
-        for (cur = elements; *cur != NULL; cur++) {
-                if (**cur == '\0' || strcmp(*cur, ".") == 0)
-                        continue;
+	for (cur = elements; *cur != NULL; cur++) {
+		if (**cur == '\0' || strcmp(*cur, ".") == 0)
+			continue;
 
-                if (strcmp(*cur, "..") == 0) {
-                        depth--;
-                        if (depth < 0)
-                                break;
-                        continue;
-                }
+		if (strcmp(*cur, "..") == 0) {
+			depth--;
+			if (depth < 0)
+				break;
+			continue;
+		}
 
-                depth++;
-        }
+		depth++;
+	}
 
-        g_strfreev(elements);
+	g_strfreev(elements);
 
 	if (depth < 0)
 		return FALSE;
-- 
1.7.6.4


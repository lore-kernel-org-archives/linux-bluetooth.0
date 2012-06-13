Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH obexd 6/7] filesystem: Use proper pointer type instead of void* in string_read
Date: Wed, 13 Jun 2012 22:49:22 +0200
Message-Id: <1339620563-25161-6-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
References: <1339620563-25161-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/filesystem.c |    3 +--
 plugins/filesystem.h |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index e664fc5..d1a3df4 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -594,9 +594,8 @@ static int string_free(void *object)
 	return 0;
 }
 
-ssize_t string_read(void *object, void *buf, size_t count)
+ssize_t string_read(GString *string, void *buf, size_t count)
 {
-	GString *string = object;
 	ssize_t len;
 
 	if (string->len == 0)
diff --git a/plugins/filesystem.h b/plugins/filesystem.h
index f95773b..694a350 100644
--- a/plugins/filesystem.h
+++ b/plugins/filesystem.h
@@ -21,6 +21,6 @@
  *
  */
 
-ssize_t string_read(void *object, void *buf, size_t count);
+ssize_t string_read(GString *string, void *buf, size_t count);
 gboolean is_filename(const char *name);
 int verify_path(const char *path);
-- 
1.7.10.4



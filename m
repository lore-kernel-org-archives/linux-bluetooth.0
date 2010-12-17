Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Fix crash when mmaping files which size is multiple of page size
Date: Fri, 17 Dec 2010 15:31:26 +0200
Message-Id: <1292592686-14908-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

In this case the buffer returned by mmap is not NULL terminated so
functions like strpbrk that expect a string goes out of bounds.

To fix this strpbrk_len was introduced which takes the size of the buffer
making sure it never goes out of bounds.
---
 src/textfile.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/src/textfile.c b/src/textfile.c
index 2429cc7..d115ff6 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -156,6 +156,28 @@ static inline int write_key_value(int fd, const char *key, const char *value)
 	return err;
 }
 
+static char *strnpbrk(const char *s, ssize_t len, const char *accept)
+{
+	const char *p = s;
+	const char *end;
+
+	end = s + len - 1;
+
+	while (p <= end && *p) {
+		const char *a = accept;
+
+		while (*a) {
+			if (*p == *a)
+				return (char *) p;
+			a++;
+		}
+
+		p++;
+	}
+
+	return NULL;
+}
+
 static int write_key(const char *pathname, const char *key, const char *value, int icase)
 {
 	struct stat st;
@@ -207,7 +229,7 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 
 	base = off - map;
 
-	end = strpbrk(off, "\r\n");
+	end = strnpbrk(off, size, "\r\n");
 	if (!end) {
 		err = EILSEQ;
 		goto unmap;
@@ -315,7 +337,7 @@ static char *read_key(const char *pathname, const char *key, int icase)
 		goto unmap;
 	}
 
-	end = strpbrk(off, "\r\n");
+	end = strnpbrk(off, size - (map - off), "\r\n");
 	if (!end) {
 		err = EILSEQ;
 		goto unmap;
@@ -404,8 +426,8 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 
 	off = map;
 
-	while (1) {
-		end = strpbrk(off, " ");
+	while (size - (off - map) > 0) {
+		end = strnpbrk(off, size - (off - map), " ");
 		if (!end) {
 			err = EILSEQ;
 			break;
@@ -424,7 +446,13 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 
 		off = end + 1;
 
-		end = strpbrk(off, "\r\n");
+		if (size - (off - map) < 0) {
+			err = EILSEQ;
+			free(key);
+			break;
+		}
+
+		end = strnpbrk(off, size - (off - map), "\r\n");
 		if (!end) {
 			err = EILSEQ;
 			free(key);
-- 
1.7.1


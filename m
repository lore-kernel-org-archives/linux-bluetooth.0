Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 09/17] textfile: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:56 -0400
Message-Id: <1321449604-4188-10-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 src/textfile.c |   56 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/src/textfile.c b/src/textfile.c
index 3fb3c01..2712cd8 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -149,7 +149,7 @@ static inline int write_key_value(int fd, const char *key, const char *value)
 	sprintf(str, "%s %s\n", key, value);
 
 	if (write(fd, str, size) < 0)
-		err = errno;
+		err = -errno;
 
 	free(str);
 
@@ -191,12 +191,12 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 		return -errno;
 
 	if (flock(fd, LOCK_EX) < 0) {
-		err = errno;
+		err = -errno;
 		goto close;
 	}
 
 	if (fstat(fd, &st) < 0) {
-		err = errno;
+		err = -errno;
 		goto unlock;
 	}
 
@@ -213,7 +213,7 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 	map = mmap(NULL, size, PROT_READ | PROT_WRITE,
 					MAP_PRIVATE | MAP_LOCKED, fd, 0);
 	if (!map || map == MAP_FAILED) {
-		err = errno;
+		err = -errno;
 		goto unlock;
 	}
 
@@ -232,7 +232,7 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 
 	end = strnpbrk(off, size, "\r\n");
 	if (!end) {
-		err = EILSEQ;
+		err = -EILSEQ;
 		goto unmap;
 	}
 
@@ -247,7 +247,7 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 	if (!len) {
 		munmap(map, size);
 		if (ftruncate(fd, base) < 0) {
-			err = errno;
+			err = -errno;
 			goto unlock;
 		}
 		lseek(fd, base, SEEK_SET);
@@ -258,13 +258,13 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 	}
 
 	if (len < 0 || len > size) {
-		err = EILSEQ;
+		err = -EILSEQ;
 		goto unmap;
 	}
 
 	str = malloc(len);
 	if (!str) {
-		err = errno;
+		err = -errno;
 		goto unmap;
 	}
 
@@ -272,7 +272,7 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 
 	munmap(map, size);
 	if (ftruncate(fd, base) < 0) {
-		err = errno;
+		err = -errno;
 		free(str);
 		goto unlock;
 	}
@@ -281,7 +281,7 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 		err = write_key_value(fd, key, value);
 
 	if (write(fd, str, len) < 0)
-		err = errno;
+		err = -errno;
 
 	free(str);
 
@@ -297,9 +297,9 @@ close:
 	fdatasync(fd);
 
 	close(fd);
-	errno = err;
+	errno = -err;
 
-	return -err;
+	return err;
 }
 
 static char *read_key(const char *pathname, const char *key, int icase)
@@ -314,12 +314,12 @@ static char *read_key(const char *pathname, const char *key, int icase)
 		return NULL;
 
 	if (flock(fd, LOCK_SH) < 0) {
-		err = errno;
+		err = -errno;
 		goto close;
 	}
 
 	if (fstat(fd, &st) < 0) {
-		err = errno;
+		err = -errno;
 		goto unlock;
 	}
 
@@ -327,26 +327,26 @@ static char *read_key(const char *pathname, const char *key, int icase)
 
 	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
 	if (!map || map == MAP_FAILED) {
-		err = errno;
+		err = -errno;
 		goto unlock;
 	}
 
 	len = strlen(key);
 	off = find_key(map, size, key, len, icase);
 	if (!off) {
-		err = EILSEQ;
+		err = -EILSEQ;
 		goto unmap;
 	}
 
 	end = strnpbrk(off, size - (map - off), "\r\n");
 	if (!end) {
-		err = EILSEQ;
+		err = -EILSEQ;
 		goto unmap;
 	}
 
 	str = malloc(end - off - len);
 	if (!str) {
-		err = EILSEQ;
+		err = -EILSEQ;
 		goto unmap;
 	}
 
@@ -361,7 +361,7 @@ unlock:
 
 close:
 	close(fd);
-	errno = err;
+	errno = -err;
 
 	return str;
 }
@@ -408,12 +408,12 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 		return -errno;
 
 	if (flock(fd, LOCK_SH) < 0) {
-		err = errno;
+		err = -errno;
 		goto close;
 	}
 
 	if (fstat(fd, &st) < 0) {
-		err = errno;
+		err = -errno;
 		goto unlock;
 	}
 
@@ -421,7 +421,7 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 
 	map = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
 	if (!map || map == MAP_FAILED) {
-		err = errno;
+		err = -errno;
 		goto unlock;
 	}
 
@@ -430,7 +430,7 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 	while (size - (off - map) > 0) {
 		end = strnpbrk(off, size - (off - map), " ");
 		if (!end) {
-			err = EILSEQ;
+			err = -EILSEQ;
 			break;
 		}
 
@@ -438,7 +438,7 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 
 		key = malloc(len + 1);
 		if (!key) {
-			err = errno;
+			err = -errno;
 			break;
 		}
 
@@ -448,14 +448,14 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 		off = end + 1;
 
 		if (size - (off - map) < 0) {
-			err = EILSEQ;
+			err = -EILSEQ;
 			free(key);
 			break;
 		}
 
 		end = strnpbrk(off, size - (off - map), "\r\n");
 		if (!end) {
-			err = EILSEQ;
+			err = -EILSEQ;
 			free(key);
 			break;
 		}
@@ -464,7 +464,7 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 
 		value = malloc(len + 1);
 		if (!value) {
-			err = errno;
+			err = -errno;
 			free(key);
 			break;
 		}
@@ -487,7 +487,7 @@ unlock:
 
 close:
 	close(fd);
-	errno = err;
+	errno = -err;
 
 	return 0;
 }
-- 
1.7.0.4


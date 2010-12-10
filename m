Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix crash while reading from mapped file
Date: Fri, 10 Dec 2010 14:55:48 +0100
Message-Id: <1291989348-3911-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After opening file from /var/lib/bluetooth/<bt_addr>/ and mapping to
memory as it is done in "textfile_foreach" function in textfile.c,
it may crash when size of file is equal to page size
(or it's multiplicity) since "strpbrk" function operates on string
so it expects zero at the end of buffer ("mmap" function zeroes
remaining memory when mapped only for a file which size is not a
multiple of the page size, so in this case "strpbrk" function can't
find null terminating character and goes out of bounds).
This patch provide buffer which contains null terminating character to
avoid crash.
---
 src/textfile.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/src/textfile.c b/src/textfile.c
index 2429cc7..393efb8 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -376,7 +376,7 @@ char *textfile_caseget(const char *pathname, const char *key)
 int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 {
 	struct stat st;
-	char *map, *off, *end, *key, *value;
+	char *map, *off, *end, *key, *value, *buffer = NULL;
 	off_t size; size_t len;
 	int fd, err = 0;
 
@@ -404,6 +404,13 @@ int textfile_foreach(const char *pathname, textfile_cb func, void *data)
 
 	off = map;
 
+	if (!(size % getpagesize())) {
+		buffer = malloc(size + 1);
+		memset(buffer, 0, size + 1);
+		memcpy(buffer, map, size);
+		off = buffer;
+	}
+
 	while (1) {
 		end = strpbrk(off, " ");
 		if (!end) {
@@ -458,6 +465,7 @@ unlock:
 
 close:
 	close(fd);
+	free(buffer);
 	errno = err;
 
 	return 0;
-- 
1.6.3.3


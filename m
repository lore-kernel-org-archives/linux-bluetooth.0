Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/4] shared/btsnoop: Add btsnoop_create_fd
Date: Fri, 30 May 2014 18:15:53 +0200
Message-ID: <1401466556-9040-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds btsnoop_create_fd function which allows to create
btsnoop on existing file descriptor instead of creating new file like
btsnoop_create does.
---
 src/shared/btsnoop.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 src/shared/btsnoop.h |  1 +
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 17a872c..da993c5 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -128,12 +128,45 @@ failed:
 	return NULL;
 }
 
-struct btsnoop *btsnoop_create(const char *path, uint32_t type)
+static bool btsnoop_init(struct btsnoop *btsnoop, uint32_t type)
 {
-	struct btsnoop *btsnoop;
 	struct btsnoop_hdr hdr;
 	ssize_t written;
 
+	btsnoop->type = type;
+	btsnoop->index = 0xffff;
+
+	memcpy(hdr.id, btsnoop_id, sizeof(btsnoop_id));
+	hdr.version = htobe32(btsnoop_version);
+	hdr.type = htobe32(btsnoop->type);
+
+	written = write(btsnoop->fd, &hdr, BTSNOOP_HDR_SIZE);
+
+	return written == BTSNOOP_HDR_SIZE;
+}
+
+struct btsnoop *btsnoop_create_fd(int fd, uint32_t type)
+{
+	struct btsnoop *btsnoop;
+
+	btsnoop = calloc(1, sizeof(*btsnoop));
+	if (!btsnoop)
+		return NULL;
+
+	btsnoop->fd = fd;
+
+	if (!btsnoop_init(btsnoop, type)) {
+		free(btsnoop);
+		return NULL;
+	}
+
+	return btsnoop_ref(btsnoop);
+}
+
+struct btsnoop *btsnoop_create(const char *path, uint32_t type)
+{
+	struct btsnoop *btsnoop;
+
 	btsnoop = calloc(1, sizeof(*btsnoop));
 	if (!btsnoop)
 		return NULL;
@@ -145,15 +178,7 @@ struct btsnoop *btsnoop_create(const char *path, uint32_t type)
 		return NULL;
 	}
 
-	btsnoop->type = type;
-	btsnoop->index = 0xffff;
-
-	memcpy(hdr.id, btsnoop_id, sizeof(btsnoop_id));
-	hdr.version = htobe32(btsnoop_version);
-	hdr.type = htobe32(btsnoop->type);
-
-	written = write(btsnoop->fd, &hdr, BTSNOOP_HDR_SIZE);
-	if (written < 0) {
+	if (!btsnoop_init(btsnoop, type)) {
 		close(btsnoop->fd);
 		free(btsnoop);
 		return NULL;
diff --git a/src/shared/btsnoop.h b/src/shared/btsnoop.h
index 2c55d02..9e6b854 100644
--- a/src/shared/btsnoop.h
+++ b/src/shared/btsnoop.h
@@ -55,6 +55,7 @@ struct btsnoop;
 
 struct btsnoop *btsnoop_open(const char *path, unsigned long flags);
 struct btsnoop *btsnoop_create(const char *path, uint32_t type);
+struct btsnoop *btsnoop_create_fd(int fd, uint32_t type);
 
 struct btsnoop *btsnoop_ref(struct btsnoop *btsnoop);
 void btsnoop_unref(struct btsnoop *btsnoop);
-- 
1.9.3


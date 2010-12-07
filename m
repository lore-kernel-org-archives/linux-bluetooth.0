Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Add support for stat files bigger than 2GB on 32-bit systems
Date: Tue,  7 Dec 2010 17:01:01 +0200
Message-Id: <1291734061-24408-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1291734061-24408-1-git-send-email-luiz.dentz@gmail.com>
References: <1291734061-24408-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

>From stat documentation:

"(stat())  path  refers to a file whose size cannot be represented in the
type off_t.  This can occur when an application compiled on a 32-bit
platform without -D_FILE_OFFSET_BITS=64 calls stat() on a file whose size
exceeds (2<<31)-1 bits."

Note that this doesn't really help for files bigger than 4GB since obex
header field is 32-bits, but since folder-listing has no such limitation
it probably worth doing this anyway.
---
 acinclude.m4         |    2 +-
 client/transfer.c    |    5 +++--
 plugins/filesystem.c |    2 +-
 src/obex-priv.h      |    6 +++---
 src/obex.c           |    6 +++---
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 4594073..3d1f511 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -12,7 +12,7 @@ AC_DEFUN([AC_PROG_CC_PIE], [
 
 AC_DEFUN([COMPILER_FLAGS], [
 	if (test "${CFLAGS}" = ""); then
-		CFLAGS="-Wall -O2 -D_FORTIFY_SOURCE=2"
+		CFLAGS="-Wall -O2 -D_FORTIFY_SOURCE=2 -D_FILE_OFFSET_BITS=64"
 	fi
 	if (test "$USE_MAINTAINER_MODE" = "yes"); then
 		CFLAGS+=" -Werror -Wextra"
diff --git a/client/transfer.c b/client/transfer.c
index 6eec513..daab4dc 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -470,7 +470,7 @@ int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
 	struct session_data *session = transfer->session;
 	gw_obex_xfer_cb_t cb;
 	struct stat st;
-	int fd;
+	int fd, size;
 
 	if (transfer->xfer != NULL)
 		return -EALREADY;
@@ -497,8 +497,9 @@ int transfer_put(struct transfer_data *transfer, transfer_callback_t func,
 	cb = put_xfer_progress;
 
 done:
+	size = transfer->size < G_MAXUINT32 ? transfer->size : 0;
 	transfer->xfer = gw_obex_put_async(session->obex, transfer->name,
-						transfer->type, transfer->size,
+						transfer->type, size,
 						-1, NULL);
 	if (transfer->xfer == NULL)
 		return -ENOTCONN;
diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index bb758ab..0386c92 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -66,7 +66,7 @@
 
 #define FL_PARENT_FOLDER_ELEMENT "<parent-folder/>" EOL_CHARS
 
-#define FL_FILE_ELEMENT "<file name=\"%s\" size=\"%lu\"" \
+#define FL_FILE_ELEMENT "<file name=\"%s\" size=\"%llu\"" \
 			" %s accessed=\"%s\" " \
 			"modified=\"%s\" created=\"%s\"/>" EOL_CHARS
 
diff --git a/src/obex-priv.h b/src/obex-priv.h
index c9be1c5..0806a56 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -33,9 +33,9 @@ struct obex_session {
 	char *path;
 	time_t time;
 	uint8_t *buf;
-	int32_t pending;
-	int32_t offset;
-	int32_t size;
+	int64_t pending;
+	int64_t offset;
+	int64_t size;
 	void *object;
 	gboolean aborted;
 	struct obex_service_driver *service;
diff --git a/src/obex.c b/src/obex.c
index 6d4430d..99bfecc 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -590,7 +590,7 @@ static int obex_read_stream(struct obex_session *os, obex_t *obex,
 
 	/* only write if both object and driver are valid */
 	if (os->object == NULL || os->driver == NULL) {
-		DBG("Stored %u bytes into temporary buffer", os->pending);
+		DBG("Stored %llu bytes into temporary buffer", os->pending);
 		return 0;
 	}
 
@@ -796,7 +796,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 	if (err < 0)
 		goto done;
 
-	if (os->size != OBJECT_SIZE_UNKNOWN) {
+	if (os->size != OBJECT_SIZE_UNKNOWN && os->size < G_MAXUINT32) {
 		hd.bq4 = os->size;
 		OBEX_ObjectAddHeader(obex, obj,
 				OBEX_HDR_LENGTH, hd, 4, 0);
@@ -1005,7 +1005,7 @@ static gboolean check_put(obex_t *obex, obex_object_t *obj)
 
 		case OBEX_HDR_LENGTH:
 			os->size = hd.bq4;
-			DBG("OBEX_HDR_LENGTH: %d", os->size);
+			DBG("OBEX_HDR_LENGTH: %llu", os->size);
 			break;
 		case OBEX_HDR_TIME:
 			os->time = parse_iso8610((const char *) hd.bs, hlen);
-- 
1.7.1


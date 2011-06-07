Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 2/4] Remove redundant code
Date: Tue,  7 Jun 2011 15:09:59 +0200
Message-Id: <1307452201-11057-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1307452201-11057-1-git-send-email-lkslawek@gmail.com>
References: <1307452201-11057-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes outdated (no longer used) code from obex_write_stream:

1) Support for sending data injected directly to obj->buf. This was used
for implementing folder listing in commit:
c42eff92a9c2c177f788dd1ec429250e64f69a78.
2) os->finished flag originally used for supporting asynchronous code in
PBAP, introduced in commit:
1a5025349df3dc6134db62afdcd048c00f876b27
---
 src/obex-priv.h |    1 -
 src/obex.c      |   20 +++-----------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/src/obex-priv.h b/src/obex-priv.h
index 0806a56..0caa0dd 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -45,7 +45,6 @@ struct obex_session {
 	obex_t *obex;
 	obex_object_t *obj;
 	struct obex_mime_type_driver *driver;
-	gboolean finished;
 };
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
diff --git a/src/obex.c b/src/obex.c
index 643b942..e6585ca 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -310,7 +310,6 @@ static void os_reset_session(struct obex_session *os)
 	os->pending = 0;
 	os->offset = 0;
 	os->size = OBJECT_SIZE_DELETE;
-	os->finished = 0;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -625,7 +624,6 @@ static int obex_write_stream(struct obex_session *os,
 			obex_t *obex, obex_object_t *obj)
 {
 	obex_headerdata_t hd;
-	uint8_t *ptr;
 	ssize_t len;
 	unsigned int flags;
 	uint8_t hi;
@@ -637,14 +635,8 @@ static int obex_write_stream(struct obex_session *os,
 	if (os->aborted)
 		return -EPERM;
 
-	if (os->object == NULL) {
-		if (os->buf == NULL && os->finished == FALSE)
-			return -EIO;
-
-		len = MIN(os->size - os->offset, os->tx_mtu);
-		ptr = os->buf + os->offset;
-		goto add_header;
-	}
+	if (os->object == NULL)
+		return -EIO;
 
 	len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
 	if (len < 0) {
@@ -659,11 +651,7 @@ static int obex_write_stream(struct obex_session *os,
 		return len;
 	}
 
-	ptr = os->buf;
-
-add_header:
-
-	hd.bs = ptr;
+	hd.bs = os->buf;
 
 	switch (hi) {
 	case OBEX_HDR_BODY:
@@ -684,8 +672,6 @@ add_header:
 		os->buf = NULL;
 	}
 
-	os->offset += len;
-
 	return 0;
 }
 
-- 
1.7.4.1


Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Add support for sending small data through obex
Date: Mon,  1 Nov 2010 11:24:59 +0200
Message-Id: <1288603499-16456-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added handling packets smaller than mtu in obex_write_stream. Now trying
to read from source until mtu will be filled properly and not sending
immediately data if it is smaller than mtu.
---
 src/obex.c |   48 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index 6d4430d..d3a6ccd 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -623,6 +623,7 @@ static int obex_write_stream(struct obex_session *os,
 	obex_headerdata_t hd;
 	uint8_t *ptr;
 	ssize_t len;
+	ssize_t r_len;
 	unsigned int flags;
 	uint8_t hi;
 
@@ -642,18 +643,37 @@ static int obex_write_stream(struct obex_session *os,
 		goto add_header;
 	}
 
-	len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
-	if (len < 0) {
-		error("read(): %s (%zd)", strerror(-len), -len);
-		if (len == -EAGAIN)
-			return len;
-		else if (len == -ENOSTR)
-			return 0;
+	/* Copying data from source until we reach end of the stream. Sending
+	 * data only if MTU will be filled in 100% or we reach end of data.
+	 * Remaining data in buffer will be sent with next amount of data
+	 * from source.*/
+	do {
+		r_len = os->driver->read(os->object, os->buf + os->pending,
+					os->tx_mtu - os->pending, &hi);
+
+		if (r_len < 0) {
+			error("read(): %s (%zd)", strerror(-r_len), -r_len);
+
+			switch(r_len) {
+			case -EAGAIN:
+				return r_len;
+			case -EINTR:
+				continue;
+			case -ENOSTR:
+				return 0;
+			default:
+				g_free(os->buf);
+				os->buf = NULL;
+				return r_len;
+			}
+		}
 
-		g_free(os->buf);
-		os->buf = NULL;
-		return len;
-	}
+		/* Saving amount of data accumulated in obex buffer */
+		os->pending += r_len;
+	} while (os->pending < os->tx_mtu && r_len != 0);
+
+	len = os->pending;
+	os->pending = 0;
 
 	ptr = os->buf;
 
@@ -702,6 +722,12 @@ static gboolean handle_async_io(void *object, int flags, int err,
 		ret = obex_read_stream(os, os->obex, os->obj);
 
 proceed:
+
+	/* Returning TRUE to not delete current watcher - it need to be active
+	 * to handle next io flag changes (more data will be available later)*/
+	if (ret == -EAGAIN)
+		return TRUE;
+
 	if (ret < 0) {
 		os_set_response(os->obj, err);
 		OBEX_CancelRequest(os->obex, TRUE);
-- 
1.7.0.4


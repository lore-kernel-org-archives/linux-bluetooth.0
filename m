Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Add flush callback to mimetype driver
Date: Tue, 22 Feb 2011 11:43:39 +0200
Message-Id: <1298367822-27766-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
References: <1298367822-27766-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This add the possibility to a driver to flush its data when final packet
is received which is specially usefull for PUT to prevent auto response
for objects with no body/body empty/size 0.

Note that it should not block like fsync, instead it is assumed to always
be asyncronous so request is suspended when .flush returns > 0, the
driver should then use obex_object_set_io_flags to indicate that it has
completed the operation.
---
 src/mimetype.h |    1 +
 src/obex.c     |   26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/src/mimetype.h b/src/mimetype.h
index ff16a8c..5bf741c 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -36,6 +36,7 @@ struct obex_mime_type_driver {
 	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi,
 							unsigned int *flags);
 	ssize_t (*write) (void *object, const void *buf, size_t count);
+	int (*flush) (void *object);
 	int (*remove) (const char *name);
 	int (*set_io_watch) (void *object, obex_object_io_func func,
 				void *user_data);
diff --git a/src/obex.c b/src/obex.c
index f2a21b7..caba2fb 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -613,6 +613,11 @@ write:
 		os->pending -= w;
 	}
 
+	/* Flush on EOS */
+	if (os->size != OBJECT_SIZE_UNKNOWN && os->size == os->offset &&
+							os->driver->flush)
+		return os->driver->flush(os->object) > 0 ? -EAGAIN : 0;
+
 	return 0;
 }
 
@@ -702,7 +707,7 @@ static gboolean handle_async_io(void *object, int flags, int err,
 
 	if (flags & (G_IO_IN | G_IO_PRI))
 		ret = obex_write_stream(os, os->obex, os->obj);
-	else if (flags & G_IO_OUT)
+	else if ((flags & G_IO_OUT) && os->pending > 0)
 		ret = obex_read_stream(os, os->obex, os->obj);
 
 proceed:
@@ -1089,8 +1094,25 @@ static void cmd_put(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 	}
 
 	err = os->service->put(os, obj, os->service_data);
-	if (err < 0)
+	if (err < 0) {
 		os_set_response(obj, err);
+		return;
+	}
+
+	/* Check if there is a body and it is not empty (size > 0), otherwise
+	   openobex won't notify us with OBEX_EV_STREAMAVAIL and it gonna reply
+	   right away */
+	if (os->size != 0)
+		return;
+
+	/* Flush immediatly since there is nothing to write so the driver
+	   has a chance to do something before we reply */
+	if (os->object && os->driver && os->driver->flush &&
+					os->driver->flush(os->object) > 0) {
+		OBEX_SuspendRequest(obex, obj);
+		os->obj = obj;
+		os->driver->set_io_watch(os->object, handle_async_io, os);
+	}
 }
 
 static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
-- 
1.7.1


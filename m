Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 1/5] Revert API changes to mime driver read function
Date: Thu,  2 Jun 2011 15:23:19 +0200
Message-Id: <1307021003-15418-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
References: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts parts of commit e0b3283e20ba885018010a6a8ae49b7c313958e8.  API
changes introduced before were meant to guarantee required PBAP functionality
of sending application parameters header in first packet of multi-packet
response.

However OBEX_FL_FIT_ONE_PACKET does not serve this purpose - it is for making
sure that all headers will fit fully into one packet (thus FIT_ONE_PACKET),
returning error from OBEX_ObjectAddHeader() when this is not the case.

Starting the body header streaming adds body header immediately to the outgoing
queue, waiting for more data. Any attempts to OBEX_ObjectAddHeader() different
than those with hi == OBEX_HDR_DATA and OBEX_FL_STREAM_DATA present in flags,
will add new header after currently streamed body and it will be processed
after ending streaming with OBEX_FL_STREAM_DATAEND.  Also in this case data is
memcpy'd, so no reason for any additional write_offset counting.
---
 plugins/filesystem.c    |   16 +++-------------
 plugins/irmc.c          |    6 +-----
 plugins/mas.c           |    4 +---
 plugins/pbap.c          |   19 +++----------------
 plugins/syncevolution.c |    6 +-----
 src/mimetype.h          |    3 +--
 src/obex-priv.h         |    1 -
 src/obex.c              |   15 +++++----------
 8 files changed, 15 insertions(+), 55 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index 7bfe673..b4ff556 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -210,7 +210,7 @@ static int filesystem_close(void *object)
 }
 
 static ssize_t filesystem_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+								uint8_t *hi)
 {
 	ssize_t ret;
 
@@ -218,9 +218,6 @@ static ssize_t filesystem_read(void *object, void *buf, size_t count,
 	if (ret < 0)
 		return -errno;
 
-	if (flags)
-		*flags = 0;
-
 	*hi = OBEX_HDR_BODY;
 
 	return ret;
@@ -502,24 +499,17 @@ ssize_t string_read(void *object, void *buf, size_t count)
 	return len;
 }
 
-static ssize_t folder_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+static ssize_t folder_read(void *object, void *buf, size_t count, uint8_t *hi)
 {
-	if (flags)
-		*flags = 0;
-
 	*hi = OBEX_HDR_BODY;
 	return string_read(object, buf, count);
 }
 
 static ssize_t capability_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+								uint8_t *hi)
 {
 	struct capability_object *obj = object;
 
-	if (flags)
-		*flags = 0;
-
 	*hi = OBEX_HDR_BODY;
 
 	if (obj->buffer)
diff --git a/plugins/irmc.c b/plugins/irmc.c
index 2cf673c..83bb156 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -463,8 +463,7 @@ static int irmc_close(void *object)
 	return 0;
 }
 
-static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi,
-							unsigned int *flags)
+static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi)
 {
 	struct irmc_session *irmc = object;
 	int len;
@@ -473,9 +472,6 @@ static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi,
 	if (!irmc->buffer)
                 return -EAGAIN;
 
-	if (flags)
-		*flags = 0;
-
 	*hi = OBEX_HDR_BODY;
 	len = string_read(irmc->buffer, buf, count);
 	DBG("returning %d bytes", len);
diff --git a/plugins/mas.c b/plugins/mas.c
index a84b8fd..9d65fbc 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -215,13 +215,11 @@ static ssize_t any_write(void *object, const void *buf, size_t count)
 	return count;
 }
 
-static ssize_t any_read(void *obj, void *buf, size_t count,
-				uint8_t *hi, unsigned int *flags)
+static ssize_t any_read(void *obj, void *buf, size_t count, uint8_t *hi)
 {
 	DBG("");
 
 	*hi = OBEX_HDR_BODY;
-	*flags = 0;
 
 	return 0;
 }
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 61e7e42..84661cc 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -967,7 +967,7 @@ static ssize_t array_read(GByteArray *array, void *buf, size_t count)
 }
 
 static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+								uint8_t *hi)
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
@@ -982,22 +982,15 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 	if (pbap->params->maxlistcount == 0) {
 		/* PhoneBookSize */
 		*hi = OBEX_HDR_APPARAM;
-		if (flags)
-			*flags = 0;
 		return array_read(obj->aparams, buf, count);
 	} else if (obj->firstpacket) {
 		/* NewMissedCalls */
 		*hi = OBEX_HDR_APPARAM;
 		obj->firstpacket = FALSE;
-		if (flags)
-			*flags = OBEX_FL_FIT_ONE_PACKET;
 		return array_read(obj->aparams, buf, count);
 	} else {
 		/* Stream data */
 		*hi = OBEX_HDR_BODY;
-		if (flags)
-			*flags = 0;
-
 		len = string_read(obj->buffer, buf, count);
 		if (len == 0 && !obj->lastpart) {
 			/* in case when buffer is empty and we know that more
@@ -1016,7 +1009,7 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 }
 
 static ssize_t vobject_list_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+								uint8_t *hi)
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
@@ -1028,9 +1021,6 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 	if (!pbap->cache.valid)
 		return -EAGAIN;
 
-	if (flags)
-		*flags = 0;
-
 	if (pbap->params->maxlistcount == 0) {
 		*hi = OBEX_HDR_APPARAM;
 		return array_read(obj->aparams, buf, count);
@@ -1041,7 +1031,7 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 }
 
 static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+								uint8_t *hi)
 {
 	struct pbap_object *obj = object;
 
@@ -1050,9 +1040,6 @@ static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
 	if (!obj->buffer)
 		return -EAGAIN;
 
-	if (flags)
-		*flags = 0;
-
 	*hi = OBEX_HDR_BODY;
 	return string_read(obj->buffer, buf, count);
 }
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index a000b36..8041df6 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -331,8 +331,7 @@ done:
 	return 0;
 }
 
-static ssize_t synce_read(void *object, void *buf, size_t count,
-					uint8_t *hi, unsigned int *flags)
+static ssize_t synce_read(void *object, void *buf, size_t count, uint8_t *hi)
 {
 	struct synce_context *context = object;
 	DBusConnection *conn;
@@ -343,9 +342,6 @@ static ssize_t synce_read(void *object, void *buf, size_t count,
 	gboolean authenticate;
 	DBusPendingCall *call;
 
-	if (flags)
-		*flags = 0;
-
 	if (context->buffer) {
 		*hi = OBEX_HDR_BODY;
 		return string_read(context->buffer, buf, count);
diff --git a/src/mimetype.h b/src/mimetype.h
index 5bf741c..8472684 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -33,8 +33,7 @@ struct obex_mime_type_driver {
 	void *(*open) (const char *name, int oflag, mode_t mode,
 			void *driver_data, size_t *size, int *err);
 	int (*close) (void *object);
-	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi,
-							unsigned int *flags);
+	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi);
 	ssize_t (*write) (void *object, const void *buf, size_t count);
 	int (*flush) (void *object);
 	int (*remove) (const char *name);
diff --git a/src/obex-priv.h b/src/obex-priv.h
index 2a22f38..0806a56 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -46,7 +46,6 @@ struct obex_session {
 	obex_object_t *obj;
 	struct obex_mime_type_driver *driver;
 	gboolean finished;
-	uint16_t write_offset;
 };
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
diff --git a/src/obex.c b/src/obex.c
index caba2fb..643b942 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -643,13 +643,10 @@ static int obex_write_stream(struct obex_session *os,
 
 		len = MIN(os->size - os->offset, os->tx_mtu);
 		ptr = os->buf + os->offset;
-		flags = 0;
 		goto add_header;
 	}
 
-	ptr = os->buf + os->write_offset;
-	len = os->driver->read(os->object, ptr, os->tx_mtu - os->write_offset,
-								&hi, &flags);
+	len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
 	if (len < 0) {
 		error("read(): %s (%zd)", strerror(-len), -len);
 		if (len == -EAGAIN)
@@ -662,15 +659,18 @@ static int obex_write_stream(struct obex_session *os,
 		return len;
 	}
 
+	ptr = os->buf;
+
 add_header:
 
 	hd.bs = ptr;
 
 	switch (hi) {
 	case OBEX_HDR_BODY:
-		flags |= len ? OBEX_FL_STREAM_DATA : OBEX_FL_STREAM_DATAEND;
+		flags = len ? OBEX_FL_STREAM_DATA : OBEX_FL_STREAM_DATAEND;
 		break;
 	case OBEX_HDR_APPARAM:
+		flags =  0;
 		break;
 	default:
 		error("read(): unkown header type %u", hi);
@@ -684,11 +684,6 @@ add_header:
 		os->buf = NULL;
 	}
 
-	if (flags & OBEX_FL_FIT_ONE_PACKET)
-		os->write_offset += len;
-	else
-		os->write_offset = 0;
-
 	os->offset += len;
 
 	return 0;
-- 
1.7.4.1


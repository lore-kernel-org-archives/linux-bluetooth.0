Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 5/5] Remove *hi from mime driver read()
Date: Mon, 27 Jun 2011 16:20:55 +0200
Message-Id: <1309184455-29752-6-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
References: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes possibility of setting header type in mime driver read()
function as the functionality of adding different header types is now
supported by get_next_header().
---
 plugins/filesystem.c    |   13 +++----------
 plugins/irmc.c          |    3 +--
 plugins/mas.c           |    4 +---
 plugins/pbap.c          |   14 +++-----------
 plugins/pcsuite.c       |    4 +---
 plugins/syncevolution.c |    6 ++----
 src/mimetype.h          |    2 +-
 src/obex.c              |   27 ++++++++-------------------
 8 files changed, 20 insertions(+), 53 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index b4ff556..3a8fb23 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -209,8 +209,7 @@ static int filesystem_close(void *object)
 	return 0;
 }
 
-static ssize_t filesystem_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+static ssize_t filesystem_read(void *object, void *buf, size_t count)
 {
 	ssize_t ret;
 
@@ -218,8 +217,6 @@ static ssize_t filesystem_read(void *object, void *buf, size_t count,
 	if (ret < 0)
 		return -errno;
 
-	*hi = OBEX_HDR_BODY;
-
 	return ret;
 }
 
@@ -499,19 +496,15 @@ ssize_t string_read(void *object, void *buf, size_t count)
 	return len;
 }
 
-static ssize_t folder_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t folder_read(void *object, void *buf, size_t count)
 {
-	*hi = OBEX_HDR_BODY;
 	return string_read(object, buf, count);
 }
 
-static ssize_t capability_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+static ssize_t capability_read(void *object, void *buf, size_t count)
 {
 	struct capability_object *obj = object;
 
-	*hi = OBEX_HDR_BODY;
-
 	if (obj->buffer)
 		return string_read(obj->buffer, buf, count);
 
diff --git a/plugins/irmc.c b/plugins/irmc.c
index cc0b9db..0fb92be 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -462,7 +462,7 @@ static int irmc_close(void *object)
 	return 0;
 }
 
-static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t irmc_read(void *object, void *buf, size_t count)
 {
 	struct irmc_session *irmc = object;
 	int len;
@@ -471,7 +471,6 @@ static ssize_t irmc_read(void *object, void *buf, size_t count, uint8_t *hi)
 	if (!irmc->buffer)
                 return -EAGAIN;
 
-	*hi = OBEX_HDR_BODY;
 	len = string_read(irmc->buffer, buf, count);
 	DBG("returning %d bytes", len);
 	return len;
diff --git a/plugins/mas.c b/plugins/mas.c
index 08e47a2..0ef8c81 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -222,12 +222,10 @@ static ssize_t any_write(void *object, const void *buf, size_t count)
 	return count;
 }
 
-static ssize_t any_read(void *obj, void *buf, size_t count, uint8_t *hi)
+static ssize_t any_read(void *obj, void *buf, size_t count)
 {
 	DBG("");
 
-	*hi = OBEX_HDR_BODY;
-
 	return 0;
 }
 
diff --git a/plugins/pbap.c b/plugins/pbap.c
index dc43867..9d4691b 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -983,8 +983,7 @@ static ssize_t vobject_pull_get_next_header(void *object, void *buf, size_t mtu,
 	return 0;
 }
 
-static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+static ssize_t vobject_pull_read(void *object, void *buf, size_t count)
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
@@ -999,8 +998,6 @@ static ssize_t vobject_pull_read(void *object, void *buf, size_t count,
 	if (pbap->params->maxlistcount == 0)
 		return -ENOSTR;
 
-	*hi = OBEX_HDR_BODY;
-
 	len = string_read(obj->buffer, buf, count);
 	if (len == 0 && !obj->lastpart) {
 		/* in case when buffer is empty and we know that more
@@ -1035,8 +1032,7 @@ static ssize_t vobject_list_get_next_header(void *object, void *buf, size_t mtu,
 	return 0;
 }
 
-static ssize_t vobject_list_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+static ssize_t vobject_list_read(void *object, void *buf, size_t count)
 {
 	struct pbap_object *obj = object;
 	struct pbap_session *pbap = obj->session;
@@ -1047,13 +1043,10 @@ static ssize_t vobject_list_read(void *object, void *buf, size_t count,
 	if (pbap->params->maxlistcount == 0)
 		return -ENOSTR;
 
-	*hi = OBEX_HDR_BODY;
-
 	return string_read(obj->buffer, buf, count);
 }
 
-static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
-								uint8_t *hi)
+static ssize_t vobject_vcard_read(void *object, void *buf, size_t count)
 {
 	struct pbap_object *obj = object;
 
@@ -1062,7 +1055,6 @@ static ssize_t vobject_vcard_read(void *object, void *buf, size_t count,
 	if (!obj->buffer)
 		return -EAGAIN;
 
-	*hi = OBEX_HDR_BODY;
 	return string_read(obj->buffer, buf, count);
 }
 
diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index 18a3ee7..49f9286 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -417,13 +417,11 @@ static int backup_close(void *object)
 	return 0;
 }
 
-static ssize_t backup_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t backup_read(void *object, void *buf, size_t count)
 {
 	struct backup_object *obj = object;
 	ssize_t ret = 0;
 
-	*hi = OBEX_HDR_BODY;
-
 	if (obj->pending_call) {
 		DBG("cmd = %s, IN WAITING STAGE", obj->cmd);
 		return -EAGAIN;
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index 77c1bd6..7a78669 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -328,7 +328,7 @@ done:
 	return 0;
 }
 
-static ssize_t synce_read(void *object, void *buf, size_t count, uint8_t *hi)
+static ssize_t synce_read(void *object, void *buf, size_t count)
 {
 	struct synce_context *context = object;
 	DBusConnection *conn;
@@ -339,10 +339,8 @@ static ssize_t synce_read(void *object, void *buf, size_t count, uint8_t *hi)
 	gboolean authenticate;
 	DBusPendingCall *call;
 
-	if (context->buffer) {
-		*hi = OBEX_HDR_BODY;
+	if (context->buffer)
 		return string_read(context->buffer, buf, count);
-	}
 
 	conn = obex_dbus_get_connection();
 	if (conn == NULL)
diff --git a/src/mimetype.h b/src/mimetype.h
index 511ab6a..1b1c234 100644
--- a/src/mimetype.h
+++ b/src/mimetype.h
@@ -35,7 +35,7 @@ struct obex_mime_type_driver {
 	int (*close) (void *object);
 	ssize_t (*get_next_header)(void *object, void *buf, size_t mtu,
 								uint8_t *hi);
-	ssize_t (*read) (void *object, void *buf, size_t count, uint8_t *hi);
+	ssize_t (*read) (void *object, void *buf, size_t count);
 	ssize_t (*write) (void *object, const void *buf, size_t count);
 	int (*flush) (void *object);
 	int (*remove) (const char *name);
diff --git a/src/obex.c b/src/obex.c
index 596da6a..b8ad408 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -627,8 +627,6 @@ static int obex_write_stream(struct obex_session *os,
 {
 	obex_headerdata_t hd;
 	ssize_t len;
-	unsigned int flags;
-	uint8_t hi;
 
 	DBG("name=%s type=%s tx_mtu=%d file=%p",
 		os->name ? os->name : "", os->type ? os->type : "",
@@ -640,7 +638,7 @@ static int obex_write_stream(struct obex_session *os,
 	if (os->object == NULL)
 		return -EIO;
 
-	len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
+	len = os->driver->read(os->object, os->buf, os->tx_mtu);
 	if (len < 0) {
 		error("read(): %s (%zd)", strerror(-len), -len);
 		if (len == -EAGAIN)
@@ -662,27 +660,18 @@ static int obex_write_stream(struct obex_session *os,
 		os->streaming = TRUE;
 	}
 
-	hd.bs = os->buf;
-
-	switch (hi) {
-	case OBEX_HDR_BODY:
-		flags = len ? OBEX_FL_STREAM_DATA : OBEX_FL_STREAM_DATAEND;
-		break;
-	case OBEX_HDR_APPARAM:
-		flags =  0;
-		break;
-	default:
-		error("read(): unkown header type %u", hi);
-		return -EIO;
-	}
-
-	OBEX_ObjectAddHeader(obex, obj, hi, hd, len, flags);
-
 	if (len == 0) {
+		hd.bs = NULL;
+		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
+						OBEX_FL_STREAM_DATAEND);
 		g_free(os->buf);
 		os->buf = NULL;
 	}
 
+	hd.bs = os->buf;
+	OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, len,
+						OBEX_FL_STREAM_DATA);
+
 	return 0;
 }
 
-- 
1.7.4.1


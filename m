Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH 3/4] Modify obex_write_stream logic
Date: Tue,  7 Jun 2011 15:10:00 +0200
Message-Id: <1307452201-11057-4-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1307452201-11057-1-git-send-email-lkslawek@gmail.com>
References: <1307452201-11057-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PBAP and MAP profiles present a requirement that in case of multi-packet
responses, application parameter header shall be send in the first
packet.

Starting body streaming in OpenOBEX adds body header immediately and
queues any other added header for sending after the streaming is
finished. In order to get desired behaviour streaming mode should be
started after sending all other headers.

This patch modifies obex_write_stream() to do this. 'stream' argument to
service driver get() function is removed, as it is no longer needed -
streaming is started automatically when getting first portion of body
data.

Also previously when the 'stream' argument was set to false, it was only
possible to add single header, as there was no loop nor appropriate
suspending involved (which is required in order to not finish
non-streaming request immediately).

Now suspending in non-streaming case is achieved by adding OBEX_HDR_EMPTY
with OBEX_FL_SUSPEND flag set, so OpenOBEX will send whatever data is
available and suspend after that.
---
 plugins/ftp.c           |    6 +--
 plugins/ftp.h           |    3 +-
 plugins/irmc.c          |    3 +-
 plugins/mas.c           |    5 +--
 plugins/opp.c           |    6 +--
 plugins/pbap.c          |    7 +---
 plugins/pcsuite.c       |    4 +-
 plugins/syncevolution.c |    5 +--
 src/obex-priv.h         |    1 +
 src/obex.c              |  100 ++++++++++++++++++++++++++++++-----------------
 src/service.h           |    2 +-
 11 files changed, 75 insertions(+), 67 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 79223bf..4962326 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -213,8 +213,7 @@ void *ftp_connect(struct obex_session *os, int *err)
 	return ftp;
 }
 
-int ftp_get(struct obex_session *os, obex_object_t *obj, gboolean *stream,
-							void *user_data)
+int ftp_get(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct ftp_session *ftp = user_data;
 	const char *type = obex_get_type(os);
@@ -229,9 +228,6 @@ int ftp_get(struct obex_session *os, obex_object_t *obj, gboolean *stream,
 	if (ret < 0)
 		return ret;
 
-	if (stream)
-		*stream = TRUE;
-
 	return 0;
 }
 
diff --git a/plugins/ftp.h b/plugins/ftp.h
index 2374125..d929cde 100644
--- a/plugins/ftp.h
+++ b/plugins/ftp.h
@@ -22,8 +22,7 @@
  */
 
 void *ftp_connect(struct obex_session *os, int *err);
-int ftp_get(struct obex_session *os, obex_object_t *obj, gboolean *stream,
-							void *user_data);
+int ftp_get(struct obex_session *os, obex_object_t *obj, void *user_data);
 int ftp_chkput(struct obex_session *os, void *user_data);
 int ftp_put(struct obex_session *os, obex_object_t *obj, void *user_data);
 int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data);
diff --git a/plugins/irmc.c b/plugins/irmc.c
index cd7f386..cc0b9db 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -233,7 +233,7 @@ static void *irmc_connect(struct obex_session *os, int *err)
 }
 
 static int irmc_get(struct obex_session *os, obex_object_t *obj,
-		gboolean *stream, void *user_data)
+							void *user_data)
 {
 	struct irmc_session *irmc = user_data;
 	const char *type = obex_get_type(os);
@@ -244,7 +244,6 @@ static int irmc_get(struct obex_session *os, obex_object_t *obj,
 	DBG("name %s type %s irmc %p", name, type ? type : "NA", irmc);
 
 	path = g_strdup(name);
-	*stream = TRUE;
 
 	ret = obex_get_stream_start(os, path);
 
diff --git a/plugins/mas.c b/plugins/mas.c
index d13625c..08e47a2 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -134,8 +134,7 @@ static void mas_disconnect(struct obex_session *os, void *user_data)
 	mas_clean(mas);
 }
 
-static int mas_get(struct obex_session *os, obex_object_t *obj,
-					gboolean *stream, void *user_data)
+static int mas_get(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	struct mas_session *mas = user_data;
 	const char *type = obex_get_type(os);
@@ -148,8 +147,6 @@ static int mas_get(struct obex_session *os, obex_object_t *obj,
 	if (type == NULL)
 		return -EBADR;
 
-	*stream = FALSE;
-
 	ret = obex_get_stream_start(os, name);
 	if (ret < 0)
 		goto failed;
diff --git a/plugins/opp.c b/plugins/opp.c
index 17c4356..4f0ed08 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -170,8 +170,7 @@ static int opp_put(struct obex_session *os, obex_object_t *obj,
 	return 0;
 }
 
-static int opp_get(struct obex_session *os, obex_object_t *obj,
-			gboolean *stream, void *user_data)
+static int opp_get(struct obex_session *os, obex_object_t *obj, void *user_data)
 {
 	const char *type;
 
@@ -190,9 +189,6 @@ static int opp_get(struct obex_session *os, obex_object_t *obj,
 	} else
 		return -EPERM;
 
-	if (stream)
-		*stream = TRUE;
-
 	return 0;
 }
 
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 0356ae7..a5b0117 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -625,7 +625,7 @@ static void *pbap_connect(struct obex_session *os, int *err)
 }
 
 static int pbap_get(struct obex_session *os, obex_object_t *obj,
-					gboolean *stream, void *user_data)
+							void *user_data)
 {
 	struct pbap_session *pbap = user_data;
 	const char *type = obex_get_type(os);
@@ -662,8 +662,6 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 			path = g_strdup(name);
 		else
 			path = g_build_filename("/", name, NULL);
-
-		*stream = (params->maxlistcount == 0 ? FALSE : TRUE);
 	} else if (strcmp(type, VCARDLISTING_TYPE) == 0) {
 		/* Always relative */
 		if (!name || strlen(name) == 0)
@@ -672,12 +670,9 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 		else
 			/* Current folder + relative path */
 			path = g_build_filename(pbap->folder, name, NULL);
-
-		*stream = (params->maxlistcount == 0 ? FALSE : TRUE);
 	} else if (strcmp(type, VCARDENTRY_TYPE) == 0) {
 		/* File name only */
 		path = g_strdup(name);
-		*stream = TRUE;
 	} else
 		return -EBADR;
 
diff --git a/plugins/pcsuite.c b/plugins/pcsuite.c
index 9cf65c9..318e186 100644
--- a/plugins/pcsuite.c
+++ b/plugins/pcsuite.c
@@ -181,13 +181,13 @@ fail:
 }
 
 static int pcsuite_get(struct obex_session *os, obex_object_t *obj,
-					gboolean *stream, void *user_data)
+							void *user_data)
 {
 	struct pcsuite_session *pcsuite = user_data;
 
 	DBG("%p", pcsuite);
 
-	return ftp_get(os, obj, stream, pcsuite->ftp);
+	return ftp_get(os, obj, pcsuite->ftp);
 }
 
 static int pcsuite_chkput(struct obex_session *os, void *user_data)
diff --git a/plugins/syncevolution.c b/plugins/syncevolution.c
index ea3eb7a..77c1bd6 100644
--- a/plugins/syncevolution.c
+++ b/plugins/syncevolution.c
@@ -250,11 +250,8 @@ static int synce_put(struct obex_session *os, obex_object_t *obj,
 }
 
 static int synce_get(struct obex_session *os, obex_object_t *obj,
-					gboolean *stream, void *user_data)
+							void *user_data)
 {
-	if (stream)
-		*stream = TRUE;
-
 	return obex_get_stream_start(os, NULL);
 }
 
diff --git a/src/obex-priv.h b/src/obex-priv.h
index 0caa0dd..8c722dc 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -45,6 +45,7 @@ struct obex_session {
 	obex_t *obex;
 	obex_object_t *obj;
 	struct obex_mime_type_driver *driver;
+	gboolean streaming;
 };
 
 int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
diff --git a/src/obex.c b/src/obex.c
index e6585ca..659f39b 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -310,6 +310,7 @@ static void os_reset_session(struct obex_session *os)
 	os->pending = 0;
 	os->offset = 0;
 	os->size = OBJECT_SIZE_DELETE;
+	os->streaming = FALSE;
 }
 
 static void obex_session_free(struct obex_session *os)
@@ -638,43 +639,78 @@ static int obex_write_stream(struct obex_session *os,
 	if (os->object == NULL)
 		return -EIO;
 
-	len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
-	if (len < 0) {
-		error("read(): %s (%zd)", strerror(-len), -len);
-		if (len == -EAGAIN)
+	do {
+		len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
+		if (len < 0) {
+			error("read(): %s (%zd)", strerror(-len), -len);
+			if (len == -EAGAIN)
+				return len;
+			else if (len == -ENOSTR)
+				return 0;
+
+			g_free(os->buf);
+			os->buf = NULL;
 			return len;
-		else if (len == -ENOSTR)
+		}
+
+		if (len == 0) {
+			if (os->streaming) {
+				hd.bs = NULL;
+				OBEX_ObjectAddHeader(obex, obj, hi, hd, 0,
+							OBEX_FL_STREAM_DATAEND);
+			}
+			g_free(os->buf);
+			os->buf = NULL;
 			return 0;
+		}
 
-		g_free(os->buf);
-		os->buf = NULL;
-		return len;
-	}
+		if (!os->streaming && hi == OBEX_HDR_BODY) {
+			DBG("Starting streaming");
+			hd.bs = NULL;
+			OBEX_ObjectAddHeader(obex, obj, hi, hd, 0,
+						OBEX_FL_STREAM_START);
+			os->streaming = TRUE;
+		}
 
-	hd.bs = os->buf;
+		hd.bs = os->buf;
 
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
+		switch (hi) {
+		case OBEX_HDR_BODY:
+			flags = OBEX_FL_STREAM_DATA;
+			break;
+		case OBEX_HDR_APPARAM:
+			flags = 0;
+			break;
+		default:
+			error("read(): unkown header type %u", hi);
+			return -EIO;
+		}
 
-	OBEX_ObjectAddHeader(obex, obj, hi, hd, len, flags);
+		OBEX_ObjectAddHeader(obex, obj, hi, hd, len, flags);
 
-	if (len == 0) {
-		g_free(os->buf);
-		os->buf = NULL;
-	}
+	} while (!os->streaming);
 
 	return 0;
 }
 
+static void suspend_stream(struct obex_session *os, obex_t *obex,
+						obex_object_t *obj)
+{
+	obex_headerdata_t hd;
+
+	if (os->streaming) {
+		OBEX_SuspendRequest(obex, obj);
+		return;
+	}
+
+	hd.bs = NULL;
+	OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_EMPTY, hd, 0, OBEX_FL_SUSPEND);
+	/* If there were no headers in the queue after the one with
+	 * the suspend flag set, OpenOBEX would finalize the request.
+	 */
+	OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_EMPTY, hd, 0, 0);
+}
+
 static gboolean handle_async_io(void *object, int flags, int err,
 						void *user_data)
 {
@@ -704,7 +740,6 @@ proceed:
 static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 {
 	obex_headerdata_t hd;
-	gboolean stream;
 	unsigned int hlen;
 	uint8_t hi;
 	int err;
@@ -781,7 +816,7 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		return;
 	}
 
-	err = os->service->get(os, obj, &stream, os->service_data);
+	err = os->service->get(os, obj, os->service_data);
 
 	if (err < 0)
 		goto done;
@@ -800,16 +835,9 @@ static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
 		goto done;
 	}
 
-	if (stream)
-		/* Standard data stream */
-		OBEX_ObjectAddHeader(obex, obj, OBEX_HDR_BODY, hd, 0,
-						OBEX_FL_STREAM_START);
-
-	/* Try to write to stream and suspend the stream immediately
-	 * if no data available to send. */
 	err = obex_write_stream(os, obex, obj);
 	if (err == -EAGAIN) {
-		OBEX_SuspendRequest(obex, obj);
+		suspend_stream(os, obex, obj);
 		os->obj = obj;
 		os->driver->set_io_watch(os->object, handle_async_io, os);
 		return;
diff --git a/src/service.h b/src/service.h
index a844885..4d9d683 100644
--- a/src/service.h
+++ b/src/service.h
@@ -33,7 +33,7 @@ struct obex_service_driver {
 	void *(*connect) (struct obex_session *os, int *err);
 	void (*progress) (struct obex_session *os, void *user_data);
 	int (*get) (struct obex_session *os, obex_object_t *obj,
-			gboolean *stream, void *user_data);
+							void *user_data);
 	int (*put) (struct obex_session *os, obex_object_t *obj,
 			void *user_data);
 	int (*chkput) (struct obex_session *os, void *user_data);
-- 
1.7.4.1


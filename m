Return-Path: <fchevalier@silicom.fr>
Message-ID: <46FCFB4F.7040700@silicom.fr>
Date: Fri, 28 Sep 2007 15:02:07 +0200
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Fabien Chevalier <fchevalier@silicom.fr>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@nokia.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Allows sink.c to know why the stream setup failed
References: <46FCE4A3.4060002@silicom.fr>
In-Reply-To: <46FCE4A3.4060002@silicom.fr>
Content-Type: multipart/mixed;
 boundary="------------080107040902060002020709"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080107040902060002020709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks to Johan review, this is an updated version of the patch.

Fabien



--------------080107040902060002020709
Content-Type: text/x-patch;
 name="avdtp-error-codes-up-the-call-stack.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="avdtp-error-codes-up-the-call-stack.patch"

--- audio/a2dp.c	(.../trunk)	(révision 71)
+++ audio/a2dp.c	(.../branches/20070928_1202)	(révision 71)
@@ -23,12 +23,13 @@
 
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
 
 #include <stdlib.h>
+#include <errno.h>
 
 #include <dbus/dbus.h>
 #include <glib.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
@@ -109,25 +110,35 @@
 
 	avdtp_get_peers(session, NULL, &addr);
 
 	return manager_device_connected(&addr, A2DP_SOURCE_UUID);
 }
 
-static void setup_callback(struct a2dp_stream_cb *cb,
-				struct a2dp_stream_setup *s)
+static gboolean finalize_stream_setup(struct a2dp_stream_setup *s, struct avdtp_error *err)
 {
-	cb->cb(s->session, s->sep, s->stream, cb->user_data);
-}
+	GSList *l;
+
+	for (l = s->cb; l != NULL; l = l->next) {
+		struct a2dp_stream_cb *cb = l->data;
+		
+		cb->cb(s->session, s->sep, s->stream, cb->user_data, err);
+	}
 
-static gboolean finalize_stream_setup(struct a2dp_stream_setup *s)
-{
-	g_slist_foreach(s->cb, (GFunc) setup_callback, s);
 	stream_setup_free(s);
 	return FALSE;
 }
 
+static gboolean finalize_stream_setup_errno(struct a2dp_stream_setup *s, int err)
+{
+	struct avdtp_error avdtp_err;
+
+	avdtp_error_init(&avdtp_err, AVDTP_ERROR_ERRNO, -err);
+
+	return finalize_stream_setup(s, err ? &avdtp_err : NULL);
+}
+
 static struct a2dp_stream_setup *find_setup_by_session(struct avdtp *session)
 {
 	GSList *l;
 
 	for (l = setups; l != NULL; l = l->next) {
 		struct a2dp_stream_setup *setup = l->data;
@@ -321,51 +332,52 @@
 	*caps = g_slist_append(*caps, media_codec);
 
 
 	return TRUE;
 }
 
-static void discovery_complete(struct avdtp *session, GSList *seps, int err,
+static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp_error *err,
 				void *user_data)
 {
 	struct avdtp_local_sep *lsep;
 	struct avdtp_remote_sep *rsep;
 	struct a2dp_stream_setup *setup;
 	GSList *caps = NULL;
+	int posix_err;
 
 	setup = find_setup_by_session(session);
 
 	if (!setup)
 		return;
 
-	if (err < 0 || setup->canceled) {
+	if (err || setup->canceled) {
 		setup->stream = NULL;
-		finalize_stream_setup(setup);
+		finalize_stream_setup(setup, err);
 		return;
 	}
 
 	debug("Discovery complete");
 
 	if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
 				A2DP_CODEC_SBC, &lsep, &rsep) < 0) {
 		error("No matching ACP and INT SEPs found");
-		finalize_stream_setup(setup);
+		finalize_stream_setup_errno(setup, -EINVAL);
 		return;
 	}
 
 	if (!a2dp_select_capabilities(session, rsep, &caps)) {
 		error("Unable to select remote SEP capabilities");
-		finalize_stream_setup(setup);
+		finalize_stream_setup_errno(setup, -EINVAL);
 		return;
 	}
 
-	err = avdtp_set_configuration(session, rsep, lsep, caps,
+	posix_err = avdtp_set_configuration(session, rsep, lsep, caps,
 							&setup->stream);
-	if (err < 0) {
-		error("avdtp_set_configuration: %s", strerror(-err));
-		finalize_stream_setup(setup);
+	if (posix_err < 0) {
+		error("avdtp_set_configuration: %s", strerror(-posix_err));
+		finalize_stream_setup_errno(setup, posix_err);
 	}
 }
 
 static gboolean setconf_ind(struct avdtp *session,
 				struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream,
@@ -487,13 +499,13 @@
 		debug("SBC Source: Set_Configuration_Cfm");
 
 	setup = find_setup_by_session(session);
 
 	if (err) {
 		if (setup)
-			finalize_stream_setup(setup);
+			finalize_stream_setup(setup, err);
 		return;
 	}
 
 	avdtp_stream_add_cb(session, stream, stream_state_changed, a2dp_sep);
 	a2dp_sep->stream = stream;
 
@@ -507,13 +519,13 @@
 
 	ret = avdtp_open(session, stream);
 	if (ret < 0) {
 		error("Error on avdtp_open %s (%d)", strerror(-ret),
 				-ret);
 		setup->stream = NULL;
-		finalize_stream_setup(setup);
+		finalize_stream_setup_errno(setup, ret);
 	}
 }
 
 static gboolean getconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				uint8_t *err, void *user_data)
 {
@@ -554,12 +566,13 @@
 static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_stream_setup *setup;
+	int posix_err;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		debug("SBC Sink: Open_Cfm");
 	else
 		debug("SBC Source: Open_Cfm");
 
@@ -573,25 +586,28 @@
 		stream_setup_free(setup);
 		return;
 	}
 
 	if (err) {
 		setup->stream = NULL;
-		goto finalize;
+		finalize_stream_setup(setup, err);
+		return;
 	}
 
 	if (setup->start) {
-		if (avdtp_start(session, stream) == 0)
+		posix_err = avdtp_start(session, stream);		
+		if (posix_err == 0)
 			return;
 
 		error("avdtp_start failed");
-		setup->stream = NULL;
+		setup->stream = NULL;		
 	}
+	else
+		posix_err = 0;
 
-finalize:
-	finalize_stream_setup(setup);
+	finalize_stream_setup_errno(setup, -posix_err);
 }
 
 static gboolean suspend_timeout(struct a2dp_sep *sep)
 {
 	if (avdtp_suspend(sep->session, sep->stream) == 0)
 		sep->suspending = TRUE;
@@ -643,16 +659,18 @@
 		if (!err)
 			avdtp_close(session, stream);
 		stream_setup_free(setup);
 		return;
 	}
 
-	if (err)
+	if (err) {
 		setup->stream = NULL;
-
-	finalize_stream_setup(setup);
+		finalize_stream_setup(setup, err);
+	}
+	else
+		finalize_stream_setup_errno(setup, 0);
 }
 
 static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data)
 {
@@ -668,12 +686,13 @@
 static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_stream_setup *setup;
+	int posix_err;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		debug("SBC Sink: Suspend_Cfm");
 	else
 		debug("SBC Source: Suspend_Cfm");
 
@@ -681,19 +700,20 @@
 
 	setup = find_setup_by_session(session);
 	if (!setup)
 		return;
 
 	if (err) {
-		finalize_stream_setup(setup);
+		finalize_stream_setup(setup, err);
 		return;
 	}
 
 	if (setup->start) {
-		if (avdtp_start(session, stream) < 0)
-			finalize_stream_setup(setup);
+		posix_err = avdtp_start(session, stream);
+		if (posix_err < 0)
+			finalize_stream_setup_errno(setup, posix_err);
 	}
 }
 
 static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data)
@@ -711,12 +731,13 @@
 static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_stream_setup *setup;
+	int posix_err;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		debug("SBC Sink: Close_Cfm");
 	else
 		debug("SBC Source: Close_Cfm");
 
@@ -728,25 +749,28 @@
 		stream_setup_free(setup);
 		return;
 	}
 
 	if (err) {
 		setup->stream = NULL;
-		goto finalize;
+		finalize_stream_setup(setup, err);
+		return;
 	}
 
 	if (setup->start) {
-		if (avdtp_discover(session, discovery_complete, setup) == 0)
+		posix_err = avdtp_discover(session, discovery_complete, setup);
+		if (posix_err == 0)
 			return;
 
 		error("avdtp_discover failed");
 		setup->stream = NULL;
 	}
+	else
+		posix_err = 0;
 
-finalize:
-	finalize_stream_setup(setup);
+	finalize_stream_setup_errno(setup, -posix_err);
 }
 
 static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream, uint8_t *err,
 				void *user_data)
 {
@@ -789,12 +813,13 @@
 static void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_stream_setup *setup;
+	int posix_err;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		debug("SBC Sink: ReConfigure_Cfm");
 	else
 		debug("SBC Source: ReConfigure_Cfm");
 
@@ -808,25 +833,28 @@
 		stream_setup_free(setup);
 		return;
 	}
 
 	if (err) {
 		setup->stream = NULL;
-		goto finalize;
+		finalize_stream_setup(setup, err);
+		return;
 	}
 
 	if (setup->start) {
-		if (avdtp_start(session, stream) == 0)
+		posix_err = avdtp_start(session, stream);		
+		if (posix_err == 0)
 			return;
 
 		error("avdtp_start failed");
 		setup->stream = NULL;
 	}
+	else
+		posix_err = 0;
 
-finalize:
-	finalize_stream_setup(setup);
+	finalize_stream_setup_errno(setup, -posix_err);
 }
 
 static struct avdtp_sep_cfm cfm = {
 	.set_configuration	= setconf_cfm,
 	.get_configuration	= getconf_cfm,
 	.open			= open_cfm,
Index: audio/a2dp.h
===================================================================
--- audio/a2dp.h	(.../trunk)	(révision 71)
+++ audio/a2dp.h	(.../branches/20070928_1202)	(révision 71)
@@ -78,13 +78,14 @@
 #endif
 
 struct a2dp_sep;
 
 typedef void (*a2dp_stream_cb_t) (struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream,
-					void *user_data);
+					void *user_data,
+					struct avdtp_error *err);
 
 int a2dp_init(DBusConnection *conn, int sources, int sinks);
 void a2dp_exit(void);
 
 unsigned int a2dp_source_request_stream(struct avdtp *session,
 					gboolean start, a2dp_stream_cb_t cb,
Index: audio/sink.c
===================================================================
--- audio/sink.c	(.../trunk)	(révision 71)
+++ audio/sink.c	(.../branches/20070928_1202)	(révision 71)
@@ -132,13 +132,13 @@
 
 	sink->state = new_state;
 }
 
 static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream,
-					void *user_data)
+					void *user_data, struct avdtp_error *err)
 {
 	struct sink *sink = user_data;
 	struct pending_request *pending;
 
 	pending = sink->connect;
 	sink->connect = NULL;
@@ -150,13 +150,13 @@
 		debug("Stream successfully created");
 	}
 	else {
 		err_failed(pending->conn, pending->msg, "Stream setup failed");
 		avdtp_unref(sink->session);
 		sink->session = NULL;
-		debug("Stream setup failed");
+		debug("Stream setup failed : %s", avdtp_strerror(err));
 	}
 
 	pending_request_free(pending);
 }
 
 static DBusHandlerResult sink_connect(DBusConnection *conn,
Index: audio/avdtp.c
===================================================================
--- audio/avdtp.c	(.../trunk)	(révision 71)
+++ audio/avdtp.c	(.../branches/20070928_1202)	(révision 71)
@@ -74,17 +74,12 @@
 
 #define REQ_TIMEOUT 4000
 #define DISCONNECT_TIMEOUT 5000
 #define STREAM_TIMEOUT 20000
 
 typedef enum {
-	AVDTP_ERROR_ERRNO,
-	AVDTP_ERROR_ERROR_CODE
-} avdtp_error_type_t;
-
-typedef enum {
 	AVDTP_SESSION_STATE_DISCONNECTED,
 	AVDTP_SESSION_STATE_CONNECTING,
 	AVDTP_SESSION_STATE_CONNECTED
 } avdtp_session_state_t;
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -359,20 +354,12 @@
 
 	guint dc_timer;
 
 	DBusPendingCall *pending_auth;
 };
 
-struct avdtp_error {
-	avdtp_error_type_t type;
-	union {
-		uint8_t error_code;
-		int posix_errno;
-	} err;
-};
-
 static uint8_t free_seid = 1;
 static GSList *local_seps = NULL;
 
 static GIOChannel *avdtp_server = NULL;
 
 static GSList *sessions = NULL;
@@ -496,13 +483,13 @@
 		remove_disconnect_timer(session);
 
 	session->dc_timer = g_timeout_add(DISCONNECT_TIMEOUT,
 						disconnect_timeout, session);
 }
 
-static void avdtp_error_init(struct avdtp_error *err, uint8_t type, int id)
+void avdtp_error_init(struct avdtp_error *err, uint8_t type, int id)
 {
 	err->type = type;
 	switch (type) {
 	case AVDTP_ERROR_ERRNO:
 		err->err.posix_errno = id;
 		break;
@@ -695,16 +682,21 @@
 		break;
 	}
 }
 
 static void finalize_discovery(struct avdtp *session, int err)
 {
+	struct avdtp_error avdtp_err;
+
+	avdtp_error_init(&avdtp_err, AVDTP_ERROR_ERRNO, -err);
+
 	if (!session->discov_cb)
 		return;
 
-	session->discov_cb(session, session->seps, err,
+	session->discov_cb(session, session->seps,
+				err ? &avdtp_err : NULL,
 				session->user_data);
 
 	session->discov_cb = NULL;
 	session->user_data = NULL;
 }
 
--- audio/avdtp.h	(.../trunk)	(révision 71)
+++ audio/avdtp.h	(.../branches/20070928_1202)	(révision 71)
@@ -18,17 +18,28 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
 
+typedef enum {
+	AVDTP_ERROR_ERRNO,
+	AVDTP_ERROR_ERROR_CODE
+} avdtp_error_type_t;
+
 struct avdtp;
 struct avdtp_stream;
 struct avdtp_local_sep;
 struct avdtp_remote_sep;
-struct avdtp_error;
+struct avdtp_error {
+	avdtp_error_type_t type;
+	union {
+		uint8_t error_code;
+		int posix_errno;
+	} err;
+};
 
 /* SEP capability categories */
 #define AVDTP_MEDIA_TRANSPORT			0x01
 #define AVDTP_REPORTING				0x02
 #define AVDTP_RECOVERY				0x03
 #define AVDTP_CONTENT_PROTECTION		0x04
@@ -174,13 +185,13 @@
 	gboolean (*reconfigure) (struct avdtp *session,
 					struct avdtp_local_sep *lsep,
 					uint8_t *err, void *user_data);
 };
 
 typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
-					int err, void *user_data);
+					struct avdtp_error *err, void *user_data);
 
 struct avdtp *avdtp_get(bdaddr_t *src, bdaddr_t *dst);
 
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
 
@@ -237,13 +248,15 @@
 			struct avdtp_remote_sep **rsep);
 
 int avdtp_unregister_sep(struct avdtp_local_sep *sep);
 
 avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
 
+void avdtp_error_init(struct avdtp_error *err, uint8_t type, int id);
 const char *avdtp_strerror(struct avdtp_error *err);
+int avdtp_error_code(struct avdtp_error *err);
 
 void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst);
 
 int avdtp_init(void);
 void avdtp_exit(void);



--------------080107040902060002020709
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fchevalier.vcf"

YmVnaW46dmNhcmQNCmZuOkZhYmllbiBDSEVWQUxJRVINCm46Q0hFVkFMSUVSO0ZhYmllbg0K
b3JnOlNJTElDT00NCmFkcjo7OzQgcnVlIGRlIEpvdWFuZXQ7IFJFTk5FUyBBVEFMQU5URTs7
MzU3MDA7RlJBTkNFDQplbWFpbDtpbnRlcm5ldDpmY2hldmFsaWVyQHNpbGljb20uZnINCnRp
dGxlOlNvZnR3YXJlICYgU3R1ZGllcyBFbmdpbmVlcg0KdGVsO3dvcms6KzMzICgwKSAyIDk5
IDg0IDE3IDE3DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------080107040902060002020709--

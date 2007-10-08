Return-Path: <fabchevalier@free.fr>
Message-ID: <470A39B1.5020405@free.fr>
Date: Mon, 08 Oct 2007 16:07:45 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@nokia.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Brad Midgley <bmidgley@xmission.com>, luiz.dentz@gmail.com
CC: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [PATCH] a2dp cross connect issues
Content-Type: multipart/mixed;
 boundary="------------060800080004010206040006"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060800080004010206040006
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Johan, Luiz, Brad, Marcel,

Here is finally the patch that fixes the a2dp cross connect issues.

I appended a log that exposes the behaviour of the patch.

Happy reviewing !!

Cheers,

Fabien

Oct  8 15:58:56 tannat audio[12402]: stream creation in progress
Oct  8 15:58:57 tannat audio[12402]: connect(): Connection refused (111)
Oct  8 15:58:57 tannat audio[12402]: avdtp_unref(0x8066eb0): ref=2
Oct  8 15:58:57 tannat audio[12402]: connect:connect XCASE detected
Oct  8 15:58:57 tannat audio[12402]: avdtp_unref(0x8066eb0): ref=1
Oct  8 15:58:57 tannat audio[12402]: avdtp_unref(0x8066eb0): ref=0
Oct  8 15:58:57 tannat audio[12402]: avdtp_unref(0x8066eb0): freeing 
session and removing from list
Oct  8 15:58:57 tannat audio[12402]: AVDTP: incoming connect from 
00:18:13:E7:6D:4F
Oct  8 15:58:57 tannat audio[12402]: Requesting authorization for device 
00:18:13:E7:6D:4F, UUID 0000110D-0000-1000-8000-00805F9B34FB
Oct  8 15:58:57 tannat audio[12402]: session_cb
Oct  8 15:58:57 tannat audio[12402]: Received DISCOVER_CMD
Oct  8 15:58:57 tannat audio[12402]: session_cb
Oct  8 15:58:57 tannat audio[12402]: Received  GET_CAPABILITIES_CMD
Oct  8 15:58:57 tannat audio[12402]: SBC Source: Get_Capability_Ind
Oct  8 15:58:57 tannat audio[12402]: session_cb
Oct  8 15:58:57 tannat audio[12402]: Received SET_CONFIGURATION_CMD
Oct  8 15:58:57 tannat audio[12402]: SBC Source: Set_Configuration_Ind
Oct  8 15:58:57 tannat audio[12402]: avdtp_ref(0x8066eb0): ref=2
Oct  8 15:58:57 tannat audio[12402]: stream state changed: IDLE -> 
CONFIGURED
Oct  8 15:58:57 tannat audio[12402]: session_cb
Oct  8 15:58:57 tannat audio[12402]: Received OPEN_CMD
Oct  8 15:58:57 tannat audio[12402]: SBC Source: Open_Ind
Oct  8 15:58:57 tannat audio[12402]: stream state changed: CONFIGURED -> 
OPEN
Oct  8 15:58:57 tannat audio[12402]: AVDTP: incoming connect from 
00:18:13:E7:6D:4F
Oct  8 15:58:57 tannat audio[12402]: session_cb
Oct  8 15:58:57 tannat audio[12402]: Received START_CMD
Oct  8 15:58:57 tannat audio[12402]: SBC Source: Start_Ind
Oct  8 15:58:57 tannat audio[12402]: avdtp_ref(0x8066eb0): ref=3
Oct  8 15:58:57 tannat audio[12402]: stream state changed: OPEN -> STREAMING
Oct  8 15:58:59 tannat audio[12402]: Stream successfully created, after 
XCASE connect:connect


--------------060800080004010206040006
Content-Type: text/x-patch;
 name="a2dp-cross-connect-fix.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="a2dp-cross-connect-fix.patch"

Index: audio/sink.c
===================================================================
--- audio/sink.c	(.../tags/20071008_1310)	(révision 113)
+++ audio/sink.c	(.../branches/20071008_1310)	(révision 113)
@@ -40,12 +40,14 @@
 #include "avdtp.h"
 #include "device.h"
 #include "a2dp.h"
 #include "error.h"
 #include "sink.h"
 
+#define STREAM_SETUP_RETRY_TIMER 2000
+
 struct pending_request {
 	DBusConnection *conn;
 	DBusMessage *msg;
 	unsigned int id;
 };
 
@@ -130,35 +132,63 @@
 		break;
 	}
 
 	sink->state = new_state;
 }
 
+static gboolean stream_setup_retry(gpointer user_data)
+{
+	struct sink *sink = user_data;
+	struct pending_request *pending = sink->connect;
+
+	if (sink->state >= AVDTP_STATE_OPEN) {
+		DBusMessage *reply;
+		debug("Stream successfully created, after XCASE connect:connect");
+		reply = dbus_message_new_method_return(pending->msg);
+		send_message_and_unref(pending->conn, reply);
+	}
+	else {
+		debug("Stream setup failed, after XCASE connect:connect");
+		err_failed(pending->conn, pending->msg, "Stream setup failed");
+	}
+	sink->connect = NULL;
+	pending_request_free(pending);
+	return FALSE;
+}
+
 static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream,
 					void *user_data, struct avdtp_error *err)
 {
 	struct sink *sink = user_data;
 	struct pending_request *pending;
 
 	pending = sink->connect;
-	sink->connect = NULL;
 
 	if (stream) {
 		DBusMessage *reply;
+		sink->connect = NULL;
 		reply = dbus_message_new_method_return(pending->msg);
 		send_message_and_unref(pending->conn, reply);
+		pending_request_free(pending);
 		debug("Stream successfully created");
 	} else {
-		err_failed(pending->conn, pending->msg, "Stream setup failed");
 		avdtp_unref(sink->session);
 		sink->session = NULL;
-		debug("Stream setup failed : %s", avdtp_strerror(err));
+		if (avdtp_error_type(err) == AVDTP_ERROR_ERRNO
+			&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
+			debug("connect:connect XCASE detected");			
+			g_timeout_add(STREAM_SETUP_RETRY_TIMER,
+				stream_setup_retry, sink);
+		} else {
+			sink->connect = NULL;
+			err_failed(pending->conn, pending->msg, "Stream setup failed");
+			pending_request_free(pending);
+			debug("Stream setup failed : %s", avdtp_strerror(err));
+		}
 	}
-
-	pending_request_free(pending);
 }
 
 static DBusHandlerResult sink_connect(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct device *dev = data;
Index: audio/avdtp.c
===================================================================
--- audio/avdtp.c	(.../tags/20071008_1310)	(révision 113)
+++ audio/avdtp.c	(.../branches/20071008_1310)	(révision 113)
@@ -496,12 +496,29 @@
 	case AVDTP_ERROR_ERROR_CODE:
 		err->err.error_code = id;
 		break;
 	}
 }
 
+avdtp_error_type_t avdtp_error_type(struct avdtp_error *err)
+{
+	return err->type;
+}
+
+int avdtp_error_error_code(struct avdtp_error *err)
+{
+	g_assert(err->type == AVDTP_ERROR_ERROR_CODE);
+	return err->err.error_code;
+}
+
+int avdtp_error_posix_errno(struct avdtp_error *err)
+{
+	g_assert(err->type == AVDTP_ERROR_ERRNO);
+	return err->err.posix_errno;
+}
+
 static struct avdtp_stream *find_stream_by_rseid(struct avdtp *session,
 							uint8_t rseid)
 {
 	GSList *l;
 
 	for (l = session->streams; l != NULL; l = g_slist_next(l)) {
Index: audio/avdtp.h
===================================================================
--- audio/avdtp.h	(.../tags/20071008_1310)	(révision 113)
+++ audio/avdtp.h	(.../branches/20071008_1310)	(révision 113)
@@ -250,13 +250,15 @@
 int avdtp_unregister_sep(struct avdtp_local_sep *sep);
 
 avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep);
 
 void avdtp_error_init(struct avdtp_error *err, uint8_t type, int id);
 const char *avdtp_strerror(struct avdtp_error *err);
-int avdtp_error_code(struct avdtp_error *err);
+avdtp_error_type_t avdtp_error_type(struct avdtp_error *err);
+int avdtp_error_error_code(struct avdtp_error *err);
+int avdtp_error_posix_errno(struct avdtp_error *err);
 
 void avdtp_get_peers(struct avdtp *session, bdaddr_t *src, bdaddr_t *dst);
 
 int avdtp_init(void);
 void avdtp_exit(void);
 

--------------060800080004010206040006--

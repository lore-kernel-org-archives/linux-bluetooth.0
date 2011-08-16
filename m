Return-Path: <cyrus@holtmann.org>
From: Prasad Bhat <prasadbhat22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] Implementation of video-sink for VDP
Date: Tue, 16 Aug 2011 19:13:54 +0530
Message-Id: <1313502238-7581-2-git-send-email-prasadbhat22@gmail.com>
In-Reply-To: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
References: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am        |    1 +
 audio/video-sink.c |  677 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/video-sink.h |   44 ++++
 3 files changed, 722 insertions(+), 0 deletions(-)
 create mode 100644 audio/video-sink.c
 create mode 100644 audio/video-sink.h

diff --git a/Makefile.am b/Makefile.am
index f1c9003..87b32a4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -142,6 +142,7 @@ builtin_sources += audio/main.c \
 			audio/sink.h audio/sink.c \
 			audio/a2dp.h audio/a2dp.c \
 			audio/vdp.h audio/vdp.c \
+			audio/video-sink.h audio/video-sink.c \
 			audio/avdtp.h audio/avdtp.c \
 			audio/ipc.h audio/ipc.c \
 			audio/unix.h audio/unix.c \
diff --git a/audio/video-sink.c b/audio/video-sink.c
new file mode 100644
index 0000000..a879c0c
--- /dev/null
+++ b/audio/video-sink.c
@@ -0,0 +1,677 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus.h>
+#include "device.h"
+#include "media.h"
+#include "log.h"
+#include "avdtp.h"
+#include "vdp.h"
+#include "error.h"
+#include "video-sink.h"
+#include "dbus-common.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
+#define STREAM_SETUP_RETRY_TIMER 2
+
+struct pending_request {
+	DBusConnection *conn;
+	DBusMessage *msg;
+	unsigned int id;
+};
+
+struct video_sink {
+	struct audio_device *dev;
+	struct avdtp *session;
+	struct avdtp_stream *stream;
+	unsigned int cb_id;
+	guint retry_id;
+	avdtp_session_state_t session_state;
+	avdtp_state_t stream_state;
+	video_sink_state_t state;
+	struct pending_request *connect;
+	struct pending_request *disconnect;
+	DBusConnection *conn;
+};
+
+struct video_sink_state_callback {
+	video_sink_state_cb cb;
+	void *user_data;
+	unsigned int id;
+};
+
+static GSList *sink_callbacks = NULL;
+
+static unsigned int avdtp_callback_id = 0;
+
+static char *str_state[] = {
+	"VIDEO_SINK_STATE_DISCONNECTED",
+	"VIDEO_SINK_STATE_CONNECTING",
+	"VIDEO_SINK_STATE_CONNECTED",
+	"VIDEO_SINK_STATE_PLAYING",
+};
+
+static const char *state2str(video_sink_state_t state)
+{
+	switch (state) {
+	case VIDEO_SINK_STATE_DISCONNECTED:
+		return "disconnected";
+	case VIDEO_SINK_STATE_CONNECTING:
+		return "connecting";
+	case VIDEO_SINK_STATE_CONNECTED:
+		return "connected";
+	case VIDEO_SINK_STATE_PLAYING:
+		return "playing";
+	default:
+		error("Invalid sink state %d", state);
+		return NULL;
+	}
+}
+
+static void sink_set_state(struct audio_device *dev, video_sink_state_t new_state)
+{
+	struct video_sink *sink = dev->video_sink;
+	const char *state_str;
+	video_sink_state_t old_state = sink->state;
+	GSList *l;
+
+	sink->state = new_state;
+
+	state_str = state2str(new_state);
+	if (state_str)
+		emit_property_changed(dev->conn, dev->path,
+					VIDEO_SINK_INTERFACE, "State",
+					DBUS_TYPE_STRING, &state_str);
+
+	DBG("State changed %s: %s -> %s", dev->path, str_state[old_state],
+		str_state[new_state]);
+
+	for (l = sink_callbacks; l != NULL; l = l->next) {
+		struct video_sink_state_callback *cb = l->data;
+		cb->cb(dev, old_state, new_state, cb->user_data);
+	}
+}
+
+static void avdtp_state_callback(struct audio_device *dev,
+					struct avdtp *session,
+					avdtp_session_state_t old_state,
+					avdtp_session_state_t new_state,
+					void *user_data)
+{
+	struct video_sink *sink = dev->video_sink;
+
+	if (sink == NULL)
+		return;
+
+	switch (new_state) {
+	case AVDTP_SESSION_STATE_DISCONNECTED:
+		if (sink->state != VIDEO_SINK_STATE_CONNECTING) {
+			gboolean value = FALSE;
+			g_dbus_emit_signal(dev->conn, dev->path,
+					VIDEO_SINK_INTERFACE, "Disconnected",
+					DBUS_TYPE_INVALID);
+			emit_property_changed(dev->conn, dev->path,
+					VIDEO_SINK_INTERFACE, "Connected",
+					DBUS_TYPE_BOOLEAN, &value);
+		}
+		sink_set_state(dev, VIDEO_SINK_STATE_DISCONNECTED);
+		break;
+	case AVDTP_SESSION_STATE_CONNECTING:
+		sink_set_state(dev, VIDEO_SINK_STATE_CONNECTING);
+		break;
+	case AVDTP_SESSION_STATE_CONNECTED:
+		break;
+	}
+
+	sink->session_state = new_state;
+}
+
+static void pending_request_free(struct audio_device *dev,
+					struct pending_request *pending)
+{
+	if (pending->conn)
+		dbus_connection_unref(pending->conn);
+	if (pending->msg)
+		dbus_message_unref(pending->msg);
+	if (pending->id)
+		vdp_cancel(dev, pending->id);
+
+	g_free(pending);
+}
+
+static void stream_state_changed(struct avdtp_stream *stream,
+					avdtp_state_t old_state,
+					avdtp_state_t new_state,
+					struct avdtp_error *err,
+					void *user_data)
+{
+	struct audio_device *dev = user_data;
+	struct video_sink *sink = dev->video_sink;
+	gboolean value;
+
+	if (err)
+		return;
+
+	switch (new_state) {
+	case AVDTP_STATE_IDLE:
+		if (sink->disconnect) {
+			DBusMessage *reply;
+			struct pending_request *p;
+
+			p = sink->disconnect;
+			sink->disconnect = NULL;
+
+			reply = dbus_message_new_method_return(p->msg);
+			g_dbus_send_message(p->conn, reply);
+			pending_request_free(dev, p);
+		}
+
+		if (sink->session) {
+			avdtp_unref(sink->session);
+			sink->session = NULL;
+		}
+		sink->stream = NULL;
+		sink->cb_id = 0;
+		break;
+	case AVDTP_STATE_OPEN:
+		if (old_state == AVDTP_STATE_CONFIGURED &&
+				sink->state == VIDEO_SINK_STATE_CONNECTING) {
+			value = TRUE;
+			g_dbus_emit_signal(dev->conn, dev->path,
+						VIDEO_SINK_INTERFACE,
+						"Connected",
+						DBUS_TYPE_INVALID);
+			emit_property_changed(dev->conn, dev->path,
+						VIDEO_SINK_INTERFACE,
+						"Connected",
+						DBUS_TYPE_BOOLEAN, &value);
+		} else if (old_state == AVDTP_STATE_STREAMING) {
+			value = FALSE;
+			g_dbus_emit_signal(dev->conn, dev->path,
+						VIDEO_SINK_INTERFACE,
+						"Stopped",
+						DBUS_TYPE_INVALID);
+			emit_property_changed(dev->conn, dev->path,
+						VIDEO_SINK_INTERFACE,
+						"Playing",
+						DBUS_TYPE_BOOLEAN, &value);
+		}
+		sink_set_state(dev, VIDEO_SINK_STATE_CONNECTED);
+		break;
+	case AVDTP_STATE_STREAMING:
+		value = TRUE;
+		g_dbus_emit_signal(dev->conn, dev->path, VIDEO_SINK_INTERFACE,
+					"Playing", DBUS_TYPE_INVALID);
+		emit_property_changed(dev->conn, dev->path,
+					VIDEO_SINK_INTERFACE, "Playing",
+					DBUS_TYPE_BOOLEAN, &value);
+		sink_set_state(dev, VIDEO_SINK_STATE_PLAYING);
+		break;
+	case AVDTP_STATE_CONFIGURED:
+	case AVDTP_STATE_CLOSING:
+	case AVDTP_STATE_ABORTING:
+	default:
+		break;
+	}
+
+	sink->stream_state = new_state;
+}
+
+static void error_failed(DBusConnection *conn, DBusMessage *msg,
+							const char *desc)
+{
+	DBusMessage *reply = btd_error_failed(msg, desc);
+	g_dbus_send_message(conn, reply);
+}
+
+
+
+static gboolean stream_setup_retry(gpointer user_data)
+{
+	struct video_sink *sink = user_data;
+	struct pending_request *pending = sink->connect;
+
+	sink->retry_id = 0;
+
+	if (sink->stream_state >= AVDTP_STATE_OPEN) {
+		DBG("Stream successfully created, after XCASE connect:connect");
+		if (pending->msg) {
+			DBusMessage *reply;
+			reply = dbus_message_new_method_return(pending->msg);
+			g_dbus_send_message(pending->conn, reply);
+		}
+	} else {
+		DBG("Stream setup failed, after XCASE connect:connect");
+		if (pending->msg)
+			error_failed(pending->conn, pending->msg, "Stream setup failed");
+	}
+
+	sink->connect = NULL;
+	pending_request_free(sink->dev, pending);
+
+	return FALSE;
+}
+
+
+static void stream_setup_complete(struct avdtp *session, struct vdp_sep *sep,
+					struct avdtp_stream *stream,
+					struct avdtp_error *err, void *user_data)
+{
+	struct video_sink *sink = user_data;
+	struct pending_request *pending;
+
+	pending = sink->connect;
+
+	pending->id = 0;
+
+	if (stream) {
+		DBG("Stream successfully created");
+
+		if (pending->msg) {
+			DBusMessage *reply;
+			reply = dbus_message_new_method_return(pending->msg);
+			g_dbus_send_message(pending->conn, reply);
+		}
+
+		sink->connect = NULL;
+		pending_request_free(sink->dev, pending);
+
+		return;
+	}
+
+	avdtp_unref(sink->session);
+	sink->session = NULL;
+	if (avdtp_error_category(err) == AVDTP_ERRNO
+			&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
+		DBG("connect:connect XCASE detected");
+		sink->retry_id = g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
+							stream_setup_retry,
+							sink);
+	} else {
+		if (pending->msg)
+			error_failed(pending->conn, pending->msg, "Stream setup failed");
+		sink->connect = NULL;
+		pending_request_free(sink->dev, pending);
+		DBG("Stream setup failed : %s", avdtp_strerror(err));
+	}
+}
+
+static void select_complete(struct avdtp *session, struct vdp_sep *sep,
+			GSList *caps, void *user_data)
+{
+	struct video_sink *sink = user_data;
+	struct pending_request *pending;
+	int id;
+
+	pending = sink->connect;
+	pending->id = 0;
+
+	id = vdp_config(session, sep, stream_setup_complete, caps, sink);
+	if (id == 0){
+		DBG("id = 0");
+		goto failed;
+	}
+
+	pending->id = id;
+	return;
+
+failed:
+	if (pending->msg)
+		error_failed(pending->conn, pending->msg, "Stream setup failed");
+	pending_request_free(sink->dev, pending);
+	sink->connect = NULL;
+	avdtp_unref(sink->session);
+	sink->session = NULL;
+}
+
+static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp_error *err,
+				void *user_data)
+{
+	struct video_sink *sink = user_data;
+	struct pending_request *pending;
+	int id;
+
+	if (!sink->connect) {
+		avdtp_unref(sink->session);
+		sink->session = NULL;
+		return;
+	}
+
+	pending = sink->connect;
+
+	if (err) {
+		avdtp_unref(sink->session);
+		sink->session = NULL;
+		if (avdtp_error_category(err) == AVDTP_ERRNO
+				&& avdtp_error_posix_errno(err) != EHOSTDOWN) {
+			DBG("connect:connect XCASE detected");
+			sink->retry_id =
+				g_timeout_add_seconds(STREAM_SETUP_RETRY_TIMER,
+							stream_setup_retry,
+							sink);
+		} else
+			goto failed;
+		return;
+	}
+
+	DBG("Discovery complete");
+
+	id = vdp_select_capabilities(sink->session, AVDTP_SEP_TYPE_SINK, NULL,
+						select_complete, sink);
+	if (id == 0)
+		goto failed;
+
+	pending->id = id;
+	return;
+
+failed:
+	if (pending->msg)
+		error_failed(pending->conn, pending->msg, "Stream setup failed");
+	pending_request_free(sink->dev, pending);
+	sink->connect = NULL;
+	avdtp_unref(sink->session);
+	sink->session = NULL;
+}
+
+gboolean video_sink_setup_stream(struct video_sink *sink, struct avdtp *session)
+{
+	if (sink->connect || sink->disconnect)
+		return FALSE;
+
+	if (session && !sink->session)
+		sink->session = avdtp_ref(session);
+
+	if (!sink->session)
+		return FALSE;
+
+	avdtp_set_auto_disconnect(sink->session, FALSE);
+
+	if (avdtp_discover(sink->session, discovery_complete, sink) < 0)
+		return FALSE;
+
+	sink->connect = g_new0(struct pending_request, 1);
+
+	return TRUE;
+}
+
+static DBusMessage *sink_connect(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct audio_device *dev = data;
+	struct video_sink *sink = dev->video_sink;
+	struct pending_request *pending;
+	DBG("Hi sink connect called");
+	if (!conn)
+		DBG("No DBus connection found");
+      
+	if (!data){
+		DBG("no data as dev");
+		return NULL;
+	  
+	}
+	
+	if (!sink->session)
+		sink->session = avdtp_get(&dev->src, &dev->dst);
+
+	if (!sink->session)
+		return btd_error_failed(msg, "Unable to get a session");
+
+	if (sink->connect || sink->disconnect)
+		return btd_error_busy(msg);
+
+	if (sink->stream_state >= AVDTP_STATE_OPEN)
+		return btd_error_already_connected(msg);
+	
+	if (!video_sink_setup_stream(sink, NULL))
+		return btd_error_failed(msg, "Failed to create a stream");
+	
+	dev->auto_connect = FALSE;
+
+	pending = sink->connect;
+
+	pending->conn = dbus_connection_ref(conn);
+	pending->msg = dbus_message_ref(msg);
+
+	DBG("stream creation in progress");
+
+	return NULL;
+}
+
+static DBusMessage *sink_disconnect(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct video_sink *sink = device->video_sink;
+	struct pending_request *pending;
+	int err;
+
+	if (!sink->session)
+		return btd_error_not_connected(msg);
+
+	if (sink->connect || sink->disconnect)
+		return btd_error_busy(msg);
+
+	if (sink->stream_state < AVDTP_STATE_OPEN) {
+		DBusMessage *reply = dbus_message_new_method_return(msg);
+		if (!reply)
+			return NULL;
+		avdtp_unref(sink->session);
+		sink->session = NULL;
+		return reply;
+	}
+
+	err = avdtp_close(sink->session, sink->stream, FALSE);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	pending = g_new0(struct pending_request, 1);
+	pending->conn = dbus_connection_ref(conn);
+	pending->msg = dbus_message_ref(msg);
+	sink->disconnect = pending;
+
+	return NULL;
+}
+
+static DBusMessage *sink_is_connected(DBusConnection *conn,
+					DBusMessage *msg,
+					void *data)
+{
+	
+	struct audio_device *device = data;
+	struct video_sink *sink = device->video_sink;
+	DBusMessage *reply;
+	dbus_bool_t connected;
+ 
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	connected = (sink->stream_state >= AVDTP_STATE_CONFIGURED);
+
+	dbus_message_append_args(reply, DBUS_TYPE_BOOLEAN, &connected,
+					DBUS_TYPE_INVALID);
+	if (sink->stream_state == AVDTP_STATE_IDLE)
+		DBG("state is idle");
+	else if (sink->stream_state == AVDTP_STATE_CONFIGURED)
+		DBG("state is configured");
+	else if (sink->stream_state == AVDTP_STATE_OPEN)
+		DBG("state is open");
+	if (connected)
+		DBG("connected");
+	else 
+		DBG("not connected");
+	return reply;
+}
+
+
+
+static DBusMessage *sink_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct video_sink *sink = device->video_sink;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *state;
+	gboolean value;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	/* Playing */
+	value = (sink->stream_state == AVDTP_STATE_STREAMING);
+	dict_append_entry(&dict, "Playing", DBUS_TYPE_BOOLEAN, &value);
+
+	/* Connected */
+	value = (sink->stream_state >= AVDTP_STATE_CONFIGURED);
+	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
+
+	/* State */
+	state = state2str(sink->state);
+	if (state)
+		dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable sink_methods[] = {
+	{ "Connect",		"",	"",	sink_connect,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect",		"",	"",	sink_disconnect,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "IsConnected",	"",	"b",	sink_is_connected,
+						G_DBUS_METHOD_FLAG_DEPRECATED },
+	{ "GetProperties",	"",	"a{sv}",sink_get_properties },
+	{ NULL, NULL, NULL, NULL }
+};
+
+static GDBusSignalTable sink_signals[] = {
+	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
+	{ "PropertyChanged",		"sv"	},
+	{ NULL, NULL }
+};
+
+static void sink_free(struct audio_device *dev)
+{
+	struct video_sink *sink = dev->video_sink;
+
+	if (sink->cb_id)
+		avdtp_stream_remove_cb(sink->session, sink->stream,
+					sink->cb_id);
+
+	if (sink->session)
+		avdtp_unref(sink->session);
+
+	if (sink->connect)
+		pending_request_free(dev, sink->connect);
+
+	if (sink->disconnect)
+		pending_request_free(dev, sink->disconnect);
+
+	if (sink->retry_id)
+		g_source_remove(sink->retry_id);
+
+	g_free(sink);
+	dev->video_sink = NULL;
+}
+
+static void path_unregister(void *data)
+{
+	struct audio_device *dev = data;
+
+	DBG("Unregistered interface %s on path %s",
+		VIDEO_SINK_INTERFACE, dev->path);
+
+	sink_free(dev);
+}
+
+struct video_sink *video_sink_register(struct audio_device *dev)
+{
+	struct video_sink *sink;
+
+	if (!g_dbus_register_interface(dev->conn, dev->path,
+						VIDEO_SINK_INTERFACE,
+						sink_methods, sink_signals,
+						NULL, dev, path_unregister))
+		return NULL;
+
+	DBG("Registered interface %s on path %s", VIDEO_SINK_INTERFACE,
+								dev->path);
+
+	if (avdtp_callback_id == 0)
+		avdtp_callback_id = avdtp_add_state_cb(avdtp_state_callback,
+									NULL);
+
+	sink = g_new0(struct video_sink, 1);
+
+	sink->dev = dev;
+
+	return sink;
+}
+
+gboolean video_sink_new_stream(struct audio_device *dev, struct avdtp *session,
+				struct avdtp_stream *stream)
+{
+	struct video_sink *sink = dev->video_sink;
+
+	if (sink->stream)
+		return FALSE;
+
+	if (!sink->session)
+		sink->session = avdtp_ref(session);
+
+	sink->stream = stream;
+
+	sink->cb_id = avdtp_stream_add_cb(session, stream,
+						stream_state_changed, dev);
+
+	return TRUE;
+}
\ No newline at end of file
diff --git a/audio/video-sink.h b/audio/video-sink.h
new file mode 100644
index 0000000..0ecb840
--- /dev/null
+++ b/audio/video-sink.h
@@ -0,0 +1,44 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define VIDEO_SINK_INTERFACE "org.bluez.VideoSink"
+
+typedef enum {
+	VIDEO_SINK_STATE_DISCONNECTED,
+	VIDEO_SINK_STATE_CONNECTING,
+	VIDEO_SINK_STATE_CONNECTED,
+	VIDEO_SINK_STATE_PLAYING,
+} video_sink_state_t;
+
+typedef void (*video_sink_state_cb) (struct audio_device *dev,
+				video_sink_state_t old_state,
+				video_sink_state_t new_state,
+				void *user_data);
+struct video_sink *video_sink_register(struct audio_device *dev);
+void video_sink_unregister(struct audio_device *dev);
+
+gboolean video_sink_new_stream(struct audio_device *dev, struct avdtp *session,
+						struct avdtp_stream *stream);
+gboolean video_sink_setup_stream(struct video_sink *sink, struct avdtp *session);
+ 
\ No newline at end of file
-- 
1.7.6


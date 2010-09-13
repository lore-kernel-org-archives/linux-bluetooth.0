Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Add support for media transport in gstreamer plugin
Date: Mon, 13 Sep 2010 17:15:31 +0300
Message-Id: <1284387337-18822-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 Makefile.am          |    4 +-
 audio/a2dp-codecs.h  |  116 ++++++++++
 audio/gsta2dpsink.c  |   33 +++-
 audio/gsta2dpsink.h  |    1 +
 audio/gstavdtpsink.c |  609 +++++++++++++++++++++++++++++++++++++++++++++++++-
 audio/gstavdtpsink.h |    6 +
 6 files changed, 757 insertions(+), 12 deletions(-)
 create mode 100644 audio/a2dp-codecs.h

diff --git a/Makefile.am b/Makefile.am
index a8829d9..46f5449 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -307,9 +307,9 @@ audio_libgstbluetooth_la_SOURCES = audio/gstbluetooth.c audio/gstpragma.h \
 				audio/rtp.h audio/ipc.h audio/ipc.c
 audio_libgstbluetooth_la_LDFLAGS = -module -avoid-version
 audio_libgstbluetooth_la_LIBADD = sbc/libsbc.la lib/libbluetooth.la \
-				@GSTREAMER_LIBS@ -lgstaudio-0.10 -lgstrtp-0.10
+				@DBUS_LIBS@ @GSTREAMER_LIBS@ -lgstaudio-0.10 -lgstrtp-0.10
 audio_libgstbluetooth_la_CFLAGS = -fvisibility=hidden -fno-strict-aliasing \
-						$(AM_CFLAGS) @GSTREAMER_CFLAGS@
+						$(AM_CFLAGS) @DBUS_CFLAGS@ @GSTREAMER_CFLAGS@
 endif
 endif
 
diff --git a/audio/a2dp-codecs.h b/audio/a2dp-codecs.h
new file mode 100644
index 0000000..e44634e
--- /dev/null
+++ b/audio/a2dp-codecs.h
@@ -0,0 +1,116 @@
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
+#define A2DP_CODEC_SBC			0x00
+#define A2DP_CODEC_MPEG12		0x01
+#define A2DP_CODEC_MPEG24		0x02
+#define A2DP_CODEC_ATRAC		0x03
+
+#define SBC_SAMPLING_FREQ_16000		(1 << 3)
+#define SBC_SAMPLING_FREQ_32000		(1 << 2)
+#define SBC_SAMPLING_FREQ_44100		(1 << 1)
+#define SBC_SAMPLING_FREQ_48000		1
+
+#define SBC_CHANNEL_MODE_MONO		(1 << 3)
+#define SBC_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
+#define SBC_CHANNEL_MODE_STEREO		(1 << 1)
+#define SBC_CHANNEL_MODE_JOINT_STEREO	1
+
+#define SBC_BLOCK_LENGTH_4		(1 << 3)
+#define SBC_BLOCK_LENGTH_8		(1 << 2)
+#define SBC_BLOCK_LENGTH_12		(1 << 1)
+#define SBC_BLOCK_LENGTH_16		1
+
+#define SBC_SUBBANDS_4			(1 << 1)
+#define SBC_SUBBANDS_8			1
+
+#define SBC_ALLOCATION_SNR		(1 << 1)
+#define SBC_ALLOCATION_LOUDNESS		1
+
+#define MPEG_CHANNEL_MODE_MONO		(1 << 3)
+#define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
+#define MPEG_CHANNEL_MODE_STEREO	(1 << 1)
+#define MPEG_CHANNEL_MODE_JOINT_STEREO	1
+
+#define MPEG_LAYER_MP1			(1 << 2)
+#define MPEG_LAYER_MP2			(1 << 1)
+#define MPEG_LAYER_MP3			1
+
+#define MPEG_SAMPLING_FREQ_16000	(1 << 5)
+#define MPEG_SAMPLING_FREQ_22050	(1 << 4)
+#define MPEG_SAMPLING_FREQ_24000	(1 << 3)
+#define MPEG_SAMPLING_FREQ_32000	(1 << 2)
+#define MPEG_SAMPLING_FREQ_44100	(1 << 1)
+#define MPEG_SAMPLING_FREQ_48000	1
+
+#define MAX_BITPOOL 64
+#define MIN_BITPOOL 2
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+typedef struct {
+	uint8_t channel_mode:4;
+	uint8_t frequency:4;
+	uint8_t allocation_method:2;
+	uint8_t subbands:2;
+	uint8_t block_length:4;
+	uint8_t min_bitpool;
+	uint8_t max_bitpool;
+} __attribute__ ((packed)) a2dp_sbc_t;
+
+typedef struct {
+	uint8_t channel_mode:4;
+	uint8_t crc:1;
+	uint8_t layer:3;
+	uint8_t frequency:6;
+	uint8_t mpf:1;
+	uint8_t rfa:1;
+	uint16_t bitrate;
+} __attribute__ ((packed)) a2dp_mpeg_t;
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+typedef struct {
+	uint8_t frequency:4;
+	uint8_t channel_mode:4;
+	uint8_t block_length:4;
+	uint8_t subbands:2;
+	uint8_t allocation_method:2;
+	uint8_t min_bitpool;
+	uint8_t max_bitpool;
+} __attribute__ ((packed)) a2dp_sbc_t;
+
+typedef struct {
+	uint8_t layer:3;
+	uint8_t crc:1;
+	uint8_t channel_mode:4;
+	uint8_t rfa:1;
+	uint8_t mpf:1;
+	uint8_t frequency:6;
+	uint16_t bitrate;
+} __attribute__ ((packed)) a2dp_mpeg_t;
+
+#else
+#error "Unknown byte order"
+#endif
diff --git a/audio/gsta2dpsink.c b/audio/gsta2dpsink.c
index 492fc63..ac63424 100644
--- a/audio/gsta2dpsink.c
+++ b/audio/gsta2dpsink.c
@@ -44,7 +44,8 @@ GST_DEBUG_CATEGORY_STATIC(gst_a2dp_sink_debug);
 enum {
 	PROP_0,
 	PROP_DEVICE,
-	PROP_AUTOCONNECT
+	PROP_AUTOCONNECT,
+	PROP_TRANSPORT
 };
 
 GST_BOILERPLATE(GstA2dpSink, gst_a2dp_sink, GstBin, GST_TYPE_BIN);
@@ -175,6 +176,16 @@ static void gst_a2dp_sink_set_property(GObject *object, guint prop_id,
 		self->device = g_value_dup_string(value);
 		break;
 
+	case PROP_TRANSPORT:
+		if (self->sink != NULL)
+			gst_avdtp_sink_set_transport(self->sink,
+				g_value_get_string(value));
+
+		if (self->transport != NULL)
+			g_free(self->transport);
+		self->transport = g_value_dup_string(value);
+		break;
+
 	case PROP_AUTOCONNECT:
 		self->autoconnect = g_value_get_boolean(value);
 
@@ -193,7 +204,7 @@ static void gst_a2dp_sink_get_property(GObject *object, guint prop_id,
 					GValue *value, GParamSpec *pspec)
 {
 	GstA2dpSink *self = GST_A2DP_SINK(object);
-	gchar *device;
+	gchar *device, *transport;
 
 	switch (prop_id) {
 	case PROP_DEVICE:
@@ -210,6 +221,13 @@ static void gst_a2dp_sink_get_property(GObject *object, guint prop_id,
 
 		g_value_set_boolean(value, self->autoconnect);
 		break;
+	case PROP_TRANSPORT:
+		if (self->sink != NULL) {
+			transport = gst_avdtp_sink_get_transport(self->sink);
+			if (transport != NULL)
+				g_value_take_string(value, transport);
+		}
+		break;
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -285,6 +303,10 @@ static GstStateChangeReturn gst_a2dp_sink_change_state(GstElement *element,
 			gst_avdtp_sink_set_device(self->sink,
 					self->device);
 
+		if (self->transport != NULL)
+			gst_avdtp_sink_set_transport(self->sink,
+					self->transport);
+
 		g_object_set(G_OBJECT(self->sink), "auto-connect",
 					self->autoconnect, NULL);
 
@@ -365,6 +387,11 @@ static void gst_a2dp_sink_class_init(GstA2dpSinkClass *klass)
 			"Automatically attempt to connect to device",
 			DEFAULT_AUTOCONNECT, G_PARAM_READWRITE));
 
+	g_object_class_install_property(object_class, PROP_TRANSPORT,
+			g_param_spec_string("transport", "Transport",
+			"Use configured transport",
+			NULL, G_PARAM_READWRITE));
+
 	GST_DEBUG_CATEGORY_INIT(gst_a2dp_sink_debug, "a2dpsink", 0,
 				"A2DP sink element");
 }
@@ -437,6 +464,7 @@ static gboolean gst_a2dp_sink_init_avdtp_sink(GstA2dpSink *self)
 	self->sink = GST_AVDTP_SINK(sink);
 	self->sink_is_in_bin = TRUE;
 	g_object_set(G_OBJECT(self->sink), "device", self->device, NULL);
+	g_object_set(G_OBJECT(self->sink), "transport", self->transport, NULL);
 
 	gst_element_set_state(sink, GST_STATE_PAUSED);
 
@@ -674,6 +702,7 @@ static void gst_a2dp_sink_init(GstA2dpSink *self,
 	self->fakesink = NULL;
 	self->rtp = NULL;
 	self->device = NULL;
+	self->transport = NULL;
 	self->autoconnect = DEFAULT_AUTOCONNECT;
 	self->capsfilter = NULL;
 	self->newseg_event = NULL;
diff --git a/audio/gsta2dpsink.h b/audio/gsta2dpsink.h
index 3ff4e45..3c4510e 100644
--- a/audio/gsta2dpsink.h
+++ b/audio/gsta2dpsink.h
@@ -53,6 +53,7 @@ struct _GstA2dpSink {
 	GstElement *fakesink;
 
 	gchar *device;
+	gchar *transport;
 	gboolean autoconnect;
 	gboolean sink_is_in_bin;
 
diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index b8c8832..95c4811 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -37,8 +37,11 @@
 
 #include <gst/rtp/gstrtpbuffer.h>
 
+#include <dbus/dbus.h>
+
 #include "ipc.h"
 #include "rtp.h"
+#include "a2dp-codecs.h"
 
 #include "gstpragma.h"
 #include "gstavdtpsink.h"
@@ -61,11 +64,20 @@ GST_DEBUG_CATEGORY_STATIC(avdtp_sink_debug);
 		g_mutex_unlock(s->sink_lock);		\
 	} G_STMT_END
 
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
 
 struct bluetooth_data {
 	struct bt_get_capabilities_rsp *caps; /* Bluetooth device caps */
 	guint link_mtu;
 
+	DBusConnection *conn;
+	guint8 codec; /* Bluetooth transport configuration */
+	gchar *uuid;
+	guint8 *config;
+	gint config_size;
+
 	gchar buffer[BUFFER_SIZE];	/* Codec transfer buffer */
 };
 
@@ -75,7 +87,8 @@ struct bluetooth_data {
 enum {
 	PROP_0,
 	PROP_DEVICE,
-	PROP_AUTOCONNECT
+	PROP_AUTOCONNECT,
+	PROP_TRANSPORT
 };
 
 GST_BOILERPLATE(GstAvdtpSink, gst_avdtp_sink, GstBaseSink,
@@ -127,6 +140,23 @@ static void gst_avdtp_sink_base_init(gpointer g_class)
 	gst_element_class_set_details(element_class, &avdtp_sink_details);
 }
 
+static void gst_avdtp_sink_transport_release(GstAvdtpSink *self)
+{
+	DBusMessage *msg;
+	const char *access_type = "w";
+
+	msg = dbus_message_new_method_call("org.bluez", self->transport,
+						"org.bluez.MediaTransport",
+						"Release");
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &access_type,
+					DBUS_TYPE_INVALID);
+
+	dbus_connection_send(self->data->conn, msg, NULL);
+
+	dbus_message_unref(msg);
+}
+
 static gboolean gst_avdtp_sink_stop(GstBaseSink *basesink)
 {
 	GstAvdtpSink *self = GST_AVDTP_SINK(basesink);
@@ -151,6 +181,10 @@ static gboolean gst_avdtp_sink_stop(GstBaseSink *basesink)
 	}
 
 	if (self->data) {
+		if (self->transport)
+			gst_avdtp_sink_transport_release(self);
+		if (self->data->conn)
+			dbus_connection_unref(self->data->conn);
 		g_free(self->data);
 		self->data = NULL;
 	}
@@ -178,6 +212,9 @@ static void gst_avdtp_sink_finalize(GObject *object)
 	if (self->device)
 		g_free(self->device);
 
+	if (self->transport)
+		g_free(self->transport);
+
 	g_mutex_free(self->sink_lock);
 
 	G_OBJECT_CLASS(parent_class)->finalize(object);
@@ -198,6 +235,13 @@ static void gst_avdtp_sink_set_property(GObject *object, guint prop_id,
 	case PROP_AUTOCONNECT:
 		sink->autoconnect = g_value_get_boolean(value);
 		break;
+
+	case PROP_TRANSPORT:
+		if (sink->transport)
+			g_free(sink->transport);
+		sink->transport = g_value_dup_string(value);
+		break;
+
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -217,6 +261,11 @@ static void gst_avdtp_sink_get_property(GObject *object, guint prop_id,
 	case PROP_AUTOCONNECT:
 		g_value_set_boolean(value, sink->autoconnect);
 		break;
+
+	case PROP_TRANSPORT:
+		g_value_set_string(value, sink->transport);
+		break;
+
 	default:
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
@@ -370,6 +419,10 @@ static gboolean gst_avdtp_sink_conf_recv_stream_fd(
 	GIOFlags flags;
 	gsize read;
 
+	/* Proceed if stream was already acquired */
+	if (self->stream != NULL)
+		goto proceed;
+
 	ret = gst_avdtp_sink_bluetooth_recvmsg_fd(self);
 	if (ret < 0)
 		return FALSE;
@@ -380,6 +433,7 @@ static gboolean gst_avdtp_sink_conf_recv_stream_fd(
 		return FALSE;
 	}
 
+proceed:
 	/* set stream socket to nonblock */
 	GST_LOG_OBJECT(self, "setting stream socket to nonblock");
 	flags = g_io_channel_get_flags(self->stream);
@@ -733,6 +787,325 @@ static GstStructure *gst_avdtp_sink_parse_mpeg_caps(
 	return structure;
 }
 
+static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
+{
+	a2dp_sbc_t *sbc = (a2dp_sbc_t *) self->data->config;
+	GstStructure *structure;
+	GValue *value;
+	GValue *list;
+	gboolean mono, stereo;
+
+	structure = gst_structure_empty_new("audio/x-sbc");
+	value = g_value_init(g_new0(GValue, 1), G_TYPE_STRING);
+
+	/* mode */
+	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
+	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_MONO) {
+		g_value_set_static_string(value, "mono");
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) {
+		g_value_set_static_string(value, "stereo");
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) {
+		g_value_set_static_string(value, "dual");
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_JOINT_STEREO) {
+		g_value_set_static_string(value, "joint");
+		gst_value_list_prepend_value(list, value);
+	}
+	g_value_unset(value);
+	if (list) {
+		gst_structure_set_value(structure, "mode", list);
+		g_free(list);
+		list = NULL;
+	}
+
+	/* subbands */
+	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
+	value = g_value_init(value, G_TYPE_INT);
+	if (sbc->subbands & BT_A2DP_SUBBANDS_4) {
+		g_value_set_int(value, 4);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->subbands & BT_A2DP_SUBBANDS_8) {
+		g_value_set_int(value, 8);
+		gst_value_list_prepend_value(list, value);
+	}
+	g_value_unset(value);
+	if (list) {
+		gst_structure_set_value(structure, "subbands", list);
+		g_free(list);
+		list = NULL;
+	}
+
+	/* blocks */
+	value = g_value_init(value, G_TYPE_INT);
+	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
+	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_16) {
+		g_value_set_int(value, 16);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_12) {
+		g_value_set_int(value, 12);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_8) {
+		g_value_set_int(value, 8);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_4) {
+		g_value_set_int(value, 4);
+		gst_value_list_prepend_value(list, value);
+	}
+	g_value_unset(value);
+	if (list) {
+		gst_structure_set_value(structure, "blocks", list);
+		g_free(list);
+		list = NULL;
+	}
+
+	/* allocation */
+	g_value_init(value, G_TYPE_STRING);
+	list = g_value_init(g_new0(GValue,1), GST_TYPE_LIST);
+	if (sbc->allocation_method & BT_A2DP_ALLOCATION_LOUDNESS) {
+		g_value_set_static_string(value, "loudness");
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->allocation_method & BT_A2DP_ALLOCATION_SNR) {
+		g_value_set_static_string(value, "snr");
+		gst_value_list_prepend_value(list, value);
+	}
+	g_value_unset(value);
+	if (list) {
+		gst_structure_set_value(structure, "allocation", list);
+		g_free(list);
+		list = NULL;
+	}
+
+	/* rate */
+	g_value_init(value, G_TYPE_INT);
+	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
+	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_48000) {
+		g_value_set_int(value, 48000);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_44100) {
+		g_value_set_int(value, 44100);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_32000) {
+		g_value_set_int(value, 32000);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_16000) {
+		g_value_set_int(value, 16000);
+		gst_value_list_prepend_value(list, value);
+	}
+	g_value_unset(value);
+	if (list) {
+		gst_structure_set_value(structure, "rate", list);
+		g_free(list);
+		list = NULL;
+	}
+
+	/* bitpool */
+	value = g_value_init(value, GST_TYPE_INT_RANGE);
+	gst_value_set_int_range(value,
+			MIN(sbc->min_bitpool, TEMPLATE_MAX_BITPOOL),
+			MIN(sbc->max_bitpool, TEMPLATE_MAX_BITPOOL));
+	gst_structure_set_value(structure, "bitpool", value);
+	g_value_unset(value);
+
+	/* channels */
+	mono = FALSE;
+	stereo = FALSE;
+	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_MONO)
+		mono = TRUE;
+	if ((sbc->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) ||
+			(sbc->channel_mode &
+			BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) ||
+			(sbc->channel_mode &
+			BT_A2DP_CHANNEL_MODE_JOINT_STEREO))
+		stereo = TRUE;
+
+	if (mono && stereo) {
+		g_value_init(value, GST_TYPE_INT_RANGE);
+		gst_value_set_int_range(value, 1, 2);
+	} else {
+		g_value_init(value, G_TYPE_INT);
+		if (mono)
+			g_value_set_int(value, 1);
+		else if (stereo)
+			g_value_set_int(value, 2);
+		else {
+			GST_ERROR_OBJECT(self,
+				"Unexpected number of channels");
+			g_value_set_int(value, 0);
+		}
+	}
+
+	gst_structure_set_value(structure, "channels", value);
+	g_free(value);
+
+	return structure;
+}
+
+static GstStructure *gst_avdtp_sink_parse_mpeg_raw(GstAvdtpSink *self)
+{
+	a2dp_mpeg_t *mpeg = (a2dp_mpeg_t *) self->data->config;
+	GstStructure *structure;
+	GValue *value;
+	GValue *list;
+	gboolean valid_layer = FALSE;
+	gboolean mono, stereo;
+
+	GST_LOG_OBJECT(self, "parsing mpeg caps");
+
+	structure = gst_structure_empty_new("audio/mpeg");
+	value = g_new0(GValue, 1);
+	g_value_init(value, G_TYPE_INT);
+
+	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
+	g_value_set_int(value, 1);
+	gst_value_list_prepend_value(list, value);
+	g_value_set_int(value, 2);
+	gst_value_list_prepend_value(list, value);
+	gst_structure_set_value(structure, "mpegversion", list);
+	g_free(list);
+
+	/* layer */
+	GST_LOG_OBJECT(self, "setting mpeg layer");
+	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
+	if (mpeg->layer & BT_MPEG_LAYER_1) {
+		g_value_set_int(value, 1);
+		gst_value_list_prepend_value(list, value);
+		valid_layer = TRUE;
+	}
+	if (mpeg->layer & BT_MPEG_LAYER_2) {
+		g_value_set_int(value, 2);
+		gst_value_list_prepend_value(list, value);
+		valid_layer = TRUE;
+	}
+	if (mpeg->layer & BT_MPEG_LAYER_3) {
+		g_value_set_int(value, 3);
+		gst_value_list_prepend_value(list, value);
+		valid_layer = TRUE;
+	}
+	if (list) {
+		gst_structure_set_value(structure, "layer", list);
+		g_free(list);
+		list = NULL;
+	}
+
+	if (!valid_layer) {
+		gst_structure_free(structure);
+		g_free(value);
+		return NULL;
+	}
+
+	/* rate */
+	GST_LOG_OBJECT(self, "setting mpeg rate");
+	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
+	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_48000) {
+		g_value_set_int(value, 48000);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_44100) {
+		g_value_set_int(value, 44100);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_32000) {
+		g_value_set_int(value, 32000);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_24000) {
+		g_value_set_int(value, 24000);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_22050) {
+		g_value_set_int(value, 22050);
+		gst_value_list_prepend_value(list, value);
+	}
+	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_16000) {
+		g_value_set_int(value, 16000);
+		gst_value_list_prepend_value(list, value);
+	}
+	g_value_unset(value);
+	if (list) {
+		gst_structure_set_value(structure, "rate", list);
+		g_free(list);
+		list = NULL;
+	}
+
+	/* channels */
+	GST_LOG_OBJECT(self, "setting mpeg channels");
+	mono = FALSE;
+	stereo = FALSE;
+	if (mpeg->channel_mode & BT_A2DP_CHANNEL_MODE_MONO)
+		mono = TRUE;
+	if ((mpeg->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) ||
+			(mpeg->channel_mode &
+			BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) ||
+			(mpeg->channel_mode &
+			BT_A2DP_CHANNEL_MODE_JOINT_STEREO))
+		stereo = TRUE;
+
+	if (mono && stereo) {
+		g_value_init(value, GST_TYPE_INT_RANGE);
+		gst_value_set_int_range(value, 1, 2);
+	} else {
+		g_value_init(value, G_TYPE_INT);
+		if (mono)
+			g_value_set_int(value, 1);
+		else if (stereo)
+			g_value_set_int(value, 2);
+		else {
+			GST_ERROR_OBJECT(self,
+				"Unexpected number of channels");
+			g_value_set_int(value, 0);
+		}
+	}
+	gst_structure_set_value(structure, "channels", value);
+	g_free(value);
+
+	return structure;
+}
+
+static gboolean gst_avdtp_sink_update_config(GstAvdtpSink *self)
+{
+	GstStructure *structure;
+	gchar *tmp;
+
+	switch (self->data->codec) {
+	case A2DP_CODEC_SBC:
+		structure = gst_avdtp_sink_parse_sbc_raw(self);
+		break;
+	case A2DP_CODEC_MPEG12:
+		structure = gst_avdtp_sink_parse_mpeg_raw(self);
+		break;
+	default:
+		GST_ERROR_OBJECT(self, "Unsupported configuration");
+		return FALSE;
+	}
+
+	if (structure == NULL)
+		return FALSE;
+
+	if (self->dev_caps != NULL)
+		gst_caps_unref(self->dev_caps);
+
+	self->dev_caps = gst_caps_new_full(structure, NULL);
+
+	tmp = gst_caps_to_string(self->dev_caps);
+	GST_DEBUG_OBJECT(self, "Transport configuration: %s", tmp);
+	g_free(tmp);
+
+	return TRUE;
+}
+
 static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
 {
 	sbc_capabilities_t *sbc;
@@ -743,6 +1116,9 @@ static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
 
 	GST_LOG_OBJECT(self, "updating device caps");
 
+	if (self->data->config_size != 0 && self->data->config != NULL)
+		return gst_avdtp_sink_update_config(self);
+
 	sbc = (void *) gst_avdtp_find_caps(self, BT_A2DP_SBC_SINK);
 	mpeg = (void *) gst_avdtp_find_caps(self, BT_A2DP_MPEG12_SINK);
 
@@ -870,6 +1246,192 @@ static gboolean gst_avdtp_sink_event(GstBaseSink *basesink,
 	return TRUE;
 }
 
+static gboolean gst_avdtp_sink_transport_parse_property(GstAvdtpSink *self,
+							DBusMessageIter *i)
+{
+	const char *key;
+	DBusMessageIter variant_i;
+
+	if (dbus_message_iter_get_arg_type(i) != DBUS_TYPE_STRING) {
+		GST_ERROR_OBJECT(self, "Property name not a string.");
+		return FALSE;
+	}
+
+	dbus_message_iter_get_basic(i, &key);
+
+	if (!dbus_message_iter_next(i))  {
+		GST_ERROR_OBJECT(self, "Property value missing");
+		return FALSE;
+	}
+
+	if (dbus_message_iter_get_arg_type(i) != DBUS_TYPE_VARIANT) {
+		GST_ERROR_OBJECT(self, "Property value not a variant.");
+		return FALSE;
+	}
+
+	dbus_message_iter_recurse(i, &variant_i);
+
+	switch (dbus_message_iter_get_arg_type(&variant_i)) {
+	case DBUS_TYPE_BYTE: {
+		uint8_t value;
+		dbus_message_iter_get_basic(&variant_i, &value);
+
+		if (g_str_equal(key, "Codec") == TRUE)
+			self->data->codec = value;
+
+		break;
+	}
+	case DBUS_TYPE_UINT16: {
+		uint16_t value;
+		dbus_message_iter_get_basic(&variant_i, &value);
+
+		if (g_str_equal(key, "OMTU") == TRUE)
+			self->data->link_mtu = value;
+
+		break;
+	}
+        case DBUS_TYPE_STRING: {
+		const char *value;
+		dbus_message_iter_get_basic(&variant_i, &value);
+
+		if (g_str_equal(key, "UUID") == TRUE) {
+			g_free(self->data->uuid);
+			self->data->uuid = g_strdup(value);
+		}
+
+		break;
+	}
+	case DBUS_TYPE_ARRAY: {
+		DBusMessageIter array_i;
+		char *value;
+		int size;
+
+		dbus_message_iter_recurse(&variant_i, &array_i);
+		dbus_message_iter_get_fixed_array(&array_i, &value, &size);
+
+		if (g_str_equal(key, "Configuration")) {
+			g_free(self->data->config);
+			self->data->config = g_new0(guint8, size);
+			self->data->config_size = size;
+			memcpy(self->data->config, value, size);
+		}
+
+		break;
+	}
+	}
+
+	return TRUE;
+}
+
+static gboolean gst_avdtp_sink_transport_acquire(GstAvdtpSink *self)
+{
+	DBusMessage *msg, *reply;
+	DBusError err;
+	const char *access_type = "w";
+	int fd;
+
+	dbus_error_init(&err);
+
+	if (self->data->conn == NULL)
+		self->data->conn = dbus_bus_get(DBUS_BUS_SYSTEM, &err);
+
+	msg = dbus_message_new_method_call("org.bluez", self->transport,
+						"org.bluez.MediaTransport",
+						"Acquire");
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &access_type,
+					DBUS_TYPE_INVALID);
+
+	reply = dbus_connection_send_with_reply_and_block(self->data->conn,
+							msg, -1, &err);
+
+	if (dbus_error_is_set(&err))
+		goto fail;
+
+	if (dbus_message_get_args(reply, &err, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_INVALID) == FALSE)
+		goto fail;
+
+	dbus_message_unref(reply);
+
+	self->stream = g_io_channel_unix_new(fd);
+	g_io_channel_set_close_on_unref(self->stream, TRUE);
+	GST_DEBUG_OBJECT(self, "stream_fd=%d", fd);
+
+	return TRUE;
+
+fail:
+	GST_ERROR_OBJECT(self, "Failed to acquire transport stream: %s",
+				err.message);
+
+	dbus_error_free(&err);
+
+	if (reply)
+		dbus_message_unref(msg);
+
+	return FALSE;
+}
+
+static gboolean gst_avdtp_sink_transport_get_properties(GstAvdtpSink *self)
+{
+	DBusMessage *msg, *reply;
+	DBusMessageIter arg_i, ele_i;
+	DBusError err;
+
+	dbus_error_init(&err);
+
+	/* Transport need to be acquire first to make sure the MTUs are
+	   available */
+	if (gst_avdtp_sink_transport_acquire(self) == FALSE)
+		return FALSE;
+
+	msg = dbus_message_new_method_call("org.bluez", self->transport,
+						"org.bluez.MediaTransport",
+						"GetProperties");
+	reply = dbus_connection_send_with_reply_and_block(self->data->conn,
+							msg, -1, &err);
+
+	if (dbus_error_is_set(&err) || reply == NULL) {
+		GST_ERROR_OBJECT(self, "Failed to get transport properties: %s",
+					err.message);
+		goto fail;
+	}
+
+	if (!dbus_message_iter_init(reply, &arg_i)) {
+		GST_ERROR_OBJECT(self, "GetProperties reply has no arguments.");
+		goto fail;
+	}
+
+	if (dbus_message_iter_get_arg_type(&arg_i) != DBUS_TYPE_ARRAY) {
+		GST_ERROR_OBJECT(self, "GetProperties argument is not an array.");
+		goto fail;
+	}
+
+	dbus_message_iter_recurse(&arg_i, &ele_i);
+	while (dbus_message_iter_get_arg_type(&ele_i) != DBUS_TYPE_INVALID) {
+
+		if (dbus_message_iter_get_arg_type(&ele_i) ==
+				DBUS_TYPE_DICT_ENTRY) {
+			DBusMessageIter dict_i;
+
+			dbus_message_iter_recurse(&ele_i, &dict_i);
+
+			gst_avdtp_sink_transport_parse_property(self, &dict_i);
+		}
+
+		if (!dbus_message_iter_next(&ele_i))
+			break;
+	}
+
+	return gst_avdtp_sink_update_caps(self);
+
+fail:
+	dbus_message_unref(msg);
+	dbus_message_unref(reply);
+	return FALSE;
+
+}
+
 static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 {
 	GstAvdtpSink *self = GST_AVDTP_SINK(basesink);
@@ -878,6 +1440,16 @@ static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 
 	GST_INFO_OBJECT(self, "start");
 
+	self->data = g_new0(struct bluetooth_data, 1);
+
+	self->stream = NULL;
+	self->stream_caps = NULL;
+	self->mp3_using_crc = -1;
+	self->channel_mode = -1;
+
+	if (self->transport != NULL)
+		return gst_avdtp_sink_transport_get_properties(self);
+
 	self->watch_id = 0;
 
 	sk = bt_audio_service_open();
@@ -892,13 +1464,6 @@ static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 	self->watch_id = g_io_add_watch(self->server, G_IO_HUP | G_IO_ERR |
 					G_IO_NVAL, server_callback, self);
 
-	self->data = g_new0(struct bluetooth_data, 1);
-
-	self->stream = NULL;
-	self->stream_caps = NULL;
-	self->mp3_using_crc = -1;
-	self->channel_mode = -1;
-
 	if (!gst_avdtp_sink_get_capabilities(self)) {
 		GST_ERROR_OBJECT(self, "failed to get capabilities "
 				"from device");
@@ -920,6 +1485,9 @@ static gboolean gst_avdtp_sink_stream_start(GstAvdtpSink *self)
 	struct bt_new_stream_ind *ind = (void *) buf;
 	GIOError io_error;
 
+	if (self->transport != NULL)
+		return gst_avdtp_sink_conf_recv_stream_fd(self);
+
 	memset(req, 0, sizeof(buf));
 	req->h.type = BT_REQUEST;
 	req->h.name = BT_START_STREAM;
@@ -1051,6 +1619,10 @@ static gboolean gst_avdtp_sink_configure(GstAvdtpSink *self,
 	GST_DEBUG_OBJECT(self, "configuring device with caps: %s", temp);
 	g_free(temp);
 
+	/* Transport already configured */
+	if (self->transport != NULL)
+		return TRUE;
+
 	structure = gst_caps_get_structure(caps, 0);
 
 	if (gst_structure_has_name(structure, "audio/x-sbc"))
@@ -1237,6 +1809,12 @@ static void gst_avdtp_sink_class_init(GstAvdtpSinkClass *klass)
 					"to device", DEFAULT_AUTOCONNECT,
 					G_PARAM_READWRITE));
 
+	g_object_class_install_property(object_class, PROP_TRANSPORT,
+					g_param_spec_string("transport",
+					"Transport",
+					"Use configured transport",
+					NULL, G_PARAM_READWRITE));
+
 	GST_DEBUG_CATEGORY_INIT(avdtp_sink_debug, "avdtpsink", 0,
 				"A2DP headset sink element");
 }
@@ -1245,6 +1823,7 @@ static void gst_avdtp_sink_init(GstAvdtpSink *self,
 			GstAvdtpSinkClass *klass)
 {
 	self->device = NULL;
+	self->transport = NULL;
 	self->data = NULL;
 
 	self->stream = NULL;
@@ -1400,11 +1979,25 @@ void gst_avdtp_sink_set_device(GstAvdtpSink *self, const gchar *dev)
 	self->device = g_strdup(dev);
 }
 
+void gst_avdtp_sink_set_transport(GstAvdtpSink *self, const gchar *trans)
+{
+	if (self->transport != NULL)
+		g_free(self->transport);
+
+	GST_LOG_OBJECT(self, "Setting transport: %s", trans);
+	self->transport = g_strdup(trans);
+}
+
 gchar *gst_avdtp_sink_get_device(GstAvdtpSink *self)
 {
 	return g_strdup(self->device);
 }
 
+gchar *gst_avdtp_sink_get_transport(GstAvdtpSink *self)
+{
+	return g_strdup(self->transport);
+}
+
 void gst_avdtp_sink_set_crc(GstAvdtpSink *self, gboolean crc)
 {
 	gint new_crc;
diff --git a/audio/gstavdtpsink.h b/audio/gstavdtpsink.h
index eb78248..888169f 100644
--- a/audio/gstavdtpsink.h
+++ b/audio/gstavdtpsink.h
@@ -51,6 +51,7 @@ struct _GstAvdtpSink {
 	GstBaseSink sink;
 
 	gchar *device;
+	gchar *transport;
 	GIOChannel *stream;
 
 	struct bluetooth_data *data;
@@ -86,8 +87,13 @@ guint gst_avdtp_sink_get_link_mtu(GstAvdtpSink *sink);
 void gst_avdtp_sink_set_device(GstAvdtpSink *sink,
 		const gchar* device);
 
+void gst_avdtp_sink_set_transport(GstAvdtpSink *sink,
+		const gchar *transport);
+
 gchar *gst_avdtp_sink_get_device(GstAvdtpSink *sink);
 
+gchar *gst_avdtp_sink_get_transport(GstAvdtpSink *sink);
+
 gboolean gst_avdtp_sink_plugin_init(GstPlugin *plugin);
 
 void gst_avdtp_sink_set_crc(GstAvdtpSink *self, gboolean crc);
-- 
1.7.1


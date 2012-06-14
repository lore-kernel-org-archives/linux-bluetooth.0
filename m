Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: =?y?q?=5BPATCH=20BlueZ=203/5=5D=20audio=3A=20Remove=20internal=20audio=20IPC?=
Date: Thu, 14 Jun 2012 16:41:08 +0300
Message-Id: <1339681270-24425-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
References: <1339681270-24425-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With unix socket and ALSA removed there is no longer any use for the
internal IPC.
---
 Makefile.am                        |    4 +-
 Makefile.tools                     |    5 +-
 audio/device.c                     |    1 -
 audio/gstavdtpsink.c               | 1107 ++++-------------------------------
 audio/gstavdtpsink.h               |    1 -
 audio/ipc.c                        |  134 -----
 audio/ipc.h                        |  361 ------------
 audio/manager.c                    |    1 -
 test/ipctest-a2dp-easy.test        |    8 -
 test/ipctest-a2dp-resume-fast.test |   82 ---
 test/ipctest-hsp-a2dp-switch.test  |   50 --
 test/ipctest-hsp-easy.test         |    7 -
 test/ipctest-init-shutdown.test    |   59 --
 test/ipctest.c                     | 1133 ------------------------------------
 14 files changed, 112 insertions(+), 2841 deletions(-)
 delete mode 100644 audio/ipc.c
 delete mode 100644 audio/ipc.h
 delete mode 100644 test/ipctest-a2dp-easy.test
 delete mode 100644 test/ipctest-a2dp-resume-fast.test
 delete mode 100644 test/ipctest-hsp-a2dp-switch.test
 delete mode 100644 test/ipctest-hsp-easy.test
 delete mode 100644 test/ipctest-init-shutdown.test
 delete mode 100644 test/ipctest.c

diff --git a/Makefile.am b/Makefile.am
index cb2143b..deb25e1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -151,7 +151,6 @@ builtin_sources += audio/main.c \
 			audio/sink.h audio/sink.c \
 			audio/a2dp.h audio/a2dp.c \
 			audio/avdtp.h audio/avdtp.c \
-			audio/ipc.h audio/ipc.c \
 			audio/media.h audio/media.c \
 			audio/transport.h audio/transport.c \
 			audio/telephony.h audio/a2dp-codecs.h
@@ -348,8 +347,7 @@ audio_libgstbluetooth_la_SOURCES = audio/gstbluetooth.c audio/gstpragma.h \
 				audio/gstavdtpsink.h audio/gstavdtpsink.c \
 				audio/gsta2dpsink.h audio/gsta2dpsink.c \
 				audio/gstsbcutil.h audio/gstsbcutil.c \
-				audio/gstrtpsbcpay.h audio/gstrtpsbcpay.c \
-				audio/rtp.h audio/ipc.h audio/ipc.c
+				audio/gstrtpsbcpay.h audio/gstrtpsbcpay.c
 audio_libgstbluetooth_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
 audio_libgstbluetooth_la_LIBADD = sbc/libsbc.la lib/libbluetooth-private.la \
 						@DBUS_LIBS@ @GSTREAMER_LIBS@ \
diff --git a/Makefile.tools b/Makefile.tools
index c93b263..8dc5674 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -163,7 +163,7 @@ sbin_PROGRAMS += test/hciemu
 bin_PROGRAMS += test/l2test test/rctest
 
 noinst_PROGRAMS += test/gaptest test/sdptest test/scotest \
-			test/attest test/hstest test/avtest test/ipctest \
+			test/attest test/hstest test/avtest \
 					test/lmptest test/bdaddr test/agent \
 					test/btiotest test/test-textfile \
 					test/uuidtest test/mpris-player
@@ -188,9 +188,6 @@ test_avtest_LDADD = lib/libbluetooth-private.la
 
 test_lmptest_LDADD = lib/libbluetooth-private.la
 
-test_ipctest_SOURCES = test/ipctest.c audio/ipc.h audio/ipc.c
-test_ipctest_LDADD= @GLIB_LIBS@ sbc/libsbc.la
-
 test_bdaddr_SOURCES = test/bdaddr.c src/oui.h src/oui.c
 test_bdaddr_LDADD = lib/libbluetooth-private.la
 
diff --git a/audio/device.c b/audio/device.c
index 51ec2d0..2e7aa97 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -46,7 +46,6 @@
 #include "../src/device.h"
 
 #include "error.h"
-#include "ipc.h"
 #include "dbus-common.h"
 #include "device.h"
 #include "avdtp.h"
diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index 1f374fc..ffaed7f 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -39,7 +39,6 @@
 
 #include <dbus/dbus.h>
 
-#include "ipc.h"
 #include "rtp.h"
 #include "a2dp-codecs.h"
 
@@ -65,7 +64,6 @@ GST_DEBUG_CATEGORY_STATIC(avdtp_sink_debug);
 	} G_STMT_END
 
 struct bluetooth_data {
-	struct bt_get_capabilities_rsp *caps; /* Bluetooth device caps */
 	guint link_mtu;
 
 	DBusConnection *conn;
@@ -118,13 +116,6 @@ static GstStaticPadTemplate avdtp_sink_factory =
 				"encoding-name = (string) \"MPA\""
 				));
 
-static int gst_avdtp_sink_audioservice_send(GstAvdtpSink *self,
-					const bt_audio_msg_header_t *msg);
-static int gst_avdtp_sink_audioservice_expect(GstAvdtpSink *self,
-					bt_audio_msg_header_t *outmsg,
-					guint8 expected_name);
-
-
 static void gst_avdtp_sink_base_init(gpointer g_class)
 {
 	GstElementClass *element_class = GST_ELEMENT_CLASS(g_class);
@@ -163,12 +154,6 @@ static gboolean gst_avdtp_sink_stop(GstBaseSink *basesink)
 		self->watch_id = 0;
 	}
 
-	if (self->server) {
-		bt_audio_service_close(g_io_channel_unix_get_fd(self->server));
-		g_io_channel_unref(self->server);
-		self->server = NULL;
-	}
-
 	if (self->stream) {
 		g_io_channel_shutdown(self->stream, TRUE, NULL);
 		g_io_channel_unref(self->stream);
@@ -241,545 +226,30 @@ static void gst_avdtp_sink_set_property(GObject *object, guint prop_id,
 		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
 		break;
 	}
-}
-
-static void gst_avdtp_sink_get_property(GObject *object, guint prop_id,
-					GValue *value, GParamSpec *pspec)
-{
-	GstAvdtpSink *sink = GST_AVDTP_SINK(object);
-
-	switch (prop_id) {
-	case PROP_DEVICE:
-		g_value_set_string(value, sink->device);
-		break;
-
-	case PROP_AUTOCONNECT:
-		g_value_set_boolean(value, sink->autoconnect);
-		break;
-
-	case PROP_TRANSPORT:
-		g_value_set_string(value, sink->transport);
-		break;
-
-	default:
-		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
-		break;
-	}
-}
-
-static gint gst_avdtp_sink_bluetooth_recvmsg_fd(GstAvdtpSink *sink)
-{
-	int err, ret;
-
-	ret = bt_audio_service_get_data_fd(
-			g_io_channel_unix_get_fd(sink->server));
-
-	if (ret < 0) {
-		err = -errno;
-		GST_ERROR_OBJECT(sink, "Unable to receive fd: %s (%d)",
-				strerror(-err), -err);
-		return err;
-	}
-
-	sink->stream = g_io_channel_unix_new(ret);
-	g_io_channel_set_encoding(sink->stream, NULL, NULL);
-	GST_DEBUG_OBJECT(sink, "stream_fd=%d", ret);
-
-	return 0;
-}
-
-static codec_capabilities_t *gst_avdtp_find_caps(GstAvdtpSink *sink,
-						uint8_t codec_type)
-{
-	struct bt_get_capabilities_rsp *rsp = sink->data->caps;
-	codec_capabilities_t *codec = (void *) rsp->data;
-	int bytes_left = rsp->h.length - sizeof(*rsp);
-
-	while (bytes_left > 0) {
-		if ((codec->type == codec_type) &&
-				!(codec->lock & BT_WRITE_LOCK))
-			break;
-
-		bytes_left -= codec->length;
-		codec = (void *) codec + codec->length;
-	}
-
-	if (bytes_left <= 0)
-		return NULL;
-
-	return codec;
-}
-
-static gboolean gst_avdtp_sink_init_sbc_pkt_conf(GstAvdtpSink *sink,
-					GstCaps *caps,
-					sbc_capabilities_t *pkt)
-{
-	sbc_capabilities_t *cfg;
-	const GValue *value = NULL;
-	const char *pref, *name;
-	gint rate, subbands, blocks;
-	GstStructure *structure = gst_caps_get_structure(caps, 0);
-
-	cfg = (void *) gst_avdtp_find_caps(sink, BT_A2DP_SBC_SINK);
-	name = gst_structure_get_name(structure);
-
-	if (!(IS_SBC(name))) {
-		GST_ERROR_OBJECT(sink, "Unexpected format %s, "
-				"was expecting sbc", name);
-		return FALSE;
-	}
-
-	value = gst_structure_get_value(structure, "rate");
-	rate = g_value_get_int(value);
-	if (rate == 44100)
-		cfg->frequency = BT_SBC_SAMPLING_FREQ_44100;
-	else if (rate == 48000)
-		cfg->frequency = BT_SBC_SAMPLING_FREQ_48000;
-	else if (rate == 32000)
-		cfg->frequency = BT_SBC_SAMPLING_FREQ_32000;
-	else if (rate == 16000)
-		cfg->frequency = BT_SBC_SAMPLING_FREQ_16000;
-	else {
-		GST_ERROR_OBJECT(sink, "Invalid rate while setting caps");
-		return FALSE;
-	}
-
-	value = gst_structure_get_value(structure, "mode");
-	pref = g_value_get_string(value);
-	if (strcmp(pref, "mono") == 0)
-		cfg->channel_mode = BT_A2DP_CHANNEL_MODE_MONO;
-	else if (strcmp(pref, "dual") == 0)
-		cfg->channel_mode = BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL;
-	else if (strcmp(pref, "stereo") == 0)
-		cfg->channel_mode = BT_A2DP_CHANNEL_MODE_STEREO;
-	else if (strcmp(pref, "joint") == 0)
-		cfg->channel_mode = BT_A2DP_CHANNEL_MODE_JOINT_STEREO;
-	else {
-		GST_ERROR_OBJECT(sink, "Invalid mode %s", pref);
-		return FALSE;
-	}
-
-	value = gst_structure_get_value(structure, "allocation");
-	pref = g_value_get_string(value);
-	if (strcmp(pref, "loudness") == 0)
-		cfg->allocation_method = BT_A2DP_ALLOCATION_LOUDNESS;
-	else if (strcmp(pref, "snr") == 0)
-		cfg->allocation_method = BT_A2DP_ALLOCATION_SNR;
-	else {
-		GST_ERROR_OBJECT(sink, "Invalid allocation: %s", pref);
-		return FALSE;
-	}
-
-	value = gst_structure_get_value(structure, "subbands");
-	subbands = g_value_get_int(value);
-	if (subbands == 8)
-		cfg->subbands = BT_A2DP_SUBBANDS_8;
-	else if (subbands == 4)
-		cfg->subbands = BT_A2DP_SUBBANDS_4;
-	else {
-		GST_ERROR_OBJECT(sink, "Invalid subbands %d", subbands);
-		return FALSE;
-	}
-
-	value = gst_structure_get_value(structure, "blocks");
-	blocks = g_value_get_int(value);
-	if (blocks == 16)
-		cfg->block_length = BT_A2DP_BLOCK_LENGTH_16;
-	else if (blocks == 12)
-		cfg->block_length = BT_A2DP_BLOCK_LENGTH_12;
-	else if (blocks == 8)
-		cfg->block_length = BT_A2DP_BLOCK_LENGTH_8;
-	else if (blocks == 4)
-		cfg->block_length = BT_A2DP_BLOCK_LENGTH_4;
-	else {
-		GST_ERROR_OBJECT(sink, "Invalid blocks %d", blocks);
-		return FALSE;
-	}
-
-	value = gst_structure_get_value(structure, "bitpool");
-	cfg->max_bitpool = cfg->min_bitpool = g_value_get_int(value);
-
-	memcpy(pkt, cfg, sizeof(*pkt));
-
-	return TRUE;
-}
-
-static gboolean gst_avdtp_sink_conf_recv_stream_fd(
-					GstAvdtpSink *self)
-{
-	struct bluetooth_data *data = self->data;
-	gint ret;
-	GError *gerr = NULL;
-	GIOStatus status;
-	GIOFlags flags;
-	int fd;
-
-	/* Proceed if stream was already acquired */
-	if (self->stream != NULL)
-		goto proceed;
-
-	ret = gst_avdtp_sink_bluetooth_recvmsg_fd(self);
-	if (ret < 0)
-		return FALSE;
-
-	if (!self->stream) {
-		GST_ERROR_OBJECT(self, "Error while configuring device: "
-				"could not acquire audio socket");
-		return FALSE;
-	}
-
-proceed:
-	/* set stream socket to nonblock */
-	GST_LOG_OBJECT(self, "setting stream socket to nonblock");
-	flags = g_io_channel_get_flags(self->stream);
-	flags |= G_IO_FLAG_NONBLOCK;
-	status = g_io_channel_set_flags(self->stream, flags, &gerr);
-	if (status != G_IO_STATUS_NORMAL) {
-		if (gerr)
-			GST_WARNING_OBJECT(self, "Error while "
-				"setting server socket to nonblock: "
-				"%s", gerr->message);
-		else
-			GST_WARNING_OBJECT(self, "Error while "
-					"setting server "
-					"socket to nonblock");
-	}
-
-	fd = g_io_channel_unix_get_fd(self->stream);
-
-	/* It is possible there is some outstanding
-	data in the pipe - we have to empty it */
-	GST_LOG_OBJECT(self, "emptying stream pipe");
-	while (1) {
-		ssize_t bread = read(fd, data->buffer, data->link_mtu);
-		if (bread <= 0)
-			break;
-	}
-
-	/* set stream socket to block */
-	GST_LOG_OBJECT(self, "setting stream socket to block");
-	flags = g_io_channel_get_flags(self->stream);
-	flags &= ~G_IO_FLAG_NONBLOCK;
-	status = g_io_channel_set_flags(self->stream, flags, &gerr);
-	if (status != G_IO_STATUS_NORMAL) {
-		if (gerr)
-			GST_WARNING_OBJECT(self, "Error while "
-				"setting server socket to block:"
-				"%s", gerr->message);
-		else
-			GST_WARNING_OBJECT(self, "Error while "
-				"setting server "
-				"socket to block");
-	}
-
-	memset(data->buffer, 0, sizeof(data->buffer));
-
-	return TRUE;
-}
-
-static gboolean server_callback(GIOChannel *chan,
-					GIOCondition cond, gpointer data)
-{
-	if (cond & G_IO_HUP || cond & G_IO_NVAL)
-		return FALSE;
-	else if (cond & G_IO_ERR)
-		GST_WARNING_OBJECT(GST_AVDTP_SINK(data),
-					"Untreated callback G_IO_ERR");
-
-	return TRUE;
-}
-
-static GstStructure *gst_avdtp_sink_parse_sbc_caps(
-			GstAvdtpSink *self, sbc_capabilities_t *sbc)
-{
-	GstStructure *structure;
-	GValue *value;
-	GValue *list;
-	gboolean mono, stereo;
-
-	if (sbc == NULL)
-		return NULL;
-
-	structure = gst_structure_empty_new("audio/x-sbc");
-	value = g_value_init(g_new0(GValue, 1), G_TYPE_STRING);
-
-	/* mode */
-	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_MONO) {
-		g_value_set_static_string(value, "mono");
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) {
-		g_value_set_static_string(value, "stereo");
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) {
-		g_value_set_static_string(value, "dual");
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_JOINT_STEREO) {
-		g_value_set_static_string(value, "joint");
-		gst_value_list_prepend_value(list, value);
-	}
-	g_value_unset(value);
-	if (list) {
-		gst_structure_set_value(structure, "mode", list);
-		g_free(list);
-		list = NULL;
-	}
-
-	/* subbands */
-	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	value = g_value_init(value, G_TYPE_INT);
-	if (sbc->subbands & BT_A2DP_SUBBANDS_4) {
-		g_value_set_int(value, 4);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->subbands & BT_A2DP_SUBBANDS_8) {
-		g_value_set_int(value, 8);
-		gst_value_list_prepend_value(list, value);
-	}
-	g_value_unset(value);
-	if (list) {
-		gst_structure_set_value(structure, "subbands", list);
-		g_free(list);
-		list = NULL;
-	}
-
-	/* blocks */
-	value = g_value_init(value, G_TYPE_INT);
-	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_16) {
-		g_value_set_int(value, 16);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_12) {
-		g_value_set_int(value, 12);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_8) {
-		g_value_set_int(value, 8);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_4) {
-		g_value_set_int(value, 4);
-		gst_value_list_prepend_value(list, value);
-	}
-	g_value_unset(value);
-	if (list) {
-		gst_structure_set_value(structure, "blocks", list);
-		g_free(list);
-		list = NULL;
-	}
-
-	/* allocation */
-	g_value_init(value, G_TYPE_STRING);
-	list = g_value_init(g_new0(GValue,1), GST_TYPE_LIST);
-	if (sbc->allocation_method & BT_A2DP_ALLOCATION_LOUDNESS) {
-		g_value_set_static_string(value, "loudness");
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->allocation_method & BT_A2DP_ALLOCATION_SNR) {
-		g_value_set_static_string(value, "snr");
-		gst_value_list_prepend_value(list, value);
-	}
-	g_value_unset(value);
-	if (list) {
-		gst_structure_set_value(structure, "allocation", list);
-		g_free(list);
-		list = NULL;
-	}
-
-	/* rate */
-	g_value_init(value, G_TYPE_INT);
-	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_48000) {
-		g_value_set_int(value, 48000);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_44100) {
-		g_value_set_int(value, 44100);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_32000) {
-		g_value_set_int(value, 32000);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_16000) {
-		g_value_set_int(value, 16000);
-		gst_value_list_prepend_value(list, value);
-	}
-	g_value_unset(value);
-	if (list) {
-		gst_structure_set_value(structure, "rate", list);
-		g_free(list);
-		list = NULL;
-	}
-
-	/* bitpool */
-	value = g_value_init(value, GST_TYPE_INT_RANGE);
-	gst_value_set_int_range(value,
-			MIN(sbc->min_bitpool, TEMPLATE_MAX_BITPOOL),
-			MIN(sbc->max_bitpool, TEMPLATE_MAX_BITPOOL));
-	gst_structure_set_value(structure, "bitpool", value);
-	g_value_unset(value);
-
-	/* channels */
-	mono = FALSE;
-	stereo = FALSE;
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_MONO)
-		mono = TRUE;
-	if ((sbc->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) ||
-			(sbc->channel_mode &
-			BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) ||
-			(sbc->channel_mode &
-			BT_A2DP_CHANNEL_MODE_JOINT_STEREO))
-		stereo = TRUE;
-
-	if (mono && stereo) {
-		g_value_init(value, GST_TYPE_INT_RANGE);
-		gst_value_set_int_range(value, 1, 2);
-	} else {
-		g_value_init(value, G_TYPE_INT);
-		if (mono)
-			g_value_set_int(value, 1);
-		else if (stereo)
-			g_value_set_int(value, 2);
-		else {
-			GST_ERROR_OBJECT(self,
-				"Unexpected number of channels");
-			g_value_set_int(value, 0);
-		}
-	}
-
-	gst_structure_set_value(structure, "channels", value);
-	g_free(value);
-
-	return structure;
-}
-
-static GstStructure *gst_avdtp_sink_parse_mpeg_caps(
-			GstAvdtpSink *self, mpeg_capabilities_t *mpeg)
-{
-	GstStructure *structure;
-	GValue *value;
-	GValue *list;
-	gboolean valid_layer = FALSE;
-	gboolean mono, stereo;
-
-	if (!mpeg)
-		return NULL;
-
-	GST_LOG_OBJECT(self, "parsing mpeg caps");
-
-	structure = gst_structure_empty_new("audio/mpeg");
-	value = g_new0(GValue, 1);
-	g_value_init(value, G_TYPE_INT);
-
-	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	g_value_set_int(value, 1);
-	gst_value_list_prepend_value(list, value);
-	g_value_set_int(value, 2);
-	gst_value_list_prepend_value(list, value);
-	gst_structure_set_value(structure, "mpegversion", list);
-	g_free(list);
-
-	/* layer */
-	GST_LOG_OBJECT(self, "setting mpeg layer");
-	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (mpeg->layer & BT_MPEG_LAYER_1) {
-		g_value_set_int(value, 1);
-		gst_value_list_prepend_value(list, value);
-		valid_layer = TRUE;
-	}
-	if (mpeg->layer & BT_MPEG_LAYER_2) {
-		g_value_set_int(value, 2);
-		gst_value_list_prepend_value(list, value);
-		valid_layer = TRUE;
-	}
-	if (mpeg->layer & BT_MPEG_LAYER_3) {
-		g_value_set_int(value, 3);
-		gst_value_list_prepend_value(list, value);
-		valid_layer = TRUE;
-	}
-	if (list) {
-		gst_structure_set_value(structure, "layer", list);
-		g_free(list);
-		list = NULL;
-	}
-
-	if (!valid_layer) {
-		gst_structure_free(structure);
-		g_free(value);
-		return NULL;
-	}
+}
 
-	/* rate */
-	GST_LOG_OBJECT(self, "setting mpeg rate");
-	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_48000) {
-		g_value_set_int(value, 48000);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_44100) {
-		g_value_set_int(value, 44100);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_32000) {
-		g_value_set_int(value, 32000);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_24000) {
-		g_value_set_int(value, 24000);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_22050) {
-		g_value_set_int(value, 22050);
-		gst_value_list_prepend_value(list, value);
-	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_16000) {
-		g_value_set_int(value, 16000);
-		gst_value_list_prepend_value(list, value);
-	}
-	g_value_unset(value);
-	if (list) {
-		gst_structure_set_value(structure, "rate", list);
-		g_free(list);
-		list = NULL;
-	}
+static void gst_avdtp_sink_get_property(GObject *object, guint prop_id,
+					GValue *value, GParamSpec *pspec)
+{
+	GstAvdtpSink *sink = GST_AVDTP_SINK(object);
 
-	/* channels */
-	GST_LOG_OBJECT(self, "setting mpeg channels");
-	mono = FALSE;
-	stereo = FALSE;
-	if (mpeg->channel_mode & BT_A2DP_CHANNEL_MODE_MONO)
-		mono = TRUE;
-	if ((mpeg->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) ||
-			(mpeg->channel_mode &
-			BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) ||
-			(mpeg->channel_mode &
-			BT_A2DP_CHANNEL_MODE_JOINT_STEREO))
-		stereo = TRUE;
+	switch (prop_id) {
+	case PROP_DEVICE:
+		g_value_set_string(value, sink->device);
+		break;
 
-	if (mono && stereo) {
-		g_value_init(value, GST_TYPE_INT_RANGE);
-		gst_value_set_int_range(value, 1, 2);
-	} else {
-		g_value_init(value, G_TYPE_INT);
-		if (mono)
-			g_value_set_int(value, 1);
-		else if (stereo)
-			g_value_set_int(value, 2);
-		else {
-			GST_ERROR_OBJECT(self,
-				"Unexpected number of channels");
-			g_value_set_int(value, 0);
-		}
-	}
-	gst_structure_set_value(structure, "channels", value);
-	g_free(value);
+	case PROP_AUTOCONNECT:
+		g_value_set_boolean(value, sink->autoconnect);
+		break;
 
-	return structure;
+	case PROP_TRANSPORT:
+		g_value_set_string(value, sink->transport);
+		break;
+
+	default:
+		G_OBJECT_WARN_INVALID_PROPERTY_ID(object, prop_id, pspec);
+		break;
+	}
 }
 
 static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
@@ -795,19 +265,19 @@ static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
 
 	/* mode */
 	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_MONO) {
+	if (sbc->channel_mode & SBC_CHANNEL_MODE_MONO) {
 		g_value_set_static_string(value, "mono");
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) {
+	if (sbc->channel_mode & SBC_CHANNEL_MODE_STEREO) {
 		g_value_set_static_string(value, "stereo");
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) {
+	if (sbc->channel_mode & SBC_CHANNEL_MODE_DUAL_CHANNEL) {
 		g_value_set_static_string(value, "dual");
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_JOINT_STEREO) {
+	if (sbc->channel_mode & SBC_CHANNEL_MODE_JOINT_STEREO) {
 		g_value_set_static_string(value, "joint");
 		gst_value_list_prepend_value(list, value);
 	}
@@ -821,11 +291,11 @@ static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
 	/* subbands */
 	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
 	value = g_value_init(value, G_TYPE_INT);
-	if (sbc->subbands & BT_A2DP_SUBBANDS_4) {
+	if (sbc->subbands & SBC_SUBBANDS_4) {
 		g_value_set_int(value, 4);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->subbands & BT_A2DP_SUBBANDS_8) {
+	if (sbc->subbands & SBC_SUBBANDS_8) {
 		g_value_set_int(value, 8);
 		gst_value_list_prepend_value(list, value);
 	}
@@ -839,19 +309,19 @@ static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
 	/* blocks */
 	value = g_value_init(value, G_TYPE_INT);
 	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_16) {
+	if (sbc->block_length & SBC_BLOCK_LENGTH_16) {
 		g_value_set_int(value, 16);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_12) {
+	if (sbc->block_length & SBC_BLOCK_LENGTH_12) {
 		g_value_set_int(value, 12);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_8) {
+	if (sbc->block_length & SBC_BLOCK_LENGTH_8) {
 		g_value_set_int(value, 8);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->block_length & BT_A2DP_BLOCK_LENGTH_4) {
+	if (sbc->block_length & SBC_BLOCK_LENGTH_4) {
 		g_value_set_int(value, 4);
 		gst_value_list_prepend_value(list, value);
 	}
@@ -865,11 +335,11 @@ static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
 	/* allocation */
 	g_value_init(value, G_TYPE_STRING);
 	list = g_value_init(g_new0(GValue,1), GST_TYPE_LIST);
-	if (sbc->allocation_method & BT_A2DP_ALLOCATION_LOUDNESS) {
+	if (sbc->allocation_method & SBC_ALLOCATION_LOUDNESS) {
 		g_value_set_static_string(value, "loudness");
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->allocation_method & BT_A2DP_ALLOCATION_SNR) {
+	if (sbc->allocation_method & SBC_ALLOCATION_SNR) {
 		g_value_set_static_string(value, "snr");
 		gst_value_list_prepend_value(list, value);
 	}
@@ -883,19 +353,19 @@ static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
 	/* rate */
 	g_value_init(value, G_TYPE_INT);
 	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_48000) {
+	if (sbc->frequency & SBC_SAMPLING_FREQ_48000) {
 		g_value_set_int(value, 48000);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_44100) {
+	if (sbc->frequency & SBC_SAMPLING_FREQ_44100) {
 		g_value_set_int(value, 44100);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_32000) {
+	if (sbc->frequency & SBC_SAMPLING_FREQ_32000) {
 		g_value_set_int(value, 32000);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (sbc->frequency & BT_SBC_SAMPLING_FREQ_16000) {
+	if (sbc->frequency & SBC_SAMPLING_FREQ_16000) {
 		g_value_set_int(value, 16000);
 		gst_value_list_prepend_value(list, value);
 	}
@@ -917,13 +387,13 @@ static GstStructure *gst_avdtp_sink_parse_sbc_raw(GstAvdtpSink *self)
 	/* channels */
 	mono = FALSE;
 	stereo = FALSE;
-	if (sbc->channel_mode & BT_A2DP_CHANNEL_MODE_MONO)
+	if (sbc->channel_mode & SBC_CHANNEL_MODE_MONO)
 		mono = TRUE;
-	if ((sbc->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) ||
+	if ((sbc->channel_mode & SBC_CHANNEL_MODE_STEREO) ||
 			(sbc->channel_mode &
-			BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) ||
+			SBC_CHANNEL_MODE_DUAL_CHANNEL) ||
 			(sbc->channel_mode &
-			BT_A2DP_CHANNEL_MODE_JOINT_STEREO))
+			SBC_CHANNEL_MODE_JOINT_STEREO))
 		stereo = TRUE;
 
 	if (mono && stereo) {
@@ -974,17 +444,17 @@ static GstStructure *gst_avdtp_sink_parse_mpeg_raw(GstAvdtpSink *self)
 	/* layer */
 	GST_LOG_OBJECT(self, "setting mpeg layer");
 	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (mpeg->layer & BT_MPEG_LAYER_1) {
+	if (mpeg->layer & MPEG_LAYER_MP1) {
 		g_value_set_int(value, 1);
 		gst_value_list_prepend_value(list, value);
 		valid_layer = TRUE;
 	}
-	if (mpeg->layer & BT_MPEG_LAYER_2) {
+	if (mpeg->layer & MPEG_LAYER_MP2) {
 		g_value_set_int(value, 2);
 		gst_value_list_prepend_value(list, value);
 		valid_layer = TRUE;
 	}
-	if (mpeg->layer & BT_MPEG_LAYER_3) {
+	if (mpeg->layer & MPEG_LAYER_MP3) {
 		g_value_set_int(value, 3);
 		gst_value_list_prepend_value(list, value);
 		valid_layer = TRUE;
@@ -1004,27 +474,27 @@ static GstStructure *gst_avdtp_sink_parse_mpeg_raw(GstAvdtpSink *self)
 	/* rate */
 	GST_LOG_OBJECT(self, "setting mpeg rate");
 	list = g_value_init(g_new0(GValue, 1), GST_TYPE_LIST);
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_48000) {
+	if (mpeg->frequency & MPEG_SAMPLING_FREQ_48000) {
 		g_value_set_int(value, 48000);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_44100) {
+	if (mpeg->frequency & MPEG_SAMPLING_FREQ_44100) {
 		g_value_set_int(value, 44100);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_32000) {
+	if (mpeg->frequency & MPEG_SAMPLING_FREQ_32000) {
 		g_value_set_int(value, 32000);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_24000) {
+	if (mpeg->frequency & MPEG_SAMPLING_FREQ_24000) {
 		g_value_set_int(value, 24000);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_22050) {
+	if (mpeg->frequency & MPEG_SAMPLING_FREQ_22050) {
 		g_value_set_int(value, 22050);
 		gst_value_list_prepend_value(list, value);
 	}
-	if (mpeg->frequency & BT_MPEG_SAMPLING_FREQ_16000) {
+	if (mpeg->frequency & MPEG_SAMPLING_FREQ_16000) {
 		g_value_set_int(value, 16000);
 		gst_value_list_prepend_value(list, value);
 	}
@@ -1039,13 +509,13 @@ static GstStructure *gst_avdtp_sink_parse_mpeg_raw(GstAvdtpSink *self)
 	GST_LOG_OBJECT(self, "setting mpeg channels");
 	mono = FALSE;
 	stereo = FALSE;
-	if (mpeg->channel_mode & BT_A2DP_CHANNEL_MODE_MONO)
+	if (mpeg->channel_mode & MPEG_CHANNEL_MODE_MONO)
 		mono = TRUE;
-	if ((mpeg->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO) ||
+	if ((mpeg->channel_mode & MPEG_CHANNEL_MODE_STEREO) ||
 			(mpeg->channel_mode &
-			BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL) ||
+			MPEG_CHANNEL_MODE_DUAL_CHANNEL) ||
 			(mpeg->channel_mode &
-			BT_A2DP_CHANNEL_MODE_JOINT_STEREO))
+			MPEG_CHANNEL_MODE_JOINT_STEREO))
 		stereo = TRUE;
 
 	if (mono && stereo) {
@@ -1103,94 +573,24 @@ static gboolean gst_avdtp_sink_update_config(GstAvdtpSink *self)
 
 static gboolean gst_avdtp_sink_update_caps(GstAvdtpSink *self)
 {
-	sbc_capabilities_t *sbc;
-	mpeg_capabilities_t *mpeg;
-	GstStructure *sbc_structure;
-	GstStructure *mpeg_structure;
-	gchar *tmp;
-
 	GST_LOG_OBJECT(self, "updating device caps");
 
-	if (self->data->config_size != 0 && self->data->config != NULL)
-		return gst_avdtp_sink_update_config(self);
-
-	sbc = (void *) gst_avdtp_find_caps(self, BT_A2DP_SBC_SINK);
-	mpeg = (void *) gst_avdtp_find_caps(self, BT_A2DP_MPEG12_SINK);
-
-	if (!sbc) {
-		GST_ERROR_OBJECT(self, "Failed to find mandatory SBC sink");
-		return FALSE;
-	}
-
-	sbc_structure = gst_avdtp_sink_parse_sbc_caps(self, sbc);
-	mpeg_structure = gst_avdtp_sink_parse_mpeg_caps(self, mpeg);
-
-	if (self->dev_caps != NULL)
-		gst_caps_unref(self->dev_caps);
-	self->dev_caps = gst_caps_new_full(sbc_structure, NULL);
-	if (mpeg_structure != NULL)
-		gst_caps_append_structure(self->dev_caps, mpeg_structure);
-
-	tmp = gst_caps_to_string(self->dev_caps);
-	GST_DEBUG_OBJECT(self, "Device capabilities: %s", tmp);
-	g_free(tmp);
-
-	return TRUE;
-}
-
-static gboolean gst_avdtp_sink_get_capabilities(GstAvdtpSink *self)
-{
-	gchar buf[BT_SUGGESTED_BUFFER_SIZE];
-	struct bt_get_capabilities_req *req = (void *) buf;
-	struct bt_get_capabilities_rsp *rsp = (void *) buf;
-	int err;
-
-	memset(req, 0, BT_SUGGESTED_BUFFER_SIZE);
-
-	req->h.type = BT_REQUEST;
-	req->h.name = BT_GET_CAPABILITIES;
-	req->h.length = sizeof(*req);
-
-	if (self->device == NULL)
-		return FALSE;
-	strncpy(req->destination, self->device, 18);
-	if (self->autoconnect)
-		req->flags |= BT_FLAG_AUTOCONNECT;
-
-	err = gst_avdtp_sink_audioservice_send(self, &req->h);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error while asking device caps");
+	if (self->data->config_size == 0 || self->data->config == NULL)
 		return FALSE;
-	}
-
-	rsp->h.length = 0;
-	err = gst_avdtp_sink_audioservice_expect(self,
-					&rsp->h, BT_GET_CAPABILITIES);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error while getting device caps");
-		return FALSE;
-	}
 
-	self->data->caps = g_malloc0(rsp->h.length);
-	memcpy(self->data->caps, rsp, rsp->h.length);
-	if (!gst_avdtp_sink_update_caps(self)) {
-		GST_WARNING_OBJECT(self, "failed to update capabilities");
-		return FALSE;
-	}
-
-	return TRUE;
+	return gst_avdtp_sink_update_config(self);
 }
 
 static gint gst_avdtp_sink_get_channel_mode(const gchar *mode)
 {
 	if (strcmp(mode, "stereo") == 0)
-		return BT_A2DP_CHANNEL_MODE_STEREO;
+		return SBC_CHANNEL_MODE_STEREO;
 	else if (strcmp(mode, "joint-stereo") == 0)
-		return BT_A2DP_CHANNEL_MODE_JOINT_STEREO;
+		return SBC_CHANNEL_MODE_JOINT_STEREO;
 	else if (strcmp(mode, "dual-channel") == 0)
-		return BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL;
+		return SBC_CHANNEL_MODE_DUAL_CHANNEL;
 	else if (strcmp(mode, "mono") == 0)
-		return BT_A2DP_CHANNEL_MODE_MONO;
+		return SBC_CHANNEL_MODE_MONO;
 	else
 		return -1;
 }
@@ -1433,8 +833,6 @@ fail:
 static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 {
 	GstAvdtpSink *self = GST_AVDTP_SINK(basesink);
-	gint sk;
-	gint err;
 
 	GST_INFO_OBJECT(self, "start");
 
@@ -1445,258 +843,71 @@ static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 	self->mp3_using_crc = -1;
 	self->channel_mode = -1;
 
-	if (self->transport != NULL)
-		return gst_avdtp_sink_transport_get_properties(self);
-
-	self->watch_id = 0;
-
-	sk = bt_audio_service_open();
-	if (sk < 0) {
-		err = -errno;
-		GST_ERROR_OBJECT(self, "Cannot open connection to bt "
-			"audio service: %s %d", strerror(-err), -err);
-		return FALSE;
-	}
-
-	self->server = g_io_channel_unix_new(sk);
-	g_io_channel_set_encoding(self->server, NULL, NULL);
-	self->watch_id = g_io_add_watch(self->server, G_IO_HUP | G_IO_ERR |
-					G_IO_NVAL, server_callback, self);
-
-	if (!gst_avdtp_sink_get_capabilities(self)) {
-		GST_ERROR_OBJECT(self, "failed to get capabilities "
-				"from device");
-		goto failed;
-	}
-
-	return TRUE;
-
-failed:
-	bt_audio_service_close(sk);
-	return FALSE;
-}
-
-static gboolean gst_avdtp_sink_stream_start(GstAvdtpSink *self)
-{
-	gchar buf[BT_SUGGESTED_BUFFER_SIZE];
-	struct bt_start_stream_req *req = (void *) buf;
-	struct bt_start_stream_rsp *rsp = (void *) buf;
-	struct bt_new_stream_ind *ind = (void *) buf;
-	int err;
-
-	if (self->transport != NULL)
-		return gst_avdtp_sink_conf_recv_stream_fd(self);
-
-	memset(req, 0, sizeof(buf));
-	req->h.type = BT_REQUEST;
-	req->h.name = BT_START_STREAM;
-	req->h.length = sizeof(*req);
-
-	err = gst_avdtp_sink_audioservice_send(self, &req->h);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error occurred while sending "
-					"start packet");
-		return FALSE;
-	}
-
-	rsp->h.length = sizeof(*rsp);
-	err = gst_avdtp_sink_audioservice_expect(self, &rsp->h,
-							BT_START_STREAM);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error while stream "
-			"start confirmation");
-		return FALSE;
-	}
-
-	ind->h.length = sizeof(*ind);
-	err = gst_avdtp_sink_audioservice_expect(self, &ind->h,
-							BT_NEW_STREAM);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error while receiving "
-			"stream filedescriptor");
-		return FALSE;
-	}
-
-	if (!gst_avdtp_sink_conf_recv_stream_fd(self))
-		return FALSE;
-
-	return TRUE;
-}
-
-static gboolean gst_avdtp_sink_init_mp3_pkt_conf(
-		GstAvdtpSink *self, GstCaps *caps,
-		mpeg_capabilities_t *pkt)
-{
-	const GValue *value = NULL;
-	gint rate, layer;
-	const gchar *name;
-	GstStructure *structure = gst_caps_get_structure(caps, 0);
-
-	name = gst_structure_get_name(structure);
-
-	if (!(IS_MPEG_AUDIO(name))) {
-		GST_ERROR_OBJECT(self, "Unexpected format %s, "
-				"was expecting mp3", name);
-		return FALSE;
-	}
-
-	/* layer */
-	value = gst_structure_get_value(structure, "layer");
-	layer = g_value_get_int(value);
-	if (layer == 1)
-		pkt->layer = BT_MPEG_LAYER_1;
-	else if (layer == 2)
-		pkt->layer = BT_MPEG_LAYER_2;
-	else if (layer == 3)
-		pkt->layer = BT_MPEG_LAYER_3;
-	else {
-		GST_ERROR_OBJECT(self, "Unexpected layer: %d", layer);
-		return FALSE;
-	}
-
-	/* crc */
-	if (self->mp3_using_crc != -1)
-		pkt->crc = self->mp3_using_crc;
-	else {
-		GST_ERROR_OBJECT(self, "No info about crc was received, "
-				" can't proceed");
-		return FALSE;
-	}
-
-	/* channel mode */
-	if (self->channel_mode != -1)
-		pkt->channel_mode = self->channel_mode;
-	else {
-		GST_ERROR_OBJECT(self, "No info about channel mode "
-				"received, can't proceed");
-		return FALSE;
-	}
-
-	/* mpf - we will only use the mandatory one */
-	pkt->mpf = 0;
-
-	value = gst_structure_get_value(structure, "rate");
-	rate = g_value_get_int(value);
-	if (rate == 44100)
-		pkt->frequency = BT_MPEG_SAMPLING_FREQ_44100;
-	else if (rate == 48000)
-		pkt->frequency = BT_MPEG_SAMPLING_FREQ_48000;
-	else if (rate == 32000)
-		pkt->frequency = BT_MPEG_SAMPLING_FREQ_32000;
-	else if (rate == 24000)
-		pkt->frequency = BT_MPEG_SAMPLING_FREQ_24000;
-	else if (rate == 22050)
-		pkt->frequency = BT_MPEG_SAMPLING_FREQ_22050;
-	else if (rate == 16000)
-		pkt->frequency = BT_MPEG_SAMPLING_FREQ_16000;
-	else {
-		GST_ERROR_OBJECT(self, "Invalid rate while setting caps");
+	if (self->transport == NULL)
 		return FALSE;
-	}
 
-	/* vbr - we always say its vbr, we don't have how to know it */
-	pkt->bitrate = 0x8000;
-
-	return TRUE;
+	return gst_avdtp_sink_transport_get_properties(self);
 }
 
-static gboolean gst_avdtp_sink_configure(GstAvdtpSink *self,
-			GstCaps *caps)
+static gboolean gst_avdtp_sink_conf_recv_stream_fd(GstAvdtpSink *self)
 {
-	gchar buf[BT_SUGGESTED_BUFFER_SIZE];
-	struct bt_open_req *open_req = (void *) buf;
-	struct bt_open_rsp *open_rsp = (void *) buf;
-	struct bt_set_configuration_req *req = (void *) buf;
-	struct bt_set_configuration_rsp *rsp = (void *) buf;
-	gboolean ret;
-	gchar *temp;
-	GstStructure *structure;
-	codec_capabilities_t *codec = NULL;
-	int err;
-
-	temp = gst_caps_to_string(caps);
-	GST_DEBUG_OBJECT(self, "configuring device with caps: %s", temp);
-	g_free(temp);
-
-	/* Transport already configured */
-	if (self->transport != NULL)
-		return TRUE;
-
-	structure = gst_caps_get_structure(caps, 0);
-
-	if (gst_structure_has_name(structure, "audio/x-sbc"))
-		codec = (void *) gst_avdtp_find_caps(self, BT_A2DP_SBC_SINK);
-	else if (gst_structure_has_name(structure, "audio/mpeg"))
-		codec = (void *) gst_avdtp_find_caps(self, BT_A2DP_MPEG12_SINK);
-
-	if (codec == NULL) {
-		GST_ERROR_OBJECT(self, "Couldn't parse caps "
-				"to packet configuration");
-		return FALSE;
-	}
-
-	memset(req, 0, BT_SUGGESTED_BUFFER_SIZE);
-	open_req->h.type = BT_REQUEST;
-	open_req->h.name = BT_OPEN;
-	open_req->h.length = sizeof(*open_req);
-
-	strncpy(open_req->destination, self->device, 18);
-	open_req->seid = codec->seid;
-	open_req->lock = BT_WRITE_LOCK;
+	struct bluetooth_data *data = self->data;
+	GError *gerr = NULL;
+	GIOStatus status;
+	GIOFlags flags;
+	int fd;
 
-	err = gst_avdtp_sink_audioservice_send(self, &open_req->h);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error occurred while sending "
-					"open packet");
+	/* Proceed if stream was already acquired */
+	if (self->stream == NULL) {
+		GST_ERROR_OBJECT(self, "Error while configuring device: "
+				"could not acquire audio socket");
 		return FALSE;
 	}
 
-	open_rsp->h.length = sizeof(*open_rsp);
-	err = gst_avdtp_sink_audioservice_expect(self, &open_rsp->h,
-								BT_OPEN);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error while receiving device "
-					"confirmation");
-		return FALSE;
+	/* set stream socket to nonblock */
+	GST_LOG_OBJECT(self, "setting stream socket to nonblock");
+	flags = g_io_channel_get_flags(self->stream);
+	flags |= G_IO_FLAG_NONBLOCK;
+	status = g_io_channel_set_flags(self->stream, flags, &gerr);
+	if (status != G_IO_STATUS_NORMAL) {
+		if (gerr)
+			GST_WARNING_OBJECT(self, "Error while "
+				"setting server socket to nonblock: "
+				"%s", gerr->message);
+		else
+			GST_WARNING_OBJECT(self, "Error while "
+					"setting server "
+					"socket to nonblock");
 	}
 
-	memset(req, 0, sizeof(buf));
-	req->h.type = BT_REQUEST;
-	req->h.name = BT_SET_CONFIGURATION;
-	req->h.length = sizeof(*req);
-	memcpy(&req->codec, codec, sizeof(req->codec));
-
-	if (codec->type == BT_A2DP_SBC_SINK)
-		ret = gst_avdtp_sink_init_sbc_pkt_conf(self, caps,
-				(void *) &req->codec);
-	else
-		ret = gst_avdtp_sink_init_mp3_pkt_conf(self, caps,
-				(void *) &req->codec);
-
-	if (!ret) {
-		GST_ERROR_OBJECT(self, "Couldn't parse caps "
-				"to packet configuration");
-		return FALSE;
-	}
+	fd = g_io_channel_unix_get_fd(self->stream);
 
-	req->h.length += req->codec.length - sizeof(req->codec);
-	err = gst_avdtp_sink_audioservice_send(self, &req->h);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error occurred while sending "
-					"configurarion packet");
-		return FALSE;
+	/* It is possible there is some outstanding
+	data in the pipe - we have to empty it */
+	GST_LOG_OBJECT(self, "emptying stream pipe");
+	while (1) {
+		ssize_t bread = read(fd, data->buffer, data->link_mtu);
+		if (bread <= 0)
+			break;
 	}
 
-	rsp->h.length = sizeof(*rsp);
-	err = gst_avdtp_sink_audioservice_expect(self, &rsp->h,
-							BT_SET_CONFIGURATION);
-	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error while receiving device "
-					"confirmation");
-		return FALSE;
+	/* set stream socket to block */
+	GST_LOG_OBJECT(self, "setting stream socket to block");
+	flags = g_io_channel_get_flags(self->stream);
+	flags &= ~G_IO_FLAG_NONBLOCK;
+	status = g_io_channel_set_flags(self->stream, flags, &gerr);
+	if (status != G_IO_STATUS_NORMAL) {
+		if (gerr)
+			GST_WARNING_OBJECT(self, "Error while "
+				"setting server socket to block:"
+				"%s", gerr->message);
+		else
+			GST_WARNING_OBJECT(self, "Error while "
+				"setting server "
+				"socket to block");
 	}
 
-	self->data->link_mtu = rsp->link_mtu;
+	memset(data->buffer, 0, sizeof(data->buffer));
 
 	return TRUE;
 }
@@ -1709,7 +920,7 @@ static GstFlowReturn gst_avdtp_sink_preroll(GstBaseSink *basesink,
 
 	GST_AVDTP_SINK_MUTEX_LOCK(sink);
 
-	ret = gst_avdtp_sink_stream_start(sink);
+	ret = gst_avdtp_sink_conf_recv_stream_fd(sink);
 
 	GST_AVDTP_SINK_MUTEX_UNLOCK(sink);
 
@@ -1838,101 +1049,6 @@ static void gst_avdtp_sink_init(GstAvdtpSink *self,
 	*/
 }
 
-static int gst_avdtp_sink_audioservice_send(GstAvdtpSink *self,
-					const bt_audio_msg_header_t *msg)
-{
-	ssize_t written;
-	const char *type, *name;
-	uint16_t length;
-	int fd, err;
-
-	length = msg->length ? msg->length : BT_SUGGESTED_BUFFER_SIZE;
-
-	fd = g_io_channel_unix_get_fd(self->server);
-
-	written = write(fd, msg, length);
-	if (written < 0) {
-		err = -errno;
-		GST_ERROR_OBJECT(self, "Error sending data to audio service:"
-			" %s", strerror(-err));
-		return err;
-	}
-
-	type = bt_audio_strtype(msg->type);
-	name = bt_audio_strname(msg->name);
-
-	GST_DEBUG_OBJECT(self, "sent: %s -> %s", type, name);
-
-	return 0;
-}
-
-static int gst_avdtp_sink_audioservice_recv(GstAvdtpSink *self,
-						bt_audio_msg_header_t *inmsg)
-{
-	ssize_t bytes_read;
-	const char *type, *name;
-	uint16_t length;
-	int fd, err = 0;
-
-	length = inmsg->length ? inmsg->length : BT_SUGGESTED_BUFFER_SIZE;
-
-	fd = g_io_channel_unix_get_fd(self->server);
-
-	bytes_read = read(fd, inmsg, length);
-	if (bytes_read < 0) {
-		err = -errno;
-		GST_ERROR_OBJECT(self, "Error receiving data from "
-				"audio service: %s", strerror(-err));
-		return err;
-	}
-
-	type = bt_audio_strtype(inmsg->type);
-	if (!type) {
-		err = -EINVAL;
-		GST_ERROR_OBJECT(self, "Bogus message type %d "
-				"received from audio service",
-				inmsg->type);
-	}
-
-	name = bt_audio_strname(inmsg->name);
-	if (!name) {
-		err = -EINVAL;
-		GST_ERROR_OBJECT(self, "Bogus message name %d "
-				"received from audio service",
-				inmsg->name);
-	}
-
-	if (inmsg->type == BT_ERROR) {
-		bt_audio_error_t *msg = (void *) inmsg;
-		err = -EINVAL;
-		GST_ERROR_OBJECT(self, "%s failed : "
-					"%s(%d)",
-					name,
-					strerror(msg->posix_errno),
-					msg->posix_errno);
-	}
-
-	GST_DEBUG_OBJECT(self, "received: %s <- %s", type, name);
-
-	return err;
-}
-
-static int gst_avdtp_sink_audioservice_expect(GstAvdtpSink *self,
-						bt_audio_msg_header_t *outmsg,
-						guint8 expected_name)
-{
-	int err;
-
-	err = gst_avdtp_sink_audioservice_recv(self, outmsg);
-	if (err < 0)
-		return err;
-
-	if (outmsg->name != expected_name)
-		return -EINVAL;
-
-	return 0;
-}
-
 gboolean gst_avdtp_sink_plugin_init(GstPlugin *plugin)
 {
 	return gst_element_register(plugin, "avdtpsink", GST_RANK_NONE,
@@ -1952,11 +1068,8 @@ GstCaps *gst_avdtp_sink_get_device_caps(GstAvdtpSink *sink)
 gboolean gst_avdtp_sink_set_device_caps(GstAvdtpSink *self,
 			GstCaps *caps)
 {
-	gboolean ret;
-
 	GST_DEBUG_OBJECT(self, "setting device caps");
 	GST_AVDTP_SINK_MUTEX_LOCK(self);
-	ret = gst_avdtp_sink_configure(self, caps);
 
 	if (self->stream_caps)
 		gst_caps_unref(self->stream_caps);
@@ -1964,7 +1077,7 @@ gboolean gst_avdtp_sink_set_device_caps(GstAvdtpSink *self,
 
 	GST_AVDTP_SINK_MUTEX_UNLOCK(self);
 
-	return ret;
+	return TRUE;
 }
 
 guint gst_avdtp_sink_get_link_mtu(GstAvdtpSink *sink)
diff --git a/audio/gstavdtpsink.h b/audio/gstavdtpsink.h
index c4e5645..eb998ac 100644
--- a/audio/gstavdtpsink.h
+++ b/audio/gstavdtpsink.h
@@ -56,7 +56,6 @@ struct _GstAvdtpSink {
 
 	struct bluetooth_data *data;
 	gboolean autoconnect;
-	GIOChannel *server;
 
 	/* mp3 stream data (outside caps data)*/
 	gint mp3_using_crc;
diff --git a/audio/ipc.c b/audio/ipc.c
deleted file mode 100644
index 02d956b..0000000
--- a/audio/ipc.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#include "ipc.h"
-
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
-/* This table contains the string representation for messages types */
-static const char *strtypes[] = {
-	"BT_REQUEST",
-	"BT_RESPONSE",
-	"BT_INDICATION",
-	"BT_ERROR",
-};
-
-/* This table contains the string representation for messages names */
-static const char *strnames[] = {
-	"BT_GET_CAPABILITIES",
-	"BT_OPEN",
-	"BT_SET_CONFIGURATION",
-	"BT_NEW_STREAM",
-	"BT_START_STREAM",
-	"BT_STOP_STREAM",
-	"BT_SUSPEND_STREAM",
-	"BT_RESUME_STREAM",
-	"BT_CONTROL",
-};
-
-int bt_audio_service_open(void)
-{
-	int sk;
-	int err;
-	struct sockaddr_un addr = {
-		AF_UNIX, BT_IPC_SOCKET_NAME
-	};
-
-	sk = socket(PF_LOCAL, SOCK_STREAM, 0);
-	if (sk < 0) {
-		err = -errno;
-		fprintf(stderr, "%s: Cannot open socket: %s (%d)\n",
-			__FUNCTION__, strerror(-err), -err);
-		errno = -err;
-		return -1;
-	}
-
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = -errno;
-		fprintf(stderr, "%s: connect() failed: %s (%d)\n",
-			__FUNCTION__, strerror(-err), -err);
-		close(sk);
-		errno = -err;
-		return -1;
-	}
-
-	return sk;
-}
-
-int bt_audio_service_close(int sk)
-{
-	return close(sk);
-}
-
-int bt_audio_service_get_data_fd(int sk)
-{
-	char cmsg_b[CMSG_SPACE(sizeof(int))], m;
-	int err, ret;
-	struct iovec iov = { &m, sizeof(m) };
-	struct msghdr msgh;
-	struct cmsghdr *cmsg;
-
-	memset(&msgh, 0, sizeof(msgh));
-	msgh.msg_iov = &iov;
-	msgh.msg_iovlen = 1;
-	msgh.msg_control = &cmsg_b;
-	msgh.msg_controllen = CMSG_LEN(sizeof(int));
-
-	ret = recvmsg(sk, &msgh, 0);
-	if (ret < 0) {
-		err = -errno;
-		fprintf(stderr, "%s: Unable to receive fd: %s (%d)\n",
-			__FUNCTION__, strerror(-err), -err);
-		errno = -err;
-		return -1;
-	}
-
-	/* Receive auxiliary data in msgh */
-	for (cmsg = CMSG_FIRSTHDR(&msgh); cmsg != NULL;
-			cmsg = CMSG_NXTHDR(&msgh, cmsg)) {
-		if (cmsg->cmsg_level == SOL_SOCKET
-				&& cmsg->cmsg_type == SCM_RIGHTS) {
-			memcpy(&ret, CMSG_DATA(cmsg), sizeof(int));
-			return ret;
-		}
-	}
-
-	errno = EINVAL;
-	return -1;
-}
-
-const char *bt_audio_strtype(uint8_t type)
-{
-	if (type >= ARRAY_SIZE(strtypes))
-		return NULL;
-
-	return strtypes[type];
-}
-
-const char *bt_audio_strname(uint8_t name)
-{
-	if (name >= ARRAY_SIZE(strnames))
-		return NULL;
-
-	return strnames[name];
-}
diff --git a/audio/ipc.h b/audio/ipc.h
deleted file mode 100644
index 61ae019..0000000
--- a/audio/ipc.h
+++ /dev/null
@@ -1,361 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-/*
-  Message sequence chart of streaming sequence for A2DP transport
-
-  Audio daemon			User
-				on snd_pcm_open
-				<--BT_GET_CAPABILITIES_REQ
-
-  BT_GET_CAPABILITIES_RSP-->
-
-				on snd_pcm_hw_params
-				<--BT_SETCONFIGURATION_REQ
-
-  BT_SET_CONFIGURATION_RSP-->
-
-				on snd_pcm_prepare
-				<--BT_START_STREAM_REQ
-
-  <Moves to streaming state>
-  BT_START_STREAM_RSP-->
-
-  BT_NEW_STREAM_IND -->
-
-				<  streams data >
-				..........
-
-				on snd_pcm_drop/snd_pcm_drain
-
-				<--BT_STOP_STREAM_REQ
-
-  <Moves to open state>
-  BT_STOP_STREAM_RSP-->
-
-				on IPC close or appl crash
-  <Moves to idle>
-
- */
-
-#ifndef BT_AUDIOCLIENT_H
-#define BT_AUDIOCLIENT_H
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#include <stdint.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <errno.h>
-
-#define BT_SUGGESTED_BUFFER_SIZE   512
-#define BT_IPC_SOCKET_NAME "\0/org/bluez/audio"
-
-/* Generic message header definition, except for RESPONSE messages */
-typedef struct {
-	uint8_t type;
-	uint8_t name;
-	uint16_t length;
-} __attribute__ ((packed)) bt_audio_msg_header_t;
-
-typedef struct {
-	bt_audio_msg_header_t h;
-	uint8_t posix_errno;
-} __attribute__ ((packed)) bt_audio_error_t;
-
-/* Message types */
-#define BT_REQUEST			0
-#define BT_RESPONSE			1
-#define BT_INDICATION			2
-#define BT_ERROR			3
-
-/* Messages names */
-#define BT_GET_CAPABILITIES		0
-#define BT_OPEN				1
-#define BT_SET_CONFIGURATION		2
-#define BT_NEW_STREAM			3
-#define BT_START_STREAM			4
-#define BT_STOP_STREAM			5
-#define BT_CLOSE			6
-#define BT_CONTROL			7
-#define BT_DELAY_REPORT			8
-
-#define BT_CAPABILITIES_TRANSPORT_A2DP	0
-#define BT_CAPABILITIES_TRANSPORT_SCO	1
-#define BT_CAPABILITIES_TRANSPORT_ANY	2
-
-#define BT_CAPABILITIES_ACCESS_MODE_READ	1
-#define BT_CAPABILITIES_ACCESS_MODE_WRITE	2
-#define BT_CAPABILITIES_ACCESS_MODE_READWRITE	3
-
-#define BT_FLAG_AUTOCONNECT	1
-
-struct bt_get_capabilities_req {
-	bt_audio_msg_header_t	h;
-	char			source[18];	/* Address of the local Device */
-	char			destination[18];/* Address of the remote Device */
-	char			object[128];	/* DBus object path */
-	uint8_t			transport;	/* Requested transport */
-	uint8_t			flags;		/* Requested flags */
-	uint8_t			seid;		/* Requested capability configuration */
-} __attribute__ ((packed));
-
-/**
- * SBC Codec parameters as per A2DP profile 1.0 § 4.3
- */
-
-/* A2DP seid are 6 bytes long so HSP/HFP are assigned to 7-8 bits */
-#define BT_A2DP_SEID_RANGE			(1 << 6) - 1
-
-#define BT_A2DP_SBC_SOURCE			0x00
-#define BT_A2DP_SBC_SINK			0x01
-#define BT_A2DP_MPEG12_SOURCE			0x02
-#define BT_A2DP_MPEG12_SINK			0x03
-#define BT_A2DP_MPEG24_SOURCE			0x04
-#define BT_A2DP_MPEG24_SINK			0x05
-#define BT_A2DP_ATRAC_SOURCE			0x06
-#define BT_A2DP_ATRAC_SINK			0x07
-#define BT_A2DP_UNKNOWN_SOURCE			0x08
-#define BT_A2DP_UNKNOWN_SINK			0x09
-
-#define BT_SBC_SAMPLING_FREQ_16000		(1 << 3)
-#define BT_SBC_SAMPLING_FREQ_32000		(1 << 2)
-#define BT_SBC_SAMPLING_FREQ_44100		(1 << 1)
-#define BT_SBC_SAMPLING_FREQ_48000		1
-
-#define BT_A2DP_CHANNEL_MODE_MONO		(1 << 3)
-#define BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-#define BT_A2DP_CHANNEL_MODE_STEREO		(1 << 1)
-#define BT_A2DP_CHANNEL_MODE_JOINT_STEREO	1
-
-#define BT_A2DP_BLOCK_LENGTH_4			(1 << 3)
-#define BT_A2DP_BLOCK_LENGTH_8			(1 << 2)
-#define BT_A2DP_BLOCK_LENGTH_12			(1 << 1)
-#define BT_A2DP_BLOCK_LENGTH_16			1
-
-#define BT_A2DP_SUBBANDS_4			(1 << 1)
-#define BT_A2DP_SUBBANDS_8			1
-
-#define BT_A2DP_ALLOCATION_SNR			(1 << 1)
-#define BT_A2DP_ALLOCATION_LOUDNESS		1
-
-#define BT_MPEG_SAMPLING_FREQ_16000		(1 << 5)
-#define BT_MPEG_SAMPLING_FREQ_22050		(1 << 4)
-#define BT_MPEG_SAMPLING_FREQ_24000		(1 << 3)
-#define BT_MPEG_SAMPLING_FREQ_32000		(1 << 2)
-#define BT_MPEG_SAMPLING_FREQ_44100		(1 << 1)
-#define BT_MPEG_SAMPLING_FREQ_48000		1
-
-#define BT_MPEG_LAYER_1				(1 << 2)
-#define BT_MPEG_LAYER_2				(1 << 1)
-#define BT_MPEG_LAYER_3				1
-
-#define BT_HFP_CODEC_PCM			0x00
-
-#define BT_PCM_FLAG_NREC			0x01
-#define BT_PCM_FLAG_PCM_ROUTING			0x02
-
-#define BT_WRITE_LOCK				(1 << 1)
-#define BT_READ_LOCK				1
-
-typedef struct {
-	uint8_t seid;
-	uint8_t transport;
-	uint8_t type;
-	uint8_t length;
-	uint8_t configured;
-	uint8_t lock;
-	uint8_t data[0];
-} __attribute__ ((packed)) codec_capabilities_t;
-
-typedef struct {
-	codec_capabilities_t capability;
-	uint8_t channel_mode;
-	uint8_t frequency;
-	uint8_t allocation_method;
-	uint8_t subbands;
-	uint8_t block_length;
-	uint8_t min_bitpool;
-	uint8_t max_bitpool;
-} __attribute__ ((packed)) sbc_capabilities_t;
-
-typedef struct {
-	codec_capabilities_t capability;
-	uint8_t channel_mode;
-	uint8_t crc;
-	uint8_t layer;
-	uint8_t frequency;
-	uint8_t mpf;
-	uint16_t bitrate;
-} __attribute__ ((packed)) mpeg_capabilities_t;
-
-typedef struct {
-	codec_capabilities_t capability;
-	uint8_t flags;
-	uint16_t sampling_rate;
-} __attribute__ ((packed)) pcm_capabilities_t;
-
-struct bt_get_capabilities_rsp {
-	bt_audio_msg_header_t	h;
-	char			source[18];	/* Address of the local Device */
-	char			destination[18];/* Address of the remote Device */
-	char			object[128];	/* DBus object path */
-	uint8_t			data[0];	/* First codec_capabilities_t */
-} __attribute__ ((packed));
-
-struct bt_open_req {
-	bt_audio_msg_header_t	h;
-	char			source[18];	/* Address of the local Device */
-	char			destination[18];/* Address of the remote Device */
-	char			object[128];	/* DBus object path */
-	uint8_t			seid;		/* Requested capability configuration to lock */
-	uint8_t			lock;		/* Requested lock */
-} __attribute__ ((packed));
-
-struct bt_open_rsp {
-	bt_audio_msg_header_t	h;
-	char			source[18];	/* Address of the local Device */
-	char			destination[18];/* Address of the remote Device */
-	char			object[128];	/* DBus object path */
-} __attribute__ ((packed));
-
-struct bt_set_configuration_req {
-	bt_audio_msg_header_t	h;
-	codec_capabilities_t	codec;		/* Requested codec */
-} __attribute__ ((packed));
-
-struct bt_set_configuration_rsp {
-	bt_audio_msg_header_t	h;
-	uint16_t		link_mtu;	/* Max length that transport supports */
-} __attribute__ ((packed));
-
-#define BT_STREAM_ACCESS_READ		0
-#define BT_STREAM_ACCESS_WRITE		1
-#define BT_STREAM_ACCESS_READWRITE	2
-struct bt_start_stream_req {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-struct bt_start_stream_rsp {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-/* This message is followed by one byte of data containing the stream data fd
-   as ancillary data */
-struct bt_new_stream_ind {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-struct bt_stop_stream_req {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-struct bt_stop_stream_rsp {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-struct bt_close_req {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-struct bt_close_rsp {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-struct bt_suspend_stream_ind {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-struct bt_resume_stream_ind {
-	bt_audio_msg_header_t	h;
-} __attribute__ ((packed));
-
-#define BT_CONTROL_KEY_POWER			0x40
-#define BT_CONTROL_KEY_VOL_UP			0x41
-#define BT_CONTROL_KEY_VOL_DOWN			0x42
-#define BT_CONTROL_KEY_MUTE			0x43
-#define BT_CONTROL_KEY_PLAY			0x44
-#define BT_CONTROL_KEY_STOP			0x45
-#define BT_CONTROL_KEY_PAUSE			0x46
-#define BT_CONTROL_KEY_RECORD			0x47
-#define BT_CONTROL_KEY_REWIND			0x48
-#define BT_CONTROL_KEY_FAST_FORWARD		0x49
-#define BT_CONTROL_KEY_EJECT			0x4A
-#define BT_CONTROL_KEY_FORWARD			0x4B
-#define BT_CONTROL_KEY_BACKWARD			0x4C
-
-struct bt_control_req {
-	bt_audio_msg_header_t	h;
-	uint8_t			mode;		/* Control Mode */
-	uint8_t			key;		/* Control Key */
-} __attribute__ ((packed));
-
-struct bt_control_rsp {
-	bt_audio_msg_header_t	h;
-	uint8_t			mode;		/* Control Mode */
-	uint8_t			key;		/* Control Key */
-} __attribute__ ((packed));
-
-struct bt_control_ind {
-	bt_audio_msg_header_t	h;
-	uint8_t			mode;		/* Control Mode */
-	uint8_t			key;		/* Control Key */
-} __attribute__ ((packed));
-
-struct bt_delay_report_req {
-	bt_audio_msg_header_t	h;
-	uint16_t		delay;
-} __attribute__ ((packed));
-
-struct bt_delay_report_ind {
-	bt_audio_msg_header_t	h;
-	uint16_t		delay;
-} __attribute__ ((packed));
-
-/* Function declaration */
-
-/* Opens a connection to the audio service: return a socket descriptor */
-int bt_audio_service_open(void);
-
-/* Closes a connection to the audio service */
-int bt_audio_service_close(int sk);
-
-/* Receives stream data file descriptor : must be called after a
-BT_STREAMFD_IND message is returned */
-int bt_audio_service_get_data_fd(int sk);
-
-/* Human readable message type string */
-const char *bt_audio_strtype(uint8_t type);
-
-/* Human readable message name string */
-const char *bt_audio_strname(uint8_t name);
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* BT_AUDIOCLIENT_H */
diff --git a/audio/manager.c b/audio/manager.c
index 7ed39bb..faa48de 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -54,7 +54,6 @@
 #include "../src/device.h"
 
 #include "log.h"
-#include "ipc.h"
 #include "device.h"
 #include "error.h"
 #include "avdtp.h"
diff --git a/test/ipctest-a2dp-easy.test b/test/ipctest-a2dp-easy.test
deleted file mode 100644
index ba62d93..0000000
--- a/test/ipctest-a2dp-easy.test
+++ /dev/null
@@ -1,8 +0,0 @@
-profile a2dp
-init_bt
-init_profile
-start_stream
-sleep 2
-stop_stream
-quit
-
diff --git a/test/ipctest-a2dp-resume-fast.test b/test/ipctest-a2dp-resume-fast.test
deleted file mode 100644
index bbc99e2..0000000
--- a/test/ipctest-a2dp-resume-fast.test
+++ /dev/null
@@ -1,82 +0,0 @@
-#!./ipctest
-
-profile a2dp
-init_bt
-
-init_profile
-
-start_stream
-sleep 1
-stop_stream
-
-stop_stream
-start_stream
-
-stop_stream
-start_stream
-
-stop_stream
-start_stream
-
-stop_stream
-start_stream
-
-stop_stream
-start_stream
-
-stop_stream
-stop_stream
-stop_stream
-
-start_stream
-start_stream
-start_stream
-
-stop_stream
-
-sleep 1
-
-start_stream
-start_stream
-start_stream
-stop_stream
-stop_stream
-
-start_stream
-sleep 1
-stop_stream
-
-start_stream
-stop_stream
-
-start_stream
-stop_stream
-
-shutdown_bt
-
-init_bt
-
-init_profile
-
-start_stream
-stop_stream
-stop_stream
-start_stream
-stop_stream
-start_stream
-stop_stream
-start_stream
-stop_stream
-start_stream
-stop_stream
-start_stream
-stop_stream
-stop_stream
-stop_stream
-
-start_stream
-start_stream
-start_stream
-stop_stream
-
-quit
diff --git a/test/ipctest-hsp-a2dp-switch.test b/test/ipctest-hsp-a2dp-switch.test
deleted file mode 100644
index e99878f..0000000
--- a/test/ipctest-hsp-a2dp-switch.test
+++ /dev/null
@@ -1,50 +0,0 @@
-init_bt
-
-profile a2dp
-init_profile
-start_stream
-sleep 2
-stop_stream
-start_stream
-sleep 2
-stop_stream
-
-shutdown_bt
-init_bt
-
-profile hsp
-init_profile
-start_stream
-sleep 2
-stop_stream
-start_stream
-sleep 2
-stop_stream
-
-shutdown_bt
-init_bt
-
-profile a2dp
-init_profile
-start_stream
-sleep 2
-stop_stream
-start_stream
-sleep 2
-stop_stream
-
-shutdown_bt
-init_bt
-
-profile hsp
-init_profile
-start_stream
-sleep 2
-stop_stream
-start_stream
-sleep 2
-stop_stream
-
-shutdown_bt
-
-quit
diff --git a/test/ipctest-hsp-easy.test b/test/ipctest-hsp-easy.test
deleted file mode 100644
index 0756a78..0000000
--- a/test/ipctest-hsp-easy.test
+++ /dev/null
@@ -1,7 +0,0 @@
-profile hsp
-init_bt
-init_profile
-start_stream
-sleep 2
-stop_stream
-quit
diff --git a/test/ipctest-init-shutdown.test b/test/ipctest-init-shutdown.test
deleted file mode 100644
index 578883a..0000000
--- a/test/ipctest-init-shutdown.test
+++ /dev/null
@@ -1,59 +0,0 @@
-#!./ipctest
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-
-init_bt
-sleep 1
-shutdown_bt
-
-init_bt
-sleep 1
-shutdown_bt
-
-init_bt
-sleep 1
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-init_bt
-shutdown_bt
-
-quit
-
diff --git a/test/ipctest.c b/test/ipctest.c
deleted file mode 100644
index cbfd78d..0000000
--- a/test/ipctest.c
+++ /dev/null
@@ -1,1133 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright (C) 2009	Lennart Poettering
- *  Copyright (C) 2008	Joao Paulo Rechi Vita
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <errno.h>
-#include <string.h>
-#include <assert.h>
-#include <libgen.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <signal.h>
-
-#include <glib.h>
-
-#include "ipc.h"
-#include "sbc.h"
-
-#define DBG(fmt, arg...)				\
-	printf("debug %s: " fmt "\n" , __FUNCTION__ , ## arg)
-#define ERR(fmt, arg...)				\
-	fprintf(stderr, "ERROR %s: " fmt "\n" , __FUNCTION__ , ## arg)
-
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
-#ifndef MIN
-# define MIN(x, y) ((x) < (y) ? (x) : (y))
-#endif
-
-#ifndef MAX
-# define MAX(x, y) ((x) > (y) ? (x) : (y))
-#endif
-
-#ifndef TRUE
-# define TRUE (1)
-#endif
-
-#ifndef FALSE
-# define FALSE (0)
-#endif
-
-#define YES_NO(t) ((t) ? "yes" : "no")
-
-#define BUFFER_SIZE 2048
-#define MAX_BITPOOL 64
-#define MIN_BITPOOL 2
-
-struct a2dp_info {
-	sbc_capabilities_t sbc_capabilities;
-	sbc_t sbc; /* Codec data */
-	int sbc_initialized; /* Keep track if the encoder is initialized */
-	size_t codesize; /* SBC codesize */
-
-	void* buffer; /* Codec transfer buffer */
-	size_t buffer_size; /* Size of the buffer */
-
-	uint16_t seq_num; /* Cumulative packet sequence */
-};
-
-struct hsp_info {
-	pcm_capabilities_t pcm_capabilities;
-};
-
-struct userdata {
-	int service_fd;
-	int stream_fd;
-	GIOChannel *stream_channel;
-	guint stream_watch;
-	GIOChannel *gin; /* dude, I am thirsty now */
-	guint gin_watch;
-	int transport;
-	uint32_t rate;
-	int channels;
-	char *address;
-	struct a2dp_info a2dp;
-	struct hsp_info hsp;
-	size_t link_mtu;
-	size_t block_size;
-	gboolean debug_stream_read : 1;
-	gboolean debug_stream_write : 1;
-};
-
-static struct userdata data = {
-	.service_fd = -1,
-	.stream_fd = -1,
-	.transport = BT_CAPABILITIES_TRANSPORT_A2DP,
-	.rate = 48000,
-	.channels = 2,
-	.address = NULL
-};
-
-static int start_stream(struct userdata *u);
-static int stop_stream(struct userdata *u);
-static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data);
-
-static GMainLoop *main_loop;
-
-static int service_send(struct userdata *u, const bt_audio_msg_header_t *msg)
-{
-	int err;
-	uint16_t length;
-
-	assert(u);
-
-	length = msg->length ? msg->length : BT_SUGGESTED_BUFFER_SIZE;
-
-	DBG("sending %s:%s", bt_audio_strtype(msg->type),
-		bt_audio_strname(msg->name));
-
-	if (send(u->service_fd, msg, length, 0) > 0)
-		err = 0;
-	else {
-		err = -errno;
-		ERR("Error sending data to audio service: %s(%d)",
-			strerror(-err), -err);
-	}
-
-	return err;
-}
-
-static int service_recv(struct userdata *u, bt_audio_msg_header_t *rsp)
-{
-	int err;
-	const char *type, *name;
-	uint16_t length;
-
-	assert(u);
-
-	length = rsp->length ? : BT_SUGGESTED_BUFFER_SIZE;
-
-	DBG("trying to receive msg from audio service...");
-	if (recv(u->service_fd, rsp, length, 0) > 0) {
-		type = bt_audio_strtype(rsp->type);
-		name = bt_audio_strname(rsp->name);
-		if (type && name) {
-			DBG("Received %s - %s", type, name);
-			err = 0;
-		} else {
-			err = -EINVAL;
-			ERR("Bogus message type %d - name %d"
-				"received from audio service",
-				rsp->type, rsp->name);
-		}
-	} else {
-		err = -errno;
-		ERR("Error receiving data from audio service: %s(%d)",
-			strerror(-err), -err);
-	}
-
-	return err;
-}
-
-static ssize_t service_expect(struct userdata *u, bt_audio_msg_header_t *rsp,
-				uint8_t expected_name)
-{
-	int r;
-
-	assert(u);
-	assert(u->service_fd >= 0);
-	assert(rsp);
-
-	if ((r = service_recv(u, rsp)) < 0)
-		return r;
-
-	if ((rsp->type != BT_INDICATION && rsp->type != BT_RESPONSE) ||
-			(rsp->name != expected_name)) {
-		if (rsp->type == BT_ERROR && rsp->length == sizeof(bt_audio_error_t))
-			ERR("Received error condition: %s",
-				strerror(((bt_audio_error_t*) rsp)->posix_errno));
-		else
-			ERR("Bogus message %s received while %s was expected",
-				bt_audio_strname(rsp->name),
-				bt_audio_strname(expected_name));
-		return -1;
-	}
-
-	return 0;
-}
-
-static int init_bt(struct userdata *u)
-{
-	assert(u);
-
-	if (u->service_fd != -1)
-		return 0;
-
-	DBG("bt_audio_service_open");
-
-	u->service_fd = bt_audio_service_open();
-	if (u->service_fd < 0) {
-		int err = -errno;
-
-		ERR("bt_audio_service_open() failed: %s (%d)", strerror(-err),
-									-err);
-
-		return err;
-	}
-
-	return 0;
-}
-
-static int parse_caps(struct userdata *u, const struct bt_get_capabilities_rsp *rsp)
-{
-	unsigned char *ptr;
-	uint16_t bytes_left;
-	codec_capabilities_t codec;
-
-	assert(u);
-	assert(rsp);
-
-	bytes_left = rsp->h.length - sizeof(*rsp);
-
-	if (bytes_left < sizeof(codec_capabilities_t)) {
-		ERR("Packet too small to store codec information.");
-		return -1;
-	}
-
-	ptr = ((void *) rsp) + sizeof(*rsp);
-
-	memcpy(&codec, ptr, sizeof(codec)); /** ALIGNMENT? **/
-
-	DBG("Payload size is %lu %lu",
-		(unsigned long) bytes_left, (unsigned long) sizeof(codec));
-
-	if (u->transport != codec.transport) {
-		ERR("Got capabilities for wrong codec.");
-		return -1;
-	}
-
-	if (u->transport == BT_CAPABILITIES_TRANSPORT_SCO) {
-
-		if (bytes_left <= 0 ||
-				codec.length != sizeof(u->hsp.pcm_capabilities))
-			return -1;
-
-		assert(codec.type == BT_HFP_CODEC_PCM);
-
-		memcpy(&u->hsp.pcm_capabilities,
-				&codec, sizeof(u->hsp.pcm_capabilities));
-
-		DBG("Has NREC: %s",
-			YES_NO(u->hsp.pcm_capabilities.flags & BT_PCM_FLAG_NREC));
-
-	} else if (u->transport == BT_CAPABILITIES_TRANSPORT_A2DP) {
-
-		while (bytes_left > 0) {
-			if (codec.type == BT_A2DP_SBC_SINK &&
-					!(codec.lock & BT_WRITE_LOCK))
-				break;
-
-			bytes_left -= codec.length;
-			ptr += codec.length;
-			memcpy(&codec, ptr, sizeof(codec));
-		}
-
-		DBG("bytes_left = %d, codec.length = %d",
-						bytes_left, codec.length);
-
-		if (bytes_left <= 0 ||
-				codec.length != sizeof(u->a2dp.sbc_capabilities))
-			return -1;
-
-		assert(codec.type == BT_A2DP_SBC_SINK);
-
-		memcpy(&u->a2dp.sbc_capabilities, &codec,
-					sizeof(u->a2dp.sbc_capabilities));
-	} else {
-		assert(0);
-	}
-
-	return 0;
-}
-
-static int get_caps(struct userdata *u)
-{
-	union {
-		struct bt_get_capabilities_req getcaps_req;
-		struct bt_get_capabilities_rsp getcaps_rsp;
-		bt_audio_error_t error;
-		uint8_t buf[BT_SUGGESTED_BUFFER_SIZE];
-	} msg;
-
-	assert(u);
-
-	memset(&msg, 0, sizeof(msg));
-	msg.getcaps_req.h.type = BT_REQUEST;
-	msg.getcaps_req.h.name = BT_GET_CAPABILITIES;
-	msg.getcaps_req.h.length = sizeof(msg.getcaps_req);
-
-	strncpy(msg.getcaps_req.destination, u->address,
-			sizeof(msg.getcaps_req.destination));
-	msg.getcaps_req.transport = u->transport;
-	msg.getcaps_req.flags = BT_FLAG_AUTOCONNECT;
-
-	if (service_send(u, &msg.getcaps_req.h) < 0)
-		return -1;
-
-	msg.getcaps_rsp.h.length = 0;
-	if (service_expect(u, &msg.getcaps_rsp.h, BT_GET_CAPABILITIES) < 0)
-		return -1;
-
-	return parse_caps(u, &msg.getcaps_rsp);
-}
-
-static uint8_t a2dp_default_bitpool(uint8_t freq, uint8_t mode)
-{
-	switch (freq) {
-	case BT_SBC_SAMPLING_FREQ_16000:
-	case BT_SBC_SAMPLING_FREQ_32000:
-		return 53;
-
-	case BT_SBC_SAMPLING_FREQ_44100:
-
-		switch (mode) {
-		case BT_A2DP_CHANNEL_MODE_MONO:
-		case BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL:
-			return 31;
-
-		case BT_A2DP_CHANNEL_MODE_STEREO:
-		case BT_A2DP_CHANNEL_MODE_JOINT_STEREO:
-			return 53;
-
-		default:
-			DBG("Invalid channel mode %u", mode);
-			return 53;
-		}
-
-	case BT_SBC_SAMPLING_FREQ_48000:
-
-		switch (mode) {
-		case BT_A2DP_CHANNEL_MODE_MONO:
-		case BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL:
-			return 29;
-
-		case BT_A2DP_CHANNEL_MODE_STEREO:
-		case BT_A2DP_CHANNEL_MODE_JOINT_STEREO:
-			return 51;
-
-		default:
-			DBG("Invalid channel mode %u", mode);
-			return 51;
-		}
-
-	default:
-		DBG("Invalid sampling freq %u", freq);
-		return 53;
-	}
-}
-
-static int setup_a2dp(struct userdata *u)
-{
-	sbc_capabilities_t *cap;
-	int i;
-
-	static const struct {
-		uint32_t rate;
-		uint8_t cap;
-	} freq_table[] = {
-		{ 16000U, BT_SBC_SAMPLING_FREQ_16000 },
-		{ 32000U, BT_SBC_SAMPLING_FREQ_32000 },
-		{ 44100U, BT_SBC_SAMPLING_FREQ_44100 },
-		{ 48000U, BT_SBC_SAMPLING_FREQ_48000 }
-	};
-
-	assert(u);
-	assert(u->transport == BT_CAPABILITIES_TRANSPORT_A2DP);
-
-	cap = &u->a2dp.sbc_capabilities;
-
-	/* Find the lowest freq that is at least as high as the requested
-	 * sampling rate */
-	for (i = 0; (unsigned) i < ARRAY_SIZE(freq_table); i++)
-		if (freq_table[i].rate >= u->rate &&
-			(cap->frequency & freq_table[i].cap)) {
-			u->rate = freq_table[i].rate;
-			cap->frequency = freq_table[i].cap;
-			break;
-		}
-
-	if ((unsigned) i >= ARRAY_SIZE(freq_table)) {
-		for (; i >= 0; i--) {
-			if (cap->frequency & freq_table[i].cap) {
-				u->rate = freq_table[i].rate;
-				cap->frequency = freq_table[i].cap;
-				break;
-			}
-		}
-
-		if (i < 0) {
-			DBG("Not suitable sample rate");
-			return -1;
-		}
-	}
-
-	if (u->channels <= 1) {
-		if (cap->channel_mode & BT_A2DP_CHANNEL_MODE_MONO) {
-			cap->channel_mode = BT_A2DP_CHANNEL_MODE_MONO;
-			u->channels = 1;
-		} else
-			u->channels = 2;
-	}
-
-	if (u->channels >= 2) {
-		u->channels = 2;
-
-		if (cap->channel_mode & BT_A2DP_CHANNEL_MODE_JOINT_STEREO)
-			cap->channel_mode = BT_A2DP_CHANNEL_MODE_JOINT_STEREO;
-		else if (cap->channel_mode & BT_A2DP_CHANNEL_MODE_STEREO)
-			cap->channel_mode = BT_A2DP_CHANNEL_MODE_STEREO;
-		else if (cap->channel_mode & BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL)
-			cap->channel_mode = BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL;
-		else if (cap->channel_mode & BT_A2DP_CHANNEL_MODE_MONO) {
-			cap->channel_mode = BT_A2DP_CHANNEL_MODE_MONO;
-			u->channels = 1;
-		} else {
-			DBG("No supported channel modes");
-			return -1;
-		}
-	}
-
-	if (cap->block_length & BT_A2DP_BLOCK_LENGTH_16)
-		cap->block_length = BT_A2DP_BLOCK_LENGTH_16;
-	else if (cap->block_length & BT_A2DP_BLOCK_LENGTH_12)
-		cap->block_length = BT_A2DP_BLOCK_LENGTH_12;
-	else if (cap->block_length & BT_A2DP_BLOCK_LENGTH_8)
-		cap->block_length = BT_A2DP_BLOCK_LENGTH_8;
-	else if (cap->block_length & BT_A2DP_BLOCK_LENGTH_4)
-		cap->block_length = BT_A2DP_BLOCK_LENGTH_4;
-	else {
-		DBG("No supported block lengths");
-		return -1;
-	}
-
-	if (cap->subbands & BT_A2DP_SUBBANDS_8)
-		cap->subbands = BT_A2DP_SUBBANDS_8;
-	else if (cap->subbands & BT_A2DP_SUBBANDS_4)
-		cap->subbands = BT_A2DP_SUBBANDS_4;
-	else {
-		DBG("No supported subbands");
-		return -1;
-	}
-
-	if (cap->allocation_method & BT_A2DP_ALLOCATION_LOUDNESS)
-		cap->allocation_method = BT_A2DP_ALLOCATION_LOUDNESS;
-	else if (cap->allocation_method & BT_A2DP_ALLOCATION_SNR)
-		cap->allocation_method = BT_A2DP_ALLOCATION_SNR;
-
-	cap->min_bitpool = (uint8_t) MAX(MIN_BITPOOL, cap->min_bitpool);
-	cap->max_bitpool = (uint8_t) MIN(
-		a2dp_default_bitpool(cap->frequency, cap->channel_mode),
-		cap->max_bitpool);
-
-	return 0;
-}
-
-static void setup_sbc(struct a2dp_info *a2dp)
-{
-	sbc_capabilities_t *active_capabilities;
-
-	assert(a2dp);
-
-	active_capabilities = &a2dp->sbc_capabilities;
-
-	if (a2dp->sbc_initialized)
-		sbc_reinit(&a2dp->sbc, 0);
-	else
-		sbc_init(&a2dp->sbc, 0);
-	a2dp->sbc_initialized = TRUE;
-
-	switch (active_capabilities->frequency) {
-	case BT_SBC_SAMPLING_FREQ_16000:
-		a2dp->sbc.frequency = SBC_FREQ_16000;
-		break;
-	case BT_SBC_SAMPLING_FREQ_32000:
-		a2dp->sbc.frequency = SBC_FREQ_32000;
-		break;
-	case BT_SBC_SAMPLING_FREQ_44100:
-		a2dp->sbc.frequency = SBC_FREQ_44100;
-		break;
-	case BT_SBC_SAMPLING_FREQ_48000:
-		a2dp->sbc.frequency = SBC_FREQ_48000;
-		break;
-	default:
-		assert(0);
-	}
-
-	switch (active_capabilities->channel_mode) {
-	case BT_A2DP_CHANNEL_MODE_MONO:
-		a2dp->sbc.mode = SBC_MODE_MONO;
-		break;
-	case BT_A2DP_CHANNEL_MODE_DUAL_CHANNEL:
-		a2dp->sbc.mode = SBC_MODE_DUAL_CHANNEL;
-		break;
-	case BT_A2DP_CHANNEL_MODE_STEREO:
-		a2dp->sbc.mode = SBC_MODE_STEREO;
-		break;
-	case BT_A2DP_CHANNEL_MODE_JOINT_STEREO:
-		a2dp->sbc.mode = SBC_MODE_JOINT_STEREO;
-		break;
-	default:
-		assert(0);
-	}
-
-	switch (active_capabilities->allocation_method) {
-	case BT_A2DP_ALLOCATION_SNR:
-		a2dp->sbc.allocation = SBC_AM_SNR;
-		break;
-	case BT_A2DP_ALLOCATION_LOUDNESS:
-		a2dp->sbc.allocation = SBC_AM_LOUDNESS;
-		break;
-	default:
-		assert(0);
-	}
-
-	switch (active_capabilities->subbands) {
-	case BT_A2DP_SUBBANDS_4:
-		a2dp->sbc.subbands = SBC_SB_4;
-		break;
-	case BT_A2DP_SUBBANDS_8:
-		a2dp->sbc.subbands = SBC_SB_8;
-		break;
-	default:
-		assert(0);
-	}
-
-	switch (active_capabilities->block_length) {
-	case BT_A2DP_BLOCK_LENGTH_4:
-		a2dp->sbc.blocks = SBC_BLK_4;
-		break;
-	case BT_A2DP_BLOCK_LENGTH_8:
-		a2dp->sbc.blocks = SBC_BLK_8;
-		break;
-	case BT_A2DP_BLOCK_LENGTH_12:
-		a2dp->sbc.blocks = SBC_BLK_12;
-		break;
-	case BT_A2DP_BLOCK_LENGTH_16:
-		a2dp->sbc.blocks = SBC_BLK_16;
-		break;
-	default:
-		assert(0);
-	}
-
-	a2dp->sbc.bitpool = active_capabilities->max_bitpool;
-	a2dp->codesize = (uint16_t) sbc_get_codesize(&a2dp->sbc);
-}
-
-static int bt_open(struct userdata *u)
-{
-	union {
-		struct bt_open_req open_req;
-		struct bt_open_rsp open_rsp;
-		bt_audio_error_t error;
-		uint8_t buf[BT_SUGGESTED_BUFFER_SIZE];
-	} msg;
-
-	memset(&msg, 0, sizeof(msg));
-	msg.open_req.h.type = BT_REQUEST;
-	msg.open_req.h.name = BT_OPEN;
-	msg.open_req.h.length = sizeof(msg.open_req);
-
-	strncpy(msg.open_req.destination, u->address,
-			sizeof(msg.open_req.destination));
-	msg.open_req.seid = u->transport == BT_CAPABILITIES_TRANSPORT_A2DP ?
-				u->a2dp.sbc_capabilities.capability.seid :
-				BT_A2DP_SEID_RANGE + 1;
-	msg.open_req.lock = u->transport == BT_CAPABILITIES_TRANSPORT_A2DP ?
-				BT_WRITE_LOCK : BT_READ_LOCK | BT_WRITE_LOCK;
-
-	if (service_send(u, &msg.open_req.h) < 0)
-		return -1;
-
-	msg.open_rsp.h.length = sizeof(msg.open_rsp);
-	if (service_expect(u, &msg.open_rsp.h, BT_OPEN) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int set_conf(struct userdata *u)
-{
-	union {
-		struct bt_set_configuration_req setconf_req;
-		struct bt_set_configuration_rsp setconf_rsp;
-		bt_audio_error_t error;
-		uint8_t buf[BT_SUGGESTED_BUFFER_SIZE];
-	} msg;
-
-	if (u->transport == BT_CAPABILITIES_TRANSPORT_A2DP) {
-		if (setup_a2dp(u) < 0)
-			return -1;
-	}
-
-	memset(&msg, 0, sizeof(msg));
-	msg.setconf_req.h.type = BT_REQUEST;
-	msg.setconf_req.h.name = BT_SET_CONFIGURATION;
-	msg.setconf_req.h.length = sizeof(msg.setconf_req);
-
-	if (u->transport == BT_CAPABILITIES_TRANSPORT_A2DP) {
-		memcpy(&msg.setconf_req.codec, &u->a2dp.sbc_capabilities,
-			sizeof(u->a2dp.sbc_capabilities));
-		msg.setconf_req.h.length += msg.setconf_req.codec.length -
-			sizeof(msg.setconf_req.codec);
-	} else {
-		msg.setconf_req.codec.transport = BT_CAPABILITIES_TRANSPORT_SCO;
-		msg.setconf_req.codec.seid = BT_A2DP_SEID_RANGE + 1;
-		msg.setconf_req.codec.length = sizeof(pcm_capabilities_t);
-	}
-
-	if (service_send(u, &msg.setconf_req.h) < 0)
-		return -1;
-
-	msg.setconf_rsp.h.length = sizeof(msg.setconf_rsp);
-	if (service_expect(u, &msg.setconf_rsp.h, BT_SET_CONFIGURATION) < 0)
-		return -1;
-
-	u->link_mtu = msg.setconf_rsp.link_mtu;
-
-	/* setup SBC encoder now we agree on parameters */
-	if (u->transport == BT_CAPABILITIES_TRANSPORT_A2DP) {
-		setup_sbc(&u->a2dp);
-		u->block_size = u->a2dp.codesize;
-		DBG("SBC parameters:\n\tallocation=%u\n"
-			"\tsubbands=%u\n\tblocks=%u\n\tbitpool=%u\n",
-			u->a2dp.sbc.allocation, u->a2dp.sbc.subbands,
-			u->a2dp.sbc.blocks, u->a2dp.sbc.bitpool);
-	} else
-		u->block_size = u->link_mtu;
-
-	return 0;
-}
-
-static int setup_bt(struct userdata *u)
-{
-	assert(u);
-
-	if (get_caps(u) < 0)
-		return -1;
-
-	DBG("Got device caps");
-
-	if (bt_open(u) < 0)
-		return -1;
-
-	if (set_conf(u) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int init_profile(struct userdata *u)
-{
-	assert(u);
-
-	return setup_bt(u);
-}
-
-static void shutdown_bt(struct userdata *u)
-{
-	assert(u);
-
-	if (u->stream_fd != -1) {
-		stop_stream(u);
-		DBG("close(stream_fd)");
-		close(u->stream_fd);
-		u->stream_fd = -1;
-	}
-
-	if (u->service_fd != -1) {
-		DBG("bt_audio_service_close");
-		bt_audio_service_close(u->service_fd);
-		u->service_fd = -1;
-	}
-}
-
-static void make_fd_nonblock(int fd)
-{
-	int v;
-
-	assert(fd >= 0);
-	assert((v = fcntl(fd, F_GETFL)) >= 0);
-
-	if (!(v & O_NONBLOCK))
-		assert(fcntl(fd, F_SETFL, v|O_NONBLOCK) >= 0);
-}
-
-static void make_socket_low_delay(int fd)
-{
-/* FIXME: is this widely supported? */
-#ifdef SO_PRIORITY
-	int priority;
-	assert(fd >= 0);
-
-	priority = 6;
-	if (setsockopt(fd, SOL_SOCKET, SO_PRIORITY, (void*)&priority,
-			sizeof(priority)) < 0)
-		ERR("SO_PRIORITY failed: %s", strerror(errno));
-#endif
-}
-
-static int read_stream(struct userdata *u)
-{
-	int ret = 0;
-	ssize_t l;
-	char *buf;
-
-	assert(u);
-	assert(u->stream_fd >= 0);
-
-	buf = alloca(u->link_mtu);
-
-	for (;;) {
-		l = read(u->stream_fd, buf, u->link_mtu);
-		if (u->debug_stream_read)
-			DBG("read from socket: %lli bytes", (long long) l);
-		if (l <= 0) {
-			if (l < 0 && errno == EINTR)
-				continue;
-			else {
-				ERR("Failed to read date from stream_fd: %s",
-					ret < 0 ? strerror(errno) : "EOF");
-				return -1;
-			}
-		} else {
-			break;
-		}
-	}
-
-	return ret;
-}
-
-/* It's what PulseAudio is doing, not sure it's necessary for this
- * test */
-static ssize_t pa_write(int fd, const void *buf, size_t count)
-{
-	ssize_t r;
-
-	if ((r = send(fd, buf, count, MSG_NOSIGNAL)) >= 0)
-		return r;
-
-	if (errno != ENOTSOCK)
-		return r;
-
-	return write(fd, buf, count);
-}
-
-static int write_stream(struct userdata *u)
-{
-	int ret = 0;
-	ssize_t l;
-	char *buf;
-
-	assert(u);
-	assert(u->stream_fd >= 0);
-	buf = alloca(u->link_mtu);
-
-	for (;;) {
-		l = pa_write(u->stream_fd, buf, u->link_mtu);
-		if (u->debug_stream_write)
-			DBG("written to socket: %lli bytes", (long long) l);
-		assert(l != 0);
-		if (l < 0) {
-			if (errno == EINTR)
-				continue;
-			else {
-				ERR("Failed to write data: %s", strerror(errno));
-				ret = -1;
-				break;
-			}
-		} else {
-			assert((size_t)l <= u->link_mtu);
-			break;
-		}
-	}
-
-	return ret;
-}
-
-static gboolean stream_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
-{
-	struct userdata *u;
-
-	assert(u = data);
-
-	if (condition & G_IO_IN) {
-		if (read_stream(u) < 0)
-			goto fail;
-	} else if (condition & G_IO_OUT) {
-		if (write_stream(u) < 0)
-			goto fail;
-	} else {
-		DBG("Got %d", condition);
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	return TRUE;
-
-fail:
-	stop_stream(u);
-	return FALSE;
-}
-
-static int start_stream(struct userdata *u)
-{
-	union {
-		bt_audio_msg_header_t rsp;
-		struct bt_start_stream_req start_req;
-		struct bt_start_stream_rsp start_rsp;
-		struct bt_new_stream_ind streamfd_ind;
-		bt_audio_error_t error;
-		uint8_t buf[BT_SUGGESTED_BUFFER_SIZE];
-	} msg;
-
-	assert(u);
-
-	if (u->stream_fd >= 0)
-		return 0;
-	if (u->stream_watch != 0) {
-		g_source_remove(u->stream_watch);
-		u->stream_watch = 0;
-	}
-	if (u->stream_channel != 0) {
-		g_io_channel_unref(u->stream_channel);
-		u->stream_channel = NULL;
-	}
-
-	memset(msg.buf, 0, BT_SUGGESTED_BUFFER_SIZE);
-	msg.start_req.h.type = BT_REQUEST;
-	msg.start_req.h.name = BT_START_STREAM;
-	msg.start_req.h.length = sizeof(msg.start_req);
-
-	if (service_send(u, &msg.start_req.h) < 0)
-		return -1;
-
-	msg.rsp.length = sizeof(msg.start_rsp);
-	if (service_expect(u, &msg.rsp, BT_START_STREAM) < 0)
-		return -1;
-
-	msg.rsp.length = sizeof(msg.streamfd_ind);
-	if (service_expect(u, &msg.rsp, BT_NEW_STREAM) < 0)
-		return -1;
-
-	if ((u->stream_fd = bt_audio_service_get_data_fd(u->service_fd)) < 0) {
-		DBG("Failed to get stream fd from audio service.");
-		return -1;
-	}
-
-	make_fd_nonblock(u->stream_fd);
-	make_socket_low_delay(u->stream_fd);
-
-	assert(u->stream_channel = g_io_channel_unix_new(u->stream_fd));
-
-	u->stream_watch = g_io_add_watch(u->stream_channel,
-					G_IO_IN|G_IO_OUT|G_IO_ERR|G_IO_HUP|G_IO_NVAL,
-					stream_cb, u);
-
-	return 0;
-}
-
-static int stop_stream(struct userdata *u)
-{
-	union {
-		bt_audio_msg_header_t rsp;
-		struct bt_stop_stream_req stop_req;
-		struct bt_stop_stream_rsp stop_rsp;
-		bt_audio_error_t error;
-		uint8_t buf[BT_SUGGESTED_BUFFER_SIZE];
-	} msg;
-	int r = 0;
-
-	if (u->stream_fd < 0)
-		return 0;
-
-	assert(u);
-	assert(u->stream_channel);
-
-	g_source_remove(u->stream_watch);
-	u->stream_watch = 0;
-	g_io_channel_unref(u->stream_channel);
-	u->stream_channel = NULL;
-
-	memset(msg.buf, 0, BT_SUGGESTED_BUFFER_SIZE);
-	msg.stop_req.h.type = BT_REQUEST;
-	msg.stop_req.h.name = BT_STOP_STREAM;
-	msg.stop_req.h.length = sizeof(msg.stop_req);
-
-	if (service_send(u, &msg.stop_req.h) < 0) {
-		r = -1;
-		goto done;
-	}
-
-	msg.rsp.length = sizeof(msg.stop_rsp);
-	if (service_expect(u, &msg.rsp, BT_STOP_STREAM) < 0)
-		r = -1;
-
-done:
-	close(u->stream_fd);
-	u->stream_fd = -1;
-
-	return r;
-}
-
-static gboolean sleep_cb(gpointer data)
-{
-	struct userdata *u;
-
-	assert(u = data);
-
-	u->gin_watch = g_io_add_watch(u->gin,
-		G_IO_IN|G_IO_ERR|G_IO_HUP|G_IO_NVAL, input_cb, data);
-
-	printf(">>> ");
-	fflush(stdout);
-
-	return FALSE;
-}
-
-static gboolean input_cb(GIOChannel *gin, GIOCondition condition, gpointer data)
-{
-	char *line, *tmp;
-	gsize term_pos;
-	GError *error = NULL;
-	struct userdata *u;
-	int success;
-
-	assert(u = data);
-	if (!(condition & G_IO_IN)) {
-		DBG("Got %d", condition);
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	if (g_io_channel_read_line(gin, &line, NULL, &term_pos, &error) !=
-		G_IO_STATUS_NORMAL)
-		return FALSE;
-
-	line[term_pos] = '\0';
-	g_strstrip(line);
-	if ((tmp = strchr(line, '#')))
-		*tmp = '\0';
-	success = FALSE;
-
-#define IF_CMD(cmd) \
-	if (!success && (success = (strncmp(line, #cmd, strlen(#cmd)) == 0)))
-
-	IF_CMD(quit) {
-		g_main_loop_quit(main_loop);
-		return FALSE;
-	}
-
-	IF_CMD(sleep) {
-		unsigned int seconds;
-		if (sscanf(line, "%*s %d", &seconds) != 1)
-			DBG("sleep SECONDS");
-		else {
-			g_source_remove(u->gin_watch);
-			g_timeout_add_seconds(seconds, sleep_cb, u);
-			return FALSE;
-		}
-	}
-
-	IF_CMD(debug) {
-		char *what = NULL;
-		int enable;
-
-		if (sscanf(line, "%*s %as %d", &what, &enable) != 1)
-			DBG("debug [stream_read|stream_write] [0|1]");
-		if (strncmp(what, "stream_read", 12) == 0) {
-			u->debug_stream_read = enable;
-		} else if (strncmp(what, "stream_write", 13) == 0) {
-			u->debug_stream_write = enable;
-		} else {
-			DBG("debug [stream_read|stream_write] [0|1]");
-		}
-	}
-
-	IF_CMD(init_bt) {
-		DBG("%d", init_bt(u));
-	}
-
-	IF_CMD(init_profile) {
-		DBG("%d", init_profile(u));
-	}
-
-	IF_CMD(start_stream) {
-		DBG("%d", start_stream(u));
-	}
-
-	IF_CMD(stop_stream) {
-		DBG("%d", stop_stream(u));
-	}
-
-	IF_CMD(shutdown_bt) {
-		shutdown_bt(u);
-	}
-
-	IF_CMD(rate) {
-		if (sscanf(line, "%*s %d", &u->rate) != 1)
-			DBG("set with rate RATE");
-		DBG("rate %d", u->rate);
-	}
-
-	IF_CMD(bdaddr) {
-		char *address;
-
-		if (sscanf(line, "%*s %as", &address) != 1)
-			DBG("set with bdaddr BDADDR");
-
-		free(u->address);
-
-		u->address = address;
-		DBG("bdaddr %s", u->address);
-	}
-
-	IF_CMD(profile) {
-		char *profile = NULL;
-
-		if (sscanf(line, "%*s %as", &profile) != 1)
-			DBG("set with profile [hsp|a2dp]");
-		if (strncmp(profile, "hsp", 4) == 0) {
-			u->transport = BT_CAPABILITIES_TRANSPORT_SCO;
-		} else if (strncmp(profile, "a2dp", 5) == 0) {
-			u->transport = BT_CAPABILITIES_TRANSPORT_A2DP;
-		} else {
-			DBG("set with profile [hsp|a2dp]");
-		}
-
-		free(profile);
-		DBG("profile %s", u->transport == BT_CAPABILITIES_TRANSPORT_SCO ?
-			"hsp" : "a2dp");
-	}
-
-	if (!success && strlen(line) != 0) {
-		DBG("%s, unknown command", line);
-	}
-
-	printf(">>> ");
-	fflush(stdout);
-	return TRUE;
-}
-
-
-static void show_usage(char* prgname)
-{
-	printf("%s: ipctest [--interactive] BDADDR\n", basename(prgname));
-}
-
-static void sig_term(int sig)
-{
-	g_main_loop_quit(main_loop);
-}
-
-int main(int argc, char *argv[])
-{
-	if (argc < 2) {
-		show_usage(argv[0]);
-		exit(EXIT_FAILURE);
-	}
-
-	assert(main_loop = g_main_loop_new(NULL, FALSE));
-
-	if (strncmp("--interactive", argv[1], 14) == 0) {
-		if (argc < 3) {
-			show_usage(argv[0]);
-			exit(EXIT_FAILURE);
-		}
-
-		data.address = strdup(argv[2]);
-
-		signal(SIGTERM, sig_term);
-		signal(SIGINT, sig_term);
-
-		assert(data.gin = g_io_channel_unix_new(fileno(stdin)));
-
-		data.gin_watch = g_io_add_watch(data.gin,
-			G_IO_IN|G_IO_ERR|G_IO_HUP|G_IO_NVAL, input_cb, &data);
-
-		printf(">>> ");
-		fflush(stdout);
-
-		g_main_loop_run(main_loop);
-
-	} else {
-		data.address = strdup(argv[1]);
-
-		assert(init_bt(&data) == 0);
-
-		assert(init_profile(&data) == 0);
-
-		assert(start_stream(&data) == 0);
-
-		g_main_loop_run(main_loop);
-
-		assert(stop_stream(&data) == 0);
-
-		shutdown_bt(&data);
-	}
-
-	g_main_loop_unref(main_loop);
-
-	printf("\nExiting\n");
-
-	exit(EXIT_SUCCESS);
-
-	return 0;
-}
-- 
1.7.10.2


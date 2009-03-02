Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 2 Mar 2009 17:31:56 +0800
Message-ID: <ac8af0be0903020131t63902a65hc71274d1e205ec62@mail.gmail.com>
Subject: [PATCH 3/4] the main part for HFP Audio Gateway -- take3 -- resend
From: Zhao Forrest <forrest.zhao@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/audio/gateway.c b/audio/gateway.c
index cf37e4b..7bee081 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -28,6 +28,9 @@
 #endif

 #include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
 #include <errno.h>

 #include <glib.h>
@@ -35,9 +38,67 @@
 #include <gdbus.h>

 #include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+#include <bluetooth/sco.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>

+#include "glib-helper.h"
 #include "device.h"
 #include "gateway.h"
+#include "logging.h"
+#include "error.h"
+#include "btio.h"
+#include "dbus-common.h"
+
+#define RFCOMM_BUF_SIZE 256
+/* not-more-then-16 defined by GSM + 1 for NULL + padding */
+#define AG_INDICATOR_DESCR_SIZE 20
+#define AG_CALLER_NUM_SIZE 64	/* size of number + type */
+
+/* commands */
+#define AG_FEATURES "AT+BRSF=26\r"     /* = 0x7F = All features supported */
+#define AG_INDICATORS_SUPP "AT+CIND=?\r"
+#define AG_INDICATORS_VAL "AT+CIND?\r"
+#define AG_INDICATORS_ENABLE "AT+CMER=3,0,0,1\r"
+#define AG_HOLD_MPTY_SUPP "AT+CHLD=?\r"
+#define AG_CALLER_IDENT_ENABLE "AT+CLIP=1\r"
+#define AG_CARRIER_FORMAT "AT+COPS=3,0\r"
+#define AG_EXTENDED_RESULT_CODE "AT+CMEE=1\r"
+
+#define AG_FEATURE_3WAY 0x1
+#define AG_FEATURE_EXTENDED_RES_CODE 0x100
+/* Hold and multipary AG features.
+ * Comments below are copied from hands-free spec for reference */
+/* Releases all held calls or sets User Determined User Busy (UDUB)
+ * for a waiting call */
+#define AG_CHLD_0 0x01
+/* Releases all active calls (if any exist) and accepts the other
+ * (held or waiting) call */
+#define AG_CHLD_1 0x02
+/* Releases specified active call only <x> */
+#define AG_CHLD_1x 0x04
+/* Places all active calls (if any exist) on hold and accepts the other
+ * (held or waiting) call */
+#define AG_CHLD_2 0x08
+/* Request private consultation mode with specified call <x> (Place all
+ * calls on hold EXCEPT the call <x>) */
+#define AG_CHLD_2x 0x10
+/* Adds a held call to the conversation */
+#define AG_CHLD_3 0x20
+/* Connects the two calls and disconnects the subscriber from both calls
+ * (Explicit Call Transfer). Support for this value and its associated
+ * functionality is optional for the HF. */
+#define AG_CHLD_4 0x40
+
+#define OK_RESPONSE "\r\nOK\r\n"
+#define ERROR_RESPONSE "\r\nERROR\r\n"
+
+struct indicator {
+	gchar descr[AG_INDICATOR_DESCR_SIZE];
+	gint value;
+};

 struct gateway {
 	GIOChannel *rfcomm;
@@ -51,13 +112,857 @@ struct gateway {
 	guint hold_multiparty_features;
 	GSList *indies;
 	gboolean is_dialing;
+
+	int sp_gain;
+	int mic_gain;
 };

+static gboolean rfcomm_ag_data_cb(GIOChannel *chan, GIOCondition cond,
+					struct audio_device *device);
+
+int gateway_close(struct audio_device *device);
+
+static void rfcomm_start_watch(struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	gw->rfcomm_watch_id = g_io_add_watch(gw->rfcomm,
+			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			(GIOFunc) rfcomm_ag_data_cb, dev);
+}
+
+static void rfcomm_stop_watch(struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	g_source_remove(gw->rfcomm_watch_id);
+}
+
+static gboolean io_channel_write_all(GIOChannel *io, gchar *data,
+					gsize count)
+{
+	gsize written = 0;
+	GIOStatus status;
+
+	while (count > 0) {
+		status = g_io_channel_write_chars(io, data, count, &written,
+						NULL);
+		if (status != G_IO_STATUS_NORMAL)
+			return FALSE;
+
+		data += written;
+		count -= written;
+	}
+	return TRUE;
+}
+
+/* it's worth to mention that data and response could be the same pointers */
+static gboolean rfcomm_send_and_read(struct gateway *gw, gchar *data,
+                                    gchar *response, gsize count)
+{
+	GIOChannel *rfcomm = gw->rfcomm;
+	gsize read = 0;
+	gboolean got_ok = FALSE;
+	gboolean got_error = FALSE;
+	gchar *resp_buf = response;
+	gsize toread = RFCOMM_BUF_SIZE - 1;
+	GIOStatus status;
+
+	if (!io_channel_write_all(rfcomm, data, count))
+		return FALSE;
+
+	while (!(got_ok || got_error)) {
+		status = g_io_channel_read_chars(rfcomm, resp_buf, toread,
+						&read, NULL);
+		if (status == G_IO_STATUS_NORMAL)
+			resp_buf[read] = '\0';
+		else {
+			debug("rfcomm_send_and_read(): %m");
+			return FALSE;
+		}
+		got_ok = NULL != strstr(resp_buf, OK_RESPONSE);
+		got_error = NULL != strstr(resp_buf, ERROR_RESPONSE);
+		resp_buf += read;
+		toread -= read;
+	}
+	return TRUE;
+}
+
+/* get <descr> from the names: (<descr>, (<values>)), (<descr>, (<values>))
+ * ... */
+static GSList *parse_indicator_names(gchar *names, GSList *indies)
+{
+	gchar *current = names - 1;
+	GSList *result = indies;
+	gchar *next;
+	struct indicator *ind;
+
+	while (current != NULL) {
+		current += 2;
+		next = strstr(current, ",(");
+		ind = g_slice_new(struct indicator);
+		strncpy(ind->descr, current, 20);
+		ind->descr[(gint) next - (gint) current] = '\0';
+		result = g_slist_append(result, (gpointer) ind);
+		current = strstr(next + 1, ",(");
+	}
+	return result;
+}
+
+/* get values from <val0>,<val1>,... */
+static GSList *parse_indicator_values(gchar *values, GSList *indies)
+{
+	gint val;
+	gchar *current = values - 1;
+	GSList *runner = indies;
+	struct indicator *ind;
+
+	while (current != NULL) {
+		current += 1;
+		sscanf(current, "%d", &val);
+		current = strchr(current, ',');
+		ind = g_slist_nth_data(runner, 0);
+		ind->value = val;
+		runner = g_slist_next(runner);
+	}
+	return indies;
+}
+
+/* get values from <val0>,<val1>,... */
+static guint get_hold_mpty_features(gchar *features)
+{
+	guint result = 0;
+
+	if (strstr(features, "0"))
+		result |= AG_CHLD_0;
+
+	if (strstr(features, "1"))
+		result |= AG_CHLD_1;
+
+	if (strstr(features, "1x"))
+		result |= AG_CHLD_1x;
+
+	if (strstr(features, "2"))
+		result |= AG_CHLD_2;
+
+	if (strstr(features, "2x"))
+		result |= AG_CHLD_2x;
+
+	if (strstr(features, "3"))
+		result |= AG_CHLD_3;
+
+	if (strstr(features, "4"))
+	        result |= AG_CHLD_4;
+
+	return result;
+}
+
+static gboolean establish_service_level_conn(struct gateway *gw)
+{
+	gchar buf[RFCOMM_BUF_SIZE];
+	gboolean res;
+
+	res = rfcomm_send_and_read(gw, AG_FEATURES, buf,
+				sizeof(AG_FEATURES) - 1);
+	if (!res || sscanf(buf, "\r\n+BRSF:%d", &gw->ag_features) != 1)
+		return FALSE;
+
+	debug("features are 0x%X", gw->ag_features);
+	res = rfcomm_send_and_read(gw, AG_INDICATORS_SUPP, buf,
+				sizeof(AG_INDICATORS_SUPP) - 1);
+	if (!res || !strstr(buf, "+CIND:"))
+		return FALSE;
+
+	gw->indies = parse_indicator_names(strchr(buf, '('), NULL);
+
+	res = rfcomm_send_and_read(gw, AG_INDICATORS_VAL, buf,
+		sizeof(AG_INDICATORS_VAL) - 1);
+	if (!res || !strstr(buf, "+CIND:"))
+		return FALSE;
+
+	gw->indies = parse_indicator_values(strchr(buf, ':') + 1, gw->indies);
+
+	res = rfcomm_send_and_read(gw, AG_INDICATORS_ENABLE, buf,
+				sizeof(AG_INDICATORS_ENABLE) - 1);
+	if (!res || !strstr(buf, "OK"))
+		return FALSE;
+
+	if ((gw->ag_features & AG_FEATURE_3WAY) != 0) {
+		res = rfcomm_send_and_read(gw, AG_HOLD_MPTY_SUPP, buf,
+				sizeof(AG_HOLD_MPTY_SUPP) - 1);
+		if (!res || !strstr(buf, "+CHLD:")) {
+			g_slice_free1(RFCOMM_BUF_SIZE, buf);
+			return FALSE;
+		}
+		gw->hold_multiparty_features = get_hold_mpty_features(
+							strchr(buf, '('));
+	} else
+		gw->hold_multiparty_features = 0;
+
+	debug("Service layer connection successfully established!");
+	rfcomm_send_and_read(gw, AG_CALLER_IDENT_ENABLE, buf,
+			sizeof(AG_CALLER_IDENT_ENABLE) - 1);
+	rfcomm_send_and_read(gw, AG_CARRIER_FORMAT, buf,
+			sizeof(AG_CARRIER_FORMAT) - 1);
+	if ((gw->ag_features & AG_FEATURE_EXTENDED_RES_CODE) != 0)
+		rfcomm_send_and_read(gw, AG_EXTENDED_RESULT_CODE, buf,
+			sizeof(AG_EXTENDED_RESULT_CODE) - 1);
+
+	return TRUE;
+}
+
+static void process_ind_change(struct audio_device *dev, guint index,
+							gint value)
+{
+	struct gateway *gw = dev->gateway;
+	struct indicator *ind = g_slist_nth_data(gw->indies, index);
+	gchar *name = ind->descr;
+
+	ind->value = value;
+
+	if (!strcmp(name, "call")) {
+		if (value > 0) {
+			g_dbus_emit_signal(dev->conn, dev->path,
+					AUDIO_GATEWAY_INTERFACE,
+					"CallStarted", DBUS_TYPE_INVALID);
+			gw->is_dialing = FALSE;
+		} else
+			g_dbus_emit_signal(dev->conn, dev->path,
+					AUDIO_GATEWAY_INTERFACE,
+					"CallEnded", DBUS_TYPE_INVALID);
+
+	} else if (!strcmp(name, "callsetup") && gw->is_dialing) {
+		if (value == 0) {
+			g_dbus_emit_signal(dev->conn, dev->path,
+					AUDIO_GATEWAY_INTERFACE,
+					"CallTerminated",
+					DBUS_TYPE_INVALID);
+			gw->is_dialing = FALSE;
+		} else
+			gw->is_dialing = TRUE;
+
+	} else if (!strcmp(name, "callheld")) {
+		/* FIXME: The following code is based on assumptions only.
+		 * Has to be tested for interoperability
+		 * I assume that callheld=2 would be sent when dial from HF
+		 * failed in case of 3-way call
+		 * Unfortunately this path is not covered by the HF spec so
+		 * the code has to be tested for interop
+		*/
+		/* '2' means: all calls held, no active calls */
+		if (value == 2) {
+			if (gw->is_dialing) {
+				g_dbus_emit_signal(dev->conn, dev->path,
+					AUDIO_GATEWAY_INTERFACE,
+					"CallTerminated",
+					DBUS_TYPE_INVALID);
+				gw->is_dialing = FALSE;
+			}
+		}
+	} else if (!strcmp(name, "service"))
+		emit_property_changed(dev->conn, dev->path,
+				AUDIO_GATEWAY_INTERFACE, "RegistrationStatus",
+				DBUS_TYPE_UINT16, &value);
+	else if (!strcmp(name, "signal"))
+		emit_property_changed(dev->conn, dev->path,
+				AUDIO_GATEWAY_INTERFACE, "SignalStrength",
+				DBUS_TYPE_UINT16, &value);
+	else if (!strcmp(name, "roam"))
+		emit_property_changed(dev->conn, dev->path,
+				AUDIO_GATEWAY_INTERFACE, "RoamingStatus",
+				DBUS_TYPE_UINT16, &value);
+	else if (!strcmp(name, "battchg"))
+		emit_property_changed(dev->conn, dev->path,
+				AUDIO_GATEWAY_INTERFACE, "BatteryCharge",
+				DBUS_TYPE_UINT16, &value);
+}
+
+static void process_ring(struct audio_device *device, GIOChannel *chan,
+			gchar *buf)
+{
+	gchar number[AG_CALLER_NUM_SIZE];
+	gchar *sep;
+	guint read;
+
+	rfcomm_stop_watch(device);
+	g_io_channel_read_chars(chan, buf, RFCOMM_BUF_SIZE - 1, &read, NULL);
+
+	if (strlen(buf) > AG_CALLER_NUM_SIZE + 10)
+		error("process_ring(): buf is too long '%s'", buf);
+	else if (sscanf(buf, "\r\n+CLIP:%s\r\n", number) == 1) {
+		sep = strchr(number, ',');
+		sep[0] = '\0';
+		/* FIXME:signal will be emitted on each RING+CLIP. That's bad */
+		g_dbus_emit_signal(device->conn, device->path,
+				AUDIO_GATEWAY_INTERFACE, "Ring",
+				DBUS_TYPE_STRING, number,
+				DBUS_TYPE_INVALID);
+	} else
+		error("process_ring(): '%s' in place of +CLIP after RING", buf);
+
+	rfcomm_start_watch(device);
+}
+
+static gboolean rfcomm_ag_data_cb(GIOChannel *chan, GIOCondition cond,
+					struct audio_device *device)
+{
+	gchar buf[RFCOMM_BUF_SIZE];
+	struct gateway *gw;
+	guint read;
+	/* some space for value */
+	gchar indicator[AG_INDICATOR_DESCR_SIZE + 4];
+	gint value;
+	guint index;
+	gchar *sep;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	gw = device->gateway;
+
+	if (cond & (G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	if (g_io_channel_read_chars(chan, buf, sizeof(buf) - 1, &read, NULL)
+			!= G_IO_ERROR_NONE)
+		return TRUE;
+	buf[read] = '\0';
+
+	if (strlen(buf) > AG_INDICATOR_DESCR_SIZE + 14)
+		error("rfcomm_ag_data_cb(): buf is too long '%s'", buf);
+	else if (sscanf(buf, "\r\n+CIEV:%s\r\n", indicator) == 1) {
+		sep = strchr(indicator, ',');
+		sep[0] = '\0';
+		sep += 1;
+		index = atoi(indicator);
+		value = atoi(sep);
+		process_ind_change(device, index, value);
+	} else if (strstr(buf, "RING"))
+		process_ring(device, chan, buf);
+	else if (sscanf(buf, "\r\n+BVRA:%d\r\n", &value) == 1) {
+		if (value == 0)
+			g_dbus_emit_signal(device->conn, device->path,
+					AUDIO_GATEWAY_INTERFACE,
+					"VoiceRecognitionActive",
+					DBUS_TYPE_INVALID);
+		else
+			g_dbus_emit_signal(device->conn, device->path,
+					AUDIO_GATEWAY_INTERFACE,
+					"VoiceRecognitionInactive",
+					DBUS_TYPE_INVALID);
+	} else if (sscanf(buf, "\r\n+VGS:%d\r\n", &value) == 1) {
+		gw->sp_gain = value;
+		emit_property_changed(device->conn, device->path,
+				AUDIO_GATEWAY_INTERFACE, "SpeakerGain",
+				DBUS_TYPE_UINT16, &value);
+	} else if (sscanf(buf, "\r\n+VGM:%d\r\n", &value) == 1) {
+		gw->mic_gain = value;
+		emit_property_changed(device->conn, device->path,
+				AUDIO_GATEWAY_INTERFACE, "MicrophoneGain",
+				DBUS_TYPE_UINT16, &value);
+	} else
+		error("rfcomm_ag_data_cb(): read wrong data '%s'", buf);
+
+	return TRUE;
+}
+
+static gboolean sco_io_cb(GIOChannel *chan, GIOCondition cond,
+			struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		GIOChannel *chan = gw->sco;
+		g_io_channel_unref(chan);
+		g_io_channel_close(chan);
+		gw->sco = NULL;
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct audio_device *dev = (struct audio_device *) user_data;
+	struct gateway *gw = dev->gateway;
+
+	if (err) {
+		error("sco_connect_cb(): %s (%d)", err->message);
+		/* not sure, but from other point of view,
+		 * what is the reason to have headset which
+		 * cannot play audio? */
+		gateway_close(dev);
+		return;
+	}
+
+	gw->sco = chan;
+	if (gw->sco_start_cb)
+		gw->sco_start_cb(dev, gw->sco_start_cb_data);
+
+	/* why is this here? */
+	fcntl(g_io_channel_unix_get_fd(chan), F_SETFL, 0);
+	g_io_add_watch(gw->sco, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) sco_io_cb, dev);
+}
+
+static void rfcomm_connect_cb(GIOChannel *chan, GError *err,
+				gpointer user_data)
+{
+	struct audio_device *dev = user_data;
+	struct gateway *gw = dev->gateway;
+	DBusMessage *conn_mes = gw->connect_message;
+	gchar gw_addr[18];
+	GIOFlags flags;
+
+	if (err) {
+		error("connect(): %s", err->message);
+		if (gw->sco_start_cb)
+			gw->sco_start_cb(NULL, gw->sco_start_cb_data);
+		return;
+	}
+
+	ba2str(&dev->dst, gw_addr);
+	/* Blocking mode should be default, but just in case: */
+	flags = g_io_channel_get_flags(chan);
+	flags &= ~G_IO_FLAG_NONBLOCK;
+	flags &= G_IO_FLAG_MASK;
+	g_io_channel_set_flags(chan, flags, NULL);
+	g_io_channel_set_encoding(chan, NULL, NULL);
+	g_io_channel_set_buffered(chan, FALSE);
+	gw->rfcomm = chan;
+	if (establish_service_level_conn(dev->gateway)) {
+		GIOChannel *sco_server = bt_io_listen(BT_IO_SCO, sco_connect_cb,
+					NULL, dev, NULL, NULL,
+					BT_IO_OPT_SOURCE_BDADDR, &dev->src,
+					BT_IO_OPT_INVALID);
+
+		if (sco_server) {
+			gboolean value = TRUE;
+			debug("%s: Connected to %s", dev->path, gw_addr);
+			rfcomm_start_watch(dev);
+			gw->sco_server = sco_server;
+			if (conn_mes) {
+				DBusMessage *reply =
+				dbus_message_new_method_return(conn_mes);
+				dbus_connection_send(dev->conn, reply, NULL);
+				dbus_message_unref(reply);
+				dbus_message_unref(conn_mes);
+				gw->connect_message = NULL;
+			}
+
+			emit_property_changed(dev->conn, dev->path,
+					AUDIO_GATEWAY_INTERFACE,
+					"Connected", DBUS_TYPE_BOOLEAN,	&value);
+			return;
+		} else
+			error("%s: Failed to setup SCO server socket",
+						dev->path);
+	} else
+		error("%s: Failed to establish service layer connection to %s",
+			dev->path, gw_addr);
+
+	if (NULL != gw->sco_start_cb)
+		gw->sco_start_cb(NULL, gw->sco_start_cb_data);
+
+	gateway_close(dev);
+}
+
+static void get_record_cb(sdp_list_t *recs, int perr, gpointer user_data)
+{
+	struct audio_device *dev = user_data;
+	DBusMessage *conn_mes = dev->gateway->connect_message;
+	int ch = -1;
+	sdp_list_t *protos, *classes = NULL;
+	uuid_t uuid;
+	gateway_stream_cb_t sco_cb;
+	GIOChannel *io;
+	GError *err = NULL;
+
+	if (perr < 0)
+		error("Unable to get service record: %s (%d)", strerror(-perr),
+					-perr);
+	else if (!recs || !recs->data)
+		error("No records found");
+	else if (sdp_get_service_classes(recs->data, &classes) < 0)
+		error("Unable to get service classes from record");
+	else {
+		memcpy(&uuid, classes->data, sizeof(uuid));
+
+		if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16)
+			error("Not a 16 bit UUID");
+		else if (uuid.value.uuid16 != HANDSFREE_AGW_SVCLASS_ID)
+			error("Service record didn't contain the HFP UUID");
+		else if (!sdp_get_access_protos(recs->data, &protos)) {
+			ch = sdp_get_proto_port(protos, RFCOMM_UUID);
+			sdp_list_foreach(protos,
+				(sdp_list_func_t) sdp_list_free, NULL);
+			sdp_list_free(protos, NULL);
+			if (ch == -1)
+				error("Unable to extract RFCOMM channel"
+						" from service record");
+			else {
+				io = bt_io_connect(BT_IO_RFCOMM,
+					rfcomm_connect_cb, dev, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &dev->src,
+					BT_IO_OPT_DEST_BDADDR, &dev->dst,
+					BT_IO_OPT_CHANNEL, ch,
+					BT_IO_OPT_INVALID);
+				if (!io) {
+					
+					error("Unable to connect: %s",
+						err->message);
+					if (conn_mes)
+						error_common_reply(dev->conn,
+						conn_mes, ERROR_INTERFACE
+						".ConnectionAttemptFailed",
+						err->message);
+					g_error_free(err);
+					gateway_close(dev);
+				}
+				sdp_list_free(classes, free);
+				return;
+			}
+		}
+	}
+
+	if (classes)
+		sdp_list_free(classes, free);
+
+	if (recs && recs->data)
+		sdp_record_free(recs->data);
+
+	if (conn_mes) {
+		error_common_reply(dev->conn, conn_mes,
+			ERROR_INTERFACE".NotSupported", "Not supported");
+		dbus_message_unref(conn_mes);
+		dev->gateway->connect_message = NULL;
+	}
+	sco_cb = dev->gateway->sco_start_cb;
+	if (sco_cb)
+		sco_cb(NULL, dev->gateway->sco_start_cb_data);
+
+}
+
+static int get_records(struct audio_device *device)
+{
+	uuid_t uuid;
+
+	sdp_uuid16_create(&uuid, HANDSFREE_AGW_SVCLASS_ID);
+	return bt_search_service(&device->src, &device->dst, &uuid,
+				get_record_cb, device, NULL);
+}
+
+static DBusMessage *ag_connect(DBusConnection *conn, DBusMessage *msg,
+				void *data)
+{
+	struct audio_device *au_dev = (struct audio_device *) data;
+	struct gateway *gw = au_dev->gateway;
+
+	if (gw->rfcomm)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+					".AlreadyConnected",
+					"Already Connected");
+
+	gw->connect_message = dbus_message_ref(msg);
+	if (get_records(au_dev) < 0) {
+		dbus_message_unref(gw->connect_message);
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+					".ConnectAttemptFailed",
+					"Connect Attempt Failed");
+	}
+	return NULL;
+}
+
+static DBusMessage *ag_disconnect(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	DBusMessage *reply = NULL;
+	char gw_addr[18];
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	if (!gw->rfcomm)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".NotConnected",
+						"Device not Connected");
+
+	gateway_close(device);
+	ba2str(&device->dst, gw_addr);
+	debug("Disconnected from %s, %s", gw_addr, device->path);
+
+	return reply;
+}
+
+static DBusMessage *process_ag_reponse(DBusMessage *msg, gchar *response)
+{
+	DBusMessage *reply;
+
+	if (strstr(response, OK_RESPONSE))
+		reply = dbus_message_new_method_return(msg);
+	else {
+		/* FIXME: some code should be here to processes errors
+		 *  in better fasion */
+		debug("AG responded with '%s' to %s method call", response,
+				dbus_message_get_member(msg));
+		reply = dbus_message_new_error(msg, ERROR_INTERFACE
+					".OperationFailed",
+					"Operation failed.See log for details");
+	}
+	return reply;
+}
+
+static DBusMessage *process_simple(DBusMessage *msg, struct audio_device *dev,
+					gchar *data)
+{
+	struct gateway *gw = dev->gateway;
+	gchar buf[RFCOMM_BUF_SIZE];
+
+	rfcomm_stop_watch(dev);
+	rfcomm_send_and_read(gw, data, buf, strlen(data));
+	rfcomm_start_watch(dev);
+	return process_ag_reponse(msg, buf);
+}
+
+#define AG_ANSWER "ATA\r"
+
+static DBusMessage *ag_answer(DBusConnection *conn, DBusMessage *msg,
+				void *data)
+{
+	return process_simple(msg, (struct audio_device *) data, AG_ANSWER);
+}
+
+#define AG_HANGUP "AT+CHUP\r"
+
+static DBusMessage *ag_terminate_call(DBusConnection *conn, DBusMessage *msg,
+				void *data)
+{
+	return process_simple(msg, (struct audio_device *) data, AG_HANGUP);
+}
+
+/* according to GSM spec */
+#define ALLOWED_NUMBER_SYMBOLS "1234567890*#+ABC"
+#define AG_PLACE_CALL "ATD%s\r"
+/* dialing from memory is not supported as headset spec doesn't define a way
+ * to retreive phone memory entries.
+ */
+static DBusMessage *ag_call(DBusConnection *conn, DBusMessage *msg,
+				void *data)
+{
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	gchar buf[RFCOMM_BUF_SIZE];
+	gchar *number;
+	gint atd_len;
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+				DBUS_TYPE_INVALID);
+	if (strlen(number) != strspn(number, ALLOWED_NUMBER_SYMBOLS))
+		return dbus_message_new_error(msg,
+			ERROR_INTERFACE ".BadNumber",
+			"Number contains characters which are not allowed");
+
+	atd_len = sprintf(buf, AG_PLACE_CALL, number);
+	rfcomm_stop_watch(device);
+	rfcomm_send_and_read(gw, buf, buf, atd_len);
+	rfcomm_start_watch(device);
+	return process_ag_reponse(msg, buf);
+}
+
+#define AG_GET_CARRIER "AT+COPS?\r"
+
+static DBusMessage *ag_get_operator(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct audio_device *dev = (struct audio_device *) data;
+	struct gateway *gw = dev->gateway;
+	gchar buf[RFCOMM_BUF_SIZE];
+	GIOChannel *rfcomm = gw->rfcomm;
+	gsize read;
+	gchar *result;
+	DBusMessage *reply;
+	GIOStatus status;
+
+	rfcomm_stop_watch(dev);
+	io_channel_write_all(rfcomm, AG_GET_CARRIER, strlen(AG_GET_CARRIER));
+
+	status = g_io_channel_read_chars(rfcomm, buf, RFCOMM_BUF_SIZE - 1,
+						&read, NULL);
+	rfcomm_start_watch(dev);
+	if (G_IO_STATUS_NORMAL == status) {
+		buf[read] = '\0';
+		if (strstr(buf, "+COPS")) {
+			result = strrchr(buf, ',') + 1;
+			reply = dbus_message_new_method_return(msg);
+			dbus_message_append_args(reply, DBUS_TYPE_STRING,
+						&result, DBUS_TYPE_INVALID);
+		} else {
+			info("ag_get_operator(): '+COPS' expected but"
+				" '%s' received", buf);
+			reply = dbus_message_new_error(msg, ERROR_INTERFACE
+						".Failed",
+						"Unexpected response from AG");
+		}
+	} else {
+		error("ag_get_operator(): %m");
+		reply = dbus_message_new_error(msg, ERROR_INTERFACE
+					".ConnectionFailed",
+					"Failed to receive response from AG");
+	}
+
+	return reply;
+}
+
+#define AG_SEND_DTMF "AT+VTS:%c\r"
+static DBusMessage *ag_send_dtmf(DBusConnection *conn, DBusMessage *msg,
+				void *data)
+{
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	gchar buf[RFCOMM_BUF_SIZE];
+	gchar *number;
+	gint com_len;
+	gboolean got_ok = TRUE;
+	gint num_len;
+	gint i = 0;
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+				DBUS_TYPE_INVALID);
+	if (strlen(number) != strspn(number, ALLOWED_NUMBER_SYMBOLS))
+		return dbus_message_new_error(msg,
+			ERROR_INTERFACE ".BadNumber",
+			"Number contains characters which are not allowed");
+
+	num_len = strlen(number);
+	rfcomm_stop_watch(device);
+	while (i < num_len && got_ok) {
+		com_len = sprintf(buf, AG_SEND_DTMF, number[i]);
+		rfcomm_send_and_read(gw, buf, buf, com_len);
+		got_ok = NULL != strstr(buf, OK_RESPONSE);
+		i += 1;
+	}
+	rfcomm_start_watch(device);
+	return process_ag_reponse(msg, buf);
+}
+
+#define AG_GET_SUBSCRIBER_NUMS "AT+CNUM\r"
+#define CNUM_LEN 5             /* length of "+CNUM" string */
+#define MAX_NUMBER_CNT 16
+static DBusMessage *ag_get_subscriber_num(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	gchar buf[RFCOMM_BUF_SIZE];
+	gchar *number, *end;
+	DBusMessage *reply = dbus_message_new_method_return(msg);
+
+	rfcomm_stop_watch(device);
+	rfcomm_send_and_read(gw, AG_GET_SUBSCRIBER_NUMS, buf,
+			strlen(AG_GET_SUBSCRIBER_NUMS));
+	rfcomm_start_watch(device);
+
+	if (strlen(buf) > AG_CALLER_NUM_SIZE + 21)
+		error("ag_get_subscriber_num(): buf is too long '%s'", buf);
+	else if (strstr(buf, "+CNUM")) {
+		number = strchr(buf, ',');
+		number++;
+		end = strchr(number, ',');
+		if (end) {
+			*end = '\0';
+			dbus_message_append_args(reply, DBUS_TYPE_STRING,
+						&number, DBUS_TYPE_INVALID);
+		}
+	} else
+		error("ag_get_subscriber_num(): read wrong data '%s'", buf);
+
+	return reply;
+}
+
+static DBusMessage *ag_get_properties(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	gboolean value;
+	guint index = 0;
+	struct indicator *ind;
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
+	/* Connected */
+	value = gateway_is_connected(device);
+	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
+
+	if (!value)
+		goto done;
+
+	while ((ind = g_slist_nth_data(gw->indies, index))) {
+		if (!strcmp(ind->descr, "service"))
+			dict_append_entry(&dict, "RegistrationStatus",
+					DBUS_TYPE_UINT16, &ind->value);
+		else if (!strcmp(ind->descr, "signal"))
+			dict_append_entry(&dict, "SignalStrength",
+					DBUS_TYPE_UINT16, &ind->value);
+		else if (!strcmp(ind->descr, "roam"))
+			dict_append_entry(&dict, "RoamingStatus",
+					DBUS_TYPE_UINT16, &ind->value);
+		else if (!strcmp(ind->descr, "battchg"))
+			dict_append_entry(&dict, "BatteryCharge",
+					DBUS_TYPE_UINT16, &ind->value);
+		index++;
+	}
+
+	/* SpeakerGain */
+	dict_append_entry(&dict, "SpeakerGain", DBUS_TYPE_UINT16,
+				&device->gateway->sp_gain);
+
+	/* MicrophoneGain */
+	dict_append_entry(&dict, "MicrophoneGain", DBUS_TYPE_UINT16,
+				&device->gateway->mic_gain);
+done:
+	dbus_message_iter_close_container(&iter, &dict);
+	return reply;
+}
+
 static GDBusMethodTable gateway_methods[] = {
+	{ "Connect", "", "", ag_connect, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect", "", "", ag_disconnect },
+	{ "AnswerCall", "", "", ag_answer },
+	{ "TerminateCall", "", "", ag_terminate_call },
+	{ "Call", "s", "", ag_call },
+	{ "GetOperatorName", "", "s", ag_get_operator },
+	{ "SendDTMF", "s", "", ag_send_dtmf },
+	{ "GetSubscriberNumber", "", "s", ag_get_subscriber_num },
+	{ "GetProperties", "", "a{sv}", ag_get_properties },
 	{ NULL, NULL, NULL, NULL }
 };

 static GDBusSignalTable gateway_signals[] = {
+	{ "Ring", "s" },
+	{ "CallTerminated", "" },
+	{ "CallStarted", "" },
+	{ "CallEnded", "" },
+	{ "PropertyChanged", "sv" },
 	{ NULL, NULL }
 };

@@ -95,4 +1000,46 @@ int gateway_connect_rfcomm(struct audio_device
*dev, GIOChannel *io)

 void gateway_start_service(struct audio_device *device)
 {
+	rfcomm_connect_cb(device->gateway->rfcomm, NULL, device);
+}
+
+static void indicator_slice_free(gpointer mem)
+{
+	g_slice_free(struct indicator, mem);
+}
+
+int gateway_close(struct audio_device *device)
+{
+	struct gateway *gw = device->gateway;
+	GIOChannel *rfcomm = gw->rfcomm;
+	GIOChannel *sco = gw->sco;
+	GIOChannel *sco_server = gw->sco_server;
+	gboolean value = FALSE;
+
+	g_slist_foreach(gw->indies, (GFunc) indicator_slice_free, NULL);
+	g_slist_free(gw->indies);
+	if (rfcomm) {
+		g_io_channel_close(rfcomm);
+		g_io_channel_unref(rfcomm);
+		gw->rfcomm = NULL;
+	}
+
+	if (sco) {
+		g_io_channel_close(sco);
+		g_io_channel_unref(sco);
+		gw->sco = NULL;
+		gw->sco_start_cb = NULL;
+		gw->sco_start_cb_data = NULL;
+	}
+
+	if (sco_server) {
+		g_io_channel_close(sco_server);
+		g_io_channel_unref(sco_server);
+		gw->sco_server = NULL;
+	}
+
+	emit_property_changed(device->conn, device->path,
+				AUDIO_GATEWAY_INTERFACE,
+				"Connected", DBUS_TYPE_BOOLEAN, &value);
+	return 0;
 }

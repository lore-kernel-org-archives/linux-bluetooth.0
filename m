Return-Path: <cyrus@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <A9056199-F858-4104-8B29-D2E55842306E@tiscali.it>
From: Michele Noberasco <michele.noberasco@tiscali.it>
To: event <event.riga@gmail.com>
In-Reply-To: <664d43d60901222334h4e1cb498hf8b3b01433e3ab92@mail.gmail.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3-989292480
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] BlueZ support for audio gateway role (HFP/HSP)
Date: Fri, 23 Jan 2009 09:32:42 +0100
References: <2C0A35D3-4DD9-4089-8061-F596A8A5A4B8@tiscali.it> <664d43d60901222334h4e1cb498hf8b3b01433e3ab92@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail-3-989292480
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Il giorno 23/gen/09, alle ore 08:34, event ha scritto:

> Hello Michele,
>
> I'm doing the same function just now :).
> So please send your code and I will look there for something I've  
> missed.

Glad that my partial work might be of help.
Here it is...

Regards,
Michele Noberasco


--Apple-Mail-3-989292480
Content-Disposition: attachment;
	filename=bluez-utils-3.36.audio-gateway.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="bluez-utils-3.36.audio-gateway.patch"
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-3.36/audio/gateway.c bluez-utils-3.36-new/audio/gateway.c
--- bluez-utils-3.36/audio/gateway.c	2008-05-20 18:14:20.000000000 +0200
+++ bluez-utils-3.36-new/audio/gateway.c	2008-09-29 15:33:25.000000000 +0200
@@ -26,9 +26,1005 @@
 #include <config.h>
 #endif
 
-#include <stdint.h>
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <signal.h>
+#include <string.h>
+#include <getopt.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+#include <bluetooth/sco.h>
+#include <bluetooth/rfcomm.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
+#include <gdbus.h>
 
+#include "logging.h"
+#include "device.h"
+#include "manager.h"
+#include "error.h"
 #include "gateway.h"
+#include "glib-helper.h"
+
+
+#define BUF_SIZE 1024
+
+static char *str_state[] = {
+	"GATEWAY_STATE_DISCONNECTED",
+	"GATEWAY_STATE_CONNECT_IN_PROGRESS",
+	"GATEWAY_STATE_CONNECTED",
+/* 	"GATEWAY_STATE_PLAY_IN_PROGRESS", */
+/* 	"GATEWAY_STATE_PLAYING", */
+};
+
+struct connect_cb {
+	unsigned int id;
+	gateway_stream_cb_t cb;
+	void *cb_data;
+};
+
+struct pending_connect {
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	GIOChannel *io;
+	int err;
+	gateway_state_t target_state;
+	GSList *callbacks;
+};
+
+struct gateway {
+	uint32_t hsp_handle;
+	uint32_t hfp_handle;
+
+	int rfcomm_ch;
+
+	GIOChannel *rfcomm;
+	GIOChannel *tmp_rfcomm;
+	GIOChannel *sco;
+	guint sco_id;
+
+	gboolean auto_dc;
+
+	guint ring_timer;
+
+	guint dc_timer;
+
+	char buf[BUF_SIZE];
+	int data_start;
+	int data_length;
+
+	gboolean hfp_active;
+	gboolean search_hfp;
+	gboolean cli_active;
+	char *ph_number;
+	int type;
+
+	gateway_state_t state;
+	struct pending_connect *pending;
+
+	int sp_gain;
+	int mic_gain;
+
+	unsigned int hfp_features;
+	gateway_lock_t lock;
+};
+
+struct event {
+	const char *cmd;
+	int (*callback) (struct audio_device *device, const char *buf);
+};
+
+
+static int rfcomm_connect(struct audio_device *device, gateway_stream_cb_t cb,
+				void *user_data, unsigned int *cb_id);
+static int get_records(struct audio_device *device, gateway_stream_cb_t cb,
+			void *user_data, unsigned int *cb_id);
+
+static int gateway_send(struct gateway *gw, char *format, ...)
+{
+	info("gateway.c: gateway_send");
+
+	char rsp[BUF_SIZE];
+	va_list ap;
+	ssize_t total_written, written, count;
+	int fd;
+
+	va_start(ap, format);
+	count = vsnprintf(rsp, sizeof(rsp), format, ap);
+	va_end(ap);
+
+	info("  gateway_send: sending message \"%s\"", rsp);
+
+	if (count < 0)
+		return -EINVAL;
+
+	if (!gw->rfcomm) {
+		error("  gateway_send: the gateway is not connected");
+		return -EIO;
+	}
+
+	written = total_written = 0;
+	fd = g_io_channel_unix_get_fd(gw->rfcomm);
+
+	while (total_written < count) {
+		written = write(fd, rsp + total_written, count - total_written);
+		if (written < 0)
+			return -errno;
+
+		total_written += written;
+	}
+
+	return 0;
+}
+
+static DBusMessage *gw_disconnect(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	info("gateway.c: gw_disconnect");
+
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	DBusMessage *reply = NULL;
+	char gw_address[18];
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	if (gw->state == GATEWAY_STATE_DISCONNECTED)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".NotConnected",
+						"Device not Connected");
+
+	gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
+	ba2str(&device->dst, gw_address);
+	info("Disconnected from %s, %s", gw_address, device->path);
+
+	return reply;
+}
+
+static DBusMessage *gw_is_connected(DBusConnection *conn,
+						DBusMessage *msg,
+						void *data)
+{
+	info("gateway.c: gw_is_connected");
+
+	struct audio_device *device = data;
+	DBusMessage *reply;
+	dbus_bool_t connected;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	connected = (device->gateway->state >= GATEWAY_STATE_CONNECTED);
+
+	dbus_message_append_args(reply, DBUS_TYPE_BOOLEAN, &connected,
+					DBUS_TYPE_INVALID);
+
+	return reply;
+}
+
+static DBusMessage *gw_connect(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	info("gateway.c: gw_connect");
+
+	struct audio_device *device = data;
+	struct gateway *gw = device->gateway;
+	int err;
+
+	if (gw->state == GATEWAY_STATE_CONNECT_IN_PROGRESS)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".InProgress",
+						"Connect in Progress");
+	else if (gw->state > GATEWAY_STATE_CONNECT_IN_PROGRESS)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".AlreadyConnected",
+						"Already Connected");
+
+	err = rfcomm_connect(device, NULL, NULL, NULL);
+	if (err < 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".ConnectAttemptFailed",
+						"Connect Attempt Failed");
+
+	gw->auto_dc = FALSE;
+
+	gw->pending->msg = dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static int phone_ringing(struct audio_device *device, const char *buf)
+{
+	info("gateway.c: phone_ringing");
+
+	struct gateway *gw = device->gateway;
+	int err;
+
+	g_dbus_emit_signal(device->conn, device->path,
+			AUDIO_GATEWAY_INTERFACE, "PhoneRinging",
+			DBUS_TYPE_INVALID);
+
+/* 	if (hs->ring_timer) { */
+/* 		g_source_remove(hs->ring_timer); */
+/* 		hs->ring_timer = 0; */
+/* 	} */
+
+/* 	if (!hs->hfp_active) */
+/* 		return gateway_send(gw, "\r\nOK\r\n"); */
+	return 0;
+
+/* 	if (hs->ph_number) { */
+/* 		g_free(hs->ph_number); */
+/* 		hs->ph_number = NULL; */
+/* 	} */
+
+/* 	err = headset_send(hs, "\r\nOK\r\n"); */
+/* 	if (err < 0) */
+/* 		return err; */
+
+/* 	/\*+CIEV: (call = 1)*\/ */
+/* 	err = headset_send(hs, "\r\n+CIEV:2,1\r\n"); */
+/* 	if (err < 0) */
+/* 		return err; */
+
+/* 	/\*+CIEV: (callsetup = 0)*\/ */
+/* 	return headset_send(hs, "\r\n+CIEV:3,0\r\n"); */
+}
+
+static int phone_error(struct audio_device *device, const char *buf)
+{
+	info("gateway.c: phone_error");
+
+	struct gateway *gw = device->gateway;
+	int err;
+
+	g_dbus_emit_signal(device->conn, device->path,
+			AUDIO_GATEWAY_INTERFACE, "PhoneError",
+			DBUS_TYPE_INVALID);
+
+	return 0;
+}
+
+static int phone_ok(struct audio_device *device, const char *buf)
+{
+	info("gateway.c: phone_ok");
+
+	struct gateway *gw = device->gateway;
+	int err;
+
+	g_dbus_emit_signal(device->conn, device->path,
+			AUDIO_GATEWAY_INTERFACE, "PhoneOK",
+			DBUS_TYPE_INVALID);
+
+	return 0;
+}
+
+static struct event event_callbacks[] = {
+	{ "RING", phone_ringing },
+	{ "ERROR", phone_error },
+	{ "ERROR", phone_ok },
+/* 	{ "ATA", answer_call }, */
+/* 	{ "AT+VG", signal_gain_setting }, */
+/* 	{ "AT+BRSF", supported_features }, */
+/* 	{ "AT+CIND", report_indicators }, */
+/* 	{ "AT+CMER", event_reporting }, */
+/* 	{ "AT+CHLD", call_hold }, */
+/* 	{ "AT+CHUP", terminate_call }, */
+/* 	{ "AT+CKPD", answer_call }, */
+/* 	{ "AT+CLIP", cli_notification }, */
+	{ 0 }
+};
+
+static int handle_event(struct audio_device *device, const char *buf)
+{
+	info("gateway.c: handle_event");
+
+	struct event *ev;
+
+	info("  Received \"%s\"", buf);
+
+/* 	int i=0; */
+/* 	for (; buf[i] != '\0'; i++) */
+/* 		info("  %d", buf[i]); */
+
+	for (ev = event_callbacks; ev->cmd; ev++) {
+		if (!strncmp(buf, ev->cmd, strlen(ev->cmd)))
+			return ev->callback(device, buf);
+	}
+
+	return -EINVAL;
+}
+
+static void close_sco(struct audio_device *device)
+{
+	info("gateway.c: close_sco");
+
+	struct gateway *gw = device->gateway;
+
+	if (gw->sco) {
+		g_source_remove(gw->sco_id);
+		gw->sco_id = 0;
+		g_io_channel_close(gw->sco);
+		g_io_channel_unref(gw->sco);
+		gw->sco = NULL;
+	}
+}
+
+static GDBusMethodTable gateway_methods[] = {
+	{ "Connect",		"",	"",	gw_connect,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect",		"",	"",	gw_disconnect },
+	{ "IsConnected",	"",	"b",	gw_is_connected },
+/* 	{ "IndicateCall",	"",	"",	hs_ring }, */
+/* 	{ "CancelCall",		"",	"",	hs_cancel_ringing }, */
+/* 	{ "Play",		"",	"",	hs_play, */
+/* 						G_DBUS_METHOD_FLAG_ASYNC }, */
+/* 	{ "Stop",		"",	"",	hs_stop }, */
+/* 	{ "IsPlaying",		"",	"b",	hs_is_playing }, */
+/* 	{ "GetSpeakerGain",	"",	"q",	hs_get_speaker_gain }, */
+/* 	{ "GetMicrophoneGain",	"",	"q",	hs_get_mic_gain }, */
+/* 	{ "SetSpeakerGain",	"q",	"",	hs_set_speaker_gain }, */
+/* 	{ "SetMicrophoneGain",	"q",	"",	hs_set_mic_gain }, */
+/* 	{ "SetupCall",		"s",	"",	hf_setup_call }, */
+/* 	{ "IdentifyCall",	"si",	"",	hf_identify_call }, */
+	{ NULL, NULL, NULL, NULL }
+};
+
+static GDBusSignalTable gateway_signals[] = {
+	{ "Connected",			""	},
+	{ "Disconnected",		""	},
+/* 	{ "AnswerRequested",		""	}, */
+/* 	{ "Stopped",			""	}, */
+/* 	{ "Playing",			""	}, */
+/* 	{ "SpeakerGainChanged",		"q"	}, */
+/* 	{ "MicrophoneGainChanged",	"q"	}, */
+/* 	{ "CallTerminated",		""	}, */
+	{ "PhoneRinging",		""	},
+	{ "PhoneError",		""	},
+	{ "PhoneOK",		""	},
+	{ NULL, NULL }
+};
+
+static void gateway_set_channel(struct gateway *gateway, sdp_record_t *record,
+				uint16_t svc)
+{
+	info("gateway.c: gateway_set_channel");
+
+	int ch;
+	sdp_list_t *protos;
+
+	if (sdp_get_access_protos(record, &protos) < 0) {
+		error("Unable to get access protos from gateway record");
+		return;
+	}
+
+	ch = sdp_get_proto_port(protos, RFCOMM_UUID);
+
+	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+	sdp_list_free(protos, NULL);
+
+	if (ch > 0) {
+		gateway->rfcomm_ch = ch;
+		info("Discovered %s service on RFCOMM channel %d",
+			svc == HEADSET_AGW_SVCLASS_ID ? "Headset" : "Handsfree",
+			ch);
+	} else
+		error("Unable to get RFCOMM channel from Headset record");
+}
+
+struct gateway *gateway_init(struct audio_device *dev, sdp_record_t *record,
+				uint16_t svc)
+{
+	info("gateway.c: gateway_init");
+
+	struct gateway *gw;
+
+	gw = g_new0(struct gateway, 1);
+	gw->rfcomm_ch = -1;
+	gw->sp_gain = -1;
+	gw->mic_gain = -1;
+	gw->search_hfp = server_is_enabled(HANDSFREE_AGW_SVCLASS_ID);
+	gw->hfp_active = FALSE;
+	gw->cli_active = FALSE;
+	gw->ph_number = NULL;
+
+	if (!record)
+		goto register_iface;
+
+	switch (svc) {
+	case HANDSFREE_AGW_SVCLASS_ID:
+		gw->hfp_handle = record->handle;
+		break;
+
+	case HEADSET_AGW_SVCLASS_ID:
+		gw->hsp_handle = record->handle;
+		break;
+
+	default:
+		info("Invalid record passed to gateway_init");
+		g_free(gw);
+		return NULL;
+	}
+
+	gateway_set_channel(gw, record, svc);
+register_iface:
+	if (!g_dbus_register_interface(dev->conn, dev->path,
+					AUDIO_GATEWAY_INTERFACE,
+					gateway_methods, gateway_signals, NULL,
+					dev, NULL)) {
+		g_free(gw);
+		return NULL;
+	}
+
+	return gw;
+}
+
+gboolean gateway_is_active(struct audio_device *dev)
+{
+	info("gateway.c: gateway_is_active");
+
+	struct gateway *gw = dev->gateway;
+
+	if (gw->state != GATEWAY_STATE_DISCONNECTED)
+		return TRUE;
+
+	return FALSE;
+}
+
+void gateway_update(struct audio_device *dev, sdp_record_t *record, uint16_t svc)
+{
+	info("gateway.c: gateway_update");
+
+	struct gateway *gateway = dev->gateway;
+
+	switch (svc) {
+	case HANDSFREE_AGW_SVCLASS_ID:
+		if (gateway->hfp_handle &&
+				(gateway->hfp_handle != record->handle)) {
+			error("More than one HFP record found on device");
+			return;
+		}
+
+		gateway->hfp_handle = record->handle;
+		break;
+
+	case HEADSET_AGW_SVCLASS_ID:
+		if (gateway->hsp_handle &&
+				(gateway->hsp_handle != record->handle)) {
+			error("More than one HSP record found on device");
+			return;
+		}
+
+		gateway->hsp_handle = record->handle;
+
+		/* Ignore this record if we already have access to HFP */
+		if (gateway->hfp_handle)
+			return;
+
+		break;
+
+	default:
+		info("Invalid record passed to gateway_update");
+		return;
+	}
+
+	gateway_set_channel(gateway, record, svc);
+}
+
+void gateway_set_state(struct audio_device *dev, gateway_state_t state)
+{
+	info("gateway.c: gateway_set_state");
+
+	struct gateway *gw = dev->gateway;
+
+	if (gw->state == state)
+		return;
+
+	switch (state) {
+	case GATEWAY_STATE_DISCONNECTED:
+		close_sco(dev);
+		gateway_close_rfcomm(dev);
+		g_dbus_emit_signal(dev->conn, dev->path,
+						AUDIO_GATEWAY_INTERFACE,
+						"Disconnected",
+						DBUS_TYPE_INVALID);
+		break;
+	case GATEWAY_STATE_CONNECT_IN_PROGRESS:
+		break;
+	case GATEWAY_STATE_CONNECTED:
+		close_sco(dev);
+		if (gw->state < state) {
+			g_dbus_emit_signal(dev->conn, dev->path,
+						AUDIO_GATEWAY_INTERFACE,
+						"Connected",
+						DBUS_TYPE_INVALID);
+		} /* else if (gw->state == GATEWAY_STATE_PLAYING) { */
+/* 			g_dbus_emit_signal(dev->conn, dev->path, */
+/* 						AUDIO_GATEWAY_INTERFACE, */
+/* 						"Stopped", */
+/* 						DBUS_TYPE_INVALID); */
+/* 		} */
+
+		gateway_send(gw, "\r\nAT+CKPD\r\n");
+
+		break;
+/* 	case GATEWAY_STATE_PLAY_IN_PROGRESS: */
+/* 		break; */
+/* 	case GATEWAY_STATE_PLAYING: */
+/* 		gw->sco_id = g_io_add_watch(gw->sco, */
+/* 					G_IO_ERR | G_IO_HUP | G_IO_NVAL, */
+/* 					(GIOFunc) sco_cb, dev); */
+
+/* 		g_dbus_emit_signal(dev->conn, dev->path, */
+/* 						AUDIO_GATEWAY_INTERFACE, */
+/* 						"Playing", DBUS_TYPE_INVALID); */
+
+/* 		if (gw->sp_gain >= 0) */
+/* 			gateway_send(gw, "\r\n+VGS=%u\r\n", gw->sp_gain); */
+/* 		if (gw->mic_gain >= 0) */
+/* 			gateway_send(gw, "\r\n+VGM=%u\r\n", gw->mic_gain); */
+/* 		break; */
+	}
+
+	info("State changed %s: %s -> %s", dev->path, str_state[gw->state],
+		str_state[state]);
+	gw->state = state;
+}
+
+gateway_state_t gateway_get_state(struct audio_device *dev)
+{
+	info("gateway.c: gateway_get_state");
+
+	struct gateway *gw = dev->gateway;
+
+	return gw->state;
+}
+
+static void pending_connect_complete(struct connect_cb *cb, struct audio_device *dev)
+{
+	info("gateway.c: pending_connect_complete");
+
+	struct gateway *gw = dev->gateway;
+
+	if (gw->pending->err)
+		cb->cb(NULL, cb->cb_data);
+	else
+		cb->cb(dev, cb->cb_data);
+}
+
+static void pending_connect_finalize(struct audio_device *dev)
+{
+	info("gateway.c: pending_connect_finalize");
+
+	struct gateway *gw = dev->gateway;
+	struct pending_connect *p = gw->pending;
+
+	g_slist_foreach(p->callbacks, (GFunc) pending_connect_complete, dev);
+
+	g_slist_foreach(p->callbacks, (GFunc) g_free, NULL);
+	g_slist_free(p->callbacks);
+
+	if (p->io) {
+		g_io_channel_close(p->io);
+		g_io_channel_unref(p->io);
+	}
+
+	if (p->msg)
+		dbus_message_unref(p->msg);
+
+	if (p->call) {
+		dbus_pending_call_cancel(p->call);
+		dbus_pending_call_unref(p->call);
+	}
+
+	g_free(p);
+
+	gw->pending = NULL;
+}
+
+static void pending_connect_init(struct gateway *gw, gateway_state_t target_state)
+{
+	info("gateway.c: pending_connect_init");
+
+	if (gw->pending) {
+		if (gw->pending->target_state < target_state)
+			gw->pending->target_state = target_state;
+		return;
+	}
+
+	gw->pending = g_new0(struct pending_connect, 1);
+	gw->pending->target_state = target_state;
+}
+
+static unsigned int connect_cb_new(struct gateway *gw,
+					gateway_state_t target_state,
+					gateway_stream_cb_t func,
+					void *user_data)
+{
+	info("gateway.c: connect_cb_new");
+
+	struct connect_cb *cb;
+	unsigned int free_cb_id = 1;
+
+	pending_connect_init(gw, target_state);
+
+	cb = g_new(struct connect_cb, 1);
+
+	cb->cb = func;
+	cb->cb_data = user_data;
+	cb->id = free_cb_id++;
+
+	gw->pending->callbacks = g_slist_append(gw->pending->callbacks,
+						cb);
+
+	return cb->id;
+}
+
+static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
+				struct audio_device *device)
+{
+	info("gateway.c: rfcomm_io_cb");
+
+/* 	static FILE *fp = NULL; */
+/* 	if (!fp) */
+/* 	{ */
+/* 		fp = fopen("/gateway_log.txt", "w"); */
+/* 	} */
+
+	struct gateway *gw;
+	unsigned char buf[BUF_SIZE];
+	char *cr;
+	gsize bytes_read = 0;
+	gsize free_space;
+	int err;
+	off_t cmd_len;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	gw = device->gateway;
+
+	if (cond & (G_IO_ERR | G_IO_HUP))
+		goto failed;
+
+	if (g_io_channel_read(chan, (gchar *) buf, sizeof(buf) - 1,
+				&bytes_read) != G_IO_ERROR_NONE)
+		return TRUE;
+
+	//THORIN: log
+/* 	fwrite(gw->buf, BUF_SIZE, 1, fp); */
+
+	free_space = sizeof(gw->buf) - gw->data_start - gw->data_length - 1;
+
+	info ("  buffer size: %d, free space: %d, bytes read: %d, cond: %d", BUF_SIZE, free_space, bytes_read, (free_space < bytes_read));
+
+	if (free_space < bytes_read) {
+		/* Very likely that the GW is sending us garbage so
+		 * just ignore the data and disconnect */
+		error("Too much data to fit incomming buffer");
+		goto failed;
+	}
+
+	//strip leading whitespace from buffer
+	int offset = 0;
+	int i      = 0;
+	for (; i<bytes_read; i++)
+	{
+		//info("  read char %d", buf[i]);
+		if (buf[i] == '\0' || buf[i] == '\r' || buf[i] == ' ' || buf[i] == '\n' || buf[i] == '\t')
+			offset++;
+		else break;
+	}
+	if (offset == bytes_read)
+		return TRUE;
+
+	//info("  offset is %d", offset);
+	//gchar *pippo = g_strndup(buf+offset, bytes_read-offset);
+	//info("  data read: \"%s\"", pippo);
+
+	memcpy(&gw->buf[gw->data_start], buf+offset, bytes_read-offset);
+	gw->data_length += bytes_read-offset;
+
+	/* Make sure the data is null terminated so we can use string
+	 * functions */
+	gw->buf[gw->data_start + gw->data_length] = '\0';
+
+	cr = strchr(&gw->buf[gw->data_start], '\r');
+	if (!cr)
+		return TRUE;
+
+	cmd_len = 1 + (off_t) cr - (off_t) &gw->buf[gw->data_start];
+	*cr = '\0';
+
+	err = handle_event(device, &gw->buf[gw->data_start]);
+	if (err == -EINVAL) {
+		error("Badly formated or unrecognized command: \"%s\"",
+				&gw->buf[gw->data_start]);
+		err = gateway_send(gw, "\r\nERROR\r\n");
+	} else if (err < 0)
+		error("Error handling command %s: %s (%d)",
+			&gw->buf[gw->data_start], strerror(-err), -err);
+
+	gw->data_start += cmd_len;
+	gw->data_length -= cmd_len;
+
+	if (!gw->data_length)
+		gw->data_start = 0;
+
+	return TRUE;
+
+failed:
+	gateway_set_state(device, GATEWAY_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void rfcomm_connect_cb(GIOChannel *chan, int err, const bdaddr_t *src,
+			const bdaddr_t *dst, gpointer user_data)
+{
+	info("gateway.c: rfcomm_connect_cb");
+
+	struct audio_device *dev = user_data;
+	struct gateway *gw = dev->gateway;
+	struct pending_connect *p = gw->pending;
+	char gw_address[18];
+
+	if (err < 0) {
+		error("connect(): %s (%d)", strerror(-err), -err);
+		goto failed;
+	}
+
+	ba2str(&dev->dst, gw_address);
+	gw->rfcomm = chan;
+	p->io = NULL;
+
+	if (server_is_enabled(HANDSFREE_AGW_SVCLASS_ID) && gw->hfp_handle != 0)
+		gw->hfp_active = TRUE;
+	else
+		gw->hfp_active = FALSE;
+
+	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
+			(GIOFunc) rfcomm_io_cb, dev);
+
+	info("%s: Connected to %s", dev->path, gw_address);
+
+	/* In HFP mode wait for Service Level Connection */
+	if (gw->hfp_active)
+		return;
+
+	gateway_set_state(dev, GATEWAY_STATE_CONNECTED);
+
+/* 	if (p->target_state == GATEWAY_STATE_PLAYING) { */
+/* 		p->err = sco_connect(dev, NULL, NULL, NULL); */
+/* 		if (p->err < 0) */
+/* 			goto failed; */
+/* 		return; */
+/* 	} */
+
+	if (p->msg) {
+		DBusMessage *reply = dbus_message_new_method_return(p->msg);
+		dbus_connection_send(dev->conn, reply, NULL);
+		dbus_message_unref(reply);
+	}
+
+	pending_connect_finalize(dev);
+
+	return;
+
+failed:
+	if (p->msg)
+		error_connection_attempt_failed(dev->conn, p->msg, p->err);
+	pending_connect_finalize(dev);
+	if (gw->rfcomm)
+		gateway_set_state(dev, GATEWAY_STATE_CONNECTED);
+	else
+		gateway_set_state(dev, GATEWAY_STATE_DISCONNECTED);
+}
+
+static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	info("gateway.c: get_record_cb");
+
+	struct audio_device *dev = user_data;
+	struct gateway *gw = dev->gateway;
+	struct pending_connect *p = gw->pending;
+	int ch = -1;
+	sdp_record_t *record = NULL;
+	sdp_list_t *protos, *classes = NULL;
+	uuid_t uuid;
+
+	if (err < 0) {
+		error("Unable to get service record: %s (%d)", strerror(-err),
+			-err);
+		goto failed_not_supported;
+	}
+
+	if (!recs || !recs->data) {
+		error("No records found");
+		goto failed_not_supported;
+	}
+
+	record = recs->data;
+
+	if (sdp_get_service_classes(record, &classes) < 0) {
+		error("Unable to get service classes from record");
+		goto failed_not_supported;
+	}
+
+	memcpy(&uuid, classes->data, sizeof(uuid));
+
+	if (!sdp_uuid128_to_uuid(&uuid) || uuid.type != SDP_UUID16) {
+		error("Not a 16 bit UUID");
+		goto failed_not_supported;
+	}
+
+	if (gw->search_hfp) {
+		if (uuid.value.uuid16 != HANDSFREE_AGW_SVCLASS_ID) {
+			error("Service record didn't contain the HFP AGW UUID");
+			goto failed_not_supported;
+		}
+		gw->hfp_handle = record->handle;
+	} else {
+		if (uuid.value.uuid16 != HEADSET_AGW_SVCLASS_ID) {
+			error("Service record didn't contain the HSP AGW UUID");
+			goto failed_not_supported;
+		}
+		gw->hsp_handle = record->handle;
+	}
+
+	if (!sdp_get_access_protos(record, &protos)) {
+		ch = sdp_get_proto_port(protos, RFCOMM_UUID);
+		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
+					NULL);
+		sdp_list_free(protos, NULL);
+		protos = NULL;
+	}
+
+	if (ch == -1) {
+		error("Unable to extract RFCOMM channel from service record");
+		goto failed_not_supported;
+	}
+
+	gw->rfcomm_ch = ch;
+
+	err = rfcomm_connect(dev, NULL, NULL, NULL);
+	if (err < 0) {
+		error("Unable to connect: %s (%s)", strerror(-err), -err);
+		p->err = -err;
+		error_connection_attempt_failed(dev->conn, p->msg, p->err);
+		goto failed;
+	}
+
+	sdp_list_free(classes, free);
+	sdp_record_free(record);
+
+	return;
+
+failed_not_supported:
+	if (p->msg) {
+		error_not_supported(dev->conn, p->msg);
+		dbus_message_unref(p->msg);
+		p->msg = NULL;
+	}
+failed:
+	if (classes)
+		sdp_list_free(classes, free);
+	if (record)
+		sdp_record_free(record);
+	pending_connect_finalize(dev);
+	gateway_set_state(dev, GATEWAY_STATE_DISCONNECTED);
+}
+
+static int get_records(struct audio_device *device, gateway_stream_cb_t cb,
+			void *user_data, unsigned int *cb_id)
+{
+	info("gateway.c: get_records");
+
+	struct gateway *gw = device->gateway;
+	uuid_t uuid;
+
+	sdp_uuid16_create(&uuid, gw->search_hfp ? HANDSFREE_AGW_SVCLASS_ID :
+				HEADSET_AGW_SVCLASS_ID);
+
+	gateway_set_state(device, GATEWAY_STATE_CONNECT_IN_PROGRESS);
+
+	pending_connect_init(gw, GATEWAY_STATE_CONNECTED);
+
+	if (cb) {
+		unsigned int id;
+		id = connect_cb_new(gw, GATEWAY_STATE_CONNECTED,
+					cb, user_data);
+		if (cb_id)
+			*cb_id = id;
+	}
+
+	return bt_search_service(&device->src, &device->dst, &uuid,
+			get_record_cb, device, NULL);
+}
+
+static int rfcomm_connect(struct audio_device *dev, gateway_stream_cb_t cb,
+				void *user_data, unsigned int *cb_id)
+{
+	info("gateway.c: rfcomm_connect");
+
+	struct gateway *gw = dev->gateway;
+	char address[18];
+	int err;
+
+	if (gw->rfcomm_ch < 0)
+		return get_records(dev, cb, user_data, cb_id);
+
+	ba2str(&dev->dst, address);
+
+	info("%s: Connecting to %s channel %d", dev->path, address,
+		gw->rfcomm_ch);
+
+	err = bt_rfcomm_connect(&dev->src, &dev->dst, gw->rfcomm_ch,
+			rfcomm_connect_cb, dev);
+	if (err < 0) {
+		error("connect() failed: %s (%d)", strerror(-err), -err);
+		return err;
+	}
+
+	gateway_set_state(dev, GATEWAY_STATE_CONNECT_IN_PROGRESS);
+
+	pending_connect_init(gw, GATEWAY_STATE_CONNECTED);
+
+	if (cb) {
+		unsigned int id = connect_cb_new(gw, GATEWAY_STATE_CONNECTED,
+							cb, user_data);
+		if (cb_id)
+			*cb_id = id;
+	}
+
+	return 0;
+}
+
+int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
+{
+	info("gateway.c: gateway_connect_rfcomm");
+
+	struct gateway *gw = dev->gateway;
+
+	gw->tmp_rfcomm = io;
+
+	return gw->tmp_rfcomm ? 0 : -EINVAL;
+}
+
+int gateway_close_rfcomm(struct audio_device *dev)
+{
+	info("gateway.c: gateway_close_rfcomm");
+
+	struct gateway *gw = dev->gateway;
+	GIOChannel *rfcomm = gw->tmp_rfcomm ? gw->tmp_rfcomm : gw->rfcomm;
+
+	if (gw->ring_timer) {
+		g_source_remove(gw->ring_timer);
+		gw->ring_timer = 0;
+	}
+
+	if (rfcomm) {
+		g_io_channel_close(rfcomm);
+		g_io_channel_unref(rfcomm);
+		gw->tmp_rfcomm = NULL;
+		gw->rfcomm = NULL;
+	}
+
+	gw->data_start = 0;
+	gw->data_length = 0;
+
+	return 0;
+}
diff -Naur bluez-utils-3.36/audio/gateway.h bluez-utils-3.36-new/audio/gateway.h
--- bluez-utils-3.36/audio/gateway.h	2008-05-05 22:56:00.000000000 +0200
+++ bluez-utils-3.36-new/audio/gateway.h	2008-09-16 11:57:35.000000000 +0200
@@ -27,8 +27,30 @@
 #define DEFAULT_HSP_HS_CHANNEL 6
 #define DEFAULT_HFP_HS_CHANNEL 7
 
-int gateway_init(DBusConnection *conn, gboolean disable_hfp, gboolean sco_hci);
+typedef enum {
+	GATEWAY_STATE_DISCONNECTED,
+	GATEWAY_STATE_CONNECT_IN_PROGRESS,
+	GATEWAY_STATE_CONNECTED/* , */
+/* 	GATEWAY_STATE_PLAY_IN_PROGRESS, */
+/* 	GATEWAY_STATE_PLAYING */
+} gateway_state_t;
 
-void gateway_exit(void);
+typedef enum {
+	GATEWAY_LOCK_READ = 1,
+	GATEWAY_LOCK_WRITE = 1 << 1,
+} gateway_lock_t;
 
-gboolean gateway_is_enabled(uint16_t svc);
+typedef void (*gateway_stream_cb_t) (struct audio_device *dev, void *user_data);
+
+struct gateway *gateway_init(struct audio_device *dev, sdp_record_t *record,
+				uint16_t svc);
+
+void gateway_update(struct audio_device *dev, sdp_record_t *record, uint16_t svc);
+
+gboolean gateway_is_active(struct audio_device *dev);
+
+int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
+int gateway_close_rfcomm(struct audio_device *dev);
+
+gateway_state_t gateway_get_state(struct audio_device *dev);
+void gateway_set_state(struct audio_device *dev, gateway_state_t state);
diff -Naur bluez-utils-3.36/audio/manager.c bluez-utils-3.36-new/audio/manager.c
--- bluez-utils-3.36/audio/manager.c	2008-06-18 18:24:51.000000000 +0200
+++ bluez-utils-3.36-new/audio/manager.c	2008-09-18 17:18:01.000000000 +0200
@@ -98,6 +98,7 @@
 static DBusConnection *connection = NULL;
 
 static struct audio_device *default_hs = NULL;
+static struct audio_device *default_gw = NULL;
 static struct audio_device *default_dev = NULL;
 
 static GSList *devices = NULL;
@@ -113,8 +114,10 @@
 static GIOChannel *hsp_hs_server = NULL;
 
 static struct enabled_interfaces enabled = {
-	.headset	= TRUE,
-	.gateway	= FALSE,
+	//.headset	= TRUE,
+	//.gateway	= FALSE,
+	.headset	= FALSE,
+	.gateway	= TRUE,
 	.sink		= TRUE,
 	.source		= FALSE,
 	.control	= TRUE,
@@ -124,6 +127,8 @@
 
 static struct audio_device *create_device(const bdaddr_t *bda)
 {
+	info("create_device called");
+
 	static int device_id = 0;
 	char path[128];
 
@@ -135,21 +140,30 @@
 
 static void destroy_device(struct audio_device *device)
 {
+	info("destroy_device called");
+
 	g_dbus_unregister_all_interfaces(connection, device->path);
 }
 
 static void remove_device(struct audio_device *device)
 {
+	info("remove_device called");
+
 	if (device == default_dev) {
-		debug("Removing default device");
+		info("Removing default device");
 		default_dev = NULL;
 	}
 
 	if (device == default_hs) {
-		debug("Removing default headset");
+		info("Removing default headset");
 		default_hs = NULL;
 	}
 
+	if (device == default_gw) {
+		info("Removing default gateway");
+		default_gw = NULL;
+	}
+
 	devices = g_slist_remove(devices, device);
 
 	destroy_device(device);
@@ -157,6 +171,8 @@
 
 static gboolean add_device(struct audio_device *device, gboolean send_signals)
 {
+	info("add_device called");
+
 	if (!send_signals)
 		goto add;
 
@@ -173,16 +189,27 @@
 				"HeadsetCreated",
 				DBUS_TYPE_STRING, &device->path,
 				DBUS_TYPE_INVALID);
+
+	if (device->gateway)
+		g_dbus_emit_signal(connection,
+				AUDIO_MANAGER_PATH,
+				AUDIO_MANAGER_INTERFACE,
+				"GatewayCreated",
+				DBUS_TYPE_STRING, &device->path,
+				DBUS_TYPE_INVALID);
 add:
 
 	if (default_dev == NULL && g_slist_length(devices) == 0) {
-		debug("Selecting default device");
+		info("Selecting default device");
 		default_dev = device;
 	}
 
 	if (!default_hs && device->headset && !devices)
 		default_hs = device;
 
+	if (!default_gw && device->gateway && !devices)
+		default_gw = device;
+
 	devices = g_slist_append(devices, device);
 
 	return TRUE;
@@ -190,6 +217,8 @@
 
 static uint16_t get_service_uuid(const sdp_record_t *record)
 {
+	info("get_service_uuid called");
+
 	sdp_list_t *classes;
 	uuid_t uuid;
 	uint16_t uuid16 = 0;
@@ -224,6 +253,8 @@
 
 gboolean server_is_enabled(uint16_t svc)
 {
+	info("server_is_enabled called");
+
 	gboolean ret;
 
 	switch (svc) {
@@ -254,17 +285,51 @@
 
 static void handle_record(sdp_record_t *record, struct audio_device *device)
 {
+	info("handle_record called");
+
 	gboolean is_default;
 	uint16_t uuid16;
 
 	uuid16 = get_service_uuid(record);
 
 	if (!server_is_enabled(uuid16))
+	{
+		info("  server is not enabled: returning (but telling you something about it!");
+	switch (uuid16) {
+	case HEADSET_SVCLASS_ID:
+		info("  Found Headset record");
+		break;
+	case HEADSET_AGW_SVCLASS_ID:
+		info("  Found Headset AG record");
+		break;
+	case HANDSFREE_SVCLASS_ID:
+		info("  Found Hansfree record");
+		break;
+	case HANDSFREE_AGW_SVCLASS_ID:
+		info("  Found Handsfree AG record");
+		break;
+	case AUDIO_SINK_SVCLASS_ID:
+		info("  Found Audio Sink");
+		break;
+	case AUDIO_SOURCE_SVCLASS_ID:
+		info("  Found Audio Source");
+		break;
+	case AV_REMOTE_SVCLASS_ID:
+		info("  Found AV Remote");
+		break;
+	case AV_REMOTE_TARGET_SVCLASS_ID:
+		info("  Found AV Target");
+		break;
+	default:
+		info("  Unrecognized UUID: 0x%04X", uuid16);
+		break;
+	}
 		return;
+	}
 
 	switch (uuid16) {
 	case HEADSET_SVCLASS_ID:
-		debug("Found Headset record");
+		info("Found Headset record");
 		if (device->headset)
 			headset_update(device, record, uuid16);
 		else
@@ -272,10 +337,15 @@
 							record, uuid16);
 		break;
 	case HEADSET_AGW_SVCLASS_ID:
-		debug("Found Headset AG record");
+		info("Found Headset AG record");
+		if (device->gateway)
+			gateway_update(device, record, uuid16);
+		else
+			device->gateway = gateway_init(device,
+							record, uuid16);
 		break;
 	case HANDSFREE_SVCLASS_ID:
-		debug("Found Hansfree record");
+		info("Found Hansfree record");
 		if (device->headset)
 			headset_update(device, record, uuid16);
 		else
@@ -283,32 +353,37 @@
 							record, uuid16);
 		break;
 	case HANDSFREE_AGW_SVCLASS_ID:
-		debug("Found Handsfree AG record");
+		info("Found Handsfree AG record");
+		if (device->gateway)
+			gateway_update(device, record, uuid16);
+		else
+			device->gateway = gateway_init(device,
+							record, uuid16);
 		break;
 	case AUDIO_SINK_SVCLASS_ID:
-		debug("Found Audio Sink");
+		info("Found Audio Sink");
 		if (device->sink == NULL)
 			device->sink = sink_init(device);
 		break;
 	case AUDIO_SOURCE_SVCLASS_ID:
-		debug("Found Audio Source");
+		info("Found Audio Source");
 		break;
 	case AV_REMOTE_SVCLASS_ID:
-		debug("Found AV Remote");
+		info("Found AV Remote");
 		if (device->control == NULL)
 			device->control = control_init(device);
 		if (device->sink && sink_is_active(device))
 			avrcp_connect(device);
 		break;
 	case AV_REMOTE_TARGET_SVCLASS_ID:
-		debug("Found AV Target");
+		info("Found AV Target");
 		if (device->control == NULL)
 			device->control = control_init(device);
 		if (device->sink && sink_is_active(device))
 			avrcp_connect(device);
 		break;
 	default:
-		debug("Unrecognized UUID: 0x%04X", uuid16);
+		info("Unrecognized UUID: 0x%04X", uuid16);
 		break;
 	}
 
@@ -319,11 +394,13 @@
 
 static void finish_sdp(struct audio_sdp_data *data, gboolean success)
 {
+	info("finish_sdp called");
+
 	const char *addr;
 	DBusMessage *reply = NULL;
 	DBusError derr;
 
-	debug("Audio service discovery completed with %s",
+	info("Audio service discovery completed with %s",
 			success ? "success" : "failure");
 
 	if (!success)
@@ -347,7 +424,7 @@
 
 	/* Return error if no audio related service records were found */
 	if (!data->records) {
-		debug("No audio audio related service records were found");
+		info("No audio audio related service records were found");
 		success = FALSE;
 		error_not_supported(connection, data->msg);
 		goto done;
@@ -393,6 +470,8 @@
 
 static void get_records_cb(sdp_list_t *recs, int err, gpointer user_data)
 {
+	info("get_records_cb called");
+
 	struct audio_sdp_data *data = user_data;
 	sdp_list_t *seq;
 	uuid_t uuid;
@@ -403,9 +482,12 @@
 		return;
 	}
 
+	int i=0;
 	for (seq = recs; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
 
+		info ("  pass %d of loop", i++);
+
 		if (!rec)
 			break;
 
@@ -414,25 +496,32 @@
 
 	sdp_list_free(recs, NULL);
 
+	info ("  data state is %d, was %d", data->state+1, data->state);
 	data->state++;
 
 	switch (data->state) {
 	case ADVANCED_AUDIO:
+		info("  data state is ADVANCED_AUDIO");
 		sdp_uuid16_create(&uuid, ADVANCED_AUDIO_SVCLASS_ID);
 		break;
 	case AV_REMOTE:
+		info("  data state is AV_REMOTE");
 		sdp_uuid16_create(&uuid, AV_REMOTE_SVCLASS_ID);
 		break;
 	default:
+		info("  data state falled back to default of finish sdp!");
 		finish_sdp(data, TRUE);
 		return;
 	}
 
+	info ("  calling get_records");
 	get_records(&uuid, data);
 }
 
 static DBusMessage *get_records(uuid_t *uuid, struct audio_sdp_data *data)
 {
+	info("get_records called");
+
 	struct audio_device *device = data->device;
 	DBusMessage *reply = NULL;
 	int err;
@@ -457,6 +546,8 @@
 					create_dev_cb_t cb,
 					void *user_data)
 {
+	info("resolve_services called");
+
 	struct audio_sdp_data *sdp_data;
 	uuid_t uuid;
 
@@ -469,14 +560,17 @@
 
 	sdp_uuid16_create(&uuid, GENERIC_AUDIO_SVCLASS_ID);
 
+	info ("  calling get_records");
 	return get_records(&uuid, sdp_data);
 }
 
 struct audio_device *manager_device_connected(const bdaddr_t *bda, const char *uuid)
 {
+	info("manager_device_connected called");
+
 	struct audio_device *device;
 	const char *path;
-	gboolean headset = FALSE, created = FALSE;
+	gboolean headset = FALSE, gateway = FALSE, created = FALSE;
 
 	device = manager_find_device(bda, NULL, FALSE);
 	if (!device) {
@@ -500,6 +594,16 @@
 			return NULL;
 
 		headset = TRUE;
+	} else if (!strcmp(uuid, HSP_HS_UUID) || !strcmp(uuid, HFP_HS_UUID)) {
+		if (device->gateway)
+			return device;
+
+		device->gateway = gateway_init(device, NULL, 0);
+
+		if (!device->gateway)
+			return NULL;
+
+		gateway = TRUE;
 	} else if (!strcmp(uuid, A2DP_SOURCE_UUID)) {
 		if (device->sink)
 			return device;
@@ -546,6 +650,22 @@
 						DBUS_TYPE_INVALID);
 	}
 
+	if (gateway)
+		g_dbus_emit_signal(connection, AUDIO_MANAGER_PATH,
+						AUDIO_MANAGER_INTERFACE,
+						"GatewayCreated",
+						DBUS_TYPE_STRING, &path,
+						DBUS_TYPE_INVALID);
+
+	if (gateway && !default_gw) {
+		default_gw = device;
+		g_dbus_emit_signal(connection, AUDIO_MANAGER_PATH,
+						AUDIO_MANAGER_INTERFACE,
+						"DefaultGatewayChanged",
+						DBUS_TYPE_STRING, &path,
+						DBUS_TYPE_INVALID);
+	}
+
 	if (!default_dev) {
 		default_dev = device;
 		g_dbus_emit_signal(connection, AUDIO_MANAGER_PATH,
@@ -561,6 +681,8 @@
 gboolean manager_create_device(bdaddr_t *bda, create_dev_cb_t cb,
 				void *user_data)
 {
+	info("manager_create_device called");
+
 	struct audio_device *dev;
 
 	dev = create_device(bda);
@@ -581,18 +703,28 @@
 	struct audio_device *device;
 	DBusMessage *reply;
 
+	info("am_create_device called");
+
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &address,
 				DBUS_TYPE_INVALID))
 		return NULL;
 
+	info("  device address is %s", address);
+
 	str2ba(address, &bda);
 
 	device = manager_find_device(&bda, NULL, FALSE);
 	if (!device) {
+		info ("  device not found");
 		device = create_device(&bda);
 		return resolve_services(msg, device, NULL, NULL);
 	}
+	else
+	{
+		info ("  device found");
+		return resolve_services(msg, device, NULL, NULL);
+	}
 
 	path = device->path;
 
@@ -610,19 +742,24 @@
 						DBusMessage *msg,
 						void *data)
 {
+	info("am_list_devices called");
+
 	DBusMessageIter iter, array_iter;
 	DBusMessage *reply;
 	DBusError derr;
 	GSList *l;
 	gboolean hs_only = FALSE;
+	gboolean hs_ag_only = FALSE;
 
 	dbus_error_init(&derr);
 
 	if (dbus_message_is_method_call(msg, AUDIO_MANAGER_INTERFACE,
 					"ListHeadsets"))
 		hs_only = TRUE;
-	else
-		hs_only = FALSE;
+
+	if (dbus_message_is_method_call(msg, AUDIO_MANAGER_INTERFACE,
+					"ListGateways"))
+		hs_ag_only = TRUE;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -639,6 +776,9 @@
 		if (hs_only && !device->headset)
 			continue;
 
+		if (hs_ag_only && !device->gateway)
+			continue;
+
 		dbus_message_iter_append_basic(&array_iter,
 						DBUS_TYPE_STRING, &device->path);
 	}
@@ -650,6 +790,8 @@
 
 static gint device_path_cmp(gconstpointer a, gconstpointer b)
 {
+	info("device_path_cmp called");
+
 	const struct audio_device *device = a;
 	const char *path = b;
 
@@ -660,6 +802,8 @@
 					DBusMessage *msg,
 					void *data)
 {
+	info("am_remove_device called");
+
 	DBusMessage *reply;
 	GSList *match;
 	const char *path;
@@ -705,6 +849,12 @@
 
 		g_dbus_emit_signal(conn, AUDIO_MANAGER_PATH,
 						AUDIO_MANAGER_INTERFACE,
+						"DefaultGatewayChanged",
+						DBUS_TYPE_STRING, &param,
+						DBUS_TYPE_INVALID);
+
+		g_dbus_emit_signal(conn, AUDIO_MANAGER_PATH,
+						AUDIO_MANAGER_INTERFACE,
 						"DefaultDeviceChanged",
 						DBUS_TYPE_STRING, &param,
 						DBUS_TYPE_INVALID);
@@ -721,6 +871,12 @@
 
 	g_dbus_emit_signal(conn, AUDIO_MANAGER_PATH,
 					AUDIO_MANAGER_INTERFACE,
+					"GatewayRemoved",
+					DBUS_TYPE_STRING, &path,
+					DBUS_TYPE_INVALID);
+
+	g_dbus_emit_signal(conn, AUDIO_MANAGER_PATH,
+					AUDIO_MANAGER_INTERFACE,
 					"DeviceRemoved",
 					DBUS_TYPE_STRING, &path,
 					DBUS_TYPE_INVALID);
@@ -732,6 +888,8 @@
 					DBusMessage *msg,
 					void *data)
 {
+	info("am_find_by_addr called");
+
 	const char *address;
 	DBusMessage *reply;
 	struct audio_device *device;
@@ -763,6 +921,8 @@
 					DBusMessage *msg,
 					void *data)
 {
+	info("am_default_device called");
+
 	DBusMessage *reply;
 
 	if (!default_dev)
@@ -775,6 +935,12 @@
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExists",
 						"Device does not exists");
 
+	if (default_dev->gateway == NULL &&
+		dbus_message_is_method_call(msg, AUDIO_MANAGER_INTERFACE,
+							"DefaultGateway"))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExists",
+						"Device does not exists");
+
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
@@ -789,6 +955,8 @@
 						DBusMessage *msg,
 						void *data)
 {
+	info("am_change_default_device called");
+
 	DBusMessage *reply;
 	GSList *match;
 	const char *path;
@@ -811,7 +979,8 @@
 	device = match->data;
 
 	if (!dbus_message_is_method_call(msg, AUDIO_MANAGER_INTERFACE,
-		"ChangeDefaultHeadset"))
+		"ChangeDefaultHeadset") && !dbus_message_is_method_call(msg, AUDIO_MANAGER_INTERFACE,
+		"ChangeDefaultGateway"))
 		g_dbus_emit_signal(conn, AUDIO_MANAGER_PATH,
 						AUDIO_MANAGER_INTERFACE,
 						"DefaultDeviceChanged",
@@ -823,6 +992,12 @@
 						"DefaultHeadsetChanged",
 						DBUS_TYPE_STRING, &device->path,
 						DBUS_TYPE_INVALID);
+	else if (device->gateway)
+		g_dbus_emit_signal(conn, AUDIO_MANAGER_PATH,
+						AUDIO_MANAGER_INTERFACE,
+						"DefaultGatewayChanged",
+						DBUS_TYPE_STRING, &device->path,
+						DBUS_TYPE_INVALID);
 	else
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".DoesNotExists",
 						"Device does not exists");
@@ -847,6 +1022,12 @@
 	{ "FindDeviceByAddress",	"s",	"s",	am_find_by_addr },
 	{ "DefaultHeadset",		"",	"s",	am_default_device },
 	{ "ChangeDefaultHeadset",	"s",	"",	am_change_default_device },
+	{ "CreateGateway",		"s",	"s",	am_create_device,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RemoveGateway",		"s",	"",	am_remove_device },
+	{ "ListGateways",		"",	"as",	am_list_devices },
+	{ "DefaultGateway",		"",	"s",	am_default_device },
+	{ "ChangeDefaultGateway",	"s",	"",	am_change_default_device },
 	{ }
 };
 
@@ -857,11 +1038,16 @@
 	{ "HeadsetRemoved",		"s"	},
 	{ "DefaultDeviceChanged",	"s"	},
 	{ "DefaultHeadsetChanged",	"s"	},
+	{ "GatewayCreated",		"s"	},
+	{ "GatewayRemoved",		"s"	},
+	{ "DefaultGatewayChanged",	"s"	},
 	{ }
 };
 
 static void parse_stored_devices(char *key, char *value, void *data)
 {
+	info("parse_stored_devices called");
+
 	bdaddr_t *src = data;
 	struct audio_device *device;
 	bdaddr_t dst;
@@ -886,6 +1072,8 @@
 
 	if (enabled.headset && strstr(value, "headset"))
 		device->headset = headset_init(device, NULL, 0);
+	if (enabled.gateway && strstr(value, "gateway"))
+		device->gateway = gateway_init(device, NULL, 0);
 	if (enabled.sink && strstr(value, "sink"))
 		device->sink = sink_init(device);
 	if (enabled.control && strstr(value, "control"))
@@ -895,6 +1083,8 @@
 
 static void register_devices_stored(const char *adapter)
 {
+	info("register_devices_stored called");
+
 	char filename[PATH_MAX + 1];
 	struct stat st;
 	struct audio_device *device;
@@ -941,6 +1131,8 @@
 
 static void register_stored(void)
 {
+	info("register_stored called");
+
 	char dirname[PATH_MAX + 1];
 	struct dirent *de;
 	DIR *dir;
@@ -964,6 +1156,8 @@
 
 static void manager_unregister(void *data)
 {
+	info("manager_unregister called");
+
 	info("Unregistered manager path");
 
 	if (devices) {
@@ -975,6 +1169,8 @@
 
 static sdp_record_t *hsp_ag_record(uint8_t ch)
 {
+	info("hsp_ag_record called");
+
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
 	uuid_t l2cap_uuid, rfcomm_uuid;
@@ -1031,6 +1227,8 @@
 
 static sdp_record_t *hsp_hs_record(uint8_t ch)
 {
+	info("hsp_hs_record called");
+
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
 	uuid_t l2cap_uuid, rfcomm_uuid;
@@ -1087,6 +1285,8 @@
 
 static sdp_record_t *hfp_ag_record(uint8_t ch, uint32_t feat)
 {
+	info("hfp_ag_record called");
+
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
 	uuid_t root_uuid, svclass_uuid, ga_svclass_uuid;
 	uuid_t l2cap_uuid, rfcomm_uuid;
@@ -1152,6 +1352,8 @@
 
 static void auth_cb(DBusError *derr, void *user_data)
 {
+	info("auth_cb called");
+
 	struct audio_device *device = user_data;
 	const char *uuid;
 
@@ -1163,7 +1365,7 @@
 	if (derr && dbus_error_is_set(derr)) {
 		error("Access denied: %s", derr->message);
 		if (dbus_error_has_name(derr, DBUS_ERROR_NO_REPLY)) {
-			debug("Canceling authorization request");
+			info("Canceling authorization request");
 			service_cancel_auth(&device->src, &device->dst);
 		}
 
@@ -1175,7 +1377,7 @@
 
 		ba2str(&device->dst, hs_address);
 
-		debug("Accepted headset connection from %s for %s",
+		info("Accepted headset connection from %s for %s",
 						hs_address, device->path);
 		headset_set_state(device, HEADSET_STATE_CONNECTED);
 	}
@@ -1184,6 +1386,8 @@
 static void ag_io_cb(GIOChannel *chan, int err, const bdaddr_t *src,
 			const bdaddr_t *dst, gpointer data)
 {
+	info("ag_io_cb called");
+
 	const char *uuid;
 	struct audio_device *device;
 	gboolean hfp_active;
@@ -1206,7 +1410,7 @@
 		goto drop;
 
 	if (headset_get_state(device) > HEADSET_STATE_DISCONNECTED) {
-		debug("Refusing new connection since one already exists");
+		info("Refusing new connection since one already exists");
 		goto drop;
 	}
 
@@ -1220,7 +1424,7 @@
 	err = service_req_auth(&device->src, &device->dst, uuid, auth_cb,
 				device);
 	if (err < 0) {
-		debug("Authorization denied: %s", strerror(-err));
+		info("Authorization denied: %s", strerror(-err));
 		headset_close_rfcomm(device);
 		return;
 	}
@@ -1238,12 +1442,16 @@
 static void hs_io_cb(GIOChannel *chan, int err, const bdaddr_t *src,
 		const bdaddr_t *dst, void *data)
 {
+	info("hs_io_cb called");
+
 	/*Stub*/
 	return;
 }
 
 static int headset_server_init(DBusConnection *conn, GKeyFile *config)
 {
+	info("headset_server_init called");
+
 	uint8_t chan = DEFAULT_HS_AG_CHANNEL;
 	sdp_record_t *record;
 	gboolean hfp = TRUE, master = TRUE;
@@ -1259,7 +1467,7 @@
 		tmp = g_key_file_get_boolean(config, "General", "Master",
 						&err);
 		if (err) {
-			debug("audio.conf: %s", err->message);
+			info("audio.conf: %s", err->message);
 			g_error_free(err);
 			err = NULL;
 		} else
@@ -1268,7 +1476,7 @@
 		tmp = g_key_file_get_boolean(config, "Headset", "HFP",
 						&err);
 		if (err) {
-			debug("audio.conf: %s", err->message);
+			info("audio.conf: %s", err->message);
 			g_error_free(err);
 			err = NULL;
 		} else
@@ -1332,6 +1540,8 @@
 
 static int gateway_server_init(DBusConnection *conn, GKeyFile *config)
 {
+	info("gateway_server called");
+
 	uint8_t chan = DEFAULT_HSP_HS_CHANNEL;
 	sdp_record_t *record;
 	gboolean master = TRUE;
@@ -1347,7 +1557,7 @@
 		tmp = g_key_file_get_boolean(config, "General", "Master",
 						&err);
 		if (err) {
-			debug("audio.conf: %s", err->message);
+			info("audio.conf: %s", err->message);
 			g_error_free(err);
 			err = NULL;
 		} else
@@ -1385,6 +1595,8 @@
 
 static void server_exit(void)
 {
+	info("server_exit called");
+
 	if (hsp_ag_record_id) {
 		remove_record_from_server(hsp_ag_record_id);
 		hsp_ag_record_id = 0;
@@ -1418,9 +1630,13 @@
 
 int audio_manager_init(DBusConnection *conn, GKeyFile *config)
 {
+	info("audio_manager_init called");
+
 	char **list;
 	int i;
 
+	info ("AUDIO_MANAGER_INIT");
+
 	connection = dbus_connection_ref(conn);
 
 	if (!config)
@@ -1498,6 +1714,8 @@
 
 void audio_manager_exit(void)
 {
+	info("audio_manager_exit called");
+
 	server_exit();
 
 	g_dbus_unregister_interface(connection, AUDIO_MANAGER_PATH,
@@ -1510,11 +1728,15 @@
 
 struct audio_device *manager_default_device(void)
 {
+	info("manager_default_device called");
+
 	return default_dev;
 }
 
 struct audio_device *manager_get_connected_device(void)
 {
+	info("manager_get_connected_device called");
+
 	GSList *l;
 
 	for (l = devices; l != NULL; l = g_slist_next(l)) {
@@ -1526,6 +1748,9 @@
 
 		if (device->headset && headset_is_active(device))
 			return device;
+
+		if (device->gateway && gateway_is_active(device))
+			return device;
 	}
 
 	return NULL;
@@ -1534,6 +1759,8 @@
 struct audio_device *manager_find_device(const bdaddr_t *bda, const char *interface,
 					gboolean connected)
 {
+	info("manager_find_device called");
+
 	GSList *l;
 
 	if (!bacmp(bda, BDADDR_ANY) && !interface && !connected)
@@ -1549,6 +1776,10 @@
 				&& !dev->headset)
 			continue;
 
+		if (interface && !strcmp(AUDIO_GATEWAY_INTERFACE, interface)
+				&& !dev->gateway)
+			continue;
+
 		if (interface && !strcmp(AUDIO_SINK_INTERFACE, interface)
 				&& !dev->sink)
 			continue;

--Apple-Mail-3-989292480
Content-Disposition: attachment;
	filename=README
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="README"
Content-Transfer-Encoding: 7bit

Work in progress in adding audio gateway support to bluez.
Currently it enables bluez to be seen as audio device by
phone, and audio events are sent to (and received by) bluez.
No audio yet, and phone reports a couple errors to bluez,
probably due to the fact that it is requesting bluez to open
2 SCO channels and that isn't handled yet.

--Apple-Mail-3-989292480--

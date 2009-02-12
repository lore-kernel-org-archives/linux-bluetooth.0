Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 12 Feb 2009 15:17:13 +0800
Message-ID: <ac8af0be0902112317s6556afc0kfaf64fe87542fa45@mail.gmail.com>
Subject: [PATCH 4/4] IPC integration part for HFP Audio gateway
From: Zhao Forrest <forrest.zhao@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: event <event.riga@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/audio/gateway.c b/audio/gateway.c
index 8d9d265..4b86c4e 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -1076,3 +1076,72 @@ int gateway_close(struct gateway *gw)
 	}
 	return 0;
 }
+
+/* These are functions to be called from unix.c for audio system
+ * ifaces (alsa, gstreamer, etc.) */
+gboolean gateway_request_stream(struct audio_device *dev,
+				gateway_stream_cb_t cb, void *user_data)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (!gw->sco) {
+		if (!gw->rfcomm)
+			return FALSE;
+		gw->sco_start_cb = cb;
+		gw->sco_start_cb_data = user_data;
+		bt_sco_connect(&dev->src, &dev->dst, sco_connect_cb, dev);
+	} else {
+		if (cb)
+			cb(dev, user_data);
+	}
+	return TRUE;
+}
+
+int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t sco_cb,
+				void *user_data)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (!gw->rfcomm) {
+		gw->sco_start_cb = sco_cb;
+		gw->sco_start_cb_data = user_data;
+		return get_records(dev);
+	}
+
+	if (sco_cb)
+		sco_cb(dev, user_data);
+
+	return 0;
+}
+
+gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
+{
+	struct gateway *gw = dev->gateway;
+
+	gateway_close(gw);
+	return TRUE;
+}
+
+int gateway_get_sco_fd(struct audio_device *dev)
+{
+	GIOChannel* sco_chan = dev->gateway->sco;
+
+	if (!sco_chan)
+		return -1;
+
+	return g_io_channel_unix_get_fd(sco_chan);
+}
+
+void gateway_suspend_stream(struct audio_device *dev)
+{
+	struct gateway* gw = dev->gateway;
+
+	if (gw->sco) {
+		g_io_channel_close(gw->sco);
+		g_io_channel_unref(gw->sco);
+		gw->sco = NULL;
+		gw->sco_start_cb = NULL;
+		gw->sco_start_cb_data = NULL;
+	}
+}
+
diff --git a/audio/gateway.h b/audio/gateway.h
index 225d3e2..f217544 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -31,4 +31,11 @@ typedef void (*gateway_stream_cb_t) (struct
audio_device *dev, void *user_data);
 struct gateway *gateway_init(struct audio_device *device);
 gboolean gateway_is_connected(struct audio_device* dev);
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *chan);
+gboolean gateway_request_stream(struct audio_device *dev,
+			gateway_stream_cb_t cb, void *user_data);
+int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
+			void *user_data);
+gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id);
+int gateway_get_sco_fd(struct audio_device *dev);
+void gateway_suspend_stream(struct audio_device *dev);

diff --git a/audio/ipc.h b/audio/ipc.h
index 9a2d93a..d0c20ba 100644
--- a/audio/ipc.h
+++ b/audio/ipc.h
@@ -108,7 +108,13 @@ typedef struct {
 #define BT_CAPABILITIES_ACCESS_MODE_WRITE	2
 #define BT_CAPABILITIES_ACCESS_MODE_READWRITE	3

+#define BT_CAPABILITIES_ROLE_SLAVE 0
+#define BT_CAPABILITIES_ROLE_MASTER 1
+
 #define BT_FLAG_AUTOCONNECT	1
+/* choose between gateway/source (set bit) and
+ * headset/sink (clear bit aka default) */
+#define BT_FLAG_MASTER 0x2

 struct bt_get_capabilities_req {
 	bt_audio_msg_header_t	h;
@@ -163,8 +169,8 @@ struct bt_get_capabilities_req {
 #define BT_PCM_FLAG_NREC			1

 typedef struct {
-	uint8_t transport;
-	uint8_t type;
+	uint8_t transport; /* sco | a2dp */
+	uint8_t type; /* sbc | mpeg12 | mpeg24 | atrac */
 	uint8_t length;
 	uint8_t data[0];
 } __attribute__ ((packed)) codec_capabilities_t;
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index 9bef89e..9c9e546 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -109,8 +109,10 @@ struct bluetooth_a2dp {
 struct bluetooth_alsa_config {
 	char device[18];		/* Address of the remote Device */
 	int has_device;
-	uint8_t transport;		/* Requested transport */
+	uint8_t transport;		/* SCO or A2DP */
 	int has_transport;
+	uint8_t role;		        /* Master (gateway|a2dp source) or Slave
(headset|a2dp sink) */
+	int has_role;
 	uint16_t rate;
 	int has_rate;
 	uint8_t channel_mode;		/* A2DP only */
@@ -1399,6 +1401,21 @@ static int bluetooth_parse_config(snd_config_t *conf,
 			}
 			continue;
 		}
+		if (strcmp(id, "role") == 0){
+			if (snd_config_get_string(n, &value) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+
+			if (strcmp(value, "master") == 0) {
+				bt_config->role = BT_CAPABILITIES_ROLE_MASTER;
+				bt_config->has_role = 1;
+			} else {
+				bt_config->role = BT_CAPABILITIES_ROLE_SLAVE;
+				bt_config->has_role = 1;
+			}
+			continue;
+		}

 		if (strcmp(id, "rate") == 0) {
 			if (snd_config_get_string(n, &value) < 0) {
@@ -1645,6 +1662,9 @@ static int bluetooth_init(struct bluetooth_data
*data, snd_pcm_stream_t stream,

 	if (alsa_conf->autoconnect)
 		req->flags |= BT_FLAG_AUTOCONNECT;
+	if (alsa_conf->has_role && alsa_conf->role == BT_CAPABILITIES_ROLE_MASTER) {
+		req->flags |= BT_FLAG_MASTER;
+	}
 	strncpy(req->device, alsa_conf->device, 18);
 	if (alsa_conf->has_transport)
 		req->transport = alsa_conf->transport;
diff --git a/audio/unix.c b/audio/unix.c
index 472347b..959c605 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -47,12 +47,14 @@
 #include "a2dp.h"
 #include "headset.h"
 #include "sink.h"
+#include "gateway.h"
 #include "unix.h"
 #include "glib-helper.h"

 typedef enum {
 	TYPE_NONE,
 	TYPE_HEADSET,
+	TYPE_GATEWAY,
 	TYPE_SINK,
 	TYPE_SOURCE
 } service_type_t;
@@ -194,6 +196,8 @@ static service_type_t select_service(struct
audio_device *dev, const char *inter
 		return TYPE_SINK;
 	else if (!strcmp(interface, AUDIO_HEADSET_INTERFACE) && dev->headset)
 		return TYPE_HEADSET;
+	else if (!strcmp(interface, AUDIO_GATEWAY_INTERFACE) && dev->gateway)
+		return TYPE_GATEWAY;

 	return TYPE_NONE;
 }
@@ -248,7 +252,7 @@ static void headset_discovery_complete(struct
audio_device *dev, void *user_data

 	pcm = (void *) codec;
 	pcm->sampling_rate = 8000;
-	if (headset_get_nrec(dev))
+	if (dev->headset && headset_get_nrec(dev))
 		pcm->flags |= BT_PCM_FLAG_NREC;

 	rsp->h.type = BT_RESPONSE;
@@ -296,6 +300,34 @@ failed:
 	unix_ipc_error(client, BT_SET_CONFIGURATION, EIO);
 }

+static void gateway_setup_complete(struct audio_device *dev, void *user_data)
+{
+	struct unix_client *client = user_data;
+	char buf[BT_SUGGESTED_BUFFER_SIZE];
+	struct bt_set_configuration_rsp *rsp = (void *) buf;
+
+	if (!dev) {
+		unix_ipc_error(client, BT_SET_CONFIGURATION, EIO);
+		return;
+	}
+
+	client->req_id = 0;
+
+	memset(buf, 0, sizeof(buf));
+
+	rsp->h.type = BT_RESPONSE;
+	rsp->h.name = BT_SET_CONFIGURATION;
+	rsp->h.length = sizeof(*rsp);
+
+	rsp->transport = BT_CAPABILITIES_TRANSPORT_SCO;
+	rsp->access_mode = client->access_mode;
+	rsp->link_mtu = 48;
+
+	client->data_fd = gateway_get_sco_fd(dev);
+
+	unix_ipc_sendmsg(client, &rsp->h);
+}
+
 static void headset_resume_complete(struct audio_device *dev, void *user_data)
 {
 	struct unix_client *client = user_data;
@@ -348,6 +380,35 @@ failed:
 	unix_ipc_error(client, BT_START_STREAM, EIO);
 }

+static void gateway_resume_complete(struct audio_device *dev, void *user_data)
+{
+	struct unix_client *client = user_data;
+	char buf[BT_SUGGESTED_BUFFER_SIZE];
+	struct bt_start_stream_rsp *rsp = (void *) buf;
+	struct bt_new_stream_ind *ind = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+	rsp->h.type = BT_RESPONSE;
+	rsp->h.name = BT_START_STREAM;
+	rsp->h.length = sizeof(*rsp);
+
+	unix_ipc_sendmsg(client, &rsp->h);
+
+	memset(buf, 0, sizeof(buf));
+	ind->h.type = BT_INDICATION;
+	ind->h.name = BT_NEW_STREAM;
+	ind->h.length = sizeof(*ind);
+
+	unix_ipc_sendmsg(client, &ind->h);
+
+	client->data_fd = gateway_get_sco_fd(dev);
+	if (unix_sendmsg_fd(client->sock, client->data_fd) < 0) {
+		error("unix_sendmsg_fd: %s(%d)", strerror(errno), errno);
+		unix_ipc_error(client, BT_START_STREAM, EIO);
+	}
+	client->req_id = 0;
+}
+
 static void headset_suspend_complete(struct audio_device *dev, void *user_data)
 {
 	struct unix_client *client = user_data;
@@ -667,6 +728,7 @@ static void start_discovery(struct audio_device
*dev, struct unix_client *client
 		break;

 	case TYPE_HEADSET:
+	case TYPE_GATEWAY:
 		headset_discovery_complete(dev, client);
 		break;

@@ -728,6 +790,13 @@ static void start_config(struct audio_device
*dev, struct unix_client *client)
 					hs->lock, client);
 		client->cancel = headset_cancel_stream;
 		break;
+	case TYPE_GATEWAY:
+		if (gateway_config_stream(dev, gateway_setup_complete, client) >= 0) {
+			client->cancel = gateway_cancel_stream;
+			id = 1;
+		} else
+			id = 0;
+		break;

 	default:
 		error("No known services for device");
@@ -785,6 +854,14 @@ static void start_resume(struct audio_device
*dev, struct unix_client *client)
 		client->cancel = headset_cancel_stream;
 		break;

+	case TYPE_GATEWAY:
+		if (gateway_request_stream(dev, gateway_resume_complete, client))
+			id = 1;
+		else
+			id = 0;
+		client->cancel = gateway_cancel_stream;
+		break;
+
 	default:
 		error("No known services for device");
 		goto failed;
@@ -837,6 +914,13 @@ static void start_suspend(struct audio_device
*dev, struct unix_client *client)
 		client->cancel = headset_cancel_stream;
 		break;

+	case TYPE_GATEWAY:
+		gateway_suspend_stream(dev);
+		client->cancel = gateway_cancel_stream;
+		headset_suspend_complete(dev, client);
+		id = 1;
+		break;
+
 	default:
 		error("No known services for device");
 		goto failed;
@@ -866,9 +950,12 @@ static void handle_getcapabilities_req(struct
unix_client *client,
 		goto failed;
 	}

-	if (req->transport == BT_CAPABILITIES_TRANSPORT_SCO)
-		client->interface = g_strdup(AUDIO_HEADSET_INTERFACE);
-	else if (req->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
+	if (req->transport == BT_CAPABILITIES_TRANSPORT_SCO) {
+		if (req->flags & BT_FLAG_MASTER)
+			client->interface = g_strdup(AUDIO_GATEWAY_INTERFACE);
+		else
+			client->interface = g_strdup(AUDIO_HEADSET_INTERFACE);
+	} else if (req->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
 		client->interface = g_strdup(AUDIO_SINK_INTERFACE);

 	if (!manager_find_device(&bdaddr, NULL, FALSE))
@@ -1005,13 +1092,7 @@ static void handle_setconfiguration_req(struct
unix_client *client,

 	str2ba(req->device, &bdaddr);

-	if (req->codec.transport == BT_CAPABILITIES_TRANSPORT_SCO) {
-		err = handle_sco_transport(client, req);
-		if (err < 0) {
-			err = -err;
-			goto failed;
-		}
-	} else if (req->codec.transport == BT_CAPABILITIES_TRANSPORT_A2DP) {
+	if (req->codec.transport == BT_CAPABILITIES_TRANSPORT_A2DP) {
 		err = handle_a2dp_transport(client, req);
 		if (err < 0) {
 			err = -err;

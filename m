Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 10/10] hsp: Implement media transport driver
Date: Fri, 12 Jul 2013 12:54:43 +0200
Message-Id: <1373626483-2031-11-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Implement the callbacks required by the Media API integration.
---
 plugins/hsp.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/plugins/hsp.c b/plugins/hsp.c
index 740b857..7fcb990 100644
--- a/plugins/hsp.c
+++ b/plugins/hsp.c
@@ -60,16 +60,22 @@
 #include "sdpd.h"
 #include "btio.h"
 #include "profiles/audio/manager.h"
+#include "profiles/audio/device.h"
 #include "profiles/audio/media.h"
+#include "profiles/audio/transport.h"
 
 #define DEFAULT_HS_AG_CHANNEL 12
 #define BUF_SIZE 1024
+#define SCO_INPUT_MTU 48
+#define SCO_OUTPUT_MTU 48
 
 typedef enum {
 	HEADSET_STATE_DISCONNECTED,
 	HEADSET_STATE_CONNECTING,
 	HEADSET_STATE_CONNECTED,
+	HEADSET_STATE_RESUMING,
 	HEADSET_STATE_PLAYING,
+	HEADSET_STATE_SUSPENDING,
 } headset_state_t;
 
 struct headset_slc {
@@ -107,6 +113,7 @@ struct headset {
 
 	struct media_endpoint *endpoint;
 	struct media_transport *transport;
+	struct media_owner *pending_media_owner; /* Ongoing suspend or resume */
 };
 
 struct event {
@@ -127,8 +134,12 @@ static const char *state2str(headset_state_t state)
 		return "HEADSET_STATE_CONNECTING";
 	case HEADSET_STATE_CONNECTED:
 		return "HEADSET_STATE_CONNECTED";
+	case HEADSET_STATE_RESUMING:
+		return "HEADSET_STATE_RESUMING";
 	case HEADSET_STATE_PLAYING:
 		return "HEADSET_STATE_PLAYING";
+	case HEADSET_STATE_SUSPENDING:
+		return "HEADSET_STATE_SUSPENDING";
 	}
 
 	return NULL;
@@ -215,6 +226,8 @@ static void headset_init_sco(struct headset *hs)
 
 	assert(hs->sco != NULL);
 
+	DBG("media_owner: %p", hs->pending_media_owner);
+
 	fd = g_io_channel_unix_get_fd(hs->sco);
 	fcntl(fd, F_SETFL, 0);
 
@@ -226,6 +239,12 @@ static void headset_init_sco(struct headset *hs)
 	headset_send(hs, "\r\n+VGS=%u\r\n", hs->slc->sp_gain);
 	headset_send(hs, "\r\n+VGM=%u\r\n", hs->slc->mic_gain);
 
+	if (hs->state == HEADSET_STATE_RESUMING) {
+		media_transport_resume_complete(hs->pending_media_owner, fd,
+						SCO_INPUT_MTU, SCO_OUTPUT_MTU);
+		hs->pending_media_owner = NULL;
+	}
+
 	headset_set_state(hs, HEADSET_STATE_PLAYING);
 }
 
@@ -276,12 +295,22 @@ static int signal_gain_setting(struct headset *hs, const char *buf)
 			return -EALREADY;
 
 		slc->sp_gain = gain;
+
+		if (hs->transport != NULL)
+			media_transport_update_speaker_gain(hs->transport,
+									gain);
+
 		break;
 	case 'M':
 		if (slc->mic_gain == gain)
 			return 0;
 
 		slc->mic_gain = gain;
+
+		if (hs->transport != NULL)
+			media_transport_update_microphone_gain(hs->transport,
+									gain);
+
 		break;
 	default:
 		error("Unknown gain setting");
@@ -660,6 +689,16 @@ static void headset_set_state(struct headset *hs, headset_state_t state)
 	if (old_state == state)
 		return;
 
+	if (old_state == HEADSET_STATE_SUSPENDING) {
+		media_transport_suspend_complete(hs->pending_media_owner);
+		hs->pending_media_owner = NULL;
+	} else if (old_state == HEADSET_STATE_RESUMING &&
+					state != HEADSET_STATE_PLAYING) {
+		media_transport_resume_complete(hs->pending_media_owner, -1, 0,
+									0);
+		hs->pending_media_owner = NULL;
+	}
+
 	switch (state) {
 	case HEADSET_STATE_DISCONNECTED:
 		headset_clearconf(hs);
@@ -689,7 +728,9 @@ static void headset_set_state(struct headset *hs, headset_state_t state)
 		server->active_headsets = g_slist_append(
 						server->active_headsets, hs);
 		break;
+	case HEADSET_STATE_RESUMING:
 	case HEADSET_STATE_PLAYING:
+	case HEADSET_STATE_SUSPENDING:
 		break;
 	}
 
@@ -913,9 +954,15 @@ static void sco_server_cb(GIOChannel *io, GError *err, gpointer user_data)
 		goto drop;
 	case HEADSET_STATE_CONNECTED:
 		break;
+	case HEADSET_STATE_RESUMING:
+		DBG("Refusing SCO due to connect:connect xcase");
+		goto drop;
 	case HEADSET_STATE_PLAYING:
 		DBG("Refusing second SCO from same headset");
 		goto drop;
+	case HEADSET_STATE_SUSPENDING:
+		DBG("Refusing SCO while suspending previous one");
+		goto drop;
 	}
 
 	DBG("Accepted headset SCO connection from %s", addr);
@@ -1084,6 +1131,207 @@ static struct btd_profile hsp_profile = {
 	.adapter_remove = hsp_hs_server_remove,
 };
 
+static struct headset *find_transport_headset(struct media_transport *transport)
+{
+	struct audio_device *audio_dev = media_transport_get_dev(transport);
+	struct btd_service *service;
+
+	service = btd_device_get_service(audio_dev->btd_dev, HSP_HS_UUID);
+	assert(service != NULL);
+
+	return btd_service_get_user_data(service);
+}
+
+static void *hsp_transport_init(struct media_transport *transport)
+{
+	struct headset *hs = find_transport_headset(transport);
+
+	assert(hs != NULL);
+	assert(hs->slc != NULL);
+
+	media_transport_update_microphone_gain(transport, hs->slc->sp_gain);
+	media_transport_update_speaker_gain(transport, hs->slc->mic_gain);
+
+	return hs;
+}
+
+static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct headset *hs = user_data;
+	struct btd_service *service = hs->service;
+	struct btd_device *device = btd_service_get_device(service);
+	char addr[18];
+
+	if (err) {
+		error("%s", err->message);
+
+		if (hs->rfcomm != NULL)
+			headset_set_state(hs, HEADSET_STATE_CONNECTED);
+		else
+			headset_set_state(hs, HEADSET_STATE_DISCONNECTED);
+
+		return;
+	}
+
+	ba2str(device_get_address(device), addr);
+	DBG("SCO socket opened for headset %s", addr);
+	headset_init_sco(hs);
+}
+
+static guint hsp_transport_resume(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct headset *hs = media_transport_get_data(transport);
+	struct btd_device *device = btd_service_get_device(hs->service);
+	GError *err = NULL;
+	const bdaddr_t *src, *dst;
+	char addr[18];
+
+	if (hs->state == HEADSET_STATE_PLAYING)
+		return 0;
+
+	switch (hs->state) {
+	case HEADSET_STATE_DISCONNECTED:
+	case HEADSET_STATE_CONNECTING:
+		return -ENOTCONN;
+	case HEADSET_STATE_CONNECTED:
+		break;
+	case HEADSET_STATE_RESUMING:
+		return -EBUSY;
+	case HEADSET_STATE_PLAYING:
+		return -EISCONN;
+	case HEADSET_STATE_SUSPENDING:
+		return -EBUSY;
+	}
+
+	assert(hs->rfcomm != NULL);
+	assert(hs->sco == NULL);
+	assert(hs->pending_media_owner == NULL);
+
+	src = adapter_get_address(device_get_adapter(device));
+	dst = device_get_address(device);
+
+	ba2str(device_get_address(device), addr);
+	DBG("Requesting SCO for %s, media_owner %p", addr, owner);
+
+	hs->sco = bt_io_connect(sco_connect_cb, hs, NULL, &err,
+						BT_IO_OPT_SOURCE_BDADDR, src,
+						BT_IO_OPT_DEST_BDADDR, dst,
+						BT_IO_OPT_INVALID);
+
+	if (hs->sco == NULL) {
+		error("%s", err->message);
+		g_error_free(err);
+		return -EIO;
+	}
+
+	hs->pending_media_owner = owner;
+	headset_set_state(hs, HEADSET_STATE_RESUMING);
+
+	return 1;
+}
+
+static guint hsp_transport_suspend(struct media_transport *transport,
+						struct media_owner *owner)
+{
+	struct headset *hs = media_transport_get_data(transport);
+	struct btd_device *device = btd_service_get_device(hs->service);
+	char addr[18];
+	int sock;
+
+	switch (hs->state) {
+	case HEADSET_STATE_DISCONNECTED:
+	case HEADSET_STATE_CONNECTING:
+		return -ENOTCONN;
+	case HEADSET_STATE_CONNECTED:
+		return -EISCONN;
+	case HEADSET_STATE_RESUMING:
+		assert(hs->pending_media_owner != NULL);
+		media_transport_resume_complete(hs->pending_media_owner, -1, 0,
+									0);
+		hs->pending_media_owner = NULL;
+		break;
+	case HEADSET_STATE_PLAYING:
+		break;
+	case HEADSET_STATE_SUSPENDING:
+		return 0;
+	}
+
+	assert(hs->sco != NULL);
+	assert(hs->pending_media_owner == NULL);
+
+	ba2str(device_get_address(device), addr);
+	DBG("Suspending SCO for %s, media_owner %p", addr, owner);
+
+	/* shutdown but leave the socket open and wait for hup */
+	sock = g_io_channel_unix_get_fd(hs->sco);
+	shutdown(sock, SHUT_RDWR);
+
+	hs->pending_media_owner = owner;
+	headset_set_state(hs, HEADSET_STATE_SUSPENDING);
+
+	return 1;
+}
+
+static void hsp_transport_set_microphone_gain(
+				struct media_transport *transport, char gain)
+{
+	struct headset *hs = media_transport_get_data(transport);
+
+	hs->slc->mic_gain = gain;
+	headset_send(hs, "\r\n+VGM=%u\r\n", gain);
+}
+
+static void hsp_transport_set_speaker_gain(
+				struct media_transport *transport, char gain)
+{
+	struct headset *hs = media_transport_get_data(transport);
+
+	hs->slc->sp_gain = gain;
+	headset_send(hs, "\r\n+VGS=%u\r\n", gain);
+}
+
+static void hsp_transport_cancel(struct media_transport *transport, guint id)
+{
+}
+
+static void hsp_transport_destroy(void *data)
+{
+	struct headset *hs = data;
+
+	hs->transport = NULL;
+	hs->endpoint = NULL;
+	hs->pending_media_owner = NULL;
+
+	if (hs->state <= HEADSET_STATE_CONNECTED)
+		return;
+
+	headset_close_sco(hs);
+	headset_set_state(hs, HEADSET_STATE_CONNECTED);
+}
+
+static struct media_transport_driver hsp_ag_driver = {
+	.uuid			= HSP_AG_UUID,
+	.init			= hsp_transport_init,
+	.resume			= hsp_transport_resume,
+	.suspend		= hsp_transport_suspend,
+	.set_microphone_gain	= hsp_transport_set_microphone_gain,
+	.set_speaker_gain	= hsp_transport_set_speaker_gain,
+	.cancel			= hsp_transport_cancel,
+	.destroy		= hsp_transport_destroy,
+};
+
+static struct media_transport_driver hfp_ag_driver = {
+	.uuid			= HFP_AG_UUID,
+	.init			= hsp_transport_init,
+	.resume			= hsp_transport_resume,
+	.suspend		= hsp_transport_suspend,
+	.set_microphone_gain	= hsp_transport_set_microphone_gain,
+	.set_speaker_gain	= hsp_transport_set_speaker_gain,
+	.cancel			= hsp_transport_cancel,
+	.destroy		= hsp_transport_destroy,
+};
+
 static int hsp_init(void)
 {
 	int err;
@@ -1092,11 +1340,16 @@ static int hsp_init(void)
 	if (err < 0)
 		return err;
 
+	media_transport_driver_register(&hsp_ag_driver);
+	media_transport_driver_register(&hfp_ag_driver);
+
 	return 0;
 }
 
 static void hsp_exit(void)
 {
+	media_transport_driver_unregister(&hfp_ag_driver);
+	media_transport_driver_unregister(&hsp_ag_driver);
 	btd_profile_unregister(&hsp_profile);
 }
 
-- 
1.8.1.4


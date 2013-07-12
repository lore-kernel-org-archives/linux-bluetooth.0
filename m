Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 09/10] hsp: Add Media API integration
Date: Fri, 12 Jul 2013 12:54:42 +0200
Message-Id: <1373626483-2031-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the HSP plugin with the required interactions with the core Media
API infrastructure.
---
 plugins/hsp.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/plugins/hsp.c b/plugins/hsp.c
index f0b55c9..740b857 100644
--- a/plugins/hsp.c
+++ b/plugins/hsp.c
@@ -60,6 +60,7 @@
 #include "sdpd.h"
 #include "btio.h"
 #include "profiles/audio/manager.h"
+#include "profiles/audio/media.h"
 
 #define DEFAULT_HS_AG_CHANNEL 12
 #define BUF_SIZE 1024
@@ -86,6 +87,7 @@ struct server {
 	GIOChannel *sco_io;
 	uint32_t record_id;
 	GSList *active_headsets;
+	unsigned int endpoint_register_cb_id;
 };
 
 struct headset {
@@ -102,6 +104,9 @@ struct headset {
 	guint sco_id;
 
 	headset_state_t state;
+
+	struct media_endpoint *endpoint;
+	struct media_transport *transport;
 };
 
 struct event {
@@ -305,6 +310,58 @@ static int handle_event(struct headset *hs, const char *buf)
 	return -EINVAL;
 }
 
+static void headset_setconf_cb(struct media_endpoint *endpoint, void *ret,
+						int size, void *user_data)
+{
+	struct headset *hs = user_data;
+
+	DBG("%p: ret=%p", hs, ret);
+
+	if (ret != NULL) {
+		hs->endpoint = endpoint;
+		return;
+	}
+
+	hs->transport = NULL;
+
+	error("Transport SetConfiguration() failed");
+}
+
+static void headset_setconf(struct headset *hs)
+{
+	struct btd_device *device = btd_service_get_device(hs->service);
+	struct media_endpoint *endpoint;
+	struct btd_adapter *adapter;
+
+	adapter = device_get_adapter(device);
+	endpoint = btd_media_endpoint_find(adapter, HSP_AG_UUID);
+
+	if (endpoint == NULL)
+		endpoint = btd_media_endpoint_find(adapter, HFP_AG_UUID);
+
+	if (endpoint == NULL) {
+		DBG("No media enpoint registered for headset");
+		return;
+	}
+
+	DBG("Setting configuration using endpoint %p", endpoint);
+
+	hs->transport = btd_media_endpoint_set_configuration(
+					endpoint, hs->audio_dev, NULL, 0,
+					headset_setconf_cb, hs, NULL);
+}
+
+static void headset_clearconf(struct headset *hs)
+{
+	if (hs->endpoint == NULL)
+		return;
+
+	DBG("Clear endpoint %p (transport %p)", hs->endpoint, hs->transport);
+	btd_media_endpoint_clear_configuration(hs->endpoint, hs->transport);
+	hs->transport = NULL;
+	hs->endpoint = NULL;
+}
+
 static gboolean rfcomm_io_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -413,6 +470,7 @@ static void headset_connect_rfcomm_cb(GIOChannel *io, GError *err,
 	ba2str(device_get_address(device), addr);
 	DBG("Connected to %s", addr);
 
+	headset_setconf(hs);
 	headset_set_state(hs, HEADSET_STATE_CONNECTED);
 }
 
@@ -604,6 +662,7 @@ static void headset_set_state(struct headset *hs, headset_state_t state)
 
 	switch (state) {
 	case HEADSET_STATE_DISCONNECTED:
+		headset_clearconf(hs);
 		headset_cancel_discovery(hs);
 		headset_close_sco(hs);
 		headset_close_rfcomm(hs);
@@ -810,6 +869,7 @@ static void confirm_event_cb(GIOChannel *io, gpointer user_data)
 	DBG("Accepted headset RFCOMM connection from %s", addr);
 	hs->rfcomm = g_io_channel_ref(io);
 
+	headset_setconf(hs);
 	headset_set_state(hs, HEADSET_STATE_CONNECTED);
 
 	return;
@@ -868,6 +928,29 @@ drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
 }
 
+static void media_endpoint_register_cb(struct media_endpoint *endpoint,
+								void *user_data)
+{
+	struct server *server = user_data;
+	GSList *l;
+
+	if (strcasecmp(media_endpoint_get_uuid(endpoint), HSP_AG_UUID) != 0 &&
+		strcasecmp(media_endpoint_get_uuid(endpoint), HFP_AG_UUID) != 0)
+		return;
+
+	DBG("HSP endpoint registered: configuring %u active headsets",
+				g_slist_length(server->active_headsets));
+
+	for (l = server->active_headsets; l != NULL; l = g_slist_next(l)) {
+		struct headset *hs = l->data;
+
+		hs->transport = btd_media_endpoint_set_configuration(
+						endpoint, hs->audio_dev,
+						NULL, 0, headset_setconf_cb,
+						hs, NULL);
+	}
+}
+
 static int hsp_hs_server_probe(struct btd_profile *p,
 						struct btd_adapter *adapter)
 {
@@ -927,6 +1010,10 @@ static int hsp_hs_server_probe(struct btd_profile *p,
 		goto failed;
 	}
 
+	server->endpoint_register_cb_id = btd_media_endpoint_add_register_cb(
+					adapter, media_endpoint_register_cb,
+					server);
+
 	server->record_id = record->handle;
 	servers = g_slist_append(servers, server);
 
@@ -961,6 +1048,10 @@ static void hsp_hs_server_remove(struct btd_profile *p,
 		return;
 	}
 
+	if (server->endpoint_register_cb_id != 0)
+		btd_media_endpoint_remove_register_cb(adapter,
+					server->endpoint_register_cb_id);
+
 	if (server->record_id != 0)
 		remove_record_from_server(server->record_id);
 
-- 
1.8.1.4


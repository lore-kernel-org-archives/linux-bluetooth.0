Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 4/6] media: Split media_endpoint_create
Date: Fri,  4 May 2012 15:14:38 +0200
Message-Id: <1336137280-6692-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1336137280-6692-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1336137280-6692-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This function is starting to be too long and needs to be split.

After this patch, the resulting code should be exactly equivalent as the
previous implementation.
---
 audio/media.c |  119 +++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index fd5a369..88b994f 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -658,6 +658,64 @@ static void gateway_state_changed(struct audio_device *dev,
 	}
 }
 
+static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
+						gboolean delay_reporting,
+						int *err)
+{
+	endpoint->sep = a2dp_add_sep(&endpoint->adapter->src,
+					AVDTP_SEP_TYPE_SOURCE, endpoint->codec,
+					delay_reporting, &a2dp_endpoint,
+					endpoint, a2dp_destroy_endpoint, err);
+	if (endpoint->sep == NULL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
+						gboolean delay_reporting,
+						int *err)
+{
+	endpoint->sep = a2dp_add_sep(&endpoint->adapter->src,
+					AVDTP_SEP_TYPE_SINK, endpoint->codec,
+					delay_reporting, &a2dp_endpoint,
+					endpoint, a2dp_destroy_endpoint, err);
+	if (endpoint->sep == NULL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean endpoint_init_ag(struct media_endpoint *endpoint, int *err)
+{
+	struct audio_device *dev;
+
+	endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
+								endpoint);
+	dev = manager_find_device(NULL, &endpoint->adapter->src, BDADDR_ANY,
+						AUDIO_HEADSET_INTERFACE, TRUE);
+	if (dev)
+		set_configuration(endpoint, dev, NULL, 0,
+						headset_setconf_cb, dev, NULL);
+
+	return TRUE;
+}
+
+static gboolean endpoint_init_hs(struct media_endpoint *endpoint, int *err)
+{
+	struct audio_device *dev;
+
+	endpoint->ag_watch = gateway_add_state_cb(gateway_state_changed,
+								endpoint);
+	dev = manager_find_device(NULL, &endpoint->adapter->src, BDADDR_ANY,
+						AUDIO_GATEWAY_INTERFACE, TRUE);
+	if (dev)
+		set_configuration(endpoint, dev, NULL, 0,
+						gateway_setconf_cb, dev, NULL);
+
+	return TRUE;
+}
+
 static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
@@ -669,6 +727,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 						int *err)
 {
 	struct media_endpoint *endpoint;
+	gboolean succeeded;
 
 	endpoint = g_new0(struct media_endpoint, 1);
 	endpoint->sender = g_strdup(sender);
@@ -684,46 +743,28 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 
 	endpoint->adapter = adapter;
 
-	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
-		endpoint->sep = a2dp_add_sep(&adapter->src,
-					AVDTP_SEP_TYPE_SOURCE, codec,
-					delay_reporting, &a2dp_endpoint,
-					endpoint, a2dp_destroy_endpoint, err);
-		if (endpoint->sep == NULL)
-			goto failed;
-	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
-		endpoint->sep = a2dp_add_sep(&adapter->src,
-					AVDTP_SEP_TYPE_SINK, codec,
-					delay_reporting, &a2dp_endpoint,
-					endpoint, a2dp_destroy_endpoint, err);
-		if (endpoint->sep == NULL)
-			goto failed;
-	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
-					strcasecmp(uuid, HSP_AG_UUID) == 0) {
-		struct audio_device *dev;
-
-		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
-								endpoint);
-		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
-						AUDIO_HEADSET_INTERFACE, TRUE);
-		if (dev)
-			set_configuration(endpoint, dev, NULL, 0,
-						headset_setconf_cb, dev, NULL);
-	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
-					strcasecmp(uuid, HSP_HS_UUID) == 0) {
-		struct audio_device *dev;
+	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0)
+		succeeded = endpoint_init_a2dp_source(endpoint,
+							delay_reporting, err);
+	else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0)
+		succeeded = endpoint_init_a2dp_sink(endpoint,
+							delay_reporting, err);
+	else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
+					strcasecmp(uuid, HSP_AG_UUID) == 0)
+		succeeded = endpoint_init_ag(endpoint, err);
+	else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
+					strcasecmp(uuid, HSP_HS_UUID) == 0)
+		succeeded = endpoint_init_hs(endpoint, err);
+	else {
+		succeeded = FALSE;
 
-		endpoint->ag_watch = gateway_add_state_cb(gateway_state_changed,
-								endpoint);
-		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
-						AUDIO_GATEWAY_INTERFACE, TRUE);
-		if (dev)
-			set_configuration(endpoint, dev, NULL, 0,
-						gateway_setconf_cb, dev, NULL);
-	} else {
 		if (err)
 			*err = -EINVAL;
-		goto failed;
+	}
+
+	if (!succeeded) {
+		g_free(endpoint);
+		return NULL;
 	}
 
 	endpoint->watch = g_dbus_add_disconnect_watch(adapter->conn, sender,
@@ -736,10 +777,6 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 	if (err)
 		*err = 0;
 	return endpoint;
-
-failed:
-	g_free(endpoint);
-	return NULL;
 }
 
 static struct media_endpoint *media_adapter_find_endpoint(
-- 
1.7.7.6


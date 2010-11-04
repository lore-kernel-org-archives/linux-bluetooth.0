Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not ignoring case of uuid given to RegisterEndpoint
Date: Thu,  4 Nov 2010 16:29:50 +0200
Message-Id: <1288880990-2125-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/media.c     |    6 +++---
 audio/transport.c |    8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 661f81a..b6c90f9 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -190,19 +190,19 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 	endpoint->size = size;
 	endpoint->adapter = adapter;
 
-	if (g_strcmp0(uuid, A2DP_SOURCE_UUID) == 0) {
+	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
 		endpoint->sep = a2dp_add_sep(&adapter->src,
 					AVDTP_SEP_TYPE_SOURCE, codec,
 					delay_reporting, endpoint);
 		if (endpoint->sep == NULL)
 			goto failed;
-	} else if (g_strcmp0(uuid, A2DP_SINK_UUID) == 0) {
+	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
 		endpoint->sep = a2dp_add_sep(&adapter->src,
 						AVDTP_SEP_TYPE_SINK, codec,
 						delay_reporting, endpoint);
 		if (endpoint->sep == NULL)
 			goto failed;
-	} else if (g_strcmp0(uuid, HFP_AG_UUID) == 0 ||
+	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
 					g_strcmp0(uuid, HSP_AG_UUID) == 0)
 		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
 								endpoint);
diff --git a/audio/transport.c b/audio/transport.c
index 6d78b73..eda46e1 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -711,15 +711,15 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 	transport->fd = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
-	if (g_strcmp0(uuid, A2DP_SOURCE_UUID) == 0 ||
-			g_strcmp0(uuid, A2DP_SINK_UUID) == 0) {
+	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0 ||
+			strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
 		transport->resume = resume_a2dp;
 		transport->suspend = suspend_a2dp;
 		transport->cancel = cancel_a2dp;
 		transport->get_properties = get_properties_a2dp;
 		transport->set_property = set_property_a2dp;
-	} else if (g_strcmp0(uuid, HFP_AG_UUID) == 0 ||
-			g_strcmp0(uuid, HSP_AG_UUID) == 0) {
+	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
+			strcasecmp(uuid, HSP_AG_UUID) == 0) {
 		transport->resume = resume_headset;
 		transport->suspend = suspend_headset;
 		transport->cancel = cancel_headset;
-- 
1.7.1


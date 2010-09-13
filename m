Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/10] Update a2dp transport delay when it changes
Date: Mon, 13 Sep 2010 17:15:35 +0300
Message-Id: <1284387337-18822-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/a2dp.c      |   31 +++++++++++++++++++++++++++----
 audio/media.c     |    6 ++++++
 audio/media.h     |    2 ++
 audio/transport.c |   14 ++++++++++++++
 audio/transport.h |    2 ++
 5 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index e6daf3b..7d3f25f 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -44,6 +44,7 @@
 #include "source.h"
 #include "unix.h"
 #include "media.h"
+#include "transport.h"
 #include "a2dp.h"
 #include "sdpd.h"
 
@@ -600,9 +601,9 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 }
 
 static gboolean endpoint_getcap_ind(struct avdtp *session,
-				struct avdtp_local_sep *sep,
-				gboolean get_all,
-				GSList **caps, uint8_t *err, void *user_data)
+					struct avdtp_local_sep *sep,
+					gboolean get_all, GSList **caps,
+					uint8_t *err, void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct avdtp_service_capability *media_transport, *media_codec;
@@ -1031,6 +1032,28 @@ static gboolean delayreport_ind(struct avdtp *session,
 	return TRUE;
 }
 
+static gboolean endpoint_delayreport_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						uint8_t rseid, uint16_t delay,
+						uint8_t *err, void *user_data)
+{
+	struct a2dp_sep *a2dp_sep = user_data;
+	struct media_transport *transport;
+
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: DelayReport_Ind", sep);
+	else
+		DBG("Source %p: DelayReport_Ind", sep);
+
+	transport = media_endpoint_get_transport(a2dp_sep->endpoint);
+	if (transport == NULL)
+		return FALSE;
+
+	media_transport_update_delay(transport, delay);
+
+	return TRUE;
+}
+
 static void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 			struct avdtp_stream *stream, struct avdtp_error *err,
 			void *user_data)
@@ -1115,7 +1138,7 @@ static struct avdtp_sep_ind endpoint_ind = {
 	.close			= close_ind,
 	.abort			= abort_ind,
 	.reconfigure		= reconf_ind,
-	.delayreport		= delayreport_ind,
+	.delayreport		= endpoint_delayreport_ind,
 };
 
 static sdp_record_t *a2dp_record(uint8_t type, uint16_t avdtp_ver)
diff --git a/audio/media.c b/audio/media.c
index da9d3ae..19ba1c4 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -681,3 +681,9 @@ uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
 {
 	return endpoint->codec;
 }
+
+struct media_transport *media_endpoint_get_transport(
+					struct media_endpoint *endpoint)
+{
+	return endpoint->transport;
+}
diff --git a/audio/media.h b/audio/media.h
index f6d144c..d089103 100644
--- a/audio/media.h
+++ b/audio/media.h
@@ -50,3 +50,5 @@ void media_endpoint_release(struct media_endpoint *endpoint);
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
+struct media_transport *media_endpoint_get_transport(
+					struct media_endpoint *endpoint);
diff --git a/audio/transport.c b/audio/transport.c
index c4d78a4..0da99e8 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -669,3 +669,17 @@ const char *media_transport_get_path(struct media_transport *transport)
 {
 	return transport->path;
 }
+
+void media_transport_update_delay(struct media_transport *transport,
+							uint16_t delay)
+{
+	/* Check if delay really changed */
+	if (transport->delay == delay)
+		return;
+
+	transport->delay = delay;
+
+	emit_property_changed(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE, "Delay",
+				DBUS_TYPE_UINT16, &transport->delay);
+}
diff --git a/audio/transport.h b/audio/transport.h
index a7594f0..f2eb37b 100644
--- a/audio/transport.h
+++ b/audio/transport.h
@@ -32,3 +32,5 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 
 void media_transport_remove(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
+void media_transport_update_delay(struct media_transport *transport,
+							uint16_t delay);
-- 
1.7.1


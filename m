Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] obexd/client: Add supported_features support
Date: Mon,  1 Dec 2014 10:47:18 +0200
Message-Id: <1417423638-29222-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds supported_features support to obc_driver so driver can
provide this information when connecting.

This is required by PBAP 1.2 (page 48):

  'Mandatory if the PSE advertises a PbapSupportedFeatures attribute in
   its SDP record, else excluded.'
---
 obexd/client/driver.h  |  1 +
 obexd/client/pbap.c    | 36 ++++++++++++++++++++++++++++++++++++
 obexd/client/session.c | 25 ++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/obexd/client/driver.h b/obexd/client/driver.h
index f1c0646..0112219 100644
--- a/obexd/client/driver.h
+++ b/obexd/client/driver.h
@@ -26,6 +26,7 @@ struct obc_driver {
 	const char *uuid;
 	void *target;
 	gsize target_len;
+	void *(*supported_features) (struct obc_session *session);
 	int (*probe) (struct obc_session *session);
 	void (*remove) (struct obc_session *session);
 };
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 812a7fb..57632b4 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -76,6 +76,7 @@
 #define PRIMARY_COUNTER_TAG	0X0A
 #define SECONDARY_COUNTER_TAG	0X0B
 #define DATABASEID_TAG		0X0D
+#define SUPPORTED_FEATURES_TAG  0x10
 
 #define DOWNLOAD_FEATURE	0x00000001
 #define BROWSE_FEATURE		0x00000002
@@ -1230,6 +1231,40 @@ static void parse_service_record(struct pbap_data *pbap)
 
 }
 
+static void *pbap_supported_features(struct obc_session *session)
+{
+	const void *data;
+	uint16_t version;
+
+	/* Version */
+	data = obc_session_get_attribute(session, SDP_ATTR_PFILE_DESC_LIST);
+	if (!data)
+		return NULL;
+
+	version = GPOINTER_TO_UINT(data);
+
+	if (version < 0x0102)
+		return NULL;
+
+	/* Supported Feature Bits */
+	data = obc_session_get_attribute(session,
+					SDP_ATTR_PBAP_SUPPORTED_FEATURES);
+	if (!data)
+		return NULL;
+
+	return g_obex_apparam_set_uint32(NULL, SUPPORTED_FEATURES_TAG,
+						DOWNLOAD_FEATURE |
+						BROWSE_FEATURE |
+						DATABASEID_FEATURE |
+						FOLDER_VERSION_FEATURE |
+						VCARD_SELECTING_FEATURE |
+						ENHANCED_CALLS_FEATURE |
+						UCI_FEATURE |
+						UID_FEATURE |
+						REFERENCING_FEATURE |
+						DEFAULT_IMAGE_FEATURE);
+}
+
 static int pbap_probe(struct obc_session *session)
 {
 	struct pbap_data *pbap;
@@ -1274,6 +1309,7 @@ static struct obc_driver pbap = {
 	.uuid = PBAP_UUID,
 	.target = OBEX_PBAP_UUID,
 	.target_len = OBEX_PBAP_UUID_LEN,
+	.supported_features = pbap_supported_features,
 	.probe = pbap_probe,
 	.remove = pbap_remove
 };
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 9bba6c6..d2ae4fd 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -345,6 +345,7 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 	struct obc_driver *driver = session->driver;
 	struct obc_transport *transport = session->transport;
 	GObex *obex;
+	GObexApparam *apparam;
 	GObexTransportType type;
 	int tx_mtu = -1;
 	int rx_mtu = -1;
@@ -370,7 +371,29 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 
 	g_io_channel_set_close_on_unref(io, TRUE);
 
-	if (driver->target != NULL)
+	apparam = NULL;
+
+	if (driver->supported_features)
+		apparam = driver->supported_features(session);
+
+	if (apparam) {
+		uint8_t buf[1024];
+		ssize_t len;
+
+		len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+		if (driver->target)
+			g_obex_connect(obex, connect_cb, callback, &err,
+					G_OBEX_HDR_TARGET,
+					driver->target, driver->target_len,
+					G_OBEX_HDR_APPARAM,
+					buf, len,
+					G_OBEX_HDR_INVALID);
+		else
+			g_obex_connect(obex, connect_cb, callback, &err,
+					G_OBEX_HDR_APPARAM, buf, len,
+					G_OBEX_HDR_INVALID);
+		g_obex_apparam_free(apparam);
+	} else if (driver->target)
 		g_obex_connect(obex, connect_cb, callback, &err,
 			G_OBEX_HDR_TARGET, driver->target, driver->target_len,
 			G_OBEX_HDR_INVALID);
-- 
1.9.3


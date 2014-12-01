Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] obexd/client: Parse PBAP record
Date: Mon,  1 Dec 2014 10:47:12 +0200
Message-Id: <1417423638-29222-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
References: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add parsing to PBAP record to extract version and supported
features.
---
 obexd/client/pbap.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 11574e7..c33de3f 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -33,6 +33,7 @@
 #include <gdbus/gdbus.h>
 
 #include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
 #include <gobex/gobex-apparam.h>
 
 #include "log.h"
@@ -73,6 +74,17 @@
 #define PHONEBOOKSIZE_TAG	0X08
 #define NEWMISSEDCALLS_TAG	0X09
 
+#define DOWNLOAD_FEATURE	0x00000001
+#define BROWSE_FEATURE		0x00000002
+#define DATABASEID_FEATURE	0x00000004
+#define FOLDER_VERSION_FEATURE	0x00000008
+#define VCARD_SELECTING_FEATURE	0x00000010
+#define ENHANCED_CALLS_FEATURE	0x00000020
+#define UCI_FEATURE		0x00000040
+#define UID_FEATURE		0x00000080
+#define REFERENCING_FEATURE	0x00000100
+#define DEFAULT_IMAGE_FEATURE	0x00000200
+
 static const char *filter_list[] = {
 	"VERSION",
 	"FN",
@@ -119,6 +131,8 @@ static const char *filter_list[] = {
 struct pbap_data {
 	struct obc_session *session;
 	char *path;
+	uint16_t version;
+	uint32_t supported_features;
 };
 
 struct pending_request {
@@ -966,6 +980,35 @@ static void pbap_free(void *data)
 	g_free(pbap);
 }
 
+static void parse_service_record(struct pbap_data *pbap)
+{
+	const void *data;
+
+	/* Version */
+	data = obc_session_get_attribute(pbap->session,
+						SDP_ATTR_PFILE_DESC_LIST);
+	if (!data)
+		return;
+
+	pbap->version = GPOINTER_TO_UINT(data);
+
+	/*
+	 * If the PbapSupportedFeatures attribute is not present
+	 * 0x00000003 shall be assumed for a remote PSE.
+	 */
+	pbap->supported_features = 0x00000003;
+
+	if (pbap->version < 0x0102)
+		return;
+
+	/* Supported Feature Bits */
+	data = obc_session_get_attribute(pbap->session,
+					SDP_ATTR_PBAP_SUPPORTED_FEATURES);
+	if (data)
+		pbap->supported_features = *(uint32_t *) data;
+
+}
+
 static int pbap_probe(struct obc_session *session)
 {
 	struct pbap_data *pbap;
@@ -981,6 +1024,11 @@ static int pbap_probe(struct obc_session *session)
 
 	pbap->session = obc_session_ref(session);
 
+	parse_service_record(pbap);
+
+	DBG("%s, version 0x%04x supported features 0x%08x", path, pbap->version,
+						pbap->supported_features);
+
 	if (!g_dbus_register_interface(conn, path, PBAP_INTERFACE, pbap_methods,
 						NULL, NULL, pbap, pbap_free)) {
 		pbap_free(pbap);
-- 
1.9.3


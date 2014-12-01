Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] obexd/client: Add support for reading version
Date: Mon,  1 Dec 2014 10:47:11 +0200
Message-Id: <1417423638-29222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for reading profile version via
SDP_ATTR_PFILE_DESC_LIST
---
 obexd/client/bluetooth.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index e89a92b..589d7a5 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
 #include <errno.h>
 #include <inttypes.h>
 
@@ -482,6 +483,26 @@ static const void *bluetooth_getattribute(guint id, int attribute_id)
 		if (session->sdp_record == NULL)
 			break;
 
+		/* Read version since UUID is already known */
+		if (attribute_id == SDP_ATTR_PFILE_DESC_LIST) {
+			sdp_list_t *descs;
+
+			if (sdp_get_profile_descs(session->sdp_record,
+								&descs) < 0)
+				return NULL;
+
+			if (descs && descs->data) {
+				sdp_profile_desc_t *desc = descs->data;
+				uint16_t version = desc->version;
+
+				sdp_list_free(descs, free);
+
+				return GINT_TO_POINTER(version);
+			}
+
+			return NULL;
+		}
+
 		data = sdp_data_get(session->sdp_record, attribute_id);
 		if (!data)
 			break;
-- 
1.9.3


Return-Path: <cyrus@holtmann.org>
From: Balamurugan Mahalingam <mbalamurugan@atheros.com>
To: <marcel@holtmann.org>
CC: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<charubala@charubala.com>, Balamurugan Mahalingam <mbalamurugan@atheros.com>
Subject: [PATCH] Fix hidd to use ServiceName attribute for device name
Date: Wed, 20 Oct 2010 15:51:17 +0530
Message-ID: <1287570077-5669-1-git-send-email-mbalamurugan@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch lets hidd use ServiceName attribute from the SDP response
instead of ProviderName+ServiceDescription for device name.
SDP response from Microsoft Bluetooth device has extended ASCII
character 174(registered symbol) in its ServiceDescription attribute.
This causes some Bluetooth application which expects only printable
characters as device name to crash.
---
 compat/sdp.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/compat/sdp.c b/compat/sdp.c
index ff2e39f..f384844 100644
--- a/compat/sdp.c
+++ b/compat/sdp.c
@@ -248,22 +248,23 @@ int get_sdp_device_info(const bdaddr_t *src, const bdaddr_t *dst, struct hidp_co
 
 	rec = (sdp_record_t *) hid_rsp->data;
 
-	pdlist = sdp_data_get(rec, 0x0101);
-	pdlist2 = sdp_data_get(rec, 0x0102);
-	if (pdlist) {
-		if (pdlist2) {
-			if (strncmp(pdlist->val.str, pdlist2->val.str, 5)) {
-				strncpy(req->name, pdlist2->val.str, sizeof(req->name) - 1);
-				strcat(req->name, " ");
-			}
-			strncat(req->name, pdlist->val.str,
-					sizeof(req->name) - strlen(req->name));
-		} else
-			strncpy(req->name, pdlist->val.str, sizeof(req->name) - 1);
-	} else {
-		pdlist2 = sdp_data_get(rec, 0x0100);
-		if (pdlist2)
-			strncpy(req->name, pdlist2->val.str, sizeof(req->name) - 1);
+	pdlist2 = sdp_data_get(rec, 0x0100);
+	if (pdlist2)
+		strncpy(req->name, pdlist2->val.str, sizeof(req->name) - 1);
+	else {
+		pdlist = sdp_data_get(rec, 0x0101);
+		pdlist2 = sdp_data_get(rec, 0x0102);
+		if (pdlist) {
+			if (pdlist2) {
+				if (strncmp(pdlist->val.str, pdlist2->val.str, 5)) {
+					strncpy(req->name, pdlist2->val.str, sizeof(req->name) - 1);
+					strcat(req->name, " ");
+				}
+				strncat(req->name, pdlist->val.str,
+						sizeof(req->name) - strlen(req->name));
+			} else
+				strncpy(req->name, pdlist->val.str, sizeof(req->name) - 1);
+		}
 	}
 
 	pdlist = sdp_data_get(rec, 0x0201);
-- 
1.6.3.3

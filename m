Return-Path: <cyrus@holtmann.org>
From: Balamurugan Mahalingam <mbalamurugan@atheros.com>
To: <marcel@holtmann.org>
CC: <johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<charubala@charubala.com>, Balamurugan Mahalingam <mbalamurugan@atheros.com>
Subject: [PATCH] Fix hidd showing different names for same device
Date: Wed, 20 Oct 2010 14:42:52 +0530
Message-ID: <1287565973-5350-1-git-send-email-mbalamurugan@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

hidd shows different names for a same device when
connected from GUI and CLI

Blueman and other GUIs use the string from ServiceName attribute as
device name in the SDP response, but hidd tool uses strings from
Service Description and Provider Name atrribute.

SDP response from Microsoft Bluetooth device has extended ASCII
character 174(registered symbol) in its ServiceDescription attribute.
Android platform expects the device name to have only printable
characters and therefore GUI Crashes while connecting Microsoft
Bluetooth Mouse using hidd

Using the ServiceName attribute from the SDP response
instead of ProviderName+ServiceDescription for device name in the
hidd tool solves both the issues.
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

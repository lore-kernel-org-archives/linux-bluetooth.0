Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?I=C3=B1aki=20Arenaza?= <iarenaza@mondragon.edu>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?I=C3=B1aki=20Arenaza?= <iarenaza@mondragon.edu>
Subject: [PATCH 1/1] device: Some devices send HSP UUIDs in the wrong order
Date: Mon, 13 Jul 2015 23:32:49 +0200
Message-Id: <1436823169-32164-2-git-send-email-iarenaza@mondragon.edu>
In-Reply-To: <1436823169-32164-1-git-send-email-iarenaza@mondragon.edu>
References: <1436823169-32164-1-git-send-email-iarenaza@mondragon.edu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some devices behave contrary to what Erratum #3507 [1] says for the
v1.2 Headset Profile (HSP). They report HEADSET_HS_UUID as the first
value of the ServiceClassIDList attribute, and HSP_HS_UUID as the
second one. One of those devices is the Energy Wireles BT 3 Ruby Red
(from Energy Sistem)

[1] See section 6.15 of
https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=231555
---
 lib/uuid.h   |  1 +
 src/device.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 2dcfe9e..c2e12bb 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -35,6 +35,7 @@ extern "C" {
 
 #define HSP_HS_UUID		"00001108-0000-1000-8000-00805f9b34fb"
 #define HSP_AG_UUID		"00001112-0000-1000-8000-00805f9b34fb"
+#define HEADSET_HS_UUID		"00001131-0000-1000-8000-00805f9b34fb"
 
 #define HFP_HS_UUID		"0000111e-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID		"0000111f-0000-1000-8000-00805f9b34fb"
diff --git a/src/device.c b/src/device.c
index debe201..4e03780 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3880,6 +3880,23 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 			continue;
 		}
 
+		/* Fix devices that report HEADSET_HS_UUID before HSP_HS_UUID,
+		 * contrary to what Erratum #3507 says.
+		 */
+		if ((bt_uuid_strcmp(profile_uuid, HEADSET_HS_UUID) == 0)) {
+			if (svcclass->next != NULL) {
+				char *uuid;
+
+				uuid = bt_uuid2string(svcclass->next->data);
+				if (bt_uuid_strcmp(uuid, HSP_HS_UUID) == 0) {
+					free(profile_uuid);
+					profile_uuid = uuid;
+				} else {
+					free(uuid);
+				}
+			}
+		}
+
 		if (bt_uuid_strcmp(profile_uuid, PNP_UUID) == 0) {
 			uint16_t source, vendor, product, version;
 			sdp_data_t *pdlist;
-- 
2.1.4


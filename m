Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/2] android/gatt: Fix cached services having element_id uuid not set
Date: Thu, 27 Mar 2014 17:05:05 +0100
Message-Id: <1395936305-23188-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395936305-23188-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395936305-23188-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes temporary uuid as we already have uuid in services
element_id, which now is properly filled.
---
 android/gatt.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0327d54..424e4db 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -304,7 +304,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		struct hal_ev_gatt_client_search_result ev_res;
 		struct gatt_primary *prim = l->data;
 		struct service *p;
-		bt_uuid_t uuid;
 
 		p = new0(struct service, 1);
 		if (!p) {
@@ -321,6 +320,11 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 
 		memset(&ev_res, 0, sizeof(ev_res));
 
+		if (bt_string_to_uuid(&p->id.uuid, prim->uuid) < 0) {
+			error("gatt: Cannot convert string to uuid");
+			continue;
+		}
+
 		/* Put primary service to our local list */
 		memcpy(&p->primary, prim, sizeof(p->primary));
 		if (!queue_push_tail(dev->services, p)) {
@@ -337,12 +341,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		ev_res.srvc_id.is_primary = 1;
 		ev_res.srvc_id.inst_id = 0;
 
-		if (bt_string_to_uuid(&uuid, prim->uuid) < 0) {
-			error("gatt: Cannot convert string to uuid");
-			continue;
-		}
-
-		uuid2android(&uuid, ev_res.srvc_id.uuid);
+		uuid2android(&p->id.uuid, ev_res.srvc_id.uuid);
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
 					HAL_EV_GATT_CLIENT_SEARCH_RESULT,
-- 
1.9.0


Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/7] android/gatt: Use better name for function filling element_id
Date: Wed, 26 Mar 2014 18:00:55 +0100
Message-Id: <1395853259-15618-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2ea99e4..06ae5cd 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1013,7 +1013,7 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 	free(data);
 }
 
-static void hal_srvc_id_to_gatt_id(const struct hal_gatt_srvc_id *from,
+static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
 							struct element_id *to)
 {
 	uint128_t uuid128;
@@ -1051,7 +1051,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	hal_srvc_id_to_gatt_id(&cmd->srvc_id, &match_id);
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
 	srvc = queue_find(dev->services, match_srvc_by_element_id, &match_id);
 	if (!srvc) {
 		error("gatt: Service with inst_id: %d not found",
-- 
1.9.0


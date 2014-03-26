Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/7] android/gatt: Reduce callback data struct scope
Date: Wed, 26 Mar 2014 18:00:57 +0100
Message-Id: <1395853259-15618-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1395853259-15618-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This saves us from redundant data (de)allocation if characteristics are
already cached.
---
 android/gatt.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e97677d..fe8ba74 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1054,7 +1054,6 @@ static bool find_service(int32_t conn_id, struct element_id *service_id,
 static void handle_client_get_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_characteristic *cmd = buf;
-	struct discover_char_data *cb_data;
 	struct characteristic *ch;
 	struct element_id match_id;
 	struct gatt_device *dev;
@@ -1076,28 +1075,33 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	cb_data = new0(struct discover_char_data, 1);
-	if (!cb_data) {
-		error("gatt: Cannot allocate call data");
-		status = HAL_STATUS_FAILED;
-		goto done;
-	}
-
-	cb_data->service = srvc;
-	cb_data->conn_id = dev->conn_id;
-
 	/* Discover all characteristics for services if not cached yet */
 	if (queue_isempty(srvc->chars)) {
-		gatt_discover_char(dev->attrib, srvc->primary.range.start,
+		struct discover_char_data *cb_data =
+					new0(struct discover_char_data, 1);
+
+		if (!cb_data) {
+			error("gatt: Cannot allocate cb data");
+			status = HAL_STATUS_FAILED;
+			goto done;
+		}
+
+		cb_data->service = srvc;
+		cb_data->conn_id = dev->conn_id;
+
+		if (!gatt_discover_char(dev->attrib, srvc->primary.range.start,
 					srvc->primary.range.end, NULL,
-					discover_char_cb, cb_data);
+					discover_char_cb, cb_data)) {
+			free(cb_data);
+
+			status = HAL_STATUS_FAILED;
+			goto done;
+		}
 
 		status = HAL_STATUS_SUCCESS;
 		goto done;
 	}
 
-	free(cb_data);
-
 	if (cmd->number)
 		ch = queue_find(srvc->chars, match_char_by_higher_inst_id,
 					INT_TO_PTR(cmd->gatt_id[0].inst_id));
-- 
1.9.0


Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 6/8] android/hal-gatt-api: Fix IPC definition for write_characteristic
Date: Thu, 17 Apr 2014 01:10:31 +0200
Message-Id: <1397689833-17557-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c     | 6 +++---
 android/hal-gatt.c | 2 +-
 android/hal-msg.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 878df0e..aa258f1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2262,7 +2262,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	}
 
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
-	hal_gatt_id_to_element_id(&cmd->gatt_id, &char_id);
+	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
 
 	if (!find_service(cmd->conn_id, &srvc_id, &dev, &srvc)) {
 		status = HAL_STATUS_FAILED;
@@ -2273,7 +2273,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 	ch = queue_find(srvc->chars, match_char_by_element_id, &char_id);
 	if (!ch) {
 		error("gatt: Characteristic with inst_id: %d not found",
-							cmd->gatt_id.inst_id);
+							cmd->char_id.inst_id);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -2300,7 +2300,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 
 	if (!res) {
 		error("gatt: Cannot write char. with inst_id: %d",
-							cmd->gatt_id.inst_id);
+							cmd->char_id.inst_id);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index e805a82..3bbae2b 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -810,7 +810,7 @@ static bt_status_t write_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 	cmd->auth_req = auth_req;
 
 	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
-	gatt_id_to_hal(&cmd->gatt_id, char_id);
+	gatt_id_to_hal(&cmd->char_id, char_id);
 
 	memcpy(cmd->value, p_value, len);
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4974a51..ed0a67a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -660,7 +660,7 @@ struct hal_cmd_gatt_client_read_characteristic {
 struct hal_cmd_gatt_client_write_characteristic {
 	int32_t conn_id;
 	struct hal_gatt_srvc_id srvc_id;
-	struct hal_gatt_gatt_id gatt_id;
+	struct hal_gatt_gatt_id char_id;
 	int32_t write_type;
 	int32_t len;
 	int32_t auth_req;
-- 
1.9.2


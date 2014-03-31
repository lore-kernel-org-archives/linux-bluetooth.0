Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/3] android/hal-msg: Add extra struct for mdep data
Date: Mon, 31 Mar 2014 16:13:34 +0300
Message-Id: <1396271615-10221-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1396271615-10221-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1396271615-10221-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Defined extra structure for MDEP data which is required for Register
Application. Also updated Opcodes for rest.
---
 android/hal-msg.h | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index b7fa8fc..44a72b0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -383,37 +383,36 @@ struct hal_cmd_pan_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-struct hal_string {
-	uint8_t len;
-	uint8_t data[0];
-};
-
 #define HAL_OP_HEALTH_REG_APP		0x01
 struct hal_cmd_health_reg_app {
-	struct hal_string app_name;
-	struct hal_string provider_name;
-	struct hal_string service_name;
-	struct hal_string service_descr;
-	uint8_t num_of_mdep;
+	uint8_t  num_of_mdep;
+	uint16_t app_name_off;
+	uint16_t provider_name_off;
+	uint16_t service_name_off;
+	uint16_t service_descr_off;
+	uint16_t len;
+	uint8_t  data[0];
+} __attribute__((packed));
 
-	struct {
-		uint8_t role;
-		uint8_t data_type;
-		uint8_t channel_type;
-		struct  hal_string descr;
-	} mdep_cfg[0];
+#define HAL_OP_HEALTH_MDEP		0x02
+struct hal_cmd_health_mdep {
+	uint8_t  role;
+	uint8_t  data_type;
+	uint8_t  channel_type;
+	uint16_t descr_len;
+	uint8_t  descr[0];
 } __attribute__((packed));
 
 struct hal_rsp_health_reg_app {
 	uint16_t app_id;
 } __attribute__((packed));
 
-#define HAL_OP_HEALTH_UNREG_APP		0x02
+#define HAL_OP_HEALTH_UNREG_APP		0x03
 struct hal_cmd_health_unreg_app {
 	uint16_t app_id;
 } __attribute__((packed));
 
-#define HAL_OP_HEALTH_CONNECT_CHANNEL	0x03
+#define HAL_OP_HEALTH_CONNECT_CHANNEL	0x04
 struct hal_cmd_health_connect_channel {
 	uint16_t app_id;
 	uint8_t  bdaddr[6];
@@ -424,7 +423,7 @@ struct hal_rsp_health_connect_channel {
 	uint16_t  channel_id;
 } __attribute__((packed));
 
-#define HAL_OP_HEALTH_DESTROY_CHANNEL	0x04
+#define HAL_OP_HEALTH_DESTROY_CHANNEL	0x05
 struct hal_cmd_health_destroy_channel {
 	uint16_t channel_id;
 } __attribute__((packed));
-- 
1.8.3.2


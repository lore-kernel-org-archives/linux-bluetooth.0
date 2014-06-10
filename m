Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC_v2 2/6] android/health: Fix MDEP data type is 2 octets
Date: Tue, 10 Jun 2014 16:21:59 +0300
Message-Id: <1402406523-2832-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 2 +-
 android/hal-msg.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 1484399..ae62c10 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1145,7 +1145,7 @@ Commands and responses:
 
 		Command parameters: Application ID (2 octets)
                                     MDEP Role (1 octet)
-		                    Data type (1 octet)
+		                    Data type (2 octets)
 		                    Channel type (1 octet)
 		                    MDEP description length (2 octets)
 		                    MDEP description (MDEP desciption length)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 65cf81f..f053173 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -407,7 +407,7 @@ struct hal_cmd_health_reg_app {
 struct hal_cmd_health_mdep {
 	uint16_t app_id;
 	uint8_t  role;
-	uint8_t  data_type;
+	uint16_t data_type;
 	uint8_t  channel_type;
 	uint16_t descr_len;
 	uint8_t  descr[0];
-- 
1.8.3.2


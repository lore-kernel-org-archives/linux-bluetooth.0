Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/12] android/hal-msg: trivial: Correct coding style
Date: Fri,  4 Jul 2014 16:43:52 +0300
Message-Id: <1404481441-734-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move rsp close to cmd improving readability of the code.
---
 android/hal-msg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index af859c6..7f13e84 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -403,6 +403,10 @@ struct hal_cmd_health_reg_app {
 	uint8_t  data[0];
 } __attribute__((packed));
 
+struct hal_rsp_health_reg_app {
+	uint16_t app_id;
+} __attribute__((packed));
+
 #define HAL_OP_HEALTH_MDEP		0x02
 struct hal_cmd_health_mdep {
 	uint16_t app_id;
@@ -413,10 +417,6 @@ struct hal_cmd_health_mdep {
 	uint8_t  descr[0];
 } __attribute__((packed));
 
-struct hal_rsp_health_reg_app {
-	uint16_t app_id;
-} __attribute__((packed));
-
 #define HAL_OP_HEALTH_UNREG_APP		0x03
 struct hal_cmd_health_unreg_app {
 	uint16_t app_id;
-- 
1.9.1


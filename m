Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 1/5] android: Fix typo in get_remote_services command
Date: Mon, 4 Nov 2013 08:30:30 +0100
Message-ID: <1383550234-14790-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1587ff2..f381862 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -148,8 +148,8 @@ struct hal_cmd_get_remote_service_rec {
 	uint8_t uuid[16];
 } __attribute__((packed));
 
-#define HAL_OP_GET_REMOTE_SERVICE	0x0a
-struct hal_cmd_get_remote_service {
+#define HAL_OP_GET_REMOTE_SERVICES	0x0a
+struct hal_cmd_get_remote_services {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
-- 
1.8.4.1


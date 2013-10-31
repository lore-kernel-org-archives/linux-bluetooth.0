Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 1/5] android: Fix typo in get_remote_services command
Date: Thu, 31 Oct 2013 16:25:48 +0100
Message-ID: <1383233152-15040-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Change-Id: Ia38b82b4b7fdbd6e52389b34e1cdbbcfd098958c
---
 android/hal-msg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8a344d8..c0af083 100644
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


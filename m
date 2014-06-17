Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/hal-msg: Add defines of HAL_AUTHENTICATION values
Date: Tue, 17 Jun 2014 15:31:10 +0200
Message-Id: <1403011871-8354-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1403011871-8354-1-git-send-email-marcin.kraglak@tieto.com>
References: <1403011871-8354-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These values are are used in read characteristic/write characteristic
functions in gatt_client.
---
 android/hal-msg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2c21a85..841f016 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1610,3 +1610,7 @@ struct hal_ev_gatt_server_rsp_confirmation {
 #define HAL_GATT_PERMISSION_WRITE_ENCRYPTED_MITM	0x0040
 #define HAL_GATT_PERMISSION_WRITE_SIGNED		0x0080
 #define HAL_GATT_PERMISSION_WRITE_SIGNED_MITM		0x0100
+
+#define HAL_AUTHENTICATION_NONE		0
+#define HAL_AUTHENTICATION_NO_MITM	1
+#define HAL_AUTHENTICATION_MITM		2
-- 
1.9.3


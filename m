Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/hal-gatt: Define attribute permissions values
Date: Fri, 23 May 2014 15:06:01 +0200
Message-Id: <1400850362-4756-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1400850362-4756-1-git-send-email-marcin.kraglak@tieto.com>
References: <1400850362-4756-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These values are defined in Android and should be used on daemon
side.
---
 android/hal-msg.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 09bd9a0..b68a4c7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1590,3 +1590,12 @@ struct hal_ev_gatt_server_rsp_confirmation {
 	int32_t status;
 	int32_t handle;
 } __attribute__((packed));
+
+#define HAL_GATT_PERMISSION_READ			0x0001
+#define HAL_GATT_PERMISSION_READ_ENCRYPTED		0x0002
+#define HAL_GATT_PERMISSION_READ_ENCRYPTED_MITM		0x0004
+#define HAL_GATT_PERMISSION_WRITE			0x0010
+#define HAL_GATT_PERMISSION_WRITE_ENCRYPTED		0x0020
+#define HAL_GATT_PERMISSION_WRITE_ENCRYPTED_MITM	0x0040
+#define HAL_GATT_PERMISSION_WRITE_SIGNED		0x0080
+#define HAL_GATT_PERMISSION_WRITE_SIGNED_MITM		0x0100
-- 
1.9.0


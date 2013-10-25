Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 11/15] android: Add missing SSP variant definitions to IPC header
Date: Fri, 25 Oct 2013 12:50:07 +0200
Message-ID: <1382698211-9123-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
References: <1382698211-9123-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 352a64c..2a0b670 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -176,6 +176,11 @@ struct hal_cmd_pin_reply {
 	uint8_t pin_code[16];
 } __attribute__((packed));
 
+#define HAL_BT_SSP_VARIANT_CONFIRM	0x00
+#define HAL_BT_SSP_VARIANT_ENTRY	0x01
+#define HAL_BT_SSP_VARIANT_CONSENT	0x02
+#define HAL_BT_SSP_VARIANT_NOTIF	0x03
+
 #define HAL_OP_SSP_REPLY		0x11
 struct hal_cmd_ssp_reply {
 	uint8_t  bdaddr[6];
-- 
1.8.4.1


Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 2/5] android: Update IPC headers to match SSP and PIN requests events
Date: Tue, 29 Oct 2013 12:52:39 +0100
Message-ID: <1383047562-4799-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
References: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Name should be 249 bytes so it is always NULL terminated string.
Class of device is send as uint32. This will allow to make simple
passing of data in HAL library without need of copying data.
---
 android/hal-msg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index a4eb2a8..80b47d6 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -356,15 +356,15 @@ struct hal_ev_discovery_state_changed {
 #define HAL_EV_PIN_REQUEST		0x86
 struct hal_ev_pin_request {
 	uint8_t bdaddr[6];
-	uint8_t name[249 - 1];
-	uint8_t class_of_dev[3];
+	uint8_t name[249];
+	uint32_t class_of_dev;
 } __attribute__((packed));
 
 #define HAL_EV_SSP_REQUEST		0x87
 struct hal_ev_ssp_request {
 	uint8_t  bdaddr[6];
-	uint8_t  name[249 - 1];
-	uint8_t  class_of_dev[3];
+	uint8_t  name[249];
+	uint32_t  class_of_dev;
 	uint8_t  pairing_variant;
 	uint32_t passkey;
 } __attribute__((packed));
-- 
1.8.4.1


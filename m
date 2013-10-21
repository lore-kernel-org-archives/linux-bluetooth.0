Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 05/11] android: Define IPC MTU size
Date: Mon, 21 Oct 2013 20:56:45 +0200
Message-Id: <1382381811-28123-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This defines buffer size big enough to hold the largest possible IPC
message.
---
 android/hal-msg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4440fc8..58fff4d 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -21,6 +21,8 @@
  *
  */
 
+#define BLUEZ_HAL_MTU 1024
+
 static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 
 struct hal_msg_hdr {
-- 
1.8.4


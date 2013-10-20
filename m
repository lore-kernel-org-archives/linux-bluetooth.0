Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/6] android: Define path for HAL communication socket
Date: Sun, 20 Oct 2013 11:53:55 +0200
Message-Id: <1382262838-25725-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
References: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This socket will be used by android daemon and libhal to communitate.
---
 android/hal-msg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4c5ca69..4440fc8 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -21,6 +21,8 @@
  *
  */
 
+static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
+
 struct hal_msg_hdr {
 	uint8_t service_id;
 	uint8_t opcode;
-- 
1.8.4


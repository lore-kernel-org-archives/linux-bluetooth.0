Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] android: Define path for HAL communication socket
Date: Sat, 19 Oct 2013 01:01:39 +0200
Message-Id: <1382137302-17237-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
References: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

This socket will be used by android daemon and libhal to communitate.
---
 android/hal-msg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4c5ca69..2da5e16 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -21,6 +21,8 @@
  *
  */
 
+#define BLUEZ_HAL_SK_PATH "bluez_hal_socket"
+
 struct hal_msg_hdr {
 	uint8_t service_id;
 	uint8_t opcode;
-- 
1.8.4.rc3


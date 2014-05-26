Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] android/README: Update information about GATT HAL support
Date: Mon, 26 May 2014 17:03:47 +0200
Message-Id: <1401116627-28767-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
References: <1401116627-28767-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

test_command appears to be usefull for PTS testing and probably should
be implemented.
---
 android/README | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/README b/android/README
index 91fc545..bcc2e7b 100644
--- a/android/README
+++ b/android/README
@@ -223,7 +223,7 @@ Profile ID    HAL header         Status
 core          bluetooth.h        complete
 a2dp          bt_av.h            complete
 gatt          bt_gatt.h          partial
-              bt_gatt_client.h   partial
+              bt_gatt_client.h   complete
               bt_gatt_server.h   initial
 handsfree     bt_hf.h            complete
 hidhost       bt_hh.h            complete
@@ -293,6 +293,14 @@ get_player_app_values_text_cb      NULL JNI implementation
 set_player_app_value_cb            NULL JNI implementation
 
 
+HAL GATT
+--------
+
+methods:
+client->set_adv_data               missing kernel support for vendor data
+client->test_command               test command
+
+
 Known Android issues
 ====================
 
@@ -324,3 +332,5 @@ HFP		Response and Hold		AT+BTRH, +BTRH
 HFP		In-band Ring Tone		+BSIR
 AVRCP		Player Settings			HAL API present but not used
 AVRCP		Browsing			No HAL API
+GATT		Client read multiple		No HAL API
+		characteristics
-- 
1.9.1


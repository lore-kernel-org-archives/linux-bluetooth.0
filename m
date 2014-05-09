Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 13/13] android/handsfree: Do not make unneeded VOICE ioctl()
Date: Fri,  9 May 2014 12:19:55 +0300
Message-Id: <1399627195-471-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399627195-471-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399627195-471-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/handsfree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index e694503..befaa6f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -930,8 +930,9 @@ static bool connect_sco(void)
 	if (device.sco)
 		return false;
 
-	if ((device.features & HFP_HF_FEAT_CODEC) &&
-				device.negotiated_codec != CODEC_ID_CVSD)
+	if (!(device.features & HFP_HF_FEAT_CODEC))
+		voice_settings = 0;
+	else if (device.negotiated_codec != CODEC_ID_CVSD)
 		voice_settings = BT_VOICE_TRANSPARENT;
 	else
 		voice_settings = BT_VOICE_CVSD_16BIT;
-- 
1.8.3.2


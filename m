Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/4] android/handsfree: Simplify codec selection
Date: Tue,  2 Dec 2014 11:59:39 +0100
Message-Id: <1417517979-18136-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417517979-18136-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Voice settings 0 is legacy, lets use BT_VOICE_CVSD_16BIT instead.
---
 android/handsfree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 29cd498..7987297 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1011,9 +1011,8 @@ static bool connect_sco(struct hf_device *dev)
 {
 	uint16_t voice_settings;
 
-	if (!codec_negotiation_supported(dev))
-		voice_settings = 0;
-	else if (dev->negotiated_codec != CODEC_ID_CVSD)
+	if (codec_negotiation_supported(dev) &&
+			dev->negotiated_codec != CODEC_ID_CVSD)
 		voice_settings = BT_VOICE_TRANSPARENT;
 	else
 		voice_settings = BT_VOICE_CVSD_16BIT;
-- 
1.8.4


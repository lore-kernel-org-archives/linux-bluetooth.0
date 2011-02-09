Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH v2] Fix blutoothd exit on badly formated AT+VTS
Date: Wed,  9 Feb 2011 16:55:46 +0200
Message-Id: <1297263346-29728-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes bluetoothd exit when AT+VTS command is badly formatted,
e.g. as AT+VTS\xfe\xfe[...]=1

Verification it done for the numeric value to be larger than 0x23,
that corresponds to the hash '#', and to be lower than 0x44, that
corresponds to 'D', such that the tone is in {0-9, *, #, A, B, C, D}.
---
 audio/headset.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 0270e2c..bdaa8da 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1015,12 +1015,18 @@ int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err)
 
 static int dtmf_tone(struct audio_device *device, const char *buf)
 {
+	char tone;
+
 	if (strlen(buf) < 8) {
 		error("Too short string for DTMF tone");
 		return -EINVAL;
 	}
 
-	telephony_transmit_dtmf_req(device, buf[7]);
+	tone = buf[7];
+	if (tone >= '#' && tone <= 'D')
+		telephony_transmit_dtmf_req(device, tone);
+	else
+		return -EINVAL;
 
 	return 0;
 }
-- 
1.7.1


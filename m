Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix crash on badly formated AT+VTS command
Date: Mon,  7 Feb 2011 19:07:36 +0200
Message-Id: <1297098456-30695-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes bluetoothd crash when AT+VTS command is badly formatted,
e.g. as AT+VTS\xfe\xfe[...]=1
---
 audio/headset.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 0270e2c..da499d8 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1015,12 +1015,18 @@ int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err)
 
 static int dtmf_tone(struct audio_device *device, const char *buf)
 {
+	char *pch;
+
 	if (strlen(buf) < 8) {
 		error("Too short string for DTMF tone");
 		return -EINVAL;
 	}
 
-	telephony_transmit_dtmf_req(device, buf[7]);
+	pch = strchr(&buf[6],'=');
+	if (pch)
+		telephony_transmit_dtmf_req(device, *(++pch));
+	else
+		return -EINVAL;
 
 	return 0;
 }
-- 
1.7.0.4


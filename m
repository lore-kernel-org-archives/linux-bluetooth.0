Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/2] Add NO CARRIER response to HFP
Date: Mon, 18 Apr 2011 00:29:13 +0300
Message-Id: <1303075754-15375-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HFP is updated by NO CARRIER response accordingly to HFP 1.5 p.68.
---
 audio/headset.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index c605e9d..2e4f6ca 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -687,14 +687,17 @@ static int telephony_generic_rsp(struct audio_device *device, cme_error_t err)
 	struct headset *hs = device->headset;
 	struct headset_slc *slc = hs->slc;
 
-	if (err != CME_ERROR_NONE) {
-		if (slc->cme_enabled)
-			return headset_send(hs, "\r\n+CME ERROR: %d\r\n", err);
-		else
-			return headset_send(hs, "\r\nERROR\r\n");
-	}
+	if ((err != CME_ERROR_NONE) && slc->cme_enabled)
+		return headset_send(hs, "\r\n+CME ERROR: %d\r\n", err);
 
-	return headset_send(hs, "\r\nOK\r\n");
+	switch (err) {
+	case CME_ERROR_NONE:
+		return headset_send(hs, "\r\nOK\r\n");
+	case CME_ERROR_NO_NETWORK_SERVICE:
+		return headset_send(hs, "\r\nNO CARRIER\r\n");
+	default:
+		return headset_send(hs, "\r\nERROR\r\n");
+	}
 }
 
 int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
-- 
1.7.1


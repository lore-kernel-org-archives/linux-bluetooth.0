Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 08/14] android/handsfree-client: Send indicators val we got during SLC setup
Date: Wed, 12 Nov 2014 11:49:31 +0100
Message-Id: <1415789377-20458-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Once SLC is done, Android is ready to get indicators values.
---
 android/handsfree-client.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 97202d5..c710b48 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -859,14 +859,24 @@ static void ciev_cb(struct hfp_context *context, void *user_data)
 
 static void slc_completed(struct device *dev)
 {
+	int i;
+	struct indicator *ag_ind;
+
 	DBG("");
 
+	ag_ind = dev->ag_ind;
+
 	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_SLC_CONNECTED);
 
-	/*
-	 * TODO: Notify Android with indicators, register unsolicited result
-	 * handlers
-	 */
+	/* Notify Android with indicators */
+	for (i = 0; i < HFP_INDICATOR_LAST; i++) {
+		if (!ag_ind[i].cb)
+			continue;
+
+		ag_ind[i].cb(ag_ind[i].val);
+	}
+
+	/* TODO: register unsolicited results handlers */
 
 	hfp_hf_register(dev->hf, bvra_cb, "+BRVA", dev, NULL);
 	hfp_hf_register(dev->hf, vgm_cb, "+VGM", dev, NULL);
@@ -959,6 +969,7 @@ static void set_indicator_value(uint8_t index, unsigned int val,
 			continue;
 
 		ag_ind[i].val = val;
+			ag_ind[i].cb(val);
 		return;
 	}
 }
-- 
1.8.4


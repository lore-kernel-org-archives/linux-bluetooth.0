Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 10/14] android/handsfree-client: Send to AG that we do support long name
Date: Wed, 12 Nov 2014 11:49:33 +0100
Message-Id: <1415789377-20458-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415789377-20458-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 2931c5c..6fe5495 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -938,6 +938,9 @@ static void slc_completed(struct device *dev)
 	hfp_hf_register(dev->hf, clcc_cb, "+CLCC", dev, NULL);
 	hfp_hf_register(dev->hf, ciev_cb, "+CIEV", dev, NULL);
 	hfp_hf_register(dev->hf, cops_cb, "+COPS", dev, NULL);
+
+	if (!hfp_hf_send_command(dev->hf, cmd_complete_cb, NULL, "AT+COPS=3,0"))
+		info("hf-client: Could not send AT+COPS=3,0");
 }
 
 static void slc_chld_cb(struct hfp_context *context, void *user_data)
-- 
1.8.4


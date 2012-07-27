Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 03/11] Bluetooth: Use devm_kzalloc in bluecard_cs.c file
Date: Fri, 27 Jul 2012 12:38:33 +0530
Message-Id: <1343372921-18780-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/bluecard_cs.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index 66c3a67..0c0838d 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -849,7 +849,7 @@ static int bluecard_probe(struct pcmcia_device *link)
 	bluecard_info_t *info;
 
 	/* Create new info device */
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&link->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -864,10 +864,7 @@ static int bluecard_probe(struct pcmcia_device *link)
 
 static void bluecard_detach(struct pcmcia_device *link)
 {
-	bluecard_info_t *info = link->priv;
-
 	bluecard_release(link);
-	kfree(info);
 }
 
 
-- 
1.7.4.1

Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 11/11] Bluetooth: Use devm_kzalloc in dtl1_cs.c file
Date: Fri, 27 Jul 2012 12:38:41 +0530
Message-Id: <1343372921-18780-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/dtl1_cs.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 97a7784..036cb36 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -550,7 +550,7 @@ static int dtl1_probe(struct pcmcia_device *link)
 	dtl1_info_t *info;
 
 	/* Create new info device */
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&link->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -569,7 +569,6 @@ static void dtl1_detach(struct pcmcia_device *link)
 
 	dtl1_close(info);
 	pcmcia_disable_device(link);
-	kfree(info);
 }
 
 static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
-- 
1.7.4.1

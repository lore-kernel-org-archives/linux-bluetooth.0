Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 05/11] Bluetooth: Use devm_kzalloc in bt3c_cs.c file
Date: Fri, 27 Jul 2012 12:38:35 +0530
Message-Id: <1343372921-18780-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/bt3c_cs.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 8925b6d..7ffd3f4 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -638,7 +638,7 @@ static int bt3c_probe(struct pcmcia_device *link)
 	bt3c_info_t *info;
 
 	/* Create new info device */
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(&link->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -654,10 +654,7 @@ static int bt3c_probe(struct pcmcia_device *link)
 
 static void bt3c_detach(struct pcmcia_device *link)
 {
-	bt3c_info_t *info = link->priv;
-
 	bt3c_release(link);
-	kfree(info);
 }
 
 static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
-- 
1.7.4.1

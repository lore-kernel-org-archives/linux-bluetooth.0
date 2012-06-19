Return-Path: <cyrus@holtmann.org>
From: Devendra Naga <devendra.aaru@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Devendra Naga <devendra.aaru@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: cleanup dtl1_config
Date: Tue, 19 Jun 2012 21:51:31 +0530
Message-Id: <1340122891-8611-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/bluetooth/dtl1_cs.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 6e8d961..aedcf4a 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -586,29 +586,31 @@ static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
 static int dtl1_config(struct pcmcia_device *link)
 {
 	dtl1_info_t *info = link->priv;
-	int i;
+	int ret;
 
 	/* Look for a generic full-sized window */
 	link->resource[0]->end = 8;
-	if (pcmcia_loop_config(link, dtl1_confcheck, NULL) < 0)
+	ret = pcmcia_loop_config(link, dtl1_confcheck, NULL);
+	if (ret)
 		goto failed;
 
-	i = pcmcia_request_irq(link, dtl1_interrupt);
-	if (i != 0)
+	ret = pcmcia_request_irq(link, dtl1_interrupt);
+	if (ret)
 		goto failed;
 
-	i = pcmcia_enable_device(link);
-	if (i != 0)
+	ret = pcmcia_enable_device(link);
+	if (ret)
 		goto failed;
 
-	if (dtl1_open(info) != 0)
+	ret = dtl1_open(info);
+	if (ret)
 		goto failed;
 
 	return 0;
 
 failed:
 	dtl1_detach(link);
-	return -ENODEV;
+	return ret;
 }
 
 static const struct pcmcia_device_id dtl1_ids[] = {
-- 
1.7.9.5


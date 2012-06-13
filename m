Return-Path: <cyrus@holtmann.org>
From: Devendra Naga <devendra.aaru@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH] Bluetooth: Cleanup dtl1_config
Date: Thu, 14 Jun 2012 00:12:15 +0530
Message-Id: <1339612935-2851-1-git-send-email-devendra.aaru@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

the functions always return 0 on sucess and -ve error on failure.

This also removes variable i.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/bluetooth/dtl1_cs.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 6e8d961..f532ce2 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -586,22 +586,19 @@ static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
 static int dtl1_config(struct pcmcia_device *link)
 {
 	dtl1_info_t *info = link->priv;
-	int i;
 
 	/* Look for a generic full-sized window */
 	link->resource[0]->end = 8;
 	if (pcmcia_loop_config(link, dtl1_confcheck, NULL) < 0)
 		goto failed;
 
-	i = pcmcia_request_irq(link, dtl1_interrupt);
-	if (i != 0)
+	if (pcmcia_request_irq(link, dtl1_interrupt))
 		goto failed;
 
-	i = pcmcia_enable_device(link);
-	if (i != 0)
+	if (pcmcia_enable_device(link))
 		goto failed;
 
-	if (dtl1_open(info) != 0)
+	if (dtl1_open(info))
 		goto failed;
 
 	return 0;
-- 
1.7.9.5

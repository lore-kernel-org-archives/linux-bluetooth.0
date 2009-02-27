Return-Path: <cyrus@holtmann.org>
From: Philipp Zabel <philipp.zabel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, Dominik Brodowski <linux@dominikbrodowski.net>, Marcel Holtmann <marcel@holtmann.org>, Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] pcmcia: dtl1_cs: fix pcmcia_loop_config logic
Date: Fri, 27 Feb 2009 17:54:08 +0100
Message-Id: <1235753648-10045-1-git-send-email-philipp.zabel@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

pcmcia_loop_config returns 0 on success.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 drivers/bluetooth/dtl1_cs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 901bdd9..e0ee642 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -616,7 +616,7 @@ static int dtl1_config(struct pcmcia_device *link)
 
 	/* Look for a generic full-sized window */
 	link->io.NumPorts1 = 8;
-	if (!pcmcia_loop_config(link, dtl1_confcheck, NULL))
+	if (pcmcia_loop_config(link, dtl1_confcheck, NULL))
 		goto failed;
 
 	i = pcmcia_request_irq(link, &link->irq);
-- 
1.5.6.5

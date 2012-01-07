Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: dtl1: Fix memleak in probe()
Date: Sat,  7 Jan 2012 15:19:41 +0100
Message-Id: <1325945981-11330-5-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325945981-11330-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We currently leak the driver info structure if dtl1_config fails. If we add a
kfree() to dtl1_release to fix this, then dtl1_release and dtl1_detach are
identical so this merges both functions.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/bluetooth/dtl1_cs.c |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index 969bb22..b2db5e9 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -83,9 +83,6 @@ typedef struct dtl1_info_t {
 
 
 static int dtl1_config(struct pcmcia_device *link);
-static void dtl1_release(struct pcmcia_device *link);
-
-static void dtl1_detach(struct pcmcia_device *p_dev);
 
 
 /* Transmit states  */
@@ -579,8 +576,8 @@ static void dtl1_detach(struct pcmcia_device *link)
 {
 	dtl1_info_t *info = link->priv;
 
-	dtl1_release(link);
-
+	dtl1_close(info);
+	pcmcia_disable_device(link);
 	kfree(info);
 }
 
@@ -619,21 +616,10 @@ static int dtl1_config(struct pcmcia_device *link)
 	return 0;
 
 failed:
-	dtl1_release(link);
+	dtl1_detach(link);
 	return -ENODEV;
 }
 
-
-static void dtl1_release(struct pcmcia_device *link)
-{
-	dtl1_info_t *info = link->priv;
-
-	dtl1_close(info);
-
-	pcmcia_disable_device(link);
-}
-
-
 static const struct pcmcia_device_id dtl1_ids[] = {
 	PCMCIA_DEVICE_PROD_ID12("Nokia Mobile Phones", "DTL-1", 0xe1bfdd64, 0xe168480d),
 	PCMCIA_DEVICE_PROD_ID12("Nokia Mobile Phones", "DTL-4", 0xe1bfdd64, 0x9102bc82),
-- 
1.7.8.1

Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E488132110;
	Mon,  3 Jun 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425876; cv=none; b=t0tX9/E330pgkdzJT8hwh+adTmZLuO8KWqln4+iM3LOQOARyFlgxbLWXpPdV7vSUcaQ1Vm+BrnBsY0Pzx1lPSRiWhsMmRfaZ7cUbs+hoBZ4k9+Kmg9osJEUCDt5KubV9jtV6wB6DnPhjF4YZI9UP3VbcRw9jzFsMAp+QysgCAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425876; c=relaxed/simple;
	bh=nMNg8q3S5J9D9ytoDoOy6OuUruVXINyBaiIQVaqduVA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqGQxs0k7riMSQ6qAdoHWdUwnGlRxaWBm8POyTXUEMj4l7JOJRFkP7i54iiPNSRCX1NSjM1UnnLenpiGJDLpmycLU8548R9cLYGDN9x7xM179lkAtljLxjzLEqFkLjKd/PYQQoqJryC3LS+90ausW21tYp8X1HjMTyjVLvKSfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=45L9c8K5; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="45L9c8K5"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8vB-008hAw-2v;
	Mon, 03 Jun 2024 16:44:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Fk7G13HeRimY6DRpUituC/NmHzEEmRRr1a/ukg9SBGM=; b=45L9c8K5xSufwauaZZEQ5Ezfpp
	HQGoHopTEzBWCystnXWBZ9n70yVN3n+eJTT0GIyadQWPti4VspeQ733X6KD06RMHZA5Whwvcs5C8g
	QP+n+LHoUD9icF69QeK79FAQpd/SSLocdOBs+BTImX01eFzsq06AfmKu0QHkApxb15z1nRIoqnbGL
	T22328hYwn30Eb2E9z/Hx13ZYy9JhKcsCuQUMFW/1bpeojfcgUEE9AWB+XtAWARJ6CsTdegYsK80W
	hwQYx0QYYerG0XxALNH8xHvNl/JpHqcqNG+TvSSPoTGmEVh6aDQ530YlXeu75vpbNciq1IDkLu1Ka
	wkGKsJsg==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8vA-002UfX-1K;
	Mon, 03 Jun 2024 16:44:25 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8vB-009DB2-1P;
	Mon, 03 Jun 2024 16:44:25 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	pmenzel@molgen.mpg.de,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [PATCH RFC v3 4/4] gnss: ai2: replace long sleeps by wait for acks
Date: Mon,  3 Jun 2024 16:44:00 +0200
Message-Id: <20240603144400.2195564-5-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603144400.2195564-1-andreas@kemnade.info>
References: <20240603144400.2195564-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously there were long sleeps for everything sent out.
Replace the sleeps by some wait for completion.
Wait times like 60ms are seen.
There are ack packets sent out if requested. Unfortunately
just waiting for them seems not stable, some open()/close()
loop stress-testing brings the communication into complete
disorder. Unfortunately these ack packets arrive before
a complete answer of the command has been received but
apparently after some processing has been done.
Properly declaring expected answers might help but adding
that can only be justified after some wider testing.

So leaving this part of the series as a RFC and base
for future optimzations.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gnss/ai2.c | 111 +++++++++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 39 deletions(-)

diff --git a/drivers/gnss/ai2.c b/drivers/gnss/ai2.c
index 0cc21b64b7c3f..19597ee891881 100644
--- a/drivers/gnss/ai2.c
+++ b/drivers/gnss/ai2.c
@@ -5,6 +5,8 @@
  *
  * Copyright (C) 2024 Andreas Kemnade <andreas@kemnade.info>
  */
+#define DEBUG
+#include <linux/completion.h>
 #include <linux/errno.h>
 #include <linux/gnss.h>
 #include <linux/init.h>
@@ -67,6 +69,16 @@ struct ai2_device {
 	struct device *dev;
 	struct sk_buff *recv_skb;
 	bool recv_esc;
+	/*
+	 * completion for the lower level around
+	 * GPS_CH9_OP_COMPLETED_EVT
+	 * probably more important if we send large
+	 * fragmented packets
+	 */
+	struct completion ch9_complete;
+
+	/* completion for AI2 ack packets */
+	struct completion ai2_ack_complete;
 };
 
 static struct sk_buff *ai2_skb_alloc(unsigned int len, gfp_t how)
@@ -86,6 +98,7 @@ static int ai2_send_frame(struct ai2_device *ai2dev,
 	int len;
 	struct gps_event_hdr *gnssdrv_hdr;
 	struct hci_dev *hdev;
+	int ret;
 
 	if (skb->len >= U16_MAX)
 		return -EINVAL;
@@ -95,13 +108,25 @@ static int ai2_send_frame(struct ai2_device *ai2dev,
 	 * not needed for simple config commands
 	 */
 	len = skb->len;
+	print_hex_dump_bytes("ai2 send frame: ", DUMP_PREFIX_OFFSET, skb->data, skb->len);
+
 	gnssdrv_hdr = skb_push(skb, sizeof(struct gps_event_hdr));
 	gnssdrv_hdr->opcode = GPS_CH9_OP_WRITE;
 	gnssdrv_hdr->plen = __cpu_to_le16(len);
-
 	hci_skb_pkt_type(skb) = GPS_CH9_PKT_NUMBER;
 	hdev = st_get_hci(ai2dev->dev->parent);
-	return hdev->send(hdev, skb);
+	reinit_completion(&ai2dev->ch9_complete);
+
+	ret = hdev->send(hdev, skb);
+	if (ret)
+		return ret;
+
+	if (!wait_for_completion_timeout(&ai2dev->ch9_complete,
+					 msecs_to_jiffies(2000)))
+		return -ETIMEDOUT;
+	dev_dbg(ai2dev->dev, "send finished\n");
+
+	return 0;
 }
 
 static void ai2_put_escaped(struct sk_buff *skb, u8 d)
@@ -150,30 +175,50 @@ static struct sk_buff *ai2_compose_frame(bool request_ack,
 	return skb;
 }
 
-static int ai2_set_receiver_state(struct ai2_device *ai2dev,
-					      uint8_t state)
+static int ai2_compose_send_frame(struct ai2_device *ai2dev,
+				  bool request_ack,
+				  u8 cmd,
+				  const u8 *data,
+				  int len)
 {
-	struct sk_buff *skb = ai2_compose_frame(true, AI2_CMD_RECEIVER_STATE,
-						&state, 1);
+	struct sk_buff *skb = ai2_compose_frame(request_ack, cmd, data, len);
 	if (!skb)
 		return -ENOMEM;
 
+	if (request_ack) {
+		int ret;
+
+		reinit_completion(&ai2dev->ai2_ack_complete);
+
+		ret = ai2_send_frame(ai2dev, skb);
+		if (ret)
+			return ret;
+
+		if (!wait_for_completion_timeout(&ai2dev->ai2_ack_complete,
+						 msecs_to_jiffies(2000)))
+			return -ETIMEDOUT;
+
+		return 0;
+	}
+
 	return ai2_send_frame(ai2dev, skb);
 }
 
+static int ai2_set_receiver_state(struct ai2_device *ai2dev,
+				  uint8_t state)
+{
+	return ai2_compose_send_frame(ai2dev, true, AI2_CMD_RECEIVER_STATE,
+				      &state, 1);
+}
+
 static int ai2_config_nmea_reports(struct ai2_device *ai2dev,
 				   uint8_t mask)
 {
 	u8 buf[4] = {0};
-	struct sk_buff *skb;
 
 	buf[0] = mask;
-	skb = ai2_compose_frame(true, AI2_CMD_CONFIG_NMEA,
-				buf, sizeof(buf));
-	if (!skb)
-		return -ENOMEM;
-
-	return ai2_send_frame(ai2dev, skb);
+	return ai2_compose_send_frame(ai2dev, true, AI2_CMD_CONFIG_NMEA,
+				      buf, sizeof(buf));
 }
 
 /*
@@ -186,22 +231,12 @@ static int gnss_ai2_init(struct ai2_device *ai2dev)
 {
 	int ret;
 	u8 d = 0x01;
-	struct sk_buff *skb = ai2_compose_frame(true, 0xf5, &d, 1);
-
-	if (!skb)
-		return -ENOMEM;
-
-	ret = ai2_send_frame(ai2dev, skb);
+	ret = ai2_compose_send_frame(ai2dev, true, 0xf5, &d, 1);
 	if (ret)
 		return ret;
 
-	msleep(200); /* seen some 60ms response time here, so wait a bit */
 	d = 5;
-	skb = ai2_compose_frame(true, 0xf1, &d, 1);
-	if (!skb)
-		return -ENOMEM;
-
-	return ai2_send_frame(ai2dev, skb);
+	return ai2_compose_send_frame(ai2dev, true, 0xf1, &d, 1);
 }
 
 static int gnss_ai2_open(struct gnss_device *gdev)
@@ -219,18 +254,14 @@ static int gnss_ai2_open(struct gnss_device *gdev)
 	if (ret)
 		goto err;
 
-	/* TODO: find out on what kind of ack we should wait */
-	msleep(50);
 	ret = ai2_set_receiver_state(ai2dev, RECEIVER_STATE_IDLE);
 	if (ret)
 		goto err;
 
-	msleep(100);
 	ret = ai2_config_nmea_reports(ai2dev, NMEA_MASK_ALL);
 	if (ret)
 		goto err;
 
-	msleep(50);
 	ret = ai2_set_receiver_state(ai2dev, RECEIVER_STATE_ON);
 	if (ret)
 		goto err;
@@ -253,13 +284,9 @@ static void gnss_ai2_close(struct gnss_device *gdev)
 {
 	struct ai2_device *ai2dev = gnss_get_drvdata(gdev);
 
-	/* TODO: find out on what kind of ack we should wait */
 	if (!ai2raw) {
-		msleep(50);
 		ai2_set_receiver_state(ai2dev, RECEIVER_STATE_IDLE);
-		msleep(50);
 		ai2_set_receiver_state(ai2dev, RECEIVER_STATE_OFF);
-		msleep(200); /* seen some longer response time here, so wait */
 	}
 
 	mutex_lock(&ai2dev->gdev_mutex);
@@ -344,8 +371,10 @@ static void process_ai2_frame(struct ai2_device *ai2dev)
 	}
 
 	/* reached if byte 1 in the command packet is set to 1 */
-	if (data[1] == AI2_ACK)
+	if (data[1] == AI2_ACK) {
+		complete(&ai2dev->ai2_ack_complete);
 		return;
+	}
 
 	head = skb_pull(ai2dev->recv_skb, 2); /* drop frame start marker */
 	while (head && (ai2dev->recv_skb->len >= 3)) {
@@ -433,11 +462,9 @@ static void gnss_recv_frame(struct device *dev, struct sk_buff *skb)
 	gnss_hdr = (struct gps_event_hdr *)skb->data;
 
 	data = skb_pull(skb, sizeof(*gnss_hdr));
-	/*
-	 * REVISIT: maybe do something with the completed
-	 * event
-	 */
-	if (gnss_hdr->opcode ==	GPS_CH9_OP_READ) {
+
+	switch (gnss_hdr->opcode) {
+	case GPS_CH9_OP_READ:
 		mutex_lock(&ai2dev->gdev_mutex);
 		if (ai2dev->gdev_open) {
 			if (ai2raw)
@@ -449,6 +476,10 @@ static void gnss_recv_frame(struct device *dev, struct sk_buff *skb)
 				"receiving data while chip should be off\n");
 		}
 		mutex_unlock(&ai2dev->gdev_mutex);
+		break;
+	case GPS_CH9_OP_COMPLETED_EVT:
+		complete(&ai2dev->ch9_complete);
+		break;
 	}
 	kfree_skb(skb);
 }
@@ -474,6 +505,8 @@ static int gnss_ai2_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ai2dev);
 	st_set_gnss_recv_func(pdev->dev.parent, gnss_recv_frame);
 	mutex_init(&ai2dev->gdev_mutex);
+	init_completion(&ai2dev->ch9_complete);
+	init_completion(&ai2dev->ai2_ack_complete);
 
 	ret = gnss_register_device(gdev);
 	if (ret)
-- 
2.39.2


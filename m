Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04922C0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 10:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C975B2081D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 10:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C975B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbeKGTuO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:50:14 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:45514 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730832AbeKGTsw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 14:48:52 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 6E4B95FCC3; Wed,  7 Nov 2018 18:13:16 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] Bluetooth: hci_bcm: Handle deferred probing for the clock supply
Date:   Wed,  7 Nov 2018 18:12:58 +0800
Message-Id: <20181107101308.7626-6-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On some systems that actually have the bluetooth controller wired up
with an extra clock signal, it's possible the bluetooth controller
probes before the clock provider. clk_get would return a defer probe
error, which was not handled by this driver.

Handle this properly, so that these systems can work reliably.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a0ceb..0a20ad48b511 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -907,6 +907,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
+	/* Handle deferred probing */
+	if (IS_ERR(dev->clk) && PTR_ERR(dev->clk) == -EPROBE_DEFER)
+		return PTR_ERR(dev->clk);
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.19.1


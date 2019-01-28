Return-Path: <SRS0=xgU7=QE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB45C282C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72FF20989
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690883;
	bh=M/L/KkkVWTaMFTlnaCMwvmp7gOGTNLIncZpVATojgJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SrvYPfGM0X06GL9AuyAoS3wnUzSQgh/qwfYY1+mMErrqls6/RSEnY+oR/o6cAlX3A
	 vdSIG3ctrd2/5TP90zsRdyPSJrexfoaR9FuuK0sKYNzBIa4YJ3NrhOtKJCXpO1QvUC
	 pcTf46uZcSnAiIfrX1fxLu/7/RVTLNleYayvCAt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfA1Pyh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbfA1Pyg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3560B20989;
        Mon, 28 Jan 2019 15:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690876;
        bh=M/L/KkkVWTaMFTlnaCMwvmp7gOGTNLIncZpVATojgJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yZdZOExP4cl5WQOGNgxhSzF5asS3sxWGa9GB8GtfCuqr4cKXg0mcw/5C8u1V2EWkB
         2g3fgvkIjWKAHzoz2fxfmTp1BPJ2ctRjKJfrKPdHbwPV1LUxQ/iWeZsMTAKrSFG9eu
         Oc+USQ7z9eleDdEEYHJL/VrzueENGel586d/OyyM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 220/304] Bluetooth: hci_bcm: Handle deferred probing for the clock supply
Date:   Mon, 28 Jan 2019 10:42:17 -0500
Message-Id: <20190128154341.47195-220-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 28ac03b9ac3f784c2f048a910c8d0a7a87483b66 ]

On some systems that actually have the bluetooth controller wired up
with an extra clock signal, it's possible the bluetooth controller
probes before the clock provider. clk_get would return a defer probe
error, which was not handled by this driver.

Handle this properly, so that these systems can work reliably.

Tested-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_bcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a0ceb..800132369134 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -907,6 +907,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
+	/* Handle deferred probing */
+	if (dev->clk == ERR_PTR(-EPROBE_DEFER))
+		return PTR_ERR(dev->clk);
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.19.1


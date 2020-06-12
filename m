Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E0CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 12:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8A52081A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 12:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MuSnvUoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgFLMPj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:15:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:41949 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFLMPi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 08:15:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591964138; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EoClYSfrCGrpW053Sq3rBKR7kbmultBOqn3icL3Su/k=; b=MuSnvUoZoSDwIeJFg7k7NXIGsKMWOGVUOwLVkWUMkX+yZhS7V2FbJxZzH4GCuqIqE2w+hZtY
 EG2NdV22oBryOdcJPsnVIcW1uFhgFCBstvbVlMiJHSN0z4cy+jr0318jbKfVP2NNGAZlts0m
 gJzBwS4gLjvJxrQz5QgfORMc0tQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ee371e5567385e8e7ef5647 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Jun 2020 12:15:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA23BC43387; Fri, 12 Jun 2020 12:15:32 +0000 (UTC)
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCD4EC433CA;
        Fri, 12 Jun 2020 12:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCD4EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, abhishekpandit@chromium.org,
        rjliao@codeaurora.org, gubbaven@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Request Tx clock vote off only when Tx is pending
Date:   Fri, 12 Jun 2020 17:45:17 +0530
Message-Id: <1591964117-8228-1-git-send-email-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Tx pending flag is set to true when HOST IBS state is AWAKE or
AWAKEING. If IBS state is ASLEEP, then Tx clock is already voted
off. To optimize further directly calling serial_clock_vote()
instead of qca_wq_serial_tx_clock_vote_off(), at this point of
qca_suspend() already data is sent out. No need to wake up hci to
send data.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f3fde99..50f896f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2107,6 +2107,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	if (tx_pending) {
 		serdev_device_wait_until_sent(hu->serdev,
 					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+		serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
 	}
 
 	/* Wait for HCI_IBS_SLEEP_IND sent by device to indicate its Tx is going
@@ -2120,7 +2121,6 @@ static int __maybe_unused qca_suspend(struct device *dev)
 		goto error;
 	}
 
-	qca_wq_serial_tx_clock_vote_off(&qca->ws_tx_vote_off);
 	return 0;
 
 error:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


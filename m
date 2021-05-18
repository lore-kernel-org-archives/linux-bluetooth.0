Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071FDC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 02:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66A4613BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 02:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346238AbhERCSK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 22:18:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:36451 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346161AbhERCSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 22:18:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621304212; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=wXOZDBYYVOrLA+k0DLX8GUA/hjImHWC+dSZy1ah78MY=; b=gyaWrJSieHcd2tVl+sVjQraE7Mgi/s2il4l2ifOHy/uJthpeqdoTpvBWZT98mfUJddGWBXJO
 B+kHpBZNIk6OjfvtYe8AsWOavwTTRLaCCtTuqxvywCmQQoCF9qzxQJTJmvc4nUiyKGB+UTCC
 LZ6nVQVMDn+4t1yPHGCVD/7O1a4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60a32393063320cd13185229 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 May 2021 02:16:51
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 873E8C43217; Tue, 18 May 2021 02:16:50 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2134EC433D3;
        Tue, 18 May 2021 02:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2134EC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org, tjiang@codeaurora.org
Subject: [PATCH v1] Bluetooth: btusb: fix bt fiwmare downloading failure issue for qca btsoc.
Date:   Tue, 18 May 2021 10:16:42 +0800
Message-Id: <1621304202-5675-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tim Jiang <tjiang@codeaurora.org>

This is btsoc timing issue, host add 20ms delay as workaround.

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5245714..b0743db 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4064,6 +4064,7 @@ static int btusb_setup_qca_download_fw(struct hci_dev *hdev,
 
 	sent += size;
 	count -= size;
+	msleep(20);
 
 	while (count) {
 		size = min_t(size_t, count, QCA_DFU_PACKET_LEN);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project


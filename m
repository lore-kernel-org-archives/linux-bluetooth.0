Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA76C47080
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 09:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209FF61287
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 09:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhFAJ7h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:59:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51426 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhFAJ7h (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 05:59:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622541475; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/PSYrftHUrro6s5rqYWOH7iNYkWF+uNpMFpMKJANktE=; b=mJQYpT20+b2OBjOHNzAjsy4V4eCAfiEEdnSpAEtlwi900T4ioitb6v/ZTJwYv+kcLlE3UICP
 paRq7lKDJv2gaSqIFyIVccYLDVBeeQvzgPW3mRAmi+jQGbqvsmeAnJNL/inB7vxxpKTPS/8a
 07BwDtrvfLLQB8pcK9dbsExUjr8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60b6047ff726fa4188e35485 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Jun 2021 09:57:19
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A78C8C4323A; Tue,  1 Jun 2021 09:57:18 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22D90C43217;
        Tue,  1 Jun 2021 09:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22D90C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org, tjiang@codeaurora.org
Subject: [PATCH v3] Bluetooth: btusb: fix bt fiwmare downloading failure issue for qca btsoc.
Date:   Tue,  1 Jun 2021 17:57:10 +0800
Message-Id: <1622541430-17072-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tim Jiang <tjiang@codeaurora.org>

This is btsoc timing issue, after host start to downloading bt firmware,
ep2 need time to switch from function acl to function dfu, so host add
20ms delay as workaround.

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5245714..bd5242f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4065,6 +4065,11 @@ static int btusb_setup_qca_download_fw(struct hci_dev *hdev,
 	sent += size;
 	count -= size;
 
+	/* ep2 need time to switch from function acl to function dfu,
+	 * so we add 20ms delay here.
+	 */
+	msleep(20);
+
 	while (count) {
 		size = min_t(size_t, count, QCA_DFU_PACKET_LEN);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D484FC2BBCF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB2A23A51
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 10:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389055AbgLRKNN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 05:13:13 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:18371 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389031AbgLRKNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 05:13:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608286373; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0qZgHrTtdOiDdGXSAh2oPnUFJwVxOdegk+F5rocDvGQ=; b=QGhznwy8N1CHsBb1ZEG9b0I2t+m09/Jpy+VIFxSQEpFuDy1RejalrWeHjbiW0bDAkSD1AGjU
 NFKGHgv6WNL8ztNsKcK93mUJhEOV9qG85LPmtX4ZXMzn8RcjeiuY196pDAy2EajDM6Y+GEXy
 QIpynYH8YlFcFcbnPspXC79k9WY=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fdc80840564dfefcd862883 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 10:12:20
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6AF32C43462; Fri, 18 Dec 2020 10:12:19 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 092B6C433ED;
        Fri, 18 Dec 2020 10:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 092B6C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org, tjiang@codeaurora.org
Subject: [PATCH v1] Bluetooth: btusb: add shutdown function for wcn6855
Date:   Fri, 18 Dec 2020 18:12:11 +0800
Message-Id: <1608286331-15760-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tim Jiang <tjiang@codeaurora.org>

we should send hci reset command before bt turn off, which can reset bt
firmware status.

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03b83aa91277..139132463a87 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4264,6 +4264,20 @@ static bool btusb_prevent_wake(struct hci_dev *hdev)
 	return !device_may_wakeup(&data->udev->dev);
 }
 
+static int btusb_shutdown_qca(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "HCI reset during shutdown failed");
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -4523,6 +4537,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_QCA_WCN6855) {
 		data->setup_on_usb = btusb_setup_qca;
+		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
 		hdev->cmd_timeout = btusb_qca_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project


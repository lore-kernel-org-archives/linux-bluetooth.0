Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB594C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 15:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA10613F0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 15:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhEAPFs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 May 2021 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhEAPFr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 May 2021 11:05:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC0CC06174A;
        Sat,  1 May 2021 08:04:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l22so1610147ljc.9;
        Sat, 01 May 2021 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mf/H2xj+zflf+YaL54FKklUQahHRX1dyDemWMHhs3v4=;
        b=vM9gpUh1nSEnhQ+KSB+C96fyyyKdfnosujRityuYC0foXKl1UEDHZZ35nKY8MHfZDJ
         TkJu+2dDjyPFvqWkl8AXpBuAwoHsVLL4FPdCf+VWsxGdEiNxzSMsMtr7agGYWaBifH5T
         sM5O1rRksM8+O9WliOObH8oQz3DlvxuJolS4XGTXC9n25uNwvkC7atQ4g5OZ6jtfNQY4
         gp+hSxxXumDiCkOeZ9HfmkXehh/II9/Gui+Xv8xQTm2QgANR1OW72FsV88RtxGhu7qyR
         7UsL7E/srW8Y0/6rtWWSJOo2KepDkvCpmZ1CEirtH02F00KPKkE2ZXDkGt/MHjYdjx5p
         iqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mf/H2xj+zflf+YaL54FKklUQahHRX1dyDemWMHhs3v4=;
        b=pHqb1vym+u+v8gcYB4XyHnZCJsy7MtQ9JFXeCMkMNJyJh5YrpQs7uJuwPzrT8wgY0z
         PZIUkd1Ja/W0n59fV3aUKrm9UybK+sjcN0VGIzaNOTnInmkb4DXeS4io4Kb4pn8/I4BV
         wTHw840+g2ToqO+PZs4fiF2FJ0JBmyx1LQNPj2eDoHnaqWSfQ7LdZsI9xeWqKPmVxqSN
         UM49v31ww9D0NQ/ilz3elIampY+6F32381ihAB7v+a3vcWqTvEArlTBpLFaleaCBqsRG
         tF/YGPnvvUJTYGZeMZ4QRVEp9IIGuKOJ9Vf2ptqhsm0o4vwNNEgNajXD8tuQtMCsoXix
         MXjg==
X-Gm-Message-State: AOAM532iquLRgv5KoVz+ASy4hCLRWM4TVrWAaXlpT8J2a/A9OIpclUTA
        wq8ZYg/9E055C+Etve6rFXU2r/erF8i4Kg==
X-Google-Smtp-Source: ABdhPJypu1oYdCdyikUBFguR96Xj4xOO23e8b8lIjgTX0Revw1tCAulGcBqvGrynXoK13NrsqjvJpg==
X-Received: by 2002:a2e:9f07:: with SMTP id u7mr7295566ljk.423.1619881496223;
        Sat, 01 May 2021 08:04:56 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id j10sm592999lfb.176.2021.05.01.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 08:04:55 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] bluetooth: fix potential gfp
Date:   Sat,  1 May 2021 18:04:45 +0300
Message-Id: <20210501150445.4055-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In qca_power_shutdown() qcadev local variable is
initialized by hu->serdev.dev private data, but
hu->serdev can be NULL and there is a check for it.

Since, qcadev is not used before

	if (!hu->serdev)
		return;

we can move its initialization after this "if" to
prevent gfp.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index de36af63e182..9589ef6c0c26 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1820,8 +1820,6 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	unsigned long flags;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 
-	qcadev = serdev_device_get_drvdata(hu->serdev);
-
 	/* From this point we go into power off state. But serial port is
 	 * still open, stop queueing the IBS data and flush all the buffered
 	 * data in skb's.
@@ -1837,6 +1835,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	if (!hu->serdev)
 		return;
 
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+
 	if (qca_is_wcn399x(soc_type)) {
 		host_set_baudrate(hu, 2400);
 		qca_send_power_pulse(hu, false);
-- 
2.31.1


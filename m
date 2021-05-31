Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FA3C47083
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD398613D1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 14:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhEaOQD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 May 2021 10:16:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3481 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhEaOMe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 May 2021 10:12:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ftxvr5YkNzYqm4;
        Mon, 31 May 2021 22:08:08 +0800 (CST)
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 22:10:51 +0800
Received: from huawei.com (10.90.53.225) by dggema755-chm.china.huawei.com
 (10.1.198.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 22:10:51 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH -next] Bluetooth: btmtkuart: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 31 May 2021 22:24:49 +0800
Message-ID: <20210531142450.30779-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema755-chm.china.huawei.com (10.1.198.197)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/bluetooth/btmtkuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 6c40bc75fb5b..e9d91d7c0db4 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -581,11 +581,9 @@ static int btmtkuart_open(struct hci_dev *hdev)
 
 	/* Enable the power domain and clock the device requires */
 	pm_runtime_enable(dev);
-	err = pm_runtime_get_sync(dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(dev);
+	err = pm_runtime_resume_and_get(dev);
+	if (err < 0)
 		goto err_disable_rpm;
-	}
 
 	err = clk_prepare_enable(bdev->clk);
 	if (err < 0)
-- 
2.17.1


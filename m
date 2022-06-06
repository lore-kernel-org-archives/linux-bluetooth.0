Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA2C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jun 2022 13:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbiFFNhc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jun 2022 09:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiFFNha (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jun 2022 09:37:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F1FF3;
        Mon,  6 Jun 2022 06:37:29 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LGvdj6G9czjXLs;
        Mon,  6 Jun 2022 21:36:09 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 21:37:27 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 21:37:27 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>
CC:     <marcel@holtmann.org>, <abhishekpandit@chromium.org>
Subject: [PATCH -next] Bluetooth: hci_core: Fix error return code in hci_register_dev()
Date:   Mon, 6 Jun 2022 21:48:07 +0800
Message-ID: <20220606134807.4102807-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If hci_register_suspend_notifier() fails, it should return error
code in hci_register_dev().

Fixes: d6bb2a91f95b ("Bluetooth: Unregister suspend with userchannel")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a4b4b3b927f2..dbddf891a4a9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2646,7 +2646,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	hci_sock_dev_event(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
 
-	if (hci_register_suspend_notifier(hdev))
+	error = hci_register_suspend_notifier(hdev);
+	if (error)
 		goto err_wqueue;
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
-- 
2.25.1


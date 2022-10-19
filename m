Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF46C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 08:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJSIHf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 04:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSIHd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 04:07:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB067074
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 01:07:31 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Msjrs16QSzVhwT;
        Wed, 19 Oct 2022 16:02:53 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:07:30 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 16:07:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH v2] Bluetooth: hci_core: fix error handling in hci_register_dev()
Date:   Wed, 19 Oct 2022 16:06:52 +0800
Message-ID: <20221019080652.836484-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If hci_register_suspend_notifier() returns error, the hdev
need to be put and deleted and rfkill need be unregistered
and destroyed to avoid leaks.

Fixes: 9952d90ea288 ("Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Add rfkill_destroy().
---
 net/bluetooth/hci_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0540555b3704..a6222238de7f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2660,7 +2660,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	error = hci_register_suspend_notifier(hdev);
 	if (error)
-		goto err_wqueue;
+		goto err_hdev;
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
 
@@ -2669,6 +2669,14 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	return id;
 
+err_hdev:
+	hci_dev_put(hdev);
+	if (hdev->rfkill) {
+		rfkill_unregister(hdev->rfkill);
+		rfkill_destroy(hdev->rfkill);
+		hdev->rfkill = NULL;
+	}
+	device_del(&hdev->dev);
 err_wqueue:
 	debugfs_remove_recursive(hdev->debugfs);
 	destroy_workqueue(hdev->workqueue);
-- 
2.25.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05165C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Oct 2022 02:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiJTCSO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 22:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJTCSN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 22:18:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50403170DDC
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 19:18:11 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtB3865sqzmVGB;
        Thu, 20 Oct 2022 10:13:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 10:17:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:17:38 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH v3] Bluetooth: hci_core: fix error handling in hci_register_dev()
Date:   Thu, 20 Oct 2022 10:16:56 +0800
Message-ID: <20221020021656.2092938-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If hci_register_suspend_notifier() returns error, the hdev and rfkill
are leaked. We could disregard the error and print a warning message
instead to avoid leaks, as it just means we won't be handing suspend
requests.

Fixes: 9952d90ea288 ("Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v2 -> v3:
  print a warning message instead of goto err

v1 -> v2:
  Add rfkill_destroy().
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0540555b3704..9d9fb3dff22a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2660,7 +2660,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	error = hci_register_suspend_notifier(hdev);
 	if (error)
-		goto err_wqueue;
+		BT_WARN("register suspend notifier failed error:%d\n", error);
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
 
-- 
2.25.1


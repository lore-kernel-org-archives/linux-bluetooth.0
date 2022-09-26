Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB18FC6FA83
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 09:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiIZJZn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 05:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiIZJYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 05:24:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62EA40E08;
        Mon, 26 Sep 2022 02:23:52 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbcfD0qrxzWh9X;
        Mon, 26 Sep 2022 17:19:48 +0800 (CST)
Received: from huawei.com (10.67.175.83) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 17:23:50 +0800
From:   ruanjinjie <ruanjinjie@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] Bluetooth: btrsi: Add __init/__exit annotations to module init/exit funcs
Date:   Mon, 26 Sep 2022 17:20:02 +0800
Message-ID: <20220926092002.1191313-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add missing __init/__exit annotations to module init/exit funcs

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
---
 drivers/bluetooth/btrsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
index 634cf8f5ed2d..1d9a04badd3c 100644
--- a/drivers/bluetooth/btrsi.c
+++ b/drivers/bluetooth/btrsi.c
@@ -179,12 +179,12 @@ const struct rsi_mod_ops rsi_bt_ops = {
 };
 EXPORT_SYMBOL(rsi_bt_ops);
 
-static int rsi_91x_bt_module_init(void)
+static int __init rsi_91x_bt_module_init(void)
 {
 	return 0;
 }
 
-static void rsi_91x_bt_module_exit(void)
+static void __exit rsi_91x_bt_module_exit(void)
 {
 	return;
 }
-- 
2.25.1


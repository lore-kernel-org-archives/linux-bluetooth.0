Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB7ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Sep 2022 15:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiIFP0X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbiIFP0B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Sep 2022 11:26:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0DBFC54;
        Tue,  6 Sep 2022 07:37:25 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MMSX93cNPz1P6mT;
        Tue,  6 Sep 2022 22:32:25 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 6 Sep
 2022 22:36:12 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
Subject: [PATCH -next] Bluetooth: btbcm: add missing of_node_put() in btbcm_get_board_name()
Date:   Tue, 6 Sep 2022 14:34:12 +0000
Message-ID: <20220906143412.123134-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

After using 'root' returned by of_find_node_by_path(), of_node_put()
need be called to decrease the refcount.

Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/bluetooth/btbcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 3006e2a0f37e..a85f3c62b08a 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -504,8 +504,10 @@ static const char *btbcm_get_board_name(struct device *dev)
 	if (!root)
 		return NULL;

-	if (of_property_read_string_index(root, "compatible", 0, &tmp))
+	if (of_property_read_string_index(root, "compatible", 0, &tmp)) {
+		of_node_put(root);
 		return NULL;
+	}

 	/* get rid of any '/' in the compatible string */
 	len = strlen(tmp) + 1;
--
2.17.1


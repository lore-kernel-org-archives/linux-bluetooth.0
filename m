Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB14C27C7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbjHQJgi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349721AbjHQJgH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 05:36:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4563A8E;
        Thu, 17 Aug 2023 02:35:41 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RRKWp1vJtz67ngg;
        Thu, 17 Aug 2023 17:31:34 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 10:35:33 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <seema.sreemantha@intel.com>, <kiran.k@intel.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
Subject: [PATCH] Bluetooth: btintel: fix dereference after free in btintel_ppag_callback()
Date:   Thu, 17 Aug 2023 17:35:28 +0800
Message-ID: <20230817093528.687571-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100001.china.huawei.com (7.188.26.227) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

'buffer.pointer' is freed and then dereferenced via 'p' pointer at
'bt_dev_warn' function call.

Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d9349ba48..4ac1eba9c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1340,11 +1340,11 @@ static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data
 	p = buffer.pointer;
 	ppag = (struct btintel_ppag *)data;
 
 	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
-		kfree(buffer.pointer);
 		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or package count: %d",
 			    p->type, p->package.count);
+		kfree(buffer.pointer);
 		ppag->status = AE_ERROR;
 		return AE_ERROR;
 	}
 
-- 
2.34.1


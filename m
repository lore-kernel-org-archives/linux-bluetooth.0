Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E8C47089
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 13:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiLEN4J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 08:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiLEN4I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 08:56:08 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C290A257;
        Mon,  5 Dec 2022 05:56:06 -0800 (PST)
Received: from dggpemm500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NQlMw6TZ2zqSt9;
        Mon,  5 Dec 2022 21:51:56 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 21:56:04 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <liwei391@huawei.com>, <marcel@holtmann.org>,
        <luiz.dentz@gmail.com>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bobo.shaobowang@huawei.com>
Subject: [PATCH] Bluetooth: btintel: Fix missing free skb in btintel_setup_combined()
Date:   Mon, 5 Dec 2022 21:53:57 +0800
Message-ID: <20221205135357.3961836-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

skb allocated by __hci_cmd_sync would not be used whether in checking
for supported iBT hardware variants or after, we should free it in all
error branches, this patch makes the case read version failed or default
error case free skb before return.

Fixes: c86c7285bb08 ("Bluetooth: btintel: Fix the legacy bootloader returns tlv based version")
Fixes: 019a1caa7fd2 ("Bluetooth: btintel: Refactoring setup routine for bootloader devices")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/bluetooth/btintel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..f6b4b7a1be4c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2524,7 +2524,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		err = btintel_read_version(hdev, &ver);
 		if (err)
-			return err;
+			break;
 
 		/* Apply the device specific HCI quirks
 		 *
@@ -2566,7 +2566,8 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
 			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
-		return -EINVAL;
+		err = -EINVAL;
+		break;
 	}
 
 exit_error:
-- 
2.25.1


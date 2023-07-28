Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF8C001DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 03:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjG1Da3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 23:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjG1DaZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 23:30:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B54B2703;
        Thu, 27 Jul 2023 20:30:23 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBtR92XyhzrRrZ;
        Fri, 28 Jul 2023 11:29:25 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:30:20 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <yuehaibing@huawei.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 -next] Bluetooth: Remove unused declaration amp_read_loc_info()
Date:   Fri, 28 Jul 2023 11:30:11 +0800
Message-ID: <20230728033011.12096-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")
and never be implemented. 

Fixes: 903e45411099 ("Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v3: Add Fixes tag
v2: fix SOB and update commit log
---
 net/bluetooth/amp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
index 832764dfbfb3..97c87abd129f 100644
--- a/net/bluetooth/amp.h
+++ b/net/bluetooth/amp.h
@@ -28,7 +28,6 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 
 int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
 
-void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
 void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
 void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
-- 
2.34.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F825C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 01:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07EE64F41
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 01:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhBDBNx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 20:13:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12018 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhBDBNw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 20:13:52 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWL9f17CqzjJlD;
        Thu,  4 Feb 2021 09:11:50 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 09:12:58 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <matthias.bgg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] Bluetooth: btusb: remove set but not used variable in btusb_mtk_setup_firmware_79xx
Date:   Thu, 4 Feb 2021 09:18:56 +0800
Message-ID: <20210204011856.3685334-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix follow warning:
drivers/bluetooth/btusb.c:3479:9: warning: variable ‘fw_size’ set but not used [-Wunused-but-set-variable]
  size_t fw_size;
         ^~~~~~~
drivers/bluetooth/btusb.c:3473:29: warning: variable ‘patchhdr’ set but not used [-Wunused-but-set-variable]
  struct btmtk_patch_header *patchhdr = NULL;
                             ^~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/bluetooth/btusb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index eeafb8432c0f..9609b6cbf20f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3470,13 +3470,11 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 static int btusb_mtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname)
 {
 	struct btmtk_hci_wmt_params wmt_params;
-	struct btmtk_patch_header *patchhdr = NULL;
 	struct btmtk_global_desc *globaldesc = NULL;
 	struct btmtk_section_map *sectionmap;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	const u8 *fw_bin_ptr;
-	size_t fw_size;
 	int err, dlen, i, status;
 	u8 flag, first_block, retry;
 	u32 section_num, dl_size, section_offset;
@@ -3490,8 +3488,6 @@ static int btusb_mtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwnam
 
 	fw_ptr = fw->data;
 	fw_bin_ptr = fw_ptr;
-	fw_size = fw->size;
-	patchhdr = (struct btmtk_patch_header *)fw_ptr;
 	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
 	section_num = globaldesc->section_num;
 
-- 
2.25.4


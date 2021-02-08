Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6383CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 05:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174CE64E61
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 05:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhBHFES (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 00:04:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43729 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhBHFEN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 00:04:13 -0500
Received: from [123.112.66.2] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1l8yht-0004VC-CR; Mon, 08 Feb 2021 05:03:30 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        rjliao@codeaurora.org
Subject: [PATCH] Bluetooth: btusb: Some Qualcomm Bluetooth adapters stop working
Date:   Mon,  8 Feb 2021 13:02:37 +0800
Message-Id: <20210208050237.42179-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This issue starts from linux-5.10-rc1, I reproduced this issue on my
Dell Inspiron 7447 with BT adapter 0cf3:e005, the kernel will print
out: "Bluetooth: hci0: don't support firmware rome 0x31010000", and
someone else also reported the similar issue to bugzilla #211571.

I found this is a regression introduced by 'commit b40f58b97386
("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855 support"), the
patch assumed that if high ROM version is not zero, it is an adapter
on WCN6855, but many old adapters don't need to load rampatch or nvm,
and they have non-zero high ROM version.

To fix it, let the driver match the rom_version in the
qca_devices_table first, if there is no entry matched, check the
high ROM version, if it is not zero, we assume this adapter is ready
to work and no need to load rampatch and nvm like previously.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=211571
Fixes: b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855 support")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2164a4cd47ad..79ec73e3d321 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4123,6 +4123,13 @@ static int btusb_setup_qca(struct hci_dev *hdev)
 			info = &qca_devices_table[i];
 	}
 	if (!info) {
+		/* If the rom_version is not matched in the qca_devices_table
+		 * and the high ROM version is not zero, we assume this chip no
+		 * need to load the rampatch and nvm.
+		 */
+		if (ver_rom & ~0xffffU)
+			return 0;
+
 		bt_dev_err(hdev, "don't support firmware rome 0x%x", ver_rom);
 		return -ENODEV;
 	}
-- 
2.25.1


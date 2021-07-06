Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5ADC11F80
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E635561ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbhGFL2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jul 2021 07:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233204AbhGFLXf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jul 2021 07:23:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A30961CF0;
        Tue,  6 Jul 2021 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570291;
        bh=1BuftYxYlodzTTWsccJ8mb6qMW4RWaRgd+qRmstKHp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGEgwba3Va+gk81pNqR13zE49FwsrLkacowwel5I7JpU2pfiM2hTuC3yJo5YMTKmR
         xNgaQOc091BYdw5AubERb8VqArvkk7xgIVNaynOeu/48YASd7d3CBhP3Z+boClEbS5
         FNkuTYvYg9d7vcuhrYPcZkH7Aq3M6KB3IIDWEaXC8BUwHvJUc38RcSu+xWubWe0c0Y
         GA4tNkYQFBTMfyv9NarquvS6+hMCtkdIJxicxrBBh8cfvdFa4IDP+fmVEC4f/lqhbz
         N5RMoBi3i1KwaCS85URSylmHjZ6P6bH5Sks7wtxG6N6+NvSCC9BzmZlC/wTc8CLHEv
         /WkRDBVFGHbaQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tim Jiang <tjiang@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 180/189] Bluetooth: btusb: use default nvm if boardID is 0 for wcn6855.
Date:   Tue,  6 Jul 2021 07:14:00 -0400
Message-Id: <20210706111409.2058071-180-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tim Jiang <tjiang@codeaurora.org>

[ Upstream commit ca17a5cccf8b6d35dab4729bea8f4350bc0b4caf ]

if boardID is 0, will use the default nvm file without surfix.

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4c18a85a1070..1cec9b2353c6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4163,9 +4163,15 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
 	int err;
 
 	if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
-		snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
-			 le32_to_cpu(ver->rom_version),
-			 le16_to_cpu(ver->board_id));
+		/* if boardid equal 0, use default nvm without surfix */
+		if (le16_to_cpu(ver->board_id) == 0x0) {
+			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
+				 le32_to_cpu(ver->rom_version));
+		} else {
+			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
+				le32_to_cpu(ver->rom_version),
+				le16_to_cpu(ver->board_id));
+		}
 	} else {
 		snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
 			 le32_to_cpu(ver->rom_version));
-- 
2.30.2


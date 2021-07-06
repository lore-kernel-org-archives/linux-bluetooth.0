Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB4C11F69
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A4B608FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jul 2021 11:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhGFLeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jul 2021 07:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235731AbhGFLaW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jul 2021 07:30:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B274D61DDE;
        Tue,  6 Jul 2021 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570507;
        bh=2Kz9zqhvZs7yyv5qURt+mojxP6fondb6dFl4+uvaN0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQrByJejdUazu34py2MYVgxppW0I0R7sWXQxVXab+S2zoNZuIPEeUVdGIwyHFeYCg
         LSyDGPUe7RfrciZKmu2pJDfCCZkW/KGUt0RCO6P7RZJ0mlsB3+leomAXcw3HmeyVq8
         pmb3VWvCHqeQl3DiRUacKf6Z6kyP9uuJwEReMjtOyVyBibqbJAX7w8Y2aIeKe8zmwr
         SuRlEnToXV84I/cCFBgXQt+yg3OmwWtWlVF2EAxUnYjuznXPVDdDYbZv62hs2ybM8S
         SIN7ivZAA1+AkTqdi3zmJZNobsHaGrgHpFCOsrB+AOFZz8chAXeLlEpcoQTXOC/KPN
         kHMdFTe1M5Zpw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hilda Wu <hildawu@realtek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 149/160] Bluetooth: btusb: Add support USB ALT 3 for WBS
Date:   Tue,  6 Jul 2021 07:18:15 -0400
Message-Id: <20210706111827.2060499-149-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111827.2060499-1-sashal@kernel.org>
References: <20210706111827.2060499-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

[ Upstream commit e848dbd364aca44c9d23c04bef964fab79e2b34f ]

Because mSBC frames do not need to be aligned to the SCO packet
boundary. Using USB ALT 3 let HCI payload >= 60 bytes, let mSBC
data satisfy 60 Bytes avoid payload unaligned situation and fixed
some headset no voise issue.

USB Alt 3 supported also need HFP support transparent MTU in 72 Bytes.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 12f05093c46d..ec17772defc2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1749,6 +1749,13 @@ static void btusb_work(struct work_struct *work)
 			 * which work with WBS at all.
 			 */
 			new_alts = btusb_find_altsetting(data, 6) ? 6 : 1;
+			/* Because mSBC frames do not need to be aligned to the
+			 * SCO packet boundary. If support the Alt 3, use the
+			 * Alt 3 for HCI payload >= 60 Bytes let air packet
+			 * data satisfy 60 bytes.
+			 */
+			if (new_alts == 1 && btusb_find_altsetting(data, 3))
+				new_alts = 3;
 		}
 
 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
-- 
2.30.2


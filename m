Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9944BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 12:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B516115B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 12:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354570AbhIIMrc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 08:47:32 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:55346
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354087AbhIIMgx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 08:36:53 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DD42D3F236;
        Thu,  9 Sep 2021 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631190942;
        bh=FqEPgbVip3uJ9vLzL9gy1Fy4mq+BOs8Bf6pvkaNj/h0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=S9bSkDgZD/m1C2u56+xlFAItzob/UkO3PvI2JbDZ+QNu719DriTryZlE3sXgFmjwT
         fBWE2jiTGWPcO8W/Z/ai8NCga9Ewiv5hL9mZMOfUnpJjuMqxnEj+2r8e1YK70ll2J9
         0KA7d900zxtaUlE1CNnfAskmAZdh/c1UZXrr2gjli4+Yuma+fXnL+wlK0C4pOIFZUl
         Tsm82TKqFhF0uPsnlL+xLgenq6PIiNr8OEsoTxKLFz1XiIFDt2St61gVXnrtWpEarB
         N5S1sRTzJ/CYOZoiYnh8d8sgRw1M/DRc3C35+IrppqX8KWM4HSRXmCRHhkXEID9XzT
         EviXagULtL5ig==
From:   Colin King <colin.king@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Kiran K <kiran.k@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Fix incorrect out of memory check
Date:   Thu,  9 Sep 2021 13:35:41 +0100
Message-Id: <20210909123541.34779-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently *ven_data is being assigned the return from a kmalloc call but
the out-of-memory check is checking ven_data and not *ven_data. Fix this
by adding the missing dereference * operator,

Addresses-Coverity: ("Dereference null return")
Fixes: 70dd978952bc ("Bluetooth: btintel: Define a callback to fetch codec config data")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 115bb2d07a8d..9359bff47296 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2176,7 +2176,7 @@ static int btintel_get_codec_config_data(struct hci_dev *hdev,
 	}
 
 	*ven_data = kmalloc(sizeof(__u8), GFP_KERNEL);
-	if (!ven_data) {
+	if (!*ven_data) {
 		err = -ENOMEM;
 		goto error;
 	}
-- 
2.32.0


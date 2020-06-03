Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA02C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6071720738
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNnwPTbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgFCRO3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgFCRO2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D36C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so1034192plr.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6CBbZ9r4eSiZUUGFyvEEYED4UFptLRNF6sdTCpICb7Q=;
        b=kNnwPTbkTH46n95zn6hqziBPVM9wJFJVDrlvB+FxTPIyAc9TOVwb+UNRfGqNMV2QIU
         CncI3fX2YD6bTDnXllyfK6l1io5jNo3NppNCdphijC8YuzAbFNyfDzYfylygKasCa/Pb
         zYnFH2aTwlfIQUD24EmQJkRm1I0JvXYrpgUt1KKlZqi4eFdZF4HUtAfJlVdWX8xHRjSh
         zkcrnsfTWw/w2wYDlVmBGi8aXdtaLpNLh0ExGot+5Rzlm8Mwwafcl2j8+9PIdpnWc+sN
         DhVOZYKINf1K1NDpXkfTZeTNEf0P+oqaq6qgrhdNhOOgi8CwmEJ+ltTTZGAIfDZpDZvN
         OXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6CBbZ9r4eSiZUUGFyvEEYED4UFptLRNF6sdTCpICb7Q=;
        b=VCipTPZgMzQbHw7dVSYLLVwevfXXC+Rh7Za6PidvnONORVVaYYa1w88k+js5+BcMDt
         TbW+V7eV9OoT1chZUBpOCnOzb29JpY90vo/5SPTNmP++poH9g4qtpgwkrNCOytlGWf/2
         7kH5FOxKZ7dzSH97VC6ymK6nkv/w7jldJLwcXQUg5C5vNruVhUT4OHWOq1Vmz3Q/xnEt
         oQNIvT4CnckiGP0utPi3F69BUyBSs0f1bWWRWNDe/Vd5I6SBGxj2vs3ngrtxulcdWCgP
         ckWchN8E6Ze0xn0XXCsxei1lxhBnG7pLJdm4BMlO0sTL7775SpqW5HG2wU80HeF46l0c
         j8kQ==
X-Gm-Message-State: AOAM53383vNsM/Dy6iI+blPaVF2mMF1xjMn1cP/tEhoKASm21IRFmVV0
        DMgU8jAyIodbbPpPmRnqOIvNPNabNYs=
X-Google-Smtp-Source: ABdhPJzEoahzou9bcXCE8PRgshFSFajcc0GSz9qsT5E2PhEjJHvjcFK9WPTQNEo+srKK/gKmRzGP/Q==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr819735pll.281.1591204467230;
        Wed, 03 Jun 2020 10:14:27 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:26 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 5/7] Bluetooth: Let controller creates RPA during le create conn
Date:   Wed,  3 Jun 2020 22:47:11 +0530
Message-Id: <20200603171713.9882-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When address resolution is enabled and set_privacy is enabled let's
use own address type as 0x03

Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
---
 net/bluetooth/hci_request.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index bcd64dec9989..6e1036cc8b1e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2183,7 +2183,13 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	if (use_rpa) {
 		int to;
 
-		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		/* If Controller supports LL Privacy use own address type is
+		 * 0x03
+		 */
+		if (use_ll_privacy(hdev))
+			*own_addr_type = ADDR_LE_DEV_RANDOM_RESOLVED;
+		else
+			*own_addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (!hci_dev_test_and_clear_flag(hdev, HCI_RPA_EXPIRED) &&
 		    !bacmp(&hdev->random_addr, &hdev->rpa))
-- 
2.17.1


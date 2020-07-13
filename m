Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23114C433E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039D42075F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBQNpsxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgGMGIt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGIt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72626C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so5525690pfn.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nCVTz/TW1C8kDWW89hWnxqM0hLVoG7bmfidmPtnLD50=;
        b=GBQNpsxHWzus4iheWeS6lUiRhY4S92H+Qhv+rsw/+d2OrsJcTor9RmgbSXLwwfaytM
         kaKiuadUNhQS2YFRJWV7n5pin7xM5GlNrYXNP/fTJEzKfsLt2BO86GnfoUZptuEfi1gu
         NE8htptB+Q6h8QjHIVq92I0PcT7WjouvoyU1wKVoh6ZUf5hJxgO2i0seP0Pckxb38rPo
         umckJzxaCwf/AUoHGPykj65MgYS2zKI7uYrF8eEdQYg7GFLJauT1UcQFx2/Qo+IsVeno
         6R/gqG2UUFtHsVkRug9R2DpgXs/OfQaDSrrCj6ONSFj5uFdPfGYubQMODAcqZZbm9710
         B5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nCVTz/TW1C8kDWW89hWnxqM0hLVoG7bmfidmPtnLD50=;
        b=j6Tdy5C2uPP66ZFJnwDeWYloeYbV9bYX9nbJBR1/sP8dVSdf7neI4hwl7jYgwLwzPX
         BHDUsdKoNfEQlsTamjW95OgV2fS0G/r0x+4Blm6GfaFomIeJOTxXuX2imgHjhZjzCrFP
         PWwhzi1dlxqLtrUQAwfi2NmS9KDN8De6R61zW8F5N4t8lUMy6+mxDJgGPsfnvb4gxx4f
         qMDXw1Xhmzv6kRcci6KO9HgbhuTpwcG7kyL8s8X/qLMrx7CRlbv4kmpNeIaJUyCaNu3s
         KHR0nLkwKP5pbFkkak969g7AkEBQBl6V2tJPvXvheybP2j1CrsqAafQ6Ci+ij1D0CA7t
         fmtw==
X-Gm-Message-State: AOAM5320YcXWnWXyPjLqkv07J+pbFtyx6/8b1dQcyHUGPaESJBYB3YAe
        RgkT3c4e9sDNnXCwhNiHgdmi2FXmsy3J1Q==
X-Google-Smtp-Source: ABdhPJwl3t7rbzBeWndSz7LewxAbB+WZaDknkJGrAGoZQkxaRQ4+Gftkk/MD3qzFtLqu/4r8KPZObA==
X-Received: by 2002:a63:2241:: with SMTP id t1mr66885154pgm.440.1594620528835;
        Sun, 12 Jul 2020 23:08:48 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id e5sm12787172pjy.26.2020.07.12.23.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:08:48 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 5/8] Bluetooth: Let controller creates RPA during le create conn
Date:   Mon, 13 Jul 2020 11:42:17 +0530
Message-Id: <20200713061220.3252-6-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713061220.3252-1-sathish.narasimman@intel.com>
References: <20200713061220.3252-1-sathish.narasimman@intel.com>
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
index 2dc00604412c..e16d5154b2cf 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2201,7 +2201,13 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
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


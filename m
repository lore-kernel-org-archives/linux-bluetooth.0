Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEEEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 04:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8289E20679
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 04:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6z7LJXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgFDEFY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgFDEFY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jun 2020 00:05:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA11C03E96D
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 21:05:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 5so519643pjd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 21:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6CBbZ9r4eSiZUUGFyvEEYED4UFptLRNF6sdTCpICb7Q=;
        b=G6z7LJXq1yMGvzasIcDqLhMRmS1B7Lt2UBo3R6TzlQYTaS8nw/C6mFjucuFGQhzBgK
         zkYQcfD7vgo3urDKr6P5+7fhPDGPTwXhaNvpeax9LtqpyuXhKKcoa8kVBtrXBBgDJEs3
         9IleOAWQAgN/EVgbLCgUPn0xFon3pnNjR+UkG50C9xgu4O1bvyxHydGxMT7JMwnZZRzL
         SVRNsUJ+6xOOUH2XEhm9whFAKkEkENA7Q0zlDyd5h/lb1mSxsP1TA53/IP3wrC7E48tM
         c1/DcGihQQT1+o72MmMhzI4QHGyNVDdUXPIsZNjxcy1xc62NAy5QWkr0T2u91y3zUV+4
         5syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6CBbZ9r4eSiZUUGFyvEEYED4UFptLRNF6sdTCpICb7Q=;
        b=hTdz5Fe5zokQQC6oYJMusoDsft69coHCFFKCzus4hsLRS6NmxkkwXAjklQxi2nzhU4
         xcU7a+NCwAPw6TDl9I9a3/Bd4CYgqKSb2vSwwhcnExctBio0ckOtJ9pudG4sDP5ZMuNp
         jkrB4Nz9DxvwItdTitBCD6J+MSM5TYDYCW8Sy1zimjvqQdaV8WZA7ruEd8HMhdneF7Ll
         XbI/2hwyLb7c+VksM0YdvmFyqw6SeJg5MMkl/D6PdWrckcqIVHiiMqRAS1nGhTIG6LDi
         G5QJqfMuAIeOIzXrQUwUnACIj+gYsqcynZ0h96gNaGaHiMVcz4LE0Bvx4sa/na1SD731
         EdLQ==
X-Gm-Message-State: AOAM530IjpOlCpB53041rE64jNMeABjdv09ZNfvzeUMFP3oEEVmQBlE2
        2eUfYp2Br0q7WCDg0i59yblUFKdXqOI=
X-Google-Smtp-Source: ABdhPJwhO8/xcwxFBN4HuqR5BkjFFP8mgMR0knnySqSmPe6cnId7wXVstfoShrZeOmx8/PmO5A+4LA==
X-Received: by 2002:a17:902:eb03:: with SMTP id l3mr2912522plb.49.1591243522003;
        Wed, 03 Jun 2020 21:05:22 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.77])
        by smtp.gmail.com with ESMTPSA id z9sm3700683pjr.39.2020.06.03.21.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 21:05:21 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 5/7] Bluetooth: Let controller creates RPA during le create conn
Date:   Thu,  4 Jun 2020 09:38:44 +0530
Message-Id: <20200604040844.13386-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
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


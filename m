Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BBBC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FD3610A8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhHEAcq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbhHEAcn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:32:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2CFC0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:32:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b1-20020a17090a8001b029017700de3903so7123647pjn.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyRlnPKfXJZVfzem9Vu8RtOJ2Jpi0DMrsSP3VHVcN8M=;
        b=OJ2g7hxL7LxSKMlfjUKZeEl2wSBQwhAUGInpEDk5vx8UyOt3IbSglAeZl+3LQKBwRr
         oMaNCKB2d6AbQ5ApmohnerJXPqYcHojMWmS6Pm5n/1dHQfUpDLVzztafIdhrAxIMbs0u
         DxnuGrl8GwGtZQwFJpuVXLUpsFDqjm8SMO8LZrh8lnAflYYa/O97IXvR/EGP/0fimgg0
         gjb9FuQ6d9o4DV3mouyKUlqFkysYdemjB8c4uRs1eSW3iTkWIVZZUwCUQgkWozr6t26w
         HjTsCZExAe0Y1axKDyLmM/wE+AbQ/sAL5LxHdvyaH3ObxVTiVonTnI6XxlQsr0UMU8Ub
         poTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyRlnPKfXJZVfzem9Vu8RtOJ2Jpi0DMrsSP3VHVcN8M=;
        b=F0MMiUCHaJPtpUxNLcSYONFK1P+0K8ap3AOKZYvgVyip+38AK2nHq40zWQTlpcQ9VJ
         zgyoce2Wjobk4u1I55juPwmOFnYGmLQV4xyZGl4e2QHXql3EcD0e2a84REO6OCPzwdQm
         /1AZQzAUWZMIcM0EE+e83AjYcPphWGg5JyLQZZVj79fn7/d9vvEFt1jEkbGJIwBDerSK
         Zt/uFWtzX7f6BrAeI8IVT9bHDaM3hisKNw9ZAdEmMOOLTbp7JROK70DbGST1vMOtQywb
         WcHBKvno2LiHGykTS+bxeaapFgrDflUcvHV0OdZrWlvQitn0ZPAWoEKXlS5X7fCveQAR
         wc4w==
X-Gm-Message-State: AOAM533QQEJLAXO0RgsLiLHsYbb1XfW57E9f2TOzes/YSJ7Lkh/qViFb
        8IgKpFlWie4GMKbijqaO1p1B4eWEWV8=
X-Google-Smtp-Source: ABdhPJxyuxSjrpCHIOFodqwziNFAXtogDnbgy62zSQGS6ZpDzlSDyqDappmw/3P2hIZiUGkq8VgijQ==
X-Received: by 2002:a63:88c7:: with SMTP id l190mr433415pgd.438.1628123549153;
        Wed, 04 Aug 2021 17:32:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id q4sm4761787pgv.16.2021.08.04.17.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:32:28 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH v7 07/12] Bluetooth: btintel: Add combined set_diag functions
Date:   Wed,  4 Aug 2021 17:32:14 -0700
Message-Id: <20210805003219.23221-8-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805003219.23221-1-hj.tedd.an@gmail.com>
References: <20210805003219.23221-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a combined set_diag functions.
It also changes the btintel_set_diag_mfg() to static since it is no
longer used by others.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 drivers/bluetooth/btintel.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index fd947a8798a9..9e9fd2222294 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -181,6 +181,23 @@ static int btintel_set_diag_mfg(struct hci_dev *hdev, bool enable)
 	return ret;
 }
 
+static int btintel_set_diag_combined(struct hci_dev *hdev, bool enable)
+{
+	int ret;
+
+	/* Legacy ROM device needs to be in the manufacturer mode to apply
+	 * diagnostic setting
+	 *
+	 * This flag is set after reading the Intel version.
+	 */
+	if (btintel_test_flag(hdev, INTEL_ROM_LEGACY))
+		ret = btintel_set_diag_mfg(hdev, enable);
+	else
+		ret = btintel_set_diag(hdev, enable);
+
+	return ret;
+}
+
 void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct sk_buff *skb;
@@ -1737,6 +1754,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x07:	/* WP */
 		case 0x08:	/* StP */
 			/* Legacy ROM product */
+			btintel_set_flag(hdev, INTEL_ROM_LEGACY);
 
 			/* These devices have an issue with LED which doesn't
 			 * go off immediately during shutdown. Set the flag
@@ -1828,7 +1846,7 @@ int btintel_configure_setup(struct hci_dev *hdev)
 	hdev->manufacturer = 2;
 	hdev->setup = btintel_setup_combined;
 	hdev->shutdown = btintel_shutdown_combined;
-	hdev->set_diag = btintel_set_diag_mfg;
+	hdev->set_diag = btintel_set_diag_combined;
 	hdev->set_bdaddr = btintel_set_bdaddr;
 
 	return 0;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index aef04fa0e1ef..17cb62ac33f6 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -146,6 +146,7 @@ enum {
 	INTEL_BOOTING,
 	INTEL_BROKEN_INITIAL_NCMD,
 	INTEL_BROKEN_LED,
+	INTEL_ROM_LEGACY,
 
 	__INTEL_NUM_FLAGS,
 };
-- 
2.25.1


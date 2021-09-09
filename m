Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3880FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 21:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1359561131
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 21:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347756AbhIIVtF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhIIVtE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 17:49:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3699C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 14:47:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s29so2962205pfw.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 14:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93kqqM4szn2ffgFlTipWqutHmpPAvSNvYOyoXBWfLFM=;
        b=Lxs/vmc73IWtXWMFRhlAclVFRZ87M7U95YsYPOb8HwMA/UDAjA14lTXa7Holk8AGyd
         t9M+y/ko2enBIphJWyxPAofyDOvlyGubngXho2pC3ZYkeV3nzc9gn0dGO93f6iSq4aZq
         hDMp+jUDlntkE30dk98qYmb6STaglQTBG1GorSLy9MemMLeJtybLqCbsoXNGzYEinLIa
         JZabQuHE5llYk4vTxkbw1rqPIRxLZ1PE4ZPIpYlwKIHDHFCUid9LF+BTHirqaSg7h293
         oBVyuJyt/ot0taLCNls44L+B+xaScPSvpVutM+ZzG9pPYf0JiWgGNG4nv5M/YO4R5+Ld
         irTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93kqqM4szn2ffgFlTipWqutHmpPAvSNvYOyoXBWfLFM=;
        b=CM2MI6L9T65k6Ewnw/qVlg622kiQx/rDxs5fuID9LKNrL7FUYhX/pB/MNBVrX7bZSL
         Tj5pTcnALXaKSb4OsoYEuELmBzP089UHkMAp2WryZmLPcinW28I/+cek4BGw6YIyqcQV
         LlNXM0UFoNhRoBeiQb1t/LP+0MwGPFQ4U2NKu/Zab2NwU6PrIGjtId7yHEKIYOscjROk
         Xg4AQrGpwLtb/2v1/Io6HZDDwtkvKaGrVcHq5yP0JuxDH5BKEvV0lYdtoh552/Q2aneW
         O/Hx8ewb8g7/WTpRHFK2dt3gqYKxeHqPl35Molw6zFW9yCVvgmuRVo2bDruWREiNFSLR
         fbDQ==
X-Gm-Message-State: AOAM530FA5Sk0ey1XkZhng/R0d0T2vhPu8qSEzsFtfNq3rJH2HzAn/EU
        UEDKMRVsENXWbuEEOInDbPdGj61Ht2s=
X-Google-Smtp-Source: ABdhPJwRHYOSwnL8KmVC0VhMfikC3DWmPAZCOQJEsTrbaHj5PFd8X6rFcTQGnnEuDp5R+cDy7tmkyw==
X-Received: by 2002:a63:f30c:: with SMTP id l12mr4493038pgh.360.1631224073908;
        Thu, 09 Sep 2021 14:47:53 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o2sm3339292pgc.47.2021.09.09.14.47.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:47:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] mgmt-api: Introduce Test command
Date:   Thu,  9 Sep 2021 14:47:50 -0700
Message-Id: <20210909214750.2683251-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces Test command which can be use to further extend the
subcommands which are intented to test the behavior of the kernel
outside the normal scope of Bluetooth subsystem (e.g. suspend, resume,
etc).
---
 doc/mgmt-api.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb0..164a0514d 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3856,6 +3856,33 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				No Resources
 				Invalid Parameters
 
+Test Command
+============
+	Command Code:		0xffff
+	Controller Index:	<controller id>
+	Command Parameters:	Subcommand code (1 Octet)
+				Subcommand length (2 Octects)
+	Return Parameters:      subcommand return (variable)
+
+	This command is meant for testing only, it shall not be used in
+	production.
+
+	Possible subcommands:
+
+	Suspend
+	-------
+	Subcommand Code:	0x0001
+	Subcommand Parameters:
+	Subcommand Return Parameters:
+
+	Resume
+	-------
+	Subcommand Code:	0x0002
+	Subcommand Parameters:
+	Subcommand Return Parameters:
+
+	Possible errors:	Failed
+				Subcommand errors
 
 Command Complete Event
 ======================
-- 
2.31.1


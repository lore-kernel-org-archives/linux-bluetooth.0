Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048CCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 22:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358393AbiFVW2Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358232AbiFVW2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 18:28:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E549C70
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so17331603pfb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EWqhkDEeWuIdX2lQ40ACatIUFzeKwauHCTCOZyB1Qqk=;
        b=QSjaYxYdDb2/+XsSzVLed5bSSUTIhNM09UUKWT7Y5yyslIButkM46YlI/pJXTiMlPW
         3T/j0pYcbFp/Uqw27CgsnRTNzQJbGy+QvpnkyKOPtbN4aQl7Kby/o0P5u7ZKdtwAtaSu
         TwGSX3h9Xr9s37MyjiIIQ5WbcIPZE+c/vwrEq+67ZXGE6AwYHKPviqxU4mWTZew+dsmb
         w5wS9KVOiJmYl7thOJzv0Fdsi5pvXs+Rz+Ff4mRApdsvwXpgf3je0sGfHefycUpfk2F1
         9gb536xEd5p/kwV/rlEQYtXsdyh8WWfXaOm7e+K0PJu/orhn3BUUIu92LbUb/4vT+BZp
         KNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWqhkDEeWuIdX2lQ40ACatIUFzeKwauHCTCOZyB1Qqk=;
        b=sPap7gx5TF1O/zSgkF2WWFJy1LVWgzPLvkyx1E45MuB9YCde79N2SdrGCbdbw1kbPi
         BycQp2bzgaXcoxaXOE4bAjFPUOP2Oa+7zeqXNCG5cgwHUCl5QjZdkCY+rKM8VnuxY26H
         TWqpp/QAFvg7eK8vzXPfBj18TG5hqBPSMps6UtBRKJyuByVM6AI0TxCVJzsQDjGBxb3d
         g7eYgGuiTN3YSOB3IIh/NnHqlfLRfXEa6Ja8JSALh3vu/cXf3dXxPVeZkfNVX1jxblKP
         G1VcSKJEltLNbfXCeIvL3Vh32WT87XV4ZtF8RxVZJSwyphrQXExkg34F6YnL5WyrGSWl
         ZAOA==
X-Gm-Message-State: AJIora/uyPqTRNRfzJY1XXp3Vj1DFBXmFFDZ7N1/pUs5N0rs2fEJU6op
        rFEwHlyGk2GNoyRmNUavr4Sz6bhW0HACqw==
X-Google-Smtp-Source: AGRyM1uwylkK1G9+0Q5gjOok9s0DpFIP9exx39HhzNBBxHXgGmE6beDBKLtlrx37u9n/5k7VcoXVZg==
X-Received: by 2002:a05:6a02:117:b0:3fa:de2:357a with SMTP id bg23-20020a056a02011700b003fa0de2357amr4762846pgb.169.1655936885694;
        Wed, 22 Jun 2022 15:28:05 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm11710482plo.14.2022.06.22.15.28.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:28:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v7 3/8] mgmt-tester: Fix Read Exp Feature tests
Date:   Wed, 22 Jun 2022 15:27:56 -0700
Message-Id: <20220622222801.2676431-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220622222801.2676431-1-luiz.dentz@gmail.com>
References: <20220622222801.2676431-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ISO Socket UUID as response to Read Exp Feature.
---
 tools/mgmt-tester.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index f45a6c015..4191840ea 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9858,7 +9858,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9870,7 +9870,11 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
 	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
 	0xce, 0x5a, 0x69, 0xa6,
-	0x00, 0x00, 0x00, 0x00			/* Flags */
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
@@ -9882,11 +9886,15 @@ static const struct generic_data read_exp_feat_success = {
 
 
 static const uint8_t read_exp_feat_param_success_index_none[] = {
-	0x01, 0x00,				/* Feature Count */
+	0x02, 0x00,				/* Feature Count */
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
 	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
 	0x30, 0x25, 0x99, 0xd4,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success_index_none = {
-- 
2.35.3


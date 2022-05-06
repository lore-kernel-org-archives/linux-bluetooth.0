Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE263C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444783AbiEFWgi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444775AbiEFWgf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:36:35 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4132528F
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:32:50 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e15so9574130iob.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=AF62WD7wrxJiHW0G9b13f9SZtEx+evKmp9lLgtWmfiaWa4u7NHW4Ba1ADwZQI3oteF
         9z67zhZWiwpHLNilRHzBqoXkz+5W8z18nXR9A1VgPGjS6hCHye5NqlQDDSYB8U+4j1H0
         z5gBx6x+xrFRik8AJykyWBKvuo+DXHhuBzowZHNcuKXbydBESW/rK8wfP+SKP+VLDmFz
         3yCLnfZIzODlcCIfxd/hVePS1ovtp1R6rd6lGzQJn4qLGLO8rtIGo1J3bIzEYZzKOCc7
         0XecTwTZ2a+gRlWMOyFERLe1TsH93PfdJjPB/+STcYWvIj7F2V5vU9UCOpK9P2ntP3yg
         wWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=6ziis8FY7mqyVh16RZSpYMy4+kmUo6BO4vl9Y7t90YpQmKGMG+R7ltwqbHoPHgoXlP
         1HSaAsGwVXo3Op9O8/TueTiFk4XlA5QUz3/0nOsT9OE4vD1+64nkcczBTT0YWtrEZVxY
         AlTy9JlN9EW5KI5QUYRDTJ4frOqO7j/hncvgee2dr8lXw2v4mELj/DB6t1XHRxEqKjiS
         ijAatMwGya5PonifyIDgz4c4GUMoE2vo9Hy0tGEEZbBTBTZio13gE7LSmBsDajl2irE/
         oHnuQ6foGr/FHAi9zHCoPn0ULlH8+LwNvj/i5VhdzV9Y5uKP9+x3iWQe7n0jSUrPySdb
         hfjg==
X-Gm-Message-State: AOAM532ruox3G5nBVTIm3J/oz9p/ZpeGB7C5NTQMSTjpSd79bcbCKWk9
        v6HtUPWwA/lyN2hUWVcwRlFV45n9PyY=
X-Google-Smtp-Source: ABdhPJyxmhzOCp7oxnpRBV3DlouFl6GvLG1dIZfPCKjmc2vRFyhEYvlbALUb/UMxDjaAOhPZRba3mg==
X-Received: by 2002:a05:6602:2b8c:b0:649:4310:602f with SMTP id r12-20020a0566022b8c00b006494310602fmr2264031iov.13.1651876369955;
        Fri, 06 May 2022 15:32:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x20-20020a056638249400b0032b3a7817d3sm1647254jat.151.2022.05.06.15.32.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:32:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 3/8] mgmt-tester: Fix Read Exp Feature tests
Date:   Fri,  6 May 2022 15:32:40 -0700
Message-Id: <20220506223245.3950871-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506223245.3950871-1-luiz.dentz@gmail.com>
References: <20220506223245.3950871-1-luiz.dentz@gmail.com>
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
index e5319d123..bfa5905e0 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9798,7 +9798,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9810,7 +9810,11 @@ static const uint8_t read_exp_feat_param_success[] = {
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
@@ -9822,11 +9826,15 @@ static const struct generic_data read_exp_feat_success = {
 
 
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
2.35.1


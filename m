Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA93C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444771AbiEFWfb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444769AbiEFWf3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:35:29 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46642528F
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:31:44 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d3so5668162ilr.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=BeEIUEGDw0nZ1pc0j9VLJJI+4MwUU6JLHR6SNty36hxJc3ll0h71YH68ZFq1PZWZrN
         37jZ69WKIKSSECkkiVa58BqwH9S+XZzCP5WU5ckimFVJanXNK0l8KwAUfKUKBYA0pzBV
         p2zIy/an8AWdvwYIrc8ES4An6D9jR4H1mvUXaJYdliKNp8ktJ2asDdgjWgLjOTmXQj+L
         jyGzA/cCBR/JlayTZyvHZW8fWjUIbLHXQrhEdJrJEzGq96wc8iL1QKphL1IsidV9COfh
         ri1ExQxJAB3bdwf0DXIuMbs5aVqvqbb0P5m9gRMEwtGdPmnoEqEWlacHfYaoyRx8b4Ar
         PRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhF9CMCiGnnsQMWw2AcnUTFA1xJBYKvdFqXkKgpPp6A=;
        b=VqzIFGtKEVgIGWudWba/e9oUq0Ps4FEF8tKA9+xFtw0PCBtKDierWawaQHSD5GhuSC
         Uj2tvLFU9vRyqA//4tAAoXel7cNCzgix4N4SHhLSukjCxuOIow4oxVvCniw9MxXvwsWx
         MlgLDW+3Xzqw/R4s65PcbXwV3Ot0NwoWLO4zZ9yvgSv+U2q3GMvOuwEeszG3JHfG1nxh
         QuWFJ698aszTvo+v0xQngnnYBXl3xO1CCB9MjbzGLWrqtIseEhS3AHHKALh+uWApS6bI
         FACb7qf36Yn4+PPm9XbLbpKo82KggLwym9s5TeAqOby1EDfwmLXNU1TqEaWTbjgLODen
         A0+w==
X-Gm-Message-State: AOAM532GTJ0sGvLQ08wnpxvQeOPkfwxi8EfujKRoo0gWYZ4bUCL/Fx+J
        MYcp20VOn6JPYqIgCrebjEvlXDi4IVE=
X-Google-Smtp-Source: ABdhPJw5CFft6pcLjFYZjagzxSGq5hno+Arkom7kiSebYkpAoG6dqe/dSvWruIkdav/n0HSGHxhthA==
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id y6-20020a926406000000b002bbf1dee13emr2132214ilb.305.1651876303802;
        Fri, 06 May 2022 15:31:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p16-20020a92c110000000b002cbed258dcfsm1488375ile.0.2022.05.06.15.31.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:31:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 3/8] mgmt-tester: Fix Read Exp Feature tests
Date:   Fri,  6 May 2022 15:31:30 -0700
Message-Id: <20220506223139.3950573-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506223139.3950573-1-luiz.dentz@gmail.com>
References: <20220506223139.3950573-1-luiz.dentz@gmail.com>
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


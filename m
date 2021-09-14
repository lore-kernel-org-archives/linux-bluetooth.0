Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9ED26115B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Sep 2021 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhINWk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhINWk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Sep 2021 18:40:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F0C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 15:39:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h3so700696pgb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ghSbFs3tTewjVk88c6Mr/RMHRpaAo6E7Z3lHs9QTv0=;
        b=XXcEjq/QhJv0mA8ivwJkxv2rfiQ6618B+dyAtNTCg1laCNtOZeXuDBNjGedfH5qtyH
         FoCZhnvhALQC6lDwDStJZTTJj1SJg7mCpI+iFnU2clpcNKe7IkL9zmbjiouFtI5ua4xe
         qPPK7r8Zr3PmZrme4vXn0HjIOyXKBdDuozwm1CdldL7ZalItVT57mZFWQdfE0r67LIv7
         v9FRtcCy8PvLWH+/4Oz+49lLmPP0BGJ2dwbv2t6Q02TYYePmFOoPXO3sCBn9UV4Z+BTs
         H9tNSWbEQHZebQNKsodCCfMZz9yso2RmVtKuYARDQKs+xDrv2tzQotyMFtW61UG1ZN4e
         f9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ghSbFs3tTewjVk88c6Mr/RMHRpaAo6E7Z3lHs9QTv0=;
        b=RON47Vv9FBAH/5WUOxuSJDhF6xiG/J8AciaEkrhUeVe5jlP9yRN1HpCi8KnmULzY01
         IiiQzbTNb7wI+5YLO5vE27cDzgJ4raUvn3pq0EGEmc7/xX3NM7vokhPGGmlce/m38Sqh
         Qa3H2VHa1uR7STpnymYE2gLstFALe3l239MpoNEg+nPwg816o+lhQYFr/BCjks58LluW
         jIQolY4aRO6bTvv/0F3F/5lkK4TkzTHPdzxRC8fAEtEzcRpeE1QrGlcMMYij9QnVfO8o
         BqxyK5LQ5idOEjSqQY/wt1ulvlpX4LaQfPQNqmQMEILySztEYcOKkwChlXfEBnICsUS7
         UrNA==
X-Gm-Message-State: AOAM5337PU3f4tZPfkFygI1e538PXF4C5Ss8X2ltr5C3GKf/AnpT4DCk
        ABdJoZQVSXLHE844YZOl9SjLvOkdHJI=
X-Google-Smtp-Source: ABdhPJzr/KHFhd0EW66BPYxDV/uvvrAiGvoCIRbQ+WwOPI74az+7lfikTNoOjXdQXss/Pvx6+rPUJg==
X-Received: by 2002:a05:6a00:10:b0:43e:ede6:2b7 with SMTP id h16-20020a056a00001000b0043eede602b7mr438662pfk.42.1631659148834;
        Tue, 14 Sep 2021 15:39:08 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3253:a507:4224:8e08])
        by smtp.gmail.com with ESMTPSA id b10sm11149049pfi.122.2021.09.14.15.39.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:39:07 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] tools/mgmt-tester: Update exp feature testcase
Date:   Tue, 14 Sep 2021 15:39:07 -0700
Message-Id: <20210914223907.353433-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the experimental feature test case with the recently
added "codec offload" feature.
---
 tools/mgmt-tester.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index da53e4484..f027f032d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9334,7 +9334,7 @@ static const struct generic_data set_dev_flags_fail_3 = {
 };
 
 static const uint8_t read_exp_feat_param_success[] = {
-	0x03, 0x00,				/* Feature Count */
+	0x04, 0x00,				/* Feature Count */
 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
 	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
 	0xb5, 0x10, 0x1b, 0x67,
@@ -9347,6 +9347,10 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0x70, 0x93, 0x2d, 0x49, 0x06, 0x75,
 	0xbc, 0x59, 0x08, 0x33,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
+	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
+	0xce, 0x5a, 0x69, 0xa6,
+	0x01, 0x00, 0x00, 0x00			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success = {
-- 
2.25.1


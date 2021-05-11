Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A158C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6545A6143B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 07:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhEKH3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 03:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhEKH3y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 03:29:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65951C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:28:48 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id n46-20020a056a000d6eb029028e9efbc4a7so12419965pfv.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0NuxBHGHxAT7PFBRKN8L1TkqBFdEqBHNKYTr/3kaxf8=;
        b=qroSWun2ErszEsgxCp4O7qFrCH+qBjwTAM9e2Jl6GH0g4Wmq4P6wCRGV0eETDEL984
         +eK1CnYCN0Hj8HSsfkHb6DtzOuriZepDfVB/KNmMLFMKn9rezjPlSxY8twRscIBQLjNE
         qUqm9v6XDTrcqyOkwG2gaugqecgygWymAOjhtaq3g2ysQtNMEw0FQ2nVJGYEUTg+/Pig
         8evtIwZh3yGfzOfg6UXO9lxkjl285vOQU2eaWH3TNO5+pMiwt5J68ul0lPiU1i+Do0eG
         u+m58RyF73X5bYNjyL9Kozihcd6fy14UKb/nq7trf7W0u2XZtlVdREGRvzrNDyoAD7Tn
         v8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0NuxBHGHxAT7PFBRKN8L1TkqBFdEqBHNKYTr/3kaxf8=;
        b=GhCWzJG5snn4zb7spaTbM+d9mNBBtWIuyKHD51/nsTn8ukeKYFUpPE5nYBnBgAYIoM
         h9t/Pbe7WXWFYIgxEeWdg8ZzmTq68HRVW3msA9iMEzyPJQOOfobGtFQa7ezUGrIIscog
         spBuDghJ5gk+bc4E3yVaQ1UwRWsmNbsAWQFJEQ0RY8cUma2uirmd7LT5x+gD7E4VBjrs
         ddfr2k7F+nc2nE2xs1X17lsLxlkiB4eLYSg17r+0nkiJv0Y8wB9nWclXdLXvH5BrMA3Y
         +yFxLX8KIMhXcoem0LF/q0U1tgrQC2FaNvxCMUdFKhzNFHJFzUuh85qV5VhJKZP3KYwd
         +8Xw==
X-Gm-Message-State: AOAM531x/74m4RuuTQXvBnHd9EwrXoBKDC1LidxFrozIUkjeR5wBmESL
        4LLIE55xiIdxkDmMSTxVIj7GJ5gMDit2YOjaIwPgBbyi4E18kpwtu9Rf4axiSJoEbb/vfCBfXrt
        Z1VZ3UNCAulkhyy4Ugh4gRH3HTzBwj7sA1lJ5zcz4Jr4+5roDdIiUt/AGPcPuMzEyjYca2t9ZPz
        V3WOU9bdsZx08=
X-Google-Smtp-Source: ABdhPJx4cuQxdXvSqJLYrH+lr0siY8udCaIfi/rjPPpz1tN0NeLdkUIgHM2XueEYkBj8k2JnRz3AJ7gMXBf1s8ataQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:cbc0:6ee0:8475:58e])
 (user=howardchung job=sendgmr) by 2002:a17:902:8505:b029:ec:b451:71cd with
 SMTP id bj5-20020a1709028505b02900ecb45171cdmr28430448plb.23.1620718127754;
 Tue, 11 May 2021 00:28:47 -0700 (PDT)
Date:   Tue, 11 May 2021 15:28:42 +0800
Message-Id: <20210511152807.Bluez.v1.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [Bluez PATCH v1] monitor: Fix possible crash of rfcomm packet
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yun-Hao Chung <howardchung@chromium.org>, apusaka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

When RFCOMM_TEST_EA returns false, btmon assumes packet data has at
least 5 bytes long. If that assumption fails, btmon could crash when
trying to read the next byte.
This patch fix it by checking the remaining size before reading the last
byte.

Reviewed-by: apusaka@chromium.org
---

 monitor/rfcomm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 9b88a3440e31..76b1123bb23d 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -452,6 +452,9 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 		hdr.length = GET_LEN16(hdr.length);
 	}
 
+	if (l2cap_frame->size == 0)
+		goto fail;
+
 	l2cap_frame_pull(&tmp_frame, l2cap_frame, l2cap_frame->size-1);
 
 	if (!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
-- 
2.31.1.607.g51e8a6a459-goog


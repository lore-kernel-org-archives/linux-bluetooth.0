Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56B1C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 02:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C1461004
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 02:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhELCs6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 22:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELCs5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 22:48:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A56C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 19:36:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d4-20020a25b5c40000b02904f8e3c8c6c9so9629148ybg.14
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 19:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lWG2iA9eD69/GYADJhXQjoZ/kEDfSwxbQBL+ek3Js0s=;
        b=hHk4zcL98+Wz/17dsqYBkBeleosqZXjNCyeW+RIkXN/3WaLIq1RmWbojst53KcOh9d
         QhuibZZ/C6rJJ/qXUE/6DHhdP+EgDZVl5CzqpSaelkx2LwtOfeVTdPIciQ+KGW5VQApm
         /Zg8GvhoPFoIy7uz3CSjAeytyNeYqWEh7LY3aNrbcAcH90cZklwZoGkKhJ9G3bzZkFWL
         fWSdP22G0shRVb8iNaACfBGap2CTmR35xh+CUL/ksVTxv+KGtT8wtcQply8YdFUbvxeZ
         HEhRnwBIo6N9tsXxg+S2nqKanl239kcPM1+WnK3Gpy7+ApgjzFm1Uv2IBaqYtQPNhXYM
         C1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lWG2iA9eD69/GYADJhXQjoZ/kEDfSwxbQBL+ek3Js0s=;
        b=LGPWkT8gkYXNTg5ZvBTPFmWNShhhnU7cUrFCQ8b6RRT8A4vyBJiE1btlTqn2TzFL+V
         hwI3aoD7j27nEBKit+G3hQKk/z+KimmLyFwvqMJ43pI5XZWbuLKBqimSBoF1CCc5lI3g
         1yBTssNfJ30bS2ufTgHCzlQuMTaN01GGWnc0hO5shJ4CpCOGLRUT/ZZ+bW3EoKmIMTa6
         7iXurRcSB2UeS4JHrB5QPgHVfO6ft8Pj6ziKmlpDvuA+cv1b3ulX1RSWaKmLum79q0bI
         PqC1utGyOZR6Red2TjpMeBXTicjTWgHg99zXRY2VIaeUdDrU//zR9pvqKf/Wcsq/JkYr
         YZcg==
X-Gm-Message-State: AOAM530uuhIohk2T0jLowvfi3ZIBJpwyDQm9pcszGhUYcnwSuk0yD/6s
        /KmwjB+qyC9tr1F+Qz9jd52u4yX8nTK+bayoXX8Yeakhy1GL9JNXvWQ0UeQvFYdPG51ZP2Hopzk
        ShOm1rP9bUOXLP1epoSzpqaNQKx2YsYx9CJiQPbEyAGaZZ1Q/4wA0RvJ4nMW9qzUzH+mHWOfYd5
        PPy+YnUUlQUVg=
X-Google-Smtp-Source: ABdhPJzdJcDbYKW86YbUgmLXPDMINEEFUzOV4QyB3mz2r8jWOVrSKff5WWe/rBQzD0KIyCa+b3Inh9B4e9dxhcs6hA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:13a6:268c:f1e1:b90a])
 (user=howardchung job=sendgmr) by 2002:a25:1455:: with SMTP id
 82mr44503907ybu.403.1620786970883; Tue, 11 May 2021 19:36:10 -0700 (PDT)
Date:   Wed, 12 May 2021 10:36:06 +0800
Message-Id: <20210512103550.Bluez.v2.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [Bluez PATCH v2] monitor: Fix possible crash of rfcomm packet
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

Changes in v2:
- Rewrite the if statement

 monitor/rfcomm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
index 9b88a3440e31..3eb19faf0297 100644
--- a/monitor/rfcomm.c
+++ b/monitor/rfcomm.c
@@ -452,6 +452,9 @@ void rfcomm_packet(const struct l2cap_frame *frame)
 		hdr.length = GET_LEN16(hdr.length);
 	}
 
+	if (!l2cap_frame->size)
+		goto fail;
+
 	l2cap_frame_pull(&tmp_frame, l2cap_frame, l2cap_frame->size-1);
 
 	if (!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
-- 
2.31.1.607.g51e8a6a459-goog


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C651AC7618D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 23:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjDEXLR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDEXLR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 19:11:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD746A7A
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 16:11:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d8so22740951pgm.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680736274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTuVRoYIpyS9FYtg1FOjJUWJ8TECAJyoSu618nmDA/0=;
        b=hDVgnRYy43qgTyMXQ4ixA94esSsdwSqN4cpawCtXk5rdzdTi3R0GozPHodXf8xbkRo
         jPh+K6138Qq8EChetMFZPP1bVsJpfhlkpjEyaK47erBgzcc7pFUYHOL4YHj9XM2KN5pW
         4lEbDVe33ouEQBlQeP3W++fTPgNhRsnj8NRnqrIjkDjS+1XAKWmpU3oii+QN1KGpOXt9
         k4gsDoMd9diYqyL6cf7wy50reJCgfhWSyZGXp8UrXZ09lgOdgJ+bphGReJ7sU6zQ7n0N
         SVG2gXG/iqF3H7S4j0wBnyf6NESwmjWzz9OibujkRPyhKu+01WOQ0LmVgFQ/4/M4UaQB
         sX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTuVRoYIpyS9FYtg1FOjJUWJ8TECAJyoSu618nmDA/0=;
        b=D5GiW3QCCZmxoo+9lIcNkUYr3jvVPcM3z8ydkjAgDc/9HHZQvCSv8nXBc6Kzj3/I9S
         +LCku9FLQ5l7GH0udFzmWA0vYisCUA5SjsXAjDb30+ghprt0sNnF3Xd1R/r/84nL1i/7
         ImFEtZMmhLmQKv28dAIEsMuwtnZYo6IxZmPOj6gV/yTR1mP9ST/omApHAtOZfX4ayP1l
         IFQ/jdFJvTvOVSfu6xo00ND8vR8396kIIAw+rm54wtJBGxziQ8Z2SNANflKQIvnc5Aa2
         NjRfMmzuhVbQmH5n5rokjx8MdyNBO1I7jj80jkQ86M+EBCx2OTIIgXy6XcYSzf6ddrZ5
         4jyQ==
X-Gm-Message-State: AAQBX9cRKi/guYWYFs+p3EjcAY63E+cWIQWILmq0Fw46MVZC9AkiHM1r
        jgZHYSd5wXXG8VJWUOwjtZi0ErCE9gg=
X-Google-Smtp-Source: AKy350Z+wvIZbSXomq61hYsrhxLJzuo4xJafelK39ub0bFKnI5Lk/WVLda/qRzB2kPafVEnKYWYlIA==
X-Received: by 2002:a05:6a00:8f:b0:627:ee6a:2a40 with SMTP id c15-20020a056a00008f00b00627ee6a2a40mr7726519pfj.10.1680736274529;
        Wed, 05 Apr 2023 16:11:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7808c000000b006254794d5b2sm11537752pff.94.2023.04.05.16.11.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:11:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] shared/ad: Fix bt_ad_has_data not matching when only type is passed
Date:   Wed,  5 Apr 2023 16:11:08 -0700
Message-Id: <20230405231111.2636523-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405231111.2636523-1-luiz.dentz@gmail.com>
References: <20230405231111.2636523-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_ad_has_data attempts to match the data portion even when not set
which is useful the user is only interested in actually mataching the
type alone.
---
 src/shared/ad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 27b76dc8179b..7350aa206d1e 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1028,6 +1028,9 @@ static bool data_match(const void *data, const void *user_data)
 	if (d1->type != d2->type)
 		return false;
 
+	if (!d2->len && !d2->data)
+		return true;
+
 	if (d1->len != d2->len)
 		return false;
 
-- 
2.39.2


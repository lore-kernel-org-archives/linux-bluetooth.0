Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6DC05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 20:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAZUMs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjAZUMr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 15:12:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5FE3586
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:46 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g23so2855436plq.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQPugu7B9HrwJq2khs0mn0gnme2ItCl7ethv33RJbRQ=;
        b=QpHk5e+fovpedkJCdVKMPvBp8kv0SH2mw1Zg9bDCqx5cnBugR25A+/A9cC34Pq/Edr
         5dRlVWS1uin5evb2JZAQAGMpO20VJTulp1WuYB9FKvPJEKX35BmP5Shj8anqLsLO1S1x
         mAJEvMIPz7jL6IkcUNpUg+e+LTWithg+bD4sKEfX7Os52DAYYd8tbu6SB9f9DhwLcs5z
         dgTLy3RAun8Hsbnk88tJvA3b4goy8P+kEsPldY31aYo2UKCxyTrqo6eL3gtiQjiTMCsm
         1PgNbGqUPE3BBbXIzTfJmeFBbcKGt+dRyykt1mWpXNoTyyrkfzei+u4y/XH1Rl7KpS43
         QqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQPugu7B9HrwJq2khs0mn0gnme2ItCl7ethv33RJbRQ=;
        b=8COuRiFbI2HNPe+kfcGSLmwmS+a162kXCuPmZmbrcX5Y5v20rPdlWnardFcfWjJ5j4
         X0aO1Ot+BUsu/SvNndfivFIZEeERov9mHkKk+i9vSdkYdhuKbQM6NJGKhomM2G9Tk73D
         hu335Mk+Y5ftWk/SSiCfqhoagmSOom3u7tGNfhe0fqcyWuzl6lQXo2d31RVqKqs8R99M
         7tCTK3+C8cjyYmA0DKBcGgz2it/R2VM4PatOl6RcGESlZc9/iVwHl+C7cvyaaZIn5N2z
         CXazAeKS/QLtahsoIOdPf4yo2nw4JH0rByFJWk64kL2YGvxVqa+JExEPHVsBdqDhy6Bz
         ztJA==
X-Gm-Message-State: AFqh2kp2a6NXPV+grMs8/UNUYcZDE7r3h5xZDNlmITpa9S2NwWff456I
        DryLeDmsHU6+O2gQFeahNV++2bWogJg=
X-Google-Smtp-Source: AMrXdXv4dWkhcNyGmmK24Om+EdX3PUOASjgx7BwSn0/m1QiRIuornmATbPOP4/tN/qPQuTik8916wA==
X-Received: by 2002:a17:902:ab50:b0:194:d5ed:b9ea with SMTP id ij16-20020a170902ab5000b00194d5edb9eamr22665653plb.57.1674763965112;
        Thu, 26 Jan 2023 12:12:45 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902c78100b00194955b7898sm1341045pla.237.2023.01.26.12.12.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 12:12:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/5] bap: Fix not setting stream to NULL
Date:   Thu, 26 Jan 2023 12:12:39 -0800
Message-Id: <20230126201242.4110305-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230126201242.4110305-1-luiz.dentz@gmail.com>
References: <20230126201242.4110305-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the stream state is idle the ep->stream shall be set to NULL
otherwise it may be reused causing the following trace:

==32623==ERROR: AddressSanitizer: heap-use-after-free on address ...
 READ of size 8 at 0x60b000103550 thread T0
    #0 0x7bf7b7 in bap_stream_valid src/shared/bap.c:4065
    #1 0x7bf981 in bt_bap_stream_config src/shared/bap.c:4082
    #2 0x51a7c8 in bap_config profiles/audio/bap.c:584
    #3 0x71b907 in queue_foreach src/shared/queue.c:207
    #4 0x51b61f in select_cb profiles/audio/bap.c:626
    #5 0x4691ed in pac_select_cb profiles/audio/media.c:884
    #6 0x4657ea in endpoint_reply profiles/audio/media.c:369

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1399232486
---
 profiles/audio/bap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ae944b617bb4..8f24117681d2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -998,9 +998,10 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_IDLE:
 		/* Release stream if idle */
-		if (ep)
+		if (ep) {
 			bap_io_close(ep);
-		else
+			ep->stream = NULL;
+		} else
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-- 
2.37.3


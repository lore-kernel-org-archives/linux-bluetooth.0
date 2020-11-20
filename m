Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E356FC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 862792240A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSKim4ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgKTUHe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbgKTUHe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:07:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C1AC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:33 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id a18so8924182pfl.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=6JoIhqlLd/kjIceAs6w1qAKl0eooc9HwRrMzM7J/ARA=;
        b=GSKim4ZYPFIA6Ya+XrHocDcHmOUCq0GCOUx5VDJHaYrQwwxfwiZPHjD/2VsbPw4Vzw
         B+8M0WYpdhDTGhqDF7gWJ2ApR0WVLdlKUHLhonHAPokGiK3krUk0z+aixFhsVc/K6Fc9
         5j4l8usCKHcxB1qkorYlHZ/iXY/71JaOex9snb76wV/7viyFfoMEr9qzrbEpMTXOXLy6
         68zK7GCSRAV7esno49l5ytDAfB64/r2RUfMDM1h787wAwOMv6gGb0ZsKzV/PRCwwyNeR
         yakEzltODzKPIG4cqyzs9y6P5zPn49Umnhn2SOK+lXQ2YaY3RXvfvE9aTOhCgDkM3txi
         k1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=6JoIhqlLd/kjIceAs6w1qAKl0eooc9HwRrMzM7J/ARA=;
        b=ljtg13Lys36fF8Zb0lDBZUaObUY4PoReI2ogru8+NLNooTFatSoFhIGZtvuAJRRQyR
         OUx0BbQ55+FMIkTsNbJXJbyIqnUwBkjSkxcmO+7+S4gyGyUJTCLfma6f9GxNxkz1y529
         CR8cn2rAFg9s0+jR+OhoPjGIHSgG1zBp75IF14U+14HgTX7iudI/0bEsE/Pr4Hu4uZJ7
         sJySuYMuCUheOzhrTcCv47na2fWx4RrPfRvoAXc+bqvBsK76mzo4xh4/9yTkJYAT7JsA
         D0qrUXgmuTPdTWPvwMmU73gKnLdL82W5CWsZV3GrSlc434D7zYC8Wgub0Lle6jALTZPB
         AEdg==
X-Gm-Message-State: AOAM530J01IxW0Jh29cFMMOSXP5PWruBAYBgJU9uM/1D41Y8QsE5bchY
        SmBvny0C9rGEtVn4ZS0ZEX09PWHgeOwjeg==
X-Google-Smtp-Source: ABdhPJxTSOA3T38uZGX4ksep33Z5NeszoZyivS1HAUpbJB42nFWgNdsnxiKth23sNJ9xwL4ybzDtng==
X-Received: by 2002:a63:1514:: with SMTP id v20mr19142627pgl.203.1605902853352;
        Fri, 20 Nov 2020 12:07:33 -0800 (PST)
Received: from han1-mobl3.jf.net (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id t5sm3979267pgt.15.2020.11.20.12.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:07:32 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     tedd.an@intel.com
Subject: [PATCH 6/6] lib: Fix the unchecked return value
Date:   Fri, 20 Nov 2020 12:07:12 -0800
Message-Id: <20201120200712.491219-6-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201120200712.491219-1-tedd.an@intel.com>
References: <20201120200712.491219-1-tedd.an@intel.com>
Reply-To: tedd.an@intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the unchecked return value.
---
 lib/hci.c | 6 ++++--
 lib/sdp.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 4bd33f241..53af0a114 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -1246,12 +1246,14 @@ int hci_send_req(int dd, struct hci_request *r, int to)
 
 failed:
 	err = errno;
-	setsockopt(dd, SOL_HCI, HCI_FILTER, &of, sizeof(of));
+	if (setsockopt(dd, SOL_HCI, HCI_FILTER, &of, sizeof(of)) < 0)
+		err = errno;
 	errno = err;
 	return -1;
 
 done:
-	setsockopt(dd, SOL_HCI, HCI_FILTER, &of, sizeof(of));
+	if (setsockopt(dd, SOL_HCI, HCI_FILTER, &of, sizeof(of)) < 0)
+		return -1;
 	return 0;
 }
 
diff --git a/lib/sdp.c b/lib/sdp.c
index ebaed3e40..844ae0d25 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4705,7 +4705,8 @@ static int sdp_connect_l2cap(const bdaddr_t *src,
 
 	if (flags & SDP_WAIT_ON_CLOSE) {
 		struct linger l = { .l_onoff = 1, .l_linger = 1 };
-		setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
+		if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0)
+			return -1;
 	}
 
 	if ((flags & SDP_LARGE_MTU) &&
-- 
2.25.4


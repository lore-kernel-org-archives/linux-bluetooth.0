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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7B8C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 23:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACADE6127C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 23:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhDSXyJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDSXyI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 19:54:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D483C06138A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 16:53:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q64-20020a25d9430000b02904e7898da351so9531303ybg.19
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eI+2lB2i0zkJaQIbQM7tK6wekgIsPHxRzUo5leb4rj4=;
        b=iGdhwBvLpWOvkaGIBS8myhQnNZLBWSQrFRI8b3G9Ueq7noHNfiggS5avakde/q9iIj
         jEtEL0gzVGSLALYIL46/hyn6tqLyMAUH4PzBJCc+u7IY4/VqV/3Bmy+SQlPiN2orQxsp
         8xSJT2yhKAJ9um/BXV1NfRSbxt8+D8gXPD22yt4vOIHBJRtAkZOtJY43+KKEr5KtdIUh
         nqNj71V+YzufEOflDJbH/Beasc8KnDQZfw0rM+2dyNsU7/zwn80fYBy9D+HjaNgy7hp3
         6uUygoUEuu+Qa35cdbc+MgSkqJ1FkpjMXKQK9sEYzD837QmQFsJRcUee6/IsGayJw4rm
         Rvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eI+2lB2i0zkJaQIbQM7tK6wekgIsPHxRzUo5leb4rj4=;
        b=JpIp9ul/N/VlwGvJaPYhZNtAiTldNl2kLEPz5b4uAyXK6F4EoQf07QU9xnl0K0PDoL
         29rQo2SEEH4koiu5tfKD219tFFnSDcycbQAoBO3NQDIS93skYIMmZ+Dj7rXew0BdSdbc
         GmijbLfs71NKNTv9JNyhP0t1pSfPfT4b76OhM3y6A+TxnT0iJ+4hO7X/FWwJVIwJ8LBO
         0sr1HS/XIMtPt3+qN47PkEJ5RJEIfSQ1QUDMMJfG7/JrmeB3KiawIcVGTbEcxSdBtrKf
         SRI+aE8HL6NPJqLbgY6vRGnRmBpUHfuUlcFc9WExMf5nSl0uCnJ6vUGvG6iozR4bxOkl
         Zkow==
X-Gm-Message-State: AOAM531EJlE4IIOTmuBHzEvQft8uIPyXwaQjYDSgMOsVJo9cm+Owh2iv
        eOtD2osxhJd09SzEM0cav+79PGJPK8mfMX1HlYK1FExfIEckXYD2BOqyFW7GiAOkf15S5IwoSo9
        dc4UNTzHCsFbC/lYio0pQBA4JicKF2PqRqe5nntrulVTZcrb6wJaptSNG5sEXpejZcvE+PpQug8
        9o
X-Google-Smtp-Source: ABdhPJzyQMvShZV2mpRVxeIT+bd4q84WPlLqmiWLMbNsGXJlBE9QHedcRcR6GFBjgErUEyjnVAmHDpsg0VOS
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:ad3b:b707:fe95:d739])
 (user=yudiliu job=sendgmr) by 2002:a5b:152:: with SMTP id c18mr20397176ybp.4.1618876416181;
 Mon, 19 Apr 2021 16:53:36 -0700 (PDT)
Date:   Mon, 19 Apr 2021 16:53:30 -0700
Message-Id: <20210419165323.v1.1.I9f9e8bcc849d91c1bb588a5181317c3e2ad48461@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v1] Bluetooth: Fix the HCI to MGMT status conversion table
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>, Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

0x2B, 0x31 and 0x33 are reserved for future use but were not present in
the HCI to MGMT conversion table, this caused the conversion to be
incorrect for the HCI status code greater than 0x2A.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Yu Liu <yudiliu@google.com>
---

Changes in v1:
- Initial change

 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 40f75b8e1416..b44e19c69c44 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -252,12 +252,15 @@ static const u8 mgmt_status_table[] = {
 	MGMT_STATUS_TIMEOUT,		/* Instant Passed */
 	MGMT_STATUS_NOT_SUPPORTED,	/* Pairing Not Supported */
 	MGMT_STATUS_FAILED,		/* Transaction Collision */
+	MGMT_STATUS_FAILED,		/* Reserved for future use */
 	MGMT_STATUS_INVALID_PARAMS,	/* Unacceptable Parameter */
 	MGMT_STATUS_REJECTED,		/* QoS Rejected */
 	MGMT_STATUS_NOT_SUPPORTED,	/* Classification Not Supported */
 	MGMT_STATUS_REJECTED,		/* Insufficient Security */
 	MGMT_STATUS_INVALID_PARAMS,	/* Parameter Out Of Range */
+	MGMT_STATUS_FAILED,		/* Reserved for future use */
 	MGMT_STATUS_BUSY,		/* Role Switch Pending */
+	MGMT_STATUS_FAILED,		/* Reserved for future use */
 	MGMT_STATUS_FAILED,		/* Slot Violation */
 	MGMT_STATUS_FAILED,		/* Role Switch Failed */
 	MGMT_STATUS_INVALID_PARAMS,	/* EIR Too Large */
-- 
2.31.1.368.gbe11c130af-goog


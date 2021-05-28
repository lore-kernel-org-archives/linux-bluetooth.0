Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E36C2B9F7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 May 2021 18:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3B613F0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 May 2021 18:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhE1SrP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 May 2021 14:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhE1Sqk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 May 2021 14:46:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709DC061760
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 May 2021 11:45:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z4so2029578plg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 May 2021 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3uEYdQaE9mklSz6lSH6QvTId1krr+8BSTiOs8FjMlU=;
        b=EcNqTXsHQKQSXmvpWvp1e7t5floiGDoYys22aqmYRFNCyC64VuOjfFbfPoRNpAj3UY
         FuuZLV54LrvlI9D/b/lUEVtfOxIXxjGiZh8rc8+mxSSL7ZsyZ2jo8WxK9axOXKO8f7Wl
         7DQXptiY4zUv1hy9OzTzFVd2GxsowjsQS6bZmF6xEI1sFUDS9h2rYY5HMEbPYV7sztYf
         GWLrUKQMvk79n2ZfmdJ8eaCiNThBybOqYmXbe8RdT9Azr3ShSU1HPsnZ052mDBPtw9pm
         Gmaz/5rDAlJK6Hj6PtCXSl3E+ZSD76E+xVGKl92kL/SOod0BKf+q6G/FYPUR9KHKAgAT
         Qqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3uEYdQaE9mklSz6lSH6QvTId1krr+8BSTiOs8FjMlU=;
        b=OVzO8bRMtJ29JLXhLKg9GabItyZ+LbuzCR3JQrMX/qwyD55aQDxEofQzncYUQENJgR
         EDoC0CUCsByx+T1/k5IUzvUhX6kBgX4Wm291yIY/5B2asNYPR9PjLaLfsL0Tkn5EMVqU
         Uw9ZBMhDoRGQ1zCdXL2BfVC+yVeB7Hw5vPnAtcno8Gq9hqsB+kmkHHvyWE/Htjw812uZ
         USMM5ll8vcb7eJJ9yWFsHvDxL0vUXJh6410ZIy4aMGqn+rYwIZsMgHHg67Qc4l77hf68
         4La5Kzcq8l8nWqXuw2RkQCZpRsZY/1gueQivXjr1E9/T/DQXG7NZBgKs4+EpQLO7nVU0
         kmBw==
X-Gm-Message-State: AOAM531pp5UxkIk6jgNtNM5aOgkiV+xRKvn8WfM4i5olhYWj7GJq6Goz
        dsO4icgWzzlZY892a+dHfcSw4k+yGEU=
X-Google-Smtp-Source: ABdhPJyQbx07YRvGg3s40uagogYtWHDv4QzrWuK3nanGUOftxtV80yXoWPTjKKITL+VHL0UGl9/V+Q==
X-Received: by 2002:a17:90b:2397:: with SMTP id mr23mr5697436pjb.77.1622227503771;
        Fri, 28 May 2021 11:45:03 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g8sm4672765pfo.85.2021.05.28.11.45.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 11:45:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGTM: Fix slab-out-of-bounds in tlv_data_is_valid
Date:   Fri, 28 May 2021 11:45:02 -0700
Message-Id: <20210528184502.171731-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes parsing of LTV entries when the length is 0.

Found with:

tools/mgmt-tester -s "Add Advertising - Success (ScRsp only)"

Add Advertising - Success (ScRsp only) - run
  Sending Add Advertising (0x003e)
  Test condition added, total 1
[   11.004577] ==================================================================
[   11.005292] BUG: KASAN: slab-out-of-bounds in tlv_data_is_valid+0x87/0xe0
[   11.005984] Read of size 1 at addr ffff888002c695b0 by task mgmt-tester/87
[   11.006711]
[   11.007176]
[   11.007429] Allocated by task 87:
[   11.008151]
[   11.008438] The buggy address belongs to the object at ffff888002c69580
[   11.008438]  which belongs to the cache kmalloc-64 of size 64
[   11.010526] The buggy address is located 48 bytes inside of
[   11.010526]  64-byte region [ffff888002c69580, ffff888002c695c0)
[   11.012423] The buggy address belongs to the page:
[   11.013291]
[   11.013544] Memory state around the buggy address:
[   11.014359]  ffff888002c69480: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   11.015453]  ffff888002c69500: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   11.016232] >ffff888002c69580: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
[   11.017010]                                      ^
[   11.017547]  ffff888002c69600: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
[   11.018296]  ffff888002c69680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[   11.019116] ==================================================================

Fixes: 2bb36870e8cb2 ("Bluetooth: Unify advertising instance flags check")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 91d36c3bf23e..b52e39fe0285 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7590,6 +7590,9 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
 	for (i = 0, cur_len = 0; i < len; i += (cur_len + 1)) {
 		cur_len = data[i];
 
+		if (!cur_len)
+			continue;
+
 		if (data[i + 1] == EIR_FLAGS &&
 		    (!is_adv_data || flags_managed(adv_flags)))
 			return false;
-- 
2.31.1


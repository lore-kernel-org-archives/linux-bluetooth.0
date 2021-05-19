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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60417C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 08:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA2461355
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 08:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244825AbhESIWm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbhESIWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 04:22:41 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601EBC06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 01:21:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a29-20020a0ca99d0000b02901ec0ad2c871so9738905qvb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Oi7OTxmpu7W/M7bKwOWkQ59+6OhP5vTHEWzcTz3HpVY=;
        b=Nf+au9BWD6ei2K5zVQJCubmEKNLWujQkwAsuw5YMdvVRfVft/ZeUwCLhNbY5KKf4uc
         yRjgQS2+7XHS6pfQcjSb3MucKNpzy4ObKw3KAcUIazUX4YO1t+b7TYPAOpeE0fxsB2MN
         6RC+8P2CxKE5PrhChsneDfoMzB7m/4wIIQGUGcCJ2NZy8S62Z8q1XAycf+0QSntFMpvn
         HSQDrZr9yKjomO0zKUIQl2YR79ObzibnwxQanF6rYuuG1wuM31qZ223GEr0DwfBi77hf
         UFmOBVAgXeOZzJDzE2YZ85lPEOnj5NE7FuqSg1pBMfqHbL7JTHiJrSq06EGiVhoKs8dr
         PQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Oi7OTxmpu7W/M7bKwOWkQ59+6OhP5vTHEWzcTz3HpVY=;
        b=Rk+ecGlF7TS3Z6WMMQy9JXk/ToYuiSnP9pdiHsKHhvjdDX9JVibgIUgEDwjAw+wxrm
         f1NtbV9/h2BdF9ddULTghU4uf8qkKRB+yK6TfjrVd4najkr3koGoxbyrVPC4QGHC6Otc
         KeT6txdr0QWIh7MtPKfP+Crf1Ig9J8GAz2KLMISljYPvPcL1sH34Q/oGjVyJ5xgxD9+o
         KFuE11T2xZdXSFAPrKzrusAS0xD+uaEsnAyEJpt8b7oZuCGOU+xgHtmVCBtZF8fNYaTg
         1sJQsV+iTL/8T3zfbufourWtFqMo+yQkd89jAxkU/NwalHQUkU2AoIuLo1ElNKXQ62I/
         /9cQ==
X-Gm-Message-State: AOAM532k2c+/nflAy3T35pzC6dHlXk4865uYJGhPmJdm246CAYI4tydW
        hDIpsAlve93lIJgwr1TlgTMe401cSxUKbGgILccA1NRX5scKMPlSxzNtEwbY7RMysAuMu+/MnJ3
        CPrZkgNZ36NnRWFt/iOAiN+vaa84X2Dsm9PpZBg4PYTXoEWiccdO4VpIpqSM4Mri0Pcc3crHmgp
        oU
X-Google-Smtp-Source: ABdhPJyDGoCoo+JIh11WEooWeVA+ev8tXz5PFClfXVO4IkY9rE7IDetVH8PU0+xD7jm5Y0BQCpjvI12/OjH9
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:b2d:eca6:9351:b764])
 (user=apusaka job=sendgmr) by 2002:a05:6214:1708:: with SMTP id
 db8mr11542081qvb.5.1621412479825; Wed, 19 May 2021 01:21:19 -0700 (PDT)
Date:   Wed, 19 May 2021 16:21:14 +0800
Message-Id: <20210519162046.Bluez.1.Ic61b294b8337c492e9d4eab47d3c5709d8adacbf@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [Bluez PATCH] lib/uuid: Fix string to uuid32 conversion
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use strtoul to prevent 32 bit overflow

Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
---

 lib/uuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index a09321dc6e..3d97dc8359 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -209,7 +209,7 @@ static int bt_string_to_uuid32(bt_uuid_t *uuid, const char *string)
 	uint32_t u32;
 	char *endptr = NULL;
 
-	u32 = strtol(string, &endptr, 16);
+	u32 = strtoul(string, &endptr, 16);
 	if (endptr && *endptr == '\0') {
 		bt_uuid32_create(uuid, u32);
 		return 0;
-- 
2.31.1.751.gd2f1c929bd-goog


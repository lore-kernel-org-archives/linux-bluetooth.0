Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D969CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B632861051
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 11:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhG0LvJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 07:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhG0LvJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 07:51:09 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23C8C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 04:51:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso11416529qke.14
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0lka6lWigZmkjp8RUMd5y0cCJKV/Ez6gd1L1Jgdctfg=;
        b=Gal7vTPLSM3P6zTZaGcKhO4qy1khKzKDr8CJFPxNJdxQz8AKgXClEIDuMgiwjTOjGm
         gZfiI4ilSJwnT2w5VW9WOUEGqf73VgUy3LMDOjg1QlQW/ZF5GR1vBzH3zxOIHUbB6woT
         QDH5CWn8V6Kh3CRx1nA3kbSJGVsg8f6A5V2wOMpd43rXdlPBljJb+CWjJ+7ojdD2TN2v
         V+KW8kxLAnaPHbnqaa4SqORBvpEqrktWLhSVKWJK3DMQQ+NxQrpWwZRS/upkzFjhtzkE
         d8vLrF35+O3mTrZqUxsxT0sboxHzYbXRGffcFOklAYyYLmSFVI4UMbtYZW7N1Q7eEh/A
         wJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0lka6lWigZmkjp8RUMd5y0cCJKV/Ez6gd1L1Jgdctfg=;
        b=btE0DW2qa6nJvQtx/tzm3c1qeoc8OkcYFoeBXlD9MWgNBo+HFMwMbOp5TcEo+MddWL
         MOHgg/Un9PKk4p/hECX8RuZaAzm/3No6UROa++wf7StXyfFhQfKUjblsRCV7Ac1AeFxX
         b2CdplEuxNiy4b9PgGCBS57+HlXxvVgJWUkPuoQMG1qMu8WFMNJIiOIig2c4RfI+BKtW
         R9Yi2GDI5gKRlF3qzeoGK4M73lLRC791HcbO5MdKvedfVbdQiJ9JSXQi/JsOG8nHXSrT
         +7vXRgjUzV9DBun8mYRs13Yu0MLbz6Evz+DA3WMWMIbst2TwrBDnGtzlTjPvg4deXGia
         mxzg==
X-Gm-Message-State: AOAM530jWrFpGoYsWk004Iu9uUkwEDg/nN4YCi9ljrTtGP6hJw0TZMw2
        ON0gIvHvFAhPDvUlAKomzNcU+/sr5vjzLRBhaFDREKDkTCAQYpvCVgI1UhEDobAscGMQ9zvQRlt
        qn6eb9NpZ7cIPR7+BsLq4EwfOH3FexBC033MvQkmC4M8NdSTlJAmBNuLrSmeCKYcSXwFAVFBbAC
        ODjnulnFWlBEo=
X-Google-Smtp-Source: ABdhPJzf/h2wnxGjwG/FhekbwVqmyi14qW4k7f3Y+/n+EQroTqoTA+5z1k1qrnDpZ9q1ZEhvwvdC/kCmTF7kAn/dUw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:6c69:c2e4:9f82:994e])
 (user=howardchung job=sendgmr) by 2002:a05:6214:f66:: with SMTP id
 iy6mr19299576qvb.58.1627386667722; Tue, 27 Jul 2021 04:51:07 -0700 (PDT)
Date:   Tue, 27 Jul 2021 19:51:03 +0800
Message-Id: <20210727195057.Bluez.v1.1.I20397b8350f98567b8d52b895442c768250a6ab3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v1] gatt-db: fix service in range check
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

If foreach_data->start < svc_start < foreach_data->end < svc_end,
foreach_in_range runs foreach_service_in_range to this service.

This patch fix the above bug.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

 src/shared/gatt-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 8bff4d37aaa2..38d93f273a9e 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1349,7 +1349,7 @@ static void foreach_in_range(void *data, void *user_data)
 
 	if (!foreach_data->attr) {
 		if (svc_start < foreach_data->start ||
-					svc_start > foreach_data->end)
+						svc_end > foreach_data->end)
 			return;
 		return foreach_service_in_range(data, user_data);
 	}
-- 
2.32.0.432.gabb21c7263-goog


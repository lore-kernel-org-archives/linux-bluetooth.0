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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A05C49361
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 04:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A136100B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 04:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhFRFAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 01:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhFRFAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 01:00:22 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD6C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 21:58:12 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 81-20020a370e540000b02903aacdbd70b7so4286568qko.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 21:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X17qt7MhHUSEMu3p+ufn01XB2FZgaoigL7RLgxOKT2o=;
        b=v3xfR5VFor3inQ9y7iUmw6uqb1AfuGY/sKcprL6RtvEY3kXNvvd62e3CWtaqyZtDhv
         TR520h/sb36e2eyAi+rqmSZCh1NhLYQFEjeAWjP0RbHXemwwHhLx3FPp/wnFmu/pkkYY
         O/DD/n+qKmYCO8wrkJ5MR32FgJ6ZU3Bx26tT/AGvtE5vx3A359GwrmSoHWoGH1lNHonv
         jjY6awLs5Ydfntghde1DSEVASU9J2KL5nALoKqt3eNZvG/cTLX7fN3wwc6iWAujn831K
         xgd6xPQUHLF/8XHPP4aJXebTuFqRdBbssXF+p+ALtTsjdcrygKOmKLgWjgbKTzG66Mc+
         0DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X17qt7MhHUSEMu3p+ufn01XB2FZgaoigL7RLgxOKT2o=;
        b=Zird7csxLYiRidMu/GmNHiVJqAV03moQE+4mgZYns8qBbppPGvG1nEWxzDiBQFm+V4
         gEv4h8kMp0fDyIVt0G5iI/4NMA0WI5JYKSIk9H3/pA2JZNN66oLqD4nyVk8dL+gcCoP9
         Iv4XlvVGcgxZzrmsP/SeNZI0Od7bKLl48O3MNp+Z7nL9D1OP8DNqZajf2I25ZN4vWUg5
         f7adgTcN7lSdr+fqJvDjQi00mYJY91uLVplB9koqIJgnyrrslmc3RO2h1sB9wydk2Emt
         OHZd1vSvqKnEI0LOF4aFGWskoH9QuCVlysntTNjeIgWqwz2ej2xXNcBpQQSa5H6WeUYj
         uaAQ==
X-Gm-Message-State: AOAM530MRm7zWUlLTuRAzz7SLhUCeGxzBl49HvSLAhGBvI3BYfQDjCtb
        dpKY6LM3f9WNZFwWrMHzc7jY2+XKnC1l9g==
X-Google-Smtp-Source: ABdhPJxviF2rW9kCZw7WZ0Qc7qLTLSFn2AmF74g5Mdkl+9ATI6fcVrQHpHPilQtfbvezLd1LdwE4XOQbdRYgzA==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:d84a:3484:47ae:4444])
 (user=mmandlik job=sendgmr) by 2002:a0c:e8cd:: with SMTP id
 m13mr3690238qvo.52.1623992291017; Thu, 17 Jun 2021 21:58:11 -0700 (PDT)
Date:   Thu, 17 Jun 2021 21:58:06 -0700
Message-Id: <20210617215758.BlueZ.v1.1.Iaf42bf6ccbc1a06a9fb7f8da55bf7f2ef37349f2@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [BlueZ PATCH v1] adv_monitor: Avoid skipping non-discoverable dev on
 Monitor match
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>, mcchou@google.com,
        alainmichaud@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Do no skip a non-discoverable device if it matches any Advertisement
Monitor.

Reviewed-by: mcchou@google.com
Reviewed-by: alainmichaud@google.com
Signed-off-by: Manish Mandlik <mmandlik@google.com>
---

 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 98fc78f1e..2175120f4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6656,7 +6656,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
-		if (!discoverable) {
+		if (!discoverable && !matched_monitors) {
 			eir_data_free(&eir_data);
 			return;
 		}
-- 
2.32.0.288.g62a8d224e6-goog


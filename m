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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72C3C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47393619B1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 18:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhCXS6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbhCXS6s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 14:58:48 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE8C061763
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 11:58:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m5so2047641pgm.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Mar 2021 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J2gRbah3/sxh+a8CvKGl9udZqszaHhWDazihh1N3+d4=;
        b=I8G7iU8FmLHr8KTfjLswAKc13glUi3BaVoy9eMajWbHkYvja34Dyzmp/PTYMnbrmMc
         9rBzkYgPmwt1ebGV7wSKqwdUR7Cvlm8wJG6kKafavvfAX616VEaXL/Twy/fTIBeO4/Kd
         f6HtRnYlDNC6ZMCY569uKoUnD3H8n93op7Jl77XMzds/i1KDSo+Ni5eCKEYLqDNNGk2Q
         gbohfuI0VqrxbjfOWcgafePKWKKhlytZ1giDmK+N3o1ZI5AvVbo5akfGY2rceHNjfrct
         +r1ufyvXdFGbIqQNaNjN5MMFMUSbfR0ag3gPI/4VNMvk9E9NzcaIYmqN+vMmopdSXZaE
         EoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J2gRbah3/sxh+a8CvKGl9udZqszaHhWDazihh1N3+d4=;
        b=c1HdLVh0sv/aJc4heAs3239kaKBuy4tv10qzCSU9c9KRjbbex+mdrzN2gpzXApfXIh
         9tavu53i/7aKG71EprBAOQevEP4WNm9mSR3aI7qh8fJbkhLetiz9B6Y426E9VZFbWzZ9
         NmAswUhwqvg5dH05rxhaP2s87xuBn7hB362RbRo6oAjHHJ/RLRnQSMF47JRKOasNpOr4
         PB8qA7XbcYFzpH/Nxheu9JGWNzG5bmTWMijkcVYUapDsn4FA/bOlBcY+Mpr0Mk2iqY+h
         gDb3a8YCf/khW8qE6hIdbmjSR5YrXpGtNbFQc++tY0GZySxftr5VRu8C8JN8VE0/cT7x
         JzYg==
X-Gm-Message-State: AOAM531/AcWNCWckHAg7/gW82mHPdWWaR2vuYZ67t4RWfIWYYrnEFmCD
        PueSM6j8fTZOKRDeTNb4KBTZBv7uWSUd8jM5ntlPfKAt5U3CHRsSx8qSyVgUf9VO+U80M99hMZC
        cr56bmUeaM0E6fI+pJYSQLdBusN0HqNlKd+ZMbtYsGt3+WijGgyqJ9A1aiI4SObgqity5JBfSmn
        Eo
X-Google-Smtp-Source: ABdhPJyyb/ACHHEGrrBAxwAvpuqk8DCEwl/sLxt9lhsgMEKSbtzU+mQRDb35oz4NxeTl2qACpHL4hV7eU47o
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:a916:b584:a08a:3fcd])
 (user=yudiliu job=sendgmr) by 2002:a17:902:ea0d:b029:e6:f01d:9db5 with SMTP
 id s13-20020a170902ea0db02900e6f01d9db5mr4956741plg.60.1616612327877; Wed, 24
 Mar 2021 11:58:47 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:58:43 -0700
Message-Id: <20210324115840.RFC.v2.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [RFC PATCH v2] doc/mgmt-api - Return connection direction in Device
 Connected Event
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>, Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When an MGMT_EV_DEVICE_CONNECTED event is reported back to the user
space we will set the flags to tell if the established connection is
outbound or not. This is useful for the user space to log better metrics
and error messages.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Yu Liu <yudiliu@google.com>
---

Changes in v2:
- Use next free bit

Changes in v1:
- Initial change

 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cab1fffc5..98552e761 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -4088,6 +4088,7 @@ Device Connected Event
 		0	Reserved (not in use)
 		1	Legacy Pairing
 		2	Reserved (not in use)
+		3	Initiated Connection
 
 
 Device Disconnected Event
-- 
2.31.0.291.g576ba9dcdaf-goog


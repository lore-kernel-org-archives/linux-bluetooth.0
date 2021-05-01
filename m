Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1EEC433B4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 01:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E25613D8
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 May 2021 01:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEABel (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Apr 2021 21:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEABek (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Apr 2021 21:34:40 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08380C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 18:33:52 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id u20so100703qku.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Apr 2021 18:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+IHpwzbcfBhgeDMJZW5X6W9sy6cPBmvBdxGWHGxdNns=;
        b=GUnrekxsu5O7O4D7ztUw09JXJFG/SzjOfhK9OCIJkUB47sSLsaX8M2EOFwr9FP8d3y
         VaI7pQ+mOZ1Z3JDw1onXfC7QYjoL4EMTLq5UMvcRg433Prbd2flL6bL1prA/KsznD6MJ
         z92Qfdsz/HNqgxhn1asciOidwCB3TDnsHsgVyOcuTOrt0IYJk7lc3EHev6+P0jvL43+C
         cZXWT8DDm/qxkXGLpOdVyH4WEbSpd/6uCvgVnGdZ/6noPeGfKDRXjYPSuSAX/z5dOKMY
         Ps0FHwUoPNLGuIlPSixAVGkdBkAcZdCpJNhMjdz0TkORZ1Fev4qfi+9dUuwouhKyF7It
         N5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+IHpwzbcfBhgeDMJZW5X6W9sy6cPBmvBdxGWHGxdNns=;
        b=RRAYMdCaIkNCfPNwRCnYV17HgxpHcuoJ3eDoB9Rfcmq4J9PZr66qGIu5JRtWlem1OD
         OL4hinawjKg+V299eFkPoq4JKxBiz8+kKugiFfNKwSFs+JXvrUZoxSmetJVgNkixkgbM
         lB0A/21KBudwLWODTCRU38kZTa9BrgCAqfKIgrU5uwyJnC1cy1qmBINoTAwuKT8SfdAb
         o1zWi0afTByZ8i9G5NO3CcQfkj2mj25f3FpwFno88Wk6IpVIiD3Y4VKoXqWHgWQ38JcV
         1g28w2hgFAT0WbNuP+jmeg68t0/+CGsVE4bCG1bBQhCHzQT2JqwfcWkeOnFMQyUoWfhh
         lUcA==
X-Gm-Message-State: AOAM532ArT/hWM27dzdChIws8FnVuJdTGmBQ4aJhmX2SZDtICHAtI+qX
        GOoENCQhpH1Q+mJJq1il6tQw9LHrUeJ3JQ==
X-Google-Smtp-Source: ABdhPJz3PyiB4ve5Pt1iviYg2ub+MQrpaoqM0AqMqdN62QkkQNJY5y0/B+UDK5bKQu5KfQd5qzroIQ==
X-Received: by 2002:a37:4595:: with SMTP id s143mr8726953qka.394.1619832831058;
        Fri, 30 Apr 2021 18:33:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.168.165.248])
        by smtp.gmail.com with ESMTPSA id n14sm2838047qke.123.2021.04.30.18.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 18:33:50 -0700 (PDT)
Message-ID: <608caffe.1c69fb81.c1efc.36ef@mx.google.com>
Date:   Fri, 30 Apr 2021 18:33:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2427776732514944783=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] avdtp: Fix accepting invalid/malformed capabilities
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210501003717.7553-1-luiz.dentz@gmail.com>
References: <20210501003717.7553-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2427776732514944783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=475947

---Test result---

Test Summary:
CheckPatch                    FAIL      0.63 seconds
GitLint                       FAIL      0.31 seconds
Prep - Setup ELL              PASS      40.36 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.95 seconds
Build - Make                  PASS      173.87 seconds
Make Check                    PASS      9.34 seconds
Make Dist                     PASS      10.67 seconds
Make Dist - Configure         PASS      4.33 seconds
Make Dist - Make              PASS      69.15 seconds
Build w/ext ELL - Configure   PASS      7.06 seconds
Build w/ext ELL - Make        PASS      160.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
monitor/avdtp: Fix decoding of reject type
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#11: 
      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 2 nosp 0

- total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor/avdtp: Fix decoding of reject type" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
monitor/avdtp: Fix decoding of reject type
8: B1 Line exceeds max length (85>80): "      AVDTP: Set Configuration (0x03) Response Reject (0x03) type 0x00 label 2 nosp 0"


##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============2427776732514944783==--

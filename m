Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC070C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A396A65120
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 17:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhCPRJA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbhCPRIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 13:08:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C34C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 10:08:54 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id g185so35966844qkf.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BQ69zkW08SzBkhLS7p9P/7MJkE6Bm4pVLMxYE7E5rVo=;
        b=B4AAkSPN/b3x9Mmd0GYhVE/yC2vZD3bJHsS94m+q/KLcwAKgCfX7ZiBSo05PZtBOwQ
         HMWm3Db0JbM2JpTpuuynuTNcvlmrCwDnKwB1jucVyXuD0SF1oU+wXSH6vwvdWvncxavc
         hfufCnrDndojHP4c5j3VQwszqd0tzgm2oFf+NxU4Vk8Gi4MwSapwoiSb1ehMp+hPEHkF
         MWtvIvwDCg6SqywDmQSHuTsbhnmzjRJE3HvbfSny9EEIjHg56ESqipen/TojzJNhD3J9
         jlkGVZlOj4psA+ZZhpiYP1WrFDl8CZ0+YRqKyKIaN/JZ3BSqt9RS2WrTpyYPdVpFJvIQ
         sWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BQ69zkW08SzBkhLS7p9P/7MJkE6Bm4pVLMxYE7E5rVo=;
        b=nTXi6f3gbKqohDX1g3QVE/8oi56avkNd5U9G3tAYV3g+AX8bKyjvLjuAeqnR0sSd1y
         5pVUDCfz9WMCl7cnHBWE6fUdT1Lv1Pw7sxOn7gNykUKIAJpPRdAO7wSsU7w7dooYimd1
         sNa8A5+Z7hESuYVCbKhVXMHfBzwM0I8+U2KbWzXPTp/e7DoNI9rPE3O8R9y0H0CmRiOF
         OPoAMUQ9LCEeiLBWJ+oBbUcpvsec3oeQ8iBUOh9JCUxHSuFBmzy/aRqS2xdcJ6Is7E3i
         LvKksLAGbkzGIKpVwzp7eA87GUJS8LbwiRouk0gmtDfIH2+feg6Osb+n0GhJNbEyIQLz
         5sGA==
X-Gm-Message-State: AOAM531VFRRLIWCh0LUoZMs//P3yv3GXaKJQMnxNyH4oFRpw5AwWubC0
        Yz+9Y4ujYtXbJBeg8acMv1bDu9c+PSx37Q==
X-Google-Smtp-Source: ABdhPJwErBXtYYz8FPAwdYGhsSfibr75qyaHo/gEsN7NQKhg9kHNMGXPwrPH7Qy1qL2kFc8MMV6sAA==
X-Received: by 2002:a05:620a:801:: with SMTP id s1mr49997qks.152.1615914533114;
        Tue, 16 Mar 2021 10:08:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.215.155])
        by smtp.gmail.com with ESMTPSA id s6sm13773877qtn.15.2021.03.16.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:08:52 -0700 (PDT)
Message-ID: <6050e624.1c69fb81.d8d7d.8758@mx.google.com>
Date:   Tue, 16 Mar 2021 10:08:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4840860611439554250=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: adapter: Fix discovery trigger for 0 second delay
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316163928.27279-2-frederic.danis@collabora.com>
References: <20210316163928.27279-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4840860611439554250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449263

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
src: Replace calls to g_timeout_add_seconds by timeout_add_seconds
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
Replace calls to g_timeout_add_seconds() by the timeout_add_seconds() wrapper

- total: 0 errors, 1 warnings, 669 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] src: Replace calls to g_timeout_add_seconds by" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins: Replace calls to g_timeout_add_seconds by timeout_add_seconds
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
Replace calls to g_timeout_add_seconds() by the timeout_add_seconds() wrapper

- total: 0 errors, 1 warnings, 286 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins: Replace calls to g_timeout_add_seconds by" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

profiles: Replace calls to g_timeout_add_seconds by timeout_add_seconds
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
Replace calls to g_timeout_add_seconds() by the timeout_add_seconds() wrapper

- total: 0 errors, 1 warnings, 762 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] profiles: Replace calls to g_timeout_add_seconds by" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============4840860611439554250==--

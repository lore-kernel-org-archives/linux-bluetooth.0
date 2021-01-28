Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B12C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 07:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E186564DD1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jan 2021 07:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhA1HgK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jan 2021 02:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhA1HeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jan 2021 02:34:02 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635DC061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 23:31:00 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id n3so2359244qvf.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 23:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3gvbAPmDZrJ8z4ark2lmseJw62VlIU2H5t61tLwy9Jc=;
        b=Y5K1D43q+WLgT+SLiE9BRGLnYcvfNIvwzZXTPXFVW1yKeiw3RwUOzHvR+rLhFen3Ln
         uAQGVylL/r6cVSlTi9+gdSMMawRjHGw/EENpHYoHFiI6Vto58r0EeExE/8YtWMG8NB8r
         Ik/4yBzTBJZdwz5wbENutdcj/uAy7D4U8LhuXdUx0nr+iV/mzSkcCn1tr+/8tLcxY0EB
         rfXG5XAlCVgNpWgO6Jt3Oz8Kspapu5+/U9lAlbJhQ8k8yVYTpjg75+r4GWYjCVnhkEXp
         QCnsqb+NbPtZwCph1xKvspQvmDjrnLLpDEswpRgxm0pniNKAKmtYBMHl5hwD9L4s9x6o
         LrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3gvbAPmDZrJ8z4ark2lmseJw62VlIU2H5t61tLwy9Jc=;
        b=nrNI0QA6H5Sl8eybEmu3OAWaARQZBajPTMHSAI0Nx0LHvMoTJBvdrDLaJmdG3zs4FH
         +FbFX7fMw4jRM40GceN0yLAIDLEduX+tcf7lWEpzkpJUeZeKEtwDqOLRzPu41lw4GLNL
         8kONfC+WczGlI2oAuarBJMGyhy77B6SRY5iVWGfCyWNhiO6TEIITUu6LWSuei2jfl1Kg
         uVMirXJNny8k9pzTWt34Qs2WJmSiVsloH/YAgfJn9qbT65Tf87oKTI3GvRSsnQLARNg2
         /Lj8TXJPnluxstZ43X3UMQUO2olCAyhFmb8bFlXA+Pv8VkDOMNnMHEAR9UEi5uyr1ymb
         Y7Gw==
X-Gm-Message-State: AOAM5337lf7bEwCZuVuocLOJRnK/cU1QVDVLFJmB682eW3+euxaCA+gf
        2HGjhWERGC0Q4WFZ7fO/NO8k9En1Q0UwOljN
X-Google-Smtp-Source: ABdhPJwcoWWuylnFpR8PJooTKMhgyPARJeDHxE6KTXZTf3KPxNRvwo+HqwRIcl4MKRnF52YGiHAH6Q==
X-Received: by 2002:a0c:8485:: with SMTP id m5mr9933449qva.14.1611819059848;
        Wed, 27 Jan 2021 23:30:59 -0800 (PST)
Received: from [172.17.0.2] ([52.179.166.64])
        by smtp.gmail.com with ESMTPSA id o10sm2802330qtg.37.2021.01.27.23.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 23:30:59 -0800 (PST)
Message-ID: <60126833.1c69fb81.612e1.26ba@mx.google.com>
Date:   Wed, 27 Jan 2021 23:30:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1789246990046480211=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v2] input/hog: Fix crashes of UAF of hog->attr
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210128063901.1362-1-sonnysasaka@chromium.org>
References: <20210128063901.1362-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1789246990046480211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=423455

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
input/hog: Fix crashes of UAF of hog->attr
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#21: 
    frame #7: 0xec8e6a1a libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3325

- total: 0 errors, 1 warnings, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] input/hog: Fix crashes of UAF of hog->attr" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
input/hog: Fix crashes of UAF of hog->attr
18: B1 Line exceeds max length (81>80): "    frame #7: 0xec8e6a1a libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3325"
22: B1 Line exceeds max length (86>80): "    frame #11: 0x05ad5a64 bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1789246990046480211==--

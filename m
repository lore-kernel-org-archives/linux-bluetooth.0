Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E18C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801DD60EFD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 09:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhHDJkD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbhHDJkC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 05:40:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713E1C0613D5
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 02:39:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so7917913pjs.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=12Yil9vx56ZCTnwK2qkWtsAE730j6dEshL0uYEftets=;
        b=E96ZCj5Hss9oh0jpfwhszLocSM0DoxI8wRVgApfyoYOcDqGo9mTIuX7UUvj/ekJczr
         5+D9F4T2GdA2bFghopV6gJ4l2s0RW47dG3cj2FpGq57/dFGOd2NmC82I7/XJtsnyYROR
         iVIYsK/19/0pzgzFbv0ryP836GYsFiZhMcN/2ExHiP5IUCMAsIrjBSoOAFHtZvLH7VON
         FmAOkyzZLQSYXGrBJiH8piyQ0aZyGeRWLFxJgDumP+L5BZlQU/1a/UM8aDDbXvh2J1Ll
         1jTw5O4e2hO711SjLLBAVfPSH/M7+2Bwnwlsu6EgjQCUYPA8J4OvW/a+ry5/ulg2kErN
         6sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=12Yil9vx56ZCTnwK2qkWtsAE730j6dEshL0uYEftets=;
        b=FuLkjsF9xnJm1i+LEJlsL8BmtjhFdUuwtCwya/rwTpvdopnHNkZQg268RdP1R3dwVb
         iLH/Bn0Gmbve2Tbnpf05Zuy/qYV/jmSJT5X3nEZ+/foXCZ9MtdioWbbCENr81daGT154
         6kerF4Iz53qw6ULrNL173CRV/8IDj0ZO0ulwTYEFIgvu0TI0SpSGpGDIpBlg2OUqV8O+
         mhyxn6rj/aXLgehkOkgd3+5BxcryHxrI4tw2NMBLD6oiBwOENWuv84A4sjQfMhmRlpGP
         bwM/+5dqx5EoMhzbSr2fWSkyxcHCLLzTTRNzt4G49fjL5ZOf7hOim+i6Ng3G3RaTdeMc
         OhPA==
X-Gm-Message-State: AOAM530LUb0JnUUaggcWLN407gZ437uiiNkHk4UVDbvPYCeX5UHpxOJd
        1sLfcsffKYy0Dyom8ILGm4cJIcPiKmg=
X-Google-Smtp-Source: ABdhPJxTrlTpg+2AXzeunOqbRcEp17xPkcJj696c1c4IrCFnxRWnwrXMTNXH4gmY7QGPXs6zp7alXQ==
X-Received: by 2002:a17:90a:4b02:: with SMTP id g2mr26867023pjh.44.1628069989787;
        Wed, 04 Aug 2021 02:39:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.156.66.30])
        by smtp.gmail.com with ESMTPSA id q1sm2166913pfn.6.2021.08.04.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:39:49 -0700 (PDT)
Message-ID: <610a6065.1c69fb81.c5f80.6121@mx.google.com>
Date:   Wed, 04 Aug 2021 02:39:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0895523727892670627=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mariusz.skamra@codecoup.pl
Subject: RE: monitor: Fix truncated server socket path parameter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210804085937.541076-1-mariusz.skamra@codecoup.pl>
References: <20210804085937.541076-1-mariusz.skamra@codecoup.pl>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0895523727892670627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=526107

---Test result---

Test Summary:
CheckPatch                    FAIL      0.39 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      46.93 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.18 seconds
Build - Make                  PASS      213.24 seconds
Make Check                    PASS      9.51 seconds
Make Distcheck                PASS      250.91 seconds
Build w/ext ELL - Configure   PASS      8.58 seconds
Build w/ext ELL - Make        PASS      204.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
monitor: Fix truncated server socket path parameter
ERROR:GERRIT_CHANGE_ID: Remove Gerrit Change-Id's before submitting upstream
#11: 
Change-Id: I646f86709d59d33b8f1d27b725eb42a9f44f6f2d

- total: 1 errors, 0 warnings, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Fix truncated server socket path parameter" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

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
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============0895523727892670627==--

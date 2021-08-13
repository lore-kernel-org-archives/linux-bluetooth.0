Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 01:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1326103E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhHMBYI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 21:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhHMBYH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 21:24:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A68C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 18:23:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w10so7008304qtj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X2rvpAjM0twCd9tbOejnEzj3Paml1wfZbAxP1kJP9XY=;
        b=A8lrEPx1mdPcq9MYcoP8G3EwyBPIE8istbSUWXECv6WYgPLtG5ob2v5EmJ7O1yb/f7
         93rX/zLXTNxAwtiF93sJ7sc1wsqx0ScR55zcOl7NTmwQ3NRl3889Aqmy1oPL+7LOgmyN
         AYtvtDpS+N0FtFdnF0Njv2sAHBagJOrrhwVBA3tCu69EuQNyj0E7C8zqsGj69jMHu7a9
         YjjTfQHW0u1hcvFstsbifjcEeGGp+GnJPd7rf/ATK28+aPcvWCrIwurWksNXXLX1Mqhr
         XqeJQy/ChvOPD3ICe2wIonBBjarXO4VQgTbkjx62MK7aDDeE9JygpaUsPq7bM47Xuy/y
         2scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X2rvpAjM0twCd9tbOejnEzj3Paml1wfZbAxP1kJP9XY=;
        b=mkg+MOYw1aXhE5sa15bjI6uOSsZmlnTPKeAMsXUGZ5Ph4dZGO+zcfE3oah8s9DHxer
         Hptt2ulfw6U7zfylf/OyWOeVKTIssxxoomQQHkMMRKyzWmSYl4DJ/m1kb6D8/509XjEW
         2P0KfwzooH+hl067TnlhFV2+TdxeAuJue5hzqnBSjhlb3sfUIcUqStc6sQbjLfMbCo02
         uYASj04tp8lovWtghsIdgvWP/egF1PiIJfLiOG1x/v9v4bA3NLdEWPXJSqZGzv7/y3Jg
         b2bjSdCMkJoDuettxurQhS8kn4KzuWrDogwXjmKsmA6NacIb2B12cO3fzeL2U8Brol5a
         YHJA==
X-Gm-Message-State: AOAM532xfeWd9Gbp8aeuJdJbuQGPCliKKY6ft0NsBWKhq5I2zdpm1Z0P
        dqPqtz1R6SXoaDlbuKfqVZTUQtGH+TCUPw==
X-Google-Smtp-Source: ABdhPJz3iIMz7QiO/UeutgAvSoC50GW+pY17RTm5PKJv0+ZGZ2y6mqtuKiy5g+ccs+lssq563AsIig==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr5638281qtq.133.1628817820335;
        Thu, 12 Aug 2021 18:23:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.47.15])
        by smtp.gmail.com with ESMTPSA id w20sm1505201qkj.116.2021.08.12.18.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 18:23:40 -0700 (PDT)
Message-ID: <6115c99c.1c69fb81.abacf.ae31@mx.google.com>
Date:   Thu, 12 Aug 2021 18:23:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7442640767885550294=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] bthost: Add bthost_debug and use it on smp.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210813005739.1043743-1-luiz.dentz@gmail.com>
References: <20210813005739.1043743-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7442640767885550294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=530891

---Test result---

Test Summary:
CheckPatch                    FAIL      0.34 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.10 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.08 seconds
Build - Make                  PASS      175.43 seconds
Make Check                    PASS      9.31 seconds
Make Distcheck                PASS      209.33 seconds
Build w/ext ELL - Configure   PASS      7.18 seconds
Build w/ext ELL - Make        PASS      165.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
bthost: Add bthost_debug and use it on smp.c
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(2, 3) over __attribute__((format(printf, 2, 3)))
#163: FILE: emulator/bthost.h:31:
+					__attribute__((format(printf, 2, 3)));

- total: 0 errors, 1 warnings, 210 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] bthost: Add bthost_debug and use it on smp.c" has style problems, please review.

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


--===============7442640767885550294==--

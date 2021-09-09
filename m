Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 22:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2980B61132
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 22:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbhIIWzI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbhIIWzH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 18:55:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD535C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 15:53:57 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x5so2995808qtq.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pOAibUXiWZzbkoxvYMSlnel8xXiC3wluPRkpJCJPzCc=;
        b=PSfGIiqHLinTQaIr4FrkcxS5Wft3IU+ECdsMVkW1SzarDTr/bMpzBWP6JX9w2IFcvy
         obZ9Lw6RNGmYEtXUNzblLRd4aHaL/mu8QruHtylsSvXfqAIJ7GhIgBkpUE9kbtC3u5ds
         QMSvWT0DYEr0IuO+t6cQLHNGXUafBfB7nXFGPqHTlSgIQs3Pxjp5CrWRYsAvBlzj1MbA
         RKhh7A4JA60J7f0N2YKpVomq2xcJctNZqjunhE9iE3BQo8K/ZB4lMH2kBqizGZ4tR0tP
         I2DSXfyRakzgC80GCbLW4JKPActW9wjIhi8scva6z6zjT4wuZvYLLcTfhgBm16SEaOdT
         hTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pOAibUXiWZzbkoxvYMSlnel8xXiC3wluPRkpJCJPzCc=;
        b=XUmmX9rgX+InWlDu1v1YtBMfhvKyICGdyxmtX3em8wjcudrTH4uJ/YmwMkFbLwpit2
         VBWujckBEku1il45wezeSJBtR80GePL/5sFsd6vopcIuLoEHZVscQXOTVM/GqUngoLn5
         rAYzmGjgiAy6SrNeJSUibQ/baIO6CrzPFRYOhN3NpcyQy4Tha2Ld0uPMZ6b+OPEn3tyq
         Q4qLxdnBTfj0SC4KM2FzO71cYSQdVuj4RsREVWwtJBSSG5KzgEArkgK8IXsrfCQkN4Qe
         im2xIB+CbPLIx7oUnb2mtJKvPhXNQnYkD2RuJKhJyT/gfiJVPmEAbKl1uOAyZwIll48r
         nziQ==
X-Gm-Message-State: AOAM533HgL+ZBE52rZfeMDrulU3MkhOdA0xFGTlkLTb25Q8yfhw2pyB9
        BWa7p14ZJSh/BoivninDs/tcHf4pc9I=
X-Google-Smtp-Source: ABdhPJzzgeiVsvuKKIQJpKA4XGMbZYgRCm1/yiK/zrHwlT1l/ISwb7jeyIyavpCjqR90dVSsfxyhhg==
X-Received: by 2002:ac8:7761:: with SMTP id h1mr5124381qtu.272.1631228036839;
        Thu, 09 Sep 2021 15:53:56 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.96.243])
        by smtp.gmail.com with ESMTPSA id l11sm1938443qtv.88.2021.09.09.15.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 15:53:56 -0700 (PDT)
Message-ID: <613a9084.1c69fb81.f0418.e21b@mx.google.com>
Date:   Thu, 09 Sep 2021 15:53:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0597792293928854047=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Add test cases for load_long_term_keys command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210909223547.164560-1-hj.tedd.an@gmail.com>
References: <20210909223547.164560-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0597792293928854047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=544659

---Test result---

Test Summary:
CheckPatch                    FAIL      0.49 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.41 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.10 seconds
Build - Make                  PASS      176.54 seconds
Make Check                    PASS      8.72 seconds
Make Distcheck                PASS      208.03 seconds
Build w/ext ELL - Configure   PASS      7.16 seconds
Build w/ext ELL - Make        PASS      166.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/mgmt-tester: Add test cases for load_long_term_keys command
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#330: FILE: tools/mgmt-tester.c:10927:
+				setup_load_ltks_20_count_1, test_command_generic);

WARNING:LONG_LINE_STRING: line length of 83 exceeds 80 columns
#334: FILE: tools/mgmt-tester.c:10931:
+	test_bredrle("asdf Load Long Term Keys - Success 5 (Power On and 20 keys)",

- total: 0 errors, 2 warnings, 323 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/mgmt-tester: Add test cases for load_long_term_keys" has style problems, please review.

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


--===============0597792293928854047==--

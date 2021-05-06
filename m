Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64785C433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42941613BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhEFCfW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhEFCfV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 22:35:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DAEC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 19:34:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h11so4226957pfn.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 19:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EdWgWzzNpVM+9pKFysSf+AfRGvHD3/7WwRduBFVkOYo=;
        b=pza40H5u2bFV4UPHTStWycno0fEC3rvJRBzk6NknmEE/dTiJRflZ3SH0cyUhfgGSvM
         8y8PgxUDdZTrFhx0qiqLAxmLvB8rw68+UMZ+3GGNay9YJPb9cYr8Pl/yrrV6N6Yz4AKj
         rcf8WR6udQdpXKpo7e2Xl+BJBM8snwRYQX/6FIWBpZLfbkLTGep/E3BE48HXeARqAGdT
         ogiAF+b8HcUC6JwKb3+IBfvtNI0/cwT5SGh91uhliGRifs4OR1D9kY6bGV7gojbxLDu6
         Zd5/WkldhCboW+emCLc8yfWfWpLEeVnV7RUmSVl8Unz4kYz02oQNnEEZFpKv2/Vy2F75
         6WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EdWgWzzNpVM+9pKFysSf+AfRGvHD3/7WwRduBFVkOYo=;
        b=AtR8qHeMGMWYAbS5LYfnFJfplTdS0DFH/wxHD5PCyKL62Iyq9is+1n8Lso10bKEsiG
         oxb/ki8O5VvaxT47XlM8a74I2wukFRAcRcImCA2QHkuzvQDmcy5vgHpQuS4BBjSph6II
         9jaEhM3ss/Ry82TonnHN7j5deF7Hrsos6B/NrBmkqqvB1z7eU+1iYyWfR55Qd9H4XfBE
         AYAj3/m+rqGAH4EkoExVuyHl3pIyJkYWDuhS8pHDjjCSh0HnnkRyq1IKQ6PjTdVyoNtk
         F0CDJV2jAnYuDVsRQWyD9ORoerwKCQd34qxROJfQ3FPiBquRWQxIE4pTuEwaDX8N6EIG
         dkzQ==
X-Gm-Message-State: AOAM5336U6T9kRJ2TH6tp2KU+7VyhBQkz+SBtrLuvlOi8N2X3kVuuJ/C
        yFAZB42aWZWNsFW0j4aY8Z5sQiJICpY=
X-Google-Smtp-Source: ABdhPJx1onN9w/5TKNfNMgOpwnWzNpWPFYE/iN4QsIwlGY8j9qH65ImVj3IpexIMBS1K0HCF8ozQhQ==
X-Received: by 2002:a63:e903:: with SMTP id i3mr1878277pgh.374.1620268463322;
        Wed, 05 May 2021 19:34:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.143.64.105])
        by smtp.gmail.com with ESMTPSA id d8sm459207pfl.156.2021.05.05.19.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 19:34:22 -0700 (PDT)
Message-ID: <609355ae.1c69fb81.470e7.2355@mx.google.com>
Date:   Wed, 05 May 2021 19:34:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8207463135052349952=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: RFC: convert tester tools to use ELL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210506021817.289939-2-inga.stotland@intel.com>
References: <20210506021817.289939-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8207463135052349952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=477641

---Test result---

Test Summary:
CheckPatch                    FAIL      6.19 seconds
GitLint                       FAIL      1.41 seconds
Prep - Setup ELL              PASS      50.12 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.54 seconds
Build - Make                  PASS      208.48 seconds
Make Check                    PASS      9.62 seconds
Make Dist                     PASS      12.47 seconds
Make Dist - Configure         PASS      5.29 seconds
Make Dist - Make              PASS      86.32 seconds
Build w/ext ELL - Configure   PASS      8.61 seconds
Build w/ext ELL - Make        FAIL      68.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
shared/bttester: tester framework wrapper to use ELL
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#78: FILE: src/shared/bttester.c:51:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#83: FILE: src/shared/bttester.c:56:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#335: FILE: src/shared/bttester.h:22:
+				__attribute__((format(printf, 1, 2)));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#337: FILE: src/shared/bttester.h:24:
+				__attribute__((format(printf, 1, 2)));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#339: FILE: src/shared/bttester.h:26:
+				__attribute__((format(printf, 1, 2)));

- total: 0 errors, 5 warnings, 318 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] shared/bttester: tester framework wrapper to use ELL" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
shared/bttester: tester framework wrapper to use ELL
3: B6 Body message is missing


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
Test: Build w/ext ELL - Make - FAIL
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
/usr/bin/ld: src/.libs/libshared-ell.a(bttester.o): in function `parse_options':
/github/workspace/src2/src/shared/bttester.c:206: undefined reference to `__stop___ell_debug'
/usr/bin/ld: /github/workspace/src2/src/shared/bttester.c:206: undefined reference to `__start___ell_debug'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5959: tools/mgmt-tester] Error 1
make: *** [Makefile:4082: all] Error 2




---
Regards,
Linux Bluetooth


--===============8207463135052349952==--

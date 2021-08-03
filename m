Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99829C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B5060EE7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 12:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbhHCMvU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 08:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbhHCMvU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 08:51:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5016BC061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 05:51:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 184so19711147qkh.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WLKr6gwXSoXWdHUu+DI4nXAF1ZLteBH0nGBdw5Eo6jc=;
        b=dMy5dnD0W1Ts4OTWCOWPtCVLwOGr6brUolmu+e/RO0Hl1ljSwWpO8ZpRIzjCYOqyEa
         x4YZBVLkGxtIlC+5krUSW1JGZoJncNd/h+6SdQ58E0wmwKmdcVf4ym0aEAPAsjOv9mCo
         62rZA0Zwy0a8bFdxvw+YB072Akw+Q11i5IRdf1veA9iIWzNCsQLnrzmIn9AyXpp3dnNP
         CcG99g264jWN2tUv6KorS0qegOUEyCyp+B1BAQSHm0EaK0q/olCSRXoQvJdBth0BUKUy
         mls2HjrjnDDqRODouLE45yq65HtsYVf4YZSUDZpnpB/fvLQhlKK4r/dPp8RwPUbAmbe1
         wjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WLKr6gwXSoXWdHUu+DI4nXAF1ZLteBH0nGBdw5Eo6jc=;
        b=QDfJymdGl1oYd7vKji3aEJxnf9crW7NFMSt1MZu9YwY75K11F6phb7uIb4jz+pNOtq
         RkwPBlj6VkRMFzZD4naj5j6mrWjxyz4skjjODmBhsRSjZw8eLnSRJLj80Olmv8Q397yb
         TD+YxzztYpEZfGx8Qz5VhNbYq1ERh38ERYp9xXh+NXiGFUVZUpuyo/3fmkFw02PAun9Q
         8OwoE79up4kvKdFn0VHoR2g42JcbSYAghv3j4JbUEKNitpy9N19C0SVoZRWtlwAnymvX
         qcfC10S5QnSUkNEkgRdp9XCgRTqAD6CHCXyVmhh16+qyAzsfCl6iJnN9F2e1Cp2foRMG
         +k4Q==
X-Gm-Message-State: AOAM531oF7AD6kW5+ru9c4YhJ39L3otiMBtY/C0juelCgLHM5M+QqnSt
        Bt0HAGenOhg6DSQMDSmK5ZYrx3yX42uacQ==
X-Google-Smtp-Source: ABdhPJy0Lg9aXXMHwuwGsYkDOsxQoIZTRQ9wrVa9bCP6KXMDw12pbWqe9TsfrruqR5+Pw5xwlzp9+g==
X-Received: by 2002:a37:cd0:: with SMTP id 199mr20255653qkm.69.1627995068356;
        Tue, 03 Aug 2021 05:51:08 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.60.133])
        by smtp.gmail.com with ESMTPSA id a5sm7806712qkk.92.2021.08.03.05.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 05:51:07 -0700 (PDT)
Message-ID: <61093bbb.1c69fb81.73b3e.d5a9@mx.google.com>
Date:   Tue, 03 Aug 2021 05:51:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0033483766674438266=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: Admin policy series
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210803194127.Bluez.v9.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
References: <20210803194127.Bluez.v9.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0033483766674438266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=525571

---Test result---

Test Summary:
CheckPatch                    FAIL      3.18 seconds
GitLint                       PASS      1.20 seconds
Prep - Setup ELL              PASS      37.20 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.46 seconds
Build - Make                  PASS      162.07 seconds
Make Check                    PASS      8.13 seconds
Make Distcheck                PASS      197.73 seconds
Build w/ext ELL - Configure   PASS      6.78 seconds
Build w/ext ELL - Make        PASS      152.94 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
plugins/admin: add ServiceAllowList property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#63: FILE: plugins/admin.c:186:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 82 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin: add ServiceAllowList property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin: add AffectedByPolicy property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#65: FILE: plugins/admin.c:254:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 120 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin: add AffectedByPolicy property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin: persist policy settings
WARNING:LINE_SPACING: Missing a blank line after declarations
#135: FILE: plugins/admin.c:260:
+	struct queue *uuid_list = NULL;
+	gchar **uuids = NULL;

- total: 0 errors, 1 warnings, 208 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin: persist policy settings" has style problems, please review.

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


--===============0033483766674438266==--

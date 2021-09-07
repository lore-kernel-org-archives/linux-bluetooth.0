Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53428C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 11:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE4610E9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 11:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbhIGLzC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhIGLzB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 07:55:01 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8361C061575
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 04:53:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id gf5so5580429qvb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ENrJT8I7zKWKz2n+Cy4xuDlxucVI3SgIMNvo8fP6ikE=;
        b=bJnIqxfbXzBWFpiOxBze8BtzKAlLhS8v+jEtuoWBleHXYbwaV82WHuBuejLuLH/0xj
         XPR/gYz6x/QJ27sjTM+VQdFJxPDzm3b2D/35maJZdoVG5l2EF/o6xB/wsVxavidOpTCv
         Au88wPqnd49a/Fbe/ohn1s/e2Zs5XaC6gsnsb4heHID7FFzt1Gejx9+XFvkfQTgyX834
         zQtaF2ljV3OURo5cHnn8Xz+B3YRMGpMwvBtCsnJlPkdhjNn2vyaPnxNsG2QVXEn5rtX9
         2R4TIJnj0VpBi13QWyKm/wz1LP/RHRRW9W57w+0yDm30piX5NMHL8U3uzGre0zO8m9Vl
         BnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ENrJT8I7zKWKz2n+Cy4xuDlxucVI3SgIMNvo8fP6ikE=;
        b=Z6mVIW9AfFz7BYpZA4x9LphfajIQW9OJpI9S9tewsvli/TZwjjJ0BLW6DNi9RPXvud
         rf4MV+htQOI/0uVQD3I6Ae328oyKc3xyek310GqI/yAdNQ5ROeJs3IDeWObmOfBLBOqF
         PnHZxsag89m9CINzQowR2pU6XYtTxY6ZBd7y2lbydDoOChMKPMzMctPPtlt+8FVDwhqh
         LDJa7FOtyXzSJOCMwTjDXxbEkbTu2NUHjXIVvbzPSY1ZxOdhiCXE9yJgizDmOoaMy496
         IajceZg9smCHyAwna1FpKCSSRd/cfKKUMZkzP7EBfUmQ5+N8GdoU3hrIMolaB3RsQLUy
         ogGg==
X-Gm-Message-State: AOAM5306lQT2cI1R56fuOrsHQzioy0p6pviMNabS7QPStgFGZOejGVVX
        u+0LUxW6R4ga+EUKphq10rIKmO7jtPrNKg==
X-Google-Smtp-Source: ABdhPJznZiPPJhpceGsvWsrkQlp1uELmLJnN/AJtH4t7Hievx3eqxd5gFXcq/cb7HHCg/ik18qb2pA==
X-Received: by 2002:a0c:df04:: with SMTP id g4mr16784910qvl.10.1631015634672;
        Tue, 07 Sep 2021 04:53:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.118.5])
        by smtp.gmail.com with ESMTPSA id s6sm8799058qkf.80.2021.09.07.04.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:53:54 -0700 (PDT)
Message-ID: <613752d2.1c69fb81.c33e2.0212@mx.google.com>
Date:   Tue, 07 Sep 2021 04:53:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6344276262720414420=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/3] tools/sco-tester: add test cases to get offload codecs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210907112556.11848-1-kiran.k@intel.com>
References: <20210907112556.11848-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6344276262720414420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=543085

---Test result---

Test Summary:
CheckPatch                    FAIL      0.72 seconds
GitLint                       PASS      0.31 seconds
Prep - Setup ELL              PASS      41.19 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.12 seconds
Build - Make                  PASS      178.50 seconds
Make Check                    PASS      8.98 seconds
Make Distcheck                PASS      219.84 seconds
Build w/ext ELL - Configure   PASS      7.29 seconds
Build w/ext ELL - Make        PASS      166.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/sco-tester: add test cases to get offload codecs
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#27: FILE: lib/bluetooth.h:154:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#32: FILE: lib/bluetooth.h:159:
+} __attribute__((packed));

- total: 0 errors, 2 warnings, 149 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/sco-tester: add test cases to get offload codecs" has style problems, please review.

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


--===============6344276262720414420==--

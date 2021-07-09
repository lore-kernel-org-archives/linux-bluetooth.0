Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6AC07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 20:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE09261241
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 20:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhGIUiB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 16:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIUiA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 16:38:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4814C0613DD
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 13:35:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x16so4758660plg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=n5yn6H0sybUrpGj3BE25sm/yTcLuStY5EVtF6QePWSQ=;
        b=gNWZnU5IYwHvV78JSkiBmXGemp49No1Tj3L/BSDJyiayLlXfa1gguMvN4DM0Z9Lldz
         cugUoubU9FPDpF3SxlQMhDq5ipf3D25nOY6xH3bKWhcurXtW3jlyoFf/Q44Rizqgq2YJ
         iXVt/U0HeKHF1QsndqCzrBbnO3eUNImYaxXKE7HrZFOeAwMX+iFBI24CrQEDONzSqnSx
         K0Lh7R65jvuy+VvaGnDuzHpXnQH4lj8+P8NAv3rAMlQLoK03RQm+BvDxLTNEF1/arVtk
         +pBaYo2Ih7cW8MM1yNh58i/wKcj/Jn5U1pVvEA/Ul9AuJkvNQDfBGIoiBVJZ3aC7RorN
         hvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=n5yn6H0sybUrpGj3BE25sm/yTcLuStY5EVtF6QePWSQ=;
        b=MxExL47WW5K39Ro995RwqwlFb30cfH7hhyeFyxJEb9i2IEAONQ4pJ531Jb6+CE7qg6
         u70zTdYqj+04rny8jbT2f4lMhyro6a8yCSErNgda5DLjS46HPlfYPgAWg4zaT0nDR8s6
         xqBrX7DVzeOLKSxth7+UAI4ZnRkBRVmIUeBbDval5e0qXD77FZ7THTcEdiNnG4VBK/DN
         iP+wxkQnYwra4LxgeYkdQXGMmkRPStmZ7zmqp2zyAnaxs7Ak5K4kt1iwnin43E+JPOZn
         0BlB5vTuKf5DvqAXSp+ElKUoT/r7+KQa39WNfwDEDCUy/QdujtcOJCsUDSajeTLlEH5P
         c3vg==
X-Gm-Message-State: AOAM530OgF74EMtp0x5u9i57eU25d3NfZIdGllxb3e+SnVO3P93KH1VA
        lDk1DFvVu8MvzNJbhAsHmA3dcNXf4cs=
X-Google-Smtp-Source: ABdhPJztACNlM+Sqvhn1jULUgpWiwP9aAqIUXAv/UZXcGclDdOkfSNUvq+yp13QzvK7iwwHJpTFOpg==
X-Received: by 2002:a17:903:404d:b029:129:b048:528b with SMTP id n13-20020a170903404db0290129b048528bmr17658527pla.65.1625862915095;
        Fri, 09 Jul 2021 13:35:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.47.190])
        by smtp.gmail.com with ESMTPSA id v8sm7135914pff.34.2021.07.09.13.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 13:35:14 -0700 (PDT)
Message-ID: <60e8b302.1c69fb81.d7498.5d3a@mx.google.com>
Date:   Fri, 09 Jul 2021 13:35:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0506728801435414467=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v6,1/2] emulator: Add support to config the white and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210709201954.919338-1-hj.tedd.an@gmail.com>
References: <20210709201954.919338-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0506728801435414467==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=513295

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       PASS      0.21 seconds
Prep - Setup ELL              PASS      41.38 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.25 seconds
Build - Make                  PASS      179.86 seconds
Make Check                    PASS      8.48 seconds
Make Distcheck                PASS      215.92 seconds
Build w/ext ELL - Configure   PASS      7.54 seconds
Build w/ext ELL - Make        PASS      169.94 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

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


--===============0506728801435414467==--

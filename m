Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCCBC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Apr 2021 18:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8275B6143E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Apr 2021 18:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbhD2StR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Apr 2021 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhD2StP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Apr 2021 14:49:15 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF9C06138B
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Apr 2021 11:48:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so34516587qkv.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Apr 2021 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yNUZMk9GTlNkqV2Mw8PeF5IDZ5RqZ4h3HNw4ldvdBx8=;
        b=sBUNhZDdhAuU5mDw9vzS+I975JldGCa2tkQSX42pk2O1F1tNct5mrfEyNy6KsYOiuv
         BFJtapGM8+ITrmIPn2UmaMLxbNW1iyVOHF7uBIOAv1pHJc6R/tKHPCdlLEcFcz1flBeD
         FdGle/GAVoXoqarl4oyOCEATVa6yzSbuaX5OQS+O5nYJUJwyCjykApGa5a54wJM1Yx+9
         8X2fDm3SucUaeokbVCyQ8tEcLsC1AQYtn920aouFZgkwLBcabrIzNfAOKGiXl0o281kA
         BEpPOrlKyBMo9qK6lvTzQE5F63JJhwqZfdFryMSRgyklqX+kNw0sHP4PjpesYuFlSdK0
         RRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yNUZMk9GTlNkqV2Mw8PeF5IDZ5RqZ4h3HNw4ldvdBx8=;
        b=ZbrPnzUFz2qOXSBv8yll02hM+tab6ctMYl2E4qnBeKD/h0K5yy4N/XYr9MnqTPbjxa
         uT4ti2gcrGfeECNzRCEdWQ0qrJHZxPL3sEgqA4FTFnzSFbpPM4cYumdw1o2jPw0BnHub
         8+G5My6GyJh0+x6swgv+RrZ1wAds7KDAMOS8QdVSXGB79j5ga4Ma20NXXVbWRifv+BMa
         vrmBc/8/U5VlzuWH4wHjvxdo0zsalIxIM5nRSNh0K7lz3iV32GUxKg9/inWFj0Bd4wyl
         8G1QJP6iIlB+U4MwVh3Olfe8v4jUqYpdudLiu/dtM7hUjJRT59drmNymxn9p4pAp0kwq
         hnjg==
X-Gm-Message-State: AOAM5306T+S2YYzgCXobj7Vrb8xEEILZP2SuiO/dyU4CAQJ75NVbgqBU
        BiN/kD7LtVO7x0+Oh+27WBzpR0TzbcYsew==
X-Google-Smtp-Source: ABdhPJxdBR4HsHpXSOsWa+FEx268f0OQv6DFhf3sA7zyDq+xsVd3VKFJVyqMBFL5OdcEoYqC5UvHBw==
X-Received: by 2002:a37:b741:: with SMTP id h62mr1154639qkf.383.1619722106278;
        Thu, 29 Apr 2021 11:48:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.170.18.245])
        by smtp.gmail.com with ESMTPSA id c29sm517063qtv.93.2021.04.29.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:48:25 -0700 (PDT)
Message-ID: <608aff79.1c69fb81.5585f.4633@mx.google.com>
Date:   Thu, 29 Apr 2021 11:48:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3698763514181589038=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [Bluez,v1] doc/mgmt-api - Add a new error code for HCI status 0x3e
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
References: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3698763514181589038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=475329

---Test result---

Test Summary:
CheckPatch                    PASS      0.23 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.85 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.93 seconds
Build - Make                  FAIL      36.64 seconds
Make Check                    FAIL      0.20 seconds
Make Dist                     PASS      9.88 seconds
Make Dist - Configure         PASS      4.29 seconds
Make Dist - Make              PASS      68.58 seconds
Build w/ext ELL - Configure   PASS      6.93 seconds
Build w/ext ELL - Make        PASS      160.00 seconds

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
Test: Build - Make - FAIL
Desc: Build the BlueZ source tree
Output:
ell/cert.c:38:10: fatal error: tls.h: No such file or directory
   38 | #include "tls.h"
      |          ^~~~~~~
compilation terminated.
make[1]: *** [Makefile:6864: ell/cert.lo] Error 1
make: *** [Makefile:4060: all] Error 2


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
ell/cert.c:38:10: fatal error: tls.h: No such file or directory
   38 | #include "tls.h"
      |          ^~~~~~~
compilation terminated.
make[1]: *** [Makefile:6864: ell/cert.lo] Error 1
make: *** [Makefile:10315: check] Error 2


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


--===============3698763514181589038==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD030C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B933B61185
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jun 2021 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhFOT63 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOT62 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 15:58:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE611C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 12:56:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k22-20020a17090aef16b0290163512accedso2380351pjz.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jun 2021 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=R5V1AcxVMp5U7ECDcNGGyhB2ScLr26o7sk4k3xn71AM=;
        b=Wgr6whVBYYzP2VZRr2ZZKqMscsMKI0TxX8NR9wE12OZxs8mj2pJcwSZgCGCDMwAgdl
         tUCNiR65yFNpcsEnL6ZfJdaBV5uS68HEIKYVDJhGRodnd/oR6PUOv+m3PRAFwczBM7Zc
         CA+T9HSci3ZodhRIX2BufUEGoi5uof6bLEBA6FlksV7cad8J67RnwT75LGTWvPlKURse
         RumVRZI1DEwIGHpIoGfdBn7o+UU5CnnuzKMwhT65WXxYcazXXM1FM91xqx7b0QamyrHm
         QRSVs4FtAABybr/DKLUVfEFTacPv2J2sg6PTQDENL/ta+UL11//sCRwr/jSCtG0HWEfe
         eZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=R5V1AcxVMp5U7ECDcNGGyhB2ScLr26o7sk4k3xn71AM=;
        b=Deeiq3z0eX0CF0dIZGKjXoS1UmgGQz/fZ+UAKmZ6mY5Sl98IoIF0VN48WZYCOp8gV7
         nRsqIOrpKsyT+9ABEXyeZbauUVRpFLR6UrTrE9Pi/x+H5l0LMq2PVeYUh35CfNqsg67j
         SbXIbqJ3lJrHiMnL0YxJp0R4qp8lDQGMIwL6UOvPwq/X7WVVa8oYFUN678D5qiUtLPuf
         1Mafj5GP7zuNjeUseuY4chTPPPXi6h9quVprEC8HovdwxTxEKWrOtZUQthuqLMjpfgzj
         JaWfjxZY93QwIfX7pwzEZpWExccQvrRAP6sxYL65RoDp8CFQNjaXSa13Q3FRuo8YfyDq
         1QjA==
X-Gm-Message-State: AOAM532sZ36DDH8SawdhxYtHH4WU5iQ2x6jAIHq3INyRgWHFydUWrdzu
        O2lNGUtSuRcB19ppjIf8Y70OYTj7BeI=
X-Google-Smtp-Source: ABdhPJwXbqSWWABEAjv3Ps2CvUsUygcBT948L2ViAACpdvUWRLj9Jr/S7d2Fxn4KPuxBdOSNcZAiLQ==
X-Received: by 2002:a17:902:aa8d:b029:11a:9225:3ea with SMTP id d13-20020a170902aa8db029011a922503eamr5696050plr.49.1623786983197;
        Tue, 15 Jun 2021 12:56:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.5.42])
        by smtp.gmail.com with ESMTPSA id s4sm15863127pjn.31.2021.06.15.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:56:22 -0700 (PDT)
Message-ID: <60c905e6.1c69fb81.56b62.dbc0@mx.google.com>
Date:   Tue, 15 Jun 2021 12:56:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5961368103315651923=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,1/2] emulator/btdev: Update the white list and resolving list size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210615193007.1854488-1-hj.tedd.an@gmail.com>
References: <20210615193007.1854488-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5961368103315651923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=500953

---Test result---

Test Summary:
CheckPatch                    FAIL      1.32 seconds
GitLint                       PASS      0.25 seconds
Prep - Setup ELL              PASS      50.71 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.83 seconds
Build - Make                  PASS      215.87 seconds
Make Check                    PASS      9.17 seconds
Make Distcheck                PASS      258.54 seconds
Build w/ext ELL - Configure   PASS      8.91 seconds
Build w/ext ELL - Make        PASS      202.65 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/mgmt-tester: Add LL Privacy test cases
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#136: FILE: tools/mgmt-tester.c:4267:
+ static const uint8_t le_add_to_white_list_param[] = {$

- total: 0 errors, 1 warnings, 995 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/mgmt-tester: Add LL Privacy test cases" has style problems, please review.

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


--===============5961368103315651923==--

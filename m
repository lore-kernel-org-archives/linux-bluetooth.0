Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51791C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 18:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiBXSih (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiBXSif (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 13:38:35 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB6B1BB701
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 10:38:03 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id s15so290774qtk.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 10:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hDJmjcg4N2owvOxTKmnkXn3BfyIhgNEzfG8wJZkqrAk=;
        b=b1oV7x0LiBldfXfV9+ArgH4g9QHA0N2czhuHe7LFNzrO+54UDAjEzjzvBQ31q40T6B
         BWVLS5Bjr72HwiRtDuLc73vJvyaFybe0BVCSuLT0hVi26hj0Sp41aNoUrRoS1lWOM6H+
         igv3EhjUam6owtzZ2cOFo6bBv2+Q5WnxziGeJpeW+7IpNhJ0p99bi3r04Gu4p8V8eErn
         hLX2OI+cYRL3JfIaQkwnlhdwRdJ4sM8+nKjsi2LvLvSldbm1GQ1zCRAReyiXj9pUVvLg
         77bPPG3LiQmolWbtUfb4Bi0LYGKWImmSIZYi8po89fUIQTvZgzdRuqVpM4cBvK1gr7L6
         CqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hDJmjcg4N2owvOxTKmnkXn3BfyIhgNEzfG8wJZkqrAk=;
        b=6VWp74zi/h62lG5HAZwzFZDY/AejywFGA3Qk3vTdulImWgxQS6Jf/lsczNgzm5goqI
         +xdPE7AyYVMc90d+HWRp0jChZuvN21hEEH+f9k7bIrIceXMTH0QUNR0wH4EF70q22Rhe
         NqNAdBQ4zax70iAbhfxUM4gejpwuHKXghewoKWlY+bD/xDeDBi5kHt461+5qDI8Dczw7
         UMfaVahYSZzWZPm/kfsvEuQ4jorT4z1DvWX93uK0EqRAHg/mt8xyZ1tVEe/7YokB0NZK
         hqcepKlOOE5ttZKYQmBVIRqF0HNXx1Q3LeuLUZXuVq8FgfDGDDewnadwURSu5NuyBmRX
         9PyA==
X-Gm-Message-State: AOAM531CedLWVX7stC6gJoBfRAp48RnDgBapKU7rNjZXv6z9a9lZ0n/k
        NGmXYkhG+/eOdN8fNm2Yod5ksF18S5QQkQ==
X-Google-Smtp-Source: ABdhPJw+nyLPAYCr/rhjucC3zx4hLZbzGON/3/k+DyK5ZWcyrpkPKNwwGPJmZ9ByHh012D+EvSVt+A==
X-Received: by 2002:a05:622a:11c4:b0:2de:b73:1762 with SMTP id n4-20020a05622a11c400b002de0b731762mr3744551qtk.59.1645727882379;
        Thu, 24 Feb 2022 10:38:02 -0800 (PST)
Received: from [172.17.0.2] ([23.102.102.82])
        by smtp.gmail.com with ESMTPSA id t128-20020a37aa86000000b0060ddf2dc3ecsm176291qke.104.2022.02.24.10.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 10:38:02 -0800 (PST)
Message-ID: <6217d08a.1c69fb81.ce539.1ce1@mx.google.com>
Date:   Thu, 24 Feb 2022 10:38:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3718989876223706289=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: RE: [BlueZ] src/shared/util.h: include sys/types.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220224173104.479809-1-fontaine.fabrice@gmail.com>
References: <20220224173104.479809-1-fontaine.fabrice@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3718989876223706289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617667

---Test result---

Test Summary:
CheckPatch                    FAIL      1.36 seconds
GitLint                       FAIL      1.00 seconds
Prep - Setup ELL              PASS      39.01 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      7.96 seconds
Build - Make                  PASS      1299.98 seconds
Make Check                    PASS      10.86 seconds
Make Check w/Valgrind         PASS      404.14 seconds
Make Distcheck                PASS      209.80 seconds
Build w/ext ELL - Configure   PASS      8.07 seconds
Build w/ext ELL - Make        PASS      1299.42 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] src/shared/util.h: include sys/types.h
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'fb57ad9b9d107856e5f1c8135da04ffa2f7a11ac', maybe rebased or not pulled?
#80: 
since commit fb57ad9b9d107856e5f1c8135da04ffa2f7a11ac:

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#84: 
  106 | ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);

/github/workspace/src/12759083.patch total: 0 errors, 2 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12759083.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] src/shared/util.h: include sys/types.h
7: B1 Line exceeds max length (85>80): "./src/shared/util.h:106:1: error: unknown type name 'ssize_t'; did you mean 'size_t'?"
13: B1 Line exceeds max length (82>80): " - http://autobuild.buildroot.org/results/83eaeb3863040645409f5787fdbdde79385c5257"




---
Regards,
Linux Bluetooth


--===============3718989876223706289==--

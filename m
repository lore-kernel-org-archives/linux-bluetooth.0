Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5729FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 00:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiCAAfu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiCAAfu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 19:35:50 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3460912AC6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 16:35:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s15so8640601qtk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 16:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2y3ZN9EwgD58FDBB7VdPp0yuWiEdwPhroK2M7bTucNg=;
        b=J8+n0EWxhRuprlBk6edMEQXxxbXxH79KgY64feJsj4/d/9I70V8s0oMZw5PUTXncml
         /1FHrN8evKzAP9RCVWXuTOKo2BYaQLtAQUI6mTQWmMqmEuQ29NumInxbI8HG9NKnDMUv
         jLExnFcmZePVpljBYzqeL1MnAfByCXXJviDbFHY/TS4Lr1MslBYI8R+kXG6iC2fA1n8d
         gm1SIRvZsxX+mK2OMOyiwHHn5ol2Cpt+vRrD3sE5k+/KSfcRnr/HYSgO07PxErZZfqaY
         Zjo+IxKF6djiNlrYuDi09cUigc55JXodBl52GRLrqsRVdYuKIc+xSguMpbSWb3OY0E3/
         3Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2y3ZN9EwgD58FDBB7VdPp0yuWiEdwPhroK2M7bTucNg=;
        b=8MFxsKKqvDJgITewSvVpYSskZUSzxrkJOqSujj6Mas4zUyR/uhLTBPF2BHPx836Vvv
         g7RuJY2zliKukrzwTKmzX/diO4lEebbovh7XZARI3slpFgcg3txQagYmJ6g6t7+k0Hpo
         bzCSjwR7v9VtFw8hI9leSyTV2NDabYKTc8bJpxzkiXinpgi7NAtzhXCfKQ3h3rAdUzAK
         uzhNZJQ6etXqRN0UJlp91coGTcUtEqtWpM1bkJ88nJ5r47ya12LB708Cc5gERedqnd6R
         LHeSgHR8xCH6V+kkaYhxKeEO+XfbaEZRKuEmkdH42S+1h0tD2dQDr/e7aD9wk2tAJi/4
         uZnA==
X-Gm-Message-State: AOAM531SOXVivJsDw3kzyxjfmmqVpNqCdBVXo+w1TFrt4EaCMrremEn8
        JHbcym7IhPk/UDn2r12PAo1GUV0MYNk=
X-Google-Smtp-Source: ABdhPJyJ1j7qRtYkKYuP/qUoeKNOfgTWAN/d0mjSUL7ZC5tm26UU/owmrkbEjoFtWxDZhi4ecA9upA==
X-Received: by 2002:a05:622a:1101:b0:2de:3c6a:bae2 with SMTP id e1-20020a05622a110100b002de3c6abae2mr18413812qty.640.1646094907172;
        Mon, 28 Feb 2022 16:35:07 -0800 (PST)
Received: from [172.17.0.2] ([20.119.245.165])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87fc6000000b002dea65d1c7dsm8016587qtk.47.2022.02.28.16.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 16:35:06 -0800 (PST)
Message-ID: <621d6a3a.1c69fb81.cfda5.a0ab@mx.google.com>
Date:   Mon, 28 Feb 2022 16:35:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0664367865672239568=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] test-runner: Add option to start emulator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220228232720.1614099-1-luiz.dentz@gmail.com>
References: <20220228232720.1614099-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0664367865672239568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618913

---Test result---

Test Summary:
CheckPatch                    FAIL      1.54 seconds
GitLint                       PASS      1.05 seconds
Prep - Setup ELL              PASS      43.02 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      8.82 seconds
Build - Make                  PASS      1440.03 seconds
Make Check                    PASS      11.46 seconds
Make Check w/Valgrind         PASS      446.11 seconds
Make Distcheck                PASS      231.77 seconds
Build w/ext ELL - Configure   PASS      8.81 seconds
Build w/ext ELL - Make        PASS      1433.12 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] test-runner: Add option to start emulator
ERROR:INITIALISED_STATIC: do not initialise statics to false
#98: FILE: tools/test-runner.c:50:
+static bool start_emulator = false;

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#119: FILE: tools/test-runner.c:605:
+static const char *btvirt_table[] = {

/github/workspace/src/12763863.patch total: 1 errors, 1 warnings, 152 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12763863.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0664367865672239568==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D8ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 23:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiH3XPB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3XPA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 19:15:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB72AFD15
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 16:14:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f12so12367036plb.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=s7su9pnFsIbrLQH2LolTDJQ/uN3UGJIF6WrPQn31orM=;
        b=ICpvVz7bSHXtKEV2opZh/Z/8yotUUDksmj5nE0NxD3P7R/0Z+f8k3zIqfNjl+i2lju
         RHS7saasie9swerEIHsjlwiUnlzoc4TfoRgESEvM0UMyh1bfdZwkZqEsxjRl8g7S92ge
         +Pr0aLsclLFcDjJrA6C+CaKpzG3NecygcaZKMmjF6uGfiN0tw4DZgAGseNAnE8hVoNZZ
         nq5luJGRShYpSmpceXcJ8d7RN7F7E4vV5IYWEQFr2ireNbVvqni9d8PqyBRg6hqEJfYu
         gkT9Bz1ck7gyI5WyuydaJ9rf1cMChV9PrPxy8H7lCICTaR+tfDzBtgVRJoEI8UZ6+qUI
         SQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=s7su9pnFsIbrLQH2LolTDJQ/uN3UGJIF6WrPQn31orM=;
        b=b+QvgLce+arx2XZo021CblFNgYsoNzdbPPEFpA9gF8808g4af/hovkL75bpmwMj24H
         YDOlIXcczio+STaSVjugcHQZqS+b05MqT2tJJx9MYQX7nGosaCAKkY9XYFYdlvstrQgO
         RH6Hlmos9xokuF0OjnOZNQ1ZIPczm2kQrlcsLW3ctxHVIVTPU8InJ5mHNf2SNPSsjHPV
         KBvHR857r9QpaT+oP99bMH5kzBdAfqu9UkAsMDY4BnN5URIg8iB0dV5KJtMSp6R/YXqC
         7PhI88YER2jKWlt5VGxE1I9DWII4hSYNc48GqVXYHDtP16pYKE5/mEKZsqM5vJcQBh9l
         9e9g==
X-Gm-Message-State: ACgBeo293/8G8tcobg8rirA8csEBGUFrRAWUORoseiY10WV1Y4n80pvM
        o60zSzZX9cQObCO+iyavvaVA3EPExjs=
X-Google-Smtp-Source: AA6agR4fNzbvDgxUvZJo7dopV5MAC1KcYvN7bvyBn8vP4gEfdjbOoHwSrux9MHkWbX1W0LUAtVWtFA==
X-Received: by 2002:a17:90b:2242:b0:1fe:61c:3022 with SMTP id hk2-20020a17090b224200b001fe061c3022mr333543pjb.197.1661901297246;
        Tue, 30 Aug 2022 16:14:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.59.100])
        by smtp.gmail.com with ESMTPSA id c18-20020a621c12000000b005381f50d1e8sm5774121pfc.115.2022.08.30.16.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:14:57 -0700 (PDT)
Message-ID: <630e99f1.620a0220.31c2d.a8b4@mx.google.com>
Date:   Tue, 30 Aug 2022 16:14:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2249218721927588961=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] client/player: Fix checkpatch warning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220830214215.1137276-1-luiz.dentz@gmail.com>
References: <20220830214215.1137276-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2249218721927588961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672614

---Test result---

Test Summary:
CheckPatch                    FAIL      1.39 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      32.15 seconds
Build - Prep                  PASS      0.65 seconds
Build - Configure             PASS      10.33 seconds
Build - Make                  PASS      980.25 seconds
Make Check                    PASS      12.90 seconds
Make Check w/Valgrind         PASS      347.96 seconds
Make Distcheck                PASS      300.51 seconds
Build w/ext ELL - Configure   PASS      10.48 seconds
Build w/ext ELL - Make        PASS      101.00 seconds
Incremental Build w/ patches  PASS      242.98 seconds
Scan Build                    WARNING   684.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] client/player: Fix checkpatch warning
WARNING:EMAIL_SUBJECT: A patch subject line should describe the change not the tool that found it
#69: 
Subject: [PATCH BlueZ 1/2] client/player: Fix checkpatch warning

/github/workspace/src/12959894.patch total: 0 errors, 1 warnings, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12959894.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
client/player.c:1755:25: warning: Dereference of null pointer
        iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
                               ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.
src/shared/shell.c:1136:19: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                        data.timeout = strtol(optarg, &endptr, 0);
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/shell.c:1158:13: warning: Access to field 'options' results in a dereference of a null pointer (loaded from variable 'opt')
                        if (c != opt->options[index - offset].val) {
                                 ^~~~~~~~~~~~
2 warnings generated.




---
Regards,
Linux Bluetooth


--===============2249218721927588961==--

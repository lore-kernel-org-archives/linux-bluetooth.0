Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6627C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 03:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiGNDKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 23:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiGNDKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 23:10:20 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6B8252A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 20:10:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y3so509672qtv.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ax+yrBxx9CjDP5gVGJkjlPpgSa8Wousf/SmH3PoCfVc=;
        b=lhDPwHI/Y5iP8XUVskb/Ut++jtmYYIr1Zd/FSGJ3pKNlcVII7vY3C7gSBwuGb2O4gE
         dqAzw48ATaZrN5F/qY/Dgb3Op0WXoUtaAM+JzJqGC28urHIFRTBI+OWwFZabdsCVKBAJ
         vcInSsiCuqDbsWdZHHg0iAXhIf+6l/3DW/NIktWpwoS0iMN39PBKP/yklf9ev+Hrcln/
         lIBgjbKMaZYsIsZnG79pZDghdppXYJN+S2mNObLz4suBNztABA1OYD4IXEZukAP6DR74
         ouJQCtCJtwRgQcbFM7rF1Mcgl2ztLkx0R7L1dfMEDZ76k1K2EsWGdtqO7FeLn+CYmpIT
         Ooaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ax+yrBxx9CjDP5gVGJkjlPpgSa8Wousf/SmH3PoCfVc=;
        b=ligZAV+KTtDEs9REkKehMXUeXFVsp8bTTIQZC939XUuZdUQjgek4oUm/lJMcSL+/Df
         R7xS0hzKg7kfcWWwAIVJ29Wv80Z9bkC3EIg+CwE17uhv/82kMdi+i492lt9vWZ8leU3l
         T/hoZrfcUK9Z5zxglWYxhEgl6nk/Q1WFGV5+rIuU7A3fLYlycUAzR4PSlk6Ji6XAFkYY
         9mwZOCqqgVJ9r0403CkfUscYNfCoV0/7H8MQnchCmgVzACTP+UaaVgN5ePnb2XK+0wZb
         w43gqaYDXwFCJd4/nUYhUI5/qGOp0EJ2qvolW+/v7Fti+oRjeXMcQSUlbE9xnEM05HNl
         1uig==
X-Gm-Message-State: AJIora9pECZOrUqEwQB1ETB/JhvwTNLT/PmQAbxv3YCfz+k1gKUxQCwy
        NviwJ8WhLjn9cqN3nBjp3FM4hUeY5+8=
X-Google-Smtp-Source: AGRyM1sxvXuPfXmvr1k8ArzBne/fX2q+Pr0Qfjmek1nXwZhl3qqzM0S35DRIqWzapoCBB6K3Za6GrA==
X-Received: by 2002:ac8:5e13:0:b0:31e:b9dc:93fa with SMTP id h19-20020ac85e13000000b0031eb9dc93famr6176175qtx.214.1657768217046;
        Wed, 13 Jul 2022 20:10:17 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.19.161])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006b57b63a8ddsm398640qkl.122.2022.07.13.20.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 20:10:16 -0700 (PDT)
Message-ID: <62cf8918.1c69fb81.d9266.099b@mx.google.com>
Date:   Wed, 13 Jul 2022 20:10:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5903688137130202726=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] main: Default device_privacy to true
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220713234655.3524356-1-luiz.dentz@gmail.com>
References: <20220713234655.3524356-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5903688137130202726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659495

---Test result---

Test Summary:
CheckPatch                    FAIL      1.66 seconds
GitLint                       PASS      1.07 seconds
Prep - Setup ELL              PASS      27.63 seconds
Build - Prep                  PASS      0.85 seconds
Build - Configure             PASS      8.67 seconds
Build - Make                  PASS      853.00 seconds
Make Check                    PASS      11.77 seconds
Make Check w/Valgrind         PASS      284.25 seconds
Make Distcheck                PASS      233.84 seconds
Build w/ext ELL - Configure   PASS      8.70 seconds
Build w/ext ELL - Make        PASS      80.81 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      483.54 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] main: Default device_privacy to true
WARNING:REPEATED_WORD: Possible repeated word: 'the'
#81: 
otherwise network mode would prevent reconnections if the the identity

/github/workspace/src/12917203.patch total: 0 errors, 1 warnings, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12917203.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5903688137130202726==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA0EECAAA2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 21:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiHYVcv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiHYVcu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 17:32:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197BEA1D54
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:32:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t5so2389315pjs.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=j/+kun0PLOGIh7mR+LGiVWJNEACol//aV1+Zhj/BKD0=;
        b=fqRbc4WMKqx0j4WkOgcdBsQkTcX1pI0SE9NFLRYq54EfN0mGVSqSVz+24rczt4v3lp
         RLhj2fxeX9obEg+eZ+1awp3CzOCUhXF0nnbhCgLLICq2ypR1UJLWU7Kicp8tQAYyf8QS
         6nSBApyfQW+JzI+NyUQQYi8Fs6JuAKocqtHsKemCqnKM1DbaOSOndKzMrneZBy2U6cDg
         2STW9IWrJTrpGTkevjT+ovMfvDQ8FMJtV+u4lJ2c4ez1YB8bopGOimtT8r+uFQtLB/03
         jn6gZypXbJmOuJP5Ky+OFzQsv0HwqdKVTe9rCWOednCKXzAz4NQqy66agssibYwfpt0i
         WoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=j/+kun0PLOGIh7mR+LGiVWJNEACol//aV1+Zhj/BKD0=;
        b=s4umj7Qf0EzjhJ6WsDQq2cIAgtfNHQKS676QDuyqxX0ahNk5NiJA9FuKL7Lri35P5V
         BfKK6k+owlshrGfu4L4DDnAPTdeo8B9hHXdkcyMMQuW93rDS9yg3MinrnqwMV9/T952V
         5rjDd9MI3y62SmmISMefXPm6VsQulDx9BXwEgw0bWWVd9McN/jbk0sheVv9VPnSDC5PD
         ++8MCKSn9msfZ7WKk7zaC187u//x5LMgID1Dyq5U52X482UaO9ZkDPbni2qzUtiXdKDe
         AtMJ3+f2HHBIK8gc6uwam+RVNG3oHL95AKwDApiRRg0goBCDUadb6AodX2Wo7VvlqOJO
         bqDQ==
X-Gm-Message-State: ACgBeo1ZrgWoMQqwtIZTUxVtIoMxRKQoFcEsBXMc9Th6Yhuy8HtPzbSZ
        EQrOG3+Ksq1wI328+WvXklHOn7LWerc=
X-Google-Smtp-Source: AA6agR4nToh/p1RAMod0Flu0+yRFqqIupyeaw1Zr9NpObu4gBW/WoJ0n+W5X9A6baiw+urzgj40axw==
X-Received: by 2002:a17:90b:3b46:b0:1fb:5993:f893 with SMTP id ot6-20020a17090b3b4600b001fb5993f893mr969124pjb.229.1661463169386;
        Thu, 25 Aug 2022 14:32:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.84.94])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709027fc200b001708e1a10a3sm36577plb.94.2022.08.25.14.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:32:49 -0700 (PDT)
Message-ID: <6307ea81.170a0220.5ed43.014c@mx.google.com>
Date:   Thu, 25 Aug 2022 14:32:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2136794159260412720=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: client: Add missing return statement in error path
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220825203903.3526-1-ceggers@arri.de>
References: <20220825203903.3526-1-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2136794159260412720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=671219

---Test result---

Test Summary:
CheckPatch                    FAIL      0.70 seconds
GitLint                       PASS      0.48 seconds
Prep - Setup ELL              PASS      33.47 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      10.61 seconds
Build - Make                  PASS      1162.23 seconds
Make Check                    PASS      12.57 seconds
Make Check w/Valgrind         PASS      354.24 seconds
Make Distcheck                PASS      297.11 seconds
Build w/ext ELL - Configure   PASS      10.59 seconds
Build w/ext ELL - Make        PASS      104.71 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      646.48 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
client: Add missing return statement in error path
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '936ad5ef7b56', maybe rebased or not pulled?
#108: 
Fixes: 936ad5ef7b56 ("client: Quit when done with command")

/github/workspace/src/12955220.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12955220.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2136794159260412720==--

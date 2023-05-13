Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDEC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 May 2023 17:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjEMRUT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 May 2023 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEMRUS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 May 2023 13:20:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128361BD0
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 10:20:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so10187096a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 10:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683998415; x=1686590415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r5a9Ni4lzsGXA1eGRco8hzx7aQABb9KTOqb6oLCdeCY=;
        b=bjV0UFYRaf4dwg81/YUk4nJTZiuqiit/tkkM5fsN7AJQWS/HYNjP/o1K1+0VA3MTVJ
         Rra2cISif3M0xPNGl9hGtKX0oMEhTJcLEplRmf/r4jI/FOMFafkxDfwfCGUBbizE0rkg
         srOlVam2kB8V0ztSMBSaO03oIN0PV5msXMMrMWLpNqglwCDPvDOIhromeMa9NrEwS2Q+
         DfgK6Xwm8kOBFIQ8M8jsZj4ln8u8sUuLJ9CgfOK8UnWXTA9VkCI5dEeUqgfcm5Pe7Yt+
         364x8GKuWGlnmav+TUFJTnlLGbR0iknno6oQOaPaZLDAvrDSEdRsyy9LS45AmBPyowIj
         cxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683998415; x=1686590415;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5a9Ni4lzsGXA1eGRco8hzx7aQABb9KTOqb6oLCdeCY=;
        b=d3teNQt+OH9EkWeq0v6V5EB2yhVu9/4KdNc0Vk13NJFeOtlkWY9pchramsp9uNdr+3
         SsSLIrSRN2WhEm4CiRSoKiFEYGjUm2qfgKQYTcFD44WI8DauL9rK77U5d8RkiJ3WPEEY
         5p7oq+dbjcu8PrDfkG8LgnSQkUFPAVzeuZZxJzXIbQqQsMounImQIrrrZ6JwXuoVACgk
         VFKPzVgRArGZWHw4u7LWkj+tttgmcAGtKCcbTKSQ97Mg5WbzndhtP6wpUlAAlZGCoaOz
         KQ+KnacJ09hpItyjvf8Nx4Qb9tdR98vVwD/Q5632v07qUXNP62ljHZfUYf2ToQwQKCma
         FmwQ==
X-Gm-Message-State: AC+VfDxcD/AWzoqaHPQ1ctu5d/pNbApIjwdNG3nMh49PivMRowt2aM1C
        hYQIRbOeoKAAdegKJtphCl4Sg1XfHno=
X-Google-Smtp-Source: ACHHUZ5GJdVEJMUd6EFPK2S3obsGGjRX1UmegLt4v6jiCkpHCp6z+zA3aOOf2f8XbqWTPRLSLHCObQ==
X-Received: by 2002:a05:6a20:8e13:b0:101:73a9:1683 with SMTP id y19-20020a056a208e1300b0010173a91683mr22052677pzj.33.1683998415174;
        Sat, 13 May 2023 10:20:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.51.38])
        by smtp.gmail.com with ESMTPSA id 71-20020a63004a000000b0051b9e82d6d6sm5100801pga.40.2023.05.13.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 10:20:14 -0700 (PDT)
Message-ID: <645fc6ce.630a0220.1799b.9542@mx.google.com>
Date:   Sat, 13 May 2023 10:20:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1593896370199491671=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
In-Reply-To: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1593896370199491671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747273

---Test result---

Test Summary:
CheckPatch                    FAIL      1.14 seconds
GitLint                       PASS      0.52 seconds
BuildEll                      PASS      26.21 seconds
BluezMake                     PASS      745.32 seconds
MakeCheck                     PASS      11.04 seconds
MakeDistcheck                 PASS      151.18 seconds
CheckValgrind                 PASS      243.86 seconds
CheckSmatch                   PASS      326.99 seconds
bluezmakeextell               PASS      98.83 seconds
IncrementalBuild              PASS      1262.88 seconds
ScanBuild                     WARNING   964.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,1/2] test-runner: revert udevd and audio support
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af52efb0751fab396b2b9026c9186b10b88', maybe rebased or not pulled?
#49: 
This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0b05c7edb74255c9b092916ac5bb99c97f', maybe rebased or not pulled?
#50: 
This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f

/github/workspace/src/src/13240258.patch total: 0 errors, 2 warnings, 193 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13240258.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/test-runner.c:924:2: warning: 2nd function call argument is an uninitialized value
        printf("Running command %s\n", cmdname ? cmdname : argv[0]);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============1593896370199491671==--

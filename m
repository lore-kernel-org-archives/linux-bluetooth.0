Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45677C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 21:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357740AbiDSVGO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357498AbiDSVGM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 17:06:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB03193C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 14:03:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so3021806pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HlPgKEDkI+cTKWRK0P5PFpmMSEnf2+7/nTsGHSor5fM=;
        b=TPqOuSd537mQyiPNU4ZffzfjsWgvqfZ3UC3IcTF7uDAgURVUnniGrb5o+EVVjECAO5
         4oyS46Z/NBwqsqfmKW37LwwhcJe8CxjTklhdIPx98d1iPucqHfsFKHNub7d0rp+R4Wd5
         c1AVAVwMtyIQrG4OyR2FWLMOQ47Go0UbfnLj2v4VK/+axZLyE4J2qVEHpGzxr68CnkqY
         oOGimzQwY6MhzpJZ/XiGJtE82WL8iyhACc//qBr5WoKDh8CjkRYxOsNGJKote7K74rzp
         r6bSOTYQAMCMi91V+JKoyAHu0ClE7FIqXAp4rAJ1LuySMfwK5xyjRnSmtIIA6uxk7uqB
         RGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HlPgKEDkI+cTKWRK0P5PFpmMSEnf2+7/nTsGHSor5fM=;
        b=Hp2znr3mfdnvjQf/3Hmirt1zrDlbT+bN6JS165BbabWG66OBAqBCGDMDs4vqBRyjvj
         XpXmbmQQ5EuYezToLsSxIaaR8j+1B0+SWCIGOemMvWgb9Q2t5O6sfuldLImjp58Jlfm9
         x4wlYuM9rqscQw+orSmWFmYpO8zx33CuH7A8A5GLG3Xp3aAmdsAOvNYnMO5fUX9Qdbg/
         pEerPCVfbJo9kRbh6zQhsiq0NjFul895sL3fToIZHKqchuYQAyP47VABCEk7botxaJV0
         bN6J3UQsF9WHieFJvTaaQceg+uAgMNNO9ktLOKfNT2rrkpUNownROpFrI6gVl1b4W37J
         47pw==
X-Gm-Message-State: AOAM5324kJK7dMNYLjR7T61luVfhQRE0BnARrFo0vESV4WmIX3VyJ7k0
        M/toiL/E2DsboXt6/XctgRRF/0oefTexpg==
X-Google-Smtp-Source: ABdhPJzvvBp5XEYQFBIbKZb7vBn8I6KsnVs3pbjqkVAoDgw7dp++jprzSiR3nk0G6N/NMLs+3f6RNg==
X-Received: by 2002:a17:90a:aa96:b0:1cb:c57f:9218 with SMTP id l22-20020a17090aaa9600b001cbc57f9218mr498850pjq.227.1650402207072;
        Tue, 19 Apr 2022 14:03:27 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.147.44])
        by smtp.gmail.com with ESMTPSA id r32-20020a17090a43a300b001cdbda883ccsm17271961pjg.38.2022.04.19.14.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:03:26 -0700 (PDT)
Message-ID: <625f239e.1c69fb81.51d25.9593@mx.google.com>
Date:   Tue, 19 Apr 2022 14:03:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2937351230925340760=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] bluetooth.service: Set StateDirectoryMode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220419182237.2531907-1-luiz.dentz@gmail.com>
References: <20220419182237.2531907-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2937351230925340760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633488

---Test result---

Test Summary:
CheckPatch                    FAIL      1.24 seconds
GitLint                       FAIL      0.89 seconds
Prep - Setup ELL              PASS      50.22 seconds
Build - Prep                  PASS      0.62 seconds
Build - Configure             PASS      9.80 seconds
Build - Make                  PASS      1740.83 seconds
Make Check                    PASS      12.41 seconds
Make Check w/Valgrind         PASS      530.59 seconds
Make Distcheck                PASS      274.43 seconds
Build w/ext ELL - Configure   PASS      9.91 seconds
Build w/ext ELL - Make        PASS      1705.33 seconds
Incremental Build with patchesPASS      3479.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] bluetooth.service: Set StateDirectoryMode
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#84: 
[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#RuntimeDirectoryMode=

/github/workspace/src/12819297.patch total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12819297.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/2] bluetooth.service: Set StateDirectoryMode
9: B1 Line exceeds max length (92>80): "[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#RuntimeDirectoryMode="




---
Regards,
Linux Bluetooth


--===============2937351230925340760==--

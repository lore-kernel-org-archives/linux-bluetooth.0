Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A60C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 00:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiHDAAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 20:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiHDAAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 20:00:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1C10EF
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 17:00:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z145so713715iof.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=+iqPfTZbOkArwcagUxOA3yjkUjTQFrdMuBqK06rfB4w=;
        b=XQ2raln3HY+DeLaf4zY43IOTPHx5qUPo9yEQwQw8LaPnQ/H1o3VE35JUP7icOVTvsN
         b1yZ0QGo9D1f6cR2Z5h27pmUa8Bexp3muTlLTkJXfPMFWbcDzCTuCIe5lFCclSbADeA1
         JPbjDpqaN61w0lh1el1AD5z4JQmkAEwdPxtdLhRkWrKJYvbPHK52ppPNDCCbCRA3LlK7
         ULEoNcP/dXu2xge6ykngIVFy8TiQPo3+WUCwp7VLulYkZBucP9IxmlnPd6y+kjWgKJs4
         nFcYDyjdHie3J0dvu23Lvd4LXF00IPTdR4YZ3Q4ZsYBowe+oB0MNPWczsbLQJi5WJO3r
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=+iqPfTZbOkArwcagUxOA3yjkUjTQFrdMuBqK06rfB4w=;
        b=zO4sLBOqaC44NU3aM47btgg4uAacgavAcMRwfXfQGOWdEBAaQCVJHf8BvPM3RireWl
         wbLB/4IQlJeEP0WsABjTA2wJKZ/gDJQXiO4Nxwsqfida7U0ljQ2/ScOqC2QtAsW1cCIA
         1R+lcT5RW0e3oK0WNZXCjk/5NVLWnX6IqqxrxXgQT1Kota2hUQUi2VsN+HhrOC1yz54G
         5y3Tw0d7LUzGNLQr5qvwxb+LdozgSuCbTL+N6DzVxY67IGmaMIHWg5Qj2ih7BSgRxv9Z
         VHZCCgxJU7Le5OnSBLgxhRaPuBq5HqmQcsTjf/GBX8/bslyLp4vvGECOiwvYbPr+MjvM
         ZsZw==
X-Gm-Message-State: AJIora9/vgqEE2wDiYxXSOSraMNtv4ngICPgEBMqUcBskFUSEbhzgdte
        9O2guv99C3jYLaKuKwp/hFu6ud2oy+xz6w==
X-Google-Smtp-Source: AGRyM1u9lI16WfRiDVojC8U4e0P61OY+0Br6xQRCvfpPWBcygmFJgSm31kdNSbEtW763asoj6CDjuQ==
X-Received: by 2002:a05:6602:486:b0:678:dad9:e56a with SMTP id y6-20020a056602048600b00678dad9e56amr9800036iov.97.1659571214839;
        Wed, 03 Aug 2022 17:00:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.118.171])
        by smtp.gmail.com with ESMTPSA id a10-20020a92d10a000000b002dcfbf36438sm7445107ilb.12.2022.08.03.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 17:00:14 -0700 (PDT)
Message-ID: <62eb0c0e.920a0220.4b4ed.9037@mx.google.com>
Date:   Wed, 03 Aug 2022 17:00:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6312141155235244042=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vi@endrift.com
Subject: RE: [BlueZ] hog-lib: Increase maximum report map size
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220803225716.1287921-1-vi@endrift.com>
References: <20220803225716.1287921-1-vi@endrift.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6312141155235244042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665202

---Test result---

Test Summary:
CheckPatch                    FAIL      1.59 seconds
GitLint                       PASS      0.71 seconds
Prep - Setup ELL              PASS      27.17 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.26 seconds
Build - Make                  PASS      737.08 seconds
Make Check                    PASS      11.31 seconds
Make Check w/Valgrind         PASS      282.32 seconds
Make Distcheck                PASS      233.41 seconds
Build w/ext ELL - Configure   PASS      8.32 seconds
Build w/ext ELL - Make        PASS      80.48 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      485.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] hog-lib: Increase maximum report map size
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#53: 
Though a 512 byte report map size seems plenty large, there exist some devices

/github/workspace/src/12935951.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12935951.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6312141155235244042==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839E2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 22:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiBNWsv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 17:48:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiBNWst (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 17:48:49 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D7154D10
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 14:48:39 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id de39so6221859qkb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 14:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AY09YAYHarCxNOOzC8HCs3vfGQEJaz1+sFhcq4MzISo=;
        b=Ie/UvHDBY3UAU8Al7cT3OZKgiUWGrFxgxnvpk2l5M+4qFxd0BmM4Yy3Y8bs6AElogU
         4ZsoGhvIStW/fHVb3LqY/twZcJz6wh4f5jrCTPJo92I9n/UCuNuLrLFX0cu+tkeTq67v
         MfVR2d8upkRw8qJwaV+jt6b2cBQoaVZoGDU7Vc+lcRpp5s9UokWWaGjYFcilUvEC5URY
         wUdbxafBerqCwnSFapAnab6c4D4IxGVRWia8xmBGHLN+BAD0BUgyD1XHXAQCf3KHcRmb
         yr5WduNliRtIJp/olaJyBONdOOzXL+ISGGzLbDatn6TpgCkVbIted510vm7AIPg/9c7e
         Y1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AY09YAYHarCxNOOzC8HCs3vfGQEJaz1+sFhcq4MzISo=;
        b=OQo4fek56ZhbFZpRPf7A+yxH/CF9CjF+X0S5MB/uvlQOzUAszhfBr+NZcDNcF76LpA
         Fl017fSS8QfoK+ZM6cbZHSO/i/tjvjBHdWsxGNSn/W5pRnd2VKUvTIQfGBENU1G6R0t4
         MvEKo8UkfDE1QvL6CNwjEKECRf+kn1WA6N1p7KYouKR3mnaj6acfvbh/HG1e6J9uff9z
         PDiWx8C5wGMVA6lLPn+QAFJUPuqrT8VjQccI285DWmWpSTRaqxP25hJYmN3We/v4010Z
         B05ucZpazIYX7uwFa+dIfgihVK0rvLmRtQ9F0oXuFX+9GyONYdGpdS+4II8UClfgP6KN
         sNPQ==
X-Gm-Message-State: AOAM530z4wLGHzgS48ij12YJ7Xm2+oUOISV9pNW1TRof0bAie6HsTM+V
        dSrtyWaygo55xKgiOWJxxFJwQYrVVeie1A==
X-Google-Smtp-Source: ABdhPJxL2dQmTC794B2wRaI0byWWKsUYUAMyM+M8ILTiSyVKZrKbUDROt5nSK/w4xcicqtZOz6WJbQ==
X-Received: by 2002:a37:b0c:: with SMTP id 12mr643763qkl.667.1644878917839;
        Mon, 14 Feb 2022 14:48:37 -0800 (PST)
Received: from [172.17.0.2] ([20.39.34.196])
        by smtp.gmail.com with ESMTPSA id x3sm14438912qkp.54.2022.02.14.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 14:48:37 -0800 (PST)
Message-ID: <620adc45.1c69fb81.2322e.e596@mx.google.com>
Date:   Mon, 14 Feb 2022 14:48:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7562641107695714788=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, fontaine.fabrice@gmail.com
Subject: RE: [BlueZ,v3] fix build with glibc < 2.25
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220214201739.3996569-1-fontaine.fabrice@gmail.com>
References: <20220214201739.3996569-1-fontaine.fabrice@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7562641107695714788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614255

---Test result---

Test Summary:
CheckPatch                    FAIL      1.67 seconds
GitLint                       FAIL      1.09 seconds
Prep - Setup ELL              PASS      53.15 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      10.64 seconds
Build - Make                  PASS      1517.59 seconds
Make Check                    PASS      13.23 seconds
Make Check w/Valgrind         PASS      538.52 seconds
Make Distcheck                PASS      282.86 seconds
Build w/ext ELL - Configure   PASS      10.65 seconds
Build w/ext ELL - Make        PASS      1494.26 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v3] fix build with glibc < 2.25
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#81: 
https://www.gnu.org/software/gnulib/manual/html_node/sys_002frandom_002eh.html

/github/workspace/src/12746111.patch total: 0 errors, 1 warnings, 208 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12746111.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,v3] fix build with glibc < 2.25
14: B1 Line exceeds max length (83>80): "https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/master/src/pipewire/utils.c"
17: B1 Line exceeds max length (82>80): " - http://autobuild.buildroot.org/results/6b8870d12e0804d6154230a7322c49416c1dc0e2"




---
Regards,
Linux Bluetooth


--===============7562641107695714788==--

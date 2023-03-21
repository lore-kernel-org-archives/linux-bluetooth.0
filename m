Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9359C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 05:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCUFCe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 01:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCUFCH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 01:02:07 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F132512
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 22:01:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f17-20020a9d7b51000000b00697349ab7e7so7925273oto.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xt29rWSoLvGyXVbCIGF5J00A+T8ZDOmCgW/c5x7sSJc=;
        b=C4Sh+wp4LPBrOSeW5uRUCAyqOaODhvmoUtL4i9PNDPECZfbRSSE5QFkG2dfZ5V/J4f
         oj8TDcVBUKaTjDRI+vHvqKB88VNXT9WlAs8pJqqA9n9PL6ey1eCNvJWRFnWIr4HYY44l
         cVQHbCWH0QnVrLBd76OLRl5RnJlYOmFfxwLCqrD3DXcq303dfrbxrcHhSIJEtzy/tOQp
         FeEYeM1v13zNqo6Od6MBih+KapE8NCk7fn29Sqbf9C5Dykc0gRTny7f70jOMVkkQve8j
         Ufr4+I+L2WCQYGSB/nKz+mK6cbHV7IRjIzDLyXB53IrJxqkzQlCEHaHjeKRwhaUcAb/0
         iF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374876;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt29rWSoLvGyXVbCIGF5J00A+T8ZDOmCgW/c5x7sSJc=;
        b=2kmTL66NuEf5MOKPGlIQGm12HRdcQmbu3IwXW9dixnWEoQx7dRxAofiuS3uK7VmJqJ
         zk95yNXy7hx2xfI2m9D0A8Kifk6n937shSi8z76O2NucT15iAdj5iN4QUXNUpIXzv/HC
         puz1j3DtEV+sxZ51HLT7eNc/mHzeNUod9UdMAL7XkY76M4zTe6Ea66dqwmdY7Te8/mf+
         md9nWzUxBzkuE4tC+aVLOJdYvtcJO7PIUo5Y0hatVGxAMqAB82awlN0PpGz2V8Q/RoHw
         xjlsxCe6pwOegeu22FfnHytBMgep6i3nT1dnN5dPSEAV1QcaTsr1lDfZVkBnPUjpmpGt
         PCbA==
X-Gm-Message-State: AO0yUKVVUHRCLwVhHwBZElozudZaYBteKxLIHGxV0DtgMSf62NZTG08m
        WIxyEAevasFzDZRhbD+tqCy22KGdTm8=
X-Google-Smtp-Source: AK7set99RfO73CO7CRUWAqQrjCvoRlVCOdmSB30J3CI+ENUOjHu0bMoF34SLscgZ2ipj/rS8X+HOvA==
X-Received: by 2002:a9d:3e10:0:b0:69f:1577:d8e9 with SMTP id a16-20020a9d3e10000000b0069f1577d8e9mr370620otd.8.1679374875957;
        Mon, 20 Mar 2023 22:01:15 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.246.136])
        by smtp.gmail.com with ESMTPSA id f12-20020a4a890c000000b0053a7aaa85a0sm3164395ooi.0.2023.03.20.22.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:01:15 -0700 (PDT)
Message-ID: <64193a1b.4a0a0220.ed5a.c476@mx.google.com>
Date:   Mon, 20 Mar 2023 22:01:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3824053221107864274=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com
Subject: RE: [v2] Bluetooth: btintel: Add LE States quirk support for Intel's new generation controllers
In-Reply-To: <20230321043310.79085-1-chethan.tumkur.narayan@intel.com>
References: <20230321043310.79085-1-chethan.tumkur.narayan@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3824053221107864274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732171

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       FAIL      0.62 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.89 seconds
CheckAllWarning               PASS      38.73 seconds
CheckSparse                   PASS      42.81 seconds
CheckSmatch                   PASS      115.16 seconds
BuildKernel32                 PASS      34.09 seconds
TestRunnerSetup               PASS      509.89 seconds
TestRunner_l2cap-tester       PASS      19.29 seconds
TestRunner_iso-tester         PASS      20.80 seconds
TestRunner_bnep-tester        PASS      6.50 seconds
TestRunner_mgmt-tester        PASS      130.52 seconds
TestRunner_rfcomm-tester      PASS      10.26 seconds
TestRunner_sco-tester         PASS      9.57 seconds
TestRunner_ioctl-tester       PASS      11.71 seconds
TestRunner_mesh-tester        PASS      8.51 seconds
TestRunner_smp-tester         PASS      9.45 seconds
TestRunner_userchan-tester    PASS      6.98 seconds
IncrementalBuild              PASS      34.50 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btintel: Add LE States quirk support for Intel's new generation controllers

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (91>80): "[v2] Bluetooth: btintel: Add LE States quirk support for Intel's new generation controllers"


---
Regards,
Linux Bluetooth


--===============3824053221107864274==--

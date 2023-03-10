Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE489C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 08:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCJImO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCJIlk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 03:41:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE9113DA
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 00:40:12 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so7453895pjn.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678437611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pMsJcCY/PHFcOdhbQvkoeMN/+WXcfe3J2YUYvSVCYkE=;
        b=H2+y+Z8isbo4V9XWi/vPM5Sb+Czu5cdHt21g1/D41sln1yCbP32zzINJmjWcBNHZJZ
         alz/kbiaqLBRZTabJgV40f9BitVIqD6K/zqXaUlwpejz6AJuGguCUcCJEapKPTzMS5dL
         dg9Ji/fr7aPJ2pvWyWE3mHA7zaVGJc2k1wSMPUEns0+sx9KdTN4ah5gUZcB4Itlh3e20
         /HgxBr72aMZP9wv8XWGtRlt4yb+E9XtsYANdtYV4LF0ap1sV5kk/giEeWZzL7IgKrZUn
         zCMzSKjbncyk/Z1kYtIlkPneU7hzcTmXcTelpmMPT50UjhnKHyCmttSfTq3CKYfC+Tbe
         YrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMsJcCY/PHFcOdhbQvkoeMN/+WXcfe3J2YUYvSVCYkE=;
        b=rPeepTAdp+IAfnqpA82Jo14kRJdrX2FgYchvqe3/n1nf+smvjvUNZcCHrYOJYLU5cv
         rfmOUtI38hsqeuuhSr1VslE/JRX2zPd4XBOVOSubiWbtd9hqOj3ScWimWdtvnQeK+d/o
         2vEoOWxRJ3LOEySA9VJbal5ZY0pKpYzcb3OmZ+JxPO1mVIUyI//AA4EXWXdwBn9rwf3R
         Irpy1p9ivskwEISVRyo4X1Vq5mL7UpQThSlVCGZsr0Zu+BRpnd38BDQcQif6GOOh0EKj
         F6wf0u9gt/cxk54mN/UktNJc8bB1hNjTqWVJwfj9NzXS6O4iIMbs49F/Md7bzZDjnyVG
         oV0w==
X-Gm-Message-State: AO0yUKWn4iTN2xAWLcMLQudqc9Z4EaLU43y1yhy4ceDouf5250JiIYNv
        A9WZzRXRCivBFv6dXsNcXRlup5D3mV4=
X-Google-Smtp-Source: AK7set8geWJg2jUjX8PMGlftWkiOwwzOVWhof716N9ngUb5RhLrUeUQ9psqX2b3UeYvnshlfyOS+9w==
X-Received: by 2002:a17:90a:1a50:b0:239:ea16:268 with SMTP id 16-20020a17090a1a5000b00239ea160268mr27286788pjl.34.1678437611512;
        Fri, 10 Mar 2023 00:40:11 -0800 (PST)
Received: from [172.17.0.2] ([13.87.244.192])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090aa58b00b00233b1da232csm1204920pjq.41.2023.03.10.00.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:40:11 -0800 (PST)
Message-ID: <640aeceb.170a0220.2b8d7.27ee@mx.google.com>
Date:   Fri, 10 Mar 2023 00:40:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3662451848284129645=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        devnull+fnkl.kernel.gmail.com@kernel.org
Subject: RE: [RESEND] bluetooth: btbcm: Fix logic error in forming the board name.
In-Reply-To: <20230224-btbcm-wtf-v1-1-d2dbd7ca7ae4@gmail.com>
References: <20230224-btbcm-wtf-v1-1-d2dbd7ca7ae4@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3662451848284129645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728518

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       FAIL      0.67 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      37.57 seconds
CheckAllWarning               PASS      41.44 seconds
CheckSparse                   PASS      46.53 seconds
CheckSmatch                   PASS      125.81 seconds
BuildKernel32                 PASS      37.45 seconds
TestRunnerSetup               PASS      527.43 seconds
TestRunner_l2cap-tester       PASS      19.21 seconds
TestRunner_iso-tester         PASS      21.61 seconds
TestRunner_bnep-tester        PASS      7.16 seconds
TestRunner_mgmt-tester        PASS      130.18 seconds
TestRunner_rfcomm-tester      PASS      10.74 seconds
TestRunner_sco-tester         PASS      9.58 seconds
TestRunner_ioctl-tester       PASS      11.52 seconds
TestRunner_mesh-tester        PASS      8.97 seconds
TestRunner_smp-tester         PASS      9.95 seconds
TestRunner_userchan-tester    PASS      7.04 seconds
IncrementalBuild              PASS      34.06 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RESEND] bluetooth: btbcm: Fix logic error in forming the board name.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[RESEND] bluetooth: btbcm: Fix logic error in forming the board name."
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3662451848284129645==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE51C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 07:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiBZH6F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 02:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiBZH6D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 02:58:03 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1833E07
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 23:57:28 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id ba20so8553268qvb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 23:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pjM5jqiBumR0DoODXNItTwq3Q1LJrvikcvppeZXZwn4=;
        b=mB3sE8gocMT5N1nIvwWlkEOgCSeb106vt73VzeN4UOrPCKGRSE92rX4rGOxPksjFyH
         3sGVDSFYwmpl4jEls9fgfxNf/sN0HHcYKa98oSPk2luCHHUPlhgiM7+nYdScPq01Q3F8
         w1DX6bxMYM6OHidPj57OpcACZo8Dw8Xb5yrFen/8lS2HzGeEKiiUyIKGRLRL1T4GUQ+W
         N27xG5U3XB0sQeZTXeK6ddfPSEz8DyeKFzkj5eG2Dy0WpmvEwv6UCs1T9QLS79KdmELq
         l5JpvpXOucMnKBMCy3tJcqch1u1JBIlH/RuLZtI3kYuaCotNyYL2JReBjh8j8U/Rr/uj
         rY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pjM5jqiBumR0DoODXNItTwq3Q1LJrvikcvppeZXZwn4=;
        b=V12yEPlrYKlzrNKcJPthaUhRHfk0+I4hncIvblmZmuzjjny1WrR9qrbZzyf9rjFZyh
         9CEmc0vs4rGYUjHg927DyAaTUNcINMSM5ouL/Fo66x8zD7zKFb9hkLD2EV6ZeI2UTwxt
         xKmxnY24D62f3BsT+7mtIDu6taMSm+ZjD7MPIwHIOzJDEPAgVGQWaFtGwLHVIwij/3jO
         k4p/pX5aS4OqcIWEJpQLNfQvGnqeX/dxT+buSh4WwqlfAY7tmt2MjoaTceI9mnv55aq6
         bktFcqey+LOuJuiRGRwFfw2t3a7nhkZfI5w2iI7SA47vQJB1gBfQwD+Jh3P7ngL8e1pj
         dQJA==
X-Gm-Message-State: AOAM533sWV9F/XwqTk04TvDIxOB6xSTI30yR28cZJp7YKCUXIRcxFG50
        a19/YNLLvVDJZRADDRkCQNB7uqNM7tQMJw==
X-Google-Smtp-Source: ABdhPJwEn5Uil4ZsjiymObAzrcrEXKgkHj4nA/hwHMyLyPTKD6CWvCXNVC1wEuA2NPxqA6Qb4J3p4g==
X-Received: by 2002:ad4:5225:0:b0:42d:f3a3:c9e0 with SMTP id r5-20020ad45225000000b0042df3a3c9e0mr8318607qvq.82.1645862247032;
        Fri, 25 Feb 2022 23:57:27 -0800 (PST)
Received: from [172.17.0.2] ([52.249.253.231])
        by smtp.gmail.com with ESMTPSA id j10-20020ac85f8a000000b002dde6288fa7sm3020171qta.83.2022.02.25.23.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 23:57:26 -0800 (PST)
Message-ID: <6219dd66.1c69fb81.a3f09.2e25@mx.google.com>
Date:   Fri, 25 Feb 2022 23:57:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6094414794810688055=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD based platforms
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1645767286-13890-1-git-send-email-quic_saluvala@quicinc.com>
References: <1645767286-13890-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6094414794810688055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617853

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       FAIL      0.94 seconds
SubjectPrefix                 FAIL      0.87 seconds
BuildKernel                   PASS      31.96 seconds
BuildKernel32                 PASS      28.30 seconds
Incremental Build with patchesPASS      37.88 seconds
TestRunner: Setup             PASS      471.58 seconds
TestRunner: l2cap-tester      PASS      13.36 seconds
TestRunner: bnep-tester       PASS      5.92 seconds
TestRunner: mgmt-tester       PASS      103.35 seconds
TestRunner: rfcomm-tester     PASS      7.52 seconds
TestRunner: sco-tester        PASS      7.33 seconds
TestRunner: smp-tester        PASS      7.22 seconds
TestRunner: userchan-tester   PASS      6.10 seconds

Details
##############################
Test: GitLint - FAIL - 0.94 seconds
Run gitlint with rule in .gitlint
[v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD based platforms
1: T1 Title exceeds max length (85>80): "[v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD based platforms"
11: B2 Line has trailing whitespace: "v1: intial patch "


##############################
Test: SubjectPrefix - FAIL - 0.87 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============6094414794810688055==--

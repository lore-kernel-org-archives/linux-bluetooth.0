Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE89C636D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Feb 2023 17:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjBURKr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjBURKn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 12:10:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6142E802
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 09:10:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id y19so2772555pgk.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 09:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkl7jqRsf64Yb2qToKzAJ3/4LFb9wJpqA4ofHO+GSv4=;
        b=NVVd9/joy64IPtpUOXyRKw+fYuyTdyHLCCEOTskkY73raEhwspl49JFtZrZoFpBkAb
         yXb6EeTcjp473F5QjX/T4kj8Q8u9PpjtqibfX30SBPhXhtjOkYptOJ7T6tZQGovlVDea
         XhVZ7u4PLu1XehQyqtjyvN26EwT9Gu0PX0E1OGcZqFeRndVJmNgdiqptOZjr4k8y8uGU
         m9HFYQiUhkz3BMFA6RSC50YVQvMZqKx4FC35X/G8GiS5DADr/15x2XrobvMoOMPVaesV
         K2UNbB282fruBbBWp9v9G5kEEEGp3qy0fnehc+90vSeZs+OqG9b7vcei0uIQ/aRHmdtv
         8AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hkl7jqRsf64Yb2qToKzAJ3/4LFb9wJpqA4ofHO+GSv4=;
        b=R16vsvQyMfIE1wX0FLewKHTqPZYknZwZUABEsO0p3qvAbqPcWHtV7fs+PtY+W93Zu9
         UZDDwBj0OQHs45StcA5VGjRkLZU9FKmCgwzqnLw97kGEuhyAhnzYDNhqAyluePivqVmX
         YGIl5twxNvMFnCPyrZG13QxBzb0+5C6Er9y6S8PW3msyd6haHr5rez6vvyMyaQl8OH7u
         6c42fyrXbIkFb4ZoRj8ZmNKgKciXZT7pRrX+tF3rZT09dKpL6AuskXNp2JrGofBdRDgG
         uB2xFQRoiChi89aD1NsTmfep5g02p2uigRQAyi3WWhjiBGO+FxC7IQFyBdH5/forYa+q
         mLlA==
X-Gm-Message-State: AO0yUKXP5OYdYXIRdOlA2UBmD5+7JDB9AMd1QgK+etAqilUd5Psz+xlU
        nm+VP1YtyVlPwOG00AHf1KBx7a5ZJSY=
X-Google-Smtp-Source: AK7set+D4MGIT1sgL1cEqc7AVucmHc7+pGGLnkJHEyaMeRIiH6b+8UhIlqrip705+4EE+OH1kI1Jvg==
X-Received: by 2002:aa7:8f37:0:b0:5a8:ab3d:3fe with SMTP id y23-20020aa78f37000000b005a8ab3d03femr5587955pfr.16.1676999435814;
        Tue, 21 Feb 2023 09:10:35 -0800 (PST)
Received: from [172.17.0.2] ([138.91.227.49])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b0058bc60dd98dsm1751210pfn.23.2023.02.21.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:10:35 -0800 (PST)
Message-ID: <63f4fb0b.a70a0220.a6575.337d@mx.google.com>
Date:   Tue, 21 Feb 2023 09:10:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7030185374353872834=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230221162541.3039992-2-neeraj.sanjaykale@nxp.com>
References: <20230221162541.3039992-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7030185374353872834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=723811

---Test result---

Test Summary:
CheckPatch                    PASS      4.40 seconds
GitLint                       FAIL      1.09 seconds
SubjectPrefix                 FAIL      0.54 seconds
BuildKernel                   PASS      37.75 seconds
CheckAllWarning               PASS      42.26 seconds
CheckSparse                   PASS      46.95 seconds
CheckSmatch                   PASS      126.87 seconds
BuildKernel32                 PASS      36.80 seconds
TestRunnerSetup               PASS      524.04 seconds
TestRunner_l2cap-tester       PASS      18.57 seconds
TestRunner_iso-tester         PASS      22.00 seconds
TestRunner_bnep-tester        PASS      6.64 seconds
TestRunner_mgmt-tester        PASS      126.64 seconds
TestRunner_rfcomm-tester      PASS      10.48 seconds
TestRunner_sco-tester         PASS      9.71 seconds
TestRunner_ioctl-tester       PASS      11.48 seconds
TestRunner_mesh-tester        PASS      8.41 seconds
TestRunner_smp-tester         PASS      9.48 seconds
TestRunner_userchan-tester    PASS      7.12 seconds
IncrementalBuild              PASS      44.17 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (109>80): "v2: Modified description, added specific compatibility devices, corrected indentations. (Krzysztof Kozlowski)"
16: B1 Line exceeds max length (85>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7030185374353872834==--

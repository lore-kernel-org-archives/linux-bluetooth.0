Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F06C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 11:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCJLCD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 06:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCJLBq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 06:01:46 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D519079E
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 03:01:42 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id be16so3969488oib.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678446101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PzhJaojbFcACTXE1SzsEMldhMI79E3oKerU14RmNRGQ=;
        b=QUWgSM/bxwuUaJlYWGjwHCcPHe1E8SurwEOPgEMwe0/ZOQYdNaMsksWZgjH5PyvrLw
         QgnqiOzBOrKAIG1suhwTybIT2YNrmeaiPJYa1Xdfzvuu42LY9wm3eWmFGkkZzcs+BLsP
         hTQQR43HmOR8jI4RjSFYjs4v9qiwCis8cB1dprBFnwdkyj8Ni9C00b86clm2GESkYMFa
         6pbSu8wOEcfFqA+a4AwrHs1B6boJnpjuK042F49rK/aMOP26809Loe7uZl3qB9a7I67q
         4kWodtrw7zKM4KjcZd67t0u/z+MK7ZcpfWey0MXG8uVqeyTGqL6qLwewX6gJtdDWp+al
         pb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678446101;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzhJaojbFcACTXE1SzsEMldhMI79E3oKerU14RmNRGQ=;
        b=KNU+O/suNOA4BJH3Cyfy5Q2/YrF64YFOwZjSl8LbzhaKjRlhZlid1OEW+GhZSMxpnT
         6FQOfBtemcFeSwnxOj0db4I4f1jhZjMhzHfl2KWrELsteH1CA5ulujiUOXDAaHwUG6Pr
         RQJ+EETVM3p9w42fYzD3mGzMZwHQa/oZyIDJIHeqAqeckJIzI8dQ3gZtgDOCoEQRB3wd
         VHSN90xrghyRd7VeO3SCjPygwew7Nvhc3uokpRGsIyz6UwmwHqv9TNWcRahB2tqitG8F
         VuEjtO1aWk59riXOcXF3gRTZuvPyLoQZem32Qeuio9U10treZ4hTcOBz2aSVN71dcGJG
         p21A==
X-Gm-Message-State: AO0yUKUV6uH3Q1QfsXJ5qrsPsYNymxoeQf+QQTqGPzPFCbgWzmFEWw3L
        WogGd5z4UDyFurRUJEBNRY6Z6A8RY+Q=
X-Google-Smtp-Source: AK7set/ZlZQavDZCkPDYKXhEHKcVGKHyb8pfFfMCwzWQ9E4oet8e93QVLgmH2YjLVfe9J50qqwhlqw==
X-Received: by 2002:a05:6808:45:b0:383:f8e7:1dea with SMTP id v5-20020a056808004500b00383f8e71deamr11464329oic.19.1678446101137;
        Fri, 10 Mar 2023 03:01:41 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.227])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a0d4c00b0073d873df3fesm1145572qkl.30.2023.03.10.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 03:01:40 -0800 (PST)
Message-ID: <640b0e14.050a0220.43878.2f31@mx.google.com>
Date:   Fri, 10 Mar 2023 03:01:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5708953942689491320=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        devnull+fnkl.kernel.gmail.com@kernel.org
Subject: RE: [RESEND] bluetooth: btbcm: Fix logic error in forming the board name.
In-Reply-To: <20230224-btbcm-wtf-v1-1-98b56133a5b7@gmail.com>
References: <20230224-btbcm-wtf-v1-1-98b56133a5b7@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5708953942689491320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728567

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       FAIL      0.63 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      31.97 seconds
CheckAllWarning               PASS      34.72 seconds
CheckSparse                   PASS      39.10 seconds
CheckSmatch                   PASS      106.14 seconds
BuildKernel32                 PASS      30.78 seconds
TestRunnerSetup               PASS      438.26 seconds
TestRunner_l2cap-tester       PASS      16.56 seconds
TestRunner_iso-tester         PASS      17.61 seconds
TestRunner_bnep-tester        PASS      5.83 seconds
TestRunner_mgmt-tester        PASS      113.20 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      8.42 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      7.27 seconds
TestRunner_smp-tester         PASS      8.23 seconds
TestRunner_userchan-tester    PASS      6.05 seconds
IncrementalBuild              PASS      28.75 seconds

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


--===============5708953942689491320==--

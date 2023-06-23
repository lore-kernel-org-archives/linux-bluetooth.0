Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD7EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 08:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjFWIoQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 04:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWIoP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 04:44:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B313D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 01:44:14 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9b4a656deso5184381cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 01:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687509853; x=1690101853;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ByhZWn2cF45BWVjHjMDT2S7RLFXTIbavvpm9sb8PwY0=;
        b=f85Q2kK3IOrDQB0RS3pmx+yD/dh7zV3gIMUhIJjdJAiKvZsYcWtTtZCclkYvwB7iZV
         VHLz6NmxbiW+l6su/oRmRKAutgo2HOc99TAN0ekvwxToU1Q2IY9bPw9KCldc9BUBSrNy
         ML5MBpLzxMLSYYuf0R5LsjHm02IiFK2VEMO3+7BSkLm/cMALx/Fhy1OlcLrWBlbV1OAS
         bDu9YSNIjqYv/JE27XXHDhbIJVuy2yPZdBt2HyWlJAsKzLsKLhrSbJbQjUKNKXT26Tly
         Eza6Nr/q1s2Xm1JySJYHr7E9WeCNhiodIUSQTnMOmp9+Ph8IhNue9Uoyr0SJ1CPOwUYD
         3gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687509853; x=1690101853;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByhZWn2cF45BWVjHjMDT2S7RLFXTIbavvpm9sb8PwY0=;
        b=Y64GmUkho/YpHMN2Mlom1ghGT7T8dMS6TJ+dDAE0GPYAd6As/DpIR/AVE/QKTJRHTY
         hVv5tVkYEc8MdBmMl0L/hlhUKz4LN+FZlHAHrpkBoRvMxioT+tnsLWwI7mQ9Ho9xPs+c
         8c3V1HXCbSWyPl1WuOyUXcRBzFHelPIegngWK+xM6mV2sfxdE1WDxILB+y3K6LZza0MX
         yUdz/m6C51YQKqADIlKXnrF+DM3RgQFz54gJV46zOLHzGnnOcS4jmwdxuQupdRsON6zx
         PLsRE2rg9A2DTspwwRxMHPfuVpiBE+euqEWNyWM5dYcJqgDDlpDzgd/z0xaILWOZ/6wD
         uj8g==
X-Gm-Message-State: AC+VfDxPMXuhgDLoPuUpIQzNh7O4IhABx/8sMMBgUPVBjnaTkwcoVOh9
        HaN+fAexiHLWzfa1RR2MHhwJ29/wYLk=
X-Google-Smtp-Source: ACHHUZ6GT5nUzhJd2iWmbHyJ/QXR41zjUneYN0XwDEvaUAKR4DejD3Lw2SdDr2oaIHKjeizcIiYCXw==
X-Received: by 2002:a05:622a:1ca:b0:3f9:adf9:a708 with SMTP id t10-20020a05622a01ca00b003f9adf9a708mr25824898qtw.44.1687509853515;
        Fri, 23 Jun 2023 01:44:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.15.179])
        by smtp.gmail.com with ESMTPSA id c13-20020ac86e8d000000b004008399a965sm991425qtv.74.2023.06.23.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:44:13 -0700 (PDT)
Message-ID: <64955b5d.c80a0220.13b32.3167@mx.google.com>
Date:   Fri, 23 Jun 2023 01:44:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1059279485421820715=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Notify user space about failed bis connections
In-Reply-To: <20230623073842.16466-2-iulia.tanasescu@nxp.com>
References: <20230623073842.16466-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1059279485421820715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759714

---Test result---

Test Summary:
CheckPatch                    PASS      2.05 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      46.50 seconds
CheckAllWarning               PASS      50.56 seconds
CheckSparse                   WARNING   58.56 seconds
CheckSmatch                   WARNING   158.23 seconds
BuildKernel32                 PASS      44.82 seconds
TestRunnerSetup               PASS      635.79 seconds
TestRunner_l2cap-tester       PASS      22.48 seconds
TestRunner_iso-tester         FAIL      33.86 seconds
TestRunner_bnep-tester        PASS      8.03 seconds
TestRunner_mgmt-tester        PASS      171.90 seconds
TestRunner_rfcomm-tester      PASS      12.62 seconds
TestRunner_sco-tester         PASS      11.53 seconds
TestRunner_ioctl-tester       PASS      13.73 seconds
TestRunner_mesh-tester        PASS      10.09 seconds
TestRunner_smp-tester         PASS      11.44 seconds
TestRunner_userchan-tester    PASS      8.40 seconds
IncrementalBuild              PASS      42.04 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 76 (95.0%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Receive - Success                                Failed       0.286 seconds
ISO Receive Timestamped - Success                    Failed       0.269 seconds
ISO Defer Receive - Success                          Failed       0.293 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.284 seconds


---
Regards,
Linux Bluetooth


--===============1059279485421820715==--

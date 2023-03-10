Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1996C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 01:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCJBea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 20:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJBe2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 20:34:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106E2DF70C
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 17:34:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso3789608pju.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 17:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678412067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jChHm8SKUwOnahRT34MUkucF3/sPS4AcgD4Yzv36T4s=;
        b=k+w+2GXF3mstAmqF5DAEmLKrn/8CzkL9lrWRptLo5yX2doFQyj24awlrW+ZqGdWVWU
         dyXuxReMt6FUWumXlDWajuFPEHgYbEVB2wMQ9DnOydvFViNbIQW6c3BAWYZn8dOxVxHG
         miAx2hqJb2JRYJnXmq25QgGKlYFqYB/mx9CKxhUrlplS8DpIV1q6aLf3ePiE1doap2T4
         NLaPApoeDEBKlrW7I9ureaDBzq7MJqIeAQeIfa1ljemuNXLvORbtvU8Dj5JtodsKN4Xu
         9dOirypTAx7F7Ox+uEd+XUBkWu3wmtBT6MW55LOpzW6hz80AlFw86XJtdUfuXjJ+TT1y
         TGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678412067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jChHm8SKUwOnahRT34MUkucF3/sPS4AcgD4Yzv36T4s=;
        b=F9BBpg1m24/blzDRYo5/C8AZEnKmwUNb8YMc7UHDHoLXCqRvMGt5gpPGJP49czG/hr
         0x2Z3OZ0bZxofkCft+IzF8HPp0nSTXNaitdubj4U98f8M914a6h3VsP0ECiZE0j6LELC
         1BDzzjFIxa2xVrhbKsbU1B4JwEaMpyLNtwG1G4mgsoEbzxXjKTO5ip1riFIw0MNObclG
         uSksKm2lfn0MbnZyY93xF2n1v/rDuNBCGeyrTEhwH/9xZGK1PiLCK8szvS9sdbT0xG49
         soxs+aE3N8Q96NgL3VkJRScw2etEeQNjUWJvt3Qp+nySk6UZEKUFwphOG3afC5l9TPR4
         RNQg==
X-Gm-Message-State: AO0yUKURW7YMOKa3XUwqLLF247dQ1N8EGXerMaSHx5Z0KARmmCwSs4W/
        1OSL3N1RplNs6a0Hs987DGqbtIqXGjE=
X-Google-Smtp-Source: AK7set9E+JwUQIKYnznl63oNBl3ktzxDNMUzCzSbKUoB2RXm8IAkgX1JzxZcNoQ6JOlBr10XqTxXFQ==
X-Received: by 2002:a05:6a20:7345:b0:cb:ac6c:b02 with SMTP id v5-20020a056a20734500b000cbac6c0b02mr698409pzc.2.1678412067234;
        Thu, 09 Mar 2023 17:34:27 -0800 (PST)
Received: from [172.17.0.2] ([65.52.126.105])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7920f000000b005a8e9e2f1c5sm190133pfo.187.2023.03.09.17.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:34:27 -0800 (PST)
Message-ID: <640a8923.a70a0220.4bb48.0832@mx.google.com>
Date:   Thu, 09 Mar 2023 17:34:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4584604968212537483=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: L2CAP: Fix responding with wrong PDU type
In-Reply-To: <20230310000055.3396026-1-luiz.dentz@gmail.com>
References: <20230310000055.3396026-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4584604968212537483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728435

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      37.94 seconds
CheckAllWarning               PASS      41.00 seconds
CheckSparse                   PASS      46.38 seconds
CheckSmatch                   PASS      125.41 seconds
BuildKernel32                 PASS      36.22 seconds
TestRunnerSetup               PASS      522.89 seconds
TestRunner_l2cap-tester       PASS      18.55 seconds
TestRunner_iso-tester         PASS      20.48 seconds
TestRunner_bnep-tester        PASS      6.67 seconds
TestRunner_mgmt-tester        PASS      126.45 seconds
TestRunner_rfcomm-tester      PASS      10.46 seconds
TestRunner_sco-tester         PASS      9.62 seconds
TestRunner_ioctl-tester       PASS      11.35 seconds
TestRunner_mesh-tester        PASS      8.34 seconds
TestRunner_smp-tester         PASS      9.55 seconds
TestRunner_userchan-tester    PASS      6.98 seconds
IncrementalBuild              PASS      48.87 seconds



---
Regards,
Linux Bluetooth


--===============4584604968212537483==--

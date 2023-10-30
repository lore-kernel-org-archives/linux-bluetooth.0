Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDF5C4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 08:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjJ3IG3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJ3IG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 04:06:28 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA27A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 01:06:26 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6ce2988d62eso2885531a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698653186; x=1699257986; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DwXxWGPFhZ5EIPV0cz0ENUXMixXQ7vplAW62feKY02g=;
        b=VU1jML84ucWTfjWP1kEiHCmUN+pk07Zd2S7nNBRbuIn9DGJOUTrdFg3f6nHHi0jnqy
         oEBabXCe5LbYWvIWjsmlpC6rZzDT87BWIEDZtRni0jOWFm7V0x+7dD5GCSnyTbuJEhEn
         tfDFWvU5wbLsTkwBaaAvKyjOIDKZMj6mORjGpVrSusXPRgZAIw2F4m64snv9n+Dc7CJd
         aPSkwr0/HOU/3RyyJMItLaP5lu+DaX1bbXzAInSo6jgmRQ/dROiOOKQMHAS8yipAJiMJ
         rfMQN030f9lY8mVA1RWFp4tdgn4TzAJKguc58i56H235qPVTert0wBVzGkph6HePk0g/
         k6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698653186; x=1699257986;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwXxWGPFhZ5EIPV0cz0ENUXMixXQ7vplAW62feKY02g=;
        b=QjOhmZT73tzxF2dQqs3Ykz0C7ImSdtVfiXcQJKf5TNYr5B2lRZdbQ2YW9Or/XoGCQX
         JAeT9EqdZXQFmTGznr6Dy+PDjeXxdcymUheytXPIdJst8lS2EHvWo5+W+93PTqhf7qXc
         q4kgZ46XrC3Rj8nXvH9p/qaAwTrmFq3bodb3/4q9KioMbCx3clZp3bgHa8paul3VuBaf
         XAmxDxphONK8Pon33XcRKhdIJFAg+Q46QUuo7jvPFQkuLltJAcgl2sCB6bOwwydAagZ5
         iJXeOBukLZoZOTI5ymsPB/jvVNM19SpugfvdES/BwuKxUpVha6NxzpCwbl2fMc88ENK9
         apYQ==
X-Gm-Message-State: AOJu0YxRuRhXxaKBUEJfKC84V/jh0R24A3ZQvp/7E6XU1XBHFyjHTD/C
        zT+1L686bzKwmKfdeYfXVE/8r5ynVQU=
X-Google-Smtp-Source: AGHT+IHq/n0MVjQEDvL3iXi1QEoKkYny017m2eNQI6lKxX6UtzjxjzJq/Ec15+v/Jl7fWOyOd3Ilcw==
X-Received: by 2002:a05:6830:6b87:b0:6b9:e3b0:1433 with SMTP id dd7-20020a0568306b8700b006b9e3b01433mr9743542otb.37.1698653185832;
        Mon, 30 Oct 2023 01:06:25 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.140.44])
        by smtp.gmail.com with ESMTPSA id x18-20020a4a97d2000000b00581f11e81c7sm1708978ooi.7.2023.10.30.01.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 01:06:25 -0700 (PDT)
Message-ID: <653f6401.4a0a0220.c4bb0.773e@mx.google.com>
Date:   Mon, 30 Oct 2023 01:06:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9063028663718926565=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test
In-Reply-To: <20231030071558.1631825-1-neeraj.sanjaykale@nxp.com>
References: <20231030071558.1631825-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9063028663718926565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=797485

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      42.35 seconds
CheckAllWarning               PASS      46.75 seconds
CheckSparse                   PASS      53.30 seconds
CheckSmatch                   PASS      141.45 seconds
BuildKernel32                 PASS      41.06 seconds
TestRunnerSetup               PASS      635.14 seconds
TestRunner_l2cap-tester       PASS      36.96 seconds
TestRunner_iso-tester         PASS      68.61 seconds
TestRunner_bnep-tester        PASS      12.92 seconds
TestRunner_mgmt-tester        PASS      260.39 seconds
TestRunner_rfcomm-tester      PASS      19.59 seconds
TestRunner_sco-tester         PASS      22.77 seconds
TestRunner_ioctl-tester       PASS      22.06 seconds
TestRunner_mesh-tester        PASS      16.30 seconds
TestRunner_smp-tester         PASS      20.28 seconds
TestRunner_userchan-tester    PASS      13.56 seconds
IncrementalBuild              PASS      38.69 seconds



---
Regards,
Linux Bluetooth


--===============9063028663718926565==--

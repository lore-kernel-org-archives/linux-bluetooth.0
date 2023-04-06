Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A014C76196
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 09:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjDFJdC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjDFJdB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 05:33:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6633A9E
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 02:32:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y4so7461702qti.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Apr 2023 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680773571;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LySu8FhsFqYGB2q5Ms3jVNFkq2I0tBXM338DaQqatd0=;
        b=YKHXyO8qum0i8GyVcPqeoBoTK8gsz2Q4ghDyQ3U6vQSQfNROc38bIjVMno/+6Ktz1Q
         7zA7AMtlTMdaT2djoL7NAahNybq8XeKsozZGV4ySYq8WUtljmbmBxAbP6HKCWvR+bdOj
         O9XCT773yW/5t9JfqtDTrI6FFF+B1VTad/1IdXUhdJ+KCmiDBNJG7CFtG/tWb0se984K
         uJ6j/FmaxyhG5i3kOUTWGI9uGGIB2spf/id+05EpfqxsZzNxQ8xYF5nqJ6XmGqDI0U8f
         qEQ+y4OtGY8KmUcmJ/pojV+YmfLMfitY5iHSZ04I5t+ECN5pNw3h6w+AEb45kiqmH5dg
         L57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773571;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LySu8FhsFqYGB2q5Ms3jVNFkq2I0tBXM338DaQqatd0=;
        b=igRZgrwDbbEnXf0kdLmY2VjC/PyZoNbysQR9AYL5zSot9vSx11eZ/5SjQlgQqu0Zfa
         VVIp7H4eJ05zMdboak62LfMB9VMqOPMZHN9lCpo1NCSzvKWNy+T5xexET3JXN5ie7nPH
         JaQCrejqAzTrGfTLvVHBj+0zd2p0cIwRs0BjilOV7sATUUM2qdpNoOYsb+WEUMCfpoUB
         MT3wFkbhHj8p83olUQOfmmiAUpRVKgLj3T+rRahOnGaLilVFOBO8OUI/LGSDpwN06UuF
         eFFNqBGKBS9Dss3bq/mjIAukJCHmOGo8UsdtfiIYb/RaYk/eff18qyDj/anhW0UEftk1
         XBsQ==
X-Gm-Message-State: AAQBX9epoWd3ypBAtOYYqt9RcGE10LQYDkJUZZDa34wIKTJetDWSZItr
        MKx7sTSWmGbLkmqAlU7pV16U4FXgzjk=
X-Google-Smtp-Source: AKy350YTyyaGf+Bum2g97Jx8IHDJSh4EtUDQtFWRrpqmqtpQjMSqmyrsnBVBaHG1PboYWfC8NrvR+A==
X-Received: by 2002:a05:622a:1890:b0:3bf:d35d:98bb with SMTP id v16-20020a05622a189000b003bfd35d98bbmr8828775qtc.56.1680773571102;
        Thu, 06 Apr 2023 02:32:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.120.52])
        by smtp.gmail.com with ESMTPSA id 13-20020a37080d000000b0074a3c282c7dsm337381qki.97.2023.04.06.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 02:32:50 -0700 (PDT)
Message-ID: <642e91c2.370a0220.a3318.0e13@mx.google.com>
Date:   Thu, 06 Apr 2023 02:32:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9114459394749372134=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, error27@gmail.com
Subject: RE: Bluetooth: vhci: Fix info leak in force_devcd_write()
In-Reply-To: <634ab328-3ef2-43b7-8f81-8a48c7661427@kili.mountain>
References: <634ab328-3ef2-43b7-8f81-8a48c7661427@kili.mountain>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9114459394749372134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=737502

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.67 seconds
CheckAllWarning               PASS      35.20 seconds
CheckSparse                   PASS      39.42 seconds
CheckSmatch                   PASS      110.45 seconds
BuildKernel32                 PASS      30.78 seconds
TestRunnerSetup               PASS      438.26 seconds
TestRunner_l2cap-tester       PASS      15.87 seconds
TestRunner_iso-tester         PASS      15.60 seconds
TestRunner_bnep-tester        PASS      5.10 seconds
TestRunner_mgmt-tester        PASS      106.48 seconds
TestRunner_rfcomm-tester      PASS      8.10 seconds
TestRunner_sco-tester         PASS      7.45 seconds
TestRunner_ioctl-tester       PASS      8.67 seconds
TestRunner_mesh-tester        PASS      6.42 seconds
TestRunner_smp-tester         PASS      7.40 seconds
TestRunner_userchan-tester    PASS      5.32 seconds
IncrementalBuild              PASS      28.53 seconds



---
Regards,
Linux Bluetooth


--===============9114459394749372134==--

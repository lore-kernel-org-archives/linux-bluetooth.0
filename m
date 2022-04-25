Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5711BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Apr 2022 16:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbiDYQPp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiDYQPj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 12:15:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030811C998
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 09:12:34 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id hu11so12117930qvb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dxyqqTI2+OVOhetC48XiGclQIDnoko/tDpJBQSWmo7M=;
        b=EIwiaCVPJpsqZ2aaKrdke+8SYCGlFnoG73p3UPB5ewFd+xYo5gRydwZd5W9GYfbMtW
         TDSd62ww+KRHjVJSmPTJbP7oyiGxs4nY+hnAPYimh75aeGXnwnCjySdWwQVLUiPy6ZJf
         q6OwD0aLER+taO+jSKjF0hkp8EWFcQsfZ+jokVIa6s+GxWbljdZWtiAEfDxvE6siNdk6
         tos+MVe/u2EbfPN715aJ847036lxky4b+X3LnZLCjXstyg+bUoAYzuj1Q7Axqol/r+g5
         nYxcBMu2+Bn9XqJj2lutAhGHuvwM8w5jIgyc51x7rJZbguAuHGsZbVzVeGyaQSxSA5zt
         Oz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dxyqqTI2+OVOhetC48XiGclQIDnoko/tDpJBQSWmo7M=;
        b=wqAcQql3U85qR66p5tsNLdC0yXjzogsl/6piLc3EpTbuNBjyXfp0Y5z0owcLUNfpN6
         BQ0lB01XWBbgQ5CK2rnC+gfplwKCSXW7n5kFCWBBLErvdi5sC1HBW1H6+0QSz35cC2ep
         JsILk3btWXU+NgLeqyBffTzDo8A6ktz0BJU8C18hmszrv31/TjWvSknSEPA2Johd3M8I
         4bUOxwVt1xoOrcGsErmFcfXNkhVqwUNPf0/YVfr9tECJZgSqCP9M04N6i6+yqS1klmA5
         wAEaD+LzyAkrU1oawueK7KVaAoA2RCp7soaHKXYgC3qbxKMrh+7bPN3ulf7SF424Xczn
         jlUQ==
X-Gm-Message-State: AOAM532lTFxWCvjlbsNb9BNyE4WnkDiK0+O0KVe5XeKsgcRhQOLdMh9B
        fT2qGhjmCnBc2afNgJevz/WGbxvtTY3+dQ==
X-Google-Smtp-Source: ABdhPJx6vur1pv0XlltjNSLeopEBKnVRuy8uY5kDlxM6HOL41iKAADDKwKADowU54Y0UbDdoq2dnnw==
X-Received: by 2002:a05:6214:226a:b0:456:3724:ddab with SMTP id gs10-20020a056214226a00b004563724ddabmr4262262qvb.126.1650903152329;
        Mon, 25 Apr 2022 09:12:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.110.85])
        by smtp.gmail.com with ESMTPSA id o4-20020ae9f504000000b0069e75e7387fsm5043091qkg.43.2022.04.25.09.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 09:12:32 -0700 (PDT)
Message-ID: <6266c870.1c69fb81.ac2f.b56e@mx.google.com>
Date:   Mon, 25 Apr 2022 09:12:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6347312606717167527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v3] Bluetooth: btusb: add support for Qualcomm WCN785x
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1650898889-12470-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1650898889-12470-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6347312606717167527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=635371

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      36.74 seconds
BuildKernel32                 PASS      32.95 seconds
Incremental Build with patchesPASS      44.00 seconds
TestRunner: Setup             PASS      553.75 seconds
TestRunner: l2cap-tester      PASS      19.28 seconds
TestRunner: bnep-tester       PASS      6.95 seconds
TestRunner: mgmt-tester       PASS      113.56 seconds
TestRunner: rfcomm-tester     PASS      10.91 seconds
TestRunner: sco-tester        PASS      10.52 seconds
TestRunner: smp-tester        PASS      10.56 seconds
TestRunner: userchan-tester   PASS      7.28 seconds



---
Regards,
Linux Bluetooth


--===============6347312606717167527==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6068C77B72
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 11:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjDTLcv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjDTLcX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 07:32:23 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF72119
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 04:31:48 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef8aaf12bdso2072366d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681990308; x=1684582308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/iQTH2YcdckI/myca46FYt7LwqfeAUAApW4WPYDEx8=;
        b=HdlBTsRDKL5DCUIcarDledMsIDFecLq7NVVAUEDolZIFgQmZmHgWJ6waaP1gfOR4sL
         5kIVtYYRUj+94DJrcmc19KcUkCblHcMZ5Yj6kGaXtyKBMLD42uNm20kJvJjEF+4YpUv9
         JH7xSANF3mKjvs+TxHqPzdXuYNpdbsBdVOTV16DFxhE4cJMCil3pegXdrvTHwa7q5L94
         Vw9VC7IgV4rRMoXtoFM1DfWNgK36Lt630CO/b/EG7WjmOCWz1te0uVfTkjYEo85XLB23
         sINgF43PhMDyI3Z66ivCALbm+vfkMl0RQAQZxkJr7FUXS2dSZUxCRNOZV07SyxJK8Hyz
         g18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681990308; x=1684582308;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/iQTH2YcdckI/myca46FYt7LwqfeAUAApW4WPYDEx8=;
        b=f/8qo9a51kAN8lM7o6THpSATYFsixg7MoGr/3uDfP6E6bEolWnRO8deNmIBwRgpw3W
         F46Tp2mIZKUYsPlW+QM+nJ6kyWLsjyM7PAOIgBlA/dxvmgV51ASkuWk4bu2cuYICLlIQ
         mCPzsi7iIBKuhrMLholFjjwAH15KwHtTQD+PtDOk9rEbabXdTG3yjv2IbaMFtWzwrBIu
         M3ESOj8DqLBMcL1/kBmksXYrlj+pZcHuqMhssS/hRvGVDKXQ2VBU+fHgJNpSZjsNn7ap
         CHz/8a/4VokWRL3etgMmTrdjnyk9jDqheiNNDjdKxUeXWYg5/mKXXJDrZCa8G8oIAccf
         In/A==
X-Gm-Message-State: AAQBX9dGkSM18+GwSFUIxd1CBUqCEUv5L3ct9K5TDwfN84vzuxWfJttU
        R5w+3/9Jx0hH9hijUE4oj7H4MHRiR2g=
X-Google-Smtp-Source: AKy350ZqjclQNLllX+MA+kgLPyJtmYmvd+z6kJSKhuXzrbxC3RYnW0Cj4MLf+KirhwWhJi9jG9w2Dg==
X-Received: by 2002:a05:6214:2a8f:b0:5ef:5307:1076 with SMTP id jr15-20020a0562142a8f00b005ef53071076mr1237499qvb.4.1681990307906;
        Thu, 20 Apr 2023 04:31:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.155.212])
        by smtp.gmail.com with ESMTPSA id s14-20020a0cdc0e000000b005e5b30eef24sm346817qvk.56.2023.04.20.04.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 04:31:47 -0700 (PDT)
Message-ID: <644122a3.0c0a0220.265b4.135d@mx.google.com>
Date:   Thu, 20 Apr 2023 04:31:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2960189106860034417=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v3] Bluetooth: btrtl: Add Realtek devcoredump support
In-Reply-To: <20230420105343.2014-1-hildawu@realtek.com>
References: <20230420105343.2014-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2960189106860034417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741684

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.91 seconds
CheckAllWarning               PASS      34.92 seconds
CheckSparse                   PASS      39.98 seconds
CheckSmatch                   PASS      109.99 seconds
BuildKernel32                 PASS      31.62 seconds
TestRunnerSetup               PASS      444.88 seconds
TestRunner_l2cap-tester       PASS      17.21 seconds
TestRunner_iso-tester         PASS      21.05 seconds
TestRunner_bnep-tester        PASS      5.58 seconds
TestRunner_mgmt-tester        PASS      114.73 seconds
TestRunner_rfcomm-tester      PASS      8.97 seconds
TestRunner_sco-tester         PASS      8.28 seconds
TestRunner_ioctl-tester       PASS      9.62 seconds
TestRunner_mesh-tester        PASS      7.01 seconds
TestRunner_smp-tester         PASS      8.20 seconds
TestRunner_userchan-tester    PASS      5.83 seconds
IncrementalBuild              PASS      29.36 seconds



---
Regards,
Linux Bluetooth


--===============2960189106860034417==--

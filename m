Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E64C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Oct 2022 08:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJSI34 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJSI3z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 04:29:55 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5173D1FFB8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 01:29:54 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id mx8so10903420qvb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iH+h4+YI77hEieflskDxSY00zYk6GnuAGbyaDORJHyo=;
        b=VMdgYm65ud/WWEccvsufyGkCKcxr0ZxzrparhviM4W6ejQ6llzATJIeKLf64z0bYFJ
         xFizAd+3JrNhi5nvmyPYjHdsxzix38fBXl1mox7GFYFUne+HAdMv3e7m7X5+9Ee7p90U
         0yQI5r8UBQdEiBtNUrEUyu1bdmfvXjLv6SreCen9rguIiLksoHnC1xbBvmHBfy4CSarQ
         p+wEHENs1XnV1rqaxUhHCHaqEBUwjbWCTxf94x1MzWCC8Zjete77UmQcYVGzNUMeWZI8
         k/Qqar4k/oH+DP6d/w+NxGQexJyAoXvbjxhoDG2sJz+mf5x3l/B1jXOp/YizCnYbJNi1
         0Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iH+h4+YI77hEieflskDxSY00zYk6GnuAGbyaDORJHyo=;
        b=TzqgIm7UXphTuD1T9V1nW45w4AOR3KZyd72KjPmzJX10zKXqybUvuYLrmmgyYK3HAi
         T8kniUXbDqFpquvUwj0vDSX1Panj1+xmwbotlzcTAPwBJNQAvdsVO8h/3qsQAK4Nk4Fi
         NR7ChBQBRCwZ16wfjNJ6eaNWVc4pJWBhgZW3iHhR6cPevfMOu+qb7xwLL6hXjYsDoz4b
         vCQnurvwG+NyTMT39L4WewnQ4NTFcTQb2ZVMFC6NII1Xm7u71plhnwYnwwczhNKtS/Su
         wCTYu+7SugjAyvHZqYlOB+3EjafJSkrFtrTlmOeX9/HsouDC1srykwIdtBudQCQ9Vnnq
         NU3g==
X-Gm-Message-State: ACrzQf0KFw3j7/6nD3LW9J8XIzzul5z4Yq1vLrdpbDSGbjgSUJWRcPRP
        wxig4mysZK7lxPDqAb8tLy5xZNLv0NmOxQ==
X-Google-Smtp-Source: AMsMyM5KOtS450xeiTLEyENxmgC3qmcvCT3BbxaomfeDMQI0hh9UlZJ0nsYzul+GUVVRYuBWfNAL9A==
X-Received: by 2002:a05:6214:5006:b0:4b4:9a51:f811 with SMTP id jo6-20020a056214500600b004b49a51f811mr5534292qvb.44.1666168193203;
        Wed, 19 Oct 2022 01:29:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.53.159])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006cec8001bf4sm4546881qko.26.2022.10.19.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 01:29:52 -0700 (PDT)
Message-ID: <634fb580.050a0220.ac374.e77c@mx.google.com>
Date:   Wed, 19 Oct 2022 01:29:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0858197988253671320=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
Subject: RE: Bluetooth: hci_core: fix error handling in hci_register_dev()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221019073008.3398136-1-yangyingliang@huawei.com>
References: <20221019073008.3398136-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0858197988253671320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686575

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      35.92 seconds
BuildKernel32                 PASS      33.00 seconds
Incremental Build with patchesPASS      45.42 seconds
TestRunner: Setup             PASS      527.64 seconds
TestRunner: l2cap-tester      PASS      18.04 seconds
TestRunner: iso-tester        PASS      17.23 seconds
TestRunner: bnep-tester       PASS      6.76 seconds
TestRunner: mgmt-tester       PASS      108.76 seconds
TestRunner: rfcomm-tester     PASS      10.64 seconds
TestRunner: sco-tester        PASS      9.98 seconds
TestRunner: ioctl-tester      PASS      11.25 seconds
TestRunner: mesh-tester       PASS      8.08 seconds
TestRunner: smp-tester        PASS      10.09 seconds
TestRunner: userchan-tester   PASS      7.08 seconds



---
Regards,
Linux Bluetooth


--===============0858197988253671320==--

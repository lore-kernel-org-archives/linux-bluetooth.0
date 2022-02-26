Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B67C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Feb 2022 07:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiBZIA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiBZIA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Feb 2022 03:00:26 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B582287CB
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 23:59:53 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s15so4600714qtk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Feb 2022 23:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X6yvikYmQOwR8kx0Iri9XK1gKgSsQjgC1jETdFEuMfI=;
        b=AsNyvG6lMZWOK8IrumUuouFsZxP4g5JW566+JTbVqd0y3HmfDUI6nuMXn1RlbiNFkO
         UOKSg2DaJwZSOiq1hCEMPOG9F8KARUfNjH2XUthIPGNU4T5etM1aEkF61kci+MoZbT8b
         p7COndIDOQJRr68//U0VOUUa6PfPVSoGrAhW7qex2Py9AeUM6bMSU4z6Kx95c7O0VHm/
         b+oKD2YOr1karNuwxnSkP10rqQWR7LUaT2DXr2e0dX7cI7fY35KjcM//2xvPcIHusod7
         R6iygTpox7xDP4n3aSmu0bslFcSCHswFHFW+AHubTVwtl2jlC1Smm9ljV5qQRLI2qZVR
         ypAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X6yvikYmQOwR8kx0Iri9XK1gKgSsQjgC1jETdFEuMfI=;
        b=0CqfYmVE2xZUzK4fvGLZSlA2VMux2Fvf0Kh9o09kI4O75DG+L5tkfRIFt25zcxjVlu
         PbCETnDDQe2TOViy5BV5xL2RBmLlxqRvjPcWAI4ZEF48trRqkR7zKa/hXgSX03pAZ1XC
         05BWFH6d2xN2cGoMs8KfqxmWiOcsXMTrEgI3z0iThjkPE77n96MH/3MJyZ4PAZUDRmAc
         YjHU11+G/Kp6xr5fRGG6rQqGiw7aVE1t/t/KfpxreTqiH92Yf8eB6Ydu5M0o9ikwouPU
         wuCiRYzaoblOU4YYQQLJassI6zL4g7NZPq1fQY9jhMRt07eYjedZsEKQ7x4aF5Ieq/Uv
         gdXA==
X-Gm-Message-State: AOAM531BP3Z5z+oCf0YEM1dypmBTi4O5ERF2cYTnjzPxM5dNzMIMzz9g
        Dd+KuQD0tTydRv1GxR2KS584tdCgXCk+mQ==
X-Google-Smtp-Source: ABdhPJyCegdBLLpJz8jy7bwWxLx6VrKb/qkJxACXIJjpCIt3dNtCFajfdZWrdmKIfEWO4PwcPrXMnw==
X-Received: by 2002:a05:622a:1007:b0:2d6:5ac4:6b78 with SMTP id d7-20020a05622a100700b002d65ac46b78mr9804528qte.668.1645862392357;
        Fri, 25 Feb 2022 23:59:52 -0800 (PST)
Received: from [172.17.0.2] ([40.121.180.25])
        by smtp.gmail.com with ESMTPSA id b127-20020a376785000000b00648ee0245dasm2294754qkc.69.2022.02.25.23.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 23:59:52 -0800 (PST)
Message-ID: <6219ddf8.1c69fb81.aa844.eda9@mx.google.com>
Date:   Fri, 25 Feb 2022 23:59:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1523046418842841602=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, cgel.zte@gmail.com
Subject: RE: net/bluetooth: use memset avoid memory leaks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220225074152.2039466-1-chi.minghao@zte.com.cn>
References: <20220225074152.2039466-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1523046418842841602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617890

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 FAIL      0.89 seconds
BuildKernel                   PASS      36.52 seconds
BuildKernel32                 PASS      32.61 seconds
Incremental Build with patchesPASS      43.92 seconds
TestRunner: Setup             PASS      563.41 seconds
TestRunner: l2cap-tester      PASS      15.69 seconds
TestRunner: bnep-tester       PASS      7.23 seconds
TestRunner: mgmt-tester       PASS      119.02 seconds
TestRunner: rfcomm-tester     PASS      9.41 seconds
TestRunner: sco-tester        PASS      9.19 seconds
TestRunner: smp-tester        PASS      9.00 seconds
TestRunner: userchan-tester   PASS      7.48 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.89 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============1523046418842841602==--

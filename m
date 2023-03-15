Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CEEC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 07:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjCOHgG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 03:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjCOHfr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 03:35:47 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA29F78CBB
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 00:32:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id be16so13586245oib.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678865553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z5O53QFRn9R4MM96/CqSjFFyIIirK9vjrTEujzuK2+M=;
        b=JHH0nnij4zEOQUHdTve2yZ0B17G8e4xn8eS6xDLFGnT2WHAaQw1hmoWQl/TyZXIVz2
         juwWu9EDCaBa3m2TkauDuPewd9Meh/l6I/drVq7RiNIH6arvjf+/ephbD3dcLgkX01vY
         iLqOtL9IDeffIvys2eilMl7E9X+hEa6xbOHE6PlE9Z4/qR3ee42iYGa9M2UuY5V6pknV
         rWNxP8A4Ilm7EOEHpJprWwMxxEHwFsnByga+98m7ScznovT28iPpLBs+mhXAPPl2FkA7
         xf8QIeFnMQU8imk0G6ZC4fowk0uAugXsMoy199hbJr004LA8/r4a79ehKbESZLF/A8UQ
         LZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5O53QFRn9R4MM96/CqSjFFyIIirK9vjrTEujzuK2+M=;
        b=HVwtv+vX6YLXn2F4+T7zcye8iJ2et+mLYR37lloMMZBltNJ83CeYP552zi9Adjqpxn
         /ymvBQhKumPMKzWDto4ReJsK5IoYBh1q4PbrML3h3fV3F3TeGhtphJ6rXlgztZ1fHHIk
         9nXp3izOSd9wsSjtw+kwe4yiXVdAg7zSpLwYtwaNfu3oZwrU2DNabnhsEyboUjVv4/zx
         SvJ68GfaL8CDWoSnhSwlVU9JoUxsodlcben8y9I6RjjEkJ5+KbzkB5cvW9QztBdDbCLF
         MZ1Px3v7HR8ODjSc20/d8vT9/VVWKLAq0dtJ/c2lwWGMRBHeeB2HipRiCNnFtb4yjAGl
         nrAQ==
X-Gm-Message-State: AO0yUKWfUz/jRls64i9CRqTzGvOJ6CY5Oi/sgO97waXGZaErKSKSlY8P
        CP10vVHLCg1Pepm9At0bFc02N8keEWI=
X-Google-Smtp-Source: AK7set83EOI25zHJmGFE7LozpxHtEN48xzoUUIr1nayqXEKXSkrH410NqLl2EdsBkCGbHRnq4vBurw==
X-Received: by 2002:a05:6808:1703:b0:37a:f0b5:d5cd with SMTP id bc3-20020a056808170300b0037af0b5d5cdmr711747oib.13.1678865553621;
        Wed, 15 Mar 2023 00:32:33 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.182.71])
        by smtp.gmail.com with ESMTPSA id v17-20020a056870955100b0016e9308e17bsm1962403oal.52.2023.03.15.00.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 00:32:33 -0700 (PDT)
Message-ID: <64117491.050a0220.36348.9dca@mx.google.com>
Date:   Wed, 15 Mar 2023 00:32:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8199117539654579160=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiasheng@iscas.ac.cn
Subject: RE: [v2] Bluetooth: 6LoWPAN: Add missing check for skb_clone
In-Reply-To: <20230315070621.447-1-jiasheng@iscas.ac.cn>
References: <20230315070621.447-1-jiasheng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8199117539654579160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730201

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.44 seconds
CheckAllWarning               PASS      34.16 seconds
CheckSparse                   PASS      38.67 seconds
CheckSmatch                   PASS      107.42 seconds
BuildKernel32                 PASS      30.11 seconds
TestRunnerSetup               PASS      434.79 seconds
TestRunner_l2cap-tester       PASS      16.46 seconds
TestRunner_iso-tester         PASS      16.46 seconds
TestRunner_bnep-tester        PASS      5.35 seconds
TestRunner_mgmt-tester        PASS      107.71 seconds
TestRunner_rfcomm-tester      PASS      8.61 seconds
TestRunner_sco-tester         PASS      7.87 seconds
TestRunner_ioctl-tester       PASS      9.34 seconds
TestRunner_mesh-tester        PASS      6.74 seconds
TestRunner_smp-tester         PASS      7.82 seconds
TestRunner_userchan-tester    PASS      5.62 seconds
IncrementalBuild              PASS      28.71 seconds



---
Regards,
Linux Bluetooth


--===============8199117539654579160==--

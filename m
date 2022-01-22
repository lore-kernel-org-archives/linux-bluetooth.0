Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6F0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jan 2022 09:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiAVJEj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jan 2022 04:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiAVJEi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jan 2022 04:04:38 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A769C06173B
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jan 2022 01:04:37 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 190so1259643qki.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jan 2022 01:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MzUdG37PcNtMrfGojqSxPnjJGbHg3T/ZsshGexmbY+A=;
        b=gBMPE/Q+Tg9dRh2bPi+50RQR6rsl6eYDYBzB6dx4DJkXcFlmZz+XypxoPlFQrsREgH
         VZxa3bhfDIC3ucY4aWXGFeGzhY1U8mKZ3OLBj9aVNUBiTO33ydxD9pnhqRPmmLPWV9E4
         8fAO/UCjBvC91bGaX2+tvhfesiqZ1Ja5vfNZHjWFhs4DDIvnBZNOa58r40HH57gyqWSN
         U+a1zBHPymmqGZ2kzWmpXoXKaRJE08pAozfdW/C3axGR0nu7Wv9oSFDEyFwjocBCI3Nh
         VzCtTZ0yAu6Aim6Wt7ex8FyTIcXZQ23On3arepW/VZu0KmW8L38LJLWQSMQV3g4lMoMc
         FQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MzUdG37PcNtMrfGojqSxPnjJGbHg3T/ZsshGexmbY+A=;
        b=1lgfOfaLgBYEbW+9vJvDRCqv8QQc4jEwu6MYdN6rv95C17Dp1A9y/EF5nKUcVcPfWr
         R2zt8/DyeifO1KHZ4fzWrhmf5XzHgzhDIGTCiPa3KzdYqAAAAltMniM/fQqAGXfmhZrL
         0ADsL3bEUO2Fhlqjp05Mc2bI3lehtLkHJkLWWAomQTV/yN2WSCyFclyYjbO4vyI4W2hV
         asC+V2elGkAZl2eyPI32ziQhYNtjjxCczU9wzzJw78xagy8XitTaerd+4Kj6AD8tErF2
         Lqw02Rt02g1UhSEpfn4z3Fs35Gcyk/Y0izi2lzm+hLgepaVtQeQH4cmy7CrdzckRqMdY
         akJw==
X-Gm-Message-State: AOAM533bqCvbftyEEh7vdNyr/e5JaFW78+QtsqzAjhrlIfv0+aTeFGqp
        6WDshyADTzXksYBiCUVeqnT/1uMXo60=
X-Google-Smtp-Source: ABdhPJzoR594Vk0cRCuUcphOJfa3SThBM7lbJa933G8UFdVA7oWl7fpJUgqHhRDe3BgKND0ayTLU/Q==
X-Received: by 2002:a37:8686:: with SMTP id i128mr5249899qkd.161.1642842275682;
        Sat, 22 Jan 2022 01:04:35 -0800 (PST)
Received: from [172.17.0.2] ([40.84.35.8])
        by smtp.gmail.com with ESMTPSA id o20sm4298351qtv.69.2022.01.22.01.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:04:35 -0800 (PST)
Message-ID: <61ebc8a3.1c69fb81.352a4.af89@mx.google.com>
Date:   Sat, 22 Jan 2022 01:04:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7577432507339148724=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: Bluetooth: msft: fix null pointer deref on msft_monitor_device_evt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220122082751.285478-1-soenke.huster@eknoes.de>
References: <20220122082751.285478-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7577432507339148724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607456

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      35.09 seconds
BuildKernel32                 PASS      30.74 seconds
Incremental Build with patchesPASS      41.41 seconds
TestRunner: Setup             PASS      540.82 seconds
TestRunner: l2cap-tester      PASS      15.14 seconds
TestRunner: bnep-tester       PASS      6.82 seconds
TestRunner: mgmt-tester       PASS      115.33 seconds
TestRunner: rfcomm-tester     PASS      8.59 seconds
TestRunner: sco-tester        PASS      8.86 seconds
TestRunner: smp-tester        PASS      8.68 seconds
TestRunner: userchan-tester   PASS      7.10 seconds



---
Regards,
Linux Bluetooth


--===============7577432507339148724==--

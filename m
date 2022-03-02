Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7F3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 00:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbiCBAkc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCBAkb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 19:40:31 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536945AEE4
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 16:39:49 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id gm1so329065qvb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 16:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HZpeMrEOnP1wdaN9Jm4iBV2DOrWyefbHKWFkNeNdZSA=;
        b=GtfZo3p2T592KQxlJ2yKC6XotryVi7nu9JWHG6eoTTuHTn1ADqhlTcEGSI++44J/Ok
         tkfdxbBex6ty6mvGJSCcKC0q2lY66TqRVoRx7gLMGjyPwShdlzpqEw0rJRDnaerFJlED
         x+ln3dv6FbohFeRA1yVZEwfCnJ9Gae+f9Eq5vQK66JXchFBn95buKcbP7JeFfNrEwoRp
         wFKFo9ybq6f6adc09XtJ1kolXRF+smleQDJ6VjrCWkSwKKcQwFBf1BobB6Y1frNFNnRk
         XRUzeomALpJnO5QBF6CpKB38BCdV7fklfsq9zKRWCXuTqveUiSXsCMM/IFluMxim4ZX/
         ENgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HZpeMrEOnP1wdaN9Jm4iBV2DOrWyefbHKWFkNeNdZSA=;
        b=1wYoND1Y381LJ7WPf6YmVQgtyd/698aXQu8UZAIHEy+wn6/DPRUwC6n1WCPtRaApDN
         Z2tjfl6aTdEnYb0rN4t0WXmCDfLPGlt8+owj+i7cXxOdTq7uQTkcODdFcYIALAS+c10M
         YXjudz5AXAsxznwVIDXPriwNTLz20H0ARkkiJz3aS+U/XDWi1jqFXNMYx3hZWb8wT/c0
         j2HbvKBlL8r3trZx9YQ9NlGqOE3keYv3wzbSTZJz5vp+mlmBno8U71Geuuz5giZYvY/F
         20Ap9IVFRjcuIYqaf/P9a7QtkhkkwuYNE8bOxGARkBsALGsnS1DPmJYTqxjVoz55FaKX
         /X4w==
X-Gm-Message-State: AOAM531riHAhSg/izsG5R+kMc7YOfbVSUJsy1m2pMKuC80pKgsG+oJIV
        xH53HT7i0guvtpLUsCl9oNHkzuEmFeFuww==
X-Google-Smtp-Source: ABdhPJyueR5b7WgfpIVE+dV6yW5TCl5udjB7wS4Lit1Fi5pHXyGTIcGer7QBTHBV7Sazb0lI/MZDcQ==
X-Received: by 2002:a05:6214:5293:b0:432:3071:e947 with SMTP id kj19-20020a056214529300b004323071e947mr19283869qvb.62.1646181588334;
        Tue, 01 Mar 2022 16:39:48 -0800 (PST)
Received: from [172.17.0.2] ([20.49.43.100])
        by smtp.gmail.com with ESMTPSA id l6-20020ac87246000000b002dcec453e42sm9146865qtp.32.2022.03.01.16.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:39:48 -0800 (PST)
Message-ID: <621ebcd4.1c69fb81.e52ea.fd21@mx.google.com>
Date:   Tue, 01 Mar 2022 16:39:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6003740047428986531=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] test-runner: Fix parsing of command line
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301233053.109920-1-luiz.dentz@gmail.com>
References: <20220301233053.109920-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6003740047428986531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619350

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      48.50 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      9.42 seconds
Build - Make                  PASS      1383.88 seconds
Make Check                    PASS      12.20 seconds
Make Check w/Valgrind         PASS      499.39 seconds
Make Distcheck                PASS      262.03 seconds
Build w/ext ELL - Configure   PASS      10.36 seconds
Build w/ext ELL - Make        PASS      1368.58 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============6003740047428986531==--

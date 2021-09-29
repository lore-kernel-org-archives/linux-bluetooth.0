Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ADBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 21:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23976058D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 21:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbhI2VeM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbhI2VeL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 17:34:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF17C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 14:32:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d8so3740583qtd.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pDg5gZBgI4mnFYQveZVCS5gt8IwZot4iKYWt5/J+jig=;
        b=kfoiCvvRrA5b1iwulXeOJY6WpnGV+5ws+kJ4qgVeSJI5/YoFLXb9EZnRNCInwPh5vI
         18uKuEyyMoeMWvDnWyfkqzlavfsh1aLjnrMI0WtdD81VhV+HuT1CjpGjF+qunFxoqJ+X
         ZRBwdZ52emPXbhNnFOiceYL9WaIJ9ZnttEiTQRGaJbUCE21Fsu92j4Tg0wa0L4ULAa5K
         lakxluzUntq9y1ENvCxHv6atgwv3ESPszOBacUw6/f9h8WRrFRBLgxAJTC/JVZJLi+RB
         HFbUZMO4fNarZFJ/B13RUQEw9ECO0ejXGs2Uo1++2TQk9HMdvmCS1CsaNOIBd7FR7Qs7
         7Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pDg5gZBgI4mnFYQveZVCS5gt8IwZot4iKYWt5/J+jig=;
        b=ECaDj8BiIW6PoUUkVnbi9E23nKKn59iKtGjpy9+inm7CkTeKFiq7Qk5nrgaSAeBfyA
         vxQCABzDRUOLvIxdjbAkwInYllgkx4fvVgTQI/JuTRpoQge29p5fK46qdTvCZdMJSk6G
         ZA8CH1kaQ+yGHGIZPnCojoy/0g66JyFiSjN8HayuHNEUZOdC8mMEtf95seszgkRLyZ9k
         HlFmmkvS22v+NirEic82iYoSYXSPAjmRKA0sTpETKlkbsjEWQYUa3lTtDkglKYLn31g7
         dKXOwModgnBTYgT3fsa1VFYZGHNm9qPJ1+VisXT9ObAkj28A0XMbXoxBkxoPGZRKW7bl
         Rfgw==
X-Gm-Message-State: AOAM531ol+anNMy4qGikhzCU8bI2AgAZcRd4V5zt7e2p8DfackleMXpo
        d6yO9PCHpljQdKkCKv49DJ8f/B8OPV8MfFvs
X-Google-Smtp-Source: ABdhPJz0Tc3C8ZSRToOa0UHfWBwq4s8q/SGyQ1LRK6/WKgVmr3NE8xcSI7KR4MRvMyPqwNhSSgcqnw==
X-Received: by 2002:ac8:6147:: with SMTP id d7mr2489180qtm.38.1632951148548;
        Wed, 29 Sep 2021 14:32:28 -0700 (PDT)
Received: from [172.17.0.2] ([52.186.73.78])
        by smtp.gmail.com with ESMTPSA id v8sm735937qta.21.2021.09.29.14.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:32:28 -0700 (PDT)
Message-ID: <6154db6c.1c69fb81.e261b.602f@mx.google.com>
Date:   Wed, 29 Sep 2021 14:32:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8352019439287633911=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools/mgmt-tester: Fix Read Experiemental Feature test case
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210929210049.35597-1-hj.tedd.an@gmail.com>
References: <20210929210049.35597-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8352019439287633911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=555241

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
GitLint                       PASS      0.92 seconds
Prep - Setup ELL              PASS      41.56 seconds
Build - Prep                  PASS      0.48 seconds
Build - Configure             PASS      7.62 seconds
Build - Make                  PASS      177.64 seconds
Make Check                    PASS      9.26 seconds
Make Distcheck                PASS      212.31 seconds
Build w/ext ELL - Configure   PASS      7.82 seconds
Build w/ext ELL - Make        PASS      168.61 seconds



---
Regards,
Linux Bluetooth


--===============8352019439287633911==--

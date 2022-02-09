Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC70C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Feb 2022 14:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiBIO2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiBIO2W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 09:28:22 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3097C06157B
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 06:28:25 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id y8so1868692qtn.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jeIM4P70FIfp4U/2ZQD7eGU14XJtqcn6wNK4Pp2lPtw=;
        b=pWBiMlvQdaNHqEZv5MEaJVlC9xU/eDEGbIS/yT5jEQBQCiJhxjASnWMB0ihJ4KiT/q
         CpIuPw2iz6jZFkvj75z8Il+4dQbyv73nRZexerVONSHoYY4J9wJlu8m0m89negeZhCCg
         sC51qmYqfjc6CNCe4osOByzTwfFT0h9OBXDAFiTpXCtiMheSQOPmh/PyDUsY0JBQUUZe
         oG343UZmWJ4S/txaplbKM5s/X7HPsEXHn99z9rvKFxUCNIux2f+4knWkqGvmhnrWdJMb
         FnVXHglJrSyQ/Xyz4xarPq0nFq5UJtE8aAVmTC6nGxTlG63iadUosXEC4RerQFtu8YJx
         1BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jeIM4P70FIfp4U/2ZQD7eGU14XJtqcn6wNK4Pp2lPtw=;
        b=dkvXLWMjzTfxQ1X6bmn12Xr/B4gyQlIC1F6R4dk8nUJin82w5wmJJRc4ejl6NPfnjY
         qTZ/fPmbY43GBHrcbP+IWIN5tjgQVw7A+dAP7b82hJxM9GDvKueCVhbt+t6WLBagb889
         AD05QthDZWBnijSWbJkySw4RWvTgyw4ZfR02TyrnzWBEe2o6oNkREDR2ZrKb+H21mGcD
         +vmOe6xB/Ko8EQ3B57e6PO2rhMGwiimNY/ZqxiRyNMuEw1GM1Kc2TLgGyvAQSbnvEelp
         cLSFxVB1ltb3dzu5t5R7PKihnZOiNtI8bWMJi905UpOXQnFEk2vZ78NAlGD9zshaM8By
         jSAQ==
X-Gm-Message-State: AOAM530OQ64ddy+0hS/g+BunknOUtYdDSk0nEkLIhlQFsZhtmA5qxGzQ
        Npzco+SPX2Qh7pq5Sw93nLvaq2lQOuubsQ==
X-Google-Smtp-Source: ABdhPJyP93QpUvsORLBEDZn+YaPYP4HI82iPfdmyGgELwIrOTZgtbgExEhpZgBFIbNLznWyGxmlICA==
X-Received: by 2002:a05:622a:303:: with SMTP id q3mr1479235qtw.31.1644416904823;
        Wed, 09 Feb 2022 06:28:24 -0800 (PST)
Received: from [172.17.0.2] ([52.177.182.173])
        by smtp.gmail.com with ESMTPSA id t1sm9604952qtc.48.2022.02.09.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 06:28:24 -0800 (PST)
Message-ID: <6203cf88.1c69fb81.450b3.2581@mx.google.com>
Date:   Wed, 09 Feb 2022 06:28:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5132714681145326095=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v3,1/9] doc: Add Bluetooth quality report event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220209092414.751642-1-josephsih@chromium.org>
References: <20220209092414.751642-1-josephsih@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5132714681145326095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612544

---Test result---

Test Summary:
CheckPatch                    PASS      13.81 seconds
GitLint                       PASS      9.23 seconds
Prep - Setup ELL              PASS      48.47 seconds
Build - Prep                  PASS      0.90 seconds
Build - Configure             PASS      9.31 seconds
Build - Make                  PASS      1511.45 seconds
Make Check                    PASS      11.25 seconds
Make Check w/Valgrind         PASS      447.60 seconds
Make Distcheck                PASS      231.77 seconds
Build w/ext ELL - Configure   PASS      8.17 seconds
Build w/ext ELL - Make        PASS      1430.29 seconds
Incremental Build with patchesPASS      13382.32 seconds



---
Regards,
Linux Bluetooth


--===============5132714681145326095==--

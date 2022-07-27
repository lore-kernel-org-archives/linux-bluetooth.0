Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4356C04A68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 08:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiG0IF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiG0IFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 04:05:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365DBE26
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 01:05:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y15so15486545plp.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=w0+MhajKETw/8IGF2KpFs/2SoVoTHXa//3jlac4yXxo=;
        b=Lil4mCsQMgDDQde3rAfN6pF4XD1sC/Pf+4lUAazTcWM3kzPtJg+SbAV1dKViLKXXCz
         wiBQciyO6HMpgMPHfnKfnO3CpX7tbiQBDhhrxq6ZLSQLdmg45vM8zhDcx6ied07D47Uj
         IBhDUN+SsgcRZy9j55RNjYbisxcviyAM/Q6BMmz7sLGfI38lMAOJOxz2VjP76Q/yMG0e
         mMq0fWQe7S4rmkLZqzCL/EVC20BJenc33ikUkIGHh2zjdNghnK3iGG2ZatxeKPp9vzeG
         cbo28aMhZJx3B7LTF2Yp8K/sqWjve7RbEkKvvUCO7YrWKXykTG5nzBiYXO96U+XKtuLl
         8eAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=w0+MhajKETw/8IGF2KpFs/2SoVoTHXa//3jlac4yXxo=;
        b=uW9dl9kdcPjAm/Vq9Hgr1CMervl3+cORtiM2+AoIABa70jtGe0S1QqKXIZbMqd03i2
         7Ja6k3IeHYH+p+ZzzFWFQBZB3dOJ6VPFPEKuPNlq6+lfdFEVQ7XXL151fN4lULToIztu
         dYFys1PJzSdy791g+WY46b6r34gMK/WyKIf2I1fYDAhCHC5rXGrKnacffz9l8Petk+ez
         0FxgE2RMBaGCKY7WsaW0FSKn4JlITTZ7zu4lYPgc6/jQ6aCpVSaHtpzLjeEpN8CCmKKF
         STtWrGUOyCB8ATzspgC53UXK+0/fxrgxt29nEb/+DnYbzOjb+pzA2LyaLm0FPRKvu2r/
         jl/Q==
X-Gm-Message-State: AJIora9DbrFLAH7apmoPLXKcnGBWBu8AXUSHx5B1zLI0Gnf9RIsu0eI5
        arih+PMuMDi3qjXnmW7CnmL0XzVw5FY=
X-Google-Smtp-Source: AGRyM1vR+cZv3dnsVbcy52jmAjoZxLjm8TsDKetfDAxCnQX5o5l/Up8KazjtzJkTxJaBVIY0J2IcdA==
X-Received: by 2002:a17:90a:d155:b0:1f2:4741:3b74 with SMTP id t21-20020a17090ad15500b001f247413b74mr3112995pjw.201.1658909153089;
        Wed, 27 Jul 2022 01:05:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.50.197])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a674100b001f262f6f717sm1009862pjm.3.2022.07.27.01.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 01:05:52 -0700 (PDT)
Message-ID: <62e0f1e0.170a0220.bf72.19f6@mx.google.com>
Date:   Wed, 27 Jul 2022 01:05:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4977310238609724618=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: [v2] Bluetooth: virtio_bt: Use skb_put to set length
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220727070541.6450-1-soenke.huster@eknoes.de>
References: <20220727070541.6450-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4977310238609724618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663357

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      0.69 seconds
SubjectPrefix                 PASS      0.52 seconds
BuildKernel                   PASS      33.52 seconds
BuildKernel32                 PASS      28.96 seconds
Incremental Build with patchesPASS      41.43 seconds
TestRunner: Setup             PASS      487.36 seconds
TestRunner: l2cap-tester      PASS      17.07 seconds
TestRunner: bnep-tester       PASS      6.20 seconds
TestRunner: mgmt-tester       PASS      99.23 seconds
TestRunner: rfcomm-tester     PASS      9.42 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.29 seconds
TestRunner: userchan-tester   PASS      6.31 seconds



---
Regards,
Linux Bluetooth


--===============4977310238609724618==--

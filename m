Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jan 2022 16:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiALQ6d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jan 2022 11:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiALQ6c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jan 2022 11:58:32 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5089DC06173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 08:58:32 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p12so3565197qvj.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jan 2022 08:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=r2kfsHAT0vQiexa9K0FKbKAvusuBXxvQbztUy9jltRs=;
        b=CRW0ZpwmcmUqnX8x6xR467qDqLF2Mx+DdXGbZqJg6YS1kufs9x6VsTQ+J3aZpypXnb
         s+WL3SpAC23VLzNuGc8aB+XqSo9V5QJcAR1BN8EsxOakQ41/yc1sUxN9Dh3O4DCzh7eM
         X7t/qEKutZDn3I7aMPhX2w5kZe/8FjW6xfIpCIVl61hVqsHxvyoBrVMbdMqz17xl+n4T
         wtXZB2OhMveeTFbPJt+Yh8dkldsyZ8nRmSS3CwH4vXx4n453BGob5QOd/8JcCyRsLLYe
         x9ylA2tgaXFDzoJWGzntgAa1IdlB5LQxOD9DKj1IDQwm+bTPw0XbGCpJ2WJDhniCsXxE
         Mcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=r2kfsHAT0vQiexa9K0FKbKAvusuBXxvQbztUy9jltRs=;
        b=RGYhd8JjijOWDIafH9jHSdKkydE4CFplG5LW21sGy95iERO5uqBoRCY0lsaT79sJEn
         BXIXdmE+jZ7mEWjRMQDYCq7YRtGtzmCTzIMzL5fLI9MhneB4HuzNKpm473vy2whIR6Gj
         58MubmxtjekPBAV7ZYyULWdn9KkBwAr5rZp+7xaTA/opyR9TKpEuVs3/ELxLF6NeiSL7
         eyTvF4jrPcABGIUThsHA/Jxa5PFjkhB/NdgX4kid0cShAhGaNoqa0AdMm/EoyPbPhjTt
         5qdoY+bbAc9iCmK9CgInpu/i0OeWMm9H13Lf8HcAjXp/8SGD7D1Rbur5MucJrRVadWDH
         p2Ag==
X-Gm-Message-State: AOAM5308H4o74tRrO2cOiHkljL2e+QSL10JN+kuR2E8wvLeu4rLnLtN8
        rkOv87J2enDJxggjqIdpG7CbmO1RHe7Q6g==
X-Google-Smtp-Source: ABdhPJwr9chijVmXm2Ez2C/ypqQgo5gz/NBePjKLi39LiSSofnkDd2/70U1QpFRYxsp/fGFcLY3slg==
X-Received: by 2002:a05:6214:da1:: with SMTP id h1mr505384qvh.23.1642006711357;
        Wed, 12 Jan 2022 08:58:31 -0800 (PST)
Received: from [172.17.0.2] ([40.84.46.149])
        by smtp.gmail.com with ESMTPSA id h17sm233225qtx.12.2022.01.12.08.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 08:58:31 -0800 (PST)
Message-ID: <61df08b7.1c69fb81.22f6c.1c7f@mx.google.com>
Date:   Wed, 12 Jan 2022 08:58:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1611408720220042103=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] media: Fix crash when endpoint replies with an error to SetConfiguration
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220112153529.338208-1-luiz.dentz@gmail.com>
References: <20220112153529.338208-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1611408720220042103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=604907

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      40.83 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.44 seconds
Build - Make                  PASS      1376.47 seconds
Make Check                    PASS      11.17 seconds
Make Check w/Valgrind         PASS      431.65 seconds
Make Distcheck                PASS      225.72 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      1364.92 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1611408720220042103==--

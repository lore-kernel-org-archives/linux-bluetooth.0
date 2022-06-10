Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9501C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 09:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbiFJJvy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347667AbiFJJvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 05:51:52 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72003AEE19
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 02:51:50 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c83so7073429qke.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7SQXnbQDHxJOjL6MKpG42Fd1QEdKWPk4PJ61VQumuzc=;
        b=AI9Wj28R61Ea2klANXjYN3GxCiMI/RXDNfQYiYkXyDrkZbF86ahWTZ5B+tZvDiL0Cv
         aMb/ZHMaF0GiLfnFMP18/pGX82IkgZjVa9VedLVc9670b3W3Pmq9vS+6YkQjiBy6CSqa
         HNLFnSyAwEmS76l18VTwxLVHBSbGuoL6HBwPSDou3nr9S/IDMJRyeznpPEt8V9KBGNL5
         mMdbGMC6qG6o4ACqSGOSdlNd0C6ukNYHDYd2h6O9Z393QornAp9+3yDfPbsooYpOSzAk
         z95okC1P9GB9r5t/EO4zJp6KbHUzrROWuyfwx22QXdijCbYZSQq8Vq9I5Ss+yH5WVwbc
         YO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7SQXnbQDHxJOjL6MKpG42Fd1QEdKWPk4PJ61VQumuzc=;
        b=X9oNKCw5X58aE9Ig1ynJY5x9TIFFkPe4e+qZRM6e9hY1cCxAVqRuYp1p2cbHnbTgcP
         vj1kWbBsydXY5noOYDXB/pFseHVppDggrocXtM7HKjR4MYj3IefgaTndrSxUhTyDYxyR
         byYQ/1eAHi+GAxGTkzyzsCXqEqRrxN8Wj9NbHHk9aT0/RKHRQJBjOViTTci7tIbepBzS
         KRvfejj+51GwQDwnmSyfl6zXoQyOXeuFcPZrD945vd0hMTVu5iRlYvVCvTks/E6cMI1j
         bVqjZerNvuVoYxsB3gDaGL7fFFBMRDO70NjZEAR0JnEKNnpyk3A0XN02CUYNCkk6Zh+4
         rUyQ==
X-Gm-Message-State: AOAM531i/8qXBxaKvdqI9rwFmER6LNqja6CpR6JHGDF/SCaHLcRkoJCQ
        qym+mQOqv9f5HuV8mbaRn5pEx5z3kTg/Lw==
X-Google-Smtp-Source: ABdhPJziKrNLGRXQxBvIZ3wvNOb2zCkQF1zCWaIx5HoVORDsvZWG65cqoolNQHz9lkV19mnsLoaqQA==
X-Received: by 2002:a05:620a:4096:b0:6a5:cdb:f6df with SMTP id f22-20020a05620a409600b006a50cdbf6dfmr30926885qko.698.1654854709422;
        Fri, 10 Jun 2022 02:51:49 -0700 (PDT)
Received: from [172.17.0.2] ([104.211.24.82])
        by smtp.gmail.com with ESMTPSA id br40-20020a05620a462800b006a6539862f8sm7170714qkb.40.2022.06.10.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:51:49 -0700 (PDT)
Message-ID: <62a31435.1c69fb81.9bc58.e16d@mx.google.com>
Date:   Fri, 10 Jun 2022 02:51:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6683452698044927298=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: test-runner: Add support for audio daemons
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220610072850.16593-2-frederic.danis@collabora.com>
References: <20220610072850.16593-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6683452698044927298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649137

---Test result---

Test Summary:
CheckPatch                    PASS      4.38 seconds
GitLint                       PASS      2.91 seconds
Prep - Setup ELL              PASS      41.65 seconds
Build - Prep                  PASS      0.64 seconds
Build - Configure             PASS      8.71 seconds
Build - Make                  PASS      1343.82 seconds
Make Check                    PASS      11.11 seconds
Make Check w/Valgrind         PASS      414.74 seconds
Make Distcheck                PASS      226.88 seconds
Build w/ext ELL - Configure   PASS      8.37 seconds
Build w/ext ELL - Make        PASS      1356.48 seconds
Incremental Build with patchesPASS      4265.16 seconds



---
Regards,
Linux Bluetooth


--===============6683452698044927298==--

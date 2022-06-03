Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52B9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 02:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiFCCon (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 22:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiFCCom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 22:44:42 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5F33360
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 19:44:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v7so4659340ilo.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2cNX7Xz45dnGbXPNyDWO02vOyqkZl5UKtTQqPFHjjTs=;
        b=F91rYZtAmUP0Zz1mBcu97yXIZA7OVaK6qEFuRQTjdLzq5dgDyX2SYTiSYhHYf86n3f
         POfF6zWBZHB0rll7YR1O0g8VoZ7zMXSQohmVZGawQ+h9VhJXdKoNMHDHQ8WQf44QLdUu
         QzBZ2ur0DeO8ha3yPszx28IIFWMGoCBAzQH90lGjEu/+eC7BP9ldRkfJqMs0WciLlnuG
         saDd8nLH2qzHaDdDDewFaXlYbBEPEtATv/S1JME0yTIM3TCMRHccJ9p120YXyjd67Kpq
         KLb5u/pGwF1bPsgCtXHqme5hWIXas43JiFVf4MJW8Kvf63usyjlH8MGYaayD8iPVYSgO
         HF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2cNX7Xz45dnGbXPNyDWO02vOyqkZl5UKtTQqPFHjjTs=;
        b=Md0dyXVtCRn/x4sn/Py7YllpYIySAP8RUvVvCX+Q3KUmdkLEZ3O/352YSfqveC8dHB
         5up0Y8WGqPJQDWtLWmXDmhVfJLCGQEKMRGSAasVCnn4k8xAAR6t5x9NEk7wp2P9JzQdx
         TDWRPT38wMoK1MFbNVe9yc8uyIFEdV4bxjtqiGf8bH/zJLW4MCmJP8cWsgKqJ+hXzCPl
         GRJdqFGXfq83I1g0pTe6J1lMt0qAAZDQ4yk0S9ZQO+Lfjom7RwO83/ExFaCqxR9lQkdD
         QZTmFtgmmGRfrjqX+NM3wTYoFncIu1NNuolOYXJqsShjWuAi8HKF4lrZFvzcW6h2jaBL
         nfFA==
X-Gm-Message-State: AOAM530D0hTuiiQCU2g3GErNtnnRUwvsReb4gHOUcyWUslwhrg0f773D
        DxXQ8TDlSD+kYtkejCIto9gYQPvEV3A=
X-Google-Smtp-Source: ABdhPJxDgwiF7YeB2hBcnr1dbTbF5ARG3Hs/L/ugcpfnR7VLJ1xCQZOK7X81Nd8gCPkJS1rjVF8/VQ==
X-Received: by 2002:a92:d743:0:b0:2b8:4642:8e3c with SMTP id e3-20020a92d743000000b002b846428e3cmr4574897ilq.244.1654224280473;
        Thu, 02 Jun 2022 19:44:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.167.238])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b0032e1e0ac289sm2028395jan.8.2022.06.02.19.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 19:44:40 -0700 (PDT)
Message-ID: <62997598.1c69fb81.6f0e.5d9d@mx.google.com>
Date:   Thu, 02 Jun 2022 19:44:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3102007990657842610=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiasheng@iscas.ac.cn
Subject: RE: [v2] Bluetooth: hci_intel: Add check for platform_driver_register
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220603012436.3332620-1-jiasheng@iscas.ac.cn>
References: <20220603012436.3332620-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3102007990657842610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647016

---Test result---

Test Summary:
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.81 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      31.91 seconds
BuildKernel32                 PASS      28.40 seconds
Incremental Build with patchesPASS      38.03 seconds
TestRunner: Setup             PASS      470.96 seconds
TestRunner: l2cap-tester      PASS      17.18 seconds
TestRunner: bnep-tester       PASS      6.01 seconds
TestRunner: mgmt-tester       PASS      101.15 seconds
TestRunner: rfcomm-tester     PASS      9.53 seconds
TestRunner: sco-tester        PASS      9.37 seconds
TestRunner: smp-tester        PASS      9.34 seconds
TestRunner: userchan-tester   PASS      6.27 seconds



---
Regards,
Linux Bluetooth


--===============3102007990657842610==--

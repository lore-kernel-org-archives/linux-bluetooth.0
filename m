Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2361AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 02:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiCKCSB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbiCKCR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 21:17:59 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418CD1617FA
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 18:16:56 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id kj21so3141777qvb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 18:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=I2qOB2lOV2zkxJgLhdBjB/h70wFgaMgekDbgzUvzQlc=;
        b=gxVm2BvnRLdhHTODRduS1h4CF4WFt3qKB4h5fFXQiF+bN5TjxRSGDaG7YROB8BYlu/
         4Qc4F5UJ+V3Gfu4MgyC6BEI3NjwEvbkkx8gvSmmsa0VhTxKWVeN7UHlQwW9sfVIUhQ5N
         1ocB5nTlL/Dez6JWKCNONQm+KBJP2btQRbfNO19JM0/I6rnlvamUnwu8in0XjTxKQ5y4
         AebQbG9O7W5PIwYCOLiaBX4iy6vgbFji0EZRaKN52EVHNQbj9KUhcj45noMYGXlMLBfV
         ap20YZ5GHD9q9ld2VSNh7jFnfDNk/bP0G+M6VTC1kQVB9XUmD9baEKkuv7QLIKPrYKrt
         ULOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=I2qOB2lOV2zkxJgLhdBjB/h70wFgaMgekDbgzUvzQlc=;
        b=A360TG/Xcm31P+GHX4jcUlJengiYzoASV0wu4jKgMGsqH0rdPXO8SdsWZObxYPHMv3
         A2V0uHc79Gr8fZyWaBaWoXBVeSwwQCE2g7ysjaYY6S2kuGlUivuq/uaiaIWFmUtyajvB
         tN+vniNSah/Hi7VrHK7XmYnKG+8dcw2KJvRGgTnbUubvGhg2TwIJ0w7CTCCIKJt4Q+j2
         kdlMuH1B4S/7ZM3Nn1OFmb2gDCUeiBKrAoUfvlgAUz4+yDRPs1jl6QdFaapf1EeyCRKz
         R7H6ZpA+bHD/Pwppy96y3izZ19AjWoL2cydyZsHSULjM7Tu6JOlIw+0XTprBolKCbGMl
         Yb9A==
X-Gm-Message-State: AOAM5315/kCxAI/E0xKqH7VyiMOmlz8cQ0cpAy9OJ3F9RbHwSufhkPa6
        a+IdbjGOcZn71EZcMhrnLDTvWrWIp0hGXQ==
X-Google-Smtp-Source: ABdhPJw627xYts2pQKggD+vuCE4a2gQxH3e07NxMKYQJ5FsyeWCJVLCZP4zN+aOthUDH/ARVvZ2cYw==
X-Received: by 2002:a05:6214:1949:b0:435:a3ec:a8d8 with SMTP id q9-20020a056214194900b00435a3eca8d8mr6257611qvk.82.1646965015242;
        Thu, 10 Mar 2022 18:16:55 -0800 (PST)
Received: from [172.17.0.2] ([20.110.115.186])
        by smtp.gmail.com with ESMTPSA id bl3-20020a05620a1a8300b0067d4cd00231sm2095164qkb.135.2022.03.10.18.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 18:16:55 -0800 (PST)
Message-ID: <622ab117.1c69fb81.e8741.d07c@mx.google.com>
Date:   Thu, 10 Mar 2022 18:16:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4777153757768170613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, linus.walleij@linaro.org
Subject: RE: Bluetooth: btbcm: Support per-board firmware variants
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220311001746.480163-1-linus.walleij@linaro.org>
References: <20220311001746.480163-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4777153757768170613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622435

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      32.01 seconds
BuildKernel32                 PASS      27.92 seconds
Incremental Build with patchesPASS      37.70 seconds
TestRunner: Setup             PASS      469.59 seconds
TestRunner: l2cap-tester      PASS      15.30 seconds
TestRunner: bnep-tester       PASS      6.07 seconds
TestRunner: mgmt-tester       PASS      99.47 seconds
TestRunner: rfcomm-tester     PASS      7.85 seconds
TestRunner: sco-tester        PASS      7.51 seconds
TestRunner: smp-tester        PASS      7.56 seconds
TestRunner: userchan-tester   PASS      6.29 seconds



---
Regards,
Linux Bluetooth


--===============4777153757768170613==--

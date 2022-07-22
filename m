Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC97BC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 23:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiGVXI3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 19:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVXI2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 19:08:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A212748
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 16:08:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so5410685pjl.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gWZqDUp12Dv/ikWDlhckPF5+nANQxjQ6++fkVLPIeOg=;
        b=dWppqVeOemzJsPCrfD02BYZoLnFXqAbwcTWxRFqsdfGG6hx76ZRR5t6FRYQBGQYRhY
         SwZSGCLVUPY2sMPFp4pc69bsl3GagIkmA03aQQux4kFbqglIstBBEK5sZ0Fu3MbXD1JJ
         qaKHkoSQE7zYukn6r0Im/F9Z8WGAOAP/Ibe7tovMq/AomMjtU4eNgW25+TrNcQFQbo7q
         +FPAsU7qwXGm/d4aH/CXLett3YwfiTbKyqfWYXTWyHV+HBAddd+NkFbNtuMfGFZSAtl1
         vZPz3Onn+WgEoF6KnnHI18oCXxF+HK5b2w5ym3sBL8GPo6Mu09VKe54nGUxVesSRY13H
         x3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gWZqDUp12Dv/ikWDlhckPF5+nANQxjQ6++fkVLPIeOg=;
        b=lBLw6G1wE+0mkfxJyBhD9MPYk1QICh5UO/Cy0CBnp9d+Pyu28O2cYHW1XHiXL78ytH
         8a1sc6i7A9droIxrQmNc82upM+FVgqZ0BuDx/m1LfwevQLM3Qih+VH5ub2mzyTlJXQE9
         CgWKPKsbNrxEpqJlRpmAkox/hZuEfArMywX25wdoya8Tt6eN4VDlljyRcs+ssLOiJE7U
         tbnOpcCR5GGwag4wAvvuLB3sQ7Z93OxHcl8xyiJXjmYBBZAC3FHKuaYfz8UOPhqEu7O0
         kcDVPGfvwmfIN4TQqPL2vgM2TMXllyFMdZHTFmCH81A7TIw+Kbk03Ow1QPa2Z5et/1HP
         vU8g==
X-Gm-Message-State: AJIora9WrheTshPv4Zr9zwo8ePzimUy7YkkJfds9S70QeTjVZVAbeJdb
        J6yaDv4Z+nzIPNEppy2XeAhH8lBV5ds=
X-Google-Smtp-Source: AGRyM1tpWbfR39yN+Md8v//xmZx2R+UG+F99v6XRkrRJkYqUJ7s9Mtp54sos6XSxC05ySdhObACOzw==
X-Received: by 2002:a17:90b:2686:b0:1f2:503c:2472 with SMTP id pl6-20020a17090b268600b001f2503c2472mr1989171pjb.187.1658531305997;
        Fri, 22 Jul 2022 16:08:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.160.227])
        by smtp.gmail.com with ESMTPSA id 30-20020a63185e000000b0041296bca2a8sm3805790pgy.12.2022.07.22.16.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 16:08:25 -0700 (PDT)
Message-ID: <62db2de9.1c69fb81.2c4a7.63d6@mx.google.com>
Date:   Fri, 22 Jul 2022 16:08:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3870524312469499399=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Clean-up stale/unused hci_request.c code
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220722222041.812546-2-brian.gix@intel.com>
References: <20220722222041.812546-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3870524312469499399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662383

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      36.19 seconds
BuildKernel32                 PASS      31.25 seconds
Incremental Build with patchesPASS      50.10 seconds
TestRunner: Setup             PASS      536.57 seconds
TestRunner: l2cap-tester      PASS      16.84 seconds
TestRunner: bnep-tester       PASS      6.26 seconds
TestRunner: mgmt-tester       PASS      100.28 seconds
TestRunner: rfcomm-tester     PASS      9.42 seconds
TestRunner: sco-tester        PASS      9.22 seconds
TestRunner: smp-tester        PASS      9.23 seconds
TestRunner: userchan-tester   PASS      6.25 seconds



---
Regards,
Linux Bluetooth


--===============3870524312469499399==--

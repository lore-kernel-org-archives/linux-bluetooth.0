Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6166C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 15:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJDPYV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDPYT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 11:24:19 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C65FDC5
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 08:24:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d17so8525571qko.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=wucVH5vOEfODf26Ql3GVXH3ubWSriOqTWnOh67xQtYg=;
        b=CYCjA+j0wkgz69jbcp/9uthzxigTBAInowE67c8qLH183vwy0wfnAoNpCikfmdVV4W
         Kc6TH3AAm/cXQDDuPPxaLh6IWhCB/wrH+3TpwNMI+bk8hr8EM+mJ2ADeR0fKEJ1U40rT
         8iLmLP7vBZrCG7mRLJAagFC/6WCnPtca/ur2hp63Lk0YYr6lc2BPCBjS264lyAiuIFUo
         t9EzGdXJBjmqbAOeM/wGDNJoT+qInMFfSq9mDYQDqu9MowGTzDWM2tlC5vnM03yP7Tr4
         8+2yk8TvZb2rCzbCTQVD03m+Q9VCpVquO36ZkqZpCnEaxvwEqG7qUoNsmRMIgxsPkfGI
         rnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wucVH5vOEfODf26Ql3GVXH3ubWSriOqTWnOh67xQtYg=;
        b=uduoOjHecvrc9Su/ERZMjkESe5uiumGjDWYmFqAPEsW07GoIToqfAUCgezRdc7Y1Uh
         BHldxgwZE2ahdgP/p/XvvyYtbNdobODWewPmeV7s0GEsxYlczbREmcmzOJopqVWCjELs
         dtLTGhbkCntGYQ07JYIKxPlTJalM8uaVslKK60XFmjFxyzxaijgQIACB1hFNdYyTMUaC
         XWixnjR+XGKZpTKV7En0FJzK4klWcDHgTXXO9hbL9DYHjw9srShpme2Om9ojktD5Nsl4
         FFGB56MZqAljxfozt4skhjbbqvVVze81LzxkEao3+DF9Vsf9bWT9+FUtN9Rp64cNsFsV
         bUxA==
X-Gm-Message-State: ACrzQf1KyQkmIi3lCoKPSybT7qX7Hx3CjoHQhqcUNBKq+OYPDkZl1WZr
        rpFRMNzBkU6pzmr9tbszQ4FdLFhJXWw=
X-Google-Smtp-Source: AMsMyM74thmb3lpWyW8w/ziU07UBgfp1WXv13CLsVLbqz7bpwba1AAxOKr/L73PPFB3m0PJ/HcAbiQ==
X-Received: by 2002:a37:aa11:0:b0:6df:cb82:fd0e with SMTP id t17-20020a37aa11000000b006dfcb82fd0emr1839744qke.311.1664897057087;
        Tue, 04 Oct 2022 08:24:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.253.127])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a0e9000b006a5d2eb58b2sm14435000qkm.33.2022.10.04.08.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:24:16 -0700 (PDT)
Message-ID: <633c5020.050a0220.ba7aa.9d3a@mx.google.com>
Date:   Tue, 04 Oct 2022 08:24:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6358817619009730015=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        nicolas.cavallari@green-communications.fr
Subject: RE: Bluetooth: Work around SCO over USB HCI design defect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221004145351.13066-1-nicolas.cavallari@green-communications.fr>
References: <20221004145351.13066-1-nicolas.cavallari@green-communications.fr>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6358817619009730015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683026

---Test result---

Test Summary:
CheckPatch                    PASS      1.78 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      34.91 seconds
BuildKernel32                 PASS      31.38 seconds
Incremental Build with patchesPASS      43.37 seconds
TestRunner: Setup             PASS      517.31 seconds
TestRunner: l2cap-tester      PASS      17.56 seconds
TestRunner: iso-tester        PASS      16.40 seconds
TestRunner: bnep-tester       PASS      6.68 seconds
TestRunner: mgmt-tester       PASS      105.96 seconds
TestRunner: rfcomm-tester     PASS      10.40 seconds
TestRunner: sco-tester        PASS      9.83 seconds
TestRunner: ioctl-tester      PASS      11.06 seconds
TestRunner: smp-tester        PASS      9.94 seconds
TestRunner: userchan-tester   PASS      6.93 seconds



---
Regards,
Linux Bluetooth


--===============6358817619009730015==--

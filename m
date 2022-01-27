Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209A7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 02:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiA0CDi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 21:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiA0CDh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 21:03:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705ABC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 18:03:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i17so1289220pfq.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 18:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ag6u0ldCVuCN/1TugTZAT7kl7as4OlbXi3yIpFPs7Y0=;
        b=g13qS6FtfAYK7mMCh2cRmS4cRom92zbTG7n7qWX25BzfLpf9DaMsPsleWA31/k3FS0
         A3VJQsFh5jMFhTuMWV07sCPzal6J3zHWCA+2rX5r27v1FPFeAHX9DWqRVMnv8yRJ916k
         XAQUGCgTNHILPXSfQbKrKtjh4HirJsQBpHfQdbZLsMGvsZrIWpK/10/QmEZfPE9xk6kM
         q/vmwmRwn6ltQl8cgnSaziE83ZQlfhnX0pRHj9jDBsLQQFlnWKk4qZ5NE3kUYWTG6nq3
         GE9s1Y0tLYTUoyvBBx3dru6YBcUmUKmYQr64n12nmG4jx1S9JeeiilV6ZG6LKMwPeTIO
         fQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ag6u0ldCVuCN/1TugTZAT7kl7as4OlbXi3yIpFPs7Y0=;
        b=VsY7UjMQ41VOxyb06wSd/GaiyOuCA447gTzCJOp9IA0BmwzHgrQ2CJfVlSDshS0chh
         wSghKzNhizEbibSVt2q53Z67Hl8P7qEWsvMAC1qUvW1lGGg+GAE5GEbGv35tB9+MUufT
         1HNMJpz5Yg0eGgc5qeSPBhlqa62eBeuuQm5cHjJY5g6rCCioPF14gSnQv6iiSqv5S69X
         +ctnPlG8iRz6DjHLRqnqGMC7ZmRWD7+Zf8YmaE+297mXcnVjNkYYaeydJE2Pctqeofyk
         05ty1j47uGgJA8tcT9FG3IKlntG7jeeGFnl7CErRcvTVKfWKXYu6dscqyM7N8/nzwK44
         L/Ow==
X-Gm-Message-State: AOAM533Gzxy+IepqkZKpIZMiF8893+s8SHAc6IDPKfleOCDneIdQ+ELJ
        ITbWPARkqhcio2WrqtfBYGLHMNAnomU=
X-Google-Smtp-Source: ABdhPJyN7kgZd9BROHlxl4ne2j8oCFld6WTMzP0EmXclAjEUJgIfyZbUW7xfd1GtJSBMLn7z1D5KQQ==
X-Received: by 2002:a63:d7:: with SMTP id 206mr1231417pga.224.1643249016713;
        Wed, 26 Jan 2022 18:03:36 -0800 (PST)
Received: from [172.17.0.2] ([52.250.126.32])
        by smtp.gmail.com with ESMTPSA id h6sm3435880pfc.35.2022.01.26.18.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:03:36 -0800 (PST)
Message-ID: <61f1fd78.1c69fb81.a6aec.a976@mx.google.com>
Date:   Wed, 26 Jan 2022 18:03:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4440028099460506271=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix queuing commands when HCI_UNREGISTER is set
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220127012100.3128690-1-luiz.dentz@gmail.com>
References: <20220127012100.3128690-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4440028099460506271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608888

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      38.03 seconds
BuildKernel32                 PASS      34.01 seconds
Incremental Build with patchesPASS      45.70 seconds
TestRunner: Setup             PASS      587.10 seconds
TestRunner: l2cap-tester      PASS      15.08 seconds
TestRunner: bnep-tester       PASS      6.72 seconds
TestRunner: mgmt-tester       PASS      122.54 seconds
TestRunner: rfcomm-tester     PASS      8.72 seconds
TestRunner: sco-tester        PASS      9.04 seconds
TestRunner: smp-tester        PASS      8.86 seconds
TestRunner: userchan-tester   PASS      7.34 seconds



---
Regards,
Linux Bluetooth


--===============4440028099460506271==--

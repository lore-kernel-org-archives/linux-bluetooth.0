Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ACCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 07:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJEHfb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJEHfU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 03:35:20 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EAB52448
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 00:35:16 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a17so7462662ilq.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Oct 2022 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Z8h6QYuDJB8FaSYROzM1i4//hht76EolphpDeZc/7Nw=;
        b=U4CbTwS0Jj0RISZXYjJ6Dvo+6xbeC1HPdNnT2mW0h12WLYx+yW20y5wQmdfFp7qKk5
         9vJWzTsfh9gkYsQSWCvwoJMZ/45YJ4szxOl+R3FwKnUo+EIJsYNBdqQE2GhsgvS9fJlm
         WLjEhnssoErp31UfFnjp9bOXu5rBJFFe2iDNri4c5BgBLDqLhNOZ9mRjvUwpK2Kln9ed
         oSxASiWylUlEWudPltgi4lcuamdOOJ3ejUetSgvvAZw/XWr/bV22Rz8sSNGYZuRl9c5J
         e9ybs6F5Jpog3J0dtpFxFKJsMoexAe+7M9Z8NJ4xnPiJqeXdX504EErwbcCIWTwRb3bQ
         TqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Z8h6QYuDJB8FaSYROzM1i4//hht76EolphpDeZc/7Nw=;
        b=arnqCBfvpzr1YFe7V5hJKvNs4L032tlD7Ibty5lvstQnYPyTwGZKxLyrq/iiPhkDYT
         LzaM6B/89t7wPggZmKFxpWnqLizVFSZvZaBIMB01n/3TdYESeo+aaM9fXAHeteTEcfhI
         u8DD5Ch54QGZIznGm+7YO6JWaUYzxD53yukY4JVWPpuoQjQo4PrmksEfw8EEOURFF912
         WvG2BCx6X+Jo573bcG+OF1r3LHSFui1rShHliA5LqM9GAkeaqj4v48pOG64AG2fl2wTu
         yy5c+PabnD2I87/fCrSXyqAbGxuTSUq3v+oT/FcCuZlhrB2GYjJnwGKwGj/qu/f81AjB
         oChg==
X-Gm-Message-State: ACrzQf2vyQrdQkopxUpHaUJgI9cAi5CGwbs1gDHghMsEN6vSOt7/rQLN
        rEgwSWKQm4pofzr/Ue8TbQ9p/6R4lzQ=
X-Google-Smtp-Source: AMsMyM6gy+9gHWiSnmC6t788K4ayrPpWhc5hzDHLqrtzk40VeTz26Kq2FCW8IoSEt6YeFdoL1R5S3A==
X-Received: by 2002:a05:6e02:1446:b0:2f9:8ce9:8da with SMTP id p6-20020a056e02144600b002f98ce908damr8518335ilo.196.1664955314926;
        Wed, 05 Oct 2022 00:35:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.235.219])
        by smtp.gmail.com with ESMTPSA id q15-20020a02cf0f000000b0036345b91f4asm2076777jar.23.2022.10.05.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 00:35:14 -0700 (PDT)
Message-ID: <633d33b2.020a0220.568a4.2915@mx.google.com>
Date:   Wed, 05 Oct 2022 00:35:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7405961456928130815=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: hci_sync: cancel cmd_timer if hci_open failed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221005150934.1.Ife932473db2eec6f0bc54226c3328e5fa8c5f97b@changeid>
References: <20221005150934.1.Ife932473db2eec6f0bc54226c3328e5fa8c5f97b@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7405961456928130815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683158

---Test result---

Test Summary:
CheckPatch                    PASS      2.38 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.69 seconds
BuildKernel                   PASS      49.88 seconds
BuildKernel32                 PASS      41.45 seconds
Incremental Build with patchesPASS      54.45 seconds
TestRunner: Setup             PASS      731.82 seconds
TestRunner: l2cap-tester      PASS      17.16 seconds
TestRunner: iso-tester        PASS      16.55 seconds
TestRunner: bnep-tester       PASS      6.21 seconds
TestRunner: mgmt-tester       PASS      106.64 seconds
TestRunner: rfcomm-tester     PASS      10.10 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: ioctl-tester      PASS      10.61 seconds
TestRunner: smp-tester        PASS      9.48 seconds
TestRunner: userchan-tester   PASS      6.49 seconds



---
Regards,
Linux Bluetooth


--===============7405961456928130815==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC07C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jun 2022 10:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiFYKBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Jun 2022 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFYKBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Jun 2022 06:01:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DE73F323
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jun 2022 03:01:42 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u189so6639851oib.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jun 2022 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=P/M0HeLd3/fSf45uq4XZwbrTFcCk5+BwIXd3B17HYIk=;
        b=pSeFhDBx15Vpec29jDA/64qqKp05+w+alSFmgNz1li6iEumoG9rfqctJqUSzPsgcaa
         gOhnUq69VDpizIb4bk0XVSYt8QAIdBeMP0T6UhFp8PXbdanyQqiPE3Mcd95rI2NF+9Rs
         WrI/hQbIC998WHoZ6OPQ48MrOzY64ScUbZJD9sdtF09prgh/5tnslH8x+d6am/8CaiQm
         i82d/aIo5VqleHoUZMc2Cmycgy3Mm6ac165D/3jFE/aUWFPwlwJWrF0heeIi8i7ylTaC
         s6Y2yrbc+ZBmF/1zrhW4/b09UOdcoIgc1qfO5xlMoqRx9xvAF+Kxrh4C4UqSR6QViyMf
         JAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=P/M0HeLd3/fSf45uq4XZwbrTFcCk5+BwIXd3B17HYIk=;
        b=MJpJy9FpuIAp4TsVRucc7XnKaGnS1fDnNtzhJq9gjt31b7tVf5QKlQWf3gO0xbCjp1
         m3Tu8tTgQpkuiP/Ngj4aaPtfq6RqgPm8lHXTOnS/JiCleam45G50YG1QeQuAJuSPHx6O
         EbicFprVw3xz+jwxnKqkUOi8W1+Ztyw/22YykyS2/1RwJ/FGqEboH+kTQS5+lexs0qtt
         z3bYtosVCONiuyt/hKj0tTS8RBbNNu/0SQOEPO+aN4V6W7rWRpIeBJZjXKVlWOKYsBPN
         P4+NvrRH0E+HwcyMD0wKtLIg3CW10d4l4HdMFhEW+BZK2zwsbYK+NCca8Eym8hKeyRH4
         FqTw==
X-Gm-Message-State: AJIora8Y9CI/TN5EKAt+SkSvVz39528NIHb1X3B8Mgh8v841KAMZVVtX
        xORK0ZwW0Aldbkko3EJCDeJOBfGLCQs=
X-Google-Smtp-Source: AGRyM1ttVVa4TKfktdGBk+4DPFwXdFQMOR5FKSJv8LZiP5saCtqpJjnT8RdgiFQbKoXE8b1dDiBqbA==
X-Received: by 2002:a05:6808:f92:b0:32f:33af:7234 with SMTP id o18-20020a0568080f9200b0032f33af7234mr4635303oiw.99.1656151301465;
        Sat, 25 Jun 2022 03:01:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.84.24])
        by smtp.gmail.com with ESMTPSA id y19-20020a9d7153000000b00612e4267634sm3033285otj.18.2022.06.25.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:01:40 -0700 (PDT)
Message-ID: <62b6dd04.1c69fb81.3cc5e.76ed@mx.google.com>
Date:   Sat, 25 Jun 2022 03:01:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6856686747068074937=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, xw897002528@gmail.com
Subject: RE: [v4] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220625090358.9373-1-xw897002528@gmail.com>
References: <20220625090358.9373-1-xw897002528@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6856686747068074937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653792

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.86 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      40.09 seconds
BuildKernel32                 PASS      34.11 seconds
Incremental Build with patchesPASS      47.16 seconds
TestRunner: Setup             PASS      560.23 seconds
TestRunner: l2cap-tester      PASS      19.43 seconds
TestRunner: bnep-tester       PASS      7.26 seconds
TestRunner: mgmt-tester       PASS      118.08 seconds
TestRunner: rfcomm-tester     PASS      11.31 seconds
TestRunner: sco-tester        PASS      10.78 seconds
TestRunner: smp-tester        PASS      11.03 seconds
TestRunner: userchan-tester   PASS      7.51 seconds



---
Regards,
Linux Bluetooth


--===============6856686747068074937==--

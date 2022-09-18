Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE96C32771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 13:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIRNbD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIRNbC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 09:31:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FFC1D0D3
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 06:31:01 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n81so20531566iod.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=C2N8uo2u7VD2QFKLuesajozWrY2QCJlAn3m2yEuNMaA=;
        b=S5R5nS/bC/0MNzreMQI0kslPCWdPsFNdxk6ZRliNX3pEoUVxcwbLqyEqLzadRw6ymk
         jVcyT53p+DrGhPSQXsnHlOlT9gN5QEz61cpolKIAcDS6nTttFJ1FFC9f582Sq21avRQU
         j7hLcdX+ccd32Q6zwc8oM+ng+27eJhf2K69Qr5s3XrtCPpp/QCmK7tEEIRQgpscd2x8p
         kBim6VhbMv4ej7/tBEfSnRB9z32/PKMgwxTkmLMrK6BWL893v4MqyJNQkpNanrxUyvbL
         zEYtvhF9GKWERtoJ6VIw4na3SgWLSHTas/9U2JSQCSzE+t20FuiZg6ij+KFEN+a5oBhx
         eR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=C2N8uo2u7VD2QFKLuesajozWrY2QCJlAn3m2yEuNMaA=;
        b=CAf7Uxi9ftRGItSpRS8JpfzKVryYwpzQR5bDweIWWiO988agQ1ZO6GSNQZxreVnW8H
         HqjltLvYiqW4MbJaQiDdvAM5PdHNsmD86ozck/G/Vn4oBmMTUApvKSWQE+nWAoevfHqH
         NNWoTBvsMmwV82VXsQB6FRXEKiRN9R2y9P1nZcRnDCitzYKwbqhzK1Ky3yFxtnpnj41I
         vjB3WpyPBtpC+RBGnjlIpoFoP6IF3MHab1FwMe9/Vbb2eXBEljImup/FlTKIi+SEfWht
         NwkUM76d+SNgmAW4kXO1xr8fKqou7aNpRmLSEQPtHqLKn5AZ5BFhdoO0OLlqm3LfSVZt
         bp3A==
X-Gm-Message-State: ACrzQf0ckdrKAOmycxOAa7SrDjLYX9/APHNWIekBWVkNX6PpBSYy+oKP
        6M0tgAZqDKKAXwYweO2MevazpfKV1BA=
X-Google-Smtp-Source: AMsMyM6dvpjP23MeesSjfEQacLJfdUmKX+5mU9wWdmpJ67eS6DPTulGFBPiAaGqhVGfR54p6hIiGzQ==
X-Received: by 2002:a05:6602:2d81:b0:6a2:53fe:5f53 with SMTP id k1-20020a0566022d8100b006a253fe5f53mr5405148iow.163.1663507860857;
        Sun, 18 Sep 2022 06:31:00 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.87.155])
        by smtp.gmail.com with ESMTPSA id l1-20020a056e021aa100b002e939413e83sm11028666ilv.48.2022.09.18.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 06:31:00 -0700 (PDT)
Message-ID: <63271d94.050a0220.aa0dd.9e89@mx.google.com>
Date:   Sun, 18 Sep 2022 06:31:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7116088698474486455=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wiagn233@outlook.com
Subject: RE: [v3] Bluetooth: btusb: Add more device IDs for WCN6855
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <TY3P286MB2611921D86D83105FC85ABE0984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <TY3P286MB2611921D86D83105FC85ABE0984A9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7116088698474486455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677949

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      0.96 seconds
SubjectPrefix                 PASS      0.72 seconds
BuildKernel                   PASS      34.40 seconds
BuildKernel32                 PASS      29.96 seconds
Incremental Build with patchesPASS      46.76 seconds
TestRunner: Setup             PASS      504.56 seconds
TestRunner: l2cap-tester      PASS      17.26 seconds
TestRunner: iso-tester        PASS      16.36 seconds
TestRunner: bnep-tester       PASS      6.54 seconds
TestRunner: mgmt-tester       PASS      103.84 seconds
TestRunner: rfcomm-tester     PASS      10.25 seconds
TestRunner: sco-tester        PASS      9.70 seconds
TestRunner: smp-tester        PASS      9.71 seconds
TestRunner: userchan-tester   PASS      6.68 seconds



---
Regards,
Linux Bluetooth


--===============7116088698474486455==--

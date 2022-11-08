Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B7C4321E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Nov 2022 13:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiKHNj6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiKHNj4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Nov 2022 08:39:56 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0588327FC6
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Nov 2022 05:39:56 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id s4so8631926qtx.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Nov 2022 05:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=39xOSIxefg9wcdI8awZ15R9OhljN2yFqIN6CiLgKMbQ=;
        b=e9htsokdCCxpMEC3sA1g+80ITNGFjOoRcZe7Da4I8AwUncrYH8e4Rafwu1AuAXpyaE
         2KZAOsj3YP40iCxwdW3b9G0GnyKnJunaTRw/WVdViuJ9mAHYmWaSA7l+pRhjVBpXEqnU
         lKfZ8D62nLassNLP1UCfrC8qCqTr2PwKd3/qERN5efOgMDoLDxc0NV4pAm/qiiEHkiyz
         feKYLlo4ByDw+fBOGWRqAVk27yLNEawdbOsb0tan8H10t/QpydQJn2l8WeauobQwIG6J
         ee9eFAK5Et6apqp9RoMB5mA84rCrP2/Nbu2MofDqBWegNAOWaufwsxwhXjaijVs7sl5P
         EQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39xOSIxefg9wcdI8awZ15R9OhljN2yFqIN6CiLgKMbQ=;
        b=jIPTNmnBKOZ+wgvfJAAQF4IZCkpBYMOMqDbiOB21QpXKVNKdhkzSpfdWsSxOexb0i1
         eoKvwRJ15XhEnWymhsI7LhC0Mk86P+kZ/C/3liySzurT0A8pkhxjGyWekfnXtrbhNjVh
         4Yj0wWQzXhWf+UN34B5IKSxMrgSLjHh5snzgDwlzZ+BJpsvl21Xy1cPEqtp7i2oBWoEe
         yNqIh4MhvmFXjQCuUP0rb0UTPMdTiXJxBTrraLjeIrE9Re11FJXsETSEZ1V2YRk85OGG
         /27TYikbTNjiVeRQOZWcgL1IsKwCt4AWkMHgWZivlwA0FqQZ5dK9fKfQrjxdbEJWcEtv
         Nw6g==
X-Gm-Message-State: ACrzQf0UxLLIXDe1Sh4vK/W3JdLZB924NNJ+fYUmTg1S1eti5lsS2qQN
        BxaBEVJmfq7pz4ssTMDCybDgPY0hAwsJIw==
X-Google-Smtp-Source: AMsMyM5PCE1WnR0AA7usBS7KU7tJij9YG+50SyVvc5Jp4qAyA+oQeDcwzbMR1OduaFGBD7J4B3KxUQ==
X-Received: by 2002:ac8:58c4:0:b0:39c:b702:8ec with SMTP id u4-20020ac858c4000000b0039cb70208ecmr860575qta.253.1667914795003;
        Tue, 08 Nov 2022 05:39:55 -0800 (PST)
Received: from [172.17.0.2] ([20.185.196.244])
        by smtp.gmail.com with ESMTPSA id s26-20020a05622a1a9a00b0039a610a04b1sm8325001qtc.37.2022.11.08.05.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:39:54 -0800 (PST)
Message-ID: <636a5c2a.050a0220.b13b3.26a4@mx.google.com>
Date:   Tue, 08 Nov 2022 05:39:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7180223290928803092=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, linux-bluetooth@cyborgize.sg
Subject: RE: Bluetooth: btusb: Add Realtek 8761BUV support ID 0x2B89:0x8761
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221108125413.216254-1-linux-bluetooth@cyborgize.sg>
References: <20221108125413.216254-1-linux-bluetooth@cyborgize.sg>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7180223290928803092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693232

---Test result---

Test Summary:
CheckPatch                    PASS      1.67 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      35.46 seconds
BuildKernel32                 PASS      31.76 seconds
Incremental Build with patchesPASS      47.46 seconds
TestRunner: Setup             PASS      531.28 seconds
TestRunner: l2cap-tester      PASS      18.04 seconds
TestRunner: iso-tester        PASS      17.36 seconds
TestRunner: bnep-tester       PASS      6.75 seconds
TestRunner: mgmt-tester       PASS      108.29 seconds
TestRunner: rfcomm-tester     PASS      10.68 seconds
TestRunner: sco-tester        PASS      9.99 seconds
TestRunner: ioctl-tester      PASS      11.37 seconds
TestRunner: mesh-tester       PASS      8.40 seconds
TestRunner: smp-tester        PASS      10.07 seconds
TestRunner: userchan-tester   PASS      7.06 seconds



---
Regards,
Linux Bluetooth


--===============7180223290928803092==--

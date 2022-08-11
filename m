Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D4C00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 02:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiHKCzg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 22:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiHKCze (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 22:55:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CEF49B66
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 19:55:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f28so15399290pfk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 19:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=44JJqdH7NuUZngMcO9qpb/Kw2CgC1mZ/5qjlcqQC2RA=;
        b=PKJYEUZkbcisoXVWXCNypZGJ5qy8loyEZOinN7rePlpKYzJo1Bpcroti4wVbaBD0LK
         9nEyiPTnXEaXM1j8Sl3LWgkHxvwKkLX6p/WSNPWTyGXb6Ty+0sbDCPUWU5Quu20yu4ow
         l+K5SJmEOHAUgv+BSez6F2HHu384lr1oddR9d4Afg+LUbqEu922URonl5y5iEh2LSrOt
         SMo+YD+P9eogdM0NiLRktvj0/MXw3FGNRkbutSuZ0SONHx2a4kkF4IupwW/1orO/h+8d
         LocsXhmf54obrv+tCINLCMdgTi92ADJ1XvHOixZ/zLJQbhJqK5o5TbfN0SDtEybEkJVV
         0QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=44JJqdH7NuUZngMcO9qpb/Kw2CgC1mZ/5qjlcqQC2RA=;
        b=oHKfj1Wr4vvDziODHfQ5TCJagPhBTpWp5pqpl7njl3ftTLnoxfn8RI0JzGEQiQgWlz
         BKxFoZXZoYOyWnJAPUCoDZ10vBk0OnTghpxE1V2BKZD9kQrEzuBj3GS73gu9TKvfDdK5
         0uzyYdcNLm35G2K/tR2vGzQnApuaTR1hP0nodkW6mYPxM2FYUjzMeS0Y3sPE8nzEBnEE
         axot4HCPNMJe9Asq4GrYHyTAwq33Y9XtDQ81zcilSinmThUZqZWsGYsk9QOtt5HoOWjG
         luv2Um8d4XMCTjQSo8aqd+2zxa8iBySmhhW/MiqTqduHkaF9aGll3Sb/XFzzlyuvqB+x
         IAlA==
X-Gm-Message-State: ACgBeo0y61hy+osoUu/Em82W+oIeFx/MZxvnMEh3+gT0b7Cfnd/Iebdk
        8qndJ0wgUnU839TU3xqqVG2QbLW2YMo=
X-Google-Smtp-Source: AA6agR5WFwgH17yabbR66gNxoWDLvg4NqdEajuM3LMTgXVdglmq5uUg7poAQ7WifAAZXyuZpJB/otg==
X-Received: by 2002:a65:5b03:0:b0:41d:131c:4f39 with SMTP id y3-20020a655b03000000b0041d131c4f39mr20717149pgq.401.1660186531476;
        Wed, 10 Aug 2022 19:55:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.14.102.232])
        by smtp.gmail.com with ESMTPSA id h184-20020a6283c1000000b0052d3899f8c3sm2782130pfe.36.2022.08.10.19.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 19:55:31 -0700 (PDT)
Message-ID: <62f46fa3.620a0220.21113.5c33@mx.google.com>
Date:   Wed, 10 Aug 2022 19:55:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2542255833638125173=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v5] Bluetooth: btusb: mediatek: fix WMT failure during runtime suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <6675f56fc8b0910f17ec506d534cf5330ff04733.1660177086.git.objelf@gmail.com>
References: <6675f56fc8b0910f17ec506d534cf5330ff04733.1660177086.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2542255833638125173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666728

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      32.92 seconds
BuildKernel32                 PASS      28.25 seconds
Incremental Build with patchesPASS      40.43 seconds
TestRunner: Setup             PASS      476.67 seconds
TestRunner: l2cap-tester      PASS      16.82 seconds
TestRunner: bnep-tester       PASS      6.04 seconds
TestRunner: mgmt-tester       PASS      99.54 seconds
TestRunner: rfcomm-tester     PASS      9.47 seconds
TestRunner: sco-tester        PASS      9.19 seconds
TestRunner: smp-tester        PASS      9.17 seconds
TestRunner: userchan-tester   PASS      6.30 seconds



---
Regards,
Linux Bluetooth


--===============2542255833638125173==--

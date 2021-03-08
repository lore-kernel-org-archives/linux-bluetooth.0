Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0072C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F065228
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 16:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCHQ0R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 11:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhCHQZ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 11:25:57 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077CCC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 08:25:57 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id u13so3489745uap.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 08:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=c50Gbr/fN/zGO34Avsgo4Wfzl1jyjMAifL+J5voJUHc=;
        b=lamDlRsKuj/qdZvxlLtctRJSipELDMFfK2eU4BXc3+r9nrZSwSjh8qgxrAA1SRCyOg
         61KBYnZzZ9amKAj+anZcBJRok3GYGCu/nOK0qtmG2TnFYkCgDUPvlbMcw9gU5Pqi1iQF
         pPfJltikK3Hs5HW5YGsF6s2arHkruNEawCVREZBVvPzy2h9icJeBVuHN7A8ENthkLTAt
         xnAvUY0ZAYqfJ1eQYu9fiakCKfPhE66pGcyZvQ4MeVxttDJS87/Lxj/WX71Hpxp5jWG9
         e8Bu3CXFgqXhPzGKG+dbrK7H4ctKX6AZxYWq9v5+VRErTVcidOTyVHpf8nMSwtGcci9W
         0jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=c50Gbr/fN/zGO34Avsgo4Wfzl1jyjMAifL+J5voJUHc=;
        b=YAOc/5vQvSgHrhw+Msmb/TgvyZCmLUY1u5jHyeuLenXzdumz3MmBwXjIPD7SNjgEcp
         /6woLE9a9d/5zXxPtxL8gSvzfrb1htipjjGW1BK8fFCLil1/Iy2Ukg/ILuz/39UNxELf
         eH3ONg0q5NsTQ00LGjFZvCqRwB4advYiLrri2LJ8QdUjbhXFG693HwckO3bB4tkmDBF0
         FOYB6h9oz0+XznnMcaIdIkd6V18PrXfIB8xXQ1mGHYILed4rLFxxhh9aLtmlQi+u0Ewe
         jI89tNWjJeeh2MBQK22PJRxjMU72e405d2hyIrDtUpTxNaVxE8gzmzhBhaAveRf/bqtO
         o0CQ==
X-Gm-Message-State: AOAM532AGyLDszPeKrF6m5EGWeP+RgBUId1/qI5udM9oZPMtX2Tq/UcR
        9O29BZOGZSvTD+e+MQP/e+t89DG98XXtj8ilDFBBu+y4MN8=
X-Google-Smtp-Source: ABdhPJymziEiia6Bsdtjw5j2FA+tP48mbhGjBZb3InO1N+A2kg3lyKpgYQh0nmlTuQSQOQyYOjZhyWxM89iuJ6JTEuA=
X-Received: by 2002:ab0:3736:: with SMTP id s22mr10153731uag.76.1615220756034;
 Mon, 08 Mar 2021 08:25:56 -0800 (PST)
MIME-Version: 1.0
From:   Patrick Doyle <wpdster@gmail.com>
Date:   Mon, 8 Mar 2021 11:25:30 -0500
Message-ID: <CAF_dkJCJ7ZkgteNFrm-Xy+j-PtZQNP6qfhgnT-ePAGyQhkVLXg@mail.gmail.com>
Subject: Where can I learn more about using the org.bluez.LEAdvertisement1 interface?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am brand new to Bluetooth, BLE, and D-Bus, so please forgive me if
my question sounds naive.

I see a description of the D-Bus interface at
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/advertising-api.txt
and it appears that I can interact with the bluetoothd using
bluetoothctl via this interface.  But when I run a utility such as
d-feet, and search for org.bluez, all I find are
org.bluez.AgentManager1 and org.bluez.ProfileManager1.  I guess I was
expecting to also see org.bluez.LEAdvertisement1.

So... I have a very general (set of) question(s), which is... how is
org.bluez.LEAdvertisement1 different than org.bluez.Agent1 and why
can't I just "use the API defined by that interface"?  One thing I
_do_ notice in the documentation is that that Agent1 interface also
specifies an object path (/org/bluez) whereas the LEAdvertising1
interface describes the Object Path as "freely definable".  What's up
with that?  What does that really mean?

And yes, I have looked in the source code for bluez (5.50) and I see
how bluetoothctl does a whole bunch of D-Bus'y things to use the
LEAdvertisement1 interface.  At the moment, I am trying to extend an
existing Bluetooth framework (https://github.com/nettlep/gobbledegook)
to support setting LE Advertising parameters, and the author of that
framework does all of his D-Bus'y things differently.  So, now it's
time for me to understand better how D-Bus'y things work so that I can
compare and contrast the two approaches, learn something, and,
ideally, start publishing some service UUID's with my BLE peripheral.

Thanks for any clues anybody can pass my way.

--wpd

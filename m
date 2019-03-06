Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE6C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEEF2064A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 08:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja3IYznN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfCFI2H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:28:07 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:55431 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCFI2H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 03:28:07 -0500
Received: by mail-it1-f179.google.com with SMTP id z131so8235539itf.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1WrqnXVmu3nzxLD2BDB7RU2SjHljlgfGfR7ofbhuQ/M=;
        b=Ja3IYznNXGSWyzNXowsnatuVq5ow7kH/8oLJpdtgKG/XNAuYIUn1qOammXikF2yqDN
         UL0YGXi9cZl3qWe//wVwq+CmapLwhsZem8XOUSJvbiadQWObYhka4cpbTcX/bOOmEeoM
         PWhfvx6nzKRhS1zPnvZEP06VdLyZWYH+ytutNO8marACiND3mM6KM3Oas5qyWO46ds+u
         6SmDGt0b/q+pidzFk29sSiIBWANKxYGSCDxhX+qM9k2nZGrpOQct+t03oUBFdD6I5CF8
         dLtLtNcenOCHDQm79qpz0egwU/lt7WOYuB2f7u2kCZXDg6//8L6Ss1ru7wdYfGkLLIsC
         Hxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1WrqnXVmu3nzxLD2BDB7RU2SjHljlgfGfR7ofbhuQ/M=;
        b=I3JkAE3g1tx1G5s6h4CnHW+jgqxrwg/eEL0T8FPSjKDmRB/l507AiMsdQxXaDX8c7w
         I2T6j7KF2AKdY2g7+UC+oeeh7kIbLsuVmlSzJXnHAl/SG1pOu2NoGJMXe7mhWgFR2fTP
         D/qLzuhmD0st+IBv+PyEzvqD1y+rAS2OkkFyJXn2btvqRRkh72e4tJW+ts2/3QU1ZNiM
         Ig+3X+ncWgkCFdBuVPPezrNb6i7UvOE1qHAxNBewZfFYelsXhRgqrvrrzHZ3EYrGX6NU
         ID5VKwzFA0elShg/cpF1w27LUojpzb0adqzJXduc8FVqf7M0Ss2Z0LsbOu8mJvsuM59K
         H2KA==
X-Gm-Message-State: APjAAAVL4EfpSP9kVB9mYP5Z5gc4uLJvWU9Na2s2eFWfdh56LO74WluO
        dvDRkXbDpfaB1RfQBiLnnMKHvXHNL5uOXNyD/5I=
X-Google-Smtp-Source: APXvYqyjoDWGoY58Jloa26I2VHMDU6JfNjuVDYHaCgeV8ck+JrcUA+LduG4vH7KPtLff8iFWhjadu8qRtTh41PM8frE=
X-Received: by 2002:a24:7a4b:: with SMTP id a72mr1298924itc.178.1551860886724;
 Wed, 06 Mar 2019 00:28:06 -0800 (PST)
MIME-Version: 1.0
References: <CADS+iDUDv=Keo6661q3dY8C5=f+fZtfCe5gdPutO-psc9Pe0UQ@mail.gmail.com>
In-Reply-To: <CADS+iDUDv=Keo6661q3dY8C5=f+fZtfCe5gdPutO-psc9Pe0UQ@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 6 Mar 2019 13:57:55 +0530
Message-ID: <CAOVXEJ+bEQ=jmqwPEZygzaP7ChtKk2GwLc7183VyiRe5tbOzUQ@mail.gmail.com>
Subject: Re: Strange SCO problem
To:     Yaroslav Isakov <yaroslav.isakov@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Intel adapter 9260 and 9265(with the latest Firmware - from
Bluetooth-next) supports USB ALT 6 settings and was verified.

Along with backend ofono
https://patchwork.freedesktop.org/patch/245272/

https://www.spinics.net/lists/linux-bluetooth/msg76982.html

Regards,
Sathish N


On Wed, Mar 6, 2019 at 5:15 AM Yaroslav Isakov
<yaroslav.isakov@gmail.com> wrote:
>
> Hello! I'm currently trying to modify pulseaudio to be able to use HFP
> profile with mSBC codec on native backend, but found that, while
> working de-jure, real sound is completely ruined, so I can barely hear
> what is sent over SCO link. I've tried two different Intel adapters
> (included in 8260 and 8265 chipset) and KillerWifi (ath10k driver), on
> two different PCs with two different headsets, results are mostly the
> same, the only difference is that on ath10k words are more or less
> distinguishable.
>
> I've even tested with pulse just for profile setup, and SCO is sent
> via modified scotest from bluez, which sends some test sound, manually
> encoded via sbcenc (with added h2, of course). I've tried also msbc
> branch from bluez-alsa, same result.
>
> I'm sure that every time socket is connected with setsockopt(fd,
> SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice));
>
> I've also tried with this patch
> https://www.spinics.net/lists/linux-bluetooth/msg76982.html, with no
> luck.
>
> Any ideas?

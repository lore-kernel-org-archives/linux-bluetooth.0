Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B84C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3B12343E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 17:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbhAMR7O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 12:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbhAMR7O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 12:59:14 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B106FC061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 09:58:33 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id j20so2727445otq.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jan 2021 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eR5pLpF31nyF2RL94MPNBabFabWRzUk5zmDvQPxiel4=;
        b=OgS6gtaxi0gC93w+7gnaWyKXJw7Um+4hdCOmTgsPkZQo6i9thqqOcSMLOrgLUHAXRQ
         paHc6dpK7k4HvyjPKOs1dFbV9wklCxhJFgrSdrvBCSfr+ovtg1u4+fSvkGJwDvvnMVbQ
         4INaylUNjG8OKxWLL91QAT+dgnVF6U1GoMR0bjRR9o4jnEgM7kDxsz0SboC4mNTz88/N
         z68DMQ8kXafyJteBWZvTUqINQXROaguo03l7r0hIhgtTGbni3iqQUB6tm9hVmPQTXhN2
         Cnc742DaWbMs/yV662rpXkTzPf+tv8K9c7bDhYlEpThUp5loXUumNylbN5KJ632tozSO
         dCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eR5pLpF31nyF2RL94MPNBabFabWRzUk5zmDvQPxiel4=;
        b=trfsJA5909IKza4qHGuXhaEcRpmYyrQTK2M1WwlffEg1fdk66+Ff8P2kaNTeZJcf4x
         WIp7sVywrpDNZvZ5p47AJiDW8N13Oam9/u8cKE4O397tEWNZJS/FTkY+pvIaueTp3t4x
         XfWAZ5pbKmhRF9aPsqGjEdkVvWe7tFLQlf2mvwUdVsx907OuBZGjgp2lliSeT3ef5j37
         2s7IcIeupgWJNJc+Z+Qxh9zpftOVjcBywDCGQR99LoGioOdnq9y0CyNiP3hYYoCD/i6M
         XbG6sWWeDABO/iewWUaqkAI3rT54wVrKBfCvk4EaagGePqvpp0cjf5QJ42lE0SWlPojd
         9+rQ==
X-Gm-Message-State: AOAM533ZG8LEeNUgY25bcXhu9MAMvXUfvyIDphK8twtsuzxDygKaBPHy
        RiD+E3l8uJt5pK1xp4ExHIfh0t5LuR/iGd713mQ=
X-Google-Smtp-Source: ABdhPJwQSTR2eWzl1Yq9TfMrnFDmduFfCOFd/hvDB6daFHfzbJdNyqBleAEhKhQXKLOGdA4C9G1056VvRIGo3ZntiuE=
X-Received: by 2002:a05:6830:157:: with SMTP id j23mr2109374otp.240.1610560713002;
 Wed, 13 Jan 2021 09:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20210113094905.2787919-1-apusaka@google.com>
In-Reply-To: <20210113094905.2787919-1-apusaka@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Jan 2021 09:58:22 -0800
Message-ID: <CABBYNZK322MeXgUbDBoctamaQDYSJFELp=0s3ODeqssCkY_szw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 0/5] Support advertising monitor add pattern with
 RSSI opcode
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Wed, Jan 13, 2021 at 1:49 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Hi linux-bluetooth,
>
> This series of patches adds a new MGMT command for adding a monitor
> with RSSI parameter. Changes are focused on passing parameters to
> the kernel via btmgmt and bluetoothctl.
>
> PTAL and thanks for your feedback!
> Archie
>
> Changes in v2:
> Remove trailing period and fix order of mgmt parameter
>
> Archie Pusaka (5):
>   lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
>   src/adv_monitor: add monitor with rssi support for mgmt
>   btmgmt: advmon add rssi support
>   bluetoothctl: advmon rssi support for mgmt
>   monitor: Decode add advmon with RSSI parameter
>
>  client/adv_monitor.c |  90 ++++++++++++------------
>  client/adv_monitor.h |   1 +
>  client/main.c        |  29 ++++----
>  lib/mgmt.h           |  15 ++++
>  monitor/packet.c     |  43 ++++++++++--
>  src/adv_monitor.c    | 143 +++++++++++++++++++++++++++++---------
>  tools/btmgmt.c       | 160 ++++++++++++++++++++++++++++++++++++-------
>  7 files changed, 357 insertions(+), 124 deletions(-)
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog

While this changes seems fine I was going to suggest we split
RSSIThresholdsAndTimers to just RSSI and Timer so one don't have to
set the entire struct if there are not interested in setting a custom
RSSI and/or Timer, the advantage is the user can just omit one or the
other and the daemon will take care of filling in the missing fields
with defaults for the MGMT command. Also we probably just use plain
int16, int16 and uint16, uint16 so we don't use () around it meaning
they are not wrapped as a struct which makes it simpler to parse and
construct.

-- 
Luiz Augusto von Dentz

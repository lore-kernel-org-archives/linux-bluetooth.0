Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D679C4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A62313C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 03:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgLPDqu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 22:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPDqu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 22:46:50 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C008C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:46:04 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b2so23353922edm.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 19:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXu3XiXJtsxAfLQrfMulSieg9s5ISdwH3czTAlmh2SY=;
        b=sEqcJ5HuI+A+7tf4aZY7NgmuQUICPRNldnyNZSYxN2lzIJdGuaGdQEPRgs4V7DbJ1A
         3CAAloMx7UO/KZu9ZV9p7X+iehQ316vTW44Wxu49r65LoGfaLZycOtyRU4qfJfZ9pKq6
         X0qtHMAINIRj6KRUDKD8H4bAAChUBwLalUgibf2jSffyw5L/lUhulcucMAckZLWOEmPe
         ZODhhGcLw6iS3rn4FFaYwDq7IJ7rdpw371JShhgZ69Nrx1b0+9/YuAd4261nabrdnm6Z
         9BdgxtXrf6dPgGhFDObEuQLdIyDgiJBGXQqu00dQI5EJwI2j6ziZMrsaMy0biI0JQMLa
         qocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXu3XiXJtsxAfLQrfMulSieg9s5ISdwH3czTAlmh2SY=;
        b=h/Fdx19N8exl1Mi/Gh8iDwISvDCmP4jnWHMMP+322qKmxuR713Y6XOupVoZDOtJI3P
         W7O8K9WDeN4EVTgOHorNJKvGTwWWPMOopz7SyM3BBmvDHSxpMaenrnRosar4LlNbP5cm
         12gm/vu5DmsmZ6Bi07L/TGbQETxbjgIg2hrnVbxdiXWTGdlvxR5p3CVIfa9me0Dse2/o
         UjcT3cBAEHz4H5Jf6DfxvQ+D3s9OSd8EMxbHMOm6s7M2v2/g6eArUx5BjKJ6VijrMIzT
         3YMD4XxZpuThi03G5qt3GPWzFV9daNcIornRqNlicSrDGc/voUgfgge2yorQzN8aVPYG
         MsDg==
X-Gm-Message-State: AOAM532qAmpR6s9BQ+LuFEQBL3RF0vbP3Ub/BtvnkVTeyBJ2BzznGARv
        K7taqwjFUJVZYiLYKM2NJcCFKSYvUm/eFDkNLeHR0w==
X-Google-Smtp-Source: ABdhPJxUahXrGqFzROFgfqof1fNhZqvzCYTh5EotDVzOuodzYE2gkNp45lkOQWmNjWx49QNZ65GEmSI9KdvR+kXpLlc=
X-Received: by 2002:a50:d6d3:: with SMTP id l19mr32073189edj.340.1608090362689;
 Tue, 15 Dec 2020 19:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20201215163328.Bluez.v1.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
 <CABBYNZKCzdA5cB3WTpbfsbY8nTc9jg_7rcfEpxGi0t+fi5n4Lg@mail.gmail.com>
In-Reply-To: <CABBYNZKCzdA5cB3WTpbfsbY8nTc9jg_7rcfEpxGi0t+fi5n4Lg@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 16 Dec 2020 11:45:51 +0800
Message-ID: <CAJQfnxEeqCD1F=qiB4do6ozTAoOr8nFUaC9LjYqdw2VqQVpBmw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc/mgmt-api: Add opcode for adding
 advertisement monitor with RSSI
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Wed, 16 Dec 2020 at 01:55, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Dec 15, 2020 at 12:33 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > This is to leverage the filtering by RSSI feature on those controllers
> > which supports advertisement packet filtering. To avoid changing the
> > existing API and breaking it, a new opcode is required.
> >
> > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> >
> >  doc/mgmt-api.txt | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 1aa43d6c3c..d5c7169630 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -3800,6 +3800,58 @@ Add Extended Advertising Data Command
> >                                 Busy
> >
> >
> > +Add Advertisement Patterns Monitor With RSSI Threshold Command
> > +==============================================================
> > +
> > +       Command Code:           0x0056
> > +       Controller Index:       <controller id>
> > +       Command Parameters:     Pattern_Count (1 Octet)
>
> I'd move the pattern_count after the rssi if the rssi is not per
> pattern, well in case the rssi is per pattern then it should be put
> inside the Pattern directly.
>
It's not per pattern. I uploaded a newer version which flips the
declaration order, please take another look. Thanks!

> > +                               RSSI_Data {
> > +                                       High_Threshold (1 Octet)
> > +                                       High_Threshold_Timer (2 Octets)
> > +                                       Low_Threshold (1 Octet)
> > +                                       Low_Threshold_Timer (2 Octets)
> > +                                       Sampling_Period (1 Octet)
> > +                               }
> > +                               Pattern1 {
> > +                                       AD_Type (1 Octet)
> > +                                       Offset (1 Octet)
> > +                                       Length (1 Octet)
> > +                                       Value (31 Octets)
> > +                               }
> > +                               Pattern2 { }
> > +                               ...
> > +       Return Parameters:      Monitor_Handle (2 Octets)
> > +
> > +       This command is essentially the same as Add Advertisement Patterns
> > +       Monitor Command (0x0052), but with an additional RSSI parameters.
> > +       As such, if the kernel supports advertisement filtering, then the
> > +       advertisement data will be filtered in accordance with the set
> > +       RSSI parameters. Otherwise, it would behave exactly the same as the
> > +       Add Advertisement Patterns Monitor Command.
> > +
> > +       Devices would be considered "in-range" if the RSSI of the received adv
> > +       packets are greater than High_Threshold dBm for High_Threshold_Timer
> > +       seconds. Similarly, devices would be considered lost if no received
> > +       adv have RSSI greater than Low_Threshold dBm for Low_Threshold_Timer
> > +       seconds. Only adv packets of "in-range" device would be propagated.
> > +
> > +       The meaning of Sampling_Period is as follows:
> > +               0x00    All adv packets from "in-range" devices would be
> > +                       propagated.
> > +               0xFF    Only the first adv data of "in-range" devices would be
> > +                       propagated. If the device becomes lost, then the first
> > +                       data when it is found again will also be propagated.
> > +               other   Advertisement data would be grouped into 100ms * N
> > +                       time period. Data in the same group will only be
> > +                       reported once, with the RSSI value being averaged out.
> > +
> > +       Possible errors:        Failed
> > +                               Busy
> > +                               No Resources
> > +                               Invalid Parameters
> > +
> > +
> >  Command Complete Event
> >  ======================
> >
> > --
> > 2.29.2.684.gfbc64c5ab5-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Regards,
Archie

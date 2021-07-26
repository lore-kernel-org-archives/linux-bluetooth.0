Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 19:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E0660F6E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 19:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhGZTPs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTPr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 15:15:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5291DC061757
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 12:56:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so9763068otu.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6DpypOErffvwyFRPf4pcrfIt/wMH+Oe2sqTny35ac+A=;
        b=CUZrMxmIJf4i1BV076wA8qlkMWU2w/LxMg6BBxsWse+J2uPiZ/DfeCmEFWlKcKAd9J
         v8c5ok+dBQJT1QjcCFWq5sKRKHOeYHLWtVmj6DlMb7sUDlxKp4uBwXdbqh6qTClNm63r
         E/vMwpol1O1B9a9XeS8Uit3fQb19Guxo3ntKOpiSFEuoBtAyz8+0Y4pXtIUbEC79Caa1
         Gf2yv3g6jQlsRAeetqjoJDJOylDPSeFlewmc1zU4ovO9eZxFTB5EnauQB5vsa8DlhwVx
         BD53aqVa5mCxGo19C5qANwzYsjdegLZ33kIZv3YXYuCsJG3c+aG46lzDBFZr/5w9M1Ea
         5iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=6DpypOErffvwyFRPf4pcrfIt/wMH+Oe2sqTny35ac+A=;
        b=N5cIPU+HyviN6SnRAto8lhvvWLO9E4NCRSe3f/iTSbOVxcij1j3agdxugi/K5h0p52
         jUx2lObCeYUPLbzS54f0BaAxrOnt6l72Wpa/SWfN6L1dhxlbHhnhmIHypmgvVwX+CWfs
         QIlBojjL0wuIfcbxuSaJGn85v6djRU+2Reb+24oo/vijU5JnU+CmqIwee0hP4ovxXxsb
         kHHiJB0nWgrG9DvIwpckWyrGwOByRD35XqiKc1orq48inkhbgWBRCbZeVRs3Vt0On1YH
         3aMPCHnzTCQfCTwc/p+7+71oGPlDXenl6gnnHYpKO8W6QaHvq+iUTXkKeYI7IAq7g68t
         p3tA==
X-Gm-Message-State: AOAM530Bu+SdgaBjXa6DfRKWmtO+GMv/TpAI/qD8O3nDvBfi5aRjuaPY
        fLNOm3X1PD0dWYbNbdcZscFvb8H4X5Ulco3wZAc=
X-Google-Smtp-Source: ABdhPJyd2vAtsJLbWueF/h1F8sdxYvHITOdLZf7lqd3vNLXa8RAc7e/twK9i8G7zSZ+UGl1JgDfc/X5Xn2SvPtHKgu0=
X-Received: by 2002:a9d:7550:: with SMTP id b16mr13419547otl.309.1627329375638;
 Mon, 26 Jul 2021 12:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAJgPF1JLw40nRXyoXyuGd9hNLWCDeD4ONVM7S_CSE9wQg3gvyA@mail.gmail.com>
 <CAJgPF1JTyqom8YJSNPx5-5uecZZKwks1gnAotzwJUhz57nSpLw@mail.gmail.com>
 <CAO1O6sfBB53qMnB-K+ZLaGrrD3ZFy00Zn+u1GqTavNX7fZCzBw@mail.gmail.com> <CAJgPF1LG32ShzPsaPWC64VGRC+odvHYrUYXBiDkTdcZHH78sbQ@mail.gmail.com>
In-Reply-To: <CAJgPF1LG32ShzPsaPWC64VGRC+odvHYrUYXBiDkTdcZHH78sbQ@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 26 Jul 2021 21:56:11 +0200
Message-ID: <CAO1O6se1=cHbH=VWyysVFJcumG=aGhquvKDs83CKfhrppzWEBg@mail.gmail.com>
Subject: Re: Instable BLE connection - MTU Request, Attribute not found
To:     =?UTF-8?Q?Peter_H=C3=B6ller?= <drmedvet.hoeller@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Den m=C3=A5n 26 juli 2021 kl 18:19 skrev Peter H=C3=B6ller <drmedvet.hoelle=
r@gmail.com>:
>
> Hi Emil!
>
> Thanks for your input!!
>
> I do have to stabilze this connection, I do not have any other chance,
> unfortunately.
>
> What I fell in my guts right now is that most likely:
>  this >>>>
> 2. The peripheral could use white listing to allow connections from
> only specific centrals. In this case the central will always see a
> connection complete immediately followed by a connection failed to be
> established.
> >>>>>
>
> and this>>>>>
> If the peripheral
> responds at least once, but after that at any time it doesn't respond
> to a central's packet within the set supervision timeout, the
> "Connection Timeout" disconnect reason will happen.
> >>>>>
>
> plays a role in my issue!!
>
> However , just to be mentioned, I cannot set (or prolong) supervision
> timeout period, which was my intention initially.
>
> here is what I am able to read/set (sudo nano) under:
> root@odroid:/sys/kernel/debug/bluetooth/hci0#
>
> 6lowpan                     force_sc_support         random_address
> adv_channel_map             force_static_address     rpa_timeout
> auto_accept_delay           hci_revision             sc_only_mode
> blacklist                   hci_version              sniff_max_interval
> conn_info_max_age           identity                 sniff_min_interval
> conn_info_min_age           identity_resolving_keys  ssp_debug_mode
> conn_max_interval           idle_timeout             static_address
> conn_min_interval           inquiry_cache            uuids
> dev_class                   le_auto_conn             voice_setting
> discov_interleaved_timeout  link_keys                white_list
> dut_mode                    long_term_keys           white_list_size
> features                    manufacturer
>
> Do you have any suggestions for those parameters or am I tuning on the
> wrong place here?
>
> However, I am going for wireshark fur ubuntu now, if I understood you rig=
ht?
>
> with kind regards
>
> Peter

Someone else should reply to the question about modifying the
supervision timeout. I think BlueZ hardcodes it but I might be wrong.
Either way you could always locate the code for it and recompile with
new parameters.

For a BLE sniffer you could for example use an nRF52 devkit, flash the
sniffer firmware at
https://www.nordicsemi.com/Products/Development-tools/nrf-sniffer-for-bluet=
ooth-le
and then use Wireshark to analyze the traffic in real time.

/Emil

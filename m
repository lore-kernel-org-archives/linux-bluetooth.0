Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99628C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418E02311D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgLVK2O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 05:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgLVK2N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 05:28:13 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4EC0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 02:27:40 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l11so30844816lfg.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 02:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYKgqNkzqvID3abMuiIagsqPFVJtBgJOUAqa/JQpSSg=;
        b=Nk6NpbPTGkku1M0NX28sxZKbaBmuz8IXNnqjfXNm515tBPe0fXzr1lzpQfZpECZyI2
         7WxBxk1i5W4jkKCd5YwAS+/xr19U6BggGadEeimcOfSyHsG2/E/mSUZxlnTvLwZXimc0
         H0tS/0Hj7seta/yket+ld84SXkzlksMCatdsbvg8uksYYuWAplqzqr7eILm9ugpiHKgW
         7Kgk1fJ1P7iV8Wy4JX3WUTnKpioJeil6rWNQarR22vyqnxNLGGNVHqPMqWwKYq1av//0
         Q8GsCbp/RGCrcWNtqyWF+BwMdGHRM6XM2t9GhLAB4zgK3bm1YTpqevBSbMX+4ofKMNyf
         0JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYKgqNkzqvID3abMuiIagsqPFVJtBgJOUAqa/JQpSSg=;
        b=ARxNSx8js4paVTfo+Vfr//hvCl2U2IfuFBcG0XlM9t+eCYDGpUOnuhtERynJbITDMA
         VclTec+Dbh/gKZWGXhXwzvjoGf9asU4p1z/c1cvkcXbYnBLq25JT0Z36fhUqgkGmmGKx
         WmFDWRQleQLJz67q5vWsb1h3F3MJzheqcadpeZ4kuf0HBHGeHQqQU0AZbyrWVck+sbbl
         n5Kog8p9InOU3TsiQfX86cIQZCZY/0zaDxZB09hPSAAvMfJ5KGTdrTbte4Lw4gVo7VPU
         4WXGYngCfLlyeJXfdCs6QZZbpWgnQZt+WhcC9r607zB8N+tnVgJJ0P858KvFkQBduW1y
         LM8Q==
X-Gm-Message-State: AOAM533ctuJCO8CkOIt+BGPUdzU+Zr2ioXuUQ5ty9R9raLcqZQcv38eE
        pCJT/ANkaESoTBmHXn/ygfyb7VHwIJBXesEN47Adzg==
X-Google-Smtp-Source: ABdhPJwD+uqHfnLKSg4sZ7kz80VgF+uYXIEP3vI2UejybH/pY9fIpjnt+kPoxmAT1h64UITODeMQKsoXHAM63XzbtnY=
X-Received: by 2002:a2e:a58b:: with SMTP id m11mr9103960ljp.329.1608632858745;
 Tue, 22 Dec 2020 02:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20201216043335.2185278-1-apusaka@google.com> <20201216123317.v3.4.I215b0904cb68d68ac780a0c75c06f7d12e6147b7@changeid>
 <73E2D097-F8D4-4BFA-8EC1-C04B079F1BFC@holtmann.org> <CAJQfnxHrvnsLRDHNFWAN9uPJmWiTpE6x4YAmgs77KO6QQBFW7w@mail.gmail.com>
 <8EB5497C-1D36-42B5-946C-3CC60D6F98CB@holtmann.org>
In-Reply-To: <8EB5497C-1D36-42B5-946C-3CC60D6F98CB@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 22 Dec 2020 18:27:27 +0800
Message-ID: <CAJQfnxG_pRP7m+MKqUEJKLOXGR2aaAXKaboUXrMx+540Xcsv2A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] Bluetooth: advmon offload MSFT handle controller reset
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I've sent a new v5 patch to address this issue.

Thanks,
Archie

On Tue, 22 Dec 2020 at 18:03, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> >>> When the controller is powered off, the registered advertising monitor
> >>> is removed from the controller. This patch handles the re-registration
> >>> of those monitors when the power is on.
> >>>
> >>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >>> Reviewed-by: Yun-Hao Chung <howardchung@google.com>
> >>>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>> net/bluetooth/msft.c | 79 +++++++++++++++++++++++++++++++++++++++++---
> >>> 1 file changed, 74 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> >>> index f5aa0e3b1b9b..7e33a85c3f1c 100644
> >>> --- a/net/bluetooth/msft.c
> >>> +++ b/net/bluetooth/msft.c
> >>> @@ -82,8 +82,15 @@ struct msft_data {
> >>>      struct list_head handle_map;
> >>>      __u16 pending_add_handle;
> >>>      __u16 pending_remove_handle;
> >>> +
> >>> +     struct {
> >>> +             u8 reregistering:1;
> >>> +     } flags;
> >>> };
> >>
> >> hmmm. Do you have bigger plans with this struct? I would just skip it.
> >>
> > This struct is also used in patch 5/5 to store the "enabled" status of
> > the filter.
> > Suspend/resume would need to enable/disable the filter, but it is not
> > yet implemented in this patch series.
>
> just do it without the nested structs. I think you are overdoing it here.
>
> Regards
>
> Marcel
>

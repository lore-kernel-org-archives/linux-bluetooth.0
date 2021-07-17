Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93196C636CA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 13:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7228E6115B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Jul 2021 13:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhGQNiI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Jul 2021 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhGQNiH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Jul 2021 09:38:07 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC60C06175F
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 06:35:10 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id n61so4778702uan.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Jul 2021 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prMbdjZsxOgJbK6uUoKMbaLY4SrWw8gmg6+Jlty6xBY=;
        b=GO4jrEsNa4mBOxumLQ7ESBVxz427YiDmZDUOuX/1sx9BclFjQw0SeRYRSeQoG96PIW
         +xl+WmG6ZoHAfCA2dxd8Bh/yfaSZGnZ/swzFNx2Zrr2OX5AHM6DjlDprZaThJA8NwRbY
         WqJSCkLPbLZeB9okQ5zKEzV2VpP9VuPDilMBnBXHyra/Oy0x3WJQoL0lvaUiHMD4oEbD
         LER0L7hO1wnP0pcNhxol1tjN0D64olfWfxaJiz3ZIeFAe+O4cWkxdpPnKRk5DrasQnky
         Zg3TEhKLdIDlxHzAJGAQmv7ZghWzQ+dObkCNge8HzJ1MbPmxehOpQ2PV6BLUaxPzAHyt
         l4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prMbdjZsxOgJbK6uUoKMbaLY4SrWw8gmg6+Jlty6xBY=;
        b=VpDyjpDG8mFyNYNXpiSewVpleTnaHhi68BIV91dXfyZI17NcN2vN8zAb7TB1/ZFnZt
         hu6SX35BsHLDSlqpxx8Su3rE4mhiXVPfj9WCAvLF2RiAegIE+jg+WyULK1IY55EIoRud
         2A+SRODfrrkG2wukgDrB590QHzuRE/XTG4K8Kpm2ihC5Pzcttu9RuJr5iHZzdDjU/X2d
         paZZtjqpgey6Ts6rku9r/mzn2pgRlPTu0WthvzeTjaX26BX5xbigkCg2rS008QCaLr9F
         hkKUp1MqmXO4Bmm8v/9gaPkIveZZ0VYlvzETRIGnIfJtOXfFNArJf5kOpjkWJgRH9sqY
         9Q8Q==
X-Gm-Message-State: AOAM53299pHJjFnX04UD+Jl4yw0BDAI4BkR9TIuLcRjiD9zIm2mDkalN
        4wsY4K73qS7L8kPgCerkEsQ93OmGHHAvxc5PE8TJMA==
X-Google-Smtp-Source: ABdhPJwsRKiCBzAwhhdvQYIouAsViI06GDp+fGSjLxy3u7z669i3QV2p0ex+LvNCfG5qt49+jnmlgGKBhVTJzvqFeHY=
X-Received: by 2002:ab0:7c67:: with SMTP id h7mr18894262uax.61.1626528909223;
 Sat, 17 Jul 2021 06:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
In-Reply-To: <d43dffdc43a40782ec6d5d6c24b1638005992a8f.camel@iki.fi>
From:   Joseph Hwang <josephsih@google.com>
Date:   Sat, 17 Jul 2021 21:34:57 +0800
Message-ID: <CAHFy41_-EYBNnKyLPof40r6jhtBW=mSHjOX6O=+hzLCbf7_ELQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: check SCO MTU before enabling USB ALT 3
 for WBS
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Hilda Wu <hildawu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It looks reasonable to check sco_mtu. My suggestion is to use
hci_packet_size_usb_alt[3] instead of the magic number 72.

Thanks,
Joseph


On Sat, Jul 17, 2021 at 1:58 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> Some USB BT adapters don't satisfy the MTU requirement mentioned in
> commit e848dbd364ac ("Bluetooth: btusb: Add support USB ALT 3 for WBS")
> and have ALT 3 setting that produces no/garbled audio. Check that the MTU
> condition is satisfied, and fall back to ALT 1 if not.
>
> Tested with USB adapters (mtu<72, produce sound only with ALT1)
> BCM20702A1 0b05:17cb, CSR8510A10 0a12:0001, and (mtu>=72, ALT3)
> RTL8761BU 0bda:8771, Intel AX200 8087:0029 (after disabling ALT6).
>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  drivers/bluetooth/btusb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9855a2dd561..3ee66e415c4d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1763,9 +1763,11 @@ static void btusb_work(struct work_struct *work)
>                         /* Because mSBC frames do not need to be aligned to the
>                          * SCO packet boundary. If support the Alt 3, use the
>                          * Alt 3 for HCI payload >= 60 Bytes let air packet
> -                        * data satisfy 60 bytes.
> +                        * data satisfy 60 bytes. USB Alt 3 support also needs
> +                        * HFP transparent MTU >= 72 Bytes.
>                          */
> -                       if (new_alts == 1 && btusb_find_altsetting(data, 3))
> +                       if (new_alts == 1 && hdev->sco_mtu >= 72 &&
> +                           btusb_find_altsetting(data, 3))
>                                 new_alts = 3;
>                 }
>
> --
> 2.31.1
>
>


-- 

Joseph Shyh-In Hwang
Email: josephsih@google.com

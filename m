Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE0CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F25064F60
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 19:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhCDTAf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhCDTAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 14:00:23 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3421CC061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 10:59:43 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id t16so8773445ott.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 10:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMOONwQNyqrWsPKCTpgC8Z4IVeTjr8khz7KQ2lqmPRg=;
        b=IYZlLOFYF8tZu4j1V66X8Z2o4cr9ZhjvhDDnk4w4alnB6LaEE8LuKCBYU/6X5hpOi7
         yqjHMJ1T5/fEhO5opAoo++NfASjqkHWnv2dIjVG19Yo8qLWuFvrn/1rXjjiIHM+Y7d/F
         1l912ui1pPWnr/921ztUMkP1gUbjF44759b0IObT9NHuFOlr8psAdTLpAVLcDPQxcBY5
         0wrKUWX4fa3fHAlg67fNUNoby76oa6mxaJPlN+ubBqYgiPdMt8dW8H2v7fBzxA1+ugiQ
         UgR5IukSTRoUL4mlI2xrSq+Uwn/MV3kHVi9w2aG+iJ3mlhIix8KsCims1CsfqTlIGE8M
         MRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMOONwQNyqrWsPKCTpgC8Z4IVeTjr8khz7KQ2lqmPRg=;
        b=Y1fvDbtbzLdZ6WplgQ/pF6owE+0Hi9hh/VKFMf2Zk9DR7fPNzWEV6yJMgAZdwDLCj/
         NJHrwA3Z2oOuQiGDJ1kjkyjMDGIS30lLxF9B2vy83W7pd1sR6B1NbgbzMAY2HNGs5XeH
         EF/dFPqjX/MWFXZtNSpZVUeHAeSfBQEB5saUt9RivwVjLauptY/tno6/9i0hutJaNx9i
         CBPOkkhcxEMoJ05O266ibMkLinNc0lE5ywH10zD12YYbR8xUmVXt2WHXwkvt8y1+/2on
         ApPhOa0+rip1RDqZl0NayzEAY3ZhT+9DwgdbUm7xqAJbGpeZ5xg7zQ7eKO7/PXkB5Ip1
         RKWQ==
X-Gm-Message-State: AOAM5316QaKX5myVGnLY9Dh2jvybiyTr8e2Pwrj2m/DQ2ABeVDUoEmCN
        GYq0wR6p7ciR15HIkbBGh0Zpr49bRihSl3xJxS4=
X-Google-Smtp-Source: ABdhPJz946JArF1E6LyLpwecKDzHCwbnMtAPnaRScFF4g9yhkr/X3nzNf+dW1jkUvO/3mIAOum6hRkf5Gzm0CDrRhL0=
X-Received: by 2002:a9d:69c6:: with SMTP id v6mr4649270oto.371.1614884382480;
 Thu, 04 Mar 2021 10:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20210303192012.1695032-1-danielwinkler@google.com> <20210303111817.Bluez.2.I45b896f4512038309cbeab7a01f51e503141edab@changeid>
In-Reply-To: <20210303111817.Bluez.2.I45b896f4512038309cbeab7a01f51e503141edab@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 10:59:31 -0800
Message-ID: <CABBYNZ+NtxCwE5XWwKEGOXtyvgb4GUm0A4Pstwj2sOd9fVx8Gw@mail.gmail.com>
Subject: Re: [Bluez PATCH 2/3] advertising: Create and use scannable adv param flag
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Wed, Mar 3, 2021 at 11:20 AM Daniel Winkler <danielwinkler@google.com> wrote:
>
> In order for the advertising parameters hci request to indicate that an
> advertising set uses a scannable PDU, we pass a scannable flag along
> with the initial parameters MGMT request.
>
> Without this patch, a broadcast advertisement with a scan response will
> either be rejected by the controller, or will ignore the requested scan
> response. The patch is tested by performing the above and confirming
> that the scan response is retrievable from a peer as expected.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> ---
>
>  lib/mgmt.h        | 1 +
>  src/advertising.c | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 76a03c9c2..7b1b9ab54 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -507,6 +507,7 @@ struct mgmt_rp_add_advertising {
>  #define MGMT_ADV_PARAM_TIMEOUT         (1 << 13)
>  #define MGMT_ADV_PARAM_INTERVALS       (1 << 14)
>  #define MGMT_ADV_PARAM_TX_POWER                (1 << 15)
> +#define MGMT_ADV_PARAM_SCAN_RSP                (1 << 16)
>
>  #define MGMT_OP_REMOVE_ADVERTISING     0x003F
>  struct mgmt_cp_remove_advertising {
> diff --git a/src/advertising.c b/src/advertising.c
> index f3dc357a1..38cef565f 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -945,6 +945,10 @@ static int refresh_extended_adv(struct btd_adv_client *client,
>                 return -EINVAL;
>         }
>
> +       /* Indicate that this instance will be configured as scannable */
> +       if (client->scan_rsp_len)
> +               flags |= MGMT_ADV_PARAM_SCAN_RSP;
> +

Don't we need to check if the flag is actually supported by the kernel?

>         cp.flags = htobl(flags);

For new code it is prefered to use the function from src/shared/util.h
(cpu_to_*).

>         mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
> --
> 2.30.1.766.gb4fecdf3b7-goog
>


-- 
Luiz Augusto von Dentz

Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAADC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 17:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD8B20899
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 17:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDNoyS0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgE0ROj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgE0ROi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 13:14:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D41C03E97D
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 10:14:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k5so29834606lji.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rZsytVPueWYb0svQ8G27WH6Q3kHb47vgODUouiNfk3Y=;
        b=MDNoyS0Od1/CzbGLDZ1eWLMT/SXP2dTovlr833cXNYR05wXi3dIVTo0f1WAUlrXHvl
         KP+O5jB44nvBw296VDnQHxB/TYFlUmrXqh9g2Lm5msbcGzHKGcnd/1B6q0D48zVzAhqh
         RMZnCi3du8xWDH3FQtkc3fEbtH9iqYmJP9W/FibVdAGqgLhwy1eq9WI1kgEe67z7Kjyj
         IlbDdJeQKJGPKRMrQ9FFA8xdNf7UNDR9wfEbp/YcR8OIBQFTqhLgB6f0jM/rrAjumQnP
         oItMSlvN/ynHAhUOM1VnadO+/2czX8aGFR2/0bn+PXuji8jb4v1GIDqE0PRj97CpCCUR
         b0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rZsytVPueWYb0svQ8G27WH6Q3kHb47vgODUouiNfk3Y=;
        b=crsL0C6nhvCt2wglaXX88YZYQfgSeBLozWieT7XJffkd4wvLdpKBHV3m6rZn7KY1hj
         HfmvzJw01hqluSvKkxRlu467MREVvQR2LlW86AidLpzVRvnvGiecsxkSZ9YKoNLV7d6+
         e7Fy30miMjmnLztF5bnK5TYpEjnyX2ReX6eCF+pDn330A3oGrryIcqr1KtUX7ryE4HXk
         zm/zQ+/cINONT0b+v34+LT7wU4rsGvuza3dqCEisZ2ycAhIu7hFVkZZ38CQGtVgny886
         jHZG4W3B1wJ+LlnB2EqahltzeSf2gAK6MGlCfO25/Or6jBJb8x1K6UcLITL7fgZcOHO7
         W+EQ==
X-Gm-Message-State: AOAM53023ZPfWD555NRB67/2mVZB2xrGnveZLpxUn0dhrRpTtgTzYGE+
        qcUtXJbdyNA0sADCqBfOvuyK6Gl4Vbh0m9vd8gZ71w==
X-Google-Smtp-Source: ABdhPJytQjhCNdQfAZEkhvSb2PxUn7KL310S3etCJ8fld53TEPbscLAohn19xVscI6ywQpg6aSHbuuq32Y+Ny5Ki0uQ=
X-Received: by 2002:a2e:898c:: with SMTP id c12mr3910080lji.200.1590599676560;
 Wed, 27 May 2020 10:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200526193314.25036-1-luiz.dentz@gmail.com>
In-Reply-To: <20200526193314.25036-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 May 2020 10:14:24 -0700
Message-ID: <CABBYNZ+vky1G6y4Aq3or12QANZC0h2sxk_xqhu26SQqE30tRiw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] advertising: Fix advertising flags
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, May 26, 2020 at 12:33 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When an instance wants to force being discoverable the code shall
> actually check if the adapter is in general disverable mode already and
> if not set BR/EDR as not supported so that devices scanning don't
> assume BR/EDR PHY is connectable when in fact it isn't.
> ---
>  src/advertising.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 45ff19fa0..829c481f6 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -697,9 +697,12 @@ static bool parse_discoverable(DBusMessageIter *iter,
>
>         dbus_message_iter_get_basic(iter, &discoverable);
>
> -       if (discoverable)
> -               flags = 0x02;
> -       else
> +       if (discoverable) {
> +               /* Set BR/EDR Not Supported if adapter is no discoverable */
> +               if (!btd_adapter_get_discoverable(client->manager->adapter))
> +                       flags = 0x04;
> +               flags |= 0x02;
> +       } else
>                 flags = 0x00;
>
>         if (!set_flags(client , flags))
> --
> 2.25.3

Pushed.

-- 
Luiz Augusto von Dentz

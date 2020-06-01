Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4981AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 16:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5802073B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 16:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR8Jtg3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFAQaC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQaC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 12:30:02 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CFEC05BD43
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2020 09:30:02 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k15so5026314otp.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2020 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKs2RNIXjZ4g918KQZTpNZSOkCD2Zpqkt1cEiqVrdQw=;
        b=cR8Jtg3lj+2RLc51xs6H/OXSSM3C6VzAVxiequ47Q1IbeFz7wuUDeV9xxnyIlgY1YO
         dWjD2SsSaPWMQLnmpn3XsEHPdMkWOeKMA3Mn8J5l+iPQMsL8lkrs/QdrVL6gaRxLGVMA
         KqigPYYGLlKej7Eflou27/qw3KwZjlwaJ83l1vfvyWfWCHdy8am9o7/Kpi++3jMro6qB
         2FJ3Z4A/jtE/w3v/OZw+CsxX4vNFawtk7Au9Av97T+bE0R/0B2BdcdihLcL4o+usCu1d
         G1btLGpw1zOVRBoYDUbHWekhYjE7RSLM7lf5F3k5UBUGv5QIkl2iGafxsv9WwT0xl/ms
         qqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKs2RNIXjZ4g918KQZTpNZSOkCD2Zpqkt1cEiqVrdQw=;
        b=eH5WH7PC50iZ+6waKX9Kkkot70m2CboJ1Gqd7iNeNN4ImhpjmSL31AgGeAvMYZyoLU
         l7nYR660DXlHhaEZ0a5GDNY2yEsd6GEBC0HpQWYjKPEAjmFSYu3c1ol9AydHDbDGzFWe
         cSupv0xYuiQ931TH6dPmMjv5/+vrdWJn/fIiUDIZB5Qi4yfXp5jcyXLWdeTWuaT9A/W2
         3Vr049iCjxsMifFnOkB/wJnQtrzgD+/EBB7ioey33uBM4s0E00UMdp1ixM5vUjqBc4tL
         wEJqrBXE3yiVWzEdATtwV4fBZkfNtW1ZUEynzMNO2E0MDca5spPwEkXBLW4pnMqrhQH2
         WCpg==
X-Gm-Message-State: AOAM530MvA9bymA8qh4YVHYPVkqVlwtpUY3oUaLUD0BU8vxWi2lPHM8y
        IG4u7mZqY2XVFsXsSjR1L6Rf7t5iOV2cLRHcv48=
X-Google-Smtp-Source: ABdhPJwyB34523RHlP9ccWgtg86FLRTfmS6PjYGzydOnOYPWnEsCXVVqGFuySJUMxtfQFLLGOx40AL3ZQDHZUXiAsi0=
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr18007514otq.79.1591029001710;
 Mon, 01 Jun 2020 09:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200530085118.10703-1-sonnysasaka@chromium.org>
In-Reply-To: <20200530085118.10703-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Jun 2020 09:29:50 -0700
Message-ID: <CABBYNZLK6H6oPRgY53x0D=EM3HbJyE5aKy2FBgvOUnQk6qCiBA@mail.gmail.com>
Subject: Re: [PATCH] a2dp: Fix ref counting bug of setup_unref
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Sat, May 30, 2020 at 1:56 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> In a2dp_reconfig, setup is ref-counted by cb_data. However, in the fail
> label setup is unref-ed but cb_data is not cleared. This may cause
> double unref in the future if cb_data gets executed. Instead, we should
> do setup_cb_free to clear cb_data and unref setup.
> ---
>  profiles/audio/a2dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 0d877b132..1b92352cf 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1719,7 +1719,7 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
>         return 0;
>
>  fail:
> -       setup_unref(setup);
> +       setup_cb_free(cb_data);
>         return err;
>  }
>
> --
> 2.17.1

Applied, thanks.

-- 
Luiz Augusto von Dentz

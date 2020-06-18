Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CEEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 04:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03108217A0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 04:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U64yTdFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgFREi3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 00:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgFREi3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 00:38:29 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F4C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 21:38:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a21so3906668oic.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 21:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8r1OH+uUbWSBJiX7OSVuf0HNyzobipC/Wk5oB6lFas=;
        b=U64yTdFcERlATolea51eJ0+cUXCRdO4HCnNu/s2HIiJhvNshQmjDMyyf0ss5RotDj0
         JjGFm2wcFpLXUcsz+iZkL01Ob0m+nU0/s8eqWYHvLeAB9dIq1IeF0NjStcUmiutB+rXN
         8MtWqFMCNt3skICXQp9YM99H4jlUKfS6JGxN/xGl96Pj0IMomU7qhDSlF60s2OlMq32y
         0iOWUQpqxdoTIvs0sjRoFEPAEsoEMw+4LI9dOwF21fcHqhQtW+jArBD5+zAPnWUPcOLM
         8R8ijkOT7aVVec786eHJ80UxB6Xe5i8VKrxYyIEEL4kzXIreaU2cJSS/si/fxqmuJNm0
         j0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8r1OH+uUbWSBJiX7OSVuf0HNyzobipC/Wk5oB6lFas=;
        b=kuEnoNDHd3Kl/i2cB5op/M2yLhKrRC1lG8r+8Ky+RAKDJH5Rg6zl67jpKNq1g0jKbh
         JKP8WMp3kLn99slifW3IGCELHBcrPXYVo/k8hSPNiN2AQOXXViFLSzF7ZaGthTRR5Z2z
         AlyikXatdfICQq4iHXuEdO2kHESRvYQ0ZhDY/MEXVj1lmFTy+lSPJi+YBQY52IFcyq/n
         OVn3rF33JPP/kKqT6MKRYPlENx36p2+QIr3P6ZjBC5UkRjkAnNqknx6HTmc8DUzj4Tkl
         CRGCK70AnVfhuPmUGBxCCsIicguncNGw3oLgeeEnxa4G3kyq09l7PZCm75uIV8rt8k6g
         D5ow==
X-Gm-Message-State: AOAM532WCxCA03VVqS0CFRbtkUWcEqyJoe5f2jzhQW9svs6lOhuQjp4u
        6TWipw9GeUZEPnQo16LCbbKNSK7ge9dEAmDGC9d9+g==
X-Google-Smtp-Source: ABdhPJynD3MYOY7fWKYhykNIvLhP3T/U1upHRyqXFyKaOs/pUDE9V3ky5Mfr2S/+TnhY+1OuE4vb5Pz+1UQhT0tKE7c=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1500323oib.48.1592455107771;
 Wed, 17 Jun 2020 21:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200618014812.234606-1-alainm@chromium.org>
In-Reply-To: <20200618014812.234606-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Jun 2020 21:38:16 -0700
Message-ID: <CABBYNZJazkorL2ea7C+P95y769qVUuRC9YO8XXOCob7CzuSL9Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH] main: fixing logical error when loading controller params
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Wed, Jun 17, 2020 at 6:51 PM Alain Michaud <alainm@chromium.org> wrote:
>
> Fixing logical error when loading configuration parameters from the
> config file.  Without this patch, the maximum allowable value is always
> used.
>
> ---
>
>  src/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index e51f614b3..75ea27f40 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -421,12 +421,13 @@ static void parse_controller_config(GKeyFile *config)
>                 int val = g_key_file_get_integer(config, "Controller",
>                                                 params[i].val_name, &err);
>                 if (err) {
> +                       warn("%s", err->message);
>                         g_clear_error(&err);
>                 } else {
> -                       DBG("%s=%d", params[i].val_name, val);
> +                       info("%s=%d", params[i].val_name, val);
>
> -                       val = MIN(val, params[i].min);
> -                       val = MAX(val, params[i].max);
> +                       val = MAX(val, params[i].min);
> +                       val = MIN(val, params[i].max);
>                         *params[i].val = val;
>                         ++main_opts.default_params.num_entries;
>                 }
> --
> 2.27.0.111.gc72c7da667-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz

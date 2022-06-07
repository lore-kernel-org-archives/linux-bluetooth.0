Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D66C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 05:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiFGFeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 01:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiFGFeB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 01:34:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2823CB716C
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jun 2022 22:33:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e9so4155916pju.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jun 2022 22:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyxY25byEgH9PupGgRfXpgr6xzg5W4K5+h4sm2X9mxs=;
        b=PPDfKeVHjScLHvr06n11D9khp+Ud+obtP+9KhWZeVWNy1VHhcvZzOAXXlq2HFtYHEo
         lNb8QCxuzJ6qRNOhkrkF3GfS39AmUYP6mL6HyFvIi1OWkRiNc0u34Fnrj0QsWsiRCPH1
         FuoIEOXkZigr/TEPAHSkseBQ+7SZE8fbDEyOBTrS00aI0zQytfXjE0u+pJ7XduYKHWpp
         DKNjV5HQ9M8xo1In4kzhQ29W4yUETpS/C98J2WCvUThFYA4fahSS/xzuxtv/TskkT+aH
         scMmravcxfuL33NCnDtI6gUWB3XHyG3UkDcZdKuDY/GtvzvaeJhtgS5MHvT1adNAYWWr
         GFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyxY25byEgH9PupGgRfXpgr6xzg5W4K5+h4sm2X9mxs=;
        b=YQH2XNXcgnHxdSS3JtWKtE2ZAPTt1JH4Ks4YfVPL8oLamyTLPlbNL5BDYLVsPZDT8P
         YDsc2AdgrK/EmoJeqCnqy0fXAu/j/l3Ph+IH/TipBuifCTlAH6z6/5RUA1hAGKrfm5h7
         csI1XByAlC0W9UWKLHBt88gTqEJcLwvjUwKQ/0J4cRJHtMTVO7hbpzXellN+8MvkyA4P
         Oi+OKDljiKvknn8+RKhRqgtbVxVY0WFNIwxqmCDM4wINtbxnCiGqSPsMVyTuO4Xw0lwS
         pwQwqzfNioSiw7X87hdYHASAb4aPFLSjfYu+M9tpaUmeOcq6asJK/rADe/Axc60BSA7l
         jRgw==
X-Gm-Message-State: AOAM533N1XtuZALBDuyJTXsW0sittSvVVjvnV+HxZcSQk8KzomX3y25i
        /22ySsFzpKjGk82TLnbVkK5FhE0QioUPvXh/rPXAZ/LU
X-Google-Smtp-Source: ABdhPJw6DMSCOt2efrT2HrwOMM5Bx6hll1sd0ULKEaLUHz58sZaJCmKmYm93fDGVkvS/8aFFApB4JWGq4Unk15OGE8I=
X-Received: by 2002:a17:902:7884:b0:167:4d5b:7a2f with SMTP id
 q4-20020a170902788400b001674d5b7a2fmr20160425pll.18.1654580038503; Mon, 06
 Jun 2022 22:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220605122927.110627-1-pav@iki.fi>
In-Reply-To: <20220605122927.110627-1-pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Jun 2022 22:33:46 -0700
Message-ID: <CABBYNZJ4f-wxZwPdYWzxQWHfG+x46HMiPZ=TmG7S74DGhPVW2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] a2dp: disallow multiple SetConfiguration to
 same local SEP
To:     Pauli Virtanen <pav@iki.fi>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Jun 5, 2022 at 9:47 PM Pauli Virtanen <pav@iki.fi> wrote:
>
> Using the remote SEP SetConfiguration DBus API, it's possible to make
> multiple remote endpoints use the same local SEP, if they are endpoints
> from different connected devices. This is invalid: successful
> configuration shall prevent a different device configuring the same SEP
> (AVDTP v1.3 Sec. 5.3).  Moreover, this breaks the assumption in the
> AVDTP code that each SEP has at most a single stream, and causes
> misbehavior later on (subsequent transport acquires fail with EPERM).

Not sure I follow I follow why it would be invalid for a stack to
enable connecting the same local SEP with different remote SEP, afaik
this depends only if the underline codec does support multiple
streams, as far I can remember the folks at BMW were actually the ones
proposing such a change back in the days so perhaps something broke
the proper support so we should be able to fix it. If, and only if,
the codec itself don't support multiple simultaneous stream then it
should reject the SetConfiguration by replying with an error.

> Fix this by first checking the SEP is free before proceeding in the DBus
> API call.  Also add a sanity check in avdtp_set_configuration, to reject
> configuring an already configured SEP similarly as in avdtp_setconf_cmd.
> ---
>
> Notes:
>     E.g. trying to set the same codec for two simultaneously connected
>     devices for the same adapter in Pulseaudio, causes the A2DP
>     connection of the first device stop working, as its transport
>     acquires start failing with EPERM. Disconnecting the first device
>     also breaks the second device connection.
>     This patch fixes it so that only the invalid SetConfiguration fails.
>
>  profiles/audio/a2dp.c  | 5 +++++
>  profiles/audio/avdtp.c | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 6f5b13711..f3e2cdd9e 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1843,6 +1843,11 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
>         GSList *l;
>         int err;
>
> +       /* Check SEP not used by a different session */
> +       if (lsep->stream && chan->session &&
> +           !avdtp_has_stream(chan->session, lsep->stream))
> +               return -EBUSY;
> +
>         setup = a2dp_setup_get(chan->session);
>         if (!setup)
>                 return -ENOMEM;
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index da4114e0f..bc7afad81 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -3523,6 +3523,9 @@ int avdtp_set_configuration(struct avdtp *session,
>         if (!(lsep && rsep))
>                 return -EINVAL;
>
> +       if (lsep->stream)
> +               return -EBUSY;
> +
>         DBG("%p: int_seid=%u, acp_seid=%u", session,
>                         lsep->info.seid, rsep->seid);
>
> --
> 2.36.1
>


-- 
Luiz Augusto von Dentz

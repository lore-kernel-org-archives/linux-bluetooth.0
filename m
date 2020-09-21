Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17CC4727D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 23:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4065F23A65
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 23:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm6XHRuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgIUXC5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Sep 2020 19:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgIUXC5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Sep 2020 19:02:57 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50EEC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 16:02:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m7so18934896oie.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2020 16:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jIpvO3JBFKmFmDmgHQ+JYCNJpS0NlN/6NqbpCynEYPs=;
        b=Jm6XHRuIGVjJ/J+SEng04dSRuY4v74HvyQncP/xU7H6gsskGsldyDmYFtcxdjesr09
         Guepsvtcqnzk83QwP4zbGfqDoJBg10vOvBmlxDpyDTymeUMyLkdFvdiwKJToBw165nEe
         HM9b9W6l6EjctuWnVjkfXwqS8PNxlR2u/lQYwiw3wjFw9pjoBXR8x61WTQ22zk97X7pU
         xw6xrzg/7KJL6dXTEPIU6qjIhZHuNDMK6SAxxJ4zk8fwV2oEApQb9MsbULsLvsNATINE
         1CMs4Vn92L8fQhnVnpxkeLuNRIxFZ7QtFfJcMaHQEPIl/ZoFOhwyJf5lkDO9cIqECndy
         A6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=jIpvO3JBFKmFmDmgHQ+JYCNJpS0NlN/6NqbpCynEYPs=;
        b=VLjJdLOd9D4QscL7i8MxDaphkNbUDkvD9hxQbJR7ZzycWvyNNZ/k/zfFhnZzK9xP7R
         TiTsm4ch6vUrbmo+7bSUkVHHEyKTjFai7WDRS1TaNVoOd0hRSzrqZ4cTrSsX2RX3FdQx
         3I0L/0fy0Go6JWhstMTSMSvshNEb6siUHrp9qV2N4iY/VvgHfMuiLbmirFwlnS2TEUbF
         ogxUDyx223P+08/S4TQj9JIOXMO+bVydWwhxEZIH3Q0ndmrK/TV7h+2Myk6FjiLIWmqj
         gQcDlY6KjrvnK8S3rp0NPHVSR6kxdNnrN/E5OQZ7xKgjOSS0qnw1/9kqv1m09+04rJsH
         Bvkg==
X-Gm-Message-State: AOAM532gI37Wzhv7LqFESVV+ZyM4Td/ojGLV2T/KsH3wksYnU5UrJqme
        o+BTzSSbGgJaHgFmYi8XC71m5u+67zGqlz34bYOdkJvk
X-Google-Smtp-Source: ABdhPJxl/T+udIPnOSyW5u4ATnf9awci9wmi49hkgMSTq6T+2aeGb53SODfpmUNGvOVbyn0IFBMJQyoHSGLXXko9JVw=
X-Received: by 2002:aca:3e08:: with SMTP id l8mr942302oia.152.1600729376768;
 Mon, 21 Sep 2020 16:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200918173436.3184738-1-luiz.dentz@gmail.com>
In-Reply-To: <20200918173436.3184738-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Sep 2020 16:02:45 -0700
Message-ID: <CABBYNZLuWifcGnf-LbquAu5+9bPb6Ft=TgzAGSLB-yXMXqMSRA@mail.gmail.com>
Subject: Re: [PATCH v2] avdtp: Fix not checking if stream is already set as
 pending open
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Sep 18, 2020 at 10:34 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> When receiving a Open command the stream will be set as pending_open but
> the remote may attempt to send yet another Open command in the meantime
> resulting in another setup and yet another timer leaving the old timer
> active which will likely cause a crash when it expires.
> ---
>  profiles/audio/avdtp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 782268c08..e0c6f44f0 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1687,7 +1687,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
>
>         stream = sep->stream;
>
> -       if (sep->ind && sep->ind->open) {
> +       if (sep->ind && sep->ind->open && !session->pending_open) {
>                 if (!sep->ind->open(session, sep, stream, &err,
>                                         sep->user_data))
>                         goto failed;
> @@ -1699,11 +1699,13 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
>                                                 AVDTP_OPEN, NULL, 0))
>                 return FALSE;
>
> -       stream->open_acp = TRUE;
> -       session->pending_open = stream;
> -       stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
> +       if (!session->pending_open) {
> +               stream->open_acp = TRUE;
> +               session->pending_open = stream;
> +               stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
>                                                 stream_open_timeout,
>                                                 stream);
> +       }
>
>         return TRUE;
>
> --
> 2.26.2

Pushed.

-- 
Luiz Augusto von Dentz

Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82243C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46484206FA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ/9wXpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHaRQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgHaRQl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 13:16:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36FDC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:16:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z22so1613692oid.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXz+RjXMfOPYNS9vVem6858n/gkouE3nAc/3H+2U+Tk=;
        b=GQ/9wXpjc0tG0WXMbdmJbK2/qGlNtu2uP3Cm/QQHFUFgReBiC5V/uUooSfTF13vbCS
         axsHJvXEFNjwpcyWMGPdHs3FX9/04vGTf0yZBxnylEI+IbgLVb2U8dXS/LK+2pehuVO3
         LxJePSYXFxmEdjR0NTMBR4hJ2HGwcKveQ5ESPJFxzpbAurGyIJBT9Z9Q241xBi1I/4ft
         YzCkPm5ynrTWmzLVf7knYY3ZFW9MI4mdSbJvDhhV0T5SimEWei8k2kzuKrT/Oi+UOgeF
         cdEQOOYy8T15f6pTH5Zh8GkrDsD9ggS4D/oEAxHV8HSei3VwsEO9r4GiGNSjZMrgBCtH
         pbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXz+RjXMfOPYNS9vVem6858n/gkouE3nAc/3H+2U+Tk=;
        b=Fj3/8r4lhR6jBDdNLwya26x3wFDK3wLDe1IHa+4a4bbw1K9l/b011d8z1i8vEojwzA
         ntk6SDeKyEKDkeQD86q9WBov+NzDkUe2AT39Dibz7UiSe7BGCdbDd0TyUituxZoWSYMH
         Xjmi02a9um8sGsFn3HFycmzEp8777XGMIuSwrqu0n07mJwp+POv9PA6QEnx/UHhYepMD
         XDQdeMi2w/2SjTvMsJGGhRcz9wI+VfAVI1gmxPW6xNmFBbwjA471cusDVB0b890GUsRM
         fzTMwfyyRLe0pGMX9ZfzeZjRGShvX52rshmAxwNjbBMqMz5ex/T/R7CudauqidQpUBjh
         MC8A==
X-Gm-Message-State: AOAM532bNP1bv7cje3IJ7MxD7vAEY7IPVilZKqhgjPsQFILnPl5/MkmU
        DXzXkCoJglzwxHLMColXvtdIA4FKWuE2g3HkPA1RXUnK
X-Google-Smtp-Source: ABdhPJzXNd+r8tQo83V7t7ymY1VwlOZcbmGI0BCGOUOmkLOhNYS4cISq6SNHtqlnSQZuoMZDxuYLipnlSpuxagvqT70=
X-Received: by 2002:aca:a9c9:: with SMTP id s192mr220457oie.152.1598894199341;
 Mon, 31 Aug 2020 10:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
In-Reply-To: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Aug 2020 10:16:29 -0700
Message-ID: <CABBYNZ+Q84vmEDgfNuoYXAAMi6T3segO_hSkG5Oufc5F_w9Qeg@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 1/2] doc/media-api: Add Press method for MediaPlayer1
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Aug 31, 2020 at 12:37 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> This allows us to send any passthrough command.
>
> Reviewed-by: Michael Sun <michaelfsun@google.com>
> ---
>
>  doc/media-api.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/doc/media-api.txt b/doc/media-api.txt
> index dabc69936..fe7222eef 100644
> --- a/doc/media-api.txt
> +++ b/doc/media-api.txt
> @@ -199,6 +199,14 @@ Methods            void Play()
>                         Possible Errors: org.bluez.Error.NotSupported
>                                          org.bluez.Error.Failed
>
> +               void Press(byte avc_key)
> +
> +                       Press a specific key to send as passthrough command.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                        org.bluez.Error.NotSupported
> +                                        org.bluez.Error.Failed
> +
>  Properties     string Equalizer [readwrite]
>
>                         Possible values: "off" or "on"
> --
> 2.28.0.402.g5ffc5be6b7-goog

For now I would prefer to use dedicated method per key or are there
many keys you would like to use from the upper layer?


--
Luiz Augusto von Dentz

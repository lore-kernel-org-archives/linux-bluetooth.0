Return-Path: <SRS0=gY20=5B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6366AC0044D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CAF20679
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0eklOvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbgCPU6K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:58:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42949 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPU6K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 16:58:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so19374794otd.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2p+kt+gi7mSwR21kEdKeJj/xtKUzlw9AhJc+uvOCNA=;
        b=S0eklOvbcosWStObSU9Szzy4IvLjwCqirFsGDfOeI+CDc/73GBENPs78RIESnOTAh/
         mW82VStby+qvTbur4vNPtFDkYRHj9aqQzBCTdspjz9+wwtCZdRF3nLqvzW1cEP1DH9Jq
         aOiLSukn+Vq0BVJ3EoMYBDrzrcT1nyGi51tm8I6msGZbbAfx8KEnSIhpQ+MjfU4KcFA8
         t0WO1/jSxAZfXG+9Vwb9Kg+0XuyDmWL2T/ElFlITz9ZNS1cEt5z3HUgdQ+LsgTmBMZS+
         QFCI5yCQffkrWoBNqNCWD5ZORM6rZoZwiGltFRuLFZY6pIrwJsr9PpYZRsax+ML4aXOw
         riHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2p+kt+gi7mSwR21kEdKeJj/xtKUzlw9AhJc+uvOCNA=;
        b=aUuHzYdCivc7ZGu9B9ODZWKGwyJe0wO3Z2pV4reh9OoBmjuexS1X9l2U+fGPjIhiBA
         Hhu9zTAkoA4soMHHSKvLe3VIPWhB67NNAkNeiYAo4raHL+TyNYEIlNZm9dyqeVrxxxu7
         rnYexGlEiy2lmtgPzRCGksyEuX9+eVVDVFFbtN3Hz04/Ve4CwlaIFrlTkotYeT6pA/JH
         D4SeyI7j+KU5myBsUqbUjjDikNaXokhjqWOQrmDadAMF/sHEG6pRFngXNhEScY/nudki
         uxJ1j+vLo09Ttck3qKDFSWzDlgHyzhCP2CldZrwX/AQNgjkWgawKhJlwPTOe79sgA+IZ
         doMA==
X-Gm-Message-State: ANhLgQ3CsligXaX8wpl2i1CBZU5/eZxW25Bj0qaZIV3nS0vvocWWs/nj
        M6vm4Pw3jAAsb3thCT8ddulhXxNJ3gkvRxRyc6M=
X-Google-Smtp-Source: ADFU+vsZWhJ2f9mcUB5E4uHSvIAUe8abv8oOA0e8bcDpUQk73Jp9Cku4TEnHO/ncO/YQv2I9QvEHgf+MgRbXp3ml7sQ=
X-Received: by 2002:a05:6830:1e06:: with SMTP id s6mr1017910otr.28.1584392289471;
 Mon, 16 Mar 2020 13:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
In-Reply-To: <20200316123914.Bluez.v1.1.I2c83372de789a015c1ee506690bb795ee0b0b0d9@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Mar 2020 13:57:57 -0700
Message-ID: <CABBYNZL1D44M4z2c+4zbjLgZ=PMHsTwy1VpYZpsJbpFJ9POZug@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: disconnect intr channel before ctrl channel
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Mar 15, 2020 at 9:40 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> According to bluetooth HID Profile spec Ver 1.0, section 7.2.2, A
> host or device shall always complete the disconnection of the
> interrupt channel before disconnecting the control channel.
> However, the current implementation disconnects them both
> simultaneously.
>
> This patch postpone the disconnection of control channel to the
> callback of interrupt watch, which shall be called upon receiving
> interrupt channel disconnection response.
> ---
>
>  profiles/input/device.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 8ada1b4ff..8ef3714c9 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1010,14 +1010,19 @@ static bool is_connected(struct input_device *idev)
>
>  static int connection_disconnect(struct input_device *idev, uint32_t flags)
>  {
> +       int sock;
> +
>         if (!is_connected(idev))
>                 return -ENOTCONN;
>
> -       /* Standard HID disconnect */
> -       if (idev->intr_io)
> -               g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
> -       if (idev->ctrl_io)
> -               g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
> +       /* Standard HID disconnect
> +        * Intr channel must be disconnected before ctrl channel, so only
> +        * disconnect intr here, ctrl is disconnected in intr_watch_cb.
> +        */
> +       if (idev->intr_io) {
> +               sock = g_io_channel_unix_get_fd(idev->intr_io);
> +               shutdown(sock, SHUT_RDWR);
> +       }
>
>         if (idev->uhid)
>                 return 0;
> --
> 2.25.1.481.gfbce0eb801-goog

Just to confirm, have you checked if this works with both situation
where the device is being removed or just being disconnected,
specially the case of HIDP_CTRL_VIRTUAL_CABLE_UNPLUG which perhaps was
not working before as well since we disconnect the ctrl channel before
transmitting it.

-- 
Luiz Augusto von Dentz

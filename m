Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jan 2022 22:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiANWxL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiANWxL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jan 2022 17:53:11 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17AC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 14:53:10 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id h14so27776898ybe.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 14:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiMrwM+IYRYW2mT+5Ehi25n/l2GeIoOXCeEDmGBUC08=;
        b=a7IDbWLZWRuqbRafscW/dT+WVeOEgduTQOGfSyGO4tXGPYPTxZGN0cl67nzOdxaGPd
         ZbrnhBWUklFRxeQTwu4eDQhfFIzhXUxiPUunb1ToMfyIEoTp5mdHRw0hzxG3S5+5R8r6
         XHJTeUpwiWZXxyzMqGp/+gYqzSDojkVnRdXpS/eeXhaO2coCluPLOO9n5Igb69sU+GSk
         x/2kpjmTPMDR8aVw3bofiC6PU3/ltYSmfAoD0Eph+ALz1E1JzI8o7kcM4URhi050I40o
         gV7IqpQ93LXejyZJwmsd1aW4qnDH0pOA2vs3gbrbCleTdd2DIUKs6w7elQtpKffiFs0U
         VB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiMrwM+IYRYW2mT+5Ehi25n/l2GeIoOXCeEDmGBUC08=;
        b=p6/CQ7iZ+2PIZpbPlvepbgVB5dSS09FPjPrHj89tszzwErDD/T1t1B+cKI4N+Drac0
         XSU8euXC7LdaDfg+VMAEXclYv4UtxphdKv8H3cYOJUSQr1uEgf7E+IOhc5+BfpdGPtQr
         IuqRpYmuXa/83FnNBSxpPasqM9xMu11KzB1crq6nzpKIiskuLM4mwhoNqPXJaUrz3BMM
         L99qBA9vqe140oVlIxoEdc4uZk7f8a5NEAZFGyu5kqN0hJFbPLhi5MDxY+b/TvQxlAta
         ZNN9GMdl/RgAU/U5mRkWpuuiK7ZL/w3h3HzmuS4hx36o6Ck9Wihwwbi/NigMypovMlfX
         C88Q==
X-Gm-Message-State: AOAM530sqzBF0lRzkkvzU0M2ueq0Bmsy5vufNk6z7WWukenU0h6TOIXj
        XZ/WCePHYnaXTAp5Jy2sUUZvH73sN+oqYxHzqeE=
X-Google-Smtp-Source: ABdhPJxydvSY88zzq8V8GvvGmtMkAwiJugX97oG90gWmoeMJc1g3YgScOhsi9AE7SAu8b8wlKshYCUPeNNkg7X9SZLs=
X-Received: by 2002:a5b:14a:: with SMTP id c10mr14812278ybp.752.1642200789889;
 Fri, 14 Jan 2022 14:53:09 -0800 (PST)
MIME-Version: 1.0
References: <20220112101731.77010-1-gav@thegavinli.com>
In-Reply-To: <20220112101731.77010-1-gav@thegavinli.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Jan 2022 14:52:59 -0800
Message-ID: <CABBYNZK+oz9S1dRU+sbxT08AU13Pk7u5yavw2sN8PwXav3a+yQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ensure valid channel mode when creating l2cap
 conn on LE
To:     gav@thegavinli.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Gavin Li <git@thegavinli.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 12, 2022 at 2:17 AM <gav@thegavinli.com> wrote:
>
> From: Gavin Li <git@thegavinli.com>
>
> After creating a socket(AF_INET, SOCK_STREAM, BTPROTO_L2CAP) socket and
> connect()'ing to a LE device with default settings (no setsockopt), upon
> the first sendmsg, the following BUG occurs because chan->mode==L2CAP_MODE_ERTM,
> causing l2cap_ertm_send() -> __set_retrans_timer() -> schedule_delayed_work()
> on l2cap_chan.retrans_timer, which was never initialized because
> l2cap_ertm_init() was never called to initialize it.
>
>   Call Trace:
>    queue_delayed_work_on+0x36/0x40
>    l2cap_ertm_send.isra.0+0x14d/0x2d0 [bluetooth]
>    l2cap_tx+0x361/0x510 [bluetooth]
>    l2cap_chan_send+0xb26/0xb50 [bluetooth]
>    l2cap_sock_sendmsg+0xc9/0x100 [bluetooth]
>    sock_sendmsg+0x5e/0x60
>    sock_write_iter+0x97/0x100
>    new_sync_write+0x1d3/0x1f0
>    vfs_write+0x1b4/0x270
>    ksys_write+0xaf/0xe0
>    do_syscall_64+0x33/0x40
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> This patch ensures that when connecting to a LE device, chan->mode will
> always be corrected to L2CAP_MODE_LE_FLOWCTL if it is invalid for LE.
>
> Signed-off-by: Gavin Li <git@thegavinli.com>
> ---
>  net/bluetooth/l2cap_sock.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 160c016a5dfb9..58c06ef32656c 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -78,6 +78,17 @@ static int l2cap_validate_le_psm(u16 psm)
>         return 0;
>  }
>
> +static bool l2cap_mode_supports_le(u8 mode)
> +{
> +       switch (mode) {
> +               case L2CAP_MODE_LE_FLOWCTL:
> +               case L2CAP_MODE_EXT_FLOWCTL:
> +                       return true;
> +               default:
> +                       return false;
> +       }
> +}
> +
>  static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
>  {
>         struct sock *sk = sock->sk;
> @@ -161,7 +172,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
>                 break;
>         }
>
> -       if (chan->psm && bdaddr_type_is_le(chan->src_type))
> +       if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
>                 chan->mode = L2CAP_MODE_LE_FLOWCTL;
>
>         chan->state = BT_BOUND;
> @@ -240,7 +251,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
>                         return -EINVAL;
>         }
>
> -       if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
> +       if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
>                 chan->mode = L2CAP_MODE_LE_FLOWCTL;
>
>         err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
> --
> 2.34.1

Doesn't apply to bluetooth-next:

https://github.com/bluez/bluez/issues/250

-- 
Luiz Augusto von Dentz

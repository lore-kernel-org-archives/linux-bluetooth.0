Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A99C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575F9218A6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 13:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXU/rndw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCN5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:57:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38872 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCN5j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 09:57:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so2140975oie.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVioX7hOzYLxkEQcAa41j8McAZVZ6Doyqy8mLYj3wp8=;
        b=fXU/rndw1G9snzliQfadbxj4eRL/m6mkpsw5wfQlcJwLeOpp1uFt+1XEAvQ4njVbp1
         riBWKfBSiM/Yg1fPE7fdueklDkDxtCeqzsh5lRBku3d/OlxHD8fQn7rg7gixX6+R/SzM
         YewrZimokwo6SupkWZRbEnxBIdvDcFhTtwUHZ/tDanSkY+Z5S8BcSPRkDlYTC363RClF
         xacOE+HFSD37QOzTICrqqyMIr8nJ/fYoyRG9UnA+H+ec2ZUStD7IsqujSQ9PW1ARfmlK
         H9Em2DKnUPrDK4Dw9pPZ3HlFeZ7y+1ciyqRiJu3dLEOfVXIL7GlUFykZg6htK1Lis4ok
         qbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVioX7hOzYLxkEQcAa41j8McAZVZ6Doyqy8mLYj3wp8=;
        b=E+N/3srwF4GdHwl7Qdrd1diq10AByc8SUecLwIt1cMjmKWJUPTg/nV3+sJhgQJeEm5
         FKfe+4YMM2UaeM7e1qLEmL9oMnZI8GldrcC4rSG6f3hCICYgpqGHnUV0/ppJucp/uXU2
         eueePIX4RvQ86uoV1SbBk33NgfYV8Aglm5Zekru/ynxQytHOo1wm0YtsdEmMVpQJi5+t
         ZTxkZAJUGt5LhLoLTbGiJFwDmUokL3zsW8vCD6lfF4octQqFkjChOHXrij07zv2tSOVY
         /wAl55UoLZysmdaGxUgJFuDvNZ6pohCByGJf0cOLGjEeuWd9Wgx2hz/qZ4CgUKIMY34X
         Vv5w==
X-Gm-Message-State: APjAAAVVwAzoVM6HbzHhAgYpty/jrh0CCOgh2nOOFTGYVDBOzSAlH6HT
        MXx+8gun7I2cDC/Dd6BHtP5P6BzYA9MD+XV6EyEmfSyX6CI=
X-Google-Smtp-Source: APXvYqx2fw/Fn/qXgWpTyb0O1FZ9+1wjj+f45uuA6looQaF9aMhubSAYrsJvOMlBzowfqti37+i8XwDcQYQZU5xw37o=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr7435952oiy.110.1562162258541;
 Wed, 03 Jul 2019 06:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190603104843.26848-1-luiz.dentz@gmail.com> <20190603104843.26848-2-luiz.dentz@gmail.com>
In-Reply-To: <20190603104843.26848-2-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jul 2019 16:57:25 +0300
Message-ID: <CABBYNZLFxgB_smaNq=0HzH0BxqKS08dsrw=ZNSv05xFkE7F75g@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: L2CAP: Check bearer type on __l2cap_global_chan_by_addr
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Johan,

On Mon, Jun 3, 2019 at 1:48 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The spec defines PSM and LE_PSM as different domains so a listen on the
> same PSM is valid if the address type points to a different bearer.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index b53acd6c9a3d..8da73ca8c111 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -168,11 +168,18 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
>         return c;
>  }
>
> -static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
> +static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src,
> +                                                     u8 src_type)
>  {
>         struct l2cap_chan *c;
>
>         list_for_each_entry(c, &chan_list, global_l) {
> +               if (src_type == BDADDR_BREDR && c->src_type != BDADDR_BREDR)
> +                       continue;
> +
> +               if (src_type != BDADDR_BREDR && c->src_type == BDADDR_BREDR)
> +                       continue;
> +
>                 if (c->sport == psm && !bacmp(&c->src, src))
>                         return c;
>         }
> @@ -185,7 +192,7 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
>
>         write_lock(&chan_list_lock);
>
> -       if (psm && __l2cap_global_chan_by_addr(psm, src)) {
> +       if (psm && __l2cap_global_chan_by_addr(psm, src, chan->src_type)) {
>                 err = -EADDRINUSE;
>                 goto done;
>         }
> @@ -209,7 +216,8 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
>
>                 err = -EINVAL;
>                 for (p = start; p <= end; p += incr)
> -                       if (!__l2cap_global_chan_by_addr(cpu_to_le16(p), src)) {
> +                       if (!__l2cap_global_chan_by_addr(cpu_to_le16(p), src,
> +                                                        chan->src_type)) {
>                                 chan->psm   = cpu_to_le16(p);
>                                 chan->sport = cpu_to_le16(p);
>                                 err = 0;
> --
> 2.21.0

Any chance to review this one.

-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC75C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jan 2022 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiANXAy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiANXAx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jan 2022 18:00:53 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F18C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 15:00:53 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id h14so27816527ybe.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 15:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7psvdez+6Ty0eEL/cskyyby/Ctgr21QAGtZe1xNUEjw=;
        b=pnF7md+33nfy+mEi8OtrvmE0pS26y7PdBMSCSNumxhCtNnXZWIDLpJMU/XH50c5ecm
         ldzm9GOOMBUBxU2LnLbKFETmZpXBa42mF6cnFw2k9X6gzxfWodz6hSWqfr0twKzX1MJM
         Mf4gmgcixxkEbUg5k8RJXQK3jW1ICfhsTwXk86ElIhqyFGvEEd+bKswNPk5aMLYb7ph/
         79zzfvnmXr1gx8w4/dzvG0C4bpV8mIiR3dtXrze7kvGgC3y9q3L/gB5xGfayLUlPHeN6
         sIYC0zqBjrzUFgSN23q2y/hQF9BZq6D/JKQbLQoEJIz7S/fHHO6QcmeBTVa1hVUp5v+h
         Q2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7psvdez+6Ty0eEL/cskyyby/Ctgr21QAGtZe1xNUEjw=;
        b=6ZXQPFeRFcRp9cWKME6u4UUmSN/xq/hvtYElbPV9Iu2J93PuEmUOx5aS8Nh7Jyfiqh
         SmI4xKGLNuGYZWYUMlMfTZCBlfo3uZhDKBJgKOxEbPysMe3SZchrHYM4kGEVi0qO0rxH
         qdT3ndCiVV8ix4YRe6YZJWInPzXwkw2wVbvP/uuh76ADVNvyZ3U9/GL8g19rA6Exx8BK
         z2tQICpOxiDtySfDPWZ2++ua+oAjBbgTQzuJRkxJ2M/Hfn2/DdpeN0nOdFFE3+Kdp3Nd
         2gCUrYa14TkK9KcROehgSUhIj2dsNDjhRgi3xx9zzj+OxbOylRbM3PWc+3jspkJhZH+t
         bqRQ==
X-Gm-Message-State: AOAM531MKNQSJOCB4ZWkX1fkz2A3GOJHIUoHsR6EST0igscdSASkUeTs
        jysKdZ8dK3MMO/xbyakuu2qP6WmesBVRfgOt3bAeEOwcgu8=
X-Google-Smtp-Source: ABdhPJwinL4NKb4JKNNt7gX3HWXvgo4TY9+7snIJmKSZaTKob9Tcl2iUU379qgFphDo68wXVTyU52gUoB/dTSr3Ex/Y=
X-Received: by 2002:a5b:14a:: with SMTP id c10mr14838090ybp.752.1642201251850;
 Fri, 14 Jan 2022 15:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20220112101731.77010-1-gav@thegavinli.com> <CABBYNZK+oz9S1dRU+sbxT08AU13Pk7u5yavw2sN8PwXav3a+yQ@mail.gmail.com>
In-Reply-To: <CABBYNZK+oz9S1dRU+sbxT08AU13Pk7u5yavw2sN8PwXav3a+yQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Jan 2022 15:00:41 -0800
Message-ID: <CABBYNZ+b4MehqjjXt7gZYi=b0yRrNRvYgTAJqjmy8Z+fM3SNjw@mail.gmail.com>
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

On Fri, Jan 14, 2022 at 2:52 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jan 12, 2022 at 2:17 AM <gav@thegavinli.com> wrote:
> >
> > From: Gavin Li <git@thegavinli.com>
> >
> > After creating a socket(AF_INET, SOCK_STREAM, BTPROTO_L2CAP) socket and
> > connect()'ing to a LE device with default settings (no setsockopt), upon
> > the first sendmsg, the following BUG occurs because chan->mode==L2CAP_MODE_ERTM,
> > causing l2cap_ertm_send() -> __set_retrans_timer() -> schedule_delayed_work()
> > on l2cap_chan.retrans_timer, which was never initialized because
> > l2cap_ertm_init() was never called to initialize it.
> >
> >   Call Trace:
> >    queue_delayed_work_on+0x36/0x40
> >    l2cap_ertm_send.isra.0+0x14d/0x2d0 [bluetooth]
> >    l2cap_tx+0x361/0x510 [bluetooth]
> >    l2cap_chan_send+0xb26/0xb50 [bluetooth]
> >    l2cap_sock_sendmsg+0xc9/0x100 [bluetooth]
> >    sock_sendmsg+0x5e/0x60
> >    sock_write_iter+0x97/0x100
> >    new_sync_write+0x1d3/0x1f0
> >    vfs_write+0x1b4/0x270
> >    ksys_write+0xaf/0xe0
> >    do_syscall_64+0x33/0x40
> >    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > This patch ensures that when connecting to a LE device, chan->mode will
> > always be corrected to L2CAP_MODE_LE_FLOWCTL if it is invalid for LE.
> >
> > Signed-off-by: Gavin Li <git@thegavinli.com>
> > ---
> >  net/bluetooth/l2cap_sock.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 160c016a5dfb9..58c06ef32656c 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -78,6 +78,17 @@ static int l2cap_validate_le_psm(u16 psm)
> >         return 0;
> >  }
> >
> > +static bool l2cap_mode_supports_le(u8 mode)
> > +{
> > +       switch (mode) {
> > +               case L2CAP_MODE_LE_FLOWCTL:
> > +               case L2CAP_MODE_EXT_FLOWCTL:
> > +                       return true;
> > +               default:
> > +                       return false;
> > +       }
> > +}
> > +
> >  static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> >  {
> >         struct sock *sk = sock->sk;
> > @@ -161,7 +172,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> >                 break;
> >         }
> >
> > -       if (chan->psm && bdaddr_type_is_le(chan->src_type))
> > +       if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
> >                 chan->mode = L2CAP_MODE_LE_FLOWCTL;
> >
> >         chan->state = BT_BOUND;
> > @@ -240,7 +251,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
> >                         return -EINVAL;
> >         }
> >
> > -       if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
> > +       if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
> >                 chan->mode = L2CAP_MODE_LE_FLOWCTL;
> >
> >         err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
> > --
> > 2.34.1
>
> Doesn't apply to bluetooth-next:
>
> https://github.com/bluez/bluez/issues/250

Please disregard the link above, Ive meant to paste:

Applying: Bluetooth: ensure valid channel mode when creating l2cap conn on LE
error: patch failed: net/bluetooth/l2cap_sock.c:161
error: net/bluetooth/l2cap_sock.c: patch does not apply

I did fix something similar:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=30d57722732d9736554f85f75f9d7ad5402d192e

-- 
Luiz Augusto von Dentz

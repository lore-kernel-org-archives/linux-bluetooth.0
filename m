Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jan 2022 07:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbiAQHsf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiAQHse (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jan 2022 02:48:34 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A58C06173F
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jan 2022 23:48:34 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g81so43228270ybg.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jan 2022 23:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegavinli.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqobLp8Ek3rCnIci6uQrkmYjKBJdOWjAvalfheGfY4M=;
        b=fgX21+qGb1d7XUr6za07HKNL2WoEQMFa4bbBOeAV4lNpFBYD9GjWPYrSNNMdEp3gQ5
         9bYjQrOZGydRxn85O3rG9JLryAETqWzKdo6J32SKP60/UXTckiWyMTmSb1piBgXwibDm
         ccM6LQCerFnOOZ5xQQU9hml3kPDB3bbRw+7fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqobLp8Ek3rCnIci6uQrkmYjKBJdOWjAvalfheGfY4M=;
        b=3xlW25Mombtlw5KZXP4oQNlQWBrb+fYGNQlSIWMIZFSowoaI8dW+YX1XL8tz+NCyGY
         wcxHM5IAQbVA1bIdbfM5PCFfp22M6L28iGEHlnUImsP3s210h5YJlppL1RD9iA60NwqD
         BOBZBa+YCbi2Ao6iUmrXwATkAL+2HwZZoNxU5jXkxuOQC/uANM9bKbsx/e0iTFtR/GH+
         2z90oE35QSfiDIV6v7qZsEfsP0/nRp7VQKqly2S3puorBjGqNTSLcNcJPiX1JN700rgU
         YZ4UQCDAYCXnrOJ2shWKhoF/rpWH6VgbGQ1oZ4iuPs1pNCaQLmTGnF/lo+eQQHKmZ1F+
         QE9Q==
X-Gm-Message-State: AOAM533DRSZk2l8pddcNam2x4Hrv0OVT0rDweqN8MPXScX6GieRtXSiu
        tJIHdNrtbEnD+JCppAbCtEe5zWLpAbQUe7C2hJ9jHw==
X-Google-Smtp-Source: ABdhPJyWZbGqq4RZVgtVXreIYSpzSJbhENFEYndcCeNTPkNpgfLHbg7NMBcibRTISD+ysOo4b+ICLjSd/q/3JMalNZ4=
X-Received: by 2002:a25:d8d6:: with SMTP id p205mr18559676ybg.256.1642405713917;
 Sun, 16 Jan 2022 23:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20220112101731.77010-1-gav@thegavinli.com> <CABBYNZK+oz9S1dRU+sbxT08AU13Pk7u5yavw2sN8PwXav3a+yQ@mail.gmail.com>
 <CABBYNZ+b4MehqjjXt7gZYi=b0yRrNRvYgTAJqjmy8Z+fM3SNjw@mail.gmail.com>
In-Reply-To: <CABBYNZ+b4MehqjjXt7gZYi=b0yRrNRvYgTAJqjmy8Z+fM3SNjw@mail.gmail.com>
From:   Gavin Li <gav@thegavinli.com>
Date:   Sun, 16 Jan 2022 23:48:23 -0800
Message-ID: <CAHxvarA8-FTmRX9FHC0GXGE7o_iW3SpxiaCkzOzbnd15_4x9Bg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ensure valid channel mode when creating l2cap
 conn on LE
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Gavin Li <git@thegavinli.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This looks good; thanks for catching that.

Gavin


On Fri, Jan 14, 2022 at 3:00 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Fri, Jan 14, 2022 at 2:52 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Wed, Jan 12, 2022 at 2:17 AM <gav@thegavinli.com> wrote:
> > >
> > > From: Gavin Li <git@thegavinli.com>
> > >
> > > After creating a socket(AF_INET, SOCK_STREAM, BTPROTO_L2CAP) socket and
> > > connect()'ing to a LE device with default settings (no setsockopt), upon
> > > the first sendmsg, the following BUG occurs because chan->mode==L2CAP_MODE_ERTM,
> > > causing l2cap_ertm_send() -> __set_retrans_timer() -> schedule_delayed_work()
> > > on l2cap_chan.retrans_timer, which was never initialized because
> > > l2cap_ertm_init() was never called to initialize it.
> > >
> > >   Call Trace:
> > >    queue_delayed_work_on+0x36/0x40
> > >    l2cap_ertm_send.isra.0+0x14d/0x2d0 [bluetooth]
> > >    l2cap_tx+0x361/0x510 [bluetooth]
> > >    l2cap_chan_send+0xb26/0xb50 [bluetooth]
> > >    l2cap_sock_sendmsg+0xc9/0x100 [bluetooth]
> > >    sock_sendmsg+0x5e/0x60
> > >    sock_write_iter+0x97/0x100
> > >    new_sync_write+0x1d3/0x1f0
> > >    vfs_write+0x1b4/0x270
> > >    ksys_write+0xaf/0xe0
> > >    do_syscall_64+0x33/0x40
> > >    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > This patch ensures that when connecting to a LE device, chan->mode will
> > > always be corrected to L2CAP_MODE_LE_FLOWCTL if it is invalid for LE.
> > >
> > > Signed-off-by: Gavin Li <git@thegavinli.com>
> > > ---
> > >  net/bluetooth/l2cap_sock.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > > index 160c016a5dfb9..58c06ef32656c 100644
> > > --- a/net/bluetooth/l2cap_sock.c
> > > +++ b/net/bluetooth/l2cap_sock.c
> > > @@ -78,6 +78,17 @@ static int l2cap_validate_le_psm(u16 psm)
> > >         return 0;
> > >  }
> > >
> > > +static bool l2cap_mode_supports_le(u8 mode)
> > > +{
> > > +       switch (mode) {
> > > +               case L2CAP_MODE_LE_FLOWCTL:
> > > +               case L2CAP_MODE_EXT_FLOWCTL:
> > > +                       return true;
> > > +               default:
> > > +                       return false;
> > > +       }
> > > +}
> > > +
> > >  static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> > >  {
> > >         struct sock *sk = sock->sk;
> > > @@ -161,7 +172,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> > >                 break;
> > >         }
> > >
> > > -       if (chan->psm && bdaddr_type_is_le(chan->src_type))
> > > +       if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
> > >                 chan->mode = L2CAP_MODE_LE_FLOWCTL;
> > >
> > >         chan->state = BT_BOUND;
> > > @@ -240,7 +251,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
> > >                         return -EINVAL;
> > >         }
> > >
> > > -       if (chan->psm && bdaddr_type_is_le(chan->src_type) && !chan->mode)
> > > +       if (chan->psm && bdaddr_type_is_le(la.l2_bdaddr_type) && !l2cap_mode_supports_le(chan->mode))
> > >                 chan->mode = L2CAP_MODE_LE_FLOWCTL;
> > >
> > >         err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
> > > --
> > > 2.34.1
> >
> > Doesn't apply to bluetooth-next:
> >
> > https://github.com/bluez/bluez/issues/250
>
> Please disregard the link above, Ive meant to paste:
>
> Applying: Bluetooth: ensure valid channel mode when creating l2cap conn on LE
> error: patch failed: net/bluetooth/l2cap_sock.c:161
> error: net/bluetooth/l2cap_sock.c: patch does not apply
>
> I did fix something similar:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=30d57722732d9736554f85f75f9d7ad5402d192e
>
> --
> Luiz Augusto von Dentz

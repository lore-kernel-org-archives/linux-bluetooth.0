Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8016C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 10:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEXKyM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 06:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEXKyL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 06:54:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E0A3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 03:54:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so1483180a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 03:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684925648; x=1687517648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/qi+dHgB0OUou2fTatsWKxVpRKt0hH2Bcu1Do/nAuA=;
        b=GftWbWECWQFLbvcv03JoAPeER0zJrtOqVthatc1RpHrmOLrBOX8yVtEf+Dhl2PqNUu
         YdodgmdA/Ge5MR5vz3mUJQsQ9NhIdN3ivxeb87HNRa4MX7baDVrvPaZSmC+smSRKbFx/
         n6BlgiMG2y8MBuWi3oF78vr00bVu6KKuhjYcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925648; x=1687517648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/qi+dHgB0OUou2fTatsWKxVpRKt0hH2Bcu1Do/nAuA=;
        b=iyMHX0y9bsGihZoMdyAnzDVnU2U7qJYKmgOxlvdO+ibhbbjbLBNxS5lJjcIHe/EpTZ
         y9Pbh4kmzZCBIM/9QO8wcpbMUDKCA8m9tw0YapEaXQcgaN/zlSFl+8WLiEDAY3gtXzPT
         qTsk4s4m040OaLZXw6FfHCatl2BaZNt/C9cdUo5NiYyR4T16/b08/hTqggstbMe0pAgE
         QSOBWzApe9Hru5VkV+hLBGg0HLkqyrqiVBmKS9JUhfZQ4OZwemRHZ+sK0iJmHdp0cJmU
         MBZipvetvjGPBHSiAiRqtwqWbPGU3f2/P+hFZZ1xknt9RWMDtmnT9FnUzwa9sxZqpzcO
         F44g==
X-Gm-Message-State: AC+VfDzXZWKb9ispDh49yahfzphKGBfECQURhc4TNfN015usrSGhbw1Y
        FW/WgHbGQDNfk69w5PbwPqnMmFfHfNDEVLrRqnk=
X-Google-Smtp-Source: ACHHUZ7VcvioW0W4hW+jnHMKqbLDCm8foh/GsgAiEUbZM5Z7fLgIBMg/xsajndIKCOc8U1KT6eIZcA==
X-Received: by 2002:a17:907:ea9:b0:96a:4bca:8408 with SMTP id ho41-20020a1709070ea900b0096a4bca8408mr18121111ejc.60.1684925648011;
        Wed, 24 May 2023 03:54:08 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906341100b00965a56f82absm5622812ejb.212.2023.05.24.03.54.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:54:07 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so627665f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 03:54:06 -0700 (PDT)
X-Received: by 2002:a5d:5348:0:b0:306:2ef0:d223 with SMTP id
 t8-20020a5d5348000000b003062ef0d223mr11847562wrv.62.1684925646235; Wed, 24
 May 2023 03:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230522234154.2924052-1-yinghsu@chromium.org>
 <ZGyPt1GYGV2C2RQZ@corigine.com> <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
In-Reply-To: <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
From:   Ying Hsu <yinghsu@chromium.org>
Date:   Wed, 24 May 2023 18:53:29 +0800
X-Gmail-Original-Message-ID: <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com>
Message-ID: <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix l2cap_disconnect_req deadlock
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

I understand your concern about the repeated code.
However, simply hiding the locking logic in another function
introduces hidden assumptions.
For this patch, I would like to fix the deadlock in a simple and easy
to understand way.
We can always refactor the l2cap_chan utility functions later.

Hi Luis,

I'll add a fixes tag in the next version.

Best regards,
Ying


On Wed, May 24, 2023 at 3:06=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Simon, Ying,
>
> On Tue, May 23, 2023 at 3:04=E2=80=AFAM Simon Horman <simon.horman@corigi=
ne.com> wrote:
> >
> > On Mon, May 22, 2023 at 11:41:51PM +0000, Ying Hsu wrote:
> > > L2CAP assumes that the locks conn->chan_lock and chan->lock are
> > > acquired in the order conn->chan_lock, chan->lock to avoid
> > > potential deadlock.
> > > For example, l2sock_shutdown acquires these locks in the order:
> > >   mutex_lock(&conn->chan_lock)
> > >   l2cap_chan_lock(chan)
> > >
> > > However, l2cap_disconnect_req acquires chan->lock in
> > > l2cap_get_chan_by_scid first and then acquires conn->chan_lock
> > > before calling l2cap_chan_del. This means that these locks are
> > > acquired in unexpected order, which leads to potential deadlock:
> > >   l2cap_chan_lock(c)
> > >   mutex_lock(&conn->chan_lock)
> > >
> > > This patch uses __l2cap_get_chan_by_scid to replace
> > > l2cap_get_chan_by_scid and adjusts the locking order to avoid the
> > > potential deadlock.
>
> This needs the fixes tag so we can backport it properly.
>
> > > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > > ---
> > > This commit has been tested on a Chromebook device.
> > >
> > > Changes in v2:
> > > - Adding the prefix "Bluetooth:" to subject line.
> > >
> > >  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++------
> > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 376b523c7b26..8f08192b8fb1 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -4651,8 +4651,16 @@ static inline int l2cap_disconnect_req(struct =
l2cap_conn *conn,
> > >
> > >       BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
> > >
> > > -     chan =3D l2cap_get_chan_by_scid(conn, dcid);
> > > +     mutex_lock(&conn->chan_lock);
> > > +     chan =3D __l2cap_get_chan_by_scid(conn, dcid);
> > > +     if (chan) {
> > > +             chan =3D l2cap_chan_hold_unless_zero(chan);
> > > +             if (chan)
> > > +                     l2cap_chan_lock(chan);
> > > +     }
> > > +
> > >       if (!chan) {
> > > +             mutex_unlock(&conn->chan_lock);
> > >               cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid);
> > >               return 0;
> > >       }
> >
> > Hi Ying,
> >
> > The conditional setting of chan and calling l2cap_chan_lock()
> > is both non-trivial and repeated. It seems that it ought to be
> > in a helper.
> >
> > Something like this (I'm sure a better function name can be chosen):
> >
> >         chan =3D __l2cap_get_and_lock_chan_by_scid(conn, dcid);
> >         if (!chan) {
> >                 ...
> >         }
> >
> >         ...
>
> Or perhaps we could do something like l2cap_del_chan_by_scid:
>
> https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
>
> --
> Luiz Augusto von Dentz

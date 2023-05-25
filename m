Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFB3C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 04:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjEYES6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 00:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjEYESb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 00:18:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BFFE61
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 21:17:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510d6e1f1abso3744470a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684988231; x=1687580231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+04EpAmaPYUlluScEVT9VyZq4eY4+rPpOkbaWKqEJI=;
        b=gIGtcI+IJtZFHHjG0HDdbS2a4uGc/jQ9c++puEfDR5mFq1ju2+l0JKO/lfAM5bO9Rb
         mZ86JQgBOdGNxDSBuf7o44ur3nq47gN4RwtZazxhR9HqpbCwVv7cN8tnHZB8H8rWxQ97
         jkzgWitDl1pUP7LInQeRzxWdGdXXWxJlcusyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684988231; x=1687580231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+04EpAmaPYUlluScEVT9VyZq4eY4+rPpOkbaWKqEJI=;
        b=KJ0aEs+OrmTm+7aJmiKceih82BTs5F39s9kiZ5saXCJlFlKuNqLJIgaDEp0dE7aCab
         nV2gl8OZpUJ5JSakPZEQVXWRJOizmWbgXElrWyI64nTsk1AQ+XPur9exaXxp5EoURkmQ
         VHsyqlvq48pXmjhbCLcuGskU3O58pa07GswjALX8uthXETOwZr1KPU07qhp6CvKeaSpK
         SqGUOtwW0EszKGfl4rnae+9YBtmIeKOt7zYNDfn//38X/1W6HbcqemHLiTZYb8/ofq2e
         jdwpO4BCZPQD+ilUQWCYTwfOfBgyTYJs2KxhwgJnkaJ3o7Kyc8FAIqomI6kBtIFRZm83
         79vQ==
X-Gm-Message-State: AC+VfDyYPqIyCv9j6WQg+H56DlH0LuLykgwfS48BcZP1JRcqxi7k1XjH
        MVqOWAWPICM5p9ygZyTuPuQOUmGUv0KsNbs6QPVcCg==
X-Google-Smtp-Source: ACHHUZ58ym5TTwRCbSHvJxdMUQToZBuaMmFrMtEophzqSgs9hG4/lMvt1bOSPOQPG/GhzElcXSKOpw==
X-Received: by 2002:a50:fa8f:0:b0:506:bcd6:b125 with SMTP id w15-20020a50fa8f000000b00506bcd6b125mr3438924edr.40.1684988230848;
        Wed, 24 May 2023 21:17:10 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id u17-20020a056402065100b0050c0b9d31a7sm130526edx.22.2023.05.24.21.17.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 21:17:09 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f423521b10so664325e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 21:17:09 -0700 (PDT)
X-Received: by 2002:a7b:c84c:0:b0:3f6:a81:eb52 with SMTP id
 c12-20020a7bc84c000000b003f60a81eb52mr1531455wml.21.1684988229048; Wed, 24
 May 2023 21:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230522234154.2924052-1-yinghsu@chromium.org>
 <ZGyPt1GYGV2C2RQZ@corigine.com> <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
 <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com> <CABBYNZKPv_0AaJJm2_c0F+4qX_vKXQ9BnVgR-kPy40YsDDqSRQ@mail.gmail.com>
In-Reply-To: <CABBYNZKPv_0AaJJm2_c0F+4qX_vKXQ9BnVgR-kPy40YsDDqSRQ@mail.gmail.com>
From:   Ying Hsu <yinghsu@chromium.org>
Date:   Thu, 25 May 2023 12:16:32 +0800
X-Gmail-Original-Message-ID: <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
Message-ID: <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
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

Hi Luiz,

The proposal solves the deadlock but might introduce other problems as
it breaks the order of l2cap_chan_del.
There are another way to resolve the deadlock:
```
@@ -4663,7 +4663,9 @@ static inline int l2cap_disconnect_req(struct
l2cap_conn *conn,

        chan->ops->set_shutdown(chan);

+       l2cap_chan_unlock(chan);
        mutex_lock(&conn->chan_lock);
+       l2cap_chan_lock(chan);
        l2cap_chan_del(chan, ECONNRESET);
        mutex_unlock(&conn->chan_lock);
 ```

If you're okay with it, I'll do some verification and post a full patch.

Best regards,
Ying

On Thu, May 25, 2023 at 2:56=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ying,
>
> On Wed, May 24, 2023 at 3:54=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> w=
rote:
> >
> > Hi Simon,
> >
> > I understand your concern about the repeated code.
> > However, simply hiding the locking logic in another function
> > introduces hidden assumptions.
> > For this patch, I would like to fix the deadlock in a simple and easy
> > to understand way.
> > We can always refactor the l2cap_chan utility functions later.
> >
> > Hi Luis,
> >
> > I'll add a fixes tag in the next version.
>
> And how about doing this:
>
> https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
>
> > Best regards,
> > Ying
> >
> >
> > On Wed, May 24, 2023 at 3:06=E2=80=AFAM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Simon, Ying,
> > >
> > > On Tue, May 23, 2023 at 3:04=E2=80=AFAM Simon Horman <simon.horman@co=
rigine.com> wrote:
> > > >
> > > > On Mon, May 22, 2023 at 11:41:51PM +0000, Ying Hsu wrote:
> > > > > L2CAP assumes that the locks conn->chan_lock and chan->lock are
> > > > > acquired in the order conn->chan_lock, chan->lock to avoid
> > > > > potential deadlock.
> > > > > For example, l2sock_shutdown acquires these locks in the order:
> > > > >   mutex_lock(&conn->chan_lock)
> > > > >   l2cap_chan_lock(chan)
> > > > >
> > > > > However, l2cap_disconnect_req acquires chan->lock in
> > > > > l2cap_get_chan_by_scid first and then acquires conn->chan_lock
> > > > > before calling l2cap_chan_del. This means that these locks are
> > > > > acquired in unexpected order, which leads to potential deadlock:
> > > > >   l2cap_chan_lock(c)
> > > > >   mutex_lock(&conn->chan_lock)
> > > > >
> > > > > This patch uses __l2cap_get_chan_by_scid to replace
> > > > > l2cap_get_chan_by_scid and adjusts the locking order to avoid the
> > > > > potential deadlock.
> > >
> > > This needs the fixes tag so we can backport it properly.
> > >
> > > > > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > > > > ---
> > > > > This commit has been tested on a Chromebook device.
> > > > >
> > > > > Changes in v2:
> > > > > - Adding the prefix "Bluetooth:" to subject line.
> > > > >
> > > > >  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++------
> > > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_cor=
e.c
> > > > > index 376b523c7b26..8f08192b8fb1 100644
> > > > > --- a/net/bluetooth/l2cap_core.c
> > > > > +++ b/net/bluetooth/l2cap_core.c
> > > > > @@ -4651,8 +4651,16 @@ static inline int l2cap_disconnect_req(str=
uct l2cap_conn *conn,
> > > > >
> > > > >       BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
> > > > >
> > > > > -     chan =3D l2cap_get_chan_by_scid(conn, dcid);
> > > > > +     mutex_lock(&conn->chan_lock);
> > > > > +     chan =3D __l2cap_get_chan_by_scid(conn, dcid);
> > > > > +     if (chan) {
> > > > > +             chan =3D l2cap_chan_hold_unless_zero(chan);
> > > > > +             if (chan)
> > > > > +                     l2cap_chan_lock(chan);
> > > > > +     }
> > > > > +
> > > > >       if (!chan) {
> > > > > +             mutex_unlock(&conn->chan_lock);
> > > > >               cmd_reject_invalid_cid(conn, cmd->ident, dcid, scid=
);
> > > > >               return 0;
> > > > >       }
> > > >
> > > > Hi Ying,
> > > >
> > > > The conditional setting of chan and calling l2cap_chan_lock()
> > > > is both non-trivial and repeated. It seems that it ought to be
> > > > in a helper.
> > > >
> > > > Something like this (I'm sure a better function name can be chosen)=
:
> > > >
> > > >         chan =3D __l2cap_get_and_lock_chan_by_scid(conn, dcid);
> > > >         if (!chan) {
> > > >                 ...
> > > >         }
> > > >
> > > >         ...
> > >
> > > Or perhaps we could do something like l2cap_del_chan_by_scid:
> > >
> > > https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

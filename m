Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15707C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 05:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjE3FII (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 01:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjE3FIH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 01:08:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2FEA
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 22:08:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-514924ca903so4127079a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 22:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685423283; x=1688015283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oENdb/PNBbVjDrw8mDPjI3X3sDQAuL7/2+YTKg1gLI=;
        b=nNJLCB3FtxaV/RTzyPCHNuMIjWkv5BTVxn9XL3QJFc08wvDCKVjKgbij8gjObSOdS+
         /VCSeFsV5FTltlQWUJuEIR13YYB7lFYb+h6EdNmYLnyPuW7nCQybmtv+uKox2YDZEfXa
         Ur4JzdagHpdYjJUKfN/QGIp8UCbs47fhyc+YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685423283; x=1688015283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oENdb/PNBbVjDrw8mDPjI3X3sDQAuL7/2+YTKg1gLI=;
        b=UDBGLtb+IMK/4tXtC8OPqmbPks6k0puZ94wuKPUBxY21sii8Co2220bHEJqj8siygJ
         JBTDRCWd4uQzDbcq4FVaFFZgFWwTX4Vzi2pjpThe2Z3KYIQgdxgeqxOkJ3aHosKF+KE2
         Ec2c5CBtRfdfk2AKMVfuSI6VsZYllGcaQI+5Rycc/44UQPyg/Em5FcgRmJ7UkeXtDr8m
         unggmI2s87KXSTGZApbWIZqjgnMbjjbhtU9VWhCq0l6Y4QAQ90iachs47kUNglPdhtYZ
         +u5j/+nGu0eEBAuMGCtTZ6GZu0rmdXqOH+IKD+HoS7gApsIMb6K2c6MUXhBcwGZbmvGk
         vpcQ==
X-Gm-Message-State: AC+VfDwX+BZgS8Dz93qy5PqyzpPzN4T99/qBUIwcZYH12D+vZP+1v7SV
        cXs26yCzJnJ/GgbUOmaiPI56/Z7RsvVDY4FRt/o=
X-Google-Smtp-Source: ACHHUZ5q/aYikFMSBiHz8OUyPab/RadF2mEFpjQRtPkCxzjzPj+EKMF8edM6gt9t4rXxwyf65oJ8yQ==
X-Received: by 2002:a17:907:d25:b0:968:1102:1fb7 with SMTP id gn37-20020a1709070d2500b0096811021fb7mr1506499ejc.6.1685423282790;
        Mon, 29 May 2023 22:08:02 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090686c900b00965e68b8df5sm6773589ejy.76.2023.05.29.22.08.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 22:08:01 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30af20f5f67so793576f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 May 2023 22:08:01 -0700 (PDT)
X-Received: by 2002:adf:dd92:0:b0:30a:b46a:a443 with SMTP id
 x18-20020adfdd92000000b0030ab46aa443mr462543wrl.51.1685423280911; Mon, 29 May
 2023 22:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230522234154.2924052-1-yinghsu@chromium.org>
 <ZGyPt1GYGV2C2RQZ@corigine.com> <CABBYNZ+by-OQH2aPEMHpQ5cOLoKNpR7k111rJj6iOd2PGLx3gg@mail.gmail.com>
 <CAAa9mD3A+3uJzFK0EbTrn5hX42EOgeixehmxgkwdhp1KetxjVQ@mail.gmail.com>
 <CABBYNZKPv_0AaJJm2_c0F+4qX_vKXQ9BnVgR-kPy40YsDDqSRQ@mail.gmail.com> <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
In-Reply-To: <CAAa9mD2e-WkuHshXf7ifOHcGEsgHb68xkRdaq5MRMeY7_jzkMg@mail.gmail.com>
From:   Ying Hsu <yinghsu@chromium.org>
Date:   Tue, 30 May 2023 13:07:23 +0800
X-Gmail-Original-Message-ID: <CAAa9mD00VriG3utyedjwykuUUXaRU0SvXkr5+VPgmZFpiFokrA@mail.gmail.com>
Message-ID: <CAAa9mD00VriG3utyedjwykuUUXaRU0SvXkr5+VPgmZFpiFokrA@mail.gmail.com>
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

Gentle ping, Luiz.


On Thu, May 25, 2023 at 12:16=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> wr=
ote:
>
> Hi Luiz,
>
> The proposal solves the deadlock but might introduce other problems as
> it breaks the order of l2cap_chan_del.
> There are another way to resolve the deadlock:
> ```
> @@ -4663,7 +4663,9 @@ static inline int l2cap_disconnect_req(struct
> l2cap_conn *conn,
>
>         chan->ops->set_shutdown(chan);
>
> +       l2cap_chan_unlock(chan);
>         mutex_lock(&conn->chan_lock);
> +       l2cap_chan_lock(chan);
>         l2cap_chan_del(chan, ECONNRESET);
>         mutex_unlock(&conn->chan_lock);
>  ```
>
> If you're okay with it, I'll do some verification and post a full patch.
>
> Best regards,
> Ying
>
> On Thu, May 25, 2023 at 2:56=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Ying,
> >
> > On Wed, May 24, 2023 at 3:54=E2=80=AFAM Ying Hsu <yinghsu@chromium.org>=
 wrote:
> > >
> > > Hi Simon,
> > >
> > > I understand your concern about the repeated code.
> > > However, simply hiding the locking logic in another function
> > > introduces hidden assumptions.
> > > For this patch, I would like to fix the deadlock in a simple and easy
> > > to understand way.
> > > We can always refactor the l2cap_chan utility functions later.
> > >
> > > Hi Luis,
> > >
> > > I'll add a fixes tag in the next version.
> >
> > And how about doing this:
> >
> > https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
> >
> > > Best regards,
> > > Ying
> > >
> > >
> > > On Wed, May 24, 2023 at 3:06=E2=80=AFAM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Simon, Ying,
> > > >
> > > > On Tue, May 23, 2023 at 3:04=E2=80=AFAM Simon Horman <simon.horman@=
corigine.com> wrote:
> > > > >
> > > > > On Mon, May 22, 2023 at 11:41:51PM +0000, Ying Hsu wrote:
> > > > > > L2CAP assumes that the locks conn->chan_lock and chan->lock are
> > > > > > acquired in the order conn->chan_lock, chan->lock to avoid
> > > > > > potential deadlock.
> > > > > > For example, l2sock_shutdown acquires these locks in the order:
> > > > > >   mutex_lock(&conn->chan_lock)
> > > > > >   l2cap_chan_lock(chan)
> > > > > >
> > > > > > However, l2cap_disconnect_req acquires chan->lock in
> > > > > > l2cap_get_chan_by_scid first and then acquires conn->chan_lock
> > > > > > before calling l2cap_chan_del. This means that these locks are
> > > > > > acquired in unexpected order, which leads to potential deadlock=
:
> > > > > >   l2cap_chan_lock(c)
> > > > > >   mutex_lock(&conn->chan_lock)
> > > > > >
> > > > > > This patch uses __l2cap_get_chan_by_scid to replace
> > > > > > l2cap_get_chan_by_scid and adjusts the locking order to avoid t=
he
> > > > > > potential deadlock.
> > > >
> > > > This needs the fixes tag so we can backport it properly.
> > > >
> > > > > > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > > > > > ---
> > > > > > This commit has been tested on a Chromebook device.
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Adding the prefix "Bluetooth:" to subject line.
> > > > > >
> > > > > >  net/bluetooth/l2cap_core.c | 26 ++++++++++++++++++++------
> > > > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_c=
ore.c
> > > > > > index 376b523c7b26..8f08192b8fb1 100644
> > > > > > --- a/net/bluetooth/l2cap_core.c
> > > > > > +++ b/net/bluetooth/l2cap_core.c
> > > > > > @@ -4651,8 +4651,16 @@ static inline int l2cap_disconnect_req(s=
truct l2cap_conn *conn,
> > > > > >
> > > > > >       BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
> > > > > >
> > > > > > -     chan =3D l2cap_get_chan_by_scid(conn, dcid);
> > > > > > +     mutex_lock(&conn->chan_lock);
> > > > > > +     chan =3D __l2cap_get_chan_by_scid(conn, dcid);
> > > > > > +     if (chan) {
> > > > > > +             chan =3D l2cap_chan_hold_unless_zero(chan);
> > > > > > +             if (chan)
> > > > > > +                     l2cap_chan_lock(chan);
> > > > > > +     }
> > > > > > +
> > > > > >       if (!chan) {
> > > > > > +             mutex_unlock(&conn->chan_lock);
> > > > > >               cmd_reject_invalid_cid(conn, cmd->ident, dcid, sc=
id);
> > > > > >               return 0;
> > > > > >       }
> > > > >
> > > > > Hi Ying,
> > > > >
> > > > > The conditional setting of chan and calling l2cap_chan_lock()
> > > > > is both non-trivial and repeated. It seems that it ought to be
> > > > > in a helper.
> > > > >
> > > > > Something like this (I'm sure a better function name can be chose=
n):
> > > > >
> > > > >         chan =3D __l2cap_get_and_lock_chan_by_scid(conn, dcid);
> > > > >         if (!chan) {
> > > > >                 ...
> > > > >         }
> > > > >
> > > > >         ...
> > > >
> > > > Or perhaps we could do something like l2cap_del_chan_by_scid:
> > > >
> > > > https://gist.github.com/Vudentz/e513859ecb31e79c947dfcb4b5c60453
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz

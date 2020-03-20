Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4112C4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B5F2072C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 17:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDmGK175"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgCTRpH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:45:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34894 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTRpG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 13:45:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id k8so7429622oik.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JvbyjlNpLdX8PWd126R+QY0cIcys7iVW9BmKK1H1+gI=;
        b=rDmGK175EMB9NoARxYF7GXJ/yVRD97OWs2HnH1zhRc/+cl4P4QScWTkCqlnmmcSSG8
         tNvqSavI3Dm06un03ieo0qlag0xlEFNTvU02IerWBau6h8thVZg3fjZ/XZoVFk7HEJka
         4d2aHQw7fH1t3mk0LQoZToVkyedv/sEgvG6GcPf/VO8jiiFWnqgunMxt/P3/DZ+3SrYL
         oWxXmTrEaGTBUWoWHeD64JbojR/TTVBDMR8b9xvkA9p939c4n+7Xp0WatRMg0bAkt7WT
         jjIp94fp0ZI0vg2G79wAvLTJJTPXZ8ZO+trB2az5NsRRCvsn9zDAmH/abhCeg+kkeYZg
         d2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JvbyjlNpLdX8PWd126R+QY0cIcys7iVW9BmKK1H1+gI=;
        b=exGLI/VXKoZVMZdGpedjJDtfB165mo8OYyd381i3Ykk7ZMqStaXJztvZsS9Yr6K1sL
         OvAL+OP4tEJ10fhXuu/F//+XkRff2I0lFm0HPnLN0ZKN+pAaupYM2uVSUMjuldhLPAyB
         OnuHj6eA68g8flYkUsiuDFx03vjYu+D8bizlgr2Lw02Em+PiBDwZ43e+eSfpVc80rL/9
         As3z+rqRZ/6L7ODa6g8YTwcF9QXIbZQZZsOVesedhUMcjjNfRHvyvwoVE4Srh+Vr9Q/I
         VpmZD7yF482mjORB1eUXJ22Xk+sXq8Ju1nqLK8aHHsxzjttyWc70GPiDHTgmmkoRLWLY
         27Kg==
X-Gm-Message-State: ANhLgQ0YCD6AASqI6BntpubHtF/9QcuZ9TBqQPQ0HodmmjINiYNPrxpn
        VS3gdzWf5YvYa+Qn8LeZ8E24E/SYB9fekCucIx58tg==
X-Google-Smtp-Source: ADFU+vuuYCSRERU2cjaJtUzVm9Xclsk9uNOSAmb4pa7zg/VLbDV6eh2luN1EjAfoB6kPNdieNUMTSLQJxx9BFgTBTGo=
X-Received: by 2002:a54:4e13:: with SMTP id a19mr7682104oiy.108.1584726305756;
 Fri, 20 Mar 2020 10:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200318215019.21494-1-luiz.dentz@gmail.com> <20200318215019.21494-4-luiz.dentz@gmail.com>
 <DDA058C0-9DF5-43F4-9A41-001595A95573@holtmann.org>
In-Reply-To: <DDA058C0-9DF5-43F4-9A41-001595A95573@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 20 Mar 2020 10:44:54 -0700
Message-ID: <CABBYNZ++Kr+y7QX-2ah0CtaC5W+3A66a=Ppu71i0DeyvZW-CjA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: Add BT_MODE socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Mar 19, 2020 at 5:58 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This adds BT_MODE socket option which can be used to set L2CAP modes,
> > including modes only supported over LE which were not supported using
> > the L2CAP_OPTIONS.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h | 11 ++++
> > net/bluetooth/l2cap_sock.c        | 96 +++++++++++++++++++++++++++++++
> > 2 files changed, 107 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 1576353a2773..34191e34bfdc 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -139,6 +139,17 @@ struct bt_voice {
> > #define BT_PHY_LE_CODED_TX    0x00002000
> > #define BT_PHY_LE_CODED_RX    0x00004000
> >
> > +#define BT_MODE                      15
> > +
> > +#define BT_MODE_BASIC                0x00
> > +#define BT_MODE_RETRANS              0x01
> > +#define BT_MODE_FLOWCTL              0x02
> > +#define BT_MODE_ERTM         0x03
> > +#define BT_MODE_STREAMING    0x04
> > +#define BT_MODE_EXT_FLOWCTL  0x05
> > +
> > +#define BT_MODE_LE_FLOWCTL   0x80
> > +
>
> what I would do is just this:
>
>         BASIC           0x00
>         ERTM            0x01
>         STREAMING       0x02
>         LE_FLOWCTL      0x03
>         EXT_FLOWCTL     0x04
>
> Trying to cling onto some old L2CAP definition from the 2.1 days is not h=
elpful. I would really make a clean cut here.

Just to confirm, that means we will not going to support the old
flowctl and retransmit modes from BR/EDR with BT_MODE?

> This way we can also cleanly check the available modes per selected socke=
t and have either setsockopt or connect fail appropriately.
>
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 117ba20ea194..f2bb376c699f 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -500,6 +500,25 @@ static int l2cap_sock_getsockopt_old(struct socket=
 *sock, int optname,
> >       return err;
> > }
> >
> > +static u8 l2cap_get_mode(struct l2cap_chan *chan)
> > +{
> > +     switch (chan->mode) {
> > +     case L2CAP_MODE_BASIC:
> > +     case L2CAP_MODE_RETRANS:
> > +     case L2CAP_MODE_FLOWCTL:
> > +     case L2CAP_MODE_ERTM:
> > +     case L2CAP_MODE_STREAMING:
> > +             /* Mode above are the same on both old and new sockopt */
> > +             return chan->mode;
> > +     case L2CAP_MODE_LE_FLOWCTL:
> > +             return BT_MODE_FLOWCTL;
> > +     case L2CAP_MODE_EXT_FLOWCTL:
> > +             return BT_MODE_EXT_FLOWCTL;
> > +     }
> > +
> > +     return chan->mode;
> > +}
> > +
>
> Don=E2=80=99t bother with this. Keep the old socket and new socket indepe=
ndent code. I also want to add Kconfig option later that will allow us to d=
isable the old socket options once we have SOL_L2CAP requirement eradicated=
.

The reason I had the defines intermixed was that application would be
able to use the old sockopt to set it and then use BT_MODE to read it,
in which case I may need to store the actual socket mode separately
from the chan->mode and then perhaps fail if application attempt to
read it with BT_MODE if was not set using it.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

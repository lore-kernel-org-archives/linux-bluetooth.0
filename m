Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94820C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C8B2072F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcXarW/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0SEW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:04:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44204 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0SEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:04:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id v134so9539020oie.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bL6aRYcClD2jCQ/0U4P6AqZW5CF0xrEoRFEUi3fTl5c=;
        b=gcXarW/+cRvG0qymvlahQAXa2vBjeIuH/RM0bEMNQ2x5yzB9i40g+hOd4QucQs/zfJ
         YQj7AxInmiD2EU0UrdoPw1lWnQBJd6sUEhB2eTBMkm5K6zkDXzEJmBymbl4M/g/5t+Y5
         uW//+E6EUYZ8xH+oZ/wpiKuArtzRauPe+PjC51/jHSdSLUCKOVd/HRPYvOyBLbxZl/Ll
         DkmU/yrzruG1yqUS/X5jd/iF+ubosjIgKDcHFbhGLWctZtHVuAIi3yS60mQ2AxHn0YY2
         V4uE2CVlFJ0+x3p2tk5B7M0wyQaxe1vJ17sZa+mS9K8H1SYHRUkoIaMwB8iQbHN/O/eg
         4RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bL6aRYcClD2jCQ/0U4P6AqZW5CF0xrEoRFEUi3fTl5c=;
        b=Rlkv/RvB8Z8xv+iwsdaIjyUg6br/6ouVefLegCmC2TNIOHmkw+GhxmB2zXOMuXbQ/R
         Q73CFNP8ND3vgFByq0iTWYmNRd2kh55tZihl/lhP/G7d5FE6eoA2WtWFBCd/ksnam1ME
         vYAj3Dkqk27E5+8VZn7gvB/JgBR6/6er6oX2qJMkp2swLYiVJqbyWBLaWwvDf+BT/Wt2
         Q3Hol8pYOoFvNK7IXOJFLxsRug0cpRxEVKHBOMy7nfLxfhpVB4ANf+aMwyy4szihHaU2
         3ys0Gh/fYLlydAFlzYKsBuNmfWhauQGW/84qWzU04OOFHexVxM8XlHC4O/2mJj5bBEDA
         f53w==
X-Gm-Message-State: ANhLgQ2W+dsgZNX7aENnQzOTrKDYdAMorzcLqrl/YubCdfwQYyTiOYtL
        a+w+z99XOXB8JCftdcFtgjEicdkgeLAosiEGurP3whE3
X-Google-Smtp-Source: ADFU+vuAMrXv5OJsUBB2u6S5SaGu/fcV4HrxcTYnE17CFQWhlzxYHiiBByW8roXJMZmXxDpMpF3/Fax/bcPTy2LaUKI=
X-Received: by 2002:aca:b602:: with SMTP id g2mr65791oif.82.1585332259631;
 Fri, 27 Mar 2020 11:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200326202202.17244-1-luiz.dentz@gmail.com> <41548503-5923-441D-B005-47788599BD26@holtmann.org>
In-Reply-To: <41548503-5923-441D-B005-47788599BD26@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Mar 2020 11:04:08 -0700
Message-ID: <CABBYNZKREdxR4kqr2xgXzMOixN4uwctPmnXjp-8fLe_Stg8L_Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add BT_MODE socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Thu, Mar 26, 2020 at 11:40 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> > This adds BT_MODE socket option which can be used to set L2CAP modes,
> > including modes only supported over LE which were not supported using
> > the L2CAP_OPTIONS.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h |   8 ++
> > net/bluetooth/l2cap_sock.c        | 120 +++++++++++++++++++++++++++++-
> > 2 files changed, 127 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 1576353a2773..3fa7b1e3c5d9 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -139,6 +139,14 @@ struct bt_voice {
> > #define BT_PHY_LE_CODED_TX    0x00002000
> > #define BT_PHY_LE_CODED_RX    0x00004000
> >
> > +#define BT_MODE                      15
> > +
> > +#define BT_MODE_BASIC                0x00
> > +#define BT_MODE_ERTM         0x01
> > +#define BT_MODE_STREAMING    0x02
> > +#define BT_MODE_LE_FLOWCTL   0x03
> > +#define BT_MODE_EXT_FLOWCTL  0x04
> > +
>
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 117ba20ea194..7c863dc8fe6d 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -395,6 +395,24 @@ static int l2cap_sock_getname(struct socket *sock,=
 struct sockaddr *addr,
> >       return sizeof(struct sockaddr_l2);
> > }
> >
> > +static int l2cap_get_mode(struct l2cap_chan *chan)
> > +{
> > +     switch (chan->mode) {
> > +     case L2CAP_MODE_BASIC:
> > +             return BT_MODE_BASIC;
> > +     case L2CAP_MODE_ERTM:
> > +             return BT_MODE_ERTM;
> > +     case L2CAP_MODE_STREAMING:
> > +             return BT_MODE_STREAMING;
> > +     case L2CAP_MODE_LE_FLOWCTL:
> > +             return BT_MODE_LE_FLOWCTL;
> > +     case L2CAP_MODE_EXT_FLOWCTL:
> > +             return BT_MODE_EXT_FLOWCTL;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
> >                                    char __user *optval, int __user *opt=
len)
> > {
> > @@ -424,6 +442,13 @@ static int l2cap_sock_getsockopt_old(struct socket=
 *sock, int optname,
> >                       break;
> >               }
> >
> > +             /* L2CAP_MODE_LE_FLOWCTL and L2CAP_MODE_EXT_FLOWCTL are n=
ot
> > +              * supported by L2CAP_OPTIONS.
> > +              */
> > +             if (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> > +                 chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL)
> > +                     return -EINVAL;
> > +
>
> I might have done a positive check here.

Right, that means any new mode we introduced is not automatically
handled, got it.

>         switch (chan->mode) {
>         case L2CAP_MODE_BASIC:
>         case L2CAP_MODE_ERTM:
>         case L2CAP_MODE_STREAMING:
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
> Anyhow, I also realized that in l2cap_sock_setsockopt_old we are allowing=
 L2CAP_MODE_LE_FLOWCTL. I think we want to make that one return EINVAL as w=
ell. However that should be a separate patch just in case we need to revert=
 it.

Yep, previously it did not validate the mode being set, which indeed
seems to be a bug.

> That said, I would leave L2CAP_MODE_LE_FLOWCTL in here initially and then=
 remove it with the same patch that removes it from setsockopt_old. Lets ch=
eck our userspace first if it handles this all correctly for LE connections=
 (not that L2CAP LE connection oriented channels are used much).

Actually there is a check preventing L2CAP_OPTIONS to work with LE
addresses, so applications should not be able to use it in that case,
except for BR/EDR though I would consider that to be a bug since
L2CAP_MODE_LE_FLOWCTL obviously should not work in that case.

> >               memset(&opts, 0, sizeof(opts));
> >               opts.imtu     =3D chan->imtu;
> >               opts.omtu     =3D chan->omtu;
> > @@ -508,7 +533,7 @@ static int l2cap_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >       struct bt_security sec;
> >       struct bt_power pwr;
> >       u32 phys;
> > -     int len, err =3D 0;
> > +     int len, mode, err =3D 0;
> >
> >       BT_DBG("sk %p", sk);
> >
> > @@ -624,6 +649,27 @@ static int l2cap_sock_getsockopt(struct socket *so=
ck, int level, int optname,
> >                       err =3D -EFAULT;
> >               break;
> >
> > +     case BT_MODE:
> > +             if (!enable_ecred) {
> > +                     err =3D -ENOPROTOOPT;
> > +                     break;
> > +             }
> > +
> > +             if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED) {
> > +                     err =3D -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             mode =3D l2cap_get_mode(chan);
> > +             if (mode < 0) {
> > +                     err =3D mode;
> > +                     break;
> > +             }
> > +
> > +             if (put_user(mode, (u8 __user *) optval))
> > +                     err =3D -EFAULT;
> > +             break;
> > +
> >       default:
> >               err =3D -ENOPROTOOPT;
> >               break;
> > @@ -763,6 +809,45 @@ static int l2cap_sock_setsockopt_old(struct socket=
 *sock, int optname,
> >       return err;
> > }
> >
> > +static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
> > +{
> > +     switch (mode) {
> > +     case BT_MODE_BASIC:
> > +             if (bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode =3D L2CAP_MODE_BASIC;
> > +             clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
> > +             break;
> > +     case BT_MODE_ERTM:
> > +             if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode =3D L2CAP_MODE_ERTM;
> > +             break;
> > +     case BT_MODE_STREAMING:
> > +             if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode =3D L2CAP_MODE_STREAMING;
> > +             break;
> > +     case BT_MODE_LE_FLOWCTL:
> > +             if (!bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode =3D L2CAP_MODE_LE_FLOWCTL;
> > +             break;
> > +     case BT_MODE_EXT_FLOWCTL:
> > +             /* TODO: Add support for ECRED PDUs to BR/EDR */
> > +             if (!bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode =3D L2CAP_MODE_EXT_FLOWCTL;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     chan->mode =3D mode;
> > +
> > +     return 0;
> > +}
> > +
> > static int l2cap_sock_setsockopt(struct socket *sock, int level, int op=
tname,
> >                                char __user *optval, unsigned int optlen=
)
> > {
> > @@ -968,6 +1053,39 @@ static int l2cap_sock_setsockopt(struct socket *s=
ock, int level, int optname,
> >
> >               break;
> >
> > +     case BT_MODE:
> > +             if (!enable_ecred) {
> > +                     err =3D -ENOPROTOOPT;
> > +                     break;
> > +             }
> > +
> > +             BT_DBG("sk->sk_state %u", sk->sk_state);
> > +
> > +             if (sk->sk_state !=3D BT_BOUND) {
> > +                     err =3D -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED) {
> > +                     err =3D -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             if (get_user(opt, (u8 __user *) optval)) {
> > +                     err =3D -EFAULT;
> > +                     break;
> > +             }
> > +
> > +             BT_DBG("opt %u", opt);
> > +
> > +             err =3D l2cap_set_mode(chan, opt);
> > +             if (err)
> > +                     break;
> > +
> > +             BT_DBG("mode 0x%2.2x", chan->mode);
> > +
> > +             break;
> > +
> >       default:
> >               err =3D -ENOPROTOOPT;
> >               break;
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

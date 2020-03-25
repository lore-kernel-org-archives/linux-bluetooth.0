Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF3C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 23:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D392076A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 23:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpf0+F7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYXjs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:39:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42317 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgCYXjs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 19:39:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id z5so3706423oth.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 16:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hh2ZM3mV1GSFYZWNvYvsqK6bwrLTfVTsGrHoiQvlIk=;
        b=Hpf0+F7lbp5QAMICoj1sBT1Ng/ItjE1EvSmFEK314qGE//zDFG6Je/1c9O8989LtPp
         bLzbXbeuAXwd0vlYRrcJDmnTFDDr6dw1Mzmlvg6KOz0kqCwk2MufMQ6b5jPFpK6HvpRd
         0iThb2yvpYYC3x+XT4h54RatmQmE0HT0oLN8Ido9FKSgOsCWKeghkwkFTJaPQWHAyDlf
         CswdiCAZ+tQsZ6Isy352VlhRlGePh6awOAf8QiJlKKxO193EuAbKgZ2JQuK8RZ1bGaus
         D2enZD4BeJGvBBw+ll5rxawXL2DEqvK39nv39F76aCM81xIIT8ayEHoYhpup27YTKqjI
         bnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hh2ZM3mV1GSFYZWNvYvsqK6bwrLTfVTsGrHoiQvlIk=;
        b=rWHHJRD1JRD5oG3EMmCbxIUy/gJRqGjD5YKUiOvalSN3kO3yuPSjulAuk/54AQncyz
         EiHcaVJj0K96jt4dvVGv0hYN4R0KBBT2LqtnBWX8MzXS2i07AxFC+T3W30pOTNS52nPS
         o4QLYdw1MnjHTPsNFl5eMDIT/UorsNek1h3472qtIctaT6Q9lSwuqd8i7UAUZhVGdvzD
         UrwUaU68PZrqOX/1Z9AruOEfs/4A0cbdohoy2wfTNgK70WplPyyAElRwp4nTNl14txQu
         s/+gkUd6eqACiUI8W8l8v2Xyts+6GAsSBrmZy1B9YTxeBAGaMB1hXaV7CuJRZRZar04q
         wrhQ==
X-Gm-Message-State: ANhLgQ1tmKdbeYDPPcUlwQVCkDObu425vQi4IFHsQocdHcAeelbtfo/e
        1kI4wJh+9l7FPVqYSv1cAlF8yfMVMhwGNiURw1DysA==
X-Google-Smtp-Source: ADFU+vsVjIdlDxuM64pRVOUrAc/ek0JADnfTGkasSecyUmzc1ILdaok4kZxtR4ggVklIE5fEXZaO53iq/ig1trBSLO0=
X-Received: by 2002:a9d:67c6:: with SMTP id c6mr4390009otn.11.1585179585543;
 Wed, 25 Mar 2020 16:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200325193754.13950-1-luiz.dentz@gmail.com> <20200325193754.13950-2-luiz.dentz@gmail.com>
 <0C7A165A-3C33-4E7D-949C-8DABB2E1DF05@holtmann.org>
In-Reply-To: <0C7A165A-3C33-4E7D-949C-8DABB2E1DF05@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Mar 2020 16:39:29 -0700
Message-ID: <CABBYNZLLUiC5KuYyiqxAhJDM78yQKy3REM8bNnr-ARtj9OWr4g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Bluetooth: Add BT_MODE socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 25, 2020 at 2:15 PM Marcel Holtmann <marcel@holtmann.org> wrote:
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
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
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
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 117ba20ea194..07f8d60953f2 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -395,6 +395,24 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr,
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
> >                                    char __user *optval, int __user *optlen)
> > {
> > @@ -424,6 +442,13 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
> >                       break;
> >               }
> >
> > +             /* L2CAP_MODE_LE_FLOWCTL and L2CAP_MODE_EXT_FLOWCTL are not
> > +              * supported by L2CAP_OPTIONS.
> > +              */
> > +             if (chan->mode == L2CAP_MODE_LE_FLOWCTL ||
> > +                             chan->mode == L2CAP_MODE_EXT_FLOWCTL)
>
> this is the wrong kernel indentation.

Fixed

> > +                     return -EINVAL;
> > +
> >               memset(&opts, 0, sizeof(opts));
> >               opts.imtu     = chan->imtu;
> >               opts.omtu     = chan->omtu;
> > @@ -508,7 +533,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> >       struct bt_security sec;
> >       struct bt_power pwr;
> >       u32 phys;
> > -     int len, err = 0;
> > +     int len, mode, err = 0;
> >
> >       BT_DBG("sk %p", sk);
> >
> > @@ -624,6 +649,27 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> >                       err = -EFAULT;
> >               break;
> >
> > +     case BT_MODE:
> > +             if (!enable_ecred) {
> > +                     err = -ENOPROTOOPT;
> > +                     break;
> > +             }
> > +
> > +             if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             mode = l2cap_get_mode(chan);
> > +             if (mode < 0) {
> > +                     err = mode;
> > +                     break;
> > +             }
> > +
> > +             if (put_user(mode, (u8 __user *) optval))
> > +                     err = -EFAULT;
> > +             break;
> > +
> >       default:
> >               err = -ENOPROTOOPT;
> >               break;
> > @@ -763,6 +809,45 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
> >       return err;
> > }
> >
> > +static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
> > +{
> > +     switch (mode) {
> > +     case BT_MODE_BASIC:
> > +             if (bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode = L2CAP_MODE_BASIC;
> > +             clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
> > +             break;
> > +     case BT_MODE_ERTM:
> > +             if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode = L2CAP_MODE_ERTM;
> > +             break;
> > +     case BT_MODE_STREAMING:
> > +             if (!disable_ertm || bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode = L2CAP_MODE_STREAMING;
> > +             break;
> > +     case BT_MODE_LE_FLOWCTL:
> > +             if (!bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode = L2CAP_MODE_LE_FLOWCTL;
> > +             break;
> > +     case BT_MODE_EXT_FLOWCTL:
> > +             /* TODO: Add support for ECRED PDUs to BR/EDR */
> > +             if (!bdaddr_type_is_le(chan->src_type))
> > +                     return -EINVAL;
> > +             mode = L2CAP_MODE_EXT_FLOWCTL;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     chan->mode = mode;
> > +
> > +     return 0;
> > +}
> > +
> > static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
> >                                char __user *optval, unsigned int optlen)
> > {
> > @@ -968,6 +1053,39 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
> >
> >               break;
> >
> > +     case BT_MODE:
> > +             if (!enable_ecred) {
> > +                     err = -ENOPROTOOPT;
> > +                     break;
> > +             }
> > +
> > +             BT_DBG("sk->sk_state %u", sk->sk_state);
> > +
> > +             if (sk->sk_state != BT_BOUND) {
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             if (get_user(opt, (u8 __user *) optval)) {
> > +                     err = -EFAULT;
> > +                     break;
> > +             }
> > +
> > +             BT_DBG("opt %u", opt);
> > +
> > +             err = l2cap_set_mode(chan, opt);
> > +             if (err)
> > +                     break;
> > +
> > +             BT_DBG("mode 0x%2.2x", chan->mode);
> > +
> > +             break;
> > +
>
> So do we want BT_MODE as u8 or just simply as int?

For the mode alone I guess it would be fine, the question is if we
want to leave space to add other fields later but I guess we could do
that with use of new options instead.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

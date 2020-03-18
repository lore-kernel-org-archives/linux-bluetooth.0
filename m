Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A4C4332D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 22:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FD520752
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 22:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKCeAGWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCRWEx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:04:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42241 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbgCRWEx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 18:04:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id 13so495673oiy.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JG44FywpxBceh3KMtpWtjel9+o7nYbu0LmUmcgp36Z4=;
        b=MKCeAGWxzC/kvRyLEgjNYeh0zHsvy/SUSdNYZLGKRPvOtbcTWoOPTxnyQUXZfpdKc8
         PVjjxvHwOfCMOrlGdub/BwHLMbvo4QrdgUNJmTSU9ZknYyYHnQdEPfzWazfE7LA/Kx6M
         x4U8DTFfWuYXISs6qG+1U4EPtKaaGNqLn10Yn65TEineQt1OazLLn4+hJI7/BKvPW5L3
         2uY02A/MiBcoRQMCqApWHlv9ZD+MnahFGDF1bNt4TnsvrF3OuYXt8vQbK+tabytgFZK0
         Hud+nu09XwUra7bagFHVcRs0TCgZX7Lsk5+gSv4uiJk/IzvBdpkJkBl+6+ZEz3YUcoBa
         4bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JG44FywpxBceh3KMtpWtjel9+o7nYbu0LmUmcgp36Z4=;
        b=KbHAYqZ5pHB9wXUzptvUkgz5u0f8WenVolo/NaSgqTrctLMWM6IINKV8wwHSnBXrUU
         LaGr9+I7bCsnS+8liszQHZK6hIiviv1+CVltmGOthXSPznM6CzCvHoQt2lt4G0il1eUz
         0mqDTSQ5V5Zr7dHkuMyFsIFEL0aAdKxj9Ff6b0rOMZoQ9SSeneIAhPM0rdPknQicdOyM
         QeiK+zOLYObykk8TQXXYM16G4Cgck9D0LSLE0PEvVvhifGooQgPTF8sr3BUKwRZb1tVt
         Ev51A7bvuThWC8nvjo104Lkxx8lUK83JYq23pHqlxfVr34/rVEjYlurOXVjsNLyPfiXw
         LTQw==
X-Gm-Message-State: ANhLgQ0B3b7w+SULb1Ks56HFQLUKQNm0J79L0+07WObWo344RH93Xx4n
        Yv8F+azt0vimaL2bdEnALdDW997jIYw7qo9nNqILft0u
X-Google-Smtp-Source: ADFU+vtxxJFVR4bkaqUtTYTBPMt63Tp4mnrYunMrog+xJbYH9VD/b0H2/EjfjKghcrbXMZox6r02aUUL3CqYUMjaM3w=
X-Received: by 2002:aca:bfc6:: with SMTP id p189mr90525oif.21.1584569092002;
 Wed, 18 Mar 2020 15:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200312222454.5079-1-luiz.dentz@gmail.com> <20200312222454.5079-3-luiz.dentz@gmail.com>
 <9F37D24D-BB2A-45B4-922D-8E2E1AB31C2C@holtmann.org> <CABBYNZJ70enQjBcMPkXaHP+p4dno4ADnafhutFwzB3458Ywgpg@mail.gmail.com>
 <80F7E75C-EC6D-4BE4-A97F-603FD9EFABB4@holtmann.org>
In-Reply-To: <80F7E75C-EC6D-4BE4-A97F-603FD9EFABB4@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 18 Mar 2020 15:04:40 -0700
Message-ID: <CABBYNZKNdXLBnFgzJm8hgLnA3fOBobHGj9Q6AXU66Ug0B3fS1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Add BT_MODE socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 18, 2020 at 12:27 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> >>> This adds BT_MODE socket option which can be used to set L2CAP modes,
> >>> including modes only supported over LE which were not supported using
> >>> the L2CAP_OPTIONS.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/bluetooth.h |  2 +
> >>> net/bluetooth/l2cap_sock.c        | 79 +++++++++++++++++++++++++-----=
-
> >>> 2 files changed, 66 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> >>> index 1576353a2773..c361ec7b06aa 100644
> >>> --- a/include/net/bluetooth/bluetooth.h
> >>> +++ b/include/net/bluetooth/bluetooth.h
> >>> @@ -139,6 +139,8 @@ struct bt_voice {
> >>> #define BT_PHY_LE_CODED_TX    0x00002000
> >>> #define BT_PHY_LE_CODED_RX    0x00004000
> >>>
> >>> +#define BT_MODE                      15
> >>> +
> >>
> >> I would cleanly define the BT_MODE_xx constants here. They don=E2=80=
=99t need to match spec numbers from L2CAP actually. I would also leave the=
 not used BR/EDR constants out of it and just add modes we do support.
> >
> > Id leave the same values since it makes easier to fallback if BT_MODE
> > is not supported e.g. BT_IO_MODE would have to declare 2 different
> > namespaces for the new and the old sockopt.
>
> I would actually not do that since we already made up a mode that isn=E2=
=80=99t in spec. And I don=E2=80=99t want to keep having to make up modes u=
ntil this tiny namespace explodes. We need to accept that for BlueZ we have=
 to define our own API and can not rely on values defined in the specificat=
ion. It was fine for Bluetooth 2.1 and earlier, but it isn=E2=80=99t anymor=
e.
>
> >
> >>> __printf(1, 2)
> >>> void bt_info(const char *fmt, ...);
> >>> __printf(1, 2)
> >>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> >>> index e43a90e05972..7a8a199c373d 100644
> >>> --- a/net/bluetooth/l2cap_sock.c
> >>> +++ b/net/bluetooth/l2cap_sock.c
> >>> @@ -619,6 +619,21 @@ static int l2cap_sock_getsockopt(struct socket *=
sock, int level, int optname,
> >>>                      err =3D -EFAULT;
> >>>              break;
> >>>
> >>> +     case BT_MODE:
> >>> +             if (!enable_ecred) {
> >>> +                     err =3D -ENOPROTOOPT;
> >>> +                     break;
> >>> +             }
> >>> +
> >>> +             if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED) {
> >>> +                     err =3D -EINVAL;
> >>> +                     break;
> >>> +             }
> >>> +
> >>> +             if (put_user(chan->mode, (u8 __user *) optval))
> >>> +                     err =3D -EFAULT;
> >>> +             break;
> >>> +
> >>>      default:
> >>>              err =3D -ENOPROTOOPT;
> >>>              break;
> >>> @@ -644,6 +659,29 @@ static bool l2cap_valid_mtu(struct l2cap_chan *c=
han, u16 mtu)
> >>>      return true;
> >>> }
> >>>
> >>> +static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
> >>> +{
> >>> +     switch (chan->mode) {
> >>> +     case L2CAP_MODE_LE_FLOWCTL:
> >>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>> +             break;
> >>> +     case L2CAP_MODE_BASIC:
> >>> +             clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
> >>> +             break;
> >>> +     case L2CAP_MODE_ERTM:
> >>> +     case L2CAP_MODE_STREAMING:
> >>> +             if (!disable_ertm)
> >>> +                     break;
> >>> +             /* fall through */
> >>> +     default:
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     chan->mode =3D mode;
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> static int l2cap_sock_setsockopt_old(struct socket *sock, int optname=
,
> >>>                                   char __user *optval, unsigned int o=
ptlen)
> >>> {
> >>> @@ -693,22 +731,9 @@ static int l2cap_sock_setsockopt_old(struct sock=
et *sock, int optname,
> >>>                      break;
> >>>              }
> >>>
> >>> -             chan->mode =3D opts.mode;
> >>> -             switch (chan->mode) {
> >>> -             case L2CAP_MODE_LE_FLOWCTL:
> >>> -                     break;
> >>> -             case L2CAP_MODE_BASIC:
> >>> -                     clear_bit(CONF_STATE2_DEVICE, &chan->conf_state=
);
> >>> -                     break;
> >>> -             case L2CAP_MODE_ERTM:
> >>> -             case L2CAP_MODE_STREAMING:
> >>> -                     if (!disable_ertm)
> >>> -                             break;
> >>> -                     /* fall through */
> >>> -             default:
> >>> -                     err =3D -EINVAL;
> >>> +             err =3D l2cap_set_mode(chan, opts.mode);
> >>> +             if (err)
> >>>                      break;
> >>> -             }
> >>>
> >>
> >> I would not yet try to break this out into a separate helper. I think =
L2CAP_OPTIONS should maybe just stay as it is. And as noted above, we defin=
e our own list of constants.
> >
> > That would complicate userspace code a little to much since that means
> > we would have 2 different namespace for BT_IO_MODE, as mentioned about
> > Id keep the same values for modes as in L2CAP_OPTIONS just adding new
> > definitions names, otherwise we will need a new option for bt_io to
> > avoid the namespaces to overlap but I rather not do that as BT_IO_MODE
> > already maps quite well to BT_MODE.
>
> Actually we need to change BT_IO_MODE to be abstract and handle it intern=
ally. Most likely BT_IO_MODE should just follow what we do for BT_MODE and =
internally it should re-map it to L2CAP_OPTIONS if needed.
>
> >
> >>>              BT_DBG("mode 0x%2.2x", chan->mode);
> >>>
> >>> @@ -963,6 +988,30 @@ static int l2cap_sock_setsockopt(struct socket *=
sock, int level, int optname,
> >>>
> >>>              break;
> >>>
> >>> +     case BT_MODE:
> >>> +             if (!enable_ecred) {
> >>> +                     err =3D -ENOPROTOOPT;
> >>> +                     break;
> >>> +             }
> >>> +
> >>> +             if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED) {
> >>> +                     err =3D -EINVAL;
> >>> +                     break;
> >>> +             }
> >>
> >> Especially here I would also check if the mode is valid on the choose =
transport. For me this would also mean we should require a bind() before al=
lowing to set the mode. So we have at least some idea what transport is pla=
nned to be used.
> >
> > I will make it check for BOUND state, though l2cap_set_mode does check
> > the mode already, or you are saying that if we do use a different
> > namespace we would have to convert, well I guess this further
> > reinforces my argument that making the values compatible makes things
> > a lot simpler.
>
> I care about the new socket options that they are clean and well defined =
when it comes to error conditions.

Fair enough, Ive made the changes so BT_MODE has its own set of modes
including BT_MODE_EXT_FLOWCTL, for the most part they are backward
compatible but Id move the LE_FLOWCTL to just map to BT_MODE_FLOWCTL
which is possible since we do require bind before setting BT_MODE we
can check the address type.

--=20
Luiz Augusto von Dentz

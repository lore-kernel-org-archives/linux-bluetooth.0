Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43243C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 16:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165D120774
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 16:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcMrUA7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgCXQ4z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:56:55 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43273 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgCXQ4z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 12:56:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125so19115181oif.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cd9wiim2w2g/X9A2/p0S6xeLGjOLXJd2upS5lm+e1Cw=;
        b=RcMrUA7PFak/Mfrpj0n3OCSFPzsIYfLLlerKJkeopRZP5xmmp9iGGWo73kKWVDchqb
         +b7mF/HGgzveL16yssM2oPDfnEolb+uai9jxFMTUohXbbZJgTyvGGd1eP+2Bhsnez4cA
         1XsNwzLdSPsjUUJCb1K1YuwGLMoNOJf8FD4p/uxYXa3YxSWp8Z7QWzkrFm01zedmsuOy
         okM0z1MFhxhoD3Ixk3TE2L1yMGrHH7x4KKrdVpFnzTEyU7YEK7hoQIJ6IDm2W0K+87ru
         XyxtK9TlZuAijQtP/BSCOXr5gGUC+ux4Fl9u76vzRa5E6erdemxoxssdkBzn0tRG8Nji
         HXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cd9wiim2w2g/X9A2/p0S6xeLGjOLXJd2upS5lm+e1Cw=;
        b=oaf5nOmIyOoFS7ICqcVxmXOrzMpFZ3yByGJZlSiox8bXiXoXCt0sOhB5YnXrzt4zSe
         XkURuiqHQrYSdr2zaaV8ow9XQkVaQ18dnf8epGUj7LlJAu8ZQZCeOmLee6yvyBxCX+vo
         ZyEt6iduEVTjRMZOXcQSykc/BYBzCRqTEtJbPEcBk+jYCq6Pc7W3kqCg8UiTTjOB2pXS
         cVnH6pw7msEikREKaRWOyqCciNhJQzfvZcr3OH4b5IBd5N9e6FjC0MhTgxK71W/+DmAL
         62jibaeahGXMhc0WXD0+rBGw8sqc+c/mwm9jo/BUEtSDD3tsNxQnTIbm7KB3K0B8DWj1
         dCtA==
X-Gm-Message-State: ANhLgQ2ftQ6eA7R4SFavPgk4Dy0H37p/wHSOhGACi6NRV0xShCMphwY/
        vqWEJfOz15Ztcqa/WgmDQEnbTxUYGn8nHgdXZeMPWQ==
X-Google-Smtp-Source: ADFU+vtNT9gHsaSgDiG+dqgs/yEhvaAY2Z0hYZpQWQB64nM6bZ8TbZ/+c9VQyhwGg8jgexW3Q+Q4IhJiFD13oEKtE2Y=
X-Received: by 2002:a54:4e13:: with SMTP id a19mr4249536oiy.108.1585069013016;
 Tue, 24 Mar 2020 09:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200323203458.24733-1-luiz.dentz@gmail.com> <20200323203458.24733-4-luiz.dentz@gmail.com>
 <90C51C98-B30D-44A6-9E87-321A4758C684@holtmann.org>
In-Reply-To: <90C51C98-B30D-44A6-9E87-321A4758C684@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Mar 2020 09:56:41 -0700
Message-ID: <CABBYNZJefwjHOJdLHe_pj6g_sZzSdAqWgprfAs3bgQOY8=ESHA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Bluetooth: Add BT_MODE socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Mar 24, 2020 at 1:44 AM Marcel Holtmann <marcel@holtmann.org> wrote=
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
> > include/net/bluetooth/bluetooth.h |   8 ++
> > include/net/bluetooth/l2cap.h     |   6 ++
> > net/bluetooth/l2cap_sock.c        | 124 ++++++++++++++++++++++++++++++
> > 3 files changed, 138 insertions(+)
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
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index dada14d0622c..56f727ba23bd 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -720,9 +720,15 @@ struct l2cap_user {
> > /* ----- L2CAP socket info ----- */
> > #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
> >
> > +#define L2CAP_PI_OPTION_UNSET                0x00
> > +#define L2CAP_PI_OPTION_LEGACY               0x01
> > +#define L2CAP_PI_OPTION_BT_MODE              0x02
> > +
> > struct l2cap_pinfo {
> >       struct bt_sock          bt;
> >       struct l2cap_chan       *chan;
> > +     u8                      option;
> > +     u8                      bt_mode;
> >       struct sk_buff          *rx_busy_skb;
> > };
>
> why do you want to store bt_mode here. Whatever we have in l2cap_chan sho=
uld be plenty.

Ive thought it would be cleaner to mess with types that comes from the
spec itself so l2cap_chan would continue to use them.

> I also looked at l2cap_sock_setsockopt_old and if you use L2CAP_OPTIONS a=
nd want to read BT_MODE, then everything should be fine. Same as setting BT=
_MODE (except EXT_FLOWCTL) and then reading L2CAP_OPTIONS is fine as well. =
We can all translate this properly and with have EINVAL return errors for n=
ot supported / disabled modes.
>
> So the only time L2CAP_OPTIONS read should fail is if you use BT_MODE wit=
h EXT_FLOWCTL as mode. So you can just check the mode set in l2cap_chan. An=
d we start using our new mode definition there and then convert it for L2CA=
P_OPTIONS.

Sure, I thought it would be more efficient to not have conversions
back and forth but Im fine either way.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

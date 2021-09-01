Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77454C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 19:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5242D6102A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Sep 2021 19:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344409AbhIATRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhIATRT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Sep 2021 15:17:19 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6BBC061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 12:16:22 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 13so116799vkl.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0FtOWpYGTkXAZYIPnjEBsicCpGfGNQucv9DkUNe1nfg=;
        b=M+ewRYAE/ivxApBVm00WP8LiseHrEDrhn2sFDCZ6KrsvCG7Eukd8sISD54DajkTubz
         wkH3/WhbEC0Oa+qdKefCHAIV4cZUyVu/Dy9wYbAoaIYa9ZTj5L24nFXzTXFLnhK1BEgA
         WteAAB/UMStpRs76XsAedbT8mVwQy/XQPJdl72gmVLwc+ShekL99bwXuJizXq8i7Rcbw
         q+fV5K3QPba9RCGypQ++eiYqvcebwwZmlGL6e2Am5VSJb/FpT8UL1/3KwAfj6I8v8SkF
         gIK8GprnZZ/pC3rJ3BiYt8voWJLliPh60/BSv+mfANPSXrzeUy6dmX1YTZ9xi0GtU/O5
         e3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0FtOWpYGTkXAZYIPnjEBsicCpGfGNQucv9DkUNe1nfg=;
        b=mY/Zj54OuBwt/ptQF7bpiEz4qc07e3iFjWP9gZgnfYm9Oc220dRwtuGD8xxIzV/nKe
         aJvlpVKyKrq5BA/0MHboxDqVWe+mViAq9Gx/1Q03PWb+BRQMIIm5HYWI8jx+ieAZCbbE
         KNBmJcO92SDUvdg0P93tEej3FyMRyZ36z2fbxGiAmpN+pMlLVh9dygmZIx52HXQMCUkW
         23LDu71qZDcc69a1TKp2DvC+60Pjy8U07ws0xMVBUXb5a8hDow6hECnzN0aUXWUdjGjm
         9OODUByIBBiDxmIYwcahO6rdARkAkTrTXMPqLrZNp2ST1W/DIhaTW6Z0TFFLkmvg2Bys
         lH1g==
X-Gm-Message-State: AOAM531x9xLHpQQxoSENz5QerND9N9rTJcrvzXfGijaiuSi7FfH15nrs
        Me4bCYsdE+FNPTZV0dV7plBuONi4jkeTe8hLqYp1FZbWCpA=
X-Google-Smtp-Source: ABdhPJwJGczUJOmdm4fo8eGbNOm3UJnXZkGLtIOYW+0Hvp3mYwqxa7kIkWoQ+bdU5GKlT/oOlod6F/RTvTytm/Knp6M=
X-Received: by 2002:a1f:7c87:: with SMTP id x129mr922496vkc.21.1630523781208;
 Wed, 01 Sep 2021 12:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210901002621.414016-1-luiz.dentz@gmail.com> <9067109F-D8FD-47E9-AD02-FB6B7DFFDB3E@holtmann.org>
In-Reply-To: <9067109F-D8FD-47E9-AD02-FB6B7DFFDB3E@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Sep 2021 12:16:10 -0700
Message-ID: <CABBYNZ+O+HQ7=464AMZBQC5Pe3h-W14AnBs1ufany6ZkKSxLkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Add bt_skb_sendmsg helper
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Aug 31, 2021 at 10:44 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> > bt_skb_sendmsg helps takes care of allocation the skb and copying the
> > the contents of msg over to the skb while checking for possible errors
> > so it should be safe to call it without holding lock_sock.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h | 26 ++++++++++++++++++++++++++
> > 1 file changed, 26 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 9125effbf448..f858efcf9f40 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -420,6 +420,32 @@ static inline struct sk_buff *bt_skb_send_alloc(st=
ruct sock *sk,
> >       return NULL;
> > }
> >
> > +/* Shall not be called with lock_sock held */
> > +static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
> > +                                          struct msghdr *msg,
> > +                                          size_t len, size_t header,
> > +                                          size_t footer)
> > +{
> > +     struct sk_buff *skb;
> > +     int err;
> > +
> > +     skb =3D bt_skb_send_alloc(sk, len + header + footer,
> > +                             msg->msg_flags & MSG_DONTWAIT, &err);
> > +     if (!skb)
> > +             return ERR_PTR(err);
> > +
> > +     skb_reserve(skb, header);
>
> I am not with you on this one since bt_skb_send_alloc already calls skb_r=
eserve in the first place.

Afaik skb_reserve can be called multiple since it just add more
headroom/reduce tailroom:

static inline void skb_reserve(struct sk_buff *skb, int len)
{
  skb->data +=3D len;
  skb->tail +=3D len;
}

The RFCOMM does exactly that:

-               skb =3D sock_alloc_send_skb(sk, size + RFCOMM_SKB_RESERVE,
-                               msg->msg_flags & MSG_DONTWAIT, &err);
-               if (!skb) {
-                       if (sent =3D=3D 0)
-                               sent =3D err;
-                       break;
-               }
-               skb_reserve(skb, RFCOMM_SKB_HEAD_RESERVE);

> /**
>  *      skb_reserve - adjust headroom
>  *      @skb: buffer to alter
>  *      @len: bytes to move
>  *
>  *      Increase the headroom of an empty &sk_buff by reducing the tail
>  *      room. This is only allowed for an empty buffer.
>  */
>
> In addition we have this comment here. So what kind of headroom do we nee=
d with this SKB?

We need the BT_SKB_RESERVE(ACL + L2CAP) +
RFCOMM_SKB_HEAD_RESERVE(RFCOMM header) +
RFCOMM_SKB_TAIL_RESERVE(RFCOMM footer) as tailroom, the len need to
accomodate all of them since they are considered part of the data
(there is no separate storage).

> And wouldn=E2=80=99t it be better to actually assign a tailroom instead o=
f just a large enough buffer?

Yep, though I think the skb_tailroom_reserve does not create a
separate area in the buffer it just marks it so the likes of
__skb_grow can grow the skb, anyway it shall be possible to use it as
well.

> /**
>  *      skb_tailroom_reserve - adjust reserved_tailroom
>  *      @skb: buffer to alter
>  *      @mtu: maximum amount of headlen permitted
>  *      @needed_tailroom: minimum amount of reserved_tailroom
>  *
>  *      Set reserved_tailroom so that headlen can be as large as possible=
 but
>  *      not larger than mtu and tailroom cannot be smaller than
>  *      needed_tailroom.
>  *      The required headroom should already have been reserved before us=
ing
>  *      this function.
>  */
>
> We also have this capability inside the SKBs.
>
> So while the basic idea of this patchset seems fine, we need to figure ou=
t the details and not overload us in spaghetti code by wanting to have a co=
mmon bt_skb_* helper. Maybe it is actually not helpful in this case since w=
e just have to have a too large parameter list to satisfy all 3 users.

Actually having proper helpers for this might actually simplify the
code since then we can enforce that both headroom and tailroom are
properly set as currently each protocol is doing this in its own way.

>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

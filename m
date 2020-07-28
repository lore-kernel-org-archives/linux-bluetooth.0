Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3A2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268D82074F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9Z78vi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgG1Qjr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbgG1Qjr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 12:39:47 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED86AC061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 09:39:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a26so6542809otf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2020 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JI0PpX5piIkrPFc0swt1AfEbX9CKzSRpIM3HPlDLtQ=;
        b=u9Z78vi+0peDj221Xa4YOQHr8pckB5dprkWcL2jrumqhE6VugTqlaOnXrkEg22k0jv
         cloYC91LL87VDOI1UDw0KuHyKyZJQ7iIROWkBfNujcfup0RP0Oa3B2mCe+lK0oE7PeD2
         296qfWPexqGTPe6Zk3LL8McvYkELx1km1JrfJutmjMUaek6kC2SyWmdNkmuBec6fMkrs
         AjNXossC7eH1KOrbjDRvIy/gSJD6jlVeV6X+QqS4womqeGMu/ONyXdSLokn6iv1pq/B1
         U95CmiN1W4yPGT39C5lNdz+qZXwoMGfNV2q259eEDT5dwXRnJcFK/png1yAglawledYX
         andQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JI0PpX5piIkrPFc0swt1AfEbX9CKzSRpIM3HPlDLtQ=;
        b=WTz0xinUmfrsNUG21xmko58yke6NC5LLq8IhRdOH1chQFcXGK+QgdhIBKzNxsX0BTK
         yhPFfU9e3TJivT6FDq4GUIV8wNDj00V4VDAk2vnlzutC6IdUNsbZdnulivUULUYJSFGu
         3jVGsayOF+2jnU3XkkV71cZf944yiN/OVaZNw5BwUT15qjQ4QcQ4lPv5CUAfdh6oq6F9
         zT1NAMJsmM4lcUycB4YniSgbJMfutJGt+2zF7t1BevmUB06Tk97xjI/gD6KDKEo5QLO4
         s2qr0vU5OzSJUZdgyzly6qESEGd+0M1nAe2xswR+acV6nJi0hBtogDGm26IB4r4qlm+d
         8KBw==
X-Gm-Message-State: AOAM531dBo+UFueDKYPIceNOLZc7L3MIKPRqfxrK9Pmd5woFNtYKDZJd
        H1+/hx83GyJsuxU0i0vgKIMEWt+B7A9OYvs2jshyBGoPtP4=
X-Google-Smtp-Source: ABdhPJxZpMfkk/kWbnT4PVJt1weLnhNP51L4W+IyBJbOK+KiC5AiJLZVDNH+hb2QUamrjDi7aaodsGeo+2hXvmu7gvo=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr5743839otj.362.1595954386257;
 Tue, 28 Jul 2020 09:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200728070428.1754257-1-luiz.dentz@gmail.com> <80073DFD-564E-4B4E-9F23-02ED4075321D@holtmann.org>
In-Reply-To: <80073DFD-564E-4B4E-9F23-02ED4075321D@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Jul 2020 09:39:37 -0700
Message-ID: <CABBYNZKJLcyJsCe9yZB6RAdtiCkpi-oMYPsJzWV_r19CJVT_Ww@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: L2CAP: Fix to handling fragmented header
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Jul 28, 2020 at 12:22 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > Bluetooth Core Specification v5.2, Vol. 3, Part A, section 1.4, table
> > 1.1:
> >
> > 'Start Fragments always either begin with the first octet of the Basic
> >  L2CAP header of a PDU or they have a length of zero (see [Vol 2] Part
> >  B, Section 6.6.2).'
> >
> > This text has been changed recently as it previously stated:
> >
> > 'Start Fragments always begin with the Basic L2CAP header of a PDU.'
> >
> > Apparently this was changed by the following errata:
> >
> > https://www.bluetooth.org/tse/errata_view.cfm?errata_id=10216
> >
> > In past this has not been a problem but it seems new controllers are
> > apparently doing it as it has been reported in Zephyr:
> >
> > https://github.com/zephyrproject-rtos/zephyr/issues/26900
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/l2cap_core.c | 104 +++++++++++++++++++++++++++++--------
> > 1 file changed, 83 insertions(+), 21 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index ade83e224567..193bea314222 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -8269,6 +8269,63 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
> >       mutex_unlock(&conn->chan_lock);
> > }
> >
> > +/* Append fragment into frame respecting the maximum len of rx_skb */
> > +static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
> > +                        u16 len)
> > +{
> > +     if (!conn->rx_skb) {
> > +             /* Allocate skb for the complete frame (with header) */
> > +             conn->rx_skb = bt_skb_alloc(len, GFP_KERNEL);
> > +             if (!conn->rx_skb)
> > +                     return -ENOMEM;
> > +             /* Init rx_len */
> > +             conn->rx_len = len;
> > +     }
> > +
> > +     /* Copy as much as the rx_skb can hold */
> > +     len = min_t(u16, len, skb->len);
> > +     skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, len), len);
> > +     skb_pull(skb, len);
> > +     conn->rx_len -= len;
> > +
> > +     return len;
> > +}
> > +
> > +static int l2cap_recv_header(struct l2cap_conn *conn, struct sk_buff *skb)
> > +{
> > +     struct l2cap_hdr *hdr;
> > +     struct sk_buff *rx_skb;
> > +     int len;
> > +
> > +     /* Append just enough to complete the header */
> > +     len = l2cap_recv_frag(conn, skb, L2CAP_HDR_SIZE - conn->rx_skb->len);
> > +
> > +     /* If header could not be read just continue */
> > +     if (len < 0 || conn->rx_skb->len < L2CAP_HDR_SIZE)
> > +             return len;
> > +
> > +     rx_skb = conn->rx_skb;
> > +     conn->rx_skb = NULL;
> > +
> > +     hdr = (struct l2cap_hdr *) rx_skb->data;
>
> so I think it is pointless to insist on getting the complete header. We really just need the first 2 octets.
>
> struct l2cap_hdr {
>         __le16     len;
>         __le16     cid;
> } __packed;

Indeed, I've totally forgotten about the cid so I will change this to
not use L2CAP_HDR_SIZE but 2 instead.

> Once we have received at least 2 octets, we can get_unaligned_le16(rx_skb->data) and then just continue.

Sure, I was trying to figure out if there is any way to grow the the
rx_skb since I will be just allocating 2 bytes for it if the header is
not available, we could perhaps take a different approach and always
allocate based on the conn->mtu that way we don't have to wait the
length to received to allocate a second skb and copy over the length
into it, obviously that would only be done if length was fragmented.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

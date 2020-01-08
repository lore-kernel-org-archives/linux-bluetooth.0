Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE2C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AF620692
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4abkLHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAHVp5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:45:57 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39758 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHVp5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:45:57 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so4069600oib.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SURLpdeJOuRUSXUnGcpJuFiA69MdchaKVdesZQ1uGF4=;
        b=b4abkLHjnGFZYpXZdEOOfkSUdfO9QGF0aZU6/zTnCPdvNAi1A33k8T0wJNkzbgg2gQ
         vgjS/8o8vtE5UPHmr7Kq0YpxXGrUUrw4NfPu/N5garwXF54/t198+YIxs0tIZEhOWVZ1
         eX6QhyibfFIP2SWkIVN4jLhaLm1gb4+BVDOijBX5UQEMX+tKaQU8WGCxUn9QUvDI8w5E
         KfPeN2gohekb2zQngF+jTyAk3Cev7jn7Flbdz7sNKLNilXC5DDVHv035Q3Mj77l9QNZ6
         Y60DlRZQWu9xhefAA5aVHlS7nYKpfbiZrNiCgNeWhlcPde2rqopAGPHbLjVHXf/d+AUL
         pixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SURLpdeJOuRUSXUnGcpJuFiA69MdchaKVdesZQ1uGF4=;
        b=FFJzAwsZ13UFlm6uv0gZyyvgnefGQiMtoK4DlvS89JcYkNSCZijwu4kr2RL+NDldQH
         h32E/v10ERlWXxIDL8k/ZgI9R0GCW/s7RnfXK4dMJSf1nEp7PSpTL4tf1eYhXYnU+5Fp
         qSIfJFFaZrSXhvVAvNjyo7BZ4D2O2i0HNdFtYtsghbKnfWHZlizGMbKETS51zaeTTZ/V
         4JiCaO5HaVkpYLsaDReN2uXGUBt6cpx5Dp1O9S2qD6PPeeOE9W/IcpEixp6+pB84Tdh9
         9r2q/KMRkisol7Z8yBiXpBON3Un/u7+ofO9Lglly5vII5JSMpDkv0OPILK5EVJdZSsRN
         TVQA==
X-Gm-Message-State: APjAAAWp5bsDxW//ZRp/iHoXMvnsl8Mk7rAkzVIa6qgLNGW4xpyHOxHr
        v778KqbOx/0bLpczickrDVYr0coJwugEA1VX8N5A+3fV
X-Google-Smtp-Source: APXvYqz/RjPy7JI4wxE9KnBsHB6tHV+dap9G3nW/b9R3R4y20K2JQ6fV2l0xJuxW4lN8RguQpf17OPBu1pdIfMlJHyc=
X-Received: by 2002:aca:4c15:: with SMTP id z21mr589828oia.8.1578519956153;
 Wed, 08 Jan 2020 13:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20200107074056.25453-1-luiz.dentz@gmail.com> <20200107074056.25453-11-luiz.dentz@gmail.com>
 <DD158910-1335-4EAF-BDDD-8C0252C3B564@holtmann.org>
In-Reply-To: <DD158910-1335-4EAF-BDDD-8C0252C3B564@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 13:45:43 -0800
Message-ID: <CABBYNZLOOq5dPTghxU9nZmEaRp7wjnTCGM472YTWMz1e0=2gTg@mail.gmail.com>
Subject: Re: [PATCH 10/10] Bluetooth: btusb: Detect if an ACL packet is in
 fact an ISO packet
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jan 8, 2020 at 1:25 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > Fix up the packet type if ISO packets are sent over the bulk endpoint.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index ded0ba83bcce..c1e030fc272f 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -663,11 +663,18 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> >               hci_skb_expect(skb) -= len;
> >
> >               if (skb->len == HCI_ACL_HDR_SIZE) {
> > +                     __u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
> >                       __le16 dlen = hci_acl_hdr(skb)->dlen;
> > +                     __u8 type;
> >
> >                       /* Complete ACL header */
> >                       hci_skb_expect(skb) = __le16_to_cpu(dlen);
> >
> > +                     type = hci_conn_lookup_type(data->hdev,
> > +                                                 hci_handle(handle));
> > +                     if (type == ISO_LINK)
> > +                             hci_skb_pkt_type(skb) = HCI_ISODATA_PKT;
> > +
> >                       if (skb_tailroom(skb) < hci_skb_expect(skb)) {
> >                               kfree_skb(skb);
> >                               skb = NULL;
>
> is this a local hack for development. We can not just look up the connection type on every packet we receive.

Unfortunately there is no dedicated endpoint for ISO packets, what I
could do instead is try to figure out if there is any ISO connection
first and only then lookup but that would still incur in lookups when
an ISO link is up.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

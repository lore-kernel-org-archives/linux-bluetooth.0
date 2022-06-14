Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE5FCCA47C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 14:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbiFNORZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbiFNORU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 10:17:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216D38D84
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 07:17:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p13so15427839ybm.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ykJCkSDmaQwuRjSNMU1SJFHZmPWM0AX/lpikFCQOxUM=;
        b=gxxmtVPdfld7TYT/I1hV+Lvzk5/ov3SJdzPCt5lLKl/8Ky9y93Vwv61PLScLaZ2qPj
         F1LTPxOhnu9ufJ5MC2A1Vnzrje1RRYDcFo7VIbhIfbUJy4S4n1iLwKJMWYfBY0dCD0za
         A2MFcEglmZ837Ge9Ofbp9npK75tDWDk44O8Pe5eCnkA8jvGTYQ5qS6Fs9LbSNLbCRFMU
         iBffFODrbAKYHUR9see0yLm10CfSpiMI4OoYna0VVWCt/+yWzWKHRkXdiMTS5895VCfw
         eW62mECaVI0HHZcu96+ekHtvWdM1d3iftQ9M9Ki8ghZ1zXJwTGSFmhmQy8ebuNQ0FIRt
         GBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ykJCkSDmaQwuRjSNMU1SJFHZmPWM0AX/lpikFCQOxUM=;
        b=22WxnxL/KWb8X9a2FHlUl2I8Dpdcy7Er+mnqRwHlIrqXR7G4B89au1qV0bt+w/yll6
         rxYJ6QPEA3ZsP+abs088pwvzePX5Wtkq4iqSA5zwViY4zWQJL957qSIJABEIiVLI/1ZZ
         6vHoyWR2aZ3XY6l/T67qjw7/KUwu3uy+tZfrvNGqLr7EY844VSKqj4m2y5Ye7f7/69XI
         UH15kH/0BHIfIhUFt9ILuVBO1BeBotNvfBUcDB02LjK2b5Fr//d8PxWvwN6J0+oosil7
         0l3+hxP29wRWTz3xKmbXieO0y86cxzKML+ivNm7f+jkIeX4OIwOf0m2CZsY2fbVjOH2A
         QbeA==
X-Gm-Message-State: AJIora+cqpP1PEPaub9bomwrdHu6sz/zLgiPkrOaGvFrpyRmZ2PWCGyY
        nCNu6iuFFSLZrkuWF+C9yxqfmWOcEfNOYanx+l15KA==
X-Google-Smtp-Source: AGRyM1sogp6JVr/ZLwK87UUL3L+3R8chDM1EO7iihKy13d9R3ODozlWUlHJF2RZKIkwqLekrFa8dq607j1nywrWJlbU=
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr5472805ybh.36.1655216237200; Tue, 14
 Jun 2022 07:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220610110749.110881-1-soenke.huster@eknoes.de>
 <CANn89i+YHqMddY68Qk1rZexqhYYX9gah-==WGttFbp4urLS7Qg@mail.gmail.com>
 <9f214837-dc68-ef1a-0199-27d6af582115@eknoes.de> <CANn89iKS7npfHvBJNP2PBtR9RAQGsVdykELX8mK8DQbFbLeybA@mail.gmail.com>
 <22131ee2-914c-3aad-d2c3-f340ad0c8ad0@eknoes.de>
In-Reply-To: <22131ee2-914c-3aad-d2c3-f340ad0c8ad0@eknoes.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 14 Jun 2022 07:17:06 -0700
Message-ID: <CANn89i+FeNoxYVTG8xu6yU_iOf94cQkrAiP=3JeUwJSvuBW5QA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: Use skb_trim to trim checksum
To:     =?UTF-8?Q?S=C3=B6nke_Huster?= <soenke.huster@eknoes.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jun 14, 2022 at 6:42 AM S=C3=B6nke Huster <soenke.huster@eknoes.de>=
 wrote:
>
> Hi Eric,
>
> On 10.06.22 18:55, Eric Dumazet wrote:
> > On Fri, Jun 10, 2022 at 8:35 AM S=C3=B6nke Huster <soenke.huster@eknoes=
.de> wrote:
> >>
> >> Hi Eric,
> >>
> >> On 10.06.22 15:59, Eric Dumazet wrote:
> >>> On Fri, Jun 10, 2022 at 4:08 AM Soenke Huster <soenke.huster@eknoes.d=
e> wrote:
> >>>>
> >>>> As skb->tail might be zero, it can underflow. This leads to a page
> >>>> fault: skb_tail_pointer simply adds skb->tail (which is now MAX_UINT=
)
> >>>> to skb->head.
> >>>>
> >>>>     BUG: unable to handle page fault for address: ffffed1021de29ff
> >>>>     #PF: supervisor read access in kernel mode
> >>>>     #PF: error_code(0x0000) - not-present page
> >>>>     RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1=
751)
> >>>>
> >>>> By using skb_trim instead of the direct manipulation, skb->tail
> >>>> is reset. Thus, the correct pointer to the checksum is used.
> >>>>
> >>>> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> >>>> ---
> >>>> v2: Clarified how the bug triggers, minimize code change
> >>>>
> >>>>  net/bluetooth/rfcomm/core.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core=
.c
> >>>> index 7324764384b6..443b55edb3ab 100644
> >>>> --- a/net/bluetooth/rfcomm/core.c
> >>>> +++ b/net/bluetooth/rfcomm/core.c
> >>>> @@ -1747,7 +1747,7 @@ static struct rfcomm_session *rfcomm_recv_fram=
e(struct rfcomm_session *s,
> >>>>         type =3D __get_type(hdr->ctrl);
> >>>>
> >>>>         /* Trim FCS */
> >>>> -       skb->len--; skb->tail--;
> >>>> +       skb_trim(skb, skb->len - 1);
> >>>>         fcs =3D *(u8 *)skb_tail_pointer(skb);
> >>>>
> >>>>         if (__check_fcs(skb->data, type, fcs)) {
> >>>> --
> >>>> 2.36.1
> >>>>
> >>>
> >>> Again, I do not see how skb->tail could possibly zero at this point.
> >>>
> >>> If it was, skb with illegal layout has been queued in the first place=
,
> >>> we need to fix the producer, not the consumer.
> >>>
> >>
> >> Sorry, I thought that might be a right place as there is not much code=
 in the kernel
> >> that manipulates ->tail directly.
> >>
> >>> A driver missed an skb_put() perhaps.
> >>>
> >>
> >> I am using the (I guess quite unused) virtio_bt driver, and figured ou=
t that the following
> >> fixes the bug:
> >>
> >> --- a/drivers/bluetooth/virtio_bt.c
> >> +++ b/drivers/bluetooth/virtio_bt.c
> >> @@ -219,7 +219,7 @@ static void virtbt_rx_work(struct work_struct *wor=
k)
> >>         if (!skb)
> >>                 return;
> >>
> >> -       skb->len =3D len;
> >> +       skb_put(skb, len);
> >
> > Removing skb->len=3Dlen seems about right.
> > But skb_put() should be done earlier.
> >
> > We are approaching the skb producer :)
> >
> > Now you have to find/check who added this illegal skb in the virt queue=
.
> >
> > Maybe virtbt_add_inbuf() ?
>
> I think here, the length of the skb can't really be known - an empty SKB =
is put into
> the virtqueue, and then filled with data in the device, which is implemen=
ted in a Hypervisor.
> Maybe my implementation of that device might then be wrong, on the other =
hand I am pretty
> sure the driver should be the one that sets the length of the skb. But th=
e driver only
> knows it in virtbt_rx_work, as it learns the size of the added buffer the=
re for the first time.
>
> >
> > Also there is kernel info leak I think.
> >
>
> I think your are right!

If this patch in drivers/bluetooth/virtio_bt.c fixes the issue, please
submit a formal patch.
You can take ownership of it, of course.

If not, more investigation is needed on your side ;)

Thanks !

>
> > diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_b=
t.c
> > index 67c21263f9e0f250f0719b8e7f1fe15b0eba5ee0..c9b832c447ee451f027430b=
284d7bb246f6ecb24
> > 100644
> > --- a/drivers/bluetooth/virtio_bt.c
> > +++ b/drivers/bluetooth/virtio_bt.c
> > @@ -37,6 +37,9 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *=
vbt)
> >         if (!skb)
> >                 return -ENOMEM;
> >
> > +       skb_put(skb, 1000);
> > +       memset(skb->data, 0, 1000);
> > +
> >         sg_init_one(sg, skb->data, 1000);
> >
> >         err =3D virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
> >
> >
> >>         virtbt_rx_handle(vbt, skb);
> >>
> >>         if (virtbt_add_inbuf(vbt) < 0)
> >>
> >> I guess this is the root cause? I just used Bluetooth for a while in t=
he VM
> >> and no error occurred, everything worked fine.
> >>
> >>> Can you please dump the skb here  ?
> >>>
> >>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.=
c
> >>> index 7324764384b6773074032ad671777bf86bd3360e..358ccb4fe7214aea0bb40=
84188c7658316fe0ff7
> >>> 100644
> >>> --- a/net/bluetooth/rfcomm/core.c
> >>> +++ b/net/bluetooth/rfcomm/core.c
> >>> @@ -1746,6 +1746,11 @@ static struct rfcomm_session
> >>> *rfcomm_recv_frame(struct rfcomm_session *s,
> >>>         dlci =3D __get_dlci(hdr->addr);
> >>>         type =3D __get_type(hdr->ctrl);
> >>>
> >>> +       if (!skb->tail) {
> >>> +               DO_ONCE_LITE(skb_dump(KERN_ERR, skb, false));
> >>> +               kfree_skb(skb);
> >>> +               return s;
> >>> +       }
> >>>         /* Trim FCS */
> >>>         skb->len--; skb->tail--;
> >>>         fcs =3D *(u8 *)skb_tail_pointer(skb);
> >>
> >> If it might still help:
> >>
> >> skb len=3D4 headroom=3D9 headlen=3D4 tailroom=3D1728
> >> mac=3D(-1,-1) net=3D(0,-1) trans=3D-1
> >> shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
> >> csum(0x0 ip_summed=3D0 complete_sw=3D0 valid=3D0 level=3D0)
> >> hash(0x0 sw=3D0 l4=3D0) proto=3D0x0000 pkttype=3D0 iif=3D0
> >> skb linear:   00000000: 03 3f 01 1c
> >>

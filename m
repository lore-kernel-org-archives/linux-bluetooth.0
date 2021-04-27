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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52491C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B1C613EE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 18:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhD0Svs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0Svr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Apr 2021 14:51:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D52FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 11:51:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j84so987460ybj.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OK7ecRtWDyzLVRL2EH1YDVA0JwiIotyKnaJSX+HDAjE=;
        b=Mp7vR0xIkN8jnZNr8vwmy7fKHGrAnoI6x2/CE12dxTrz2YIt4rqHT8TnWqGPKR0zBr
         ddr6HCD8iKcA4+q2sKHg3zJKY2pW9F6D7Iws9pibGxahf6MCWQdidFIHlpJqi2T8+w8M
         6gDacxPlBX/59q/+kXaOwjfMJnb5ehGwuNfiS4z4JxNb10mMgcQNNYDoU5183LMX8AbE
         CTEnM223ZLXTQRPDuxOxjlRokY4A1cYrO7/4N8uS+/Fq7cIjGDuLkuObY4xW6XdihWRx
         zAMhasjQrG9DMRCsbL+mN45HXR5SVVlsZZjeVFiTkCiZ+ho+xCUw8/K4vzPP9dHaC30O
         CkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OK7ecRtWDyzLVRL2EH1YDVA0JwiIotyKnaJSX+HDAjE=;
        b=ugAHtQDRekd84z5X016oVfIWbmn+WJaAlhiOPZiMdDM6SRMKiz4Hx/KydpTYchBbBK
         wqIA/QdbOHFoufWEHHKcXeSW3VEbbNNsw1Bkgyye5UF/KqVChrWxMf45tu1nYqg/7RDS
         DMymCcZuF5lqW2pLJNn4K9Qx4OxT8YO+1A7jb63P23KPLM+jnmKhduZauMnCKCNUObDT
         vzUutpMyvVIho46/KVhf4JUeCFDpq8TqgeKc/Bm2PBEf17d1DjsKmJRk7mwEjKu6tgJp
         6vqfmW081CMEP0NSv4avINbTyrpEKXtLNlOocwWLE4cYXThXwPBBJLEJDqYADBg8rE1G
         pQwA==
X-Gm-Message-State: AOAM53361rhLyRv9TuZwjBu2MzTFXHOIOeO3odxHCCuxw1q5lo3xOioG
        Kd8Q/LHcH0N7fyuah7LeryytlBwlUt5iYuNrb41gQQ6NTkzvcA==
X-Google-Smtp-Source: ABdhPJwOcJhy6EkYTjaK2K/jy1bRsO+eFiLNbdKK+azDIjHedYtDsmrN0HCn2jc7nMIiCBlR6wl8xc0jUuIrpbfo6uw=
X-Received: by 2002:a05:6902:120a:: with SMTP id s10mr35724335ybu.91.1619549463162;
 Tue, 27 Apr 2021 11:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
 <20210419171257.3865181-2-luiz.dentz@gmail.com> <25D86C94-89CE-44CC-BB9C-724486444C12@holtmann.org>
 <CABBYNZJSRN2AbLqOVEWJ1oJivn0nR59zZad5AG1LCYpghd6CmA@mail.gmail.com>
 <BB97D0B0-1006-47E0-BA9E-876A6833D5E0@holtmann.org> <CABBYNZKmsOGqtezqDzzEh=ti1Am-mGQcbGCrekEcr8JPx=TW0w@mail.gmail.com>
 <79A4150F-9DD2-4370-993F-495248D8D377@holtmann.org>
In-Reply-To: <79A4150F-9DD2-4370-993F-495248D8D377@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Apr 2021 11:50:52 -0700
Message-ID: <CABBYNZ+ONgc-AfrSUfgvWQ1h=ue3+gM0HfYA0gDAwX61EtH=bQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Bluetooth: HCI: Use skb_pull to parse BR/EDR events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Apr 27, 2021 at 11:37 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> >>>>> This uses skb_pull to check the BR/EDR events received have the min=
imum
> >>>>> required length.
> >>>>>
> >>>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>>>> ---
> >>>>> include/net/bluetooth/hci.h |   4 +
> >>>>> net/bluetooth/hci_event.c   | 272 +++++++++++++++++++++++++++++----=
---
> >>>>> 2 files changed, 229 insertions(+), 47 deletions(-)
> >>>>>
> >>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hc=
i.h
> >>>>> index ea4ae551c426..f1f505355e81 100644
> >>>>> --- a/include/net/bluetooth/hci.h
> >>>>> +++ b/include/net/bluetooth/hci.h
> >>>>> @@ -1894,6 +1894,10 @@ struct hci_cp_le_reject_cis {
> >>>>> } __packed;
> >>>>>
> >>>>> /* ---- HCI Events ---- */
> >>>>> +struct hci_ev_status {
> >>>>> +     __u8    status;
> >>>>> +} __packed;
> >>>>> +
> >>>>> #define HCI_EV_INQUIRY_COMPLETE               0x01
> >>>>>
> >>>>> #define HCI_EV_INQUIRY_RESULT         0x02
> >>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>>>> index 5e99968939ce..077541fcba41 100644
> >>>>> --- a/net/bluetooth/hci_event.c
> >>>>> +++ b/net/bluetooth/hci_event.c
> >>>>> @@ -42,6 +42,30 @@
> >>>>>
> >>>>> /* Handle HCI Event packets */
> >>>>>
> >>>>> +static void *hci_skb_pull(struct sk_buff *skb, size_t len)
> >>>>> +{
> >>>>> +     void *data =3D skb->data;
> >>>>> +
> >>>>> +     if (skb->len < len)
> >>>>> +             return NULL;
> >>>>> +
> >>>>> +     skb_pull(skb, len);
> >>>>> +
> >>>>> +     return data;
> >>>>> +}
> >>>>> +
> >>>>> +static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff =
*skb,
> >>>>> +                          u8 ev, size_t len)
> >>>>> +{
> >>>>> +     void *data;
> >>>>> +
> >>>>> +     data =3D hci_skb_pull(skb, len);
> >>>>> +     if (!data)
> >>>>> +             bt_dev_err(hdev, "Malformed Event: 0x%2.2x", ev);
> >>>>> +
> >>>>> +     return data;
> >>>>> +}
> >>>>> +
> >>>>
> >>>> so if you do it in one function, this will look like this:
> >>>>
> >>>>       static void *hci_ev_skb_pull(..)
> >>>>       {
> >>>>               void *data =3D skb->data;
> >>>>
> >>>>               if (skb->len < len) {
> >>>>                       bt_dev_err(hdev, =E2=80=9CMalformed ..=E2=80=
=9D);
> >>>>                       return NULL;
> >>>>               }
> >>>>
> >>>>               skb_pull(skb, len);
> >>>>               return data;
> >>>>       }
> >>>>
> >>>>       static void *hci_cc_skb_pull(..)
> >>>>       {
> >>>>               void *data =3D skb->data;
> >>>>
> >>>>               if (skb->len < len) {
> >>>>                       bt_dev_err(..);
> >>>>                       return NULL;
> >>>>               }
> >>>>
> >>>>               skb_pull(..);
> >>>>               return data;
> >>>>       }
> >>>>
> >>>> I realize that you want to optimize the code with hci_skb_pull, but =
I don=E2=80=99t see how that makes it simpler or cleaner. In the end you ju=
st have spaghetti code and don=E2=80=99t win anything in size reduction or =
complexity.
> >>>
> >>> Right, I can either do that or perhaps bite the bullet and convert th=
e
> >>> whole hci_event.c to use a function table:
> >>>
> >>> #define HCI_EVENT(_op, _len, _func)...
> >>>
> >>> struct hci_event {
> >>> __u8    op;
> >>> __u16  len;
> >>> func...
> >>> } ev_table[] =3D {
> >>> HCI_EVENT(...),
> >>> }
> >>>
> >>> But that would pack a lot more changes since we would need to convert
> >>> the whole switch to a for loop or alternatively if we don't want do a
> >>> lookup we could omit the op and access the table by index if we want
> >>> to trade speed over code size, with that we can have just one call to
> >>> the likes of hci_ev_skb_pull.
> >>
> >> looping through a table is not ideal. There are too many events that y=
ou can receive and if we end up looping for every LE advertising report it =
would be rather silly. And of course a static table is possible since event=
 numbers are assigned in order, but it also means some sort of overhead sin=
ce we don=E2=80=99t parse each event.
> >>
> >> In addition to that dilemma, you have the problem that not all events =
are fixed size. So you end up indicating that similar to how we do it in bt=
mon which will increase the table size again. Maybe that is actually ok sin=
ce two giant switch statements also take time and code size.
> >>
> >> So our currently max event code is 0x57 for Authenticated Payload Time=
out and the max LE event code is 0x3e for BIG Info Advertising Report. Mean=
ing table one would have 87 entries and table would have two 63 entries. If=
 we do min_len,max_len as uint8 then we have 2 octets and a function pointe=
r. Maybe that is not too bad since that is all static const data.
> >
> > Yep, even if we have to have NOP for those event we don't handle I
> > don't think it is such a big deal and accessing by index should be
> > comparable in terms of speed to a switch statement, that said we may
> > still need to do some checks on the callbacks for those events that
> > have variable size I was only intending to do minimal size checks but
> > perhaps you are saying it might be better to have a bool/flag saying
> > that the event has variable size which matters when we are checking
> > the length to either use =3D=3D or <.
>
> I actually meant min_len + max_len.
>
> So you have for example
>
>         HCI_EVENT(..) that sets min_len =3D x, max_len =3D x.
>         HCI_EVENT_VAR(..) that sets min_len =3D x and max_len =3D 253.
>
> No need for extra flags then.

Ah got it, is there really a max_len for variable size though? Or you
mean to say that should be limited to event buffer size? That Im
afraid we only discover at runtime, anyway usually for variable size
we should be using flex_array_size but that requires accessing the
received skb so we can't really tell at build time and it will be
likely left for the callback to figure out it has received enough data
or not.

>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

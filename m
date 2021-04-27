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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F90C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 17:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCA0F60FDB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 17:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhD0R6c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Apr 2021 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0R6c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Apr 2021 13:58:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29AEC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 10:57:48 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id q192so16777238ybg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hz3Pry896M21XnxSDlomPdliquxOSz/6A1EuW0FS8cE=;
        b=mRl45l7z++2f+OVsrD/cBh0S3ToZIHi3q1JambAcAezyENSQIZhvD1P95bi2Y798Jp
         Tzo8/d1qyyNLtEWcOJ8Id/oQdlRJgWY9Kf+yGgpuJSr7Z4dkPiwXG/VUyZo6xZmMtg7b
         VCXo+w4r2ceNfyxZTx4CSRUF+amqQ6GSBNUhyAxl5yNqz+ECBzLT6R6+PQlHEjWRyMc7
         FYHeGYsn8frrSRlPUuvYNHmJuYvUvzk2vHHpSxj8cCZpXkr9f5yh5dqGds0np6jzeoDS
         nShy3c964ZVNS5SkTEamNonOA4vYaZCGIcNqmi1GYaroxvwbCGjxdDPezl4FnnFqmtf6
         XLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hz3Pry896M21XnxSDlomPdliquxOSz/6A1EuW0FS8cE=;
        b=W4XJOJ6tvFJQCgINhYY5vk73yqQdhzRXsBgLS81ZNscqAstmbpJObkGuKLllCFLkVF
         ESwQtiz6nvNeM3nZ56lRgdFtLagjF+uD8JtOcz6KsvRi0SLlg6mWP22JgUb4amoryd6l
         Bbca/pg2p3rViw1xgi3fsoD6697O58jXGC9NBfdJdty7rKokj+MCw/asjtCFSfNckB+U
         ns57Tv4oeyaB3QIWx7v5DMisMKF06FhYEhBI6QI3aZrMFMecSPUA+Kk+GzMb+qaQ9p7V
         bTWuX8v3lCdBQMsvkGNVQg1RzE+eSrVMyY5zW7PhkaISKgx+8aLbY+SF/YQPXYxerR2E
         DERQ==
X-Gm-Message-State: AOAM532a99kSMI48SX5TPmJ/IakNp6nLq0KlnjoSRE7dDBJgrtd+fcFR
        6ASqbR1ej8JIzRVJ99J1ZIYh4MD6vRkL/Ns4DU28k389xaA=
X-Google-Smtp-Source: ABdhPJx4cORBbFhiiGaNWg39McXpNe3fpZ92iW/HbfLtZcYxXazxWkN6TeE3M6ykdf6hZL0VLHPC5Qm4DyW9t07v+Jo=
X-Received: by 2002:a05:6902:120a:: with SMTP id s10mr35341205ybu.91.1619546268073;
 Tue, 27 Apr 2021 10:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
 <20210419171257.3865181-2-luiz.dentz@gmail.com> <25D86C94-89CE-44CC-BB9C-724486444C12@holtmann.org>
 <CABBYNZJSRN2AbLqOVEWJ1oJivn0nR59zZad5AG1LCYpghd6CmA@mail.gmail.com> <BB97D0B0-1006-47E0-BA9E-876A6833D5E0@holtmann.org>
In-Reply-To: <BB97D0B0-1006-47E0-BA9E-876A6833D5E0@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Apr 2021 10:57:37 -0700
Message-ID: <CABBYNZKmsOGqtezqDzzEh=ti1Am-mGQcbGCrekEcr8JPx=TW0w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Bluetooth: HCI: Use skb_pull to parse BR/EDR events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Apr 26, 2021 at 11:07 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> >>> This uses skb_pull to check the BR/EDR events received have the minim=
um
> >>> required length.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/hci.h |   4 +
> >>> net/bluetooth/hci_event.c   | 272 +++++++++++++++++++++++++++++------=
-
> >>> 2 files changed, 229 insertions(+), 47 deletions(-)
> >>>
> >>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.=
h
> >>> index ea4ae551c426..f1f505355e81 100644
> >>> --- a/include/net/bluetooth/hci.h
> >>> +++ b/include/net/bluetooth/hci.h
> >>> @@ -1894,6 +1894,10 @@ struct hci_cp_le_reject_cis {
> >>> } __packed;
> >>>
> >>> /* ---- HCI Events ---- */
> >>> +struct hci_ev_status {
> >>> +     __u8    status;
> >>> +} __packed;
> >>> +
> >>> #define HCI_EV_INQUIRY_COMPLETE               0x01
> >>>
> >>> #define HCI_EV_INQUIRY_RESULT         0x02
> >>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>> index 5e99968939ce..077541fcba41 100644
> >>> --- a/net/bluetooth/hci_event.c
> >>> +++ b/net/bluetooth/hci_event.c
> >>> @@ -42,6 +42,30 @@
> >>>
> >>> /* Handle HCI Event packets */
> >>>
> >>> +static void *hci_skb_pull(struct sk_buff *skb, size_t len)
> >>> +{
> >>> +     void *data =3D skb->data;
> >>> +
> >>> +     if (skb->len < len)
> >>> +             return NULL;
> >>> +
> >>> +     skb_pull(skb, len);
> >>> +
> >>> +     return data;
> >>> +}
> >>> +
> >>> +static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *s=
kb,
> >>> +                          u8 ev, size_t len)
> >>> +{
> >>> +     void *data;
> >>> +
> >>> +     data =3D hci_skb_pull(skb, len);
> >>> +     if (!data)
> >>> +             bt_dev_err(hdev, "Malformed Event: 0x%2.2x", ev);
> >>> +
> >>> +     return data;
> >>> +}
> >>> +
> >>
> >> so if you do it in one function, this will look like this:
> >>
> >>        static void *hci_ev_skb_pull(..)
> >>        {
> >>                void *data =3D skb->data;
> >>
> >>                if (skb->len < len) {
> >>                        bt_dev_err(hdev, =E2=80=9CMalformed ..=E2=80=9D=
);
> >>                        return NULL;
> >>                }
> >>
> >>                skb_pull(skb, len);
> >>                return data;
> >>        }
> >>
> >>        static void *hci_cc_skb_pull(..)
> >>        {
> >>                void *data =3D skb->data;
> >>
> >>                if (skb->len < len) {
> >>                        bt_dev_err(..);
> >>                        return NULL;
> >>                }
> >>
> >>                skb_pull(..);
> >>                return data;
> >>        }
> >>
> >> I realize that you want to optimize the code with hci_skb_pull, but I =
don=E2=80=99t see how that makes it simpler or cleaner. In the end you just=
 have spaghetti code and don=E2=80=99t win anything in size reduction or co=
mplexity.
> >
> > Right, I can either do that or perhaps bite the bullet and convert the
> > whole hci_event.c to use a function table:
> >
> > #define HCI_EVENT(_op, _len, _func)...
> >
> > struct hci_event {
> >  __u8    op;
> >  __u16  len;
> >  func...
> > } ev_table[] =3D {
> >  HCI_EVENT(...),
> > }
> >
> > But that would pack a lot more changes since we would need to convert
> > the whole switch to a for loop or alternatively if we don't want do a
> > lookup we could omit the op and access the table by index if we want
> > to trade speed over code size, with that we can have just one call to
> > the likes of hci_ev_skb_pull.
>
> looping through a table is not ideal. There are too many events that you =
can receive and if we end up looping for every LE advertising report it wou=
ld be rather silly. And of course a static table is possible since event nu=
mbers are assigned in order, but it also means some sort of overhead since =
we don=E2=80=99t parse each event.
>
> In addition to that dilemma, you have the problem that not all events are=
 fixed size. So you end up indicating that similar to how we do it in btmon=
 which will increase the table size again. Maybe that is actually ok since =
two giant switch statements also take time and code size.
>
> So our currently max event code is 0x57 for Authenticated Payload Timeout=
 and the max LE event code is 0x3e for BIG Info Advertising Report. Meaning=
 table one would have 87 entries and table would have two 63 entries. If we=
 do min_len,max_len as uint8 then we have 2 octets and a function pointer. =
Maybe that is not too bad since that is all static const data.

Yep, even if we have to have NOP for those event we don't handle I
don't think it is such a big deal and accessing by index should be
comparable in terms of speed to a switch statement, that said we may
still need to do some checks on the callbacks for those events that
have variable size I was only intending to do minimal size checks but
perhaps you are saying it might be better to have a bool/flag saying
that the event has variable size which matters when we are checking
the length to either use =3D=3D or <.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

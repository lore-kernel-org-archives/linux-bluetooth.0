Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0667C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Apr 2021 21:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78E6611ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Apr 2021 21:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhDZVu6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Apr 2021 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhDZVuz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Apr 2021 17:50:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE34C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Apr 2021 14:50:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p126so13157566yba.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Apr 2021 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BJPx/MCBi9ssNNApKSRSVpap2r5lVRF6JH0ifvlglPU=;
        b=adJ80Jj0052KmdOyrgES8y3WEv793sninD0oyQ3XfC5dgPWKDnYGR9n7isRG7UmQjd
         emXJB1kNy/xm4HNeBcCMHtbQGRSk6hfcJ/XrImC9zZ0EwOC3ZcWyfIAUV9etHHgAjk0p
         vePuDDEh11WWEZ3P+dQreulm+kOnO5f+WzahWr3fae+nfXWS4OVt+YIDcXiLaKJslyQA
         T4JdyiA3zF/xiuDEMCLdBJF8zHkvQKRrM14KqsqSLyHYIL47XIDNhpSbB4yTOi4pL8iH
         twhFCvGh3MkJVBQAGhILQkUiyqlsBTxekK3vz5dotFNug3BBflR0+Lllnkx6P0uS6ZUI
         QFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BJPx/MCBi9ssNNApKSRSVpap2r5lVRF6JH0ifvlglPU=;
        b=gwfHZWfTS8KKfnde/hPp7TAlX31zfqtiOf5I8HaWVKWQg4mvK+KoqrcQ8SyIwMw/Td
         iJgol76ZFWTO6fY++fG8pqf98vQQjCIS4Sd0YkJ+/wGE7uQsT0Ej5Y5Q/BB+/gucjV6k
         qMMxl0e1J0yvYkGJOsV3XqceeeStbc7gZ+Wpfx1u/MFbp7+MSP+jnwEo5/PNySDvXVWr
         +YSAiNelaOsl0DTO3IYGb0+LW/XfC6T3Z7o/YyCGUSF7qMAbt3rmuCwsqBkRamvig9Cp
         FQYJvKzbI6drdFb46WfFOmi/7j6QVoIPWhWy69UxJAwkC1elr6FRGAKnrbHH2KRf3cvj
         ue5g==
X-Gm-Message-State: AOAM533/m6an9dAQofliylEMRdT6X8VZEHwvUu/3fcSVlX6oYJB9P8Ag
        CuVC+d2HZk56ofVPrCiQ3r6+Ic1VTXe8XCra/5AB+hJJMLo=
X-Google-Smtp-Source: ABdhPJzuS+47RbR+Ky86wT2yifqSENqjKsbz7m+lCviuO77zaw4amMm40BRgp7CdeQvBekcbcohEWgzJs0LpNYme/II=
X-Received: by 2002:a25:2d57:: with SMTP id s23mr3239719ybe.222.1619473811854;
 Mon, 26 Apr 2021 14:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
 <20210419171257.3865181-2-luiz.dentz@gmail.com> <25D86C94-89CE-44CC-BB9C-724486444C12@holtmann.org>
In-Reply-To: <25D86C94-89CE-44CC-BB9C-724486444C12@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Apr 2021 14:50:00 -0700
Message-ID: <CABBYNZJSRN2AbLqOVEWJ1oJivn0nR59zZad5AG1LCYpghd6CmA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Bluetooth: HCI: Use skb_pull to parse BR/EDR events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Apr 23, 2021 at 5:26 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This uses skb_pull to check the BR/EDR events received have the minimum
> > required length.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci.h |   4 +
> > net/bluetooth/hci_event.c   | 272 +++++++++++++++++++++++++++++-------
> > 2 files changed, 229 insertions(+), 47 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index ea4ae551c426..f1f505355e81 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1894,6 +1894,10 @@ struct hci_cp_le_reject_cis {
> > } __packed;
> >
> > /* ---- HCI Events ---- */
> > +struct hci_ev_status {
> > +     __u8    status;
> > +} __packed;
> > +
> > #define HCI_EV_INQUIRY_COMPLETE               0x01
> >
> > #define HCI_EV_INQUIRY_RESULT         0x02
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 5e99968939ce..077541fcba41 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -42,6 +42,30 @@
> >
> > /* Handle HCI Event packets */
> >
> > +static void *hci_skb_pull(struct sk_buff *skb, size_t len)
> > +{
> > +     void *data =3D skb->data;
> > +
> > +     if (skb->len < len)
> > +             return NULL;
> > +
> > +     skb_pull(skb, len);
> > +
> > +     return data;
> > +}
> > +
> > +static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb=
,
> > +                          u8 ev, size_t len)
> > +{
> > +     void *data;
> > +
> > +     data =3D hci_skb_pull(skb, len);
> > +     if (!data)
> > +             bt_dev_err(hdev, "Malformed Event: 0x%2.2x", ev);
> > +
> > +     return data;
> > +}
> > +
>
> so if you do it in one function, this will look like this:
>
>         static void *hci_ev_skb_pull(..)
>         {
>                 void *data =3D skb->data;
>
>                 if (skb->len < len) {
>                         bt_dev_err(hdev, =E2=80=9CMalformed ..=E2=80=9D);
>                         return NULL;
>                 }
>
>                 skb_pull(skb, len);
>                 return data;
>         }
>
>         static void *hci_cc_skb_pull(..)
>         {
>                 void *data =3D skb->data;
>
>                 if (skb->len < len) {
>                         bt_dev_err(..);
>                         return NULL;
>                 }
>
>                 skb_pull(..);
>                 return data;
>         }
>
> I realize that you want to optimize the code with hci_skb_pull, but I don=
=E2=80=99t see how that makes it simpler or cleaner. In the end you just ha=
ve spaghetti code and don=E2=80=99t win anything in size reduction or compl=
exity.

Right, I can either do that or perhaps bite the bullet and convert the
whole hci_event.c to use a function table:

#define HCI_EVENT(_op, _len, _func)...

struct hci_event {
  __u8    op;
  __u16  len;
  func...
} ev_table[] =3D {
  HCI_EVENT(...),
}

But that would pack a lot more changes since we would need to convert
the whole switch to a for loop or alternatively if we don't want do a
lookup we could omit the op and access the table by index if we want
to trade speed over code size, with that we can have just one call to
the likes of hci_ev_skb_pull.

>
>
> > static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff =
*skb,
> >                                 u8 *new_status)
> > {
> > @@ -2507,11 +2531,15 @@ static void hci_cs_switch_role(struct hci_dev *=
hdev, u8 status)
> >
> > static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> > {
> > -     __u8 status =3D *((__u8 *) skb->data);
> > +     struct hci_ev_status *ev;
> >       struct discovery_state *discov =3D &hdev->discovery;
> >       struct inquiry_entry *e;
> >
> > -     BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > +     ev =3D hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_COMPLETE, sizeof=
(*ev));
> > +     if (!ev)
> > +             return;
> > +
>
> Now since we also have this pattern:
>
>         ev =3D hci_ev_skb_pull(..);
>         if (!ev)
>                 return;
>
> The question is now why not just use a #define here.
>
>         hci_ev_skb_pull(HCI_EV_INQUIRY_COMPLETE, ev);
>
> And then the define would look like this (untested):
>
> #define hci_ev_skb_pull(evt, var) do {                    \
>                 (var) =3D skb->data;                        \
>                 if (skb->len < sizeof(*(var))) {          \
>                         bt_dev_err(hdev, =E2=80=9CMalformed ..=E2=80=9D);=
 \
>                         return NULL;                      \
>                 }                                         \
>                 skb_pull(skb, sizeof(*(var)));            \
>         } while (0);
>
>
> > +     BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
>
> If we have every event with an ev->status, we could even include bt_dev_d=
bg in the macro.
>
> >
> >       hci_conn_check_pending(hdev);
> >
> > @@ -2604,9 +2632,13 @@ static void hci_inquiry_result_evt(struct hci_de=
v *hdev, struct sk_buff *skb)
> >
> > static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff =
*skb)
> > {
> > -     struct hci_ev_conn_complete *ev =3D (void *) skb->data;
> > +     struct hci_ev_conn_complete *ev;
> >       struct hci_conn *conn;
> >
> > +     ev =3D hci_ev_skb_pull(hdev, skb, HCI_EV_CONN_COMPLETE, sizeof(*e=
v));
> > +     if (!ev)
> > +             return;
> > +
> >       BT_DBG("%s", hdev->name);
>
> If you are touching the above part anyway, then move towards bt_dev_dbg()=
 at the same time.
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

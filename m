Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C864C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375DB20674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIL0DyWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCRQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCRQG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:16:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FDAC08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:16:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z2so3296500ilq.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMCpsHUTNz4uoieqPTxZU+bogZX6IL51BPCrwDaWeJ4=;
        b=hIL0DyWKlyYLBQlEfashDCo6q/pclt1ZtHXAWa6nZyTTj/jga47K5ghpl4JPdU7NT4
         uH2t6DejbtsyBPjsXKvMTFcAeCMaN2IrollezojBQQLDjfgkl4SffjE8HcUuHFtrmYs7
         yOU+jnmjpoWojqs/Zco7ZgsR+HTIEqK0GrUa03gGzUKyyYOhfp40yYnSEaUo2QfdjcFC
         Dq44P2uzy8CQPfY/LoldMNS6XvkBfk880qLxtE9CXPX3JPaRWsqtBXuW28ZouCmk9hiT
         2U6U4EJ7R1FFLT+Lwg5kCkIscBtISmd2javPLlj175vEPna2BXhy3utz3cZO2v3kz/9r
         0fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMCpsHUTNz4uoieqPTxZU+bogZX6IL51BPCrwDaWeJ4=;
        b=fdmXwzX6nwOot7Taru5XzD+9qNp7gUL34dr6YbIwq1beq2xRG25HTDnwYVJiwwPlep
         jYVWvIxncIgXqIPe0b5B7zUnf53zFWoVsIDz1nrVOh4vmi7ZjG0za0RoeqlTacOUUC0Q
         dpHn6S4WAk76QyO0SJ5ej8aBeRr6peatsMeWWz1hKsOmzu7pjJnF8H8XDYM2jonsafkS
         9izlgDFLTyi4ufZYCCQXQDZzOsX0B1+QlV5d+NRwiyOFV7U/gMq37qd/ET2Vp3OlHzP/
         6XU+WTCV7qy/xyon6NGcjc70UcNyqvaMt75YK0iw0yck7B8tLbyn0EHHc65Ns/xlTvmz
         Ty1Q==
X-Gm-Message-State: AOAM531s5ynGJR8kdJqe7gVoixixUegXizvvqryQO3WVEVaAUiQuPRlK
        YYuSni2cbqjNIf/z4rEf7HlOfWek4752zEVvWYjptUkzlA0=
X-Google-Smtp-Source: ABdhPJzxoVjqkbB7g7QTvyujvGQzCe8hIa4REeNgfn4jT4GXQO/4kLnuPTyep0oYtnukdcIEX/uq9UNrsUpvw9GU+BQ=
X-Received: by 2002:a92:de41:: with SMTP id e1mr491988ilr.199.1591204565832;
 Wed, 03 Jun 2020 10:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200407205611.1002903-1-marcel@holtmann.org> <CAOVXEJJeriSp=5ywt4ZxND7mYY=yepShCC5U-8s8=_rWQup3wQ@mail.gmail.com>
In-Reply-To: <CAOVXEJJeriSp=5ywt4ZxND7mYY=yepShCC5U-8s8=_rWQup3wQ@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 3 Jun 2020 22:45:54 +0530
Message-ID: <CAOVXEJLEdf34P6ZHT6YYNNRtWgN-BLb4ZRiifqTC64BfKZAjYQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Update resolving list when updating whitelist
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Tue, May 5, 2020 at 6:41 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Hi Marcel
>
> On Wed, Apr 8, 2020 at 2:26 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > When the whitelist is updated, then also update the entries of the
> > resolving list for devices where IRKs are available.
> >
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > ---
> >  net/bluetooth/hci_request.c | 37 +++++++++++++++++++++++++++++++++++--
> >  1 file changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index efec2a0bb824..45fbda5323af 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -695,6 +695,21 @@ static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
> >         bt_dev_dbg(req->hdev, "Remove %pMR (0x%x) from whitelist", &cp.bdaddr,
> >                    cp.bdaddr_type);
> >         hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST, sizeof(cp), &cp);
> > +
> > +       if (use_ll_privacy(req->hdev)) {
> > +               struct smp_irk *irk;
> > +
> > +               irk = hci_find_irk_by_addr(req->hdev, bdaddr, bdaddr_type);
> > +               if (irk) {
> > +                       struct hci_cp_le_del_from_resolv_list cp;
> > +
> > +                       cp.bdaddr_type = bdaddr_type;
> > +                       bacpy(&cp.bdaddr, bdaddr);
> > +
> > +                       hci_req_add(req, HCI_OP_LE_DEL_FROM_RESOLV_LIST,
> > +                                   sizeof(cp), &cp);
> > +               }
> > +       }
> >  }
> >
> >  /* Adds connection to white list if needed. On error, returns -1. */
> > @@ -715,7 +730,7 @@ static int add_to_white_list(struct hci_request *req,
> >                 return -1;
> >
> >         /* White list can not be used with RPAs */
> > -       if (!allow_rpa &&
> > +       if (!allow_rpa && !use_ll_privacy(hdev) &&
> >             hci_find_irk_by_addr(hdev, &params->addr, params->addr_type)) {
> >                 return -1;
> >         }
> > @@ -732,6 +747,24 @@ static int add_to_white_list(struct hci_request *req,
> >                    cp.bdaddr_type);
> >         hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
> >
> > +       if (use_ll_privacy(hdev)) {
> > +               struct smp_irk *irk;
> > +
> > +               irk = hci_find_irk_by_addr(hdev, &params->addr,
> > +                                          params->addr_type);
> > +               if (irk) {
> > +                       struct hci_cp_le_add_to_resolv_list cp;
> > +
> > +                       cp.bdaddr_type = params->addr_type;
> > +                       bacpy(&cp.bdaddr, &params->addr);
> > +                       memcpy(cp.peer_irk, irk->val, 16);
> > +                       memset(cp.local_irk, 0, 16);
> Shall we memcpy hdev->irk as local_irk here.
> if  privacy (HCI_PRIVACY)  is enabled. also if controller supports
> LL_PRIVACY so that stack can utilize it.
> else continue with HCI_PRIVACY.
> Is there any drawback with this approach. please guide
> > +
> > +                       hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLV_LIST,
> > +                                   sizeof(cp), &cp);
> > +               }
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -772,7 +805,7 @@ static u8 update_white_list(struct hci_request *req)
> >                 }
> >
> >                 /* White list can not be used with RPAs */
> > -               if (!allow_rpa &&
> > +               if (!allow_rpa && !use_ll_privacy(hdev) &&
> >                     hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
> >                         return 0x00;
> >                 }
> > --
> > 2.25.2
> >

I have uploaded patch v2 with a slight modification over your patch.
can you please review
>
> Regards
> Sathish N

Regards
Sathish N

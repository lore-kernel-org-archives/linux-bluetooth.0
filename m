Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F29C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJJT0W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJJT0U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 15:26:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53186CF4F
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 12:26:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d6so17941933lfs.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+IzfqkaQR+lumGiDT6SOc/p6YG9+wojOX5AhJzrGJnQ=;
        b=U0Q6PQh8shD6oyt9iEeK7Q/OqnbGiaVFZGBeCGzZ8Lc/0s4gFqYYbgQJX5gPI3GZvd
         +IvgCk1H+TNLr3KNO2mxnFBSS2CaI5rhJ5BYGeGqpPxkMnpUp8pzmfz1npZ7UdqtUMih
         54ELmls+y/atiL/cWSzMv69PfQaPoCcxNUssjO5LxmBLFh0ZLF0zQNNeBrrLmRjAY/Vw
         SPiII2totgt+oJMCQMJ2NmlcTbs4PI5kYpLZhML/Wgp+I757QpD00Vr4dKoEg+w/APLF
         TMGAu7wSOn3sM9kMrKjgDDE7ppclfkPQ1YJoLRnVKb36b7Gw9LiHCdU+v1m77GVLxMPF
         k1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IzfqkaQR+lumGiDT6SOc/p6YG9+wojOX5AhJzrGJnQ=;
        b=fxjvs9yt0WmGkrtSbaTf5bCuDQiMPWrtvp8/ywAWUGWt+v0p9vkjgzDePOwG9Y7j8C
         1z8NauD/vjcdesGf2JYWHTyGXOw9pmy4tuQZBZt6d+4TFBy2dMU+3l8uNNcof9QL+FW6
         ph1FYxNVzBfc2urfR/9HdoPjZg7SLi0lJiiN7Vsm7oWilqvqdCeJDvbAS9LFARx0wA+F
         zoWJBDHUkoqmOLH1Hfg90wDPTVgqXVNy4CLA5nsqBfjgCklO/AVvE7CvwtHlw38i+wM+
         qgN07CNspecjALLYAFOEDgoAhnMq8uh8OeDFDsn0VyN2/UOTfiGRpe48dQn7aKSG2s59
         V7ew==
X-Gm-Message-State: ACrzQf1Xs79urm+LsYkhvO3sMNv7eoI4gqWRuoKG5PKQkZH4ehnUkA1c
        A9kK7has3FdzWvqtnuNuCzetBlMgIAgRkClzgMY=
X-Google-Smtp-Source: AMsMyM6vhzdccQejYkhcSL2zKg4BTkIUViNVcueKFhTXhWoy+6s+Oli+u2Ew6tRISB426hFA8QHit39oS48e/AuV/kY=
X-Received: by 2002:ac2:5f56:0:b0:4a2:40f6:266c with SMTP id
 22-20020ac25f56000000b004a240f6266cmr6934678lfz.564.1665429970916; Mon, 10
 Oct 2022 12:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221009174216.17533-1-pav@iki.fi> <CABBYNZ+KzN_4w2x4en+fXP+SqwA5-WF_SNL_Q7dRmiCN1JQLNw@mail.gmail.com>
 <71ac3f7a801192980142beb34d618770802d9a4c.camel@iki.fi>
In-Reply-To: <71ac3f7a801192980142beb34d618770802d9a4c.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Oct 2022 12:25:59 -0700
Message-ID: <CABBYNZLCN+SCw4N6T=ytgk4w48PFDJot528o26D5feBm1tD+4Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix CIS connection dst_type handling
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Oct 10, 2022 at 12:08 PM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> su, 2022-10-09 kello 14:45 -0700, Luiz Augusto von Dentz kirjoitti:
> [clip]
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index 9777e7b109ee..78d8b8b7fd72 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -1691,12 +1691,19 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
> > >  {
> > >         struct hci_conn *cis;
> > >
> > > +       /* Convert from ISO socket address type to HCI address type  */
> > > +       if (dst_type == BDADDR_LE_PUBLIC)
> > > +               dst_type = ADDR_LE_DEV_PUBLIC;
> > > +       else
> > > +               dst_type = ADDR_LE_DEV_RANDOM;
> > > +
> > >         cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
> > >         if (!cis) {
> > >                 cis = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
> > >                 if (!cis)
> > >                         return ERR_PTR(-ENOMEM);
> > >                 cis->cleanup = cis_cleanup;
> > > +               cis->dst_type = dst_type;
> > >         }
> > >
> > >         if (cis->state == BT_CONNECTED)
> > > @@ -2075,20 +2082,21 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
> > >  {
> > >         struct hci_conn *le;
> > >         struct hci_conn *cis;
> > > +       u8 hci_dst_type;
> > >
> > >         /* Convert from ISO socket address type to HCI address type  */
> > >         if (dst_type == BDADDR_LE_PUBLIC)
> > > -               dst_type = ADDR_LE_DEV_PUBLIC;
> > > +               hci_dst_type = ADDR_LE_DEV_PUBLIC;
> > >         else
> > > -               dst_type = ADDR_LE_DEV_RANDOM;
> > > +               hci_dst_type = ADDR_LE_DEV_RANDOM;
> >
> > Nice catch, though I think we should make sure these types are not
> > from hci_conn.c as the name suggest these should be dealing HCI
> > procedures so it doesn't make much sense to propagate types other than
> > HCI.
>
> Not sure I parse right: You want to move the conversions to the
> callsite in iso.c? Or change the variable name here? If the former,
> there are a few other instances of these in hci_conn.c.

Lets move to iso.c and make the conversion before the calls into hci_conn.c.

> > >         if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
> > > -               le = hci_connect_le(hdev, dst, dst_type, false,
> > > +               le = hci_connect_le(hdev, dst, hci_dst_type, false,
> > >                                     BT_SECURITY_LOW,
> > >                                     HCI_LE_CONN_TIMEOUT,
> > >                                     HCI_ROLE_SLAVE);
> > >         else
> > > -               le = hci_connect_le_scan(hdev, dst, dst_type,
> > > +               le = hci_connect_le_scan(hdev, dst, hci_dst_type,
> > >                                          BT_SECURITY_LOW,
> > >                                          HCI_LE_CONN_TIMEOUT,
> > >                                          CONN_REASON_ISO_CONNECT);
> > > --
> > > 2.37.3
> > >
> >
> > While at it probably makes sense to introduce a test to iso-tester
> > that uses random address rather than always using public, that way we
> > can make sure we exercise this code with CI.



-- 
Luiz Augusto von Dentz

Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1148C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE35220692
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BecWQZoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgAHVsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:48:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46405 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHVsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:48:00 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so2188239oij.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1SvIK25J4N8jsurn+gfP9nDUl0NimbgIZiClQ1wjsQ=;
        b=BecWQZoJ/H5x5qX49sQUnXALkyuIsm5ep/CRQw3+5ORt40sY8JDOqeziTBRVos+zl9
         +RN2s0flo9c5ch49d008uA1ctqOVuxemHZ6nEcP7GRdIuBRF1ZGuTXKOHuH31nxkMXC/
         90mZprN3yVbXD3ZtJU9LYpDNwYf7buXbqbz6NRgHYP/LtpNWTTQRXGZNR8ECx7Rotf23
         a2MyndsZpYWJpRqC8JFRThb2OYJTqf0jhLtgTZxzLZCs9xWE+YkmrTaZusxiDeMxeMom
         1HLxEBRgtyUYSZCmN621SQr8fTuaKMcAKvNKHkcoHLzUI19GG/mWJdASvfzgYvhiB6f2
         4y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1SvIK25J4N8jsurn+gfP9nDUl0NimbgIZiClQ1wjsQ=;
        b=iT01vwZbw2QNEhty29cl0kcbV2HBR+CZ4c4EyRbtncgiJs+T94sR7lQi7M7KfGu4oN
         pbuUmcXGzPcwVYuT2chz3GUwnrsUzaC35dLasCSJ3DLRCKpOhyOtURC0ba6ZJoBakSVS
         XXqQPIYmqcaMTFjOYO7O3iF63C4PqJrAQspnp+ML6f7lHwPxS1K3hVeNUaTHSxMEInZU
         ASiubzGMx8McE37SOX+WtO5bbwYizUsjnZgj49iJnUCn+Y5jaIHabX80aPRMuwUloYIs
         8A61TIG7WQmww7KOFGBykkKw3EM/PnQx3jW2VJnTIa3dzgoRo0TWeWyBD5K+Q9BKBYp3
         +5cQ==
X-Gm-Message-State: APjAAAVJZHELT49dHTohPp6FkGpcBrN4DWcIizSDLszzkpGwe75FlbQF
        s1+jItoUhnHoOp60npXM7iHKwClTMYCNbQ4vciI5WELZ
X-Google-Smtp-Source: APXvYqyboTYxfTMHY9qbPpXRqL98o98dBTrd8MiX61COaHWNK8E7DUZfE1iLZrZvBfE0k3d299XyWOcYubPdxhwqw3o=
X-Received: by 2002:aca:481:: with SMTP id 123mr622572oie.110.1578520079936;
 Wed, 08 Jan 2020 13:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20200107074056.25453-1-luiz.dentz@gmail.com> <20200107074056.25453-9-luiz.dentz@gmail.com>
 <F1F4DBA5-9A69-4C09-9359-02DAE70C7403@holtmann.org>
In-Reply-To: <F1F4DBA5-9A69-4C09-9359-02DAE70C7403@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jan 2020 13:47:47 -0800
Message-ID: <CABBYNZJGQaf16YYUkZLTHMxY7Wmawq-t8CzK9dVa80dv+isnEQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] Bluetooth: hci_h4: Add support for ISO packets
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jan 8, 2020 at 1:23 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This enabled H4 driver to properly handle ISO packets.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/hci_h4.c   | 1 +
> > drivers/bluetooth/hci_uart.h | 7 +++++++
> > 2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> > index 19ba52005009..6dc1fbeb564b 100644
> > --- a/drivers/bluetooth/hci_h4.c
> > +++ b/drivers/bluetooth/hci_h4.c
> > @@ -103,6 +103,7 @@ static const struct h4_recv_pkt h4_recv_pkts[] = {
> >       { H4_RECV_ACL,   .recv = hci_recv_frame },
> >       { H4_RECV_SCO,   .recv = hci_recv_frame },
> >       { H4_RECV_EVENT, .recv = hci_recv_frame },
> > +     { H4_RECV_ISO,   .recv = hci_recv_frame },
> > };
> >
> > /* Recv data */
> > diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> > index 6ab631101019..4e039d7a16f8 100644
> > --- a/drivers/bluetooth/hci_uart.h
> > +++ b/drivers/bluetooth/hci_uart.h
> > @@ -143,6 +143,13 @@ struct h4_recv_pkt {
> >       .lsize = 1, \
> >       .maxlen = HCI_MAX_EVENT_SIZE
> >
> > +#define H4_RECV_ISO \
> > +     .type = HCI_ISODATA_PKT, \
> > +     .hlen = HCI_ISO_HDR_SIZE, \
> > +     .loff = 2, \
> > +     .lsize = 2, \
> > +     .maxlen = HCI_MAX_FRAME_SIZE \
> > +
> > struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
> >                           const unsigned char *buffer, int count,
> >                           const struct h4_recv_pkt *pkts, int pkts_count);
>
> there are a bunch of drivers that should be able to handle packet type 5. We should fix them all.

Indeed, I haven't looked into drivers I didn't have any means to test
but in theory that should be straight forward to support the new type
so I will try to add support to them as well.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

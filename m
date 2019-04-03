Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A7C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 22:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BF72075D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 22:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5obEfNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDCWvb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:51:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46061 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDCWvb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 18:51:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so182663pgk.12;
        Wed, 03 Apr 2019 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i71Hlyh8EaHuelWNVV73aUTyWKghZfNb+372daTbEso=;
        b=t5obEfNcbkOAS7kXOnPUcZOl7Ge/BiOD9A+cKZjAKPyShSiCU2/fA94RxmA2UFDRGc
         N3KD7pDPQnUzhjGpLLNg7FZXFVVtok8EQEv3RQaKbuRVhOU++y1lv8FRdkwO20lsHHS7
         S0vz1r29Cnn2BJuAaRZ6O06PisxXHFlfy2z7CdO4W19NPH0B8pwnpCdUlB4ubjGniLeD
         Dqy5LA/KS3BoJ+XmkjpeE6WUc3xl7h09maErb1hBm4uA6+PclY2DAg+dYdVydipcJ6pd
         IU/jBVRqZTEMBAkjcx+8J0emQoCBuEUewC3xkgQeTxNmDeJ2i6QwDhzEJBGYDC4jJM0j
         mxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i71Hlyh8EaHuelWNVV73aUTyWKghZfNb+372daTbEso=;
        b=FGkyYDbTaA7CWM5M4XjuMGK+yP4Lypq22zItC0KbDUrtRHUSDiSyyYLgYIegm7K+gh
         r1C4Y3W1zD0/0zdyhXrvoauEqMopJ16YWdUjB15BaTxVrikAMiur+ya8TLJuHaOPKqeW
         r7c9t1GtzUfi5afKX4vYOV+ksSfZ6a2Spnvb8dDeISAnFK8IWqWpaSsQbdBBD2nZlSFx
         ffhX6HTfWOCYlxtfPXW7XZwvz2jp3kLyBr8y9xlalfsy+1GnOYydWNGpkxVjZrYo/j+N
         fk4MMgamIknpMFkCzj0fBoQ4sVELEC4md17JEIk4a9DflWC/R/4p4OmCX9F/q+uM/uog
         tnsw==
X-Gm-Message-State: APjAAAXSMaDnbP8R//tS7cgTjg3V+CrhWMhgN4vE8eRdHcnwYSrwrQo2
        jrZJ4NsZWhf2u6353VXzL5spFbTXh0LixLiHtkw5TyBo
X-Google-Smtp-Source: APXvYqzL+HMTNCLBPEoSpqxpeucnrGVXMHYtqdmlH0fefMVAi9iMP5RqFQ859/8y+b1P0DOIF3FrTdbFy092o2mjwKw=
X-Received: by 2002:a62:4ec8:: with SMTP id c191mr2147470pfb.138.1554331890618;
 Wed, 03 Apr 2019 15:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190330072511.GA5502@kadam> <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam> <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402201322.GG32613@kadam>
In-Reply-To: <20190402201322.GG32613@kadam>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 3 Apr 2019 15:51:18 -0700
Message-ID: <CAM_iQpWjwOwawBN3yiZ0F-B-HDSOW8KGfpLGhAsf5yE0A=wtDA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV events
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 2, 2019 at 1:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Apr 02, 2019 at 10:42:38AM -0700, Cong Wang wrote:
> > > Btw, get rid of all the likely/unlikely() macros.  Then the other style
> > > comment would be don't move the "ev = (void *)skb->data;" assignments
> > > around.  It's ok to say:
> >
> >
> > Similarly, pskb_may_pull() may reallocate skb's, although very unlikely
> > for bluetooth case (skb's are linear). At least it doesn't harm anything
> > we move the skb->data dereference after pskb_may_pull().
> >
>
> It harms readability.

Why? I can't see how it harms readability if you have pskb_may_pull()
in mind that it potentially reallocates skb->data.

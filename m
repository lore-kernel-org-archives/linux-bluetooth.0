Return-Path: <SRS0=lHyt=SE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB3C4360F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022B02082C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Apr 2019 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckp5jWU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfDBRmv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:42:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40387 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfDBRmv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Apr 2019 13:42:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so3646902plr.7;
        Tue, 02 Apr 2019 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01FTVkSdk3vYzX/BKJroxt1kGJIrVWQuYeYIyvWINfg=;
        b=Ckp5jWU627R+kJofzuQIJ7cCD25W/CxqsrB1Jk8WOpU7uwUjTWNn2bsIEa1USyEAtJ
         6tKYC28Ohdi4JyTLAFu6ShiRGoTiwy5i4gT94ufoKA9t7slTo94lmMnYMmdxBm99dsbe
         O84bmfQEk+bB22yn94bclpTXfhxohQR3ssYSvh9+D/6Vv7Co240DN0zwatwk5vLruBTY
         4vCArjot5/F17OupVL0f/9wUi/CrWK+1TbUyOfCedJ2+ntf/eP/mE213391vGIygbXEq
         em6RSI2FwWeo43akHu7IZeXH77r9+PYy2jRtvIgJSi46udf/9xXjj1/RHyPZsURRh63j
         1cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01FTVkSdk3vYzX/BKJroxt1kGJIrVWQuYeYIyvWINfg=;
        b=ppZJthYh4y3F670QevOgP1sYVnLbUboN/oWMBewpsjoMzvSKo4sqy5iHhLhcrD7+yp
         6+D3avPgEvG2Q8UbHqWK8vxT/CYaYdrgNTJ3v9DsuTVNVoolZXawzQbmyDc3oILNUlMj
         Aw1+gq0klc9h1p1BXJdV89A9OgLYK//rYuCE9+O7raf5EnmTZU8kS7mhjI4ZpQBdUYBy
         oodAwfZGWS8OClQ6kZ7qlTEjvrny8IEjCCfBj3dW6lQbXhxcM7Un3i2qRKD+D5jInsjc
         hXRGQKak3zqzwBfWjjZbAlt17itbVxU2H3ZkytgwVrOe9Gu7QnzlLCjM7QiV4vDPMoO9
         J5JA==
X-Gm-Message-State: APjAAAXDSVWt7GsTRcPlpqQ0FcL3gstjFJiE+jFBaZlJ2n+rrnGiXNWM
        xGiIE8DMG2wXkyMQsYj4/v70+dwivMcMIitHOZc=
X-Google-Smtp-Source: APXvYqyEHKdR23S2mfnFwVa/6PQZuLDFrxDy3Nb6u0abuLDd4W3q01Wwz+2FyAW1LL+PaJLdm+XHrgPS9fd5j0dG17A=
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr72300255pla.267.1554226970307;
 Tue, 02 Apr 2019 10:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190330072511.GA5502@kadam> <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com> <20190402063313.GA32613@kadam>
In-Reply-To: <20190402063313.GA32613@kadam>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 2 Apr 2019 10:42:38 -0700
Message-ID: <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
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

On Mon, Apr 1, 2019 at 11:33 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Apr 01, 2019 at 11:03:53AM -0700, Cong Wang wrote:
> > Hi,
> >
> > On Sat, Mar 30, 2019 at 2:23 AM Tomas Bortoli <tomasbortoli@gmail.com> wrote:
> > >
> > > Hi Dan,
> > >
> > > On 3/30/19 8:25 AM, Dan Carpenter wrote:
> > > > There is a potential out of bounds if "ev->length" is too high or if the
> > > > number of reports are too many.
> > > >
> > > > Fixes: c215e9397b00 ("Bluetooth: Process extended ADV report event")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Reviewed-By: Tomas Bortoli <tomasbortoli@gmail.com>
> >
> > I sent a patchset to fix all of this kind of OOB:
> > https://marc.info/?l=linux-netdev&m=155314874622831&w=2
> >
> > Unfortunately I get no response...
> >
> > Does any of you mind to look at them?
> >
>
> I don't know the rules...  When is it ok say:
>
>         if (skb->len < sizeof(*ev))
>                 return;
>
> and when must we say:
>
>         if (!pskb_may_pull(skb, sizeof(*ev)))
>                 return;


The rule is simple: pskb_may_pull() always knows better. In bluetooth
case, they are actually equivalent, as the skb's in bluetooth are linear.


>
> Btw, get rid of all the likely/unlikely() macros.  Then the other style
> comment would be don't move the "ev = (void *)skb->data;" assignments
> around.  It's ok to say:


Similarly, pskb_may_pull() may reallocate skb's, although very unlikely
for bluetooth case (skb's are linear). At least it doesn't harm anything
we move the skb->data dereference after pskb_may_pull().

I think these likely()/unlikely() are reasonable, ill-formatted packets
are rare cases, normal packets deserve such a special care. We
use likely()/unlikely() with pskb_may_pull() in many places in
networking subsystem, at least.

Anyway, if you don't mind, I can resend my patchset with you Cc'ed.

Thanks.

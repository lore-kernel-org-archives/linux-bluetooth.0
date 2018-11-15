Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A1C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 15:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D512146D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 15:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="GlWzlLGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D512146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeKPBwF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:52:05 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41842 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBwF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 20:52:05 -0500
Received: by mail-vs1-f67.google.com with SMTP id t17so11908344vsc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 07:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgRNrOsOPNB188sQ8k81AXfFaeSIBbP5rW3HbvhbZcM=;
        b=GlWzlLGGuHpSgDBbZ9MHoAxmdmu/J2MuL5Bvf+EXkbMrzeaEqNmTEcutZ/asqtzePR
         pd+HttdRV6Zo0ylivw9I5Bq4A0uix2+m0RvmmEsXRfNTgPqop3JnBz8VZSGPsDC2IjLd
         FLGQYArGj5cMnKW8Rw84EbooqKoUPzfAFxVT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgRNrOsOPNB188sQ8k81AXfFaeSIBbP5rW3HbvhbZcM=;
        b=HUTJ/0G8aOaxSJhLiw1bItvURExwbchBO1SXQnLqBP7lIE7Vp8+GKU8Znj+Kx/HXuX
         J5lsdGC6n3ydvCufWNJTwF3SL5iXbiCkMv8MpeCT8kFdyNLd8pi/boPWnQXyrbDkaMM4
         90xzUDbW7XX1aSMT9YM3m4bdvySdVw47LKf7Sfy/fIHzNXLBD3rZerUtVKke1NBSzSGD
         MD7ZB1/dnpK1hP1Q/pqz6jT4Rta4oMYdXUQxUnUBjVAp6kxHzDPBLRopjH5p+M0dcZMB
         7XJj0W35FWyxlfk8/GnGxnAN+S0L+UR9Lxewa2NGvXk2MV8kO0GaBaXHRI0aExGZ76P4
         RBMg==
X-Gm-Message-State: AGRZ1gKo8Pr0eiSo7h63EGlljDixqG6Yrv9LUS8d71WHczn3wWZTTtgL
        z5BUfp6QBaK5neDiDXgb5d441i0yuphD7DxxekHk0g==
X-Google-Smtp-Source: AJdET5crkd8qJMd50+Db7v8ijNM1EVyaguqxpJmeELTPsMjWnNGX+5H1lri7tsOjMlGjXqE5wVmfdstyT3pWwnQJfog=
X-Received: by 2002:a67:105:: with SMTP id 5mr2815465vsb.183.1542296623980;
 Thu, 15 Nov 2018 07:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20181115083817.20986-1-gbenhaim@augury.com> <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
 <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com>
 <9007400A-D10D-4906-AB75-6D6395AF98FD@holtmann.org> <CAHotPr9Jb3Prqk_tkaeTRsJk0VgsGWbj8tsSdEp-Q9mb9Dt=-A@mail.gmail.com>
 <CAHotPr-BO=RE6HZYWsC1+MT9oSZ58Xf-8XLz53BJq0Z6Em9Hsw@mail.gmail.com> <CAO1O6seRNsBvz_sdZHKZhSYc3wbeZPOf-_0qXEG6PAnom0qcvA@mail.gmail.com>
In-Reply-To: <CAO1O6seRNsBvz_sdZHKZhSYc3wbeZPOf-_0qXEG6PAnom0qcvA@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Thu, 15 Nov 2018 17:43:32 +0200
Message-ID: <CAHotPr_3F-wCDyKryYa-K_=tmLP7cwRDqhbzWNDJ2P7EmYxRVg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
To:     emil.lenngren@gmail.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

should it be added to setup_signalfd in main.c ?

On Thu, Nov 15, 2018 at 2:56 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
>
> Den tors 15 nov. 2018 kl 12:55 skrev Gal Ben Haim <gbenhaim@augury.com>:
> >
> > I submitted a different patch -
> > https://marc.info/?l=linux-bluetooth&m=154228281730667&w=2
> > On Thu, Nov 15, 2018 at 12:20 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > >
> > > I can try to create another patch for it
> > >
> > > On Thu, Nov 15, 2018 at 12:18 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > > >
> > > > Hi Gal,
> > > >
> > > > > io_send can use poll and check for POLLOUT and POLLRDHUP before
> > > > > writing to the pipe
> > > >
> > > > that should be done anyway since code that writes to a pipe descriptor (or socket for that matter) without checking that it is still valid is broken code.
> > > >
> > > > Regards
> > > >
> > > > Marcel
> > > >
>
> Even if you first check for writability with poll, you still need to
> also ignore the SIGPIPE signal, since the connection could be reset
> after the check is made but before the write is executed, I guess. But
> the "signal(SIGPIPE, SIG_IGN)" should usually be made once at
> application initialization.
>
> /Emil

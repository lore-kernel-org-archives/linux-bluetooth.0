Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9195AC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC4D2086C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="JBiUuLqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC4D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbeKQFcO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:32:14 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34861 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 00:32:13 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so14376112vsc.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 11:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7FBZN72cICJGv/KWbFSo63/QIIWi45/uQgrOhU1+Ic=;
        b=JBiUuLqMuWLw5Gcvf+Z6LUHuRxpKqhU9MyOr81nshrwNbuYMlPgD7ZjWcdOf3hWO9R
         L1nHfFtPL7nfuwmAjAz2DRo/YFmb3vkN5BFTBFke8rDSB7fPpG6JpUXD6B9diYVvINoZ
         xWDZcmjECmiWXJJkWDX3OxX8NTQ5BWNoi3VS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7FBZN72cICJGv/KWbFSo63/QIIWi45/uQgrOhU1+Ic=;
        b=Jy2lNAMHL/jbiLfA65fo7o+8CkZ7v1girhS1BRZMo8JX/mVHcv8AnWLwjq8nYoTYN0
         KMQ3DERWgsQ/2pw1F+q4dkwQGhFYeB3lTp1o/aJQf4i5MjKK+FnzJtxUQk3TV656u/GV
         VLkmZGGoZHjaEq9RjMWjds4yIKqqOAIY3g4BG/dRXSoPNnZP+dLwMJB5XH2BxJw8mWkn
         ljFZOyZpxSHBLPhRRACXqf7jQvJTX48FWEpjc32pXv8p0ABFs+kv0bX5SN0CvtI8C3QU
         bXsltoX2nbjuXjZhHVaak2Bi8v/CHgY81uO2R7Lf2uS3OYj8dgUqM2/qP4EtHX+RL4zN
         0XxQ==
X-Gm-Message-State: AGRZ1gLhw7pZKgB3bCvtPSW2fucSWFJmUL1wJiJCi8mMMS/awkm3pMnJ
        fwEOoeW02Mp25Azi3PlbKQz3vudcSGq5hJKqe/qEQA==
X-Google-Smtp-Source: AJdET5cCkkFbClAYa1sARrYyLjIjeU0eCohGGvw8weD32JusR1cQCSmxqihov8o6JqNSwyOqVagW8q1mtuATFSgPIsk=
X-Received: by 2002:a67:10c3:: with SMTP id 186mr5140123vsq.209.1542395913589;
 Fri, 16 Nov 2018 11:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20181115083817.20986-1-gbenhaim@augury.com> <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
 <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com>
 <9007400A-D10D-4906-AB75-6D6395AF98FD@holtmann.org> <CAHotPr9Jb3Prqk_tkaeTRsJk0VgsGWbj8tsSdEp-Q9mb9Dt=-A@mail.gmail.com>
 <CAHotPr-BO=RE6HZYWsC1+MT9oSZ58Xf-8XLz53BJq0Z6Em9Hsw@mail.gmail.com>
 <CAO1O6seRNsBvz_sdZHKZhSYc3wbeZPOf-_0qXEG6PAnom0qcvA@mail.gmail.com> <CAHotPr_3F-wCDyKryYa-K_=tmLP7cwRDqhbzWNDJ2P7EmYxRVg@mail.gmail.com>
In-Reply-To: <CAHotPr_3F-wCDyKryYa-K_=tmLP7cwRDqhbzWNDJ2P7EmYxRVg@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Fri, 16 Nov 2018 21:18:22 +0200
Message-ID: <CAHotPr9S0b_i9_Wj-swQoRHBe2qOQ_pZx7XmLLJ2sQTeABaycQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I submitted another patch that does it in src/main.c -
https://marc.info/?l=linux-bluetooth&m=154239570400752&w=2
On Thu, Nov 15, 2018 at 5:43 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> should it be added to setup_signalfd in main.c ?
>
> On Thu, Nov 15, 2018 at 2:56 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
> >
> > Den tors 15 nov. 2018 kl 12:55 skrev Gal Ben Haim <gbenhaim@augury.com>:
> > >
> > > I submitted a different patch -
> > > https://marc.info/?l=linux-bluetooth&m=154228281730667&w=2
> > > On Thu, Nov 15, 2018 at 12:20 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > > >
> > > > I can try to create another patch for it
> > > >
> > > > On Thu, Nov 15, 2018 at 12:18 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > > > >
> > > > > Hi Gal,
> > > > >
> > > > > > io_send can use poll and check for POLLOUT and POLLRDHUP before
> > > > > > writing to the pipe
> > > > >
> > > > > that should be done anyway since code that writes to a pipe descriptor (or socket for that matter) without checking that it is still valid is broken code.
> > > > >
> > > > > Regards
> > > > >
> > > > > Marcel
> > > > >
> >
> > Even if you first check for writability with poll, you still need to
> > also ignore the SIGPIPE signal, since the connection could be reset
> > after the check is made but before the write is executed, I guess. But
> > the "signal(SIGPIPE, SIG_IGN)" should usually be made once at
> > application initialization.
> >
> > /Emil

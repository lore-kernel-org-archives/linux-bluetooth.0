Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6395FC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888920854
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 10:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="MAunkMn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2888920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeKOUXd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:23:33 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34354 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeKOUXd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 15:23:33 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so11394782vsi.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BF9NLAeKtfYvP1GvpNNhkaPJ7bFbonWuMRbiCCMyFig=;
        b=MAunkMn/evzYcdU4pbSWIhEcnaeBkx6kCk2nFkYlCEo924zz4PYfktNOLulxMz9zsn
         Hyq72v8c6mQ8oqo7XuwN2D09TLsoei1JWwg1hJKrJUojpDcigPzvP71osld5i1AJWGX3
         rf1Ew4jS4DDOudySg5wzd+E5pYorQbBdaGo+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF9NLAeKtfYvP1GvpNNhkaPJ7bFbonWuMRbiCCMyFig=;
        b=RA7OClrMinNAvFNYaObwZ10yMkDGfgNWEOQrgENiLaeDyum6xbNQO0pncnazqgNoq6
         8GEl8SlxJkkihuXV2ldGR4yGsoRNCkZKFQ2UsuTx0TOWxaCeMHU4OXwdE7ptSUti8OZ5
         LMw3Ud9CrlUcZat2B2zgUtx3Orc6rcS9fRAza1bNzuA4Vx7nBJ+GMQN/42KEOmg8VLyy
         FP8nLlwrczZ/4/Ne2hD0Dwdna8eUHMh/9eZ25K4xrmj4KMlYspwoNYBXWsUBNtAIARyn
         ka6cTHAwkcK+a++zjv6K5zmtfk0cyw2eJwt7HjHArcC009tJAr9RfxTV4X1JmySJjbzc
         scCw==
X-Gm-Message-State: AGRZ1gLQxfEs053B0DwVWIuSxriikwECAdzzlMbHdJy+VQHq7DLeOHwa
        yOSoTOkLOLUiYfMfJkJuyveFYnHOfaQWhqoJKQLK/A==
X-Google-Smtp-Source: AJdET5ekIbbR2jRtcbpy/0O+4B6wbVkXZmgpiRc2HPjYZyXtTr0Cew3Vt9CVl+dAwD+aPgPrq+UuGKhi2qG7FPCYIvc=
X-Received: by 2002:a67:e81:: with SMTP id 123mr2126578vso.43.1542276980447;
 Thu, 15 Nov 2018 02:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20181115083817.20986-1-gbenhaim@augury.com> <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
In-Reply-To: <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Thu, 15 Nov 2018 12:16:09 +0200
Message-ID: <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

io_send can use poll and check for POLLOUT and POLLRDHUP before
writing to the pipe

On Thu, Nov 15, 2018 at 12:12 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
> On Thu, Nov 15, 2018 at 10:41 AM Gal <gbenhaim@augury.com> wrote:
> >
> > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > was acquired by AcquireNotify and there are no readers. it can be
> > reproduced by terminating the reader process without closing the reader
> > end of the pipe.
> >
> > Ignoring the SIGPIPE will cause the write operation to return a
> > "io_send: Broken pipe" error which will be logged.
> > ---
> >  src/gatt-client.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > index 234f46ed7..236f38ad5 100644
> > --- a/src/gatt-client.c
> > +++ b/src/gatt-client.c
> > @@ -1137,6 +1137,9 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
> >         if (pipe2(pipefd, O_DIRECT | O_NONBLOCK | O_CLOEXEC) < 0)
> >                 return btd_error_failed(msg, strerror(errno));
> >
> > +       /* Ignore SIGPIPE, a broken pipe error will be returned if the pipe has no readers */
> > +       signal(SIGPIPE, SIG_IGN);
> > +
> >         dir = dbus_message_has_member(msg, "AcquireWrite");
> >
> >         io = io_new(pipefd[!dir]);
> > --
> > 2.19.1
>
> I wonder if there is a way to detect that on bluetoothd actually, that
> way even if the client don't set it properly it would not make
> bluetoothd to exit.
>
>
> --
> Luiz Augusto von Dentz

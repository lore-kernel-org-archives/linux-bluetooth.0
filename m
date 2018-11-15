Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A5AC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 19:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9892086C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="ZZ7jmudz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9892086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeKPFnn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:43:43 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40707 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeKPFnn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Nov 2018 00:43:43 -0500
Received: by mail-vk1-f195.google.com with SMTP id v70so4734552vkv.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PcPtBvYIOe7vbjJxmgEzQ3mqAOb1zB7gDm2IAIuvSw=;
        b=ZZ7jmudzG5V/HLhx7NPI0yJlZuEGVmW+HtZWrtO4ZpEJkbFjqciDkbmGsvXETimY96
         qJD7SOP5fdMS4RlITQvuEwUIKQlHJa7A7ZTh/WsAO2cmGTScUPuOd0UpHTcEaFFCAqFb
         0DSfgm8SpAFGGB+Mh8UaYtsI2Ft1M62OgHpCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PcPtBvYIOe7vbjJxmgEzQ3mqAOb1zB7gDm2IAIuvSw=;
        b=NKnDpdP7itKWnr1lj+G74NqB0z45JhRd2viminh6B6s0iSc2ZkcgzBhGasnOf0C/H+
         im++nisFqbA5xEjGpHE1+ZQc+7+IrIB27A5jCXmxSSlaESx77dj6O/GEuyRe/Bzs2vUu
         2lp+Uutw7h0/uaCCBtA5EvQ+73ZVDhG9hfyayQ4coFvbIuI1Nwi7kPJXrdsheCJfaEhU
         YGZD0BK/LYJgt5Rpqh3pygMMRNZi9++WDo/7tD/XoHyRPpe5zcmNIF7PX9Myzonn9hQn
         zhfIjjbaTb2MRDzbEbNVIto1NNgexdlYG8Vvkd5XnBW2EU1WQETfquECsI4t9PaDxwYY
         r1Hw==
X-Gm-Message-State: AGRZ1gJJBzSsnEnbSp/OkZeyK2Q/Abw7gUnsjL+RAzpAmyP/wp9/2N8B
        vjc/nEUVA2FI/qGVIVVgj7W1MPO8ZK7TuuOtGK6S5A==
X-Google-Smtp-Source: AJdET5cmhmiINKB5k34NN54uc9pP2yXCr2vsB/3JTNmOaEVlY/8kqc1LkmEFMauUSlgrmLvjqr/+0aQ96hTciudiLSU=
X-Received: by 2002:a1f:83ca:: with SMTP id f193mr3162238vkd.75.1542310474896;
 Thu, 15 Nov 2018 11:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20181115115324.10215-1-gbenhaim@augury.com> <CABBYNZKkrddaFypEA0FGW8CHAH3bf-atNKh2+6scLKC3ZPSfQQ@mail.gmail.com>
In-Reply-To: <CABBYNZKkrddaFypEA0FGW8CHAH3bf-atNKh2+6scLKC3ZPSfQQ@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Thu, 15 Nov 2018 21:34:23 +0200
Message-ID: <CAHotPr9A7A6Rf0+JgQN6nAiXYDGp6QiaPeXP6vyomXeR4F57Cw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/io-mainloop: Try to write to the pipe only
 if there are readers
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

doesn't my first patch of ignoring SIGPIPE simplify this? errno of the
write op will be EPIPE..
I can move it to main.c
On Thu, Nov 15, 2018 at 2:38 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Gal,
> On Thu, Nov 15, 2018 at 1:55 PM Gal Ben-Haim <gbenhaim@augury.com> wrote:
> >
> > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > was acquired by AcquireNotify and there are no readers. it can be
> > reproduced by terminating the reader process without closing the reader
> > end of the pipe.
> >
> > poll is used to check for a POLLRDHUP event before write and an EPIPE
> > error is returned if the peer closed its end of the pipe.
> > ---
> >  src/shared/io-mainloop.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
> > index 2306c3479..4a70449fc 100644
> > --- a/src/shared/io-mainloop.c
> > +++ b/src/shared/io-mainloop.c
> > @@ -27,6 +27,7 @@
> >
> >  #include <unistd.h>
> >  #include <errno.h>
> > +#include <poll.h>
> >  #include <sys/socket.h>
> >
> >  #include "src/shared/mainloop.h"
> > @@ -305,7 +306,14 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> >         if (!io || io->fd < 0)
> >                 return -ENOTCONN;
> >
> > +       struct pollfd fds[1];
> > +       fds[0].fd = io->fd;
> > +       fds[0].events = POLLRDHUP;
> >         do {
> > +               if (poll(fds, 1, 0) > 0 && fds[0].revents & POLLRDHUP > 0) {
> > +                       return -EPIPE;
> > +               }
> > +
> >                 ret = writev(io->fd, iov, iovcnt);
> >         } while (ret < 0 && errno == EINTR);
> >
> > --
> > 2.19.1
>
> We normally do it a bit differently, we setup a write handler using
> io_set_write_handler which informs when the fd is writable, otherwise
> we maybe polling twice here since the user of the io may already be
> using that mechanism. That said you are actually checking for HUP
> which is something done io_set_disconnect_handler, which is already in
> use. I suspect to really get this done cleanly we should perhaps use
> MSG_NOSIGNAL when trying to write.
>
> --
> Luiz Augusto von Dentz

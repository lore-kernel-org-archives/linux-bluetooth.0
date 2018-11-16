Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0836AC43610
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D2A2086B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 23:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="fzV0EEj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D2A2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeKQJ6q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:58:46 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42614 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeKQJ6p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 04:58:45 -0500
Received: by mail-ua1-f68.google.com with SMTP id d21so8872304uap.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SC061YYWdXVYYX7g3Fv4kfp/n9e9H/wm9LWPwm+6hLY=;
        b=fzV0EEj7EdX0oOZrIWEpFw020myjEMTDIaYw8Ztk9uSqrHXftJi3pfhUIz9aHlqu/P
         8vmz2fig1EDpn+wOuXDC01C5ql9dKPir1AY7Xd0O4omRIacOO6mz7dZX6Obz7LTWfKVS
         H0QVkUVM/7diTjI0Bj8Repq0+HifmOX2EDVc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SC061YYWdXVYYX7g3Fv4kfp/n9e9H/wm9LWPwm+6hLY=;
        b=BOnaq1azQwvgp66t+nt2zZva4cBDG75YXNOva3cmXszj9Zx6Dleqc4xubQ85UIIQ4g
         UHM51Ub4I95vQlYOw4fWtGZnt9YFxNxHy5+Gd/74LzZmZY0wulkx76hn3rePrVuoJI34
         9mOQK0tKnBDXjg8xheV0+sTxGdd+b1CF19bDCPQ6nAp7trtAv73vgR/gj2UzLHcjy3Xo
         nOMO0/eykQb4Kva6JvJfzxukq37e5gf2N72PhpKA3IptL3RJ+mldmmxEevjckpKihCgb
         Vg28OS9B1IVov+wTw/g7gjoUzekByW5UtR0JpkWNmwPpgQpsT6FrHfLMnTXnlOOFme/g
         p26g==
X-Gm-Message-State: AGRZ1gK/WrG8MCzQo1hkr99UJmc3AouJVpfe5OsGWba9RPRI9zunbW0C
        sDqtJNULyZR7PY9qdoeRSvwU2ZgXzlPr0CGqVxkR0cB7fu0=
X-Google-Smtp-Source: AJdET5deUFN9lfqCHXm69ZoDClk1m5hYsVx+klyBZsD4YwHfni5JTWggCKhUq9pQnSBooN0nPxTiPiV9GjSxvfJBn78=
X-Received: by 2002:ab0:3259:: with SMTP id r25mr5570779uan.108.1542411858794;
 Fri, 16 Nov 2018 15:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20181116205651.8800-1-gbenhaim@augury.com> <CAHotPr_HqPg6PrCEG2tJOa4EAvCj6SWBgJLW6JM19gwpAFd78g@mail.gmail.com>
In-Reply-To: <CAHotPr_HqPg6PrCEG2tJOa4EAvCj6SWBgJLW6JM19gwpAFd78g@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Sat, 17 Nov 2018 01:44:08 +0200
Message-ID: <CAHotPr_Y_=BhYdJVVQ1CYsat32BDGW02XKeoGSZ--7HmwuxO3w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] io_send: Write to pipes with the MSG_NOSIGNAL flag
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

this is the error message: io_send: Socket operation on non-socket
On Fri, Nov 16, 2018 at 11:36 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> I did this change but it doesn't seem to write as expected, what do you think?
>
> On Fri, Nov 16, 2018 at 10:56 PM Gal Ben-Haim <gbenhaim@augury.com> wrote:
> >
> > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > was acquired by AcquireNotify and there are no readers. it can be
> > reproduced by terminating the reader process without closing the reader
> > end of the pipe.
> >
> > Requesting not to send SIGPIPE will cause the write operation to return an
> > error which will be logged as "io_send: Broken pipe".
> > ---
> >  src/shared/io-ell.c      | 14 ++++++++++++--
> >  src/shared/io-glib.c     | 15 +++++++++++++--
> >  src/shared/io-mainloop.c | 14 ++++++++++++--
> >  src/shared/io.h          |  2 +-
> >  4 files changed, 38 insertions(+), 7 deletions(-)
> >
> > diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
> > index 6748982c7..2bd166966 100644
> > --- a/src/shared/io-ell.c
> > +++ b/src/shared/io-ell.c
> > @@ -117,7 +117,7 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
> >                                                         user_data, destroy);
> >  }
> >
> > -ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> > +ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt)
> >  {
> >         ssize_t ret;
> >         int fd;
> > @@ -129,8 +129,18 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> >         if (fd < 0)
> >                 return -ENOTCONN;
> >
> > +       const struct msghdr msg = {
> > +                .msg_name = NULL,
> > +                .msg_namelen = 0,
> > +                .msg_iov = iov,
> > +                .msg_iovlen = iovcnt,
> > +                .msg_control = NULL,
> > +                .msg_controllen = 0,
> > +                .msg_flags = 0
> > +        };
> > +
> >         do {
> > -               ret = writev(fd, iov, iovcnt);
> > +               ret = sendmsg(fd, &msg, MSG_NOSIGNAL);
> >         } while (ret < 0 && errno == EINTR);
> >
> >         if (ret < 0)
> > diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> > index d62de4e10..7e4c9961b 100644
> > --- a/src/shared/io-glib.c
> > +++ b/src/shared/io-glib.c
> > @@ -26,6 +26,7 @@
> >  #endif
> >
> >  #include <errno.h>
> > +#include <sys/socket.h>
> >
> >  #include <glib.h>
> >
> > @@ -263,7 +264,7 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
> >         return io_set_handler(io, G_IO_HUP, callback, user_data, destroy);
> >  }
> >
> > -ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> > +ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt)
> >  {
> >         int fd;
> >         ssize_t ret;
> > @@ -273,8 +274,18 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> >
> >         fd = io_get_fd(io);
> >
> > +       const struct msghdr msg = {
> > +                .msg_name = NULL,
> > +                .msg_namelen = 0,
> > +                .msg_iov = iov,
> > +                .msg_iovlen = iovcnt,
> > +                .msg_control = NULL,
> > +                .msg_controllen = 0,
> > +                .msg_flags = 0
> > +        };
> > +
> >         do {
> > -               ret = writev(fd, iov, iovcnt);
> > +               ret = sendmsg(fd, &msg, MSG_NOSIGNAL);
> >         } while (ret < 0 && errno == EINTR);
> >
> >         if (ret < 0)
> > diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
> > index 2306c3479..4b6cc14c7 100644
> > --- a/src/shared/io-mainloop.c
> > +++ b/src/shared/io-mainloop.c
> > @@ -298,15 +298,25 @@ bool io_set_disconnect_handler(struct io *io, io_callback_func_t callback,
> >         return true;
> >  }
> >
> > -ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> > +ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt)
> >  {
> >         ssize_t ret;
> >
> >         if (!io || io->fd < 0)
> >                 return -ENOTCONN;
> >
> > +       const struct msghdr msg = {
> > +               .msg_name = NULL,
> > +               .msg_namelen = 0,
> > +               .msg_iov = iov,
> > +               .msg_iovlen = iovcnt,
> > +               .msg_control = NULL,
> > +               .msg_controllen = 0,
> > +               .msg_flags = 0
> > +       };
> > +
> >         do {
> > -               ret = writev(io->fd, iov, iovcnt);
> > +               ret = sendmsg(io->fd, &msg, MSG_NOSIGNAL);
> >         } while (ret < 0 && errno == EINTR);
> >
> >         if (ret < 0)
> > diff --git a/src/shared/io.h b/src/shared/io.h
> > index 8bc1111d0..522ec26ff 100644
> > --- a/src/shared/io.h
> > +++ b/src/shared/io.h
> > @@ -34,7 +34,7 @@ void io_destroy(struct io *io);
> >  int io_get_fd(struct io *io);
> >  bool io_set_close_on_destroy(struct io *io, bool do_close);
> >
> > -ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt);
> > +ssize_t io_send(struct io *io, struct iovec *iov, int iovcnt);
> >  bool io_shutdown(struct io *io);
> >
> >  typedef bool (*io_callback_func_t)(struct io *io, void *user_data);
> > --
> > 2.19.1
> >

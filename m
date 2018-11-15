Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE1C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 12:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B984B2083E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 12:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJkr4Jyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B984B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbeKOWpm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:45:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46735 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeKOWpm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 17:45:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so17141963otm.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 04:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xztb9mBOfez/RVxdoNNvnlJjGEd8Y27UU6I5XZmFFM8=;
        b=KJkr4JydgYHQDTPu0Wx3LWdUqlEG/ohvXKp4IUtV3l/l8YT1p1XttAQ9md7pXpp8UI
         kP04dyMZLkDVqluzSarx8Ka6iirb92RkGzWCq1YevqHAKhFgXIcbHke/Hy4jf4hRhYxz
         sEgCIFUrhGcVVeG3z5Qq1NIkuiaf0YJKB85J6crPeCeJiog1SSR9fOazpTYz0Y/ZiaKw
         OgrCf1RUqd3eZ2YO9OxI+vPWEF0203TlhWXVpDfH3KOpaHEYjtr3vMwEODT6MX5tc5n/
         nfF4c3uOSvnhjVnZVFbcHzlje4+8JP8phlcOj/tJkb8WiCPsqbxt59/xshEXEX2qDUvk
         KCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xztb9mBOfez/RVxdoNNvnlJjGEd8Y27UU6I5XZmFFM8=;
        b=IXr5gChoy91c/RGOeAK+WKd8NpL+ASI7UqRU+3pfBxwocjy6e4o8DRxwKq5O0jEIxX
         9qGm5WqsO7b/3y+EmRPN2iYjaguEWc+8InJKZP70yeAnsiVHaTxF46aSB1I3HwCX0Ic6
         hFthbxDHEoisHwOsdZ1Cp+6Ex3/RriD4MfexonB3AHJ1obcuuXp820YimR0BE/TWQUEs
         aNmGL3dGvOgYxyZrhb7gnq92lkfy31lKoyFeIrq7Elwu+y4oStPtpoC8gBRre7I5v9Ob
         Xe8bZ07hz93Tq8vxJac5DYBLMfYtG+rE8ENmnVPCiGnxAgyGgEx1jEaQ0o00P8XCSmZw
         +rWg==
X-Gm-Message-State: AGRZ1gLWdP6j0Jvo96dOcb866OdXgho/T+EH8XamRDPDBbgJQJeto/tU
        jp+eA0eeq3kkZqZkwYrgGO4KL0n7qqqMIsGYbIE=
X-Google-Smtp-Source: AJdET5dI0/vm+T80UXncsNFAE2OFAwuRCs99E8b22mCn9JMhzLOw/Y92n9U3r4tqStdarvFMmsd/SxBND8rOpCvTquw=
X-Received: by 2002:a9d:3213:: with SMTP id t19mr3885380otc.71.1542285480899;
 Thu, 15 Nov 2018 04:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20181115115324.10215-1-gbenhaim@augury.com>
In-Reply-To: <20181115115324.10215-1-gbenhaim@augury.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Nov 2018 14:37:48 +0200
Message-ID: <CABBYNZKkrddaFypEA0FGW8CHAH3bf-atNKh2+6scLKC3ZPSfQQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/io-mainloop: Try to write to the pipe only
 if there are readers
To:     gbenhaim@augury.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,
On Thu, Nov 15, 2018 at 1:55 PM Gal Ben-Haim <gbenhaim@augury.com> wrote:
>
> bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> was acquired by AcquireNotify and there are no readers. it can be
> reproduced by terminating the reader process without closing the reader
> end of the pipe.
>
> poll is used to check for a POLLRDHUP event before write and an EPIPE
> error is returned if the peer closed its end of the pipe.
> ---
>  src/shared/io-mainloop.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
> index 2306c3479..4a70449fc 100644
> --- a/src/shared/io-mainloop.c
> +++ b/src/shared/io-mainloop.c
> @@ -27,6 +27,7 @@
>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <poll.h>
>  #include <sys/socket.h>
>
>  #include "src/shared/mainloop.h"
> @@ -305,7 +306,14 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
>         if (!io || io->fd < 0)
>                 return -ENOTCONN;
>
> +       struct pollfd fds[1];
> +       fds[0].fd = io->fd;
> +       fds[0].events = POLLRDHUP;
>         do {
> +               if (poll(fds, 1, 0) > 0 && fds[0].revents & POLLRDHUP > 0) {
> +                       return -EPIPE;
> +               }
> +
>                 ret = writev(io->fd, iov, iovcnt);
>         } while (ret < 0 && errno == EINTR);
>
> --
> 2.19.1

We normally do it a bit differently, we setup a write handler using
io_set_write_handler which informs when the fd is writable, otherwise
we maybe polling twice here since the user of the io may already be
using that mechanism. That said you are actually checking for HUP
which is something done io_set_disconnect_handler, which is already in
use. I suspect to really get this done cleanly we should perhaps use
MSG_NOSIGNAL when trying to write.

-- 
Luiz Augusto von Dentz

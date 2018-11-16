Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC9C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FC42080D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa4BVgrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FC42080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeKQFoP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:44:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33307 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQFoP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 00:44:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so15021168oib.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10YeBZ839o8wJQ2vw+ZxWshfJybYuLfsbDhMuRGRofs=;
        b=Aa4BVgrTxMluiOQpftxYhPGMgIhJx6O+pjBGWf8OprKGuAI2/M47HgqaFxq0aC3bnj
         MVmPDA/ou4UQxqS6o/rnZ6LN0SP1zjf0kOVcgNAaMDs8Xv7rpn39NUajzec3BxW6foX9
         6AFAoTHgNCeOjYlTPAZTlu/QAZRwFU6pjHpDivRXbFHUJ7vNzIglF8tqXS1YkKZwPYvN
         OABFjPNVkM9RSrIxgrkV/Q4iST/h9n7TmrAqNMn7q52/m3ppl/mxuKS/9AyO+zEYHJte
         tYL05YYGjMtgLt2C8UV5ixqvlKrlTiitG43fbyHuOmjZqbQNvtR7hlKuQ7Zg831x/5Ia
         TuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10YeBZ839o8wJQ2vw+ZxWshfJybYuLfsbDhMuRGRofs=;
        b=NtHuzP92OujqtUXa0ynSOGIo8tScSXV2tXo5/xGkR7jNrzrPqDRw5J+ptENyUG3HqH
         PhvK+NoyH9QxBoVgaeDmuVK10oNt/+V2mkAJFFaDkwo18iR3PWOdAZW1ef5FHXmrE+4S
         hJt7jNKE+0Lszu+/XyiB8PbekvnQFGkmqvemGGs1HmWSj1qnjh5U/WqTxrLaz3EkcUj4
         rHAbQeq9uTDeRc7XgAnapKoQpwsAmmdcpkPp2JX3ZHDn5iS+Gf99PGD6TQ0dUZwTGGjV
         r0KgxCPmPrXY0jV2Wbc6mLdroTsHBebs9vvRwwaPnPi8cY0HLu1S7+CaU/k6R385DCTC
         6vSQ==
X-Gm-Message-State: AA+aEWaEZBgCQWQPMXUbT7yPMJw7otMrq+c7P3GaUk6P2E4vyG4gqZtr
        qrG7TpxS37Hv7BXMz2MVp+kQWH2ER6MVk/YgDV/u6cDd
X-Google-Smtp-Source: AJdET5c2HFYXFo6lSlODgC7LbOVXQsULw8y/jO4pkpprJ6vBGJ6fIHtDGitsKK1xyxtmv8iEpbEUEPsjPRlitVJmZ+0=
X-Received: by 2002:aca:aa0d:: with SMTP id t13mr1784444oie.273.1542396633432;
 Fri, 16 Nov 2018 11:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20181116191452.17377-1-gbenhaim@augury.com>
In-Reply-To: <20181116191452.17377-1-gbenhaim@augury.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 16 Nov 2018 21:30:21 +0200
Message-ID: <CABBYNZJFTNMvXE5p0t4XrhF8KaJf3RKRdbD1Hv6Jwp+x+6shGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Ignore SIGPIPE
To:     Gal Ben Haim <gbenhaim@augury.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,

On Fri, Nov 16, 2018 at 9:17 PM Gal Ben-Haim <gbenhaim@augury.com> wrote:
>
> bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> was acquired by AcquireNotify and there are no readers. it can be
> reproduced by terminating the reader process without closing the reader
> end of the pipe.
>
> Ignoring the SIGPIPE will cause the write operation to return an
> error which will be logged as "io_send: Broken pipe".

Ive been suggesting using MSG_NOSIGNAL, do you have anything against it?

MSG_NOSIGNAL (since Linux 2.2)Requests not to send SIGPIPE on errors
on stream oriented sockets when the other end breaks the connection.
The EPIPE error is still returned.
(https://linux.die.net/man/2/send)

> ---
>  src/main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index 4716f5388..c62886593 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -691,7 +691,7 @@ int main(int argc, char *argv[])
>         uint16_t sdp_mtu = 0;
>         uint32_t sdp_flags = 0;
>         int gdbus_flags = 0;
> -       guint signal, watchdog;
> +       guint signal_source, watchdog;
>         const char *watchdog_usec;
>
>         init_defaults();
> @@ -721,7 +721,11 @@ int main(int argc, char *argv[])
>
>         event_loop = g_main_loop_new(NULL, FALSE);
>
> -       signal = setup_signalfd();
> +       signal_source = setup_signalfd();
> +
> +       /* Ignore SIGPIPE, a broken pipe error will be returned from write
> +        * attempts to a pipe with no readers */
> +       signal(SIGPIPE, SIG_IGN);
>
>         __btd_log_init(option_debug, option_detach);
>
> @@ -809,7 +813,7 @@ int main(int argc, char *argv[])
>
>         sd_notify(0, "STATUS=Quitting");
>
> -       g_source_remove(signal);
> +       g_source_remove(signal_source);
>
>         plugin_cleanup();
>
> --
> 2.19.1
>


-- 
Luiz Augusto von Dentz

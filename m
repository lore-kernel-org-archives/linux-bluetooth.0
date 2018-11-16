Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C55C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48F42086C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="ayrmFHm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48F42086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeKQGIq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:08:46 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43601 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQGIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 01:08:46 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so14406232vsc.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+IW+WWtiG4NSpqwG+28lC2DKSMR9lgHSQMOkOj6ZoA=;
        b=ayrmFHm6YQhDJkqb22C5xKWwOlIR2yO/xhEdYQDk2RCtTUPl9vMrOJ26Uw0y9godPF
         57F1BRMtLpTC9Urg3Wr2qqKKc5fZwt+Ug5Ngo8Im8H/yLq/OreRZjfYOPfMgkSY/Epg+
         T3JD0WeKvx8r7AOBErSu2Yi0ktCMnrEEHqXpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+IW+WWtiG4NSpqwG+28lC2DKSMR9lgHSQMOkOj6ZoA=;
        b=sWDmXh8BDLrfsrp9ZXcSjiZYMZReOEJajaiDaiVtyZv2FJO+kLzyUYXiYgfAWKHHXY
         ZD1CGPII2jZfgSYv/GYgZiyzD5sp5dKMKn1ZRmXO3lijzyGnZuOCWrtIJVofx2NrMv6B
         t6r3b5Xum5eEFiXchSdF0IbVM7lQhZR69Hb8a6q+K4P1WjOy/akbCtwQiJ2jz+3ckKdc
         FkRPUOQF+RfxHue4BCsITvvS/7qu2zQWMZVvVFqvP7yc+QfYqYL7M43Q/b3/7bpLWj0/
         /ItDD9z8C1Ulci6scak8/YkPB2l7m0eT/hlP9rxgqtc0h6+CNt2mC0XU3GksbTBFPcQU
         sXuA==
X-Gm-Message-State: AGRZ1gLXLQGoWcwNCp1sNx5IqZqydgntOzdhchVA27hG/ZlaolI/xsGT
        gIs/mxjFrqxgOuyHBD6jdDnvAA6e+bdnfcbZeoAMNQ==
X-Google-Smtp-Source: AJdET5fN3+SgP62+VOe3utulkbnjRj9fmRsa+JNxZYwXo1V0wY2bpppUQntaIApR8kUkgi6BYx/PZXfQr/3p+0CwOQg=
X-Received: by 2002:a67:dd11:: with SMTP id y17mr5287652vsj.111.1542398099290;
 Fri, 16 Nov 2018 11:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20181116191452.17377-1-gbenhaim@augury.com> <CABBYNZJFTNMvXE5p0t4XrhF8KaJf3RKRdbD1Hv6Jwp+x+6shGQ@mail.gmail.com>
In-Reply-To: <CABBYNZJFTNMvXE5p0t4XrhF8KaJf3RKRdbD1Hv6Jwp+x+6shGQ@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Fri, 16 Nov 2018 21:54:48 +0200
Message-ID: <CAHotPr8prG8vfmOeFYD+5rq7U9MtnHDjkhET4M4dwMn4OE-Vug@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Ignore SIGPIPE
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

there's a suggestion in the thread about my other patch that uses poll
that the signal should be ignored anyway,
to prevent a scenario that the peer disconnects between poll or
checking for MSG_NOSIGNAL and the write attempt.
On Fri, Nov 16, 2018 at 9:30 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Gal,
>
> On Fri, Nov 16, 2018 at 9:17 PM Gal Ben-Haim <gbenhaim@augury.com> wrote:
> >
> > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > was acquired by AcquireNotify and there are no readers. it can be
> > reproduced by terminating the reader process without closing the reader
> > end of the pipe.
> >
> > Ignoring the SIGPIPE will cause the write operation to return an
> > error which will be logged as "io_send: Broken pipe".
>
> Ive been suggesting using MSG_NOSIGNAL, do you have anything against it?
>
> MSG_NOSIGNAL (since Linux 2.2)Requests not to send SIGPIPE on errors
> on stream oriented sockets when the other end breaks the connection.
> The EPIPE error is still returned.
> (https://linux.die.net/man/2/send)
>
> > ---
> >  src/main.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/main.c b/src/main.c
> > index 4716f5388..c62886593 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -691,7 +691,7 @@ int main(int argc, char *argv[])
> >         uint16_t sdp_mtu = 0;
> >         uint32_t sdp_flags = 0;
> >         int gdbus_flags = 0;
> > -       guint signal, watchdog;
> > +       guint signal_source, watchdog;
> >         const char *watchdog_usec;
> >
> >         init_defaults();
> > @@ -721,7 +721,11 @@ int main(int argc, char *argv[])
> >
> >         event_loop = g_main_loop_new(NULL, FALSE);
> >
> > -       signal = setup_signalfd();
> > +       signal_source = setup_signalfd();
> > +
> > +       /* Ignore SIGPIPE, a broken pipe error will be returned from write
> > +        * attempts to a pipe with no readers */
> > +       signal(SIGPIPE, SIG_IGN);
> >
> >         __btd_log_init(option_debug, option_detach);
> >
> > @@ -809,7 +813,7 @@ int main(int argc, char *argv[])
> >
> >         sd_notify(0, "STATUS=Quitting");
> >
> > -       g_source_remove(signal);
> > +       g_source_remove(signal_source);
> >
> >         plugin_cleanup();
> >
> > --
> > 2.19.1
> >
>
>
> --
> Luiz Augusto von Dentz

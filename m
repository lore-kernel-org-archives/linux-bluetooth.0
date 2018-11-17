Return-Path: <SRS0=7u80=N4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD55BC43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 15:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BA02080F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 15:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="CLL95Vs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BA02080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeKRBVQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:21:16 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45554 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRBVP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 20:21:15 -0500
Received: by mail-vs1-f66.google.com with SMTP id v10so8036124vsv.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Nov 2018 07:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Z1KfiIE8WGaCrUwUl9b17qptSwjvhZS3uEKHuuuiwA=;
        b=CLL95Vs9ceWWpcDX2g/v3xP31uqzseujWcsuFMb6QqGZw91ZXJXTndU90JjHFLBkfd
         a65mtAu93ZjPUp6MdSX7+I0y6nkjqU8OUz00rYfrxBVGaherSO10t+niL9O572Wd0DqN
         2KSGsKCAm/LjXhYwfiaxUqBDWZDy44fCzcx9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Z1KfiIE8WGaCrUwUl9b17qptSwjvhZS3uEKHuuuiwA=;
        b=mCGo2gAEZRCZ3I2P/OR1Kd1aFDSbox4AMVZoH7hSx7VZcqIo0Ng6zbbz0tdwS8Bi6t
         iJ/tdipXlOaFy4vQYY0eYiVxco0yVahUcarD9G9h85nf/iqklGHrXHYxX/0Q+b3XJ5pX
         ijoxTxRN2cl0vids/MIK/f/zgH4nTvcM+Hz0/W+HwowGKDF4D17JtX5g4bnXISE/1b1+
         Euv21kTP7sKDspZr6US5WU6KHZTbhbz9un3KTel2GOZassIoMdFcb5NoPq5OIawal+l4
         gwwNKnQu7ZyJ43zdkGDjRgAVFZyhW5Tg5uAVq0IxoojhE9SRTrhdlgsNerdvtlXYZI3L
         xNEA==
X-Gm-Message-State: AGRZ1gJAIH0oZRPwaypIvBxUeCkxUy1l+8zTk/7aY7vBDONwrDG5Zm1o
        lWuE/JG4RJOJkp8+qe0YVO+EWrxNJvnqKDiT0lPz8A==
X-Google-Smtp-Source: AJdET5cMZ9WWrKqdQasTqKcWfrSo2q+l4Gkb4B3Y+8KObfkrHewGQ27jFjNQo8cfeD7UTh7EfEocbC6NRxw9mgjnOSQ=
X-Received: by 2002:a67:105:: with SMTP id 5mr6221054vsb.183.1542467057796;
 Sat, 17 Nov 2018 07:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20181116191452.17377-1-gbenhaim@augury.com> <5F365876-5DA6-4916-B810-E2DF1ABD3772@holtmann.org>
 <CAHotPr-cE2gc9Gue9ekyqgb4fFCR+jPWuVYcQzNrpFc-BmW7-g@mail.gmail.com>
 <CAHotPr_nF+ZLmRAVUKPFdbGJ2rt_+vBA9cv5-pgEf-DHhJueJQ@mail.gmail.com> <CABBYNZK1fydodkrSoZAeja-6h50xBBkMLLMNqxFbxsaGCtquiA@mail.gmail.com>
In-Reply-To: <CABBYNZK1fydodkrSoZAeja-6h50xBBkMLLMNqxFbxsaGCtquiA@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Sat, 17 Nov 2018 17:04:06 +0200
Message-ID: <CAHotPr9o1LVM+EgSSRV_Qevptb25y2CMeKoA-_4Ykkmo6FCUOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Ignore SIGPIPE
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

submitted - https://marc.info/?l=linux-bluetooth&m=154243443910013&w=2
On Sat, Nov 17, 2018 at 11:29 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Gal,
>
> Weird I thought send/sendmsg works with pipes, anyway I think we can
> apply the handling of SIGPIPE with signalfd then.
> On Sat, Nov 17, 2018 at 1:47 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
> >
> > I tried MSG_NOSIGNAL, see my other patch. the error is io_send: Socket
> > operation on non-socket.
> >
> > please suggest an acceptable solution for this issue
> > On Fri, Nov 16, 2018 at 10:11 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> > >
> > > what should signal_handler do in case of SIGPIPE? will failed write
> > > return EPIPE if the signal is catched?
> > >
> > > On Fri, Nov 16, 2018 at 10:01 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > > >
> > > > Hi Gal,
> > > >
> > > > > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > > > > was acquired by AcquireNotify and there are no readers. it can be
> > > > > reproduced by terminating the reader process without closing the reader
> > > > > end of the pipe.
> > > > >
> > > > > Ignoring the SIGPIPE will cause the write operation to return an
> > > > > error which will be logged as "io_send: Broken pipe".
> > > > > ---
> > > > > src/main.c | 10 +++++++---
> > > > > 1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/src/main.c b/src/main.c
> > > > > index 4716f5388..c62886593 100644
> > > > > --- a/src/main.c
> > > > > +++ b/src/main.c
> > > > > @@ -691,7 +691,7 @@ int main(int argc, char *argv[])
> > > > >       uint16_t sdp_mtu = 0;
> > > > >       uint32_t sdp_flags = 0;
> > > > >       int gdbus_flags = 0;
> > > > > -     guint signal, watchdog;
> > > > > +     guint signal_source, watchdog;
> > > > >       const char *watchdog_usec;
> > > > >
> > > > >       init_defaults();
> > > > > @@ -721,7 +721,11 @@ int main(int argc, char *argv[])
> > > > >
> > > > >       event_loop = g_main_loop_new(NULL, FALSE);
> > > > >
> > > > > -     signal = setup_signalfd();
> > > > > +     signal_source = setup_signalfd();
> > > > > +
> > > > > +     /* Ignore SIGPIPE, a broken pipe error will be returned from write
> > > > > +      * attempts to a pipe with no readers */
> > > > > +     signal(SIGPIPE, SIG_IGN);
> > > >
> > > > if we decide not to use MSG_NOSIGNAL, then everything has to go via signalfd and not just by hacking in signal(SIG_IGN).
> > > >
> > > > Regards
> > > >
> > > > Marcel
> > > >
>
>
>
> --
> Luiz Augusto von Dentz

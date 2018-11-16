Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C2EC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE0D20883
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="Ldt3wVc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE0D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeKQKAc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:00:32 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38510 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeKQKAc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 05:00:32 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so8878719uaa.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6faokSPAGhS4yqRfNMcPaylbTt71jpMgejl9GWDOpP4=;
        b=Ldt3wVc3WrsubCL0BOLbIKjdmE6vQCgkGWHqCLfvOR+sRqj6K4AvBuFzPyJRag1T+d
         5UfxjX5l+mc708zXRZOCJU+bo3xwYkQglMaSvvfitOxS1E4tlTwXF8SvIX61R047Fzpn
         qQhmpDTILGeHsdgF5Z7tqvi3tu6a07kcDTdLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6faokSPAGhS4yqRfNMcPaylbTt71jpMgejl9GWDOpP4=;
        b=IgWXjzdCOs5bjwLwgPRZxIl57BluCdrHJFFM/g9FHhGXIXZzBla3JwRRgRqymAswLN
         Vo2mbgi+ZC1TiJelXea3jRSogyuBC68vFfC5BxFoazfW+BhBkUdhlG5qpzbvy/FJ+Jac
         0e2gPxMTOwouSz2RzX8zQIiuMieS6buYSIG+wF1qtgIJPQ1sfdILCjW/3Sbd0FTH1DfY
         rh1JwuzGYFpRzfRi7m1aoeyfFhvkQ9G9zIxbx3c1Qyl6dRSl6wXRpESeA+SlO5WnZ1O2
         4VsGbgtA/CLGxl/Vzv75dctEXYfAc7mecm9gKz9reHHYk4ROyLu2WZGlZ9fOOHqq3nq7
         isbg==
X-Gm-Message-State: AGRZ1gKrPDT4VvWlkjquc6QPWpdCAZza8zh1iYPnw5IZbPz/BJKaahAQ
        6bmQi3oYjOC+QdjN9CoQmjd6aW2zR5nwwl/tYeuS/OzCj2k=
X-Google-Smtp-Source: AJdET5dT8rtmfIm5ieD0VO9hRONDJMU08XCw847hsQxUXvtTldXHVx+wOl77XeHU9v3a2hV0f6AfAPhr+9b0qGELefU=
X-Received: by 2002:ab0:4a16:: with SMTP id q22mr5658595uae.1.1542411965186;
 Fri, 16 Nov 2018 15:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20181116191452.17377-1-gbenhaim@augury.com> <5F365876-5DA6-4916-B810-E2DF1ABD3772@holtmann.org>
 <CAHotPr-cE2gc9Gue9ekyqgb4fFCR+jPWuVYcQzNrpFc-BmW7-g@mail.gmail.com>
In-Reply-To: <CAHotPr-cE2gc9Gue9ekyqgb4fFCR+jPWuVYcQzNrpFc-BmW7-g@mail.gmail.com>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Sat, 17 Nov 2018 01:45:54 +0200
Message-ID: <CAHotPr_nF+ZLmRAVUKPFdbGJ2rt_+vBA9cv5-pgEf-DHhJueJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Ignore SIGPIPE
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I tried MSG_NOSIGNAL, see my other patch. the error is io_send: Socket
operation on non-socket.

please suggest an acceptable solution for this issue
On Fri, Nov 16, 2018 at 10:11 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> what should signal_handler do in case of SIGPIPE? will failed write
> return EPIPE if the signal is catched?
>
> On Fri, Nov 16, 2018 at 10:01 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Gal,
> >
> > > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > > was acquired by AcquireNotify and there are no readers. it can be
> > > reproduced by terminating the reader process without closing the reader
> > > end of the pipe.
> > >
> > > Ignoring the SIGPIPE will cause the write operation to return an
> > > error which will be logged as "io_send: Broken pipe".
> > > ---
> > > src/main.c | 10 +++++++---
> > > 1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/src/main.c b/src/main.c
> > > index 4716f5388..c62886593 100644
> > > --- a/src/main.c
> > > +++ b/src/main.c
> > > @@ -691,7 +691,7 @@ int main(int argc, char *argv[])
> > >       uint16_t sdp_mtu = 0;
> > >       uint32_t sdp_flags = 0;
> > >       int gdbus_flags = 0;
> > > -     guint signal, watchdog;
> > > +     guint signal_source, watchdog;
> > >       const char *watchdog_usec;
> > >
> > >       init_defaults();
> > > @@ -721,7 +721,11 @@ int main(int argc, char *argv[])
> > >
> > >       event_loop = g_main_loop_new(NULL, FALSE);
> > >
> > > -     signal = setup_signalfd();
> > > +     signal_source = setup_signalfd();
> > > +
> > > +     /* Ignore SIGPIPE, a broken pipe error will be returned from write
> > > +      * attempts to a pipe with no readers */
> > > +     signal(SIGPIPE, SIG_IGN);
> >
> > if we decide not to use MSG_NOSIGNAL, then everything has to go via signalfd and not just by hacking in signal(SIG_IGN).
> >
> > Regards
> >
> > Marcel
> >

Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF1C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 20:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9312087A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 20:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="FJOzt69A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9312087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeKQGZ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:25:59 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43397 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQGZ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 01:25:59 -0500
Received: by mail-ua1-f67.google.com with SMTP id z11so8697059uaa.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 12:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrS6Xp/Uvso0u+TGKp+3DVTnhARFgJVKnqYkXzR9oAg=;
        b=FJOzt69AarmHfvmKddRBokA1cFu6GIAIoOvgmpaCO6fKrGIgmMRIfAyRudApIgoUOA
         sqemjHZoiNsis4o5w6UcaQY4zoO2ztI12StkLfBwOD7C3HG3IKkrJ3rJ/Hm8y2Wr9XP4
         Q1DYYvepMt/QPYeWmk3Qg8J30tDTvQzUWgD90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrS6Xp/Uvso0u+TGKp+3DVTnhARFgJVKnqYkXzR9oAg=;
        b=LCFJMSzjyz8I5Se+jBo7mX41/eYdoiMLLucBMn3vgOF5hYG8Sy6MHkN2hBcohPnIGt
         oHUoiDZQwo85eLpJrmYJRzHzilJAybzk67EFI102OV09Xli7yUVy7MJt556j3UY7AGO+
         9sJj9jMX7XCdireKmcfxSMAZr8MFAlDhkN2PLi+MhWtCicywse9AezCczXua23nZApvY
         Wa5IZ0cJaU+VhRfTieqfGyf1XdkwcXrzHX68hJLdKH496QZ+NuG+dC5Lk+TLvCMuf6F7
         +kvmkvIVdYhwf/NJs7iliFiebHKzAKwXq/dt4bXtpt/1tqJrfjf38FXntwv6LwUoDw2+
         3UNw==
X-Gm-Message-State: AGRZ1gK/ZBehlkHIKY5R3CqWPfxxS/JTlpo71gd8GKc9Z+AqWuRMU6tN
        HKip2n1Bk+zj+zcuQ6WvidbRecJMdNXsFLy/OJVis1IW
X-Google-Smtp-Source: AJdET5dPVTOY4bLbHe0E7I9J1EC0vEmp1roWRrAooWm0nbDYwqPiQwVoPrN510RWx+BicG+APCjZOLMGEudylJHJEXQ=
X-Received: by 2002:ab0:2482:: with SMTP id i2mr5341400uan.82.1542399128389;
 Fri, 16 Nov 2018 12:12:08 -0800 (PST)
MIME-Version: 1.0
References: <20181116191452.17377-1-gbenhaim@augury.com> <5F365876-5DA6-4916-B810-E2DF1ABD3772@holtmann.org>
In-Reply-To: <5F365876-5DA6-4916-B810-E2DF1ABD3772@holtmann.org>
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Fri, 16 Nov 2018 22:11:57 +0200
Message-ID: <CAHotPr-cE2gc9Gue9ekyqgb4fFCR+jPWuVYcQzNrpFc-BmW7-g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Ignore SIGPIPE
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

what should signal_handler do in case of SIGPIPE? will failed write
return EPIPE if the signal is catched?

On Fri, Nov 16, 2018 at 10:01 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Gal,
>
> > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > was acquired by AcquireNotify and there are no readers. it can be
> > reproduced by terminating the reader process without closing the reader
> > end of the pipe.
> >
> > Ignoring the SIGPIPE will cause the write operation to return an
> > error which will be logged as "io_send: Broken pipe".
> > ---
> > src/main.c | 10 +++++++---
> > 1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/src/main.c b/src/main.c
> > index 4716f5388..c62886593 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -691,7 +691,7 @@ int main(int argc, char *argv[])
> >       uint16_t sdp_mtu = 0;
> >       uint32_t sdp_flags = 0;
> >       int gdbus_flags = 0;
> > -     guint signal, watchdog;
> > +     guint signal_source, watchdog;
> >       const char *watchdog_usec;
> >
> >       init_defaults();
> > @@ -721,7 +721,11 @@ int main(int argc, char *argv[])
> >
> >       event_loop = g_main_loop_new(NULL, FALSE);
> >
> > -     signal = setup_signalfd();
> > +     signal_source = setup_signalfd();
> > +
> > +     /* Ignore SIGPIPE, a broken pipe error will be returned from write
> > +      * attempts to a pipe with no readers */
> > +     signal(SIGPIPE, SIG_IGN);
>
> if we decide not to use MSG_NOSIGNAL, then everything has to go via signalfd and not just by hacking in signal(SIG_IGN).
>
> Regards
>
> Marcel
>

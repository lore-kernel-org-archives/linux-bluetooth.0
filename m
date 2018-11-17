Return-Path: <SRS0=7u80=N4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47479C43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11D520824
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 09:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+HqJwMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11D520824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeKQTpy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 14:45:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39379 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeKQTpy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 14:45:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id g27so23580716oth.6
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Nov 2018 01:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PZ9V/Tfu9UbpOYsGnDuUXyiA5R780+A01V2eiRlEqQ=;
        b=i+HqJwMovJMwZXOB+ls2lJPkZxKWhTlp4yWk57h3dtyfB6ONY5JBOli5s+T8/VMf82
         wgDTD54uymLl82FhaRfJV1/TSzVA5o9Dyusfxzl/WiZ64Uw1dczI45quDem5/EVURc7R
         XwoPZ5F45B29OAaHgFo5q0H3RGUDf8oDZAp99azdCZ/8cXPk0Z+HF8O4mppyzQ4xsQRO
         hKpBl6nQNGAfVUqzg2H5m1iTgWh3Sna7Su/oEHiB7VupAnA+LT40OTGOw7HDp7os6xaY
         SEiqJlahmg0Euvd1l7+C8mjg61OG8wk6ETX/7BmejhQq+dPgabxI56CuEb0qBLYdFMhi
         JfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PZ9V/Tfu9UbpOYsGnDuUXyiA5R780+A01V2eiRlEqQ=;
        b=Lt0YRc5AZqxFpjx3Lw+opkiVBgarMSGF5p4HAeoF3jHZv1AsAN3fA9QegNEbnQe+Nz
         /wEBHOhl9knax9XTjyEkEuXdh8VCsB7HK79Vsp4moJI7bppvWpppSycmq8htn2bWzjDf
         bQjv4QXqV2HHDTILz7z7QdU9OQ6aYP49Tp5eGDh5+32f7LaU/WAIEOFEQ5g0EFN82BAd
         dhdoBiFFiokerQCht7mu/l+BALuigGS6XEKSqDjBKFQN+KWMw8u0p1Vksu4wClJProUx
         ph7SZMx0aLNek5xgx5NqpLfBKE6r8BhVbpHzQRB8fJAM1QyLVWhyDx/JkZPTTMnzlbkC
         h5Gw==
X-Gm-Message-State: AGRZ1gKYcur/7DDDx5hNnrD6E/WewZCj9vSDPMgnBy/4tv296g0te0NR
        vfxN/e5daDqn366U2k6G38LQUSjvqHnHy80cKqADww==
X-Google-Smtp-Source: AJdET5e0t/aeEgdUVogNjXiCTRrfo+9tfbZcrApFAdZUQf+OeVdVASCxWS6UD6gFWb/VkF3HRWWRckn5K7WJ4INYyTk=
X-Received: by 2002:a9d:3213:: with SMTP id t19mr9257227otc.71.1542446989702;
 Sat, 17 Nov 2018 01:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20181116191452.17377-1-gbenhaim@augury.com> <5F365876-5DA6-4916-B810-E2DF1ABD3772@holtmann.org>
 <CAHotPr-cE2gc9Gue9ekyqgb4fFCR+jPWuVYcQzNrpFc-BmW7-g@mail.gmail.com> <CAHotPr_nF+ZLmRAVUKPFdbGJ2rt_+vBA9cv5-pgEf-DHhJueJQ@mail.gmail.com>
In-Reply-To: <CAHotPr_nF+ZLmRAVUKPFdbGJ2rt_+vBA9cv5-pgEf-DHhJueJQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 17 Nov 2018 11:29:37 +0200
Message-ID: <CABBYNZK1fydodkrSoZAeja-6h50xBBkMLLMNqxFbxsaGCtquiA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core: Ignore SIGPIPE
To:     Gal Ben Haim <gbenhaim@augury.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Gal,

Weird I thought send/sendmsg works with pipes, anyway I think we can
apply the handling of SIGPIPE with signalfd then.
On Sat, Nov 17, 2018 at 1:47 AM Gal Ben Haim <gbenhaim@augury.com> wrote:
>
> I tried MSG_NOSIGNAL, see my other patch. the error is io_send: Socket
> operation on non-socket.
>
> please suggest an acceptable solution for this issue
> On Fri, Nov 16, 2018 at 10:11 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> >
> > what should signal_handler do in case of SIGPIPE? will failed write
> > return EPIPE if the signal is catched?
> >
> > On Fri, Nov 16, 2018 at 10:01 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > >
> > > Hi Gal,
> > >
> > > > bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
> > > > was acquired by AcquireNotify and there are no readers. it can be
> > > > reproduced by terminating the reader process without closing the reader
> > > > end of the pipe.
> > > >
> > > > Ignoring the SIGPIPE will cause the write operation to return an
> > > > error which will be logged as "io_send: Broken pipe".
> > > > ---
> > > > src/main.c | 10 +++++++---
> > > > 1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/src/main.c b/src/main.c
> > > > index 4716f5388..c62886593 100644
> > > > --- a/src/main.c
> > > > +++ b/src/main.c
> > > > @@ -691,7 +691,7 @@ int main(int argc, char *argv[])
> > > >       uint16_t sdp_mtu = 0;
> > > >       uint32_t sdp_flags = 0;
> > > >       int gdbus_flags = 0;
> > > > -     guint signal, watchdog;
> > > > +     guint signal_source, watchdog;
> > > >       const char *watchdog_usec;
> > > >
> > > >       init_defaults();
> > > > @@ -721,7 +721,11 @@ int main(int argc, char *argv[])
> > > >
> > > >       event_loop = g_main_loop_new(NULL, FALSE);
> > > >
> > > > -     signal = setup_signalfd();
> > > > +     signal_source = setup_signalfd();
> > > > +
> > > > +     /* Ignore SIGPIPE, a broken pipe error will be returned from write
> > > > +      * attempts to a pipe with no readers */
> > > > +     signal(SIGPIPE, SIG_IGN);
> > >
> > > if we decide not to use MSG_NOSIGNAL, then everything has to go via signalfd and not just by hacking in signal(SIG_IGN).
> > >
> > > Regards
> > >
> > > Marcel
> > >



-- 
Luiz Augusto von Dentz

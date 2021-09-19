Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702FEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Sep 2021 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EC760232
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Sep 2021 13:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhISNq7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Sep 2021 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhISNq6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Sep 2021 09:46:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4DFC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Sep 2021 06:45:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg28so27007028edb.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Sep 2021 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6exTQj2H8K+ahbQLkHM9yRcZGgvoa3LOgXfJ3HggxwQ=;
        b=U48E6hmW45ep5MWXSmELGCeEnx1aJV0XG2i7asG9sJ41X3A4wef5PFhqqvTnwc02a3
         nh8InO3tqg8ilbWomLwYnIuiiti6zegkiSscx4z2jappgilFMK0Tu3W/1L3WBd/A+909
         5ChMXiYXw6Ww8N3iNKUzbr+QMRHikMhDLR7dUANph8dMHb3ssd85UTkb05g7H/PuZO4Q
         8bjQGTgAjafrq++J96Afs7REKKbG+2p4Qny/BWjYXYStvFFLiw19Mbpg9ufOoxiftIto
         Mo2Y8RP3HS3pM737FuIV6tOByyQwaeKuWZzkh9kt8TWHtRgMT4XY9a6gtAqJhEJY92Yr
         i7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6exTQj2H8K+ahbQLkHM9yRcZGgvoa3LOgXfJ3HggxwQ=;
        b=02j50CFF2vTA9RH2M6UUuNNH2Sb0uzzmbqTwKZPjPJQ6pnpRSubM0CMNNYKfEmfQqH
         2rYCJnxj4/esBR6skT1SXbXbq6BugDQ0eGMCxe58wGr+0937byS4+DHzHQBdeykI7d5a
         ftYf1nVgHK1rV3u4vCteibH05VJBxV1/ppLoC3u4MsC9QuZ37jNaT1ZTcapxXnJw9YLJ
         a9c9mw5BTRr76shKfjTb2sN6eUA8zfD+OTSNiooqIm74O1mYuYkZ4W+4mb5RTpNJoNif
         ZNC7mGjl/aHFDVyM9IjDcGCO46hWJF68oOwTcBkYJxyFtZS/XIPSw/Znw5X30IdEeAq1
         HJ9A==
X-Gm-Message-State: AOAM530exgt0zDBMcq/MF0pR7w8Uuz5XOjbnS4WsG++NAZ0IzdbJ5dGH
        p39qSM1KhULtmZahQYTZ04ItRRQwKKF+XNQmm1ERb1TmsXs=
X-Google-Smtp-Source: ABdhPJzpqLyz9hjGxcmkqe6bgDb5bQjZkDJ/ACZAOt6JLPZ0Vv3xvPaGa+iupinoTXNbY8MMYasXGuVC9mQ3U5f2e5o=
X-Received: by 2002:a50:fa89:: with SMTP id w9mr24432490edr.113.1632059131507;
 Sun, 19 Sep 2021 06:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAAu3APZAJD-uPUO1d4g=7smD34LUzkn87MkQKfdEcTC41FM5Vg@mail.gmail.com>
 <20210917080436.hjs3fsezznlqcxay@SoMainline.org>
In-Reply-To: <20210917080436.hjs3fsezznlqcxay@SoMainline.org>
From:   Barry Byford <31baz66@gmail.com>
Date:   Sun, 19 Sep 2021 14:45:20 +0100
Message-ID: <CAAu3APb=YP_C8zB2YXiw9oa9h5CScXqmufSREWWvSO2J5td8Rg@mail.gmail.com>
Subject: Re: Deprecated Python Libraries
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Sanchayan Maity <sanchayan@asymptotic.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Marijn,

On Fri, 17 Sept 2021 at 09:04, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Barry,
>
> On 2021-09-17 08:03:36, Barry Byford wrote:
> > The Python examples in the test directory have some dependencies that
> > have issues:
> > [..]
> > Would there be any interest in getting patches to change to these
> > different libraries?
> > Are these test scripts used in any of the automated tests?
> > Can I submit a PR via https://github.com/bluez/bluez/pulls?
>
> Perhaps of relevance: Sanchayan (cc'd) imporved some scripts for Python
> 3 compatibility (Python 2 is already deprecated for the better part of
> 1.5 years) and proper formatting [1] while working on BT LDAC [2], some
> patches made it to the list [3] but were ultimately never merged.
> Sanchayan, would you be willing to resubmit these?  Alternatively Barry
> can pick them up as part of their quest to improve the scripts for
> longevity?
>
> Disclaimer: I'm not a maintainer, merely a passer-by so don't take my
> comment as an acknowledgement to go ahead with the changes.  But if you
> do I think everyone appreciates improved shebangs and PEP8 style
> formatting (I find `black` to perform formatting nicely) along the way
> just like Sanchayan's patches.
>
> [1]: https://gitlab.freedesktop.org/SanchayanMaity/bluez/-/commits/python3/
> [2]: https://gitlab.freedesktop.org/gstreamer/gst-plugins-bad/-/merge_requests/1621
> [3]: https://lore.kernel.org/linux-bluetooth/?q=sanchayan
>

Thanks for the feedback and references.

I'm not quite sure of the purpose of the the Python scripts in the
test directory.
Do they serve the automated tests? In which case any changes need to
be carefully considered.
Or are they a base for people to interactively test BlueZ and see how
to do an implementation with the D-Bus API.
The use of bluezutils.py file seems to be inconsistent so I'm not sure
if it is preferred or not.
I regularly refer people to the Python scripts as an example of using
the BlueZ D-Bus APi and that is my motivation for wanting to see them
be improved.

I've taken a look at moving the test-adapter script across to the Gio
bindings and argparse.
This meant updating the bluezutils.py also. Once I started
restructuring things I may have got slightly carried away. I've also
added some functionality such as being able to Introspect the
interface.

Anyway, the result of my experiment is at:
https://github.com/ukBaz/bluez/commit/44f9c205f798232f9417879401b2baefa1ef01ac

Any guidance from the maintainers as to what is required of the Python
scripts in the test directory would be appreciated. Are there any
scripts in the directory that you think are good examples of what you
are looking for?

Regards,
Barry


> Thanks!
> - Marijn

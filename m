Return-Path: <SRS0=7bNH=57=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6EC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D814820774
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNkpIq2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbgDOXGr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Apr 2020 19:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387914AbgDOXGo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Apr 2020 19:06:44 -0400
Received: from mail-oo1-xc43.google.com (mail-yw1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC2CC061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 16:06:44 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id b17so261578ooa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FKQOhHYD1W+xmAoeKTnCayPMlo2f3QdiW26jM4QaH8=;
        b=TNkpIq2md52hnbZqobPVr8JgqwTuIk+w74eQ/ItcVDYm1rdLF5NzAGxrWthfMteDfB
         2J1hj+dcqTA4LlH1sM0Veic+WCit+3ORwS2/bCY2LVm+5pCIabsYQM0kOijNeHse1EE2
         PGaTa/PiNztAUgSFRVoAYWQkS2wQU7s3+mRksfx6Cyugm+IIyLGIfqJLe6faq0dKPais
         pW12mm13llb6+o8ZxkY/w4suRbREtiSqti4AQ09VKpKz5XOeGXIfhLbSPYZe7GJh6dt6
         gwtAUKrk+iLXVNq+CYhMchPDmw8jSyCshyYP9zWHz3OWv5IP2hPqSqjrUCpkvOHw+zKd
         3Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FKQOhHYD1W+xmAoeKTnCayPMlo2f3QdiW26jM4QaH8=;
        b=swJaQJkZ67MPPphQ1psHe4rCFmkIXq9Xn2IkBpTPll1Esek2FNtOINU32JReI2KGx2
         D1lRwMRyVOo1PpOkUtM66Xsh00aq0Pcz/IZpVLhgV9/QCqI/031ax0eKN9Pd5YJjPL0B
         j8Ztd6UjhlKB7WXHTXue9+7XRmkq5NvPYP4XASDPq2iYFMoWIY5lX1z5cPUCT0RCbxnR
         X3+DS+aMiUloNjzC+J+MkjSun2jOvAkzlF48U74xniXf1ecqorv/x2yqw7TUAEaCXpU8
         2Ph/4JwaSi7nRrDpT4DY0cMdJCfo6c4BZe5n3sq9sfTf90CdTe54erLyhCvZKMQAPmpZ
         NGVQ==
X-Gm-Message-State: AGi0PubEUTdMagIJOvMH7ZdkH5Jy+NE+yv1kNZLe4nPwADrD7jH/xYXP
        DfcxZHTaLDFIDLTL46oPPArKBXPmt2TLwvo9UF8aSOuY
X-Google-Smtp-Source: APiQypIgQ9ywq0jl/jqTb+ToUUoon7WNHbdNjd+wnI2B23uzYxw6/j8IZ2+V0KtLklMRi24W0rok5BiiKOkMGsb0CKY=
X-Received: by 2002:a4a:d44c:: with SMTP id p12mr24857676oos.91.1586992003078;
 Wed, 15 Apr 2020 16:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200407194059.5734-1-olivier@labapart.com> <167a95a1-38d1-9f1f-9556-7bd855c3fe81@labapart.com>
 <CABBYNZJEJR-fnLOgWFiDNB-MnyEn1BbnfpBJxkEBriYKT_EPUQ@mail.gmail.com> <9c2df62b-a864-7f85-bca9-ba3cd3de6669@labapart.com>
In-Reply-To: <9c2df62b-a864-7f85-bca9-ba3cd3de6669@labapart.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Apr 2020 16:06:31 -0700
Message-ID: <CABBYNZ+Ak_pLdNyavvVbKCB3_c7CMZPgBKywEVk8m-w-98rjOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] emulator: Fix command line parameters with
 optional argument
To:     Olivier MARTIN <olivier@labapart.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Olivier,

On Wed, Apr 15, 2020 at 3:43 PM Olivier MARTIN <olivier@labapart.com> wrote:
>
> Hi Luiz,
>
> I sent the update directly after my email. See:
> https://www.spinics.net/lists/linux-bluetooth/msg84386.html
>
> Olivier
>
> On 16.04.20 00:40, Luiz Augusto von Dentz wrote:
> > Hi Olivier,
> >
> > On Tue, Apr 7, 2020 at 12:51 PM Olivier MARTIN <olivier@labapart.com> wrote:
> >> Oops, some debug leftover. Please ignore this patch.
> > Are you still planning on sending an update for this one?
> >
> >> On 07.04.20 21:40, Olivier Martin wrote:
> >>> Some parameters were missing the indication that additional
> >>> argument could be expected.
> >>> ---
> >>>    btio/btio.c     | 8 ++++++--
> >>>    emulator/main.c | 6 ++++--
> >>>    2 files changed, 10 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/btio/btio.c b/btio/btio.c
> >>> index e7b4db16b..56c59f84e 100644
> >>> --- a/btio/btio.c
> >>> +++ b/btio/btio.c
> >>> @@ -1676,12 +1676,16 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
> >>>        ret = parse_set_opts(&opts, gerr, opt1, args);
> >>>        va_end(args);
> >>>
> >>> -     if (ret == FALSE)
> >>> +     if (ret == FALSE) {
> >>> +             fprintf(stderr, "bt_io_connect(type:%d) err1\n", opts.type);
> >>>                return NULL;
> >>> +     }
> >>>
> >>>        io = create_io(FALSE, &opts, gerr);
> >>> -     if (io == NULL)
> >>> +     if (io == NULL) {
> >>> +             fprintf(stderr, "bt_io_connect(type:%d) err2\n", opts.type);
> >>>                return NULL;
> >>> +     }
> >>>
> >>>        sock = g_io_channel_unix_get_fd(io);
> >>>
> >>> diff --git a/emulator/main.c b/emulator/main.c
> >>> index 68c53488e..75cb79c7b 100644
> >>> --- a/emulator/main.c
> >>> +++ b/emulator/main.c
> >>> @@ -56,10 +56,12 @@ static void usage(void)
> >>>        printf("options:\n"
> >>>                "\t-S                    Create local serial port\n"
> >>>                "\t-s                    Create local server sockets\n"
> >>> -             "\t-l [num]              Number of local controllers\n"
> >>> +             "\t-l[num]               Number of local controllers\n"
> >>>                "\t-L                    Create LE only controller\n"
> >>> +             "\t-U[num]               Number of test LE controllers\n"
> >>>                "\t-B                    Create BR/EDR only controller\n"
> >>>                "\t-A                    Create AMP controller\n"
> >>> +             "\t-T[num]               Number of test AMP controllers\n"
> >>>                "\t-h, --help            Show help options\n");
> >>>    }
> >>>
> >>> @@ -97,7 +99,7 @@ int main(int argc, char *argv[])
> >>>        for (;;) {
> >>>                int opt;
> >>>
> >>> -             opt = getopt_long(argc, argv, "Ssl::LBAUTvh",
> >>> +             opt = getopt_long(argc, argv, "Ssl::LBAU::T::vh",
> >>>                                                main_options, NULL);
> >>>                if (opt < 0)
> >>>                        break;
> >
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz

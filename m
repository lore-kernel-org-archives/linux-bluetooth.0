Return-Path: <SRS0=7bNH=57=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADBBC2BB55
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 22:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044F320732
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Apr 2020 22:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJd/o+Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbgDOWka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732502AbgDOWkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Apr 2020 18:40:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040A3C061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 15:40:21 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so1506800otr.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qub0N+fGm94/BGcFO7eIBujp6RLUVSouxdVyi+S6txg=;
        b=ZJd/o+MzhjrQsyVBmnN+hIVKkEvheEO7xZI/hM4dgh2k6lNHfRtDf7RaS4f2rXY3Yh
         Xp9RJVB8hazlmS3ayslEExipD26w65J4y/Yvdz8R9oTssxxa1MZ5WpBkAV+PVoRdz9C8
         fTGOnSYbb8ZUDS+PIbBSsojh3JL48U6SpH1XQMiAHTMq1+ZxtO4bZQ6th1hZaWaQDbA4
         Woj2U2UU6MoDxt4Q3GKhh7BaSEoDUQ1cN83tZzt63y9c+QV0r+oGNFDEUeygy+I34xon
         VHSFFU+FKZaKWzWHDx0rB/BTl8gsyKOmJwPvyBJo2ZuT6xK//grxKUVajemLgyWSzfG3
         /Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qub0N+fGm94/BGcFO7eIBujp6RLUVSouxdVyi+S6txg=;
        b=fIZ6VgGVcFGV78IxjFBK3sfFMQkfreqKKT7uq63oTrjbzZqLOIrasv/4e2qODP1CSi
         tabnko6KV4B2bf7zE69GtFBbfcQ4mQpftIl8rfB2BU1Y1MJnb8afN1ur30zG64NYy3Vb
         rlEiVBBteDTkkRiPpohdpeO5xAPXIMa1TTbaGGNLa77Vg1cn1PWTE1JYAIzU8m+Ro1Ot
         SuZspu19WfMknPkqMM8xQpzJ+8Pt5EjmC+lN6VznB/GDytqJeeT6u+KLV5rdue8WE460
         DDTG+WJvDLj+R7mIHaVsaleDR5zGRCxbCNUA0o4ccEHeIXq8ni3nmf5yzNIApLk8FLgd
         7OMQ==
X-Gm-Message-State: AGi0PuaqAvWDG9STRdq9wpt0m/gooOga8uHLXEnwEfoYMApybvHlc7Ms
        4MnDmuXthmY+xd9FHkstT85RzTUvgat74jTQvUGk4UYd
X-Google-Smtp-Source: APiQypIiw2Ko78IyNLtj7vW//HffX3c7BsyJ4cmhPIac7kvW1Ay8gzH4Y0senEronwf44TtdlX0q7c7g12263RlvXpM=
X-Received: by 2002:a05:6830:1d4:: with SMTP id r20mr15945080ota.11.1586990421229;
 Wed, 15 Apr 2020 15:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200407194059.5734-1-olivier@labapart.com> <167a95a1-38d1-9f1f-9556-7bd855c3fe81@labapart.com>
In-Reply-To: <167a95a1-38d1-9f1f-9556-7bd855c3fe81@labapart.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Apr 2020 15:40:09 -0700
Message-ID: <CABBYNZJEJR-fnLOgWFiDNB-MnyEn1BbnfpBJxkEBriYKT_EPUQ@mail.gmail.com>
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

On Tue, Apr 7, 2020 at 12:51 PM Olivier MARTIN <olivier@labapart.com> wrote:
>
> Oops, some debug leftover. Please ignore this patch.

Are you still planning on sending an update for this one?

> On 07.04.20 21:40, Olivier Martin wrote:
> > Some parameters were missing the indication that additional
> > argument could be expected.
> > ---
> >   btio/btio.c     | 8 ++++++--
> >   emulator/main.c | 6 ++++--
> >   2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/btio/btio.c b/btio/btio.c
> > index e7b4db16b..56c59f84e 100644
> > --- a/btio/btio.c
> > +++ b/btio/btio.c
> > @@ -1676,12 +1676,16 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpointer user_data,
> >       ret = parse_set_opts(&opts, gerr, opt1, args);
> >       va_end(args);
> >
> > -     if (ret == FALSE)
> > +     if (ret == FALSE) {
> > +             fprintf(stderr, "bt_io_connect(type:%d) err1\n", opts.type);
> >               return NULL;
> > +     }
> >
> >       io = create_io(FALSE, &opts, gerr);
> > -     if (io == NULL)
> > +     if (io == NULL) {
> > +             fprintf(stderr, "bt_io_connect(type:%d) err2\n", opts.type);
> >               return NULL;
> > +     }
> >
> >       sock = g_io_channel_unix_get_fd(io);
> >
> > diff --git a/emulator/main.c b/emulator/main.c
> > index 68c53488e..75cb79c7b 100644
> > --- a/emulator/main.c
> > +++ b/emulator/main.c
> > @@ -56,10 +56,12 @@ static void usage(void)
> >       printf("options:\n"
> >               "\t-S                    Create local serial port\n"
> >               "\t-s                    Create local server sockets\n"
> > -             "\t-l [num]              Number of local controllers\n"
> > +             "\t-l[num]               Number of local controllers\n"
> >               "\t-L                    Create LE only controller\n"
> > +             "\t-U[num]               Number of test LE controllers\n"
> >               "\t-B                    Create BR/EDR only controller\n"
> >               "\t-A                    Create AMP controller\n"
> > +             "\t-T[num]               Number of test AMP controllers\n"
> >               "\t-h, --help            Show help options\n");
> >   }
> >
> > @@ -97,7 +99,7 @@ int main(int argc, char *argv[])
> >       for (;;) {
> >               int opt;
> >
> > -             opt = getopt_long(argc, argv, "Ssl::LBAUTvh",
> > +             opt = getopt_long(argc, argv, "Ssl::LBAU::T::vh",
> >                                               main_options, NULL);
> >               if (opt < 0)
> >                       break;



-- 
Luiz Augusto von Dentz

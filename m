Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2974C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7541C64F1F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBZUyw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBZUyv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 15:54:51 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341FDC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 12:54:11 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g5so17002472ejt.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 12:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x2+ZP6PnhAZfZC6eNqTzPjTQAp6Mpg4R8gOeK3cQ1bU=;
        b=jAkvNTtXrQTtuOQeveqmFnsHnnegmkCXcIGMDVIss4aIT49C64M1Zw6IemuNju8hcH
         HSYkJ4FK75hUrJGF1PO1k+sl6+SrRjHFl2ds6Jaqy1iELhVjAUapxwGBkmdP2aVGn99u
         8rNBhqflTzfWMAOuWuZEBbLxL0FlZZWHbLPZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x2+ZP6PnhAZfZC6eNqTzPjTQAp6Mpg4R8gOeK3cQ1bU=;
        b=qa04eLfO4bpIA6Eh7c7IlV0JR5f6dgrjYIRkbS/P6ZIQR7WcvPhVj7ej5QqtYVJRNr
         XS82/UwEqVLcTIfGVYPwZafVmu75QXptZap3ymaXR76GOoczoWg7f6y1MYbJRzEu3ZHn
         rRqIHULtaHLcRQZxZwcvtiW2ESr1i9dItKShTbjNTdSzucipifUgIs8VN6L5uO4b3QJI
         YQXGMh8lNVYEivI3vGDLRvdCZ3QNvk/DuTnnFiLzy88R+vD/EVZ1tbIeB0Xxx2OXX0Cd
         LQT33qrMyjlM40nOvxZP+qs1n/T41ChA77013ThJKDV+AsV2L4USVZ4x083FqtMmD8j7
         cbWQ==
X-Gm-Message-State: AOAM530iuG9oNAoFMxcAz1H9HFNi2UIkfR4674kIJShcsY0+YLsBIp8b
        mq9z38PG6I5W95d6yulYC1KY6ly0yavtzg==
X-Google-Smtp-Source: ABdhPJzgp5pMLYVnNOu9XFTl9VFJrtmmUMt1hvkqrKy83sgCDshwZcgsvFk1R7dHg/uSMnEfJmKIIw==
X-Received: by 2002:a17:906:170a:: with SMTP id c10mr53576eje.349.1614372849708;
        Fri, 26 Feb 2021 12:54:09 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id qx17sm6102408ejb.85.2021.02.26.12.54.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 12:54:09 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id a18so1626925wrc.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 12:54:09 -0800 (PST)
X-Received: by 2002:adf:b60e:: with SMTP id f14mr5148937wre.99.1614372848912;
 Fri, 26 Feb 2021 12:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20210226181158.6538-1-sonnysasaka@chromium.org>
 <69611743-89EB-4E86-A1F3-93DEE833774E@holtmann.org> <CAO271mmPpPmJxR8zBvy-tDn441z+c0_G0_F_LTTpiMwTgCDqXA@mail.gmail.com>
In-Reply-To: <CAO271mmPpPmJxR8zBvy-tDn441z+c0_G0_F_LTTpiMwTgCDqXA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 26 Feb 2021 12:53:57 -0800
X-Gmail-Original-Message-ID: <CAO271m==xPAggx-o=4oRYNXUSqwdBYFr=nFAo4WQ247ixRYbYQ@mail.gmail.com>
Message-ID: <CAO271m==xPAggx-o=4oRYNXUSqwdBYFr=nFAo4WQ247ixRYbYQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add option to set fallback width
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I missed one of your comments in v2. Please take a look at v3 instead. Than=
ks!

On Fri, Feb 26, 2021 at 12:50 PM Sonny Sasaka <sonnysasaka@chromium.org> wr=
ote:
>
> Hi Marcel,
>
> I have addressed your comments in v2. Please take another look. Thanks!
>
> On Fri, Feb 26, 2021 at 12:09 PM Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> >
> > Hi Sonny,
> >
> > > Sometimes we want to be able to pipe the output of btmon to a
> > > non-terminal device. The current fallback width is usually not long
> > > enough so this patch adds an option to specify the column width. This=
 is
> > > especially needed for text logs from bluetoothd.
> > >
> > > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > >
> > > ---
> > > monitor/control.c |  4 ++--
> > > monitor/control.h |  2 +-
> > > monitor/display.c |  8 ++++++--
> > > monitor/display.h |  2 +-
> > > monitor/main.c    | 10 ++++++++--
> > > 5 files changed, 18 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/monitor/control.c b/monitor/control.c
> > > index d1ba97d37..00001bf1e 100644
> > > --- a/monitor/control.c
> > > +++ b/monitor/control.c
> > > @@ -1474,7 +1474,7 @@ bool control_writer(const char *path)
> > >       return !!btsnoop_file;
> > > }
> > >
> > > -void control_reader(const char *path, bool pager)
> > > +void control_reader(const char *path, bool pager, int column)
> > > {
> > >       unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
> > >       uint16_t pktlen;
> > > @@ -1500,7 +1500,7 @@ void control_reader(const char *path, bool page=
r)
> > >       }
> > >
> > >       if (pager)
> > > -             open_pager();
> > > +             open_pager(column);
> > >
> > >       switch (format) {
> > >       case BTSNOOP_FORMAT_HCI:
> > > diff --git a/monitor/control.h b/monitor/control.h
> > > index 29616c4f1..ad16358b1 100644
> > > --- a/monitor/control.h
> > > +++ b/monitor/control.h
> > > @@ -12,7 +12,7 @@
> > > #include <stdint.h>
> > >
> > > bool control_writer(const char *path);
> > > -void control_reader(const char *path, bool pager);
> > > +void control_reader(const char *path, bool pager, int column);
> > > void control_server(const char *path);
> > > int control_tty(const char *path, unsigned int speed);
> > > int control_rtt(char *jlink, char *rtt);
> > > diff --git a/monitor/display.c b/monitor/display.c
> > > index b11b71d5d..598db8080 100644
> > > --- a/monitor/display.c
> > > +++ b/monitor/display.c
> > > @@ -28,6 +28,7 @@
> > > #include "display.h"
> > >
> > > static pid_t pager_pid =3D 0;
> > > +static int output_width =3D 0;
> >
> > why not set this to FALLBACK_TERMINAL_WIDTH?
> >
> > > bool use_color(void)
> > > {
> > > @@ -48,7 +49,8 @@ int num_columns(void)
> > >
> > >               if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 ||
> > >                                                               ws.ws_c=
ol =3D=3D 0)
> > > -                     cached_num_columns =3D FALLBACK_TERMINAL_WIDTH;
> > > +                     cached_num_columns =3D output_width > 0 ?
> > > +                             output_width : FALLBACK_TERMINAL_WIDTH;
> > >               else
> > >                       cached_num_columns =3D ws.ws_col;
> > >       }
> > > @@ -81,12 +83,14 @@ static void wait_for_terminate(pid_t pid)
> > >       }
> > > }
> > >
> > > -void open_pager(void)
> > > +void open_pager(int column)
> > > {
> > >       const char *pager;
> > >       pid_t parent_pid;
> > >       int fd[2];
> > >
> > > +     output_width =3D column;
> > > +
> > >       if (pager_pid > 0)
> > >               return;
> > >
> > > diff --git a/monitor/display.h b/monitor/display.h
> > > index f3a614b81..70734d590 100644
> > > --- a/monitor/display.h
> > > +++ b/monitor/display.h
> > > @@ -75,5 +75,5 @@ static inline uint64_t print_bitfield(int indent, u=
int64_t val,
> > >
> > > int num_columns(void);
> > >
> > > -void open_pager(void);
> > > +void open_pager(int column);
> > > void close_pager(void);
> > > diff --git a/monitor/main.c b/monitor/main.c
> > > index 0f5eb4a3b..5996eed40 100644
> > > --- a/monitor/main.c
> > > +++ b/monitor/main.c
> > > @@ -67,6 +67,7 @@ static void usage(void)
> > >               "\t                       Read data from RTT\n"
> > >               "\t-R  --rtt [<address>],[<area>],[<name>]\n"
> > >               "\t                       RTT control block parameters\=
n"
> > > +             "\t-c, --column [width]   Output width if not a termina=
l\n"
> >
> > I think we should be using uppercase C.
> >
> > >               "\t-h, --help             Show help options\n");
> > > }
> > >
> > > @@ -90,6 +91,7 @@ static const struct option main_options[] =3D {
> > >       { "no-pager",  no_argument,       NULL, 'P' },
> > >       { "jlink",     required_argument, NULL, 'J' },
> > >       { "rtt",       required_argument, NULL, 'R' },
> > > +     { "column",    required_argument, NULL, 'c' },
> > >       { "todo",      no_argument,       NULL, '#' },
> > >       { "version",   no_argument,       NULL, 'v' },
> > >       { "help",      no_argument,       NULL, 'h' },
> > > @@ -110,6 +112,7 @@ int main(int argc, char *argv[])
> > >       const char *str;
> > >       char *jlink =3D NULL;
> > >       char *rtt =3D NULL;
> > > +     int column =3D 0;
> > >       int exit_status;
> > >
> > >       mainloop_init();
> > > @@ -121,7 +124,7 @@ int main(int argc, char *argv[])
> > >               struct sockaddr_un addr;
> > >
> > >               opt =3D getopt_long(argc, argv,
> > > -                                     "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R=
:vh",
> > > +                                     "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R=
:vhc:",
> >
> > Please don=E2=80=99t put this at the end. The vh is at the end on purpo=
se.
> >
> > >                                       main_options, NULL);
> > >               if (opt < 0)
> > >                       break;
> > > @@ -205,6 +208,9 @@ int main(int argc, char *argv[])
> > >               case 'R':
> > >                       rtt =3D optarg;
> > >                       break;
> > > +             case 'c':
> > > +                     column =3D atoi(optarg);
> > > +                     break;
> > >               case '#':
> > >                       packet_todo();
> > >                       lmp_todo();
> > > @@ -245,7 +251,7 @@ int main(int argc, char *argv[])
> > >               if (ellisys_server)
> > >                       ellisys_enable(ellisys_server, ellisys_port);
> > >
> > > -             control_reader(reader_path, use_pager);
> > > +             control_reader(reader_path, use_pager, column);
> >
> > I prefer that we use a bit more descriptive variable names here. So eit=
her num_columns or pager_width or something like that.
> >
> > >               return EXIT_SUCCESS;
> > >       }
> >
> > Regards
> >
> > Marcel
> >

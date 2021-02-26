Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EDAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DF664F13
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 20:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhBZUvm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBZUvj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 15:51:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B56C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 12:50:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id h19so12582456edb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 12:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GA3SgutCECgPYRhOWjzIAlXIghg2kVN5Rk1StpSXfZc=;
        b=gXLxuIlPs47Mu3Db+2N0fOd4xZZGcBnkuNgmO2zQK2dGGpbWAmIG6Jirhw+bzmAbba
         SGDSBUHt+LPbNLcxKpFyqQ94AsLbh0iBkYDbPWPY9rFmtVj5OFKJ4U0Yf3uFc2VWVCiF
         tm8ktIucZ2keqBYU6I5qD18rgFi1hjWhtCsro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GA3SgutCECgPYRhOWjzIAlXIghg2kVN5Rk1StpSXfZc=;
        b=egfpOBF+zo08akWxXN9eiztVMkG9NksS8GUxSPZlqYMMOrVn6H9eBR7xcTveWKOzSZ
         TBhKr2khkDSpF+wFO5/8yCj1Sc3NPDX7tTjB4G9y+S+Se39Qet3Q4OWwsTKXZmkxhshd
         qDSMk/HEIukRW2UpFYciyYHm0D5Is4oiLRRlPbhDr1BwPx2IIy/T46sFsGiTxEm8v1JF
         Xz668Za7WHFWGcEXkR+ExcSEyu2oYMMdbsO2/nEHmzYHXOrnu/e50r60eXeND8tsdb62
         N0FkwySoAxddq8lOazLUCaRskAaXfrMW+S/vhJPmYrOpf3T1IHryZ6SYbcrYtEibCmoc
         Mhrw==
X-Gm-Message-State: AOAM5339ED4PzXcXW44nyYYxhMFdwn58Gv6STNfykjEzegVOkBpKpX8Y
        Rtf0R0HU1MJJMSFvQ6qcqKyjP5vH/cf4WA==
X-Google-Smtp-Source: ABdhPJxahMq2dlK3lo2cDqMssT1k9nzHwTOhEW/MdAiOyBwj659at5elzBCuSD2Tg/ZNcDfg16/h4A==
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr5496996edv.116.1614372657653;
        Fri, 26 Feb 2021 12:50:57 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id l6sm6868598edn.82.2021.02.26.12.50.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 12:50:57 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id a18so1620343wrc.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 12:50:57 -0800 (PST)
X-Received: by 2002:a5d:6042:: with SMTP id j2mr5164261wrt.336.1614372657002;
 Fri, 26 Feb 2021 12:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20210226181158.6538-1-sonnysasaka@chromium.org> <69611743-89EB-4E86-A1F3-93DEE833774E@holtmann.org>
In-Reply-To: <69611743-89EB-4E86-A1F3-93DEE833774E@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 26 Feb 2021 12:50:45 -0800
X-Gmail-Original-Message-ID: <CAO271mmPpPmJxR8zBvy-tDn441z+c0_G0_F_LTTpiMwTgCDqXA@mail.gmail.com>
Message-ID: <CAO271mmPpPmJxR8zBvy-tDn441z+c0_G0_F_LTTpiMwTgCDqXA@mail.gmail.com>
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

I have addressed your comments in v2. Please take another look. Thanks!

On Fri, Feb 26, 2021 at 12:09 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Sonny,
>
> > Sometimes we want to be able to pipe the output of btmon to a
> > non-terminal device. The current fallback width is usually not long
> > enough so this patch adds an option to specify the column width. This i=
s
> > especially needed for text logs from bluetoothd.
> >
> > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> >
> > ---
> > monitor/control.c |  4 ++--
> > monitor/control.h |  2 +-
> > monitor/display.c |  8 ++++++--
> > monitor/display.h |  2 +-
> > monitor/main.c    | 10 ++++++++--
> > 5 files changed, 18 insertions(+), 8 deletions(-)
> >
> > diff --git a/monitor/control.c b/monitor/control.c
> > index d1ba97d37..00001bf1e 100644
> > --- a/monitor/control.c
> > +++ b/monitor/control.c
> > @@ -1474,7 +1474,7 @@ bool control_writer(const char *path)
> >       return !!btsnoop_file;
> > }
> >
> > -void control_reader(const char *path, bool pager)
> > +void control_reader(const char *path, bool pager, int column)
> > {
> >       unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
> >       uint16_t pktlen;
> > @@ -1500,7 +1500,7 @@ void control_reader(const char *path, bool pager)
> >       }
> >
> >       if (pager)
> > -             open_pager();
> > +             open_pager(column);
> >
> >       switch (format) {
> >       case BTSNOOP_FORMAT_HCI:
> > diff --git a/monitor/control.h b/monitor/control.h
> > index 29616c4f1..ad16358b1 100644
> > --- a/monitor/control.h
> > +++ b/monitor/control.h
> > @@ -12,7 +12,7 @@
> > #include <stdint.h>
> >
> > bool control_writer(const char *path);
> > -void control_reader(const char *path, bool pager);
> > +void control_reader(const char *path, bool pager, int column);
> > void control_server(const char *path);
> > int control_tty(const char *path, unsigned int speed);
> > int control_rtt(char *jlink, char *rtt);
> > diff --git a/monitor/display.c b/monitor/display.c
> > index b11b71d5d..598db8080 100644
> > --- a/monitor/display.c
> > +++ b/monitor/display.c
> > @@ -28,6 +28,7 @@
> > #include "display.h"
> >
> > static pid_t pager_pid =3D 0;
> > +static int output_width =3D 0;
>
> why not set this to FALLBACK_TERMINAL_WIDTH?
>
> > bool use_color(void)
> > {
> > @@ -48,7 +49,8 @@ int num_columns(void)
> >
> >               if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 ||
> >                                                               ws.ws_col=
 =3D=3D 0)
> > -                     cached_num_columns =3D FALLBACK_TERMINAL_WIDTH;
> > +                     cached_num_columns =3D output_width > 0 ?
> > +                             output_width : FALLBACK_TERMINAL_WIDTH;
> >               else
> >                       cached_num_columns =3D ws.ws_col;
> >       }
> > @@ -81,12 +83,14 @@ static void wait_for_terminate(pid_t pid)
> >       }
> > }
> >
> > -void open_pager(void)
> > +void open_pager(int column)
> > {
> >       const char *pager;
> >       pid_t parent_pid;
> >       int fd[2];
> >
> > +     output_width =3D column;
> > +
> >       if (pager_pid > 0)
> >               return;
> >
> > diff --git a/monitor/display.h b/monitor/display.h
> > index f3a614b81..70734d590 100644
> > --- a/monitor/display.h
> > +++ b/monitor/display.h
> > @@ -75,5 +75,5 @@ static inline uint64_t print_bitfield(int indent, uin=
t64_t val,
> >
> > int num_columns(void);
> >
> > -void open_pager(void);
> > +void open_pager(int column);
> > void close_pager(void);
> > diff --git a/monitor/main.c b/monitor/main.c
> > index 0f5eb4a3b..5996eed40 100644
> > --- a/monitor/main.c
> > +++ b/monitor/main.c
> > @@ -67,6 +67,7 @@ static void usage(void)
> >               "\t                       Read data from RTT\n"
> >               "\t-R  --rtt [<address>],[<area>],[<name>]\n"
> >               "\t                       RTT control block parameters\n"
> > +             "\t-c, --column [width]   Output width if not a terminal\=
n"
>
> I think we should be using uppercase C.
>
> >               "\t-h, --help             Show help options\n");
> > }
> >
> > @@ -90,6 +91,7 @@ static const struct option main_options[] =3D {
> >       { "no-pager",  no_argument,       NULL, 'P' },
> >       { "jlink",     required_argument, NULL, 'J' },
> >       { "rtt",       required_argument, NULL, 'R' },
> > +     { "column",    required_argument, NULL, 'c' },
> >       { "todo",      no_argument,       NULL, '#' },
> >       { "version",   no_argument,       NULL, 'v' },
> >       { "help",      no_argument,       NULL, 'h' },
> > @@ -110,6 +112,7 @@ int main(int argc, char *argv[])
> >       const char *str;
> >       char *jlink =3D NULL;
> >       char *rtt =3D NULL;
> > +     int column =3D 0;
> >       int exit_status;
> >
> >       mainloop_init();
> > @@ -121,7 +124,7 @@ int main(int argc, char *argv[])
> >               struct sockaddr_un addr;
> >
> >               opt =3D getopt_long(argc, argv,
> > -                                     "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:v=
h",
> > +                                     "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:v=
hc:",
>
> Please don=E2=80=99t put this at the end. The vh is at the end on purpose=
.
>
> >                                       main_options, NULL);
> >               if (opt < 0)
> >                       break;
> > @@ -205,6 +208,9 @@ int main(int argc, char *argv[])
> >               case 'R':
> >                       rtt =3D optarg;
> >                       break;
> > +             case 'c':
> > +                     column =3D atoi(optarg);
> > +                     break;
> >               case '#':
> >                       packet_todo();
> >                       lmp_todo();
> > @@ -245,7 +251,7 @@ int main(int argc, char *argv[])
> >               if (ellisys_server)
> >                       ellisys_enable(ellisys_server, ellisys_port);
> >
> > -             control_reader(reader_path, use_pager);
> > +             control_reader(reader_path, use_pager, column);
>
> I prefer that we use a bit more descriptive variable names here. So eithe=
r num_columns or pager_width or something like that.
>
> >               return EXIT_SUCCESS;
> >       }
>
> Regards
>
> Marcel
>

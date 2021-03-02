Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0488C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A99C6186A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhCBWyn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Mar 2021 17:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348245AbhCBAm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Mar 2021 19:42:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C316C061756
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Mar 2021 16:42:17 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w9so7016174edt.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Mar 2021 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tum/uXtWvvhizYRwVyZfCdVJt1hBPcvIx5+gWro/lBE=;
        b=hru06s7ATY7IzGeQ4Per98nbcDtMvuD4hsrjsYRZmWJuOOaUw+/207eGfkVPGl49Hs
         0c278DKmQi3KYaCqrjnugQBXbep8Dx96yodJIcVejAK7d1MM/fI0XIONEBF5IYWt/oJi
         VobmlnTXJtZa50m9ZjOBVkHv0EO7qvHjLlwJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tum/uXtWvvhizYRwVyZfCdVJt1hBPcvIx5+gWro/lBE=;
        b=OzdOEgD0TIHrUgR7jmMnGcdVWRIVW4HQDwVZLn9R3z0X0YUfPWH9kt6vyO96eZMdL7
         +c+Spsvi2w9roJ2Q8gjqAr15L654urtwryfw7q3r4sF0ByvWLkVEXMmjr92dIZ5CVltr
         A9tD1ciftr933DPxE3dkDLEUiXDur0amwHrBcKq+w1ZAPsAJr63eFYJZaPa+cKXs1Dos
         0lp5Yw8XvZm/oEUZVzHVjObERGzsJXvJRd6Upw89+Wnt8QQeFvDO/iWFX+T0+WJuAzMu
         /J2vfLTckmlvZ/WchJW3GU86lfpbJAg/n0+QhVm5IXr0TQ123ubol6l4mALU4cpLOSxz
         LzwA==
X-Gm-Message-State: AOAM5308Yc+4WleDvkA2pQ0hpHGgRydjMSwURdbsy+iL3QxDLsfPX/Ma
        Dn79mmHmhZyUhP4qL3dPnspw6gHOeEEpaw==
X-Google-Smtp-Source: ABdhPJynMongM2H2WayIe1x44ggIMyA+aV0JVbdhSOL3MybHUQIw+XWvlRkk4FI5euJCJFuglBXMJQ==
X-Received: by 2002:aa7:cf02:: with SMTP id a2mr16886188edy.59.1614645735459;
        Mon, 01 Mar 2021 16:42:15 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id d5sm17080811edu.12.2021.03.01.16.42.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Mar 2021 16:42:14 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id k66so924924wmf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Mar 2021 16:42:14 -0800 (PST)
X-Received: by 2002:a1c:e383:: with SMTP id a125mr1255406wmh.125.1614645734497;
 Mon, 01 Mar 2021 16:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20210226205232.6844-1-sonnysasaka@chromium.org> <728662E2-D299-4753-AC81-99D321ABB7A7@holtmann.org>
In-Reply-To: <728662E2-D299-4753-AC81-99D321ABB7A7@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 1 Mar 2021 16:42:03 -0800
X-Gmail-Original-Message-ID: <CAO271m=S6Er136ZYw5wWLW8sF+QeWXDV=7qvk5-YPwvfrJNo_Q@mail.gmail.com>
Message-ID: <CAO271m=S6Er136ZYw5wWLW8sF+QeWXDV=7qvk5-YPwvfrJNo_Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] monitor: Add option to set fallback width
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, please take another look at v4 of this patch. Since you
mention of making it a global variable, I remove the variable passing
altogether and instead added an interface to set the global pager
width.

On Sat, Feb 27, 2021 at 12:22 PM Marcel Holtmann <marcel@holtmann.org> wrot=
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
> > index d1ba97d37..2fab87320 100644
> > --- a/monitor/control.c
> > +++ b/monitor/control.c
> > @@ -1474,7 +1474,7 @@ bool control_writer(const char *path)
> >       return !!btsnoop_file;
> > }
> >
> > -void control_reader(const char *path, bool pager)
> > +void control_reader(const char *path, bool pager, int num_columns)
> > {
> >       unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
> >       uint16_t pktlen;
> > @@ -1500,7 +1500,7 @@ void control_reader(const char *path, bool pager)
> >       }
> >
> >       if (pager)
> > -             open_pager();
> > +             open_pager(num_columns);
> >
> >       switch (format) {
> >       case BTSNOOP_FORMAT_HCI:
> > diff --git a/monitor/control.h b/monitor/control.h
> > index 29616c4f1..b96c542fc 100644
> > --- a/monitor/control.h
> > +++ b/monitor/control.h
> > @@ -12,7 +12,7 @@
> > #include <stdint.h>
> >
> > bool control_writer(const char *path);
> > -void control_reader(const char *path, bool pager);
> > +void control_reader(const char *path, bool pager, int num_columns);
> > void control_server(const char *path);
> > int control_tty(const char *path, unsigned int speed);
> > int control_rtt(char *jlink, char *rtt);
> > diff --git a/monitor/display.c b/monitor/display.c
> > index b11b71d5d..08db18147 100644
> > --- a/monitor/display.c
> > +++ b/monitor/display.c
> > @@ -28,6 +28,7 @@
> > #include "display.h"
> >
> > static pid_t pager_pid =3D 0;
> > +static int n_columns =3D FALLBACK_TERMINAL_WIDTH;
>
> hmmm. Wouldn=E2=80=99t be default_num_columns better a bit better here an=
d more descriptive what the variable does?
>
> >
> > bool use_color(void)
> > {
> > @@ -48,7 +49,8 @@ int num_columns(void)
> >
> >               if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 ||
> >                                                               ws.ws_col=
 =3D=3D 0)
> > -                     cached_num_columns =3D FALLBACK_TERMINAL_WIDTH;
> > +                     cached_num_columns =3D n_columns > 0 ?
> > +                             n_columns : FALLBACK_TERMINAL_WIDTH;
>
> Just set cached_num_columns =3D default_num_columns.
>
> >               else
> >                       cached_num_columns =3D ws.ws_col;
> >       }
> > @@ -81,12 +83,14 @@ static void wait_for_terminate(pid_t pid)
> >       }
> > }
> >
> > -void open_pager(void)
> > +void open_pager(int columns)
> > {
> >       const char *pager;
> >       pid_t parent_pid;
> >       int fd[2];
> >
> > +     n_columns =3D columns;
> > +
> >       if (pager_pid > 0)
> >               return;
> >
> > diff --git a/monitor/display.h b/monitor/display.h
> > index f3a614b81..97aac8f7a 100644
> > --- a/monitor/display.h
> > +++ b/monitor/display.h
> > @@ -75,5 +75,5 @@ static inline uint64_t print_bitfield(int indent, uin=
t64_t val,
> >
> > int num_columns(void);
> >
> > -void open_pager(void);
> > +void open_pager(int);
>
> I know that this is fine, but don=E2=80=99t do that. Include the paramete=
r name please.
>
> > void close_pager(void);
> > diff --git a/monitor/main.c b/monitor/main.c
> > index 0f5eb4a3b..23a16660f 100644
> > --- a/monitor/main.c
> > +++ b/monitor/main.c
> > @@ -67,6 +67,7 @@ static void usage(void)
> >               "\t                       Read data from RTT\n"
> >               "\t-R  --rtt [<address>],[<area>],[<name>]\n"
> >               "\t                       RTT control block parameters\n"
> > +             "\t-C, --column [width]   Output width if not a terminal\=
n"
> >               "\t-h, --help             Show help options\n");
> > }
> >
> > @@ -90,6 +91,7 @@ static const struct option main_options[] =3D {
> >       { "no-pager",  no_argument,       NULL, 'P' },
> >       { "jlink",     required_argument, NULL, 'J' },
> >       { "rtt",       required_argument, NULL, 'R' },
> > +     { "column",    required_argument, NULL, 'C' },
>
> Not plural =E2=80=9Ccolumns=E2=80=9D here?
>
> >       { "todo",      no_argument,       NULL, '#' },
> >       { "version",   no_argument,       NULL, 'v' },
> >       { "help",      no_argument,       NULL, 'h' },
> > @@ -110,6 +112,7 @@ int main(int argc, char *argv[])
> >       const char *str;
> >       char *jlink =3D NULL;
> >       char *rtt =3D NULL;
> > +     int num_columns =3D 0;
> >       int exit_status;
> >
> >       mainloop_init();
> > @@ -121,7 +124,7 @@ int main(int argc, char *argv[])
> >               struct sockaddr_un addr;
> >
> >               opt =3D getopt_long(argc, argv,
> > -                                     "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:v=
h",
> > +                                     "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C=
:vh",
> >                                       main_options, NULL);
> >               if (opt < 0)
> >                       break;
> > @@ -205,6 +208,9 @@ int main(int argc, char *argv[])
> >               case 'R':
> >                       rtt =3D optarg;
> >                       break;
> > +             case 'C':
> > +                     num_columns =3D atoi(optarg);
> > +                     break;
>
> I would have set here default_num_columns global variable.
>
> >               case '#':
> >                       packet_todo();
> >                       lmp_todo();
> > @@ -245,7 +251,7 @@ int main(int argc, char *argv[])
> >               if (ellisys_server)
> >                       ellisys_enable(ellisys_server, ellisys_port);
> >
> > -             control_reader(reader_path, use_pager);
> > +             control_reader(reader_path, use_pager, num_columns);
> >               return EXIT_SUCCESS;
> >       }
>
> Regards
>
> Marcel
>

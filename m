Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C638C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1999F64F1B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 23:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCRXBQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 19:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhCRXBO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 19:01:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E16C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 16:01:14 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id m13so2758119oiw.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUN5dEZINowEVHS4xmL1Ss0QEbzDw80Z9pDbLYZy2+4=;
        b=W2NWIcgz5z08PqzanY/jw/Xi89Ktj1u/LAy+GYL117Lb1EAF3yduaHXiaw668hvkRf
         fR8yvW+JqXyfLMYLRATvz0lBlSv+KyjYx9amBJ8BAP+rAOz6NVZkpQurHrbbXOhA8RVB
         pkdlKNMbgoo3RVqlD6CruzXI6lCaRN4mB4firrrrxTpjr7lyDC7JAOZfXPucuylelpB1
         NozG6R/29wVeRQ2c8lm4N7ZteBuD1ANRLwX9wC8wKLmyOmEajt145TwVspbdsPtvtV3X
         ZPhZT0PhAb8W8WmT4zFFWL7yNUNkUUtu150ctM0Mur3hfti7ApffiDvsGYUnzL8cB0qV
         AfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUN5dEZINowEVHS4xmL1Ss0QEbzDw80Z9pDbLYZy2+4=;
        b=H4BCTQvcaFYk9287s7HqxbDUYEcU2UbwU1cL5WdU557kiCGh3j1OasNYYIuqAdN5U8
         k3T+Ux7K1emtTKU2+GZhddieZOdf1TOzZUfVbIbmb1xgTsJ478PuExquj9bFBD3cFG6C
         /Q2Pm7FquEWuJi8DYs33GdQ2FrymIydOgghUszDU+Yo3ZOCRCcAqqeQQLEmWLeMhJyRJ
         iLqNAMtAjPrqR/mn8JpOGpywl5XEV7LO1Q6K/dvt3+ffNdOD2/9MJMajGX71mIsQR2s7
         MR+QYcteJX5CqnWToT0ptwgID6F9WfR/rrpgfurujuNbo9bPijXuNoHpXOxN8qU471SW
         9TtQ==
X-Gm-Message-State: AOAM5318+kMP6iTWNosRnqpNq0DOUSQPJOe6B7tML5etTudwz73syAVS
        c0oXFvEZAvzT5SJ8OP0fSzgfTdgn+zmFAil4jdU=
X-Google-Smtp-Source: ABdhPJxkGyv/j2V2gmsaHF5F+J59vkG4TN/GxL0YWDMLiGt5tBOFm+B2IZVI7/2FBCS3DiBgDpw3ft1HbUvTeQDFWJY=
X-Received: by 2002:a54:468f:: with SMTP id k15mr4666135oic.58.1616108473404;
 Thu, 18 Mar 2021 16:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221648.11839-1-sonnysasaka@chromium.org> <CAO271mmpyMp1eO6tCvcs6WQRP6v_bxCkPjbQzK10wxv-DfK1eA@mail.gmail.com>
In-Reply-To: <CAO271mmpyMp1eO6tCvcs6WQRP6v_bxCkPjbQzK10wxv-DfK1eA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Mar 2021 16:01:02 -0700
Message-ID: <CABBYNZKOiE0pRsHZ87fU=icsYbFru-G28jB9i3BMEBJE8e066Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add option to force output color
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Mar 18, 2021 at 11:19 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz/Marcel,
>
> Friendly ping to review this patch. Thanks!
>
>
> On Tue, Mar 16, 2021 at 3:17 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Sometimes we want to force output color even when stdout is not a
> > terminal, for example when piping the output to a filter script and then
> > piping it further to a pager which can display colors.
> >
> > This patch provides a general option to force whether color is on or off
> > (always and never), or leave btmon to decide (auto).
> >
> > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> >
> > ---
> >  monitor/display.c | 12 +++++++++++-
> >  monitor/display.h |  3 +++
> >  monitor/main.c    | 17 ++++++++++++++++-
> >  3 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/monitor/display.c b/monitor/display.c
> > index 4e5693b04..d61a79a38 100644
> > --- a/monitor/display.c
> > +++ b/monitor/display.c
> > @@ -29,12 +29,22 @@
> >
> >  static pid_t pager_pid = 0;
> >  int default_pager_num_columns = FALLBACK_TERMINAL_WIDTH;
> > +enum monitor_color setting_monitor_color = COLOR_AUTO;
> > +
> > +void set_monitor_color(enum monitor_color color)
> > +{
> > +       setting_monitor_color = color;
> > +}
> >
> >  bool use_color(void)
> >  {
> >         static int cached_use_color = -1;
> >
> > -       if (__builtin_expect(!!(cached_use_color < 0), 0))
> > +       if (setting_monitor_color == COLOR_ALWAYS)
> > +               cached_use_color = 1;
> > +       else if (setting_monitor_color == COLOR_NEVER)
> > +               cached_use_color = 0;
> > +       else if (__builtin_expect(!!(cached_use_color < 0), 0))
> >                 cached_use_color = isatty(STDOUT_FILENO) > 0 || pager_pid > 0;
> >
> >         return cached_use_color;
> > diff --git a/monitor/display.h b/monitor/display.h
> > index cba39ec7f..be5739833 100644
> > --- a/monitor/display.h
> > +++ b/monitor/display.h
> > @@ -14,6 +14,9 @@
> >
> >  bool use_color(void);
> >
> > +enum monitor_color { COLOR_AUTO, COLOR_ALWAYS, COLOR_NEVER };
> > +void set_monitor_color(enum monitor_color);
> > +
> >  #define COLOR_OFF      "\x1B[0m"
> >  #define COLOR_BLACK    "\x1B[0;30m"
> >  #define COLOR_RED      "\x1B[0;31m"
> > diff --git a/monitor/main.c b/monitor/main.c
> > index 969c88103..3ec3a5f08 100644
> > --- a/monitor/main.c
> > +++ b/monitor/main.c
> > @@ -69,6 +69,7 @@ static void usage(void)
> >                 "\t-R  --rtt [<address>],[<area>],[<name>]\n"
> >                 "\t                       RTT control block parameters\n"
> >                 "\t-C, --columns [width]  Output width if not a terminal\n"
> > +               "\t-c, --color [mode]     Output color: auto/always/never\n"
> >                 "\t-h, --help             Show help options\n");
> >  }
> >
> > @@ -93,6 +94,7 @@ static const struct option main_options[] = {
> >         { "jlink",     required_argument, NULL, 'J' },
> >         { "rtt",       required_argument, NULL, 'R' },
> >         { "columns",   required_argument, NULL, 'C' },
> > +       { "color",     required_argument, NULL, 'c' },
> >         { "todo",      no_argument,       NULL, '#' },
> >         { "version",   no_argument,       NULL, 'v' },
> >         { "help",      no_argument,       NULL, 'h' },
> > @@ -124,7 +126,7 @@ int main(int argc, char *argv[])
> >                 struct sockaddr_un addr;
> >
> >                 opt = getopt_long(argc, argv,
> > -                                       "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:vh",
> > +                                       "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:c:vh",
> >                                         main_options, NULL);
> >                 if (opt < 0)
> >                         break;
> > @@ -211,6 +213,19 @@ int main(int argc, char *argv[])
> >                 case 'C':
> >                         set_default_pager_num_columns(atoi(optarg));
> >                         break;
> > +               case 'c':
> > +                       if (strcmp("always", optarg) == 0)
> > +                               set_monitor_color(COLOR_ALWAYS);
> > +                       else if (strcmp("never", optarg) == 0)
> > +                               set_monitor_color(COLOR_NEVER);
> > +                       else if (strcmp("auto", optarg) == 0)
> > +                               set_monitor_color(COLOR_AUTO);
> > +                       else {
> > +                               fprintf(stderr, "Color option must be one of "
> > +                                               "auto/always/never\n");
> > +                               return EXIT_FAILURE;
> > +                       }
> > +                       break;
> >                 case '#':
> >                         packet_todo();
> >                         lmp_todo();
> > --
> > 2.29.2
> >

Applied, thanks.

-- 
Luiz Augusto von Dentz

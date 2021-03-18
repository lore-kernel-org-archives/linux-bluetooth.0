Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A0C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 18:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F58564F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 18:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhCRSRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhCRSRB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 14:17:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A558C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 11:17:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y6so7874638eds.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StFz4lOhqp4aDZcL/XmMeguaYtoNZPINP1LY38vjBqo=;
        b=cqC6J8lXDFrNYt3inCDwWIHTwCDimptQuwWd/Gxp2FWU1R1vRvSf5prY+02I0QuUnv
         yEITQbutJngHwGmP2kuGdYEGy8lwvU1tHpMpjH5rgRghm+XmSGh2bEIl1XGQE1nIkjJ/
         fhTYL+0hr+GVJEKiUsK70g/0DncJyfMdwX+K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StFz4lOhqp4aDZcL/XmMeguaYtoNZPINP1LY38vjBqo=;
        b=EYHdQV1zEGrbDEdXAiBR8NG7f9N/h33GjTTSgLYWIWspc3JF7w6gIAjoFclUFQpv/M
         dh1HGBYe/4vkcccTbMHYU4cidWxQ/+GN53SutsmtC/Rb7QmurRH/78/jNlEHtIYAAdDr
         8tGLUODVWbYY+5LRVC25Sa5lcnLmnq+uEonWkauEV9FZvXEr4k3SU7MB7Q8446Ed64+Z
         lkEtR/HkUCyAmmowT64cdUQUWQExjQsqWmuwKY6dX/0n5ybcvN+BeHRD3021Uhic3I8j
         IPLCoshVSAdqRwJZMGXqceD8+wRulNAbSBmL3jAK4vRr/jtL5ik9LE9fqeh7UVPzx3e6
         hiyw==
X-Gm-Message-State: AOAM532DQrYMorHG13eAG66uHs2fmSOUPMxNc152VRT/t0+4vj02C5Ky
        ohQ8pnFIh/6+sPQkKo8QpldjZ9Tco4SooA==
X-Google-Smtp-Source: ABdhPJy+jhgtsZKp/e4jsz6pSu2ZCHPxnNjgAAxZibp9trVcfbXRvROkCqLy6mQMztAly8vF37fmCw==
X-Received: by 2002:aa7:dc0b:: with SMTP id b11mr5367500edu.124.1616091420130;
        Thu, 18 Mar 2021 11:17:00 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id p9sm2665295edu.79.2021.03.18.11.16.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 11:16:59 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso5976538wmi.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 11:16:59 -0700 (PDT)
X-Received: by 2002:a05:600c:2f08:: with SMTP id r8mr390347wmn.95.1616091419218;
 Thu, 18 Mar 2021 11:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221648.11839-1-sonnysasaka@chromium.org>
In-Reply-To: <20210316221648.11839-1-sonnysasaka@chromium.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 18 Mar 2021 11:16:48 -0700
X-Gmail-Original-Message-ID: <CAO271mmpyMp1eO6tCvcs6WQRP6v_bxCkPjbQzK10wxv-DfK1eA@mail.gmail.com>
Message-ID: <CAO271mmpyMp1eO6tCvcs6WQRP6v_bxCkPjbQzK10wxv-DfK1eA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Add option to force output color
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Cc:     Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz/Marcel,

Friendly ping to review this patch. Thanks!


On Tue, Mar 16, 2021 at 3:17 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Sometimes we want to force output color even when stdout is not a
> terminal, for example when piping the output to a filter script and then
> piping it further to a pager which can display colors.
>
> This patch provides a general option to force whether color is on or off
> (always and never), or leave btmon to decide (auto).
>
> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
>
> ---
>  monitor/display.c | 12 +++++++++++-
>  monitor/display.h |  3 +++
>  monitor/main.c    | 17 ++++++++++++++++-
>  3 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/display.c b/monitor/display.c
> index 4e5693b04..d61a79a38 100644
> --- a/monitor/display.c
> +++ b/monitor/display.c
> @@ -29,12 +29,22 @@
>
>  static pid_t pager_pid = 0;
>  int default_pager_num_columns = FALLBACK_TERMINAL_WIDTH;
> +enum monitor_color setting_monitor_color = COLOR_AUTO;
> +
> +void set_monitor_color(enum monitor_color color)
> +{
> +       setting_monitor_color = color;
> +}
>
>  bool use_color(void)
>  {
>         static int cached_use_color = -1;
>
> -       if (__builtin_expect(!!(cached_use_color < 0), 0))
> +       if (setting_monitor_color == COLOR_ALWAYS)
> +               cached_use_color = 1;
> +       else if (setting_monitor_color == COLOR_NEVER)
> +               cached_use_color = 0;
> +       else if (__builtin_expect(!!(cached_use_color < 0), 0))
>                 cached_use_color = isatty(STDOUT_FILENO) > 0 || pager_pid > 0;
>
>         return cached_use_color;
> diff --git a/monitor/display.h b/monitor/display.h
> index cba39ec7f..be5739833 100644
> --- a/monitor/display.h
> +++ b/monitor/display.h
> @@ -14,6 +14,9 @@
>
>  bool use_color(void);
>
> +enum monitor_color { COLOR_AUTO, COLOR_ALWAYS, COLOR_NEVER };
> +void set_monitor_color(enum monitor_color);
> +
>  #define COLOR_OFF      "\x1B[0m"
>  #define COLOR_BLACK    "\x1B[0;30m"
>  #define COLOR_RED      "\x1B[0;31m"
> diff --git a/monitor/main.c b/monitor/main.c
> index 969c88103..3ec3a5f08 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -69,6 +69,7 @@ static void usage(void)
>                 "\t-R  --rtt [<address>],[<area>],[<name>]\n"
>                 "\t                       RTT control block parameters\n"
>                 "\t-C, --columns [width]  Output width if not a terminal\n"
> +               "\t-c, --color [mode]     Output color: auto/always/never\n"
>                 "\t-h, --help             Show help options\n");
>  }
>
> @@ -93,6 +94,7 @@ static const struct option main_options[] = {
>         { "jlink",     required_argument, NULL, 'J' },
>         { "rtt",       required_argument, NULL, 'R' },
>         { "columns",   required_argument, NULL, 'C' },
> +       { "color",     required_argument, NULL, 'c' },
>         { "todo",      no_argument,       NULL, '#' },
>         { "version",   no_argument,       NULL, 'v' },
>         { "help",      no_argument,       NULL, 'h' },
> @@ -124,7 +126,7 @@ int main(int argc, char *argv[])
>                 struct sockaddr_un addr;
>
>                 opt = getopt_long(argc, argv,
> -                                       "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:vh",
> +                                       "r:w:a:s:p:i:d:B:V:MNtTSAE:PJ:R:C:c:vh",
>                                         main_options, NULL);
>                 if (opt < 0)
>                         break;
> @@ -211,6 +213,19 @@ int main(int argc, char *argv[])
>                 case 'C':
>                         set_default_pager_num_columns(atoi(optarg));
>                         break;
> +               case 'c':
> +                       if (strcmp("always", optarg) == 0)
> +                               set_monitor_color(COLOR_ALWAYS);
> +                       else if (strcmp("never", optarg) == 0)
> +                               set_monitor_color(COLOR_NEVER);
> +                       else if (strcmp("auto", optarg) == 0)
> +                               set_monitor_color(COLOR_AUTO);
> +                       else {
> +                               fprintf(stderr, "Color option must be one of "
> +                                               "auto/always/never\n");
> +                               return EXIT_FAILURE;
> +                       }
> +                       break;
>                 case '#':
>                         packet_todo();
>                         lmp_todo();
> --
> 2.29.2
>

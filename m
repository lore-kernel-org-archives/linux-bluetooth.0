Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59269C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B2C2074D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZK1s2V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgE2RRE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgE2RRE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 13:17:04 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C9BC03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 10:17:04 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id u190so39106ooa.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoxGlIPe1LsjlwkQynEP6dZut7A8ScGB3oV7Uy1EI1A=;
        b=cZK1s2V/IRqH4KIxoV1eJn93hhfrFxztPiHFTbqc6SA34p2eDFaKbaRD1kNJSLDauK
         rdv5DokTxG9ND3gG4oZZh48+Cp9tZVgdCLP4jL0kmkMiJ/vYiesnGEhSrsVvImQH5urq
         kTOJiscIgS70+eOE6nKjG1PDMKtBhp3h1Jgkc43lIncZU3cZnqpceBJ1/Qre27v+pO8J
         bpZyXrreibRE5tyKp6RmuRRNTWvK52wYkBu1nYjKoBVFoStJH0eJF/l70t3FXi5yG8zb
         hmbfnuFEbNdRI0D91gq+SBcpvlqmErzSvNKVUZJSUe7XHeW06XNqVodGmOaGV+4GmKyi
         jdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoxGlIPe1LsjlwkQynEP6dZut7A8ScGB3oV7Uy1EI1A=;
        b=KN+pvpUnZDbJ0QiNSAu+FLSFIOVQE0e6eMzcEudWDnkMUiKqaPEnA6YWKFeqzMH8p8
         Y+NlLPhd9DyLO7ggjj21pwoP9UujbkfZcMDNEFe6QADS5vohGnWISbwTmZnkRAAir1TS
         eqL/GVFP/ijF6Ei2fbYh2Znq3cUPGOn5LEitSRsrs2q0Umf7qGqpQnG4b/gl9hfrk5wS
         rllnsfDzPaB3Hi3ISosuLn7qXstotcPfVxqCfgeeaqxPlQH9WUpQ+7cr63MzODgnzGfQ
         yJNGdhMDu3kwaQiTteAmpmZdBwlZuL/pblSzTRLf5eaeXqoM5QHAaKqO7Q1hisMQOf/Q
         kv0A==
X-Gm-Message-State: AOAM533CbnmyjbjVSXXUTBqTUp60G5N7N/0pSPGtO2+N81TTtNw2w5hL
        sYpf5DnIqbiQZKAasJx/dRP8G4+Mj+7UeT8m3jM=
X-Google-Smtp-Source: ABdhPJxlex+IEmUZ0l/wfYTyc8JaLxnkrBGOSArc0z2Bqb+hZC6rNu+sGXno7UEvRoAaN/OPqiD5KmU2XDjXtkhFD+U=
X-Received: by 2002:a4a:e795:: with SMTP id x21mr7231858oov.91.1590772618938;
 Fri, 29 May 2020 10:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200529153814.213125-1-alainm@chromium.org> <20200529153814.213125-5-alainm@chromium.org>
In-Reply-To: <20200529153814.213125-5-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 29 May 2020 10:16:46 -0700
Message-ID: <CABBYNZJJ751fxpjpZ0MFvUsQ21H9CptM_gySAgZbcGPwz76W2Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 4/4] fixing const decoration warnins on options.
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Fri, May 29, 2020 at 8:41 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This changes fixes const decoration warnins on options.

What us this fixing?

> ---
>
> Changes in v3: None
> Changes in v2: None
>
>  src/main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index ca27f313d..cea50a3d2 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -80,7 +80,7 @@ static enum {
>         MPS_MULTIPLE,
>  } mps = MPS_OFF;
>
> -static const char *supported_options[] = {
> +static const char * const supported_options[] = {
>         "Name",
>         "Class",
>         "DiscoverableTimeout",
> @@ -129,7 +129,7 @@ static const char * const controller_options[] = {
>         NULL
>  };
>
> -static const char *policy_options[] = {
> +static const char * const policy_options[] = {
>         "ReconnectUUIDs",
>         "ReconnectAttempts",
>         "ReconnectIntervals",
> @@ -137,7 +137,7 @@ static const char *policy_options[] = {
>         NULL
>  };
>
> -static const char *gatt_options[] = {
> +static const char * const gatt_options[] = {
>         "Cache",
>         "KeySize",
>         "ExchangeMTU",
> @@ -146,8 +146,8 @@ static const char *gatt_options[] = {
>  };
>
>  static const struct group_table {
> -       const char *name;
> -       const char **options;
> +       const char * const name;
> +       const char * const * const options;
>  } valid_groups[] = {
>         { "General",    supported_options },
>         { "Controller", controller_options },
> @@ -243,7 +243,7 @@ static enum jw_repairing_t parse_jw_repairing(const char *jw_repairing)
>
>
>  static void check_options(GKeyFile *config, const char *group,
> -                                               const char **options)
> +                                       const char * const * const options)
>  {
>         char **keys;
>         int i;
> --
> 2.27.0.rc0.183.gde8f92d652-goog
>

I wonder how usufull is to tell it is a constant pointer to a constant
character given that is so rarely in the kernel and userspace,
something like const char * const * const would be very hard to keep
it readable.

-- 
Luiz Augusto von Dentz

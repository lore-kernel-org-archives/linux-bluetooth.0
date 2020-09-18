Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F4C43465
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 17:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8917B21707
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 17:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDBlncBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgIRR1v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRR1u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 13:27:50 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E94EC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 10:27:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 60so6113404otw.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uTZEMN1xCM+J5UEYe9o/lYG2rXaLpeL7/RLjKrG2cc=;
        b=oDBlncBYKvJmxGjuPTCd49/4Tim7cgXOF0PFAYa+OOu7FW6Di0yIPKJ+vbSgtlagkt
         eZ3Hp6aGOIODUqrZyWRNGFTkBu/KllOQ0WSAokk7Sa0GNSkbImQtBd/zsMK74UejDKrw
         pBtNOjIjkxqZPH16gNpjBJD8xJqQ03HNDeHbJtBhRBPYkhQ3sLDjX0SvmDmB4xmT56lj
         OoVgFxm4wRD6SuZRZOWW8O7EpjLPSdhow1IYI4oYOcUkl6hbxvXb9xdMVxg7HVMf99G1
         S2SdEhCTz5O6upOQRa9kzJAfalx37+D2JsU32exKinUedgbo8kPVYxpY0fEYA4HR4zI5
         mY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uTZEMN1xCM+J5UEYe9o/lYG2rXaLpeL7/RLjKrG2cc=;
        b=H3gIYpSMHLdNHyTYT3iaRRCZAs9wX7KT3hUjMca4sI8A1U9mLU1peuUDxrX8cJQocd
         uoNHUnGauzaHW96w+4PtPUp8NMZxqjEOaHfo2z0TYyT8c9SZoy1MKqdISaBcvwpZTars
         /iEsSwJvDD4cAJ3TPmwOPtji9+8oBBjlmE4VP6CRnIAn8Q2WVfQii8Axj7w1h4zolk3Q
         +tQQXXe10l6TDjKnb6QwCxfpUdw30clVR+YuI4AoR1aNBgGy4ByIVE7MtrqKqJHAjuOJ
         JbWuFqyXaEse3IrHyYdeRY/+UE80AZszgyBMTu4HXWLmNHHtYsBh+ud04B0il8dARy3y
         mIhQ==
X-Gm-Message-State: AOAM531lpUM5qP0FoIhuYFyVoHWl0n7L8WcysRarr+zs48E9wzwkXJz2
        rIT8qm3rzPx6TqQwu/885HGknd1k7ovRIVTuDSU=
X-Google-Smtp-Source: ABdhPJz55zjCGX0eAX3g0u1Hk3C3a5M8xxW5jaKdNW9XJyV+Yzvt4OsS577paFUqDZLNNJGNaE2F7V37gJWdcqT/Bto=
X-Received: by 2002:a9d:4695:: with SMTP id z21mr23792736ote.91.1600450069296;
 Fri, 18 Sep 2020 10:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200918121348.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
 <20200918121348.BlueZ.v2.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
In-Reply-To: <20200918121348.BlueZ.v2.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Sep 2020 10:27:37 -0700
Message-ID: <CABBYNZLvYtF6eB0K5VrvpTcZpgmsg3epYyZNr39aZrC-JK8PFQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 2/2] core: Add param to disable interleave scan
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Sep 17, 2020 at 9:14 PM Howard Chung <howardchung@google.com> wrote:
>
> This patch adds parameter to enable/disable the interleave scan feature.
> ---
>
> (no changes since v1)
>
>  src/adapter.c | 9 +++++++++
>  src/hcid.h    | 1 +
>  src/main.c    | 6 ++++++
>  src/main.conf | 6 ++++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index c0e95b48a1c4..a2c782e308bb 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4449,6 +4449,15 @@ static void load_default_system_params(struct btd_adapter *adapter)
>                 len += sizeof(params[i].u16);
>         }
>
> +       if (main_opts.default_params.enable_advmon_interleave_scan != 0xFFFF) {
> +               params[i].entry.type = 0x001f;
> +               params[i].entry.length = sizeof(params[i].u16);
> +               params[i].u16 =
> +                       main_opts.default_params.enable_advmon_interleave_scan;
> +               ++i;
> +               len += sizeof(params[i].u16);
> +       }
> +
>         err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
>                         adapter->dev_id, len, params, NULL, NULL, NULL);
>         if (!err)
> diff --git a/src/hcid.h b/src/hcid.h
> index c3e5fe803543..c6717be62c48 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -96,6 +96,7 @@ struct main_opts {
>
>                 uint16_t        advmon_allowlist_scan_duration;
>                 uint16_t        advmon_no_filter_scan_duration;
> +               uint16_t        enable_advmon_interleave_scan;
>         } default_params;
>
>
> diff --git a/src/main.c b/src/main.c
> index e222ed3bf855..3433130bc419 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -125,6 +125,7 @@ static const char *controller_options[] = {
>         "LEAutoconnecttimeout",
>         "AdvMonAllowlistScanDuration",
>         "AdvMonNoFilterScanDuration",
> +       "EnableAdvMonInterleaveScan",
>         NULL
>  };
>
> @@ -444,6 +445,10 @@ static void parse_controller_config(GKeyFile *config)
>                   &main_opts.default_params.advmon_no_filter_scan_duration,
>                   1,
>                   10000},
> +               { "EnableAdvMonInterleaveScan",
> +                 &main_opts.default_params.enable_advmon_interleave_scan,
> +                 0,
> +                 1},
>         };
>         uint16_t i;
>
> @@ -711,6 +716,7 @@ static void init_defaults(void)
>         main_opts.default_params.num_entries = 0;
>         main_opts.default_params.br_page_scan_type = 0xFFFF;
>         main_opts.default_params.br_scan_type = 0xFFFF;
> +       main_opts.default_params.enable_advmon_interleave_scan = 0xFFFF;
>
>         if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
>                 return;
> diff --git a/src/main.conf b/src/main.conf
> index 3b341f44c9cf..c300a3b81086 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -159,6 +159,12 @@
>  # Default: 500
>  #AdvMonNoFilterScanDuration=
>
> +# Enable/Disable Advertisement Monitor interleave scan for power saving.
> +# 0: disable
> +# 1: enable
> +# Defaults to 1
> +#EnableAdvMonInterleaveScan=

This should probably ve defaulting to false until we consider the
interface stable and document how this feature works.

>  [GATT]
>  # GATT attribute cache.
>  # Possible values:
> --
> 2.28.0.681.g6f77f65b4e-goog
>


-- 
Luiz Augusto von Dentz

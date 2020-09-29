Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0FAC4727C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF155207F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 19:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDmxRAUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgI2Tu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbgI2Tu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 15:50:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A721C061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 12:50:26 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 185so6805876oie.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPnGusgGUOeYoHQNnz5k+NkaUwdcYF5mCMU5EXNRxmY=;
        b=dDmxRAUrRDVEEN85CkwKBXV7JnhDph93hk653rlknkAymVmnGYmzt6ocxYvDv9cW83
         UN0g2/7uTwFapwsldNDn5Z7Dt4oMMPHIHEoR7/S6BxEon3Yb2BcTnsSyzl2kHU1qFyTn
         nTEZuQxNeR5moqO9Lwx5uzTXmGGyrGsS1tYePtYpxKL1gRTE28eIeilct3VhVrCoE2WS
         jiEP1hhcMPaUvnCzFcDN/MllBxgaTTs9jWBCUJ5rsmq/Z7F+nSF5a6ELUsNagr8LQBVl
         VnZVNRdYuwjortbPcmmdP5gCgdOFj5/aS8OXhgxvc5mT+C63VhhDrPOCbTh5bK3Plr/P
         7iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPnGusgGUOeYoHQNnz5k+NkaUwdcYF5mCMU5EXNRxmY=;
        b=Hi3CShL/0zqN6+aMHoWOosf0W3JvcQtAKMMywxpRz5idEt1EcRTYCWvr6LID6P+t/H
         jdWigJMv/noKT2mh+cFNPy/TVrT4zsflyQyJtOq9xXNdWhhom7OhsWDp+s4h/YzSJBtp
         fb9n5+IigO+J0M18H/epyfUggDeAik3g52/m5u5C35/ATDRBWPrbEIlElAZBInry5p+N
         +S2DBwl+ADZBsims2OSoutiP3vF4PdRhivzaCNRDArbpiGxdCAAyYJhC7VJinZMtup0B
         cuxYPVyvH7gy5gSCuXilaxiDjXCXt1yCrqXOeOKX49sUr6CDWJC7iyL6wyT0hphD9dEd
         C3/Q==
X-Gm-Message-State: AOAM533IUwrWmTWBYmCJ9NJpmOU0YIQS4KJw/hn/1dYacMF1n8fwI+ld
        9Aj4SQgTdWjqcYI41hNRkZu89qAup0uaHi8SkXaVK1/Y
X-Google-Smtp-Source: ABdhPJxMMiWGP08UQCDAqAbp7UPMHwcKjYptnfUSK/dxzFugz75kuCA0LSkEDkyo/HdUGxewneI43CRpfPZFsKehqtw=
X-Received: by 2002:aca:1b01:: with SMTP id b1mr3727851oib.137.1601409025437;
 Tue, 29 Sep 2020 12:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
 <20200929185522.BlueZ.v5.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
In-Reply-To: <20200929185522.BlueZ.v5.2.Iac5207375d22fb7b96ae4ef73b49ae4ab457219c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Sep 2020 12:50:14 -0700
Message-ID: <CABBYNZ++XfOFCaAErMF6x+1mC+hT868h3b3GtaVNvnGDZcnkvQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 2/3] core: Add param to disable interleave scan
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, Sep 29, 2020 at 3:56 AM Howard Chung <howardchung@google.com> wrote:
>
> This patch adds parameter to enable/disable the interleave scan feature.
> ---
>
> Changes in v5:
> - Fix compile warning
>
> Changes in v4:
> - Set type of EnableAdvMonInterleaveScan to u8
> - Add support of different sizes of parameters
>
> Changes in v3:
> - Set EnableAdvMonInterleaveScan default to Disable
>
>  src/adapter.c | 10 ++++++++++
>  src/hcid.h    |  1 +
>  src/main.c    | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  src/main.conf |  6 ++++++
>  4 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index f072541aad35..553db4aa8b1f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4169,6 +4169,7 @@ static void load_default_system_params(struct btd_adapter *adapter)
>                 struct mgmt_tlv entry;
>                 union {
>                         uint16_t u16;
> +                       uint8_t  u8;
>                 };
>         } __packed *params;
>         uint16_t i = 0;
> @@ -4436,6 +4437,15 @@ static void load_default_system_params(struct btd_adapter *adapter)
>                 len += sizeof(params[i].u16);
>         }
>
> +       if (main_opts.default_params.enable_advmon_interleave_scan != 0xFF) {
> +               params[i].entry.type = 0x001f;
> +               params[i].entry.length = sizeof(params[i].u8);
> +               params[i].u8 =
> +                       main_opts.default_params.enable_advmon_interleave_scan;
> +               ++i;
> +               len += sizeof(params[i].u8);
> +       }
> +

We could perhaps have a zero length here so that just the presence of
the type indicates it should be enabled, how about that?

>         err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
>                         adapter->dev_id, len, params, NULL, NULL, NULL);
>         if (!err)
> diff --git a/src/hcid.h b/src/hcid.h
> index 713eab8e03ae..34d22b3470f9 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -83,6 +83,7 @@ struct main_opts {
>
>                 uint16_t        advmon_allowlist_scan_duration;
>                 uint16_t        advmon_no_filter_scan_duration;
> +               uint8_t         enable_advmon_interleave_scan;
>         } default_params;
>
>
> diff --git a/src/main.c b/src/main.c
> index 38f193a093df..274af6bdcc0f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -112,6 +112,7 @@ static const char *controller_options[] = {
>         "LEAutoconnecttimeout",
>         "AdvMonAllowlistScanDuration",
>         "AdvMonNoFilterScanDuration",
> +       "EnableAdvMonInterleaveScan",
>         NULL
>  };
>
> @@ -307,130 +308,169 @@ static void parse_controller_config(GKeyFile *config)
>  {
>         static const struct {
>                 const char * const val_name;
> -               uint16_t * const val;
> +               void * const val;
> +               const size_t size;
>                 const uint16_t min;
>                 const uint16_t max;
>         } params[] = {
>                 { "BRPageScanType",
>                   &main_opts.default_params.br_page_scan_type,
> +                 sizeof(main_opts.default_params.br_page_scan_type),
>                   0,
>                   1},
>                 { "BRPageScanInterval",
>                   &main_opts.default_params.br_page_scan_interval,
> +                 sizeof(main_opts.default_params.br_page_scan_interval),
>                   0x0012,
>                   0x1000},
>                 { "BRPageScanWindow",
>                   &main_opts.default_params.br_page_scan_win,
> +                 sizeof(main_opts.default_params.br_page_scan_win),
>                   0x0011,
>                   0x1000},
>                 { "BRInquiryScanType",
>                   &main_opts.default_params.br_scan_type,
> +                 sizeof(main_opts.default_params.br_scan_type),
>                   0,
>                   1},
>                 { "BRInquiryScanInterval",
>                   &main_opts.default_params.br_scan_interval,
> +                 sizeof(main_opts.default_params.br_scan_interval),
>                   0x0012,
>                   0x1000},
>                 { "BRInquiryScanWindow",
>                   &main_opts.default_params.br_scan_win,
> +                 sizeof(main_opts.default_params.br_scan_win),
>                   0x0011,
>                   0x1000},
>                 { "BRLinkSupervisionTimeout",
>                   &main_opts.default_params.br_link_supervision_timeout,
> +                 sizeof(main_opts.default_params.br_link_supervision_timeout),
>                   0x0001,
>                   0xFFFF},
>                 { "BRPageTimeout",
>                   &main_opts.default_params.br_page_timeout,
> +                 sizeof(main_opts.default_params.br_page_scan_win),
>                   0x0001,
>                   0xFFFF},
>                 { "BRMinSniffInterval",
>                   &main_opts.default_params.br_min_sniff_interval,
> +                 sizeof(main_opts.default_params.br_min_sniff_interval),
>                   0x0001,
>                   0xFFFE},
>                 { "BRMaxSniffInterval",
>                   &main_opts.default_params.br_max_sniff_interval,
> +                 sizeof(main_opts.default_params.br_max_sniff_interval),
>                   0x0001,
>                   0xFFFE},
>                 { "LEMinAdvertisementInterval",
>                   &main_opts.default_params.le_min_adv_interval,
> +                 sizeof(main_opts.default_params.le_min_adv_interval),
>                   0x0020,
>                   0x4000},
>                 { "LEMaxAdvertisementInterval",
>                   &main_opts.default_params.le_max_adv_interval,
> +                 sizeof(main_opts.default_params.le_max_adv_interval),
>                   0x0020,
>                   0x4000},
>                 { "LEMultiAdvertisementRotationInterval",
>                   &main_opts.default_params.le_multi_adv_rotation_interval,
> +                 sizeof(main_opts.default_params.
> +                                               le_multi_adv_rotation_interval),
>                   0x0001,
>                   0xFFFF},
>                 { "LEScanIntervalAutoConnect",
>                   &main_opts.default_params.le_scan_interval_autoconnect,
> +                 sizeof(main_opts.default_params.le_scan_interval_autoconnect),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowAutoConnect",
>                   &main_opts.default_params.le_scan_win_autoconnect,
> +                 sizeof(main_opts.default_params.le_scan_win_autoconnect),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalSuspend",
>                   &main_opts.default_params.le_scan_interval_suspend,
> +                 sizeof(main_opts.default_params.le_scan_interval_suspend),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowSuspend",
>                   &main_opts.default_params.le_scan_win_suspend,
> +                 sizeof(main_opts.default_params.le_scan_win_suspend),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalDiscovery",
>                   &main_opts.default_params.le_scan_interval_discovery,
> +                 sizeof(main_opts.default_params.le_scan_interval_discovery),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowDiscovery",
>                   &main_opts.default_params.le_scan_win_discovery,
> +                 sizeof(main_opts.default_params.le_scan_win_discovery),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalAdvMonitor",
>                   &main_opts.default_params.le_scan_interval_adv_monitor,
> +                 sizeof(main_opts.default_params.le_scan_interval_adv_monitor),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowAdvMonitor",
>                   &main_opts.default_params.le_scan_win_adv_monitor,
> +                 sizeof(main_opts.default_params.le_scan_win_adv_monitor),
>                   0x0004,
>                   0x4000},
>                 { "LEScanIntervalConnect",
>                   &main_opts.default_params.le_scan_interval_connect,
> +                 sizeof(main_opts.default_params.le_scan_interval_connect),
>                   0x0004,
>                   0x4000},
>                 { "LEScanWindowConnect",
>                   &main_opts.default_params.le_scan_win_connect,
> +                 sizeof(main_opts.default_params.le_scan_win_connect),
>                   0x0004,
>                   0x4000},
>                 { "LEMinConnectionInterval",
>                   &main_opts.default_params.le_min_conn_interval,
> +                 sizeof(main_opts.default_params.le_min_conn_interval),
>                   0x0006,
>                   0x0C80},
>                 { "LEMaxConnectionInterval",
>                   &main_opts.default_params.le_max_conn_interval,
> +                 sizeof(main_opts.default_params.le_max_conn_interval),
>                   0x0006,
>                   0x0C80},
>                 { "LEConnectionLatency",
>                   &main_opts.default_params.le_conn_latency,
> +                 sizeof(main_opts.default_params.le_conn_latency),
>                   0x0000,
>                   0x01F3},
>                 { "LEConnectionSupervisionTimeout",
>                   &main_opts.default_params.le_conn_lsto,
> +                 sizeof(main_opts.default_params.le_conn_lsto),
>                   0x000A,
>                   0x0C80},
>                 { "LEAutoconnecttimeout",
>                   &main_opts.default_params.le_autoconnect_timeout,
> +                 sizeof(main_opts.default_params.le_autoconnect_timeout),
>                   0x0001,
>                   0x4000},
>                 { "AdvMonAllowlistScanDuration",
>                   &main_opts.default_params.advmon_allowlist_scan_duration,
> +                 sizeof(main_opts.default_params.
> +                                               advmon_allowlist_scan_duration),
>                   1,
>                   10000},
>                 { "AdvMonNoFilterScanDuration",
>                   &main_opts.default_params.advmon_no_filter_scan_duration,
> +                 sizeof(main_opts.default_params.br_page_scan_win),
>                   1,
>                   10000},
> +               { "EnableAdvMonInterleaveScan",
> +                 &main_opts.default_params.enable_advmon_interleave_scan,
> +                 sizeof(main_opts.default_params.
> +                                               enable_advmon_interleave_scan),
> +                 0,
> +                 1},
>         };
>         uint16_t i;
>
> @@ -449,7 +489,7 @@ static void parse_controller_config(GKeyFile *config)
>
>                         val = MAX(val, params[i].min);
>                         val = MIN(val, params[i].max);
> -                       *params[i].val = val;
> +                       memcpy(params[i].val, &val, params[i].size);
>                         ++main_opts.default_params.num_entries;
>                 }
>         }
> @@ -698,6 +738,7 @@ static void init_defaults(void)
>         main_opts.default_params.num_entries = 0;
>         main_opts.default_params.br_page_scan_type = 0xFFFF;
>         main_opts.default_params.br_scan_type = 0xFFFF;
> +       main_opts.default_params.enable_advmon_interleave_scan = 0xFF;
>
>         if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
>                 return;
> diff --git a/src/main.conf b/src/main.conf
> index 3b341f44c9cf..82ffc5813204 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -159,6 +159,12 @@
>  # Default: 500
>  #AdvMonNoFilterScanDuration=
>
> +# Enable/Disable Advertisement Monitor interleave scan for power saving.
> +# 0: disable
> +# 1: enable
> +# Defaults to 0
> +#EnableAdvMonInterleaveScan=
> +
>  [GATT]
>  # GATT attribute cache.
>  # Possible values:
> --
> 2.28.0.709.gb0816b6eb0-goog
>


-- 
Luiz Augusto von Dentz

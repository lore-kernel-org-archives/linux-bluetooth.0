Return-Path: <SRS0=Q1DV=EF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD7C00A89
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 17:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2C820A8B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Oct 2020 17:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpxto9EL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3R63 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Oct 2020 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3R63 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Oct 2020 13:58:29 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D6C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 10:58:29 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w145so1840423oie.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2020 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAcW8A4EiFC40/QVLzCiB+RO0JWsuCng4T77lJWLbZA=;
        b=Fpxto9ELuIucF+i06i/85HT5OT5ziCwzDAyjYiDVrqLeZ4heOp3RDHv18k4UQtJjxu
         hiLg/Jdm+KaNM6k8xiMRUTzPpr0y1Tx3wxZP2Nkygx3CRCKwTT1K063rJEU4QjB1HqAp
         Qr7QNU5qlSWm0Gs8fSgwAc/+yCfIohACL9lB8ajyK7KLX52k623Zk1BWZL00rpUs6qyS
         aUgD8pO+1pA4nEZpN9YaWX92mHPeu/jXlK9khKSqw/Iq9fslB+82AzukbE3f+X6tTBEg
         hQyxIDH+b8XHdPODaqiy5vInOaH8UOAcProwlw56Xn9+Y7qlRO+k5Zn1idUTjCQcqdw2
         H8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAcW8A4EiFC40/QVLzCiB+RO0JWsuCng4T77lJWLbZA=;
        b=OUesfP7x2n4pWlTnREUsQ6i7hTyVBZVZsnIPBC9PdM7LFgxtKNhS/fRtK6j7qCX8B6
         WYIeBGT46aYoDpL3Q43TA3Ec90CeiS+6XNjVgpDzgsraW9pmapVBmB9BAPYA7eKVtIJz
         WD1kXQDP6fGX8BQQm9RtszgkCS+Z3VE+dnd9Efh01CFXTDFmmfEFJNx7xH32cosVgc0J
         Jt7iVZaQAM/7NTdteEfH066dthOJbm+2tdOqOTaq3ZZp9ARjf67cYtQd+RVGbCl/7F6T
         HdGpUVGhnmw9spFzgLevGyYn309sPRapV+WquVzUKIevX74skI1h22pFQ8P86h6pDLfp
         k14g==
X-Gm-Message-State: AOAM5303qz0DXr9NqNpKV9wdWBZ1gA2CWbQQ27iUb08h03vxPlkikp84
        uGfzXRiQnsNpp7d7z9sI7C9lqUE0XdPQB/k1nJE=
X-Google-Smtp-Source: ABdhPJw7N8sEyaL2rBbqlAUO/tgH8u7iTj/CoDxTSuMfsU3c5BAreY/LQU1lDK00/3VOF7e0RVU/maYl5BsPBv/YYa0=
X-Received: by 2002:aca:c70b:: with SMTP id x11mr1918760oif.58.1604080709013;
 Fri, 30 Oct 2020 10:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201030170932.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
In-Reply-To: <20201030170932.BlueZ.v2.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Oct 2020 10:58:18 -0700
Message-ID: <CABBYNZJY__xSetrhU36TZresueqb2X-A3ZQCyydtd48MVmTybw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 1/3] core: Add parmas to set interleaving durations
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

On Fri, Oct 30, 2020 at 2:11 AM Howard Chung <howardchung@google.com> wrote:
>
> This patch adds parameters to control the durations of allowlist scan
> and no-filter scan when the kernel is doing interleaving scan.
> ---
>
> Changes in v2:
> - re-implement on new mgmt_tlv API
>
>  src/adapter.c | 12 ++++++++++++
>  src/btd.h     |  3 +++
>  src/main.c    | 12 ++++++++++++
>  src/main.conf |  7 +++++++
>  4 files changed, 34 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index cac90b01bdc0..bdfe41d7e88c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4342,6 +4342,18 @@ static void load_default_system_params(struct btd_adapter *adapter)
>                         goto done;
>         }
>
> +       if (btd_opts.defaults.le.advmon_allowlist_scan_duration) {
> +               if (!mgmt_tlv_add_fixed(tlv_list, 0x001d,
> +                               &btd_opts.defaults.le.advmon_allowlist_scan_duration))
> +                       goto done;
> +       }
> +
> +       if (btd_opts.defaults.le.advmon_no_filter_scan_duration) {
> +               if (!mgmt_tlv_add_fixed(tlv_list, 0x001e,
> +                               &btd_opts.defaults.le.advmon_no_filter_scan_duration))
> +                       goto done;
> +       }
> +
>         err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
>                         adapter->dev_id, tlv_list, NULL, NULL, NULL);
>
> diff --git a/src/btd.h b/src/btd.h
> index 4cd117538fda..b0df77fe3ab3 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -71,6 +71,9 @@ struct btd_le_defaults {
>         uint16_t        conn_latency;
>         uint16_t        conn_lsto;
>         uint16_t        autoconnect_timeout;
> +
> +       uint16_t        advmon_allowlist_scan_duration;
> +       uint16_t        advmon_no_filter_scan_duration;
>  };
>
>  struct btd_defaults {
> diff --git a/src/main.c b/src/main.c
> index 0ae45015fbe8..47887a4059a1 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -114,6 +114,8 @@ static const char *le_options[] = {
>         "ConnectionLatency",
>         "ConnectionSupervisionTimeout",
>         "Autoconnecttimeout",
> +       "AdvMonAllowlistScanDuration",
> +       "AdvMonNoFilterScanDuration",
>         NULL
>  };
>
> @@ -497,6 +499,16 @@ static void parse_le_config(GKeyFile *config)
>                   sizeof(btd_opts.defaults.le.autoconnect_timeout),
>                   0x0001,
>                   0x4000},
> +               { "AdvMonAllowlistScanDuration",
> +                 &btd_opts.defaults.le.advmon_allowlist_scan_duration,
> +                 sizeof(btd_opts.defaults.le.advmon_allowlist_scan_duration),
> +                 1,
> +                 10000},
> +               { "AdvMonNoFilterScanDuration",
> +                 &btd_opts.defaults.le.advmon_no_filter_scan_duration,
> +                 sizeof(btd_opts.defaults.le.advmon_no_filter_scan_duration),
> +                 1,
> +                 10000},
>         };
>
>         if (btd_opts.mode == BT_MODE_BREDR)
> diff --git a/src/main.conf b/src/main.conf
> index 1b349821294b..a3f2020b04dc 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -160,6 +160,13 @@
>  #ConnectionSupervisionTimeout=
>  #Autoconnecttimeout=
>
> +# Scan duration during interleaving scan. Only used when scanning for ADV
> +# monitors. The units are msec.
> +# Default: 300
> +#AdvMonAllowlistScanDuration=
> +# Default: 500
> +#AdvMonNoFilterScanDuration=
> +
>  [GATT]
>  # GATT attribute cache.
>  # Possible values:
> --
> 2.29.1.341.ge80a0c044ae-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz

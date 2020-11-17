Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFA2C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 14:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007F722240
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 14:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDWGhmX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgKQOnt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgKQOnt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 09:43:49 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F5C0617A6
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 06:43:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j205so30450201lfj.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2020 06:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGtenS6uoZKTHKtbUJGOuQ+M6l6eKaq/n7J10Kma8no=;
        b=dDWGhmX+SxFa5r3m73hwHq7FYrs9NiKGhRoaXk94zrQrnzhWcnUGvttemwxj+ecZRe
         s0k517G7Vnb4g375WzxgtmA/LezhgfNcaGPX/OFKzad2dL1LtNL9cD4isKL75SbYsiZS
         lRy/85LDiVzWf8PUwbgbCvLm8OBQqRJiapLrRaiZfbyfNje5c/HMaaxnlBckKYgfSyN/
         bzcX9GyPre6uD9YmUa1yGDDmEoyqd7NQz83GaZvInBv5u4Hm3cdd2FW5bSOIJUN6CJkn
         rvYBdvCI+tLdw33QIxeHyxpTvmMzMUmvI1JY6NoRIw4YeQFBr/zLym790rwbuetmrd2l
         W3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGtenS6uoZKTHKtbUJGOuQ+M6l6eKaq/n7J10Kma8no=;
        b=kMdlnpUWvPlGlQJ0WbUeO12NvZXAsadx61OQg9ZwYBDM6k415G2K4EKFrjqXFaisME
         EUlEhpX9iD2trzYHMYQkxoMPFc/LYjoKWmS0otgzA8wykHpKCny0E33D7eUGYj6IGP8i
         2ttJxo5xF4Vk1p2nv7NqNbg0o3hWwIzvjILdSYKT2w3ohewoNquNQbM1FPmEj+77EWf6
         Xm10zH4aqNi2yb4o8sZKzVvPcXe7uxMvTLLyDRpWgptf6u1KaMF5kTx6BswuyUc5ykSi
         /xLVLf6cPIRYRWQcF/U7063wiVZNHW7xyFXBixckJSo4Clyr6W9AI4MUqg905JSGG3ez
         V7mA==
X-Gm-Message-State: AOAM530rBvfE3r1AbfLwm1vYHiMa11DJjP0Oa1IqmEoFxbB4/ELjfhj2
        5Fnh5Ad1AGXH8RLCQL2WFHch5DaBenItdEMNhbCOKw==
X-Google-Smtp-Source: ABdhPJxlcT4r+ZWw/qnajPG1JGY92flOdLqstn3fqDf18b2jzJqAxSGUKhUny+vWGjedIiN88Ba35FfuRyeum9O1uY4=
X-Received: by 2002:a19:8883:: with SMTP id k125mr1757972lfd.10.1605624227154;
 Tue, 17 Nov 2020 06:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20201116233910.4128702-1-luiz.dentz@gmail.com> <20201116233910.4128702-2-luiz.dentz@gmail.com>
In-Reply-To: <20201116233910.4128702-2-luiz.dentz@gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 17 Nov 2020 09:43:35 -0500
Message-ID: <CALWDO_UreE5HBUDkefrfmNcsu0h==sQr+41GL-2OVtf9zQoWtA@mail.gmail.com>
Subject: Re: [RFC BlueZ 2/2] main.conf: Add option to configure AVDP
 session/stream channel modes
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Nov 16, 2020 at 7:26 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a new group AVDTP where platform can confure the prefered
> modes L2CAP channel for both session (signalling) and stream
> (transport). For better backward compatibility the default modes of
> boths

Reviewed-by: Alain Michaud <alainm@chromium.org>
Tested-by: Alain Michaud <alainm@chromium.org>

> ---
>  profiles/audio/a2dp.c  |  5 +----
>  profiles/audio/avdtp.c | 14 ++-----------
>  src/btd.h              |  7 +++++++
>  src/main.c             | 45 ++++++++++++++++++++++++++++++++++++++++++
>  src/main.conf          | 13 ++++++++++++
>  5 files changed, 68 insertions(+), 16 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 626f61d34..59d11a0aa 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2324,10 +2324,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
>         if (server->io)
>                 return true;
>
> -       if (btd_opts.mps == MPS_OFF)
> -               mode = BT_IO_MODE_BASIC;
> -       else
> -               mode = BT_IO_MODE_STREAMING;
> +       mode = btd_opts.avdtp.session_mode;
>
>         server->io = bt_io_listen(NULL, confirm_cb, server, NULL, &err,
>                                 BT_IO_OPT_SOURCE_BDADDR,
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 619b94e29..ff0a124c3 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -2603,12 +2603,7 @@ static int send_req(struct avdtp *session, gboolean priority,
>         int err, timeout;
>
>         if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
> -               BtIOMode mode;
> -
> -               if (btd_opts.mps == MPS_OFF)
> -                       mode = BT_IO_MODE_BASIC;
> -               else
> -                       mode = BT_IO_MODE_ERTM;
> +               BtIOMode mode = btd_opts.avdtp.session_mode;
>
>                 session->io = l2cap_connect(session, mode);
>                 if (!session->io) {
> @@ -2807,12 +2802,7 @@ static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stre
>                                 struct seid_rej *resp, int size)
>  {
>         struct avdtp_local_sep *sep = stream->lsep;
> -       BtIOMode mode;
> -
> -       if (btd_opts.mps == MPS_OFF)
> -               mode = BT_IO_MODE_BASIC;
> -       else
> -               mode = BT_IO_MODE_STREAMING;
> +       BtIOMode mode = btd_opts.avdtp.stream_mode;
>
>         stream->io = l2cap_connect(session, mode);
>         if (!stream->io) {
> diff --git a/src/btd.h b/src/btd.h
> index c98414e35..a3247e4fd 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -84,6 +84,11 @@ struct btd_defaults {
>         struct btd_le_defaults le;
>  };
>
> +struct btd_avdtp_opts {
> +       uint8_t  session_mode;
> +       uint8_t  stream_mode;
> +};
> +
>  struct btd_opts {
>         char            *name;
>         uint32_t        class;
> @@ -112,6 +117,8 @@ struct btd_opts {
>         uint8_t         gatt_channels;
>         enum mps_mode_t mps;
>
> +       struct btd_avdtp_opts avdtp;
> +
>         uint8_t         key_size;
>
>         enum jw_repairing_t jw_repairing;
> diff --git a/src/main.c b/src/main.c
> index e6c4d861e..33c0f0d15 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -34,6 +34,7 @@
>  #include "lib/sdp.h"
>
>  #include "gdbus/gdbus.h"
> +#include "btio/btio.h"
>
>  #include "log.h"
>  #include "backtrace.h"
> @@ -137,6 +138,12 @@ static const char *gatt_options[] = {
>         NULL
>  };
>
> +static const char *avdtp_options[] = {
> +       "SessionMode",
> +       "StreamMode",
> +       NULL
> +};
> +
>  static const struct group_table {
>         const char *name;
>         const char **options;
> @@ -146,6 +153,7 @@ static const struct group_table {
>         { "LE",         le_options },
>         { "Policy",     policy_options },
>         { "GATT",       gatt_options },
> +       { "AVDTP",      avdtp_options },
>         { }
>  };
>
> @@ -744,6 +752,40 @@ static void parse_config(GKeyFile *config)
>                 btd_opts.gatt_channels = val;
>         }
>
> +       str = g_key_file_get_string(config, "AVDTP", "SessionMode", &err);
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +       } else {
> +               DBG("SessionMode=%s", str);
> +
> +               if (!strcmp(str, "basic"))
> +                       btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
> +               else if (!strcmp(str, "ertm"))
> +                       btd_opts.avdtp.session_mode = BT_IO_MODE_ERTM;
> +               else {
> +                       DBG("Invalid mode option: %s", str);
> +                       btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
> +               }
> +       }
> +
> +       val = g_key_file_get_integer(config, "AVDTP", "StreamMode", &err);
> +       if (err) {
> +               DBG("%s", err->message);
> +               g_clear_error(&err);
> +       } else {
> +               DBG("StreamMode=%s", str);
> +
> +               if (!strcmp(str, "basic"))
> +                       btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
> +               else if (!strcmp(str, "streaming"))
> +                       btd_opts.avdtp.stream_mode = BT_IO_MODE_STREAMING;
> +               else {
> +                       DBG("Invalid mode option: %s", str);
> +                       btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
> +               }
> +       }
> +
>         parse_br_config(config);
>         parse_le_config(config);
>  }
> @@ -780,6 +822,9 @@ static void init_defaults(void)
>         btd_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
>         btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
>         btd_opts.gatt_channels = 3;
> +
> +       btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
> +       btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
>  }
>
>  static void log_handler(const gchar *log_domain, GLogLevelFlags log_level,
> diff --git a/src/main.conf b/src/main.conf
> index 54f6a36bd..d3bc61441 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -200,6 +200,19 @@
>  # Default to 3
>  #Channels = 3
>
> +[AVDTP]
> +# AVDTP L2CAP Signalling Channel Mode.
> +# Possible values:
> +# basic: Use L2CAP Basic Mode
> +# ertm: Use L2CAP Enhanced Retransmission Mode
> +#SessionMode = basic
> +
> +# AVDTP L2CAP Transport Channel Mode.
> +# Possible values:
> +# basic: Use L2CAP Basic Mode
> +# streaming: Use L2CAP Streaming Mode
> +#StreamMode = basic
> +
>  [Policy]
>  #
>  # The ReconnectUUIDs defines the set of remote services that should try
> --
> 2.26.2
>

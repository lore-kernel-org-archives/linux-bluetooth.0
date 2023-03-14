Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ED8C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 23:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCNXRM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 19:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCNXRK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 19:17:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C7E50F85
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 16:17:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i20so17641076lja.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678835827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3S7IfrDNccnAtwdiDbVDpRr7gkj7HphOwFijbk7fXc=;
        b=cWgQ9qYgIosJSy5VQTOmbjLt4de1Z4JF42SnkrzFUiZOX4+GeVCuoPMiKVj4NmLiqf
         3iunsXR2N6aMG44um6e5D2yJ8Tf9ShMMB1MUaVqKH+3m+ZJ1SNquOr0s3w6Kw4QSUYS0
         qdrSr4NbDqurn+IrINeTq7CLj2sxnYLw+mlziW0qC3B5IUVqYe0NE9fDSE7TXBbG5pGa
         CW4BjFeeRHSz8EVjirIzQXk5UeGkHS+VgKFgwyF9Juy0bdLb//VaJogtElmvdtYXGtdC
         qubzxdoCPNx0bG0PsPI1bwqVdyIT2DRQoWpEz4BKDm0JA3C8yA7mRNG3HQaFb6WBs/5D
         +xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678835827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3S7IfrDNccnAtwdiDbVDpRr7gkj7HphOwFijbk7fXc=;
        b=v1xtJIhssVF3QxQWm4XvI9W/iZOA1uHTvyGX0iN74cyJ5FpfiqVC0BJMUwegi9Fx8r
         vRL79jjjuMq1ImKpDKW7UslYJdnKpJzghecpuQWEuKMh5vAO2xGw+XpeZ1OhZlWSpEfr
         WBd9d1IezE+5/T+t/iQM2dI3aLaXkmeFkqiD8DwEAOCn8kTUtQH6kscIJR9wldiStVzx
         0by4CxtNpXRJk4uZmpUtlf6exy4DiDA5GV+a6ZOjrmjKnT7kVOr3nxlUWps3YouhCzk6
         bPEM1NtvPHDVxgHxx17cVClR7k7qG4blYrPCmOIuoDpS6/QJVwwSAlMInKG0PDft5yC/
         nTaA==
X-Gm-Message-State: AO0yUKUFa5RrCtZQyT3TSYMQMT7wFKPOW2N08fCK/c9dGT9oiZQt9gL+
        892E2TaY/jTWHKTfumdzPfc8WLp0hUMyen8KB04=
X-Google-Smtp-Source: AK7set9YU0NbngIAJzhW7gPdcdAfxrKJtffZYzk003tiSA3CTMnw1sfLzkrkmeldQvGxSTybsI0JGs0U9sE+21AG1oc=
X-Received: by 2002:a2e:b4a4:0:b0:295:897c:6f7a with SMTP id
 q4-20020a2eb4a4000000b00295897c6f7amr265202ljm.0.1678835826718; Tue, 14 Mar
 2023 16:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230311003826.454858-1-marijn.suijten@somainline.org> <20230311003826.454858-2-marijn.suijten@somainline.org>
In-Reply-To: <20230311003826.454858-2-marijn.suijten@somainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Mar 2023 16:16:55 -0700
Message-ID: <CABBYNZJimKVz46=6b=B4M9O=FW7hXJZBaRSM50U47oWtxcj0rQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/3] audio/avrcp: Guard SetAbsoluteVolume without
 target behind config value
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Fri, Mar 10, 2023 at 4:39=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Commit 179ccb936 ("avrcp: Set volume if volume changed event is
> registered") introduced a catch that allows SetAbsoluteVolume to be sent
> to a remote device that does _not_ implement the AVRCP TG profile.  This
> is strange as the TG role is required to be able to send commands to the
> peer, but the commit must have been applied to the tree for a reason.
>
> We discussed in [1] that workarounds for dubious peers and software
> stacks should be guarded behind a config entry in main.conf, so this
> starts out by introducing a new [AVRCP] category to to it that will
> later be extended with other workarounds.
>
> [1]: https://marc.info/?l=3Dlinux-bluetooth&m=3D163519566912788&w=3D2
> ---
>  profiles/audio/avrcp.c | 12 +++++++++---
>  src/btd.h              |  5 +++++
>  src/main.c             | 13 +++++++++++++
>  src/main.conf          |  6 ++++++
>  4 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 80f34c7a7..5e6322916 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -48,6 +48,7 @@
>  #include "src/dbus-common.h"
>  #include "src/shared/timeout.h"
>  #include "src/shared/util.h"
> +#include "src/btd.h"
>
>  #include "avctp.h"
>  #include "avrcp.h"
> @@ -4577,9 +4578,14 @@ int avrcp_set_volume(struct btd_device *dev, int8_=
t volume, bool notify)
>                                                                 &volume);
>         }
>
> -       if (!session->controller && !avrcp_event_registered(session,
> -                                       AVRCP_EVENT_VOLUME_CHANGED))
> -               return -ENOTSUP;
> +       if (btd_opts.avrcp.set_absolute_volume_without_target) {
> +               if (!session->controller && !avrcp_event_registered(sessi=
on,
> +                                               AVRCP_EVENT_VOLUME_CHANGE=
D))
> +                       return -ENOTSUP;
> +       } else {
> +               if (!session->controller || session->controller->version =
< 0x0104)
> +                       return -ENOTSUP;
> +       }
>
>         memset(buf, 0, sizeof(buf));
>
> diff --git a/src/btd.h b/src/btd.h
> index 42cffcde4..31c04a990 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -97,6 +97,10 @@ struct btd_avdtp_opts {
>         uint8_t  stream_mode;
>  };
>
> +struct btd_avrcp_opts {
> +       gboolean set_absolute_volume_without_target;
> +};
> +
>  struct btd_advmon_opts {
>         uint8_t         rssi_sampling_period;
>  };
> @@ -136,6 +140,7 @@ struct btd_opts {
>         enum mps_mode_t mps;
>
>         struct btd_avdtp_opts avdtp;
> +       struct btd_avrcp_opts avrcp;
>
>         uint8_t         key_size;
>
> diff --git a/src/main.c b/src/main.c
> index 99d9c508f..92f74e381 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -152,6 +152,11 @@ static const char *avdtp_options[] =3D {
>         NULL
>  };
>
> +static const char *avrcp_options[] =3D {
> +       "SetAbsoluteVolumeWithoutTarget",
> +       NULL
> +};
> +
>  static const char *advmon_options[] =3D {
>         "RSSISamplingPeriod",
>         NULL
> @@ -167,6 +172,7 @@ static const struct group_table {
>         { "Policy",     policy_options },
>         { "GATT",       gatt_options },
>         { "AVDTP",      avdtp_options },
> +       { "AVRCP",      avrcp_options },
>         { "AdvMon",     advmon_options },
>         { }
>  };
> @@ -975,6 +981,13 @@ static void parse_config(GKeyFile *config)
>                 g_free(str);
>         }
>
> +       boolean =3D g_key_file_get_boolean(config, "AVRCP",
> +                                               "SetAbsoluteVolumeWithout=
Target", &err);
> +       if (err)
> +               g_clear_error(&err);
> +       else
> +               btd_opts.avrcp.set_absolute_volume_without_target =3D boo=
lean;
> +
>         val =3D g_key_file_get_integer(config, "AdvMon", "RSSISamplingPer=
iod",
>                                                                         &=
err);
>         if (err) {
> diff --git a/src/main.conf b/src/main.conf
> index f187c9aaa..ca00ed03e 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -271,6 +271,12 @@
>  # streaming: Use L2CAP Streaming Mode
>  #StreamMode =3D basic
>
> +[AVRCP]
> +# Allow SetAbsoluteVolume calls to a peer device that
> +# does not advertise the AVRCP remote control target
> +# profile.
> +#SetAbsoluteVolumeWithoutTarget =3D false

Let's do just VolumeWithoutTarget and we should probably mention that
it would ignore the version as well.

> +
>  [Policy]
>  #
>  # The ReconnectUUIDs defines the set of remote services that should try
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz

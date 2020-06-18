Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9912AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 04:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DDF217A0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 04:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+moL1DL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgFREnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 00:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgFREnD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 00:43:03 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C7C06174E
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 21:43:03 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k15so3519621otp.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 21:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNGRm/uT8MggjM6+qpD2PxualvaE2mM+LeQP0hJ3bi0=;
        b=d+moL1DLj+fYtShyVzQe+D2yeEGh5CfUt4mhNn6uQIgcEGrujOZDwurth5csod2NTR
         NqAfI7PaMEB798uHCS1KZhlhwwnn2mTV0dAY0pFns05TESCthnA87OXZjFZiwnJhgVqC
         putoxCOD1lwawAQiyRANNyMhI+pjvAGekAMK74WjknizozKKvV+S1oOExGfBzZ7ptMTl
         LMQJ/1Bk6Vry1iKJGvBez6IQ9lugelPSxAwePX/W0Q40dPDuIkOo9fZDHzpiZxkCK1OE
         z9FWTNhB3b5r/zxDqyByC5QCSUB8pY3YBjTwAcjDKIpuPVBqDuEMlmgzgiH+MaW2Qzh2
         TViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNGRm/uT8MggjM6+qpD2PxualvaE2mM+LeQP0hJ3bi0=;
        b=GYhDcBrmQgfdw9hSGOvLJ2rwEFxCFRUM49FkJXvs9X35IkKeHWCrBiPJzfhg5umn7r
         1Ylbsx1y5Zk4Lupv3urf+7UschJVPkKbpeHNqz4Y4IzgLD1IeYVCRQihFQ6QLhJvz3BK
         kVDcrt0dvfh6cByvr3oIe6V1damnZLrFmVEOEGZnK05KmK+FkeeJyCIiFhwhL/YENgF8
         NmlpjvN2oJ2Uxi/d0hColFHm3keFnTs2kxJ3C2I+ghEJ6FeaxL2mLNBfmFzKmmVGlIo6
         4VVldBvPAsy59IwRR9IGIhwRUnbCzLJMaBGsatohLZZqyXDbcEF3aWCYNVen8Y5tnfFn
         6jsQ==
X-Gm-Message-State: AOAM533gt0ZRlUw5/qYrps4G93bqwEKrM/fup0t3dhPWyyRcxqI84cUh
        xwgk70kP5NFggx1hYbsZPdouiu9a2WDNojoHGwOWmg==
X-Google-Smtp-Source: ABdhPJwvo6J4+QoVQLN1ukIZuq4cJXfBon9gR3MjWNisR73L1mKx8Si6x2P2WTA3sbrrPJj/jrq8f9XeJKv0p4Nc/dg=
X-Received: by 2002:a05:6830:8d:: with SMTP id a13mr1943250oto.91.1592455383001;
 Wed, 17 Jun 2020 21:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200615145252.259971-1-alainm@chromium.org>
In-Reply-To: <20200615145252.259971-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Jun 2020 21:42:52 -0700
Message-ID: <CABBYNZK=-_uN=Z==-vi3rKaAFzEWmKn2c2eXSsMMWJXTQFiJ_g@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adding a configurable le autoconnect timeout value
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Mon, Jun 15, 2020 at 7:57 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This patch adds support for a configurable le autoconnect timer.
>
> ---
>
>  doc/mgmt-api.txt | 1 +
>  src/adapter.c    | 8 ++++++++
>  src/hcid.h       | 1 +
>  src/main.c       | 5 +++++
>  src/main.conf    | 1 +
>  5 files changed, 16 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 80c483f8b..ca0d38469 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3278,6 +3278,7 @@ Read Default System Configuration Command
>                 0x0018  LE Max Connection Interval
>                 0x0019  LE Connection Latency
>                 0x001a  LE Connection Supervision Timeout
> +               0x001b  LE Autoconnect Timeout
>
>         This command can be used at any time and will return a list of
>         supported default parameters as well as their current value.
> diff --git a/src/adapter.c b/src/adapter.c
> index 92002673b..9ce351893 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4423,6 +4423,14 @@ static void load_default_system_params(struct btd_adapter *adapter)
>                 len += sizeof(params[i].u16);
>         }
>
> +       if (main_opts.default_params.le_autoconnect_timeout) {
> +               params[i].entry.type = 0x001b;
> +               params[i].entry.length = sizeof(params[i].u16);
> +               params[i].u16 = main_opts.default_params.le_autoconnect_timeout;
> +               ++i;
> +               len += sizeof(params[i].u16);
> +       }
> +
>         err = mgmt_send(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
>                         adapter->dev_id, len, params, NULL, NULL, NULL);
>         if (!err)
> diff --git a/src/hcid.h b/src/hcid.h
> index 1b2714b1d..c21ac9980 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -91,6 +91,7 @@ struct main_opts {
>                 uint16_t        le_max_conn_interval;
>                 uint16_t        le_conn_latency;
>                 uint16_t        le_conn_lsto;
> +               uint16_t        le_autoconnect_timeout;
>         } default_params;
>
>
> diff --git a/src/main.c b/src/main.c
> index e51f614b3..77886d58e 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -120,6 +120,7 @@ static const char *controller_options[] = {
>         "LEMaxConnectionInterval",
>         "LEConnectionLatency",
>         "LEConnectionSupervisionTimeout",
> +       "LEAutoconnecttimeout",
>         NULL
>  };
>
> @@ -410,6 +411,10 @@ static void parse_controller_config(GKeyFile *config)
>                   &main_opts.default_params.le_scan_win_connect,
>                   0x0004,
>                   0x4000},
> +               { "LEAutoconnecttimeout",
> +                 &main_opts.default_params.le_autoconnect_timeout,
> +                 0x0001,
> +                 0x4000},
>         };
>         uint16_t i;
>
> diff --git a/src/main.conf b/src/main.conf
> index 92d937f0c..6a6f7d4b4 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -141,6 +141,7 @@
>  #LEMaxConnectionInterval=
>  #LEConnectionLatency=
>  #LEConnectionSupervisionTimeout=
> +#LEAutoconnecttimeout=
>
>  [GATT]
>  # GATT attribute cache.
> --
> 2.27.0.290.gba653c62da-goog
>
Applied, thanks. Note that it might be better to send the
documentation changes as a separate patch next time.

-- 
Luiz Augusto von Dentz

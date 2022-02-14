Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D8FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 19:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiBNTEj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 14:04:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBNTEN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 14:04:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1171C8C49D
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 11:03:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w2so9825748edc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 11:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdr3WFp3E9OzgNCWLotNQ7VjdvztBcysFRD6qohkMU4=;
        b=IAj/f401Pamj54tFk8U9adtcleW7eXX912sjBfKSWPtoZKqN7gFSxwHebO0+kVIu5K
         +uE6bJcXGJv6avd3tDOTJgfx6bZ4vVOh9sAiTle1ScL1lAy7/XBbE2E0rqrLgnHEk1sp
         Rr5dep5YOvLSEO2ogfKAEs+jgEXAITnpjt6u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdr3WFp3E9OzgNCWLotNQ7VjdvztBcysFRD6qohkMU4=;
        b=y0rGXWXTa2CVu1/M3ULWcffDapcDsZxd7Xztkjcf4faY0njCzMNDoWYiiy6YXFjoh4
         BR8Kagl1RfMTEPFH19vR7jFV1Lbl0mR1rm7u+iSvLkNXP7mpSdIwt64X1WLcpGjMf9zy
         D1+rVYdQJ3Fh14WWVl5vPhacNTZGtDZ9wBDAt1+T4VxKwr3h9hQGSJtk1N1pgBX/1gvC
         qoqgxWkxUZVoIifB+iyppq+0Jp9wDjRIF4e6M8kZzNm2BEsPDNvoijAMJrw6/OT0z6Be
         aoFkOiCGQthdJxdQ00wxNEe9Nj5euOqrMzylHcd6+hNwalSGXzwKp8H4kTfT6S18A72P
         MvLA==
X-Gm-Message-State: AOAM530+sH+rWstnQ3nAUG9UqN5bag3dRJ0NilSf3mTC0ips07GQ5z0Y
        dGkV1e+rShh7SysA9rU+YUNONwBm3JyfZg==
X-Google-Smtp-Source: ABdhPJxpJAbRZ+vEhToULpc3sojhPapJkkJWpKEvM4Ilv2jUPMi0n8J0OC+iDDOzcglEsSUgpflhGA==
X-Received: by 2002:a05:6402:22b7:: with SMTP id cx23mr185373edb.91.1644865144206;
        Mon, 14 Feb 2022 10:59:04 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id c5sm16005229edk.43.2022.02.14.10.59.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:59:03 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id d27so24645539wrb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 10:59:03 -0800 (PST)
X-Received: by 2002:a05:6000:1683:: with SMTP id y3mr357342wrd.222.1644865143200;
 Mon, 14 Feb 2022 10:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20220212084541.221196-1-daniel.trnka@gmail.com>
In-Reply-To: <20220212084541.221196-1-daniel.trnka@gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Mon, 14 Feb 2022 10:58:52 -0800
X-Gmail-Original-Message-ID: <CAO271mn+kd08LkTsByqqGt6EuvJpEdNpRHZsK2eVZg0so_KmQA@mail.gmail.com>
Message-ID: <CAO271mn+kd08LkTsByqqGt6EuvJpEdNpRHZsK2eVZg0so_KmQA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: battery provider for non-LE controllers
To:     Daniel Trnka <daniel.trnka@gmail.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

On Sat, Feb 12, 2022 at 12:48 AM Daniel Trnka <daniel.trnka@gmail.com> wrote:
>
> Enable battery provider dbus interface BatteryProviderManager1 for
> non-LE controllers, so external clients like pipewire can provide
> battery information for bluetooth headsets on non-LE controllers.
> ---
>  src/adapter.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index eef50f67a..2071cf8db 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8976,6 +8976,11 @@ static int adapter_register(struct btd_adapter *adapter)
>                 agent_unref(agent);
>         }
>
> +       if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
> +               adapter->battery_provider_manager =
> +                       btd_battery_provider_manager_create(adapter);
> +       }
> +
>         /* Don't start GATT database and advertising managers on
>          * non-LE controllers.
>          */
> @@ -9010,11 +9015,6 @@ static int adapter_register(struct btd_adapter *adapter)
>                 }
>         }
>
> -       if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
> -               adapter->battery_provider_manager =
> -                       btd_battery_provider_manager_create(adapter);
> -       }
> -
>         db = btd_gatt_database_get_db(adapter->database);
>         adapter->db_id = gatt_db_register(db, services_modified,
>                                                         services_modified,
> --
> 2.35.1
>

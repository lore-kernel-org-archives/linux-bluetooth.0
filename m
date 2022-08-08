Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B85C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 20:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbiHHUJO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiHHUJE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 16:09:04 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257361A816
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 13:09:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o22so12681104edc.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79rXfwytifjHsT/nWSVtUKit1pAtH9HVs1gJvOC1UxY=;
        b=Lkm9ZXFWid0RwG6ZWU+WMNeaUe1qpu7Rv1OrZvixk8h3EBcBOIhKU26xxIuQRalHgQ
         pwAuiy32uvQHglgtWIZYZcCPHloEuZGWyegCZi4JkgxzyZLnbiB7uz6kAzU1trM2e9xh
         W+wW9Ld41f7B3d0KK0cg6DC7KO83n+Xj7r8+fKvk6pTsS+I5uvVV67EiM7ZefNd2BoMS
         6rE8mA9PskUsL89dVAzS0CNtgk6RhJevDbzytz9fkriz5DSDXL93RQBu9pYRq+Fe3iHq
         Z4VwrEDAzClipD7ysBNYTk+2D+cIN1GhkKrHXDOdlIPBif07OgVx9IB26LhzIKe3o3oM
         2Fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79rXfwytifjHsT/nWSVtUKit1pAtH9HVs1gJvOC1UxY=;
        b=L6LY9JfytwJ7e6/qfabKebZT0lkGwq0bvduQxXLpOUP/p7eXy4GUUOPZ/xtfun2Ca0
         Hwh4Ta3+vZoCBwCum6OV7ftMJWU57jyMt4snHyhGAFofxZpvKwE9pibQAyqygTShjCPN
         e+Skxu4ckZAxzrmJ/kHA1PmBSGWmqvplVqMIZFggFYNKYVAu69fC0m4x3wUWuBvQ775S
         IxaPS4CysegwoQH0fQC/+To+pZFpuLcH9abrcQr2FgLqDZ/HMNpu2oU9y5ZYd4MolHsn
         1H+YR5ie+Y+h+8AYqjFtIkseMIV5YOuNEFLUrsoDdUq2dzLkSgQd9eoIdpql36yE0aB0
         Jr7A==
X-Gm-Message-State: ACgBeo1VGsOzpMYRuIjctz4SPSWAsJyUQFU8oxNfrrOkZwcs8oBzv9mI
        PkqTsdEqIBnnPkt49W/wiKc17ReKtegSjhlDugI=
X-Google-Smtp-Source: AA6agR44dCc4H2Of5RH0qFijMOh/sTkQkz/0gWI6Jqzdo8jqd1y24AY5V7Ohr2QaFhCdO8dHzugjhQQSFT9sFUpwr10=
X-Received: by 2002:a05:6402:cb7:b0:440:ad7e:5884 with SMTP id
 cn23-20020a0564020cb700b00440ad7e5884mr5954963edb.382.1659989339527; Mon, 08
 Aug 2022 13:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220808092206.153221-1-ntrrgc@gmail.com>
In-Reply-To: <20220808092206.153221-1-ntrrgc@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Aug 2022 13:08:48 -0700
Message-ID: <CABBYNZJOGjEgGQ7+tc3SOJ3j7Og1PkHMv+a1EX4JaVg1B3rXwA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Fix uninitialized read in attribute handle
To:     Alicia Boya Garcia <ntrrgc@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alicia,

On Mon, Aug 8, 2022 at 2:30 AM Alicia Boya Garcia <ntrrgc@gmail.com> wrote:
>
> When services, characteristics and descriptors were parsed from DBus
> proxies the client code was calling the print code without initializing
> the `handle` field, which the print functions use.
>
> This resulted in semi-random or zero handles in all attributes when
> using gatt.list-attributes in bluetoothctl, depending on compilation
> flags.
>
> This patch fixes the problem by parsing the handle from the DBus proxy
> path.
> ---
>  client/gatt.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/client/gatt.c b/client/gatt.c
> index 4c1efaf75..aaad786b2 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -158,6 +158,16 @@ static void print_inc_service(struct service *service, const char *description)
>                                         service->uuid, text);
>  }
>
> +static uint16_t handle_from_path(const char *path)
> +{
> +       const char *number = path + strlen(path) - 4;
> +
> +       if (number < path)
> +               return 0;
> +
> +       return (uint16_t) strtol(number, NULL, 16);
> +}

Object paths are subject to change so we shouldn't consider them as
APIs, so what we should aim to do if we really want to expose handles
of remote attributes is to have it as a D-Bus property Handle like we
do for the servers:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n53

>  static void print_service_proxy(GDBusProxy *proxy, const char *description)
>  {
>         struct service service;
> @@ -179,6 +189,7 @@ static void print_service_proxy(GDBusProxy *proxy, const char *description)
>         service.path = (char *) g_dbus_proxy_get_path(proxy);
>         service.uuid = (char *) uuid;
>         service.primary = primary;
> +       service.handle = handle_from_path(service.path);
>
>         print_service(&service, description);
>  }
> @@ -261,6 +272,7 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
>         memset(&chrc, 0, sizeof(chrc));
>         chrc.path = (char *) g_dbus_proxy_get_path(proxy);
>         chrc.uuid = (char *) uuid;
> +       chrc.handle = handle_from_path(chrc.path);
>
>         print_chrc(&chrc, description);
>  }
> @@ -355,6 +367,7 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
>         memset(&desc, 0, sizeof(desc));
>         desc.path = (char *) g_dbus_proxy_get_path(proxy);
>         desc.uuid = (char *) uuid;
> +       desc.handle = handle_from_path(desc.path);
>
>         print_desc(&desc, description);
>  }
> --
> 2.37.1
>


-- 
Luiz Augusto von Dentz

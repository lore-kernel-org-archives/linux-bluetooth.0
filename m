Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DF2C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 01:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161B060ED5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 01:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhH0BSB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 21:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhH0BSA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 21:18:00 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF0C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 18:17:12 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id m19so3416351vsj.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 18:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXcH24SjawFwqCQPAoT8+4ICwSP78DMNwAg30BDtZ4c=;
        b=KCVYpHVpXUhhjedx5R8iTx99tDP4sBBPrshtl+TD/W/0OaA0gYHRSyrp4SOlIRuaDC
         Wv05wXuLJP1UzAHverRFcLewnW+rx2uKQEI5DIgZ6Jk34mLa9ZP9qBKkPt0U2YHpQQPl
         ORnPk2MhUOSrsUr2bWPbaluIz4oH9oVBDUj7P1Wk+9uYkSSDw47ZUFKFwOuG+VS2IPVR
         shLOGxAZbMyttIZKj+W9pTc+qQDDNV/sU9g8VGjPRJfzhlYVhtprghUu0mWf2wXGlms8
         KVP/SeqFEorD0/TA/GRNqmMcXR1TzwtwGoUgI0aO0v+DwctRE6LEIKVP2ZIMJ9boRVkL
         GgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXcH24SjawFwqCQPAoT8+4ICwSP78DMNwAg30BDtZ4c=;
        b=Dn7hrDyj/fXtkhPcuHHGgaKMaezyA/jHKXGZO5dY9jerde1IVbXCOuVL8+KefJYSWk
         y/bVdcwhp669mu8tCuX3fsWZoWIh7skm1nowFgl2b/pMeG/kvE5Od9ot/v9BlghYWw5D
         eQUPS9MDqnd+Cok57dNa/UTUnuDTcvzyM0Co8ZGbNCWu8cdUn0rcn/jiGe5oKS9lOb6j
         +BkOXYrUdoxDtNpECvnXu0SQTIu/98D7aGzcRVoJP6+nwu04m+fnaMMPRIQ2nkJqRLjF
         mcVGfqr7v035o92BFCJU+QbUBQ8MsLb1h0gEIQScdwsMz0jsuwWotFGUDaRISZa9mC4i
         NTuw==
X-Gm-Message-State: AOAM533CvTnsR9F0CgdFg6a7JdYszWXD5adh02z1F1OIpTyEhKKAdnzr
        KvyYJwpJqBALNiEKJpMhVVH4dWvpeUOqLak5PJUtwske
X-Google-Smtp-Source: ABdhPJwn5mKOOiw5K+p/s6p2BnCI+N792JRfHSZM+0dGd9LttQ+sT9qvl28vzVDRtOiCQisRAoQXX73Mn/O6CVot6Hg=
X-Received: by 2002:a67:f10a:: with SMTP id n10mr5728740vsk.18.1630027031114;
 Thu, 26 Aug 2021 18:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210826164211.2936133-1-david@lechnology.com>
In-Reply-To: <20210826164211.2936133-1-david@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Aug 2021 18:17:00 -0700
Message-ID: <CABBYNZK9-0b0O_FOzYQ8+iB-dDqC0RHxLCBkN8TibR2opJoD=A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: add MTU D-Bus property
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Thu, Aug 26, 2021 at 9:45 AM David Lechner <david@lechnology.com> wrote:
>
> When using GATT write without response, it is useful to know how much
> data can be sent in a single write. This value is the negotiated MTU
> minus 3 bytes.
>
> The D-bus method org.bluez.GattCharacteristic1.AcquireWrite returns the
> MTU exactly for this reason. However, when using the alternate API
> org.bluez.GattCharacteristic1.WriteValue with the options dictionary
> { "type": "command" }, there is no current way to get the MTU value.
> If the value is too large, then the method returns "Failed to initiate
> write" [org.bluez.Error.Failed].

In most cases the MTU is not that useful since each attribute has a
maximum length of just a few bytes, the MTU is only really useful for
control points which I rather have using Acquire* variants. Note that
for long values the attribute must support Write Long Procedure and
afaik WriteValue does support that so it can fragment the data and
send according to the MTU.

> This adds an "MTU" property to the org.bluez.Device1 interface that
> is emitted in gatt_client_ready_cb() which is after the MTU exchange
> has taken place.

This would not work for the likes of EATT which don't require rx and
tx MTU to be symmetric, with the likes of Acquire we could in theory
even assign a dedicated EATT channel if we have to.

> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  client/main.c      |  1 +
>  doc/device-api.txt |  4 ++++
>  src/device.c       | 24 ++++++++++++++++++++++++
>  3 files changed, 29 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 506602bbd..b12a7da3e 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1754,6 +1754,7 @@ static void cmd_info(int argc, char *argv[])
>         print_property(proxy, "TxPower");
>         print_property(proxy, "AdvertisingFlags");
>         print_property(proxy, "AdvertisingData");
> +       print_property(proxy, "MTU");
>
>         battery_proxy = find_proxies_by_path(battery_proxies,
>                                         g_dbus_proxy_get_path(proxy));
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 4e824d2de..030873821 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -272,3 +272,7 @@ Properties  string Address [readonly]
>                         Example:
>                                 <Transport Discovery> <Organization Flags...>
>                                 0x26                   0x01         0x01...
> +
> +               uint16 MTU [readonly, optional]
> +
> +                       The exchanged MTU (GATT client only).
> diff --git a/src/device.c b/src/device.c
> index 26a01612a..898f98da7 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1471,6 +1471,26 @@ static gboolean dev_property_wake_allowed_exist(
>         return device_get_wake_support(device);
>  }
>
> +static gboolean
> +dev_property_get_mtu(const GDBusPropertyTable *property,
> +                    DBusMessageIter *iter, void *data)
> +{
> +       struct btd_device *device = data;
> +
> +       dbus_uint16_t mtu = bt_gatt_client_get_mtu(device->client);
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &mtu);
> +
> +       return TRUE;
> +}
> +
> +static gboolean
> +dev_property_mtu_exist(const GDBusPropertyTable *property, void *data)
> +{
> +       struct btd_device *device = data;
> +
> +       return bt_gatt_client_get_mtu(device->client) != 0;
> +}
> +
>  static bool disconnect_all(gpointer user_data)
>  {
>         struct btd_device *device = user_data;
> @@ -3014,6 +3034,7 @@ static const GDBusPropertyTable device_properties[] = {
>         { "WakeAllowed", "b", dev_property_get_wake_allowed,
>                                 dev_property_set_wake_allowed,
>                                 dev_property_wake_allowed_exist },
> +       { "MTU", "q", dev_property_get_mtu, NULL, dev_property_mtu_exist },
>         { }
>  };
>
> @@ -5245,6 +5266,9 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
>                 return;
>         }
>
> +       g_dbus_emit_property_changed(dbus_conn, device->path,
> +                                       DEVICE_INTERFACE, "MTU");
> +
>         register_gatt_services(device);
>
>         btd_gatt_client_ready(device->client_dbus);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz

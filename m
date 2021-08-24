Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06B7C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 22:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6779B61220
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Aug 2021 22:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhHXWhp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhHXWho (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Aug 2021 18:37:44 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17144C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 15:37:00 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id x23so5794057uav.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Aug 2021 15:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqmNWaYmYIkDv2HoLvGXNvKQdovEkPQFqubZX6Uqce4=;
        b=G1DsILJxcHZYn6cbFag9KlDCjhfRZhwOB3bQymiS9yUbjJ+TsWpWcOQ450kshtS6ed
         BRO+3vEutKz4CV30oLCvc0u6+qOo9fkf7ME1apZjFG1U7YfgxMgkx8EKxNYVjbFd3nuZ
         C7WgzoEFv6dNx82tU+awiPzUEn3dMmaGedhMoUFAl4REBTDz/nAfPjsEDiwFG2WWWCqZ
         nTx9s6iWWx5Ibhq31eu6Wf/lNRcdXIJCfbm6E1NDYmAQZVl+g06621GJE3zEHvEeFIaT
         NSn+ljI2Vyi+H8lsRbY+C7bEiZXyvXeFSU5dw6Yvuzf3vXsFtFA1y++AsLT0gMiLE0WC
         zUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqmNWaYmYIkDv2HoLvGXNvKQdovEkPQFqubZX6Uqce4=;
        b=psLU5n90OKVeeEHnDJ6VY242ikcJzcCDN2XgLaV3xAqQlHjDti/WjLp/YJOSGlNvR+
         M4bL/J/RNVUn+rBxcjU5wOaXkIq4AyrHXne8u3EcGlk04eJSz5+ACyXhoRS6A10jTzx7
         jUNQEwS4W0e81l1D5cbYhdECRh+TpAVX61wplkm7otNfLho6IFQjox1BJKVH686SbQhA
         EY/wY9UyLSBF4NmhknxU+krNacR0u3ACC08yE0epDpCk5iXusfW64VLTOW4X/AXNh/Pg
         ReA49yWUriRxCTSnQRqdNjMBIMjdJ6BGyGQRmJ02pBn1EeRYNZV2Spa+Pepelh6i/FgV
         iZKQ==
X-Gm-Message-State: AOAM530uBIX5abyt2bVWoRKMJoAbEKm0FKJfPmXq/1QH1POms3DBDum0
        G51EtdhsP2yM9DvLlZnQYoWTn2b0lv1Bd5wb1O005PRAysc=
X-Google-Smtp-Source: ABdhPJy4FJ/gvxD0EwC/Q6ugXFQdQcoxGrsrZHDHWvibNwPBOGDTqL6tUZ4yVjhSAQ565UDQ3Hto6Kfwq1h6/c2UPHw=
X-Received: by 2002:a67:f10a:: with SMTP id n10mr9917788vsk.18.1629844618851;
 Tue, 24 Aug 2021 15:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210824182916.2569317-1-david@lechnology.com>
In-Reply-To: <20210824182916.2569317-1-david@lechnology.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Aug 2021 15:36:47 -0700
Message-ID: <CABBYNZ+BOXNV6yz3H842J_-jtqkqRpO4Zzm_zCbkwrCX4Wx81w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: fix advertising data UUIDs ignored when
 Cache = yes
To:     David Lechner <david@lechnology.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi David,

On Tue, Aug 24, 2021 at 12:00 PM David Lechner <david@lechnology.com> wrote:
>
> When [GATT] Cache = yes is set in configuration BlueZ does not use
> cached UUIDs for the list of service UUIDs. However, it doesn't clear
> the in-memory list of UUIDs received from advertising data, so when
> a device is scanned, connected and disconnected, the internal state
> still reflects that the UUIDs from the advertising data have already
> been handled. device_add_eir_uuids() ignored the UUIDs from the
> advertising data because both dev->le_state.svc_resolved == true and
> dev->eir_uuids still contains the UUIDs from the previous scan session.
>
> This fixes the issue by resetting both le_state.svc_resolved and
> eir_uuids when the device is disconnected.
>
> Issue: https://github.com/bluez/bluez/issues/192
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  src/device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 807106812..48b9bd8d6 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3129,6 +3129,12 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>
>         device_update_last_seen(device, bdaddr_type);
>
> +       if (!gatt_cache_is_enabled(device)) {
> +               device->le_state.svc_resolved = false;
> +               g_slist_free_full(device->eir_uuids, g_free);
> +               device->eir_uuids = NULL;
> +       }

We might want to cleanup the eir_uuid regardless of the cache being
enabled, since the next time the device advertise it may have
completely different UUIDs, as for resetting the svc_resolved Id guess
it would be better placed at gatt_cache_cleanup since that is clearing
the db it means should be cache left with should also set svc_resolved
= false.

>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connected");
>
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz

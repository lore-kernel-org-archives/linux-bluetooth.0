Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20674C433E9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3983652B7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 18:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCHSjI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCHSii (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 13:38:38 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E6CC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 10:38:38 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id z126so12010056oiz.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 10:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVhzNT0R75Vb776in/lQfHHjf7gKVBYrk5VLjHEXNW0=;
        b=NISlYcVpJPXaSBAysJs4yqTQ4/VKXIUlH6LVjJu0OERd4kgiNFYgk0YVSUYT8dmDJB
         1i5mSgjTk1eitrIDEhq8snZd3Ylx3Vx3yLHQnK5kspyI/IHB41Jhdi5b+Mx5g62DI6Xs
         ie1LSz69C/TadPQevMZwbioWQUNvK4rvNqtaWAawOml9g9LcODhgHO1lKOaxGeb63TF4
         hL+FAnMlr9ldZyHIRrQ1FuGxiS742a95bvAkwpIlCDBHXFnQI4JPmTdpsmeHkEB4b72l
         hHNRU4ED9D0Fk31hBiP2mnR+ZM+qshx1m0abroWXQXjMijrXRSMlJ+rqSzmeAB7+Y6bz
         TBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVhzNT0R75Vb776in/lQfHHjf7gKVBYrk5VLjHEXNW0=;
        b=eMUELX4XTrEb2jiZb2wmhD6MwfNZ/9IXSE0eRSxDYFCzENGHoc1aJehfp/p9P0htTi
         TdIIvgaVLpsJsNuTzHVhMPKtKIN4/96zvXZHINDLrVBGhu4ds9xg6p4b4A5Lt6vEfR9e
         qV2FcLk73ccar5cX64RLxarm5Iuns6p+CTiM7QOUvx++SSU6PiOBXsUUSZResKdNh/vE
         ROetxsPN7xZyAzp0JIJhGc6GExut0inUc0dkcpwnP7Uu1sI9M901EHvVAskqPwoQ0asa
         6YMlRnJJ+ManKcz9r0F+/OOyxPqJcHodS9nnqP9k1eBL7IRW+wy9htJVLJFMp1kbiQ5H
         zuaQ==
X-Gm-Message-State: AOAM532i6Ua4C0f0d00J2GgJyAexp4hUy8nvAgvTU+9cvc0E7C7fiF3D
        I4BW6pZEvvUuG1Lh1/395AmYSdS9ASiPqKraBgU=
X-Google-Smtp-Source: ABdhPJwOi3RkT9nN17U22ctTkd2NuEgbmVshpsdiOuL8W6k+rCBz9TDzPVgjikHe5NiN1rtVWavEK0msWzJqz727Qjs=
X-Received: by 2002:a54:468f:: with SMTP id k15mr162154oic.58.1615228717839;
 Mon, 08 Mar 2021 10:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20210305235217.2382976-1-danielwinkler@google.com> <20210305155113.Bluez.v3.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
In-Reply-To: <20210305155113.Bluez.v3.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Mar 2021 10:38:27 -0800
Message-ID: <CABBYNZLWOrzuY=WnAxxxyPK8Q4RxwBCA8qQRZO_wFOHcaswUHw@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/3] advertising: Add SupportedFeatures to LEAdvertisingManager1
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Fri, Mar 5, 2021 at 3:59 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> The new SupportedFeatures member tells advertising clients whether the
> platform has hardware support for advertising or capability to set tx
> power of advertisements.
>
> Additionally, fix small typo in "secondary_exists" function name.
>
> Change is tested on hatch and kukui chromebooks by using dbus-send to
> verify that SupportedFeatures always exists, and is only populated when
> extended advertising is available.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> Changes in v3: None
> Changes in v2:
> - Expose empty SupportedFeatures if no support available
>
>  lib/mgmt.h        |  2 ++
>  src/advertising.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 76a03c9c2..c0021abd8 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -503,6 +503,8 @@ struct mgmt_rp_add_advertising {
>  #define MGMT_ADV_FLAG_SEC_1M           (1 << 7)
>  #define MGMT_ADV_FLAG_SEC_2M           (1 << 8)
>  #define MGMT_ADV_FLAG_SEC_CODED                (1 << 9)
> +#define MGMT_ADV_FLAG_CAN_SET_TX_POWER (1 << 10)
> +#define MGMT_ADV_FLAG_HW_OFFLOAD       (1 << 11)
>  #define MGMT_ADV_PARAM_DURATION                (1 << 12)
>  #define MGMT_ADV_PARAM_TIMEOUT         (1 << 13)
>  #define MGMT_ADV_PARAM_INTERVALS       (1 << 14)
> diff --git a/src/advertising.c b/src/advertising.c
> index 15a343e52..dd6008cb9 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1616,7 +1616,8 @@ static void append_secondary(struct btd_adv_manager *manager,
>         }
>  }
>
> -static gboolean secondary_exits(const GDBusPropertyTable *property, void *data)
> +static gboolean secondary_exists(const GDBusPropertyTable *property,
> +                                               void *data)
>  {
>         struct btd_adv_manager *manager = data;
>
> @@ -1640,6 +1641,43 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
>         return TRUE;
>  }
>
> +static struct adv_feature {
> +       int flag;
> +       const char *name;
> +} features[] = {
> +       { MGMT_ADV_FLAG_CAN_SET_TX_POWER, "CanSetTxPower" },
> +       { MGMT_ADV_FLAG_HW_OFFLOAD, "HardwareOffload" },
> +       { },
> +};
> +
> +static void append_features(struct btd_adv_manager *manager,
> +                                               DBusMessageIter *iter)
> +{
> +       struct adv_feature *feat;
> +
> +       for (feat = features; feat->name; feat++) {
> +               if (manager->supported_flags & feat->flag)
> +                       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
> +                                                               &feat->name);
> +       }
> +}
> +
> +static gboolean get_supported_features(const GDBusPropertyTable *property,
> +                                       DBusMessageIter *iter, void *data)
> +{
> +       struct btd_adv_manager *manager = data;
> +       DBusMessageIter entry;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_TYPE_STRING_AS_STRING, &entry);
> +
> +       append_features(manager, &entry);
> +
> +       dbus_message_iter_close_container(iter, &entry);
> +
> +       return TRUE;
> +}
> +
>  static gboolean get_supported_cap(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *data)
>  {
> @@ -1678,7 +1716,8 @@ static const GDBusPropertyTable properties[] = {
>         { "SupportedInstances", "y", get_instances, NULL, NULL },
>         { "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
>         { "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
> -                                                       secondary_exits },
> +                                                       secondary_exists },
> +       { "SupportedFeatures", "as", get_supported_features, NULL, NULL },

Missing G_DBUS_PROPERTY_FLAG_EXPERIMENTAL.

>         { "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL,
>                                         G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
>         { }
> --
> 2.30.1.766.gb4fecdf3b7-goog
>


-- 
Luiz Augusto von Dentz

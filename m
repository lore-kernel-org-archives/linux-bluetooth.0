Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF9F61B66
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbhKPD1O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbhKPDZm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 22:25:42 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC490C03401B
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 15:50:02 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id f7so10140397vkf.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQGDpHZNfVl47QzRyqQg4FWE2rmH6JeLNXUBbaQTl6Q=;
        b=a2bXS+wLo4DwkUurYF6SXuCI56mVNyLjovD3wlkvcoY2ac0Ld2Z8zGSI+YHlDxkxoK
         hVTDv3y8Nq3v5vNIhKscp2NHhoJNiwXARChOnF3u0//p2+xPbHJ21Zd1qrhg0tNfd8uU
         TxZypTdVWSnua4gNhUVW1cbmntySbTp+zxcHl2zQ8BQa5KJbl8UrZ/AU4JZLh5LNHVGK
         WFjBTYaYHBl2CLAqm+0uzw9o7BQfX+e6CkeP0ZlfcteyqHC80r2p3Aj5DsHBBZs9sF42
         ojXD4egXWpLf7U2P8iI0OuR6uqhjwrgJZm5Xl7h95lhY64B/AJu+KMO/enVjVLSe9Z32
         1Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQGDpHZNfVl47QzRyqQg4FWE2rmH6JeLNXUBbaQTl6Q=;
        b=7zOd9qupcfbtPR0cmJ2PkVlX7KiDJ9RpbnStMgC1M+R1eeW/K2iG0YN4RvFTCikdKz
         1+cY6Op1wq2UYVZ0p1T/C5UoV4CHRl6DRgrZacVju2TcqWpQt5Imb6O/kuA11yNOMsXy
         QYoEfR+NZHcF4+58djO22V8V5E2FzgXkOJlmciRHOUyC/8bnoxXfkxRw8/62+h4YBICz
         Y3CuLCuHdeHox11UFHUtAXLk6NKw1FUSK29wv7Wst84KTl//SUR7qeh7D28R4eJ0tO75
         sNLNRXAugKkeLfRRvGdQPNb/uiRdIPMTV+qk/gZM6//lATpD2WW0GSQfZcXzqLcsrE8E
         WGRQ==
X-Gm-Message-State: AOAM530HF7fxDFvI50FlqDh54w9lUwret8TodMoVekNxr6qg4xQJ10mt
        ZnYv683+Cf9fxTJWoA+peGDfrmye4RcXETfb/BA=
X-Google-Smtp-Source: ABdhPJxLDgoD0vsXO+Qv9F+UkosJDkyvRI5r+rZ1uzcfT/xQSQD0TkvamdS2AuAzZg6S/Cnb0tUdQhAK6mYc4tG6s6A=
X-Received: by 2002:a05:6122:2005:: with SMTP id l5mr65622749vkd.4.1637020201733;
 Mon, 15 Nov 2021 15:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
In-Reply-To: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Nov 2021 15:49:51 -0800
Message-ID: <CABBYNZJ+gnw_BCkLUaxQ5c6aViqcroWU1FuHnhK01=+m6Mwq3g@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 1/3] Listen and process remote name resolving failure
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Nov 15, 2021 at 1:27 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> When Remote Name Resolve ends with failure, record this occurrence and
> prevent remote name resolving for the same device for some time.
> Increase the time duration for subsequent failures.
> ---
> Hi maintainers,
>
> This is the patch series for remote name request as was discussed here.
> https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/
> Please also review the corresponding kernel space change.
>
> Changes in v3:
> * Rename MGMT const to align with the doc
>
> Changes in v2:
> * Stay silent instead of sending MGMT_OP_CONFIRM_NAME with DONT_CARE flag.
>
>  lib/mgmt.h    |  1 +
>  src/adapter.c | 15 +++++++++++++--
>  src/device.c  | 23 +++++++++++++++++++++++
>  src/device.h  |  2 ++
>  4 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 0d1678f01d..d860b27401 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -856,6 +856,7 @@ struct mgmt_ev_auth_failed {
>  #define MGMT_DEV_FOUND_CONFIRM_NAME    0x01
>  #define MGMT_DEV_FOUND_LEGACY_PAIRING  0x02
>  #define MGMT_DEV_FOUND_NOT_CONNECTABLE 0x04
> +#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED 0x10
>
>  #define MGMT_EV_DEVICE_FOUND           0x0012
>  struct mgmt_ev_device_found {
> diff --git a/src/adapter.c b/src/adapter.c
> index d0d38621b8..6100448b5f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6989,6 +6989,7 @@ static void update_found_devices(struct btd_adapter *adapter,
>                                         uint8_t bdaddr_type, int8_t rssi,
>                                         bool confirm, bool legacy,
>                                         bool not_connectable,
> +                                       bool name_resolve_failed,
>                                         const uint8_t *data, uint8_t data_len)
>  {
>         struct btd_device *dev;
> @@ -7081,6 +7082,9 @@ static void update_found_devices(struct btd_adapter *adapter,
>
>         device_set_legacy(dev, legacy);
>
> +       if (name_resolve_failed)
> +               device_name_resolve_fail(dev);
> +
>         if (adapter->filtered_discovery)
>                 device_set_rssi_with_delta(dev, rssi, 0);
>         else
> @@ -7151,7 +7155,10 @@ static void update_found_devices(struct btd_adapter *adapter,
>         if (g_slist_find(adapter->discovery_found, dev))
>                 return;
>
> -       if (confirm)
> +       /* If name is unknown but it's not allowed to resolve, don't send
> +        * MGMT_OP_CONFIRM_NAME.
> +        */
> +       if (confirm && (name_known || device_name_resolve_allowed(dev)))
>                 confirm_name(adapter, bdaddr, bdaddr_type, name_known);
>
>         adapter->discovery_found = g_slist_prepend(adapter->discovery_found,
> @@ -7201,6 +7208,8 @@ static void device_found_callback(uint16_t index, uint16_t length,
>         uint32_t flags;
>         bool confirm_name;
>         bool legacy;
> +       bool not_connectable;
> +       bool name_resolve_failed;
>         char addr[18];
>
>         if (length < sizeof(*ev)) {
> @@ -7230,10 +7239,12 @@ static void device_found_callback(uint16_t index, uint16_t length,
>
>         confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
>         legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
> +       not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
> +       name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
>
>         update_found_devices(adapter, &ev->addr.bdaddr, ev->addr.type,
>                                         ev->rssi, confirm_name, legacy,
> -                                       flags & MGMT_DEV_FOUND_NOT_CONNECTABLE,
> +                                       not_connectable, name_resolve_failed,
>                                         eir, eir_len);
>  }
>
> diff --git a/src/device.c b/src/device.c
> index fdc2d50a47..699faeba3b 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -79,6 +79,8 @@
>  #define GATT_INCLUDE_UUID_STR "2802"
>  #define GATT_CHARAC_UUID_STR "2803"
>
> +#define NAME_RESOLVE_RETRY_DELAY       120 /* seconds */

I'd make this configurable since on headless systems it might be a
good idea to have an option to disable the retrying logic.

>  static DBusConnection *dbus_conn = NULL;
>  static unsigned service_state_cb_id;
>
> @@ -272,6 +274,9 @@ struct btd_device {
>
>         GIOChannel      *att_io;
>         guint           store_id;
> +
> +       time_t          name_resolve_earliest_allow_time;
> +       uint8_t         name_resolve_fail_count;
>  };
>
>  static const uint16_t uuid_list[] = {
> @@ -4361,6 +4366,24 @@ bool device_name_known(struct btd_device *device)
>         return device->name[0] != '\0';
>  }
>
> +bool device_name_resolve_allowed(struct btd_device *device)
> +{
> +       return time(NULL) >= device->name_resolve_earliest_allow_time;
> +}
> +
> +void device_name_resolve_fail(struct btd_device *device)
> +{
> +       if (!device)
> +               return;
> +
> +       /* Punish this device by not allowing name resolve for some time.
> +        * increase punishment time for subsequent failures.
> +        */
> +       device->name_resolve_fail_count++;
> +       device->name_resolve_earliest_allow_time = time(NULL) +
> +               NAME_RESOLVE_RETRY_DELAY * device->name_resolve_fail_count;

Like I said above we should probably make the number of retries and
intervals configurable, have a look how it was done for reconnections
in the policy plugin since I believe this would look very similar to
that. Anyway we can't really use the system time as that can be
modified causing jumps backward or forward in time so you must use
CLOCK_MONOTONIC if you don't want it to be affected by system time
changes.

The other possible solution would be not to have any retry logic since
those device are likely to fail resolving their names on each retry,
or we are doing this because we now properly abort the name
resolution?

> +}
> +
>  void device_set_class(struct btd_device *device, uint32_t class)
>  {
>         if (device->class == class)
> diff --git a/src/device.h b/src/device.h
> index 5f615cb4b6..76d79855f8 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -25,6 +25,8 @@ void btd_device_device_set_name(struct btd_device *device, const char *name);
>  void device_store_cached_name(struct btd_device *dev, const char *name);
>  void device_get_name(struct btd_device *device, char *name, size_t len);
>  bool device_name_known(struct btd_device *device);
> +bool device_name_resolve_allowed(struct btd_device *device);
> +void device_name_resolve_fail(struct btd_device *device);
>  void device_set_class(struct btd_device *device, uint32_t class);
>  void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
>                                                         uint8_t bdaddr_type);
> --
> 2.34.0.rc1.387.gb447b232ab-goog
>


-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE177C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF20610FF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Sep 2021 23:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhIIXKG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhIIXKG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Sep 2021 19:10:06 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40902C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Sep 2021 16:08:56 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id t26so40509uao.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Sep 2021 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qMS1mpJ5wNCPyK8/l7Zgddv+58AolL5uq4uSXUD10w=;
        b=T3vFLVfVAr3fAWS/LfDrrOKCddgEpDZhWj6WqJONwA76fOiVqSmkdU2nGf4iQvEYUe
         hIfs8cW43EvAT1VOc0siZv4fl9+87aT6OcLzDigNeDb2aDniKnVR2qfX2EJhyh1vf9yD
         sMCcaCwh7e44CcoJpkT8cHak+CMKKraGcgrZqFys/uKtUGZp/EEPOafzzYMsqGBgIHVV
         z5G9MqHw36NGvGa9O/+HFm3vw8ZLvc/clKfcCkY1B/JZPAZ5347IYnA/LtYMfxfV7dj6
         bUrbLQkk0CP6oP/ck3J1s69x1Dd1m5sX1lPPBdPSqW3aOs6QLAiEtCdci+MBm6ZrIfaF
         2SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qMS1mpJ5wNCPyK8/l7Zgddv+58AolL5uq4uSXUD10w=;
        b=blffRljMPR/yyWiLesiNzbiMN359vdbhxl8BKpob4+d9yIH5EEVdJAjgPR2VAhEdBW
         WcNwiV/k3YUtmvS0Jzp2eio9U6R+yD9BpIP95xzvcgjOGo3EbIDRcGq52U7QNwhVfx2A
         W7naBio5sU0cKLcj8WtHx5IlzvxUszAhzvJKhbeMr80BBL18mLe0Lf3YFkqzJwZqVbm4
         edMFW3ONnhDKrFacUuu1Ozy1d0IipuUXiazaW1au/p9a6ct2IR7+DzW2qP/AwoTolddr
         VysXUWT/KoE2Gq6B9ArqjwBMzbJp1JrDOzDo0iQXDOP3iW/GABot7eV38gluFry3ZuDp
         z0IQ==
X-Gm-Message-State: AOAM530i5IWNa75o+CWT4z2ADQlBVFVVHtPvAde0aBdDxybdYssTSrPU
        M2O9wYEV0DCsOHPWlbA4eRtN9ecFroNgMO2mMeY=
X-Google-Smtp-Source: ABdhPJxFZapqa0jVJjMYJlKIidQQvjPvgLYHL2BsRek1WoA2APWtRnnLoVUaXdxc3bUwxo4BvUR16M0IhssXKd/H1JM=
X-Received: by 2002:ab0:3b93:: with SMTP id p19mr4123611uaw.72.1631228935244;
 Thu, 09 Sep 2021 16:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210826085906.BlueZ.v1.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
In-Reply-To: <20210826085906.BlueZ.v1.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 9 Sep 2021 16:08:44 -0700
Message-ID: <CABBYNZJsOLTk6iO1stc=6SBBdDms6xi-=j2s8hXLGVUnqqFm-w@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adv_monitor: Clear any running DeviceLost timers
 on power down
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Thu, Aug 26, 2021 at 8:59 AM Manish Mandlik <mmandlik@google.com> wrote:
>
> This patch clears any running Adv Monitor DeviceLost timers on bt power
> down. It'll also invoke DeviceLost event if the device is already found
> and is being tracked for the DeviceLost event.
>
> Verified this by adding a monitor using bluetoothctl and confirming that
> the DeviceLost event is getting triggered for already found device in
> case of bt power down.
>
> Reviewed-by: mcchou@google.com
> Signed-off-by: Manish Mandlik <mmandlik@google.com>

We don't use signed-off-by on userspace.

> ---
>
>  src/adapter.c     |  8 ++++++++
>  src/adv_monitor.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/adv_monitor.h |  2 ++
>  3 files changed, 62 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 84bc5a1b0..3af7d1f1a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -2872,6 +2872,13 @@ static void clear_discoverable(struct btd_adapter *adapter)
>         set_mode(adapter, MGMT_OP_SET_CONNECTABLE, 0x00);
>  }
>
> +static void adv_monitor_notify_power_down(struct btd_adapter *adapter)
> +{
> +       /* Notify Adv Monitor about power down */
> +       if (adapter->adv_monitor_manager)
> +               btd_adv_monitor_notify_power_down(adapter->adv_monitor_manager);
> +}

I guess we could just check for NULL inside btd_adv_monitor*, also I
would rename it to btd_adv_monitor_power_down.

>  static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>                                                 DBusMessageIter *value,
>                                                 GDBusPendingPropertySet id)
> @@ -2912,6 +2919,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>                 len = sizeof(mode);
>
>                 if (!mode) {
> +                       adv_monitor_notify_power_down(adapter);
>                         clear_discoverable(adapter);
>                         remove_temporary_devices(adapter);
>                 }
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index 715ac5904..59f307ae9 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -2011,3 +2011,55 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
>                                             NULL);
>         }
>  }
> +
> +/* Clears running DeviceLost timer for a given device */
> +static void clear_device_lost_timer(void *data, void *user_data)
> +{
> +       struct adv_monitor_device *dev = data;
> +       struct adv_monitor *monitor = NULL;
> +
> +       if (dev->lost_timer) {
> +               timeout_remove(dev->lost_timer);
> +               dev->lost_timer = 0;
> +
> +               monitor = dev->monitor;
> +
> +               DBG("Clearing device lost timer for device %p. "
> +                               "Calling DeviceLost() on Adv Monitor of "
> +                               "owner %s at path %s", dev->device,
> +                               monitor->app->owner, monitor->path);

The function name should already give the information about clearing
device lost timer so I'm not why you have to be so verbose about this
action.

> +               g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
> +                               report_device_state_setup,
> +                               NULL, dev->device, NULL);
> +       }
> +}
> +
> +/* Clears running DeviceLost timers from each monitor */
> +static void clear_lost_timers_from_monitor(void *data, void *user_data)
> +{
> +       struct adv_monitor *monitor = data;
> +
> +       queue_foreach(monitor->devices, clear_device_lost_timer, NULL);
> +}
> +
> +/* Clears running DeviceLost timers from each app */
> +static void clear_lost_timers_from_app(void *data, void *user_data)
> +{
> +       struct adv_monitor_app *app = data;
> +
> +       queue_foreach(app->monitors, clear_lost_timers_from_monitor, NULL);
> +}
> +
> +/* Handles bt power down scenario */
> +void btd_adv_monitor_notify_power_down(struct btd_adv_monitor_manager *manager)
> +{
> +       if (!manager) {
> +               error("Unexpected NULL btd_adv_monitor_manager object upon "
> +                               "power down");
> +               return;
> +       }

So you are doing the manager pointer check so it is even more a reason
to not have a wrapper around it.

> +       /* Clear any running DeviceLost timers in case of power down */
> +       queue_foreach(manager->apps, clear_lost_timers_from_app, NULL);
> +}
> diff --git a/src/adv_monitor.h b/src/adv_monitor.h
> index 2b4f68abf..20da012d4 100644
> --- a/src/adv_monitor.h
> +++ b/src/adv_monitor.h
> @@ -38,4 +38,6 @@ void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *manager,
>  void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
>                                    struct btd_device *device);
>
> +void btd_adv_monitor_notify_power_down(struct btd_adv_monitor_manager *manager);
> +
>  #endif /* __ADV_MONITOR_H */
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>


-- 
Luiz Augusto von Dentz

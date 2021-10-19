Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDDCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 21:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2291E60FD9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 21:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJSVTx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhJSVTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 17:19:50 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5E8C061746
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 14:17:37 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id i22so2653006ual.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbIhq0CHxYNjhfi4w7ry3tJI6g5AZi4JJSy/6O2ouH0=;
        b=cGW031XmaphQLlIQ2Nc0U8Y8u09MyxCTHlqObLgm/cE+pNc97LEZxvyQmaO7X6J3fB
         njpQtaEETAAvaO+qo8jHvBRIYzsesIRd6gHby9mdRz6qFJXBbBMgWDE/CW10h9s35chL
         2Rf3EdU5gjtGqs00uZs2fuMzpFLwrVrLGAX68ScO27jfGg84ex9EBGBYJcLcmPVP8p1y
         c9nimZ53ulQ3PZTibteIADpVnzNL3IGz449KWPVqlXmkd5vw2RebqYNgXJMKXPjz9idn
         TuORgoqB6z2gxjRFlx01ppaEHv2ZJob3fZVhGzb8v8t/QL7/ZwB3gqa0uRgdnJZowJcD
         7CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbIhq0CHxYNjhfi4w7ry3tJI6g5AZi4JJSy/6O2ouH0=;
        b=OKQXmrAzWVDrWIylyNq6n8f+1m6MrGK/x7hzjZc9konS1D9XL+gGzp24kCxaVKmQm7
         6dUPnsXwB26P6Jvr6Dxs8iK820ZJAFfUXTMRwyCxHZLuLIoB8+uumE1Yu8EOD0OcWJT5
         eqcid83QK5gCs1KzaCBKs6BsTi6eGj07ym4UxEdo/Zr3+a+z/1meIPQ85WiBn3QlZoGl
         YgIX6H7nz/aH0RYE0rrFCBRYDpekjp0rg8hZe5T0kSKrEu9nBKr8qY0SjFIOhHWLpiQO
         YOCeZOCJwbtJ975X/2TqDW0LP/vqixNNAYM07oySXrd7OwpFAIJ3IWWrciNgIRjcjbKN
         eItw==
X-Gm-Message-State: AOAM530SiMC9uHneT+99mDGYY8PVug7igU+ryvsg9yJ55J8YLMtwzlM6
        xIdMY5vWmIGgx+OEn6UqIK69g46zAf3TRODnqTQ=
X-Google-Smtp-Source: ABdhPJwrEBzrhxbS4lq3upnkhlQrWvuYOjyOuV/Ssjw6+uovO1CaFRmCIGKGZqGFw0M4Gq+tG353luhA8RrhtJ5Dwoc=
X-Received: by 2002:ab0:3cac:: with SMTP id a44mr3058330uax.129.1634678256169;
 Tue, 19 Oct 2021 14:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211013190035.1876237-1-mmandlik@google.com> <20211013115927.BlueZ.v3.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
In-Reply-To: <20211013115927.BlueZ.v3.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Oct 2021 14:17:25 -0700
Message-ID: <CABBYNZJ=0yyrqV4PV6jJC-j2Jjo5Agj6K0GFntDtAy93+1x7qQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 3/3] adv_monitor: Receive the Device Lost event
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Oct 13, 2021 at 12:00 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> This patch registers a callback function to receive Advertisement
> Monitor Device Lost event.
>
> Test performed:
> - verified by logs that Monitor Device is received from the controller
>   and sent to the bluetoothd when the controller starts/stops monitoring
>   a bluetooth device.
>
> ---
>
> Changes in v3:
> - Fix indentation of the adv_monitor_device_lost_callback() name and
>   it's arguments.
>
> Changes in v2:
> - Update function name adv_monitor_tracking_callback() to
>   adv_monitor_device_lost_callback() as it will receive only Device Lost
>   event.
>
>  src/adv_monitor.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index 715ac5904..385ab26e6 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -1531,6 +1531,27 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
>                 ev->monitor_handle);
>  }
>
> +/* Processes Adv Monitor tracking event from kernel */
> +static void adv_monitor_device_lost_callback(uint16_t index, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       struct btd_adv_monitor_manager *manager = user_data;
> +       const struct mgmt_ev_adv_monitor_device_lost *ev = param;
> +       uint16_t handle = le16_to_cpu(ev->monitor_handle);
> +       const uint16_t adapter_id = manager->adapter_id;
> +       char addr[18];
> +
> +       if (length < sizeof(*ev)) {
> +               btd_error(adapter_id,
> +                               "Wrong size of Adv Monitor Device Lost event");
> +               return;
> +       }
> +
> +       ba2str(&ev->addr.bdaddr, addr);
> +       DBG("Adv monitor with handle 0x%04x stopped tracking the device %s",
> +                       handle, addr);

Isn't there a DeviceLost in the AdvertisementMonitor1 interface?
Otherwise this is quite pointless since the only thing it is doing is
printing the event without taking any action.

> +}
> +
>  /* Allocates a manager object */
>  static struct btd_adv_monitor_manager *manager_new(
>                                                 struct btd_adapter *adapter,
> @@ -1555,6 +1576,10 @@ static struct btd_adv_monitor_manager *manager_new(
>                         manager->adapter_id, adv_monitor_removed_callback,
>                         manager, NULL);
>
> +       mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_LOST,
> +                       manager->adapter_id, adv_monitor_device_lost_callback,
> +                       manager, NULL);
> +
>         return manager;
>  }
>
> --
> 2.33.0.882.g93a45727a2-goog
>


-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EAEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79157611ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhIUCXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbhIUBuD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Sep 2021 21:50:03 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3CC06AB07
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Sep 2021 14:54:47 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id 19so8936588uaf.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Sep 2021 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0siD6YC9m5v3wPV7R5V2WfjhWvoRPvMRqlDpTfEraw=;
        b=ORoHuh6Km3bgYDjraK0bAvDBIwkv/hIsbYFeHelRDd8m+YNOgJnChgbfu0yyvloKnY
         wOx66DeKcysoPSq/ZR18YM5R19fSvr/Nxdcu0iRaIWq6r158A7PKujEiDkJ9ee+mmATX
         G9XJpx200nraswR+NTEXLAiaa9n34Btn/JBRbiaLYNkj+6RpIo6cfdtAovB6hGSHyPux
         sGh0eIiaVX3tjEPgTKIMI+p+/Pm075AWcd4GcBPqMNXq7eqzygyhJWpITcD8J4ZdgKse
         Q48oy1I5mQvdFcnl50DsxSpbAOsMajy/XB3LUf4z3A6bq9F4CE1+gn+0+eDNUqrmDe/7
         D3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0siD6YC9m5v3wPV7R5V2WfjhWvoRPvMRqlDpTfEraw=;
        b=5jNDqkW2HH4kR/LzEGQVACYpk+Yj3q5PEN0PHWYX0cLNM6Ec+mUP5etdshAS2uTlzQ
         lKYgRUVXR42dMoTF75fFO/4DV/G4fkhwNLZj65iB1HQU2E4YPOBliJVWANkvKj028aPx
         esAeZ/DxafnRlCsKHNxrVrthr78BFFvuSdVpAAQmRSQulLTFPW/JrP7cnxI+XreGoTs2
         BqZav3jovrXOx6ElNuBzFPi0LJEC1t9UEoEUME514Vba4tZiqbkzqWC4FCJiATMlcDZy
         B22wtjSYelMg79rwMB2rovpW61jJNxCv7t2J//bJP3vuSjfR0YBRUhPmAFEOM3ZWILK0
         YLGA==
X-Gm-Message-State: AOAM530i2xABbRQmKBuG5piO5EihqmUaIiAwlkfyzLJ4oRMpjdyoPDBm
        htDty56h/1SIytBCUvaBpWAxnXJR+cnkHpwUx+s=
X-Google-Smtp-Source: ABdhPJxTyvQoSnNdJG0OVRfVIxaCyUuQGHcDZvBE9EkY1qG7Uzdji/4QmdEYlAWvnNSYYhH+n5fdPiv35HOE+BFNjGQ=
X-Received: by 2002:ab0:136c:: with SMTP id h41mr13481773uae.47.1632174886576;
 Mon, 20 Sep 2021 14:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210909190503.BlueZ.v2.1.Iae4b26a8036d47ca4d0db470f2bb23247f6cac7d@changeid>
 <CAGPPCLDpXtXfhMHp39ABmYB8=OduvJmR0VkN2nh9E8Sqg7V_gw@mail.gmail.com>
In-Reply-To: <CAGPPCLDpXtXfhMHp39ABmYB8=OduvJmR0VkN2nh9E8Sqg7V_gw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Sep 2021 14:54:35 -0700
Message-ID: <CABBYNZLMunjUB1MR8kGNDPjRxLSft7m5ujODkhssybOmNwbc3A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] adv_monitor: Clear any running DeviceLost timers
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

On Mon, Sep 20, 2021 at 8:53 AM Manish Mandlik <mmandlik@google.com> wrote:
>
> Friendly reminder to review this patch.
>
> Thanks,
> Manish.
>
>
> On Thu, Sep 9, 2021 at 7:05 PM Manish Mandlik <mmandlik@google.com> wrote:
>>
>> This patch clears any running Adv Monitor DeviceLost timers on bt power
>> down. It'll also invoke DeviceLost event if the device is already found
>> and is being tracked for the DeviceLost event.
>>
>> Verified this by adding a monitor using bluetoothctl and confirming that
>> the DeviceLost event is getting triggered for already found device in
>> case of bt power down.
>>
>> Reviewed-by: mcchou@google.com
>> ---
>>
>> Changes in v2:
>> - Removed the wrapper in adapter.c, updated the debug log.
>>
>>  src/adapter.c     |  2 ++
>>  src/adv_monitor.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>>  src/adv_monitor.h |  2 ++
>>  3 files changed, 55 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 84bc5a1b0..5ddc5eee6 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -2912,6 +2912,8 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>>                 len = sizeof(mode);
>>
>>                 if (!mode) {
>> +                       btd_adv_monitor_notify_power_down(
>> +                                       adapter->adv_monitor_manager);
>>                         clear_discoverable(adapter);
>>                         remove_temporary_devices(adapter);
>>                 }
>> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
>> index 715ac5904..39094c10d 100644
>> --- a/src/adv_monitor.c
>> +++ b/src/adv_monitor.c
>> @@ -2011,3 +2011,54 @@ static void adv_monitor_filter_rssi(struct adv_monitor *monitor,
>>                                             NULL);
>>         }
>>  }
>> +
>> +/* Clears running DeviceLost timer for a given device */
>> +static void clear_device_lost_timer(void *data, void *user_data)
>> +{
>> +       struct adv_monitor_device *dev = data;
>> +       struct adv_monitor *monitor = NULL;
>> +
>> +       if (dev->lost_timer) {
>> +               timeout_remove(dev->lost_timer);
>> +               dev->lost_timer = 0;
>> +
>> +               monitor = dev->monitor;
>> +
>> +               DBG("Calling DeviceLost() for device %p on Adv Monitor "
>> +                               "of owner %s at path %s", dev->device,
>> +                               monitor->app->owner, monitor->path);
>> +
>> +               g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
>> +                               report_device_state_setup,
>> +                               NULL, dev->device, NULL);
>> +       }
>> +}
>> +
>> +/* Clears running DeviceLost timers from each monitor */
>> +static void clear_lost_timers_from_monitor(void *data, void *user_data)
>> +{
>> +       struct adv_monitor *monitor = data;
>> +
>> +       queue_foreach(monitor->devices, clear_device_lost_timer, NULL);
>> +}
>> +
>> +/* Clears running DeviceLost timers from each app */
>> +static void clear_lost_timers_from_app(void *data, void *user_data)
>> +{
>> +       struct adv_monitor_app *app = data;
>> +
>> +       queue_foreach(app->monitors, clear_lost_timers_from_monitor, NULL);
>> +}
>> +
>> +/* Handles bt power down scenario */
>> +void btd_adv_monitor_notify_power_down(struct btd_adv_monitor_manager *manager)
>> +{
>> +       if (!manager) {
>> +               error("Unexpected NULL btd_adv_monitor_manager object upon "
>> +                               "power down");
>> +               return;
>> +       }
>> +
>> +       /* Clear any running DeviceLost timers in case of power down */
>> +       queue_foreach(manager->apps, clear_lost_timers_from_app, NULL);
>> +}
>> diff --git a/src/adv_monitor.h b/src/adv_monitor.h
>> index 2b4f68abf..20da012d4 100644
>> --- a/src/adv_monitor.h
>> +++ b/src/adv_monitor.h
>> @@ -38,4 +38,6 @@ void btd_adv_monitor_notify_monitors(struct btd_adv_monitor_manager *manager,
>>  void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
>>                                    struct btd_device *device);
>>
>> +void btd_adv_monitor_notify_power_down(struct btd_adv_monitor_manager *manager);
>> +
>>  #endif /* __ADV_MONITOR_H */
>> --
>> 2.33.0.309.g3052b89438-goog
>>

It has already been pushed some 10 days ago:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=cec1ef63ff3f74d98c9fa6b480c7416726927870


-- 
Luiz Augusto von Dentz

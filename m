Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED3BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 00:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiCVAui (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiCVAuh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 20:50:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D7E2FFFB
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 17:49:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2e612af95e3so62955627b3.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 17:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qkH69KN1TwhUo9RFr/dTkj/kI4KCK+uS3B4wUco7aA=;
        b=DvYurA+i6k7emLC7l+rWoHeQlikWzpr3fQoox/nBIIJNnT6vzrATavIPjNdiFCu11H
         STSmZvcv1+QOkwcfmAZBzqvjNPoWiq5DDASwdv1jmm1TAKyl86ySmXzfy3d49afj6bkY
         7qQZsYKZAsTKwQciagK/ZNOBjFqO4LaaiXHEh5jkH4VBXy6VBJ8dN4D1UWC6VA79NJWC
         fJPh543zKW4BRqMcWfp8rSIHnJih4Bpe+ShCQ/FeqriCycesX+NmXM74aCyving0vzgO
         cDnHG+6FJZBgV2mWrKXVGe/j0Pe9knC4VwamGG6mbkS4B4uMZdAl0MxDn3qzoOBR/aYK
         oyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qkH69KN1TwhUo9RFr/dTkj/kI4KCK+uS3B4wUco7aA=;
        b=j96VdODDdSxx/anDUOwgs4vcj3pbo7pn6gl13iFO1H+DCQKWxydzJfI9KXTAyrLoIn
         hmvV7BbtArBEKXzwvMrVU/O7+/Wq+/n8So/aWRlINolI5eqldvbUtkDvfiFOmyIJbkjh
         yul06f7YpoLIR+CenLcXZtdRBcPoo1bRn/JfWB/yKL8S7IGZ+nAgx2TdgFFrQ37xqwoF
         6ysOO12ceHgdSBGmuSeA6B0AR9F2eEKEEnYmpOxQvg4RYamCUpTWkfkZ4rkLDdFXVLcp
         2xRpO8fzce5HwN5X9noM1CRIa1Ie27TGursvx+OqMdihX5s0mHn6wQLI8PTk8h8nSWQw
         K9dg==
X-Gm-Message-State: AOAM531g3ZP6MlMMFYZl6AJ6u/3DOkmBD3s+qWL6eE4LZ1NaMhA+3F5B
        Q833j9OflZvP+uaBA7eprRX7RTX+5uIrVkYnKo+qywU6
X-Google-Smtp-Source: ABdhPJxO6yWO7akXIqa0C6WMFnENKg0RyzC0F4/vXx6wka3OFfT2iOH6BJ1QEm4/r+LIzV20UwYrfXjy1Z0vBk+f3JM=
X-Received: by 2002:a0d:d84f:0:b0:2e5:f8f1:7272 with SMTP id
 a76-20020a0dd84f000000b002e5f8f17272mr14526541ywe.376.1647910148794; Mon, 21
 Mar 2022 17:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
 <20220320183445.BlueZ.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
In-Reply-To: <20220320183445.BlueZ.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Mar 2022 17:48:57 -0700
Message-ID: <CABBYNZJFZO=sdgenn0xjwQ2b4Qxf-DGY4f+4pYiU7k2-4=zW=w@mail.gmail.com>
Subject: Re: [BlueZ PATCH 7/9] adv_monitor: Add the monitor Release reason
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Sun, Mar 20, 2022 at 6:37 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Adv Monitor is released for various reasons. For example, incorrect RSSI
> parameters, incorrect monitor type, non-overlapping RSSI thresholds,
> etc.
>
> Return this release reason along with the Release event for the better
> visibility to clients.

Shouldn't this be sent as a reply to the method registering the monitor?

> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
>  doc/advertisement-monitor-api.txt | 12 ++++++-
>  src/adv_monitor.c                 | 56 ++++++++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
> index 942d44b2f..fcbd9c5c2 100644
> --- a/doc/advertisement-monitor-api.txt
> +++ b/doc/advertisement-monitor-api.txt
> @@ -17,12 +17,22 @@ Service             org.bluez
>  Interface      org.bluez.AdvertisementMonitor1 [experimental]
>  Object path    freely definable
>
> -Methods                void Release() [noreply]
> +Methods                void Release(Int8 reason) [noreply]
>
>                         This gets called as a signal for a client to perform
>                         clean-up when (1)a monitor cannot be activated after it
>                         was exposed or (2)a monitor has been deactivated.
>
> +                       Possible reasons:  0  Unknown reason
> +                                          1  Invalid monitor type
> +                                          2  Invalid RSSI parameter(s)
> +                                          3  Invalid pattern(s)
> +                                          4  Monitor already exists
> +                                          5  Kernel failed to add monitor
> +                                          6  Kernel failed to remove monitor
> +                                          7  Monitor removed by kernel
> +                                          8  App unregistered/destroyed
> +
>                 void Activate() [noreply]
>
>                         After a monitor was exposed, this gets called as a
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index 85231557e..6ee3736d2 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -90,6 +90,18 @@ enum monitor_state {
>         MONITOR_STATE_RELEASED, /* Dbus Object removed by app */
>  };
>
> +enum monitor_release_reason {
> +       REASON_UNKNOWN,
> +       REASON_INVALID_TYPE,
> +       REASON_INVALID_RSSI_PARAMS,
> +       REASON_INVALID_PATTERNS,
> +       REASON_ALREADY_EXISTS,
> +       REASON_FAILED_TO_ADD,
> +       REASON_FAILED_TO_REMOVE,
> +       REASON_REMOVED_BY_KERNEL,
> +       REASON_APP_DESTROYED,
> +};
> +
>  enum merged_pattern_state {
>         MERGED_PATTERN_STATE_ADDING,    /* Adding pattern to kernel */
>         MERGED_PATTERN_STATE_REMOVING,  /* Removing pattern from kernel */
> @@ -113,6 +125,7 @@ struct adv_monitor {
>         char *path;
>
>         enum monitor_state state;       /* MONITOR_STATE_* */
> +       enum monitor_release_reason release_reason;
>
>         struct rssi_parameters rssi;    /* RSSI parameter for this monitor */
>         struct adv_monitor_merged_pattern *merged_pattern;
> @@ -137,6 +150,7 @@ struct adv_monitor_merged_pattern {
>         struct queue *patterns;         /* List of bt_ad_pattern objects */
>         enum merged_pattern_state current_state; /* MERGED_PATTERN_STATE_* */
>         enum merged_pattern_state next_state;    /* MERGED_PATTERN_STATE_* */
> +       enum monitor_release_reason release_reason;
>  };
>
>  /* Some data like last_seen, timer/timeout values need to be maintained
> @@ -541,6 +555,18 @@ static void monitor_free(struct adv_monitor *monitor)
>         free(monitor);
>  }
>
> +/* Includes monitor release reason into the dbus message */
> +static void report_release_reason_setup(DBusMessageIter *iter, void *user_data)
> +{
> +       const struct adv_monitor *monitor = user_data;
> +       int8_t release_reason = REASON_UNKNOWN;
> +
> +       if (monitor)
> +               release_reason = monitor->release_reason;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &release_reason);
> +}
> +
>  /* Calls Release() method of the remote Adv Monitor */
>  static void monitor_release(struct adv_monitor *monitor)
>  {
> @@ -560,8 +586,9 @@ static void monitor_release(struct adv_monitor *monitor)
>         DBG("Calling Release() on Adv Monitor of owner %s at path %s",
>                 monitor->app->owner, monitor->path);
>
> -       g_dbus_proxy_method_call(monitor->proxy, "Release", NULL, NULL, NULL,
> -                                       NULL);
> +       g_dbus_proxy_method_call(monitor->proxy, "Release",
> +                                       report_release_reason_setup, NULL,
> +                                       monitor, NULL);
>  }
>
>  /* Removes monitor from the merged_pattern. This would result in removing it
> @@ -635,13 +662,20 @@ static void monitor_destroy(void *data)
>  static void app_destroy(void *data)
>  {
>         struct adv_monitor_app *app = data;
> +       const struct queue_entry *e;
>
>         if (!app)
>                 return;
>
>         DBG("Destroy Adv Monitor app %s at path %s", app->owner, app->path);
>
> -       queue_destroy(app->monitors, monitor_destroy);
> +       for (e = queue_get_entries(app->monitors); e; e = e->next) {
> +               struct adv_monitor *m = e->data;
> +
> +               m->release_reason = REASON_APP_DESTROYED;
> +               monitor_destroy(m);
> +       }
> +       queue_destroy(app->monitors, NULL);
>
>         if (app->reg) {
>                 app_reply_msg(app, btd_error_failed(app->reg,
> @@ -793,6 +827,7 @@ static bool parse_monitor_type(struct adv_monitor *monitor, const char *path)
>         }
>
>  failed:
> +       monitor->release_reason = REASON_INVALID_TYPE;
>         btd_error(adapter_id,
>                         "Invalid argument of property Type of the Adv Monitor "
>                         "at path %s", path);
> @@ -919,6 +954,7 @@ done:
>         return true;
>
>  failed:
> +       monitor->release_reason = REASON_INVALID_RSSI_PARAMS;
>         btd_error(adapter_id,
>                         "Invalid argument of RSSI thresholds and timeouts "
>                         "of the Adv Monitor at path %s",
> @@ -1005,6 +1041,7 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
>         return true;
>
>  failed:
> +       monitor->release_reason = REASON_INVALID_PATTERNS;
>         btd_error(adapter_id, "Invalid argument of property Patterns of the "
>                         "Adv Monitor at path %s", path);
>
> @@ -1053,6 +1090,7 @@ static void merged_pattern_destroy_monitors(
>                 struct adv_monitor *monitor = e->data;
>
>                 monitor->merged_pattern = NULL;
> +               monitor->release_reason = merged_pattern->release_reason;
>                 monitor_destroy(monitor);
>         }
>  }
> @@ -1086,6 +1124,7 @@ static void remove_adv_monitor_cb(uint8_t status, uint16_t length,
>         return;
>
>  fail:
> +       merged_pattern->release_reason = REASON_FAILED_TO_REMOVE;
>         merged_pattern_destroy_monitors(merged_pattern);
>         merged_pattern_free(merged_pattern);
>  }
> @@ -1142,6 +1181,7 @@ static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
>         return;
>
>  fail:
> +       merged_pattern->release_reason = REASON_FAILED_TO_ADD;
>         merged_pattern_destroy_monitors(merged_pattern);
>         merged_pattern_free(merged_pattern);
>  }
> @@ -1285,6 +1325,7 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
>                 merged_pattern_add(monitor->merged_pattern);
>         } else {
>                 if (!merge_is_possible(existing_pattern, monitor)) {
> +                       monitor->release_reason = REASON_ALREADY_EXISTS;
>                         monitor_destroy(monitor);
>                         DBG("Adv Monitor at path %s released due to existing "
>                                 "monitor", path);
> @@ -1551,6 +1592,7 @@ static void remove_merged_pattern(void *data, void *user_data)
>  {
>         struct adv_monitor_merged_pattern *merged_pattern = data;
>         uint16_t *handle = user_data;
> +       const struct queue_entry *e;
>
>         if (!handle)
>                 return;
> @@ -1562,8 +1604,14 @@ static void remove_merged_pattern(void *data, void *user_data)
>         DBG("Adv monitor with handle:0x%04x removed by kernel",
>                 merged_pattern->monitor_handle);
>
> +       for (e = queue_get_entries(merged_pattern->monitors); e; e = e->next) {
> +               struct adv_monitor *m = e->data;
> +
> +               m->release_reason = REASON_REMOVED_BY_KERNEL;
> +               monitor_destroy(m);
> +       }
>         queue_foreach(merged_pattern->monitors, monitor_state_removed, NULL);
> -       queue_destroy(merged_pattern->monitors, monitor_destroy);
> +       queue_destroy(merged_pattern->monitors, NULL);
>         merged_pattern_free(merged_pattern);
>  }
>
> --
> 2.35.1.894.gb6a874cedc-goog
>


-- 
Luiz Augusto von Dentz

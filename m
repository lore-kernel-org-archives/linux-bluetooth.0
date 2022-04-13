Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 21:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiDMVvE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiDMVvD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 17:51:03 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A1047569
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 14:48:41 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ebd70a4cf5so37394467b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCTIA0vlYQm7d6dJFt0QM83f5uECBKD9dzUr51cr2ws=;
        b=ZTs1kjkE0rtHL9rDezxOGi4p8LwsDJ6md4ai8vy2p5c8iA3NpRkji3DrSqKyLHFByj
         R0IvK3ILiyRc8DMJLV4cPcyJWNhSX91Z3f+VJ4MKja90CaaZcSN+/bnf2dRuWgsE7pUx
         5lh0qVHpqB1B8TGuwkWOOcP8n8j3mlf3ON1HIRc9yVgzgsemOFy3rYpEEP4UEAqe7nWn
         OkWS+fEIWdGvwOG3Ve0yW7AuC92uWcJcD4i9wjC4xX2OWttdGZAmLi1TgB4SiQzCM44K
         rLssoJ6cSoIV0Dg2ERK1A2pFR0eK0LhXzmnFhxDunGO4rMEEyOPDj+VYqvJakcbgeMB9
         ppPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCTIA0vlYQm7d6dJFt0QM83f5uECBKD9dzUr51cr2ws=;
        b=xwWQiluQbSRVX49s9cEOQdaB9v5/0mZP/Au4rY3VYhvQRQ6aMVVvtNCEJGO1UjeRQk
         l1m38wi2z7cBZSZ9+WxPz2Gw9UUMGr3JxG9TS9nQ5ELsSIsumeEfgaYF+JzsTt9DJqdJ
         FE0Y789e8Cl+tPNuWYsY3f7ED8Ho0lAwrNycIxBlJ+e1bRCYwzCTz+AQgDVWr5kUCvnU
         N5taqqjXctLLjJBG8LtKyhg/GTDHalPoJsaR8qFbX3D7VkMdnsWEDrFtF7XFRiqkpAQX
         Er7KiLWhcb1mnHInRWqb2UtL7LL8HNhnHGhBNXgO27gHI3H/PZrKdudALAhOFcau9xc0
         hYiw==
X-Gm-Message-State: AOAM530UTjvtnfIOyUskj4loVdeSGUDf5hAp/uWSix/ccMd0fNf9b36V
        TptfY4mUz77WToW7gxtRk0Fj+cjDaqLoPK/t5G4=
X-Google-Smtp-Source: ABdhPJx0QDgsrpj6uYXmC0c5/ZArP+Gl3R3aKMSxXb4JZZSmnJD1ip4nBM6SrYYuHnJaNuyUcVYk8KE6GCQzua54vlQ=
X-Received: by 2002:a81:4987:0:b0:2ec:4986:eeb4 with SMTP id
 w129-20020a814987000000b002ec4986eeb4mr926185ywa.150.1649886520191; Wed, 13
 Apr 2022 14:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
 <20220413135223.BlueZ.v2.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
In-Reply-To: <20220413135223.BlueZ.v2.7.I668ef2477efd8fcdd9c44975c5f7b9f32af966ca@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Apr 2022 14:48:29 -0700
Message-ID: <CABBYNZL3Jd_Er8C_NNoZ2GaRwH3KpzqhhED4kKLbrr+na6KXJQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 7/9] adv_monitor: Add the monitor Release reason
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

On Wed, Apr 13, 2022 at 1:55 PM Manish Mandlik <mmandlik@google.com> wrote:
>
> Adv Monitor is released for various reasons. For example, incorrect RSSI
> parameters, incorrect monitor type, non-overlapping RSSI thresholds,
> etc.
>
> Return this release reason along with the Release event for the better
> visibility to clients.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> (no changes since v1)
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

I don't really like this, this is only really useful for debugging but
once the code is stable it becomes pretty useless because the likes of
btmon would already collect errors from bluetoothd so you can already
debug with that, instead this just enables debugging on the
application layer but I don't see how it would help to recover anyway
so given this back to the user is probably a bad idea. Btw if you have
an App unregistered/destroyed the daemon most likely won't be able to
reach the object, so I wonder what is it for?

>                 void Activate() [noreply]
>
>                         After a monitor was exposed, this gets called as a
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index d88e1bbbb..9e67d984b 100644
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
> 2.36.0.rc0.470.gd361397f0d-goog
>


-- 
Luiz Augusto von Dentz

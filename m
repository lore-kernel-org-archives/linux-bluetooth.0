Return-Path: <SRS0=eST2=AT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87CEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B2420739
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jul 2020 21:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rarHCj3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgGHVOu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGHVOu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jul 2020 17:14:50 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128BCC061A0B
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2020 14:14:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a21so186235otq.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2020 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8uXdX1ijQUFjAgU9Yg2R5ixp4s5oGR8LBnzH9CAzck=;
        b=rarHCj3WpsfYgsOnwhLlgUOtEbVV9t4cJkkn5f/NQHrnhzyu1SkP0ExKY7j/KehSNW
         5+g/CitpqpuxmWutNiXyMbxHxTuYe4bL7kI9RuuGq9ceFA3XlKDJy7bTrY5s++fygn4m
         SmYYUjrtgfxJNasLhGfjWKxYWi9DA8qPFpyJMO6Mmy5rpiagsVwi4FunpGKiW2UcDi4U
         o7kNWtkNdsHR3snP+OQghcXBpl09N/OkewLlMW9H78Uo6mv9PdoHMXXW9IOe8Ph8+GQa
         NswQkBpKeA3n2k0lN6mkxq/B2UKtjpye/3mPiLxnnlQg/3JWFaouPIp691usHgwVVjoF
         oUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8uXdX1ijQUFjAgU9Yg2R5ixp4s5oGR8LBnzH9CAzck=;
        b=Uh4QlDCiAYULSXgyRKK40/9tMOVMKjltGvTKSIU27e56m2dkjZs2oNL1jqDu2kPerF
         vGK+1zc+h6BrmRcFTqd3INOyHfKq37gMZSs+3k+c2fUZ09YgmrYPUYGOheCQgj85QuAl
         9A2yaJdl/enQUCy21s0XXQtRLHXmI41zkCRLaJMP2PlHUqnoG/+ffj3IpRSEUBloA6W1
         rdpK9e6RZLthqcJLF/dSZ1Lb5sdozinkYWNXoDj1dR0mVgT0QVxhEgx/KjgWk3TcwBv2
         DmwdetiTIUSrwk3YHGgAUNgRMxZAOUYnRS/66dKlCZiZo9G9Sk/mgfwE5hV2dxNeMbXb
         MdBA==
X-Gm-Message-State: AOAM531lKayHclTpv2+qjokpI+sJc5mFnqG83ys0GVBSyl8eKNQKJL4x
        whf1kTuNcGZZZceMzhvj8Hd7E/D8lPXHRNcd/QrWWbOa
X-Google-Smtp-Source: ABdhPJwtGf50TB8UM41R1x+eyjgZXu8kHiZf7gnyiL29gVBaabjS0hHzGGB/lvAGzWRbYSdj4qracPozvkIT75hLres=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr48815673ota.91.1594242889325;
 Wed, 08 Jul 2020 14:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEQQxWxKs7ewwVyq4mnsyLbRhErQe9vZc5joNK6zfGSO3wN5bg@mail.gmail.com>
 <d9eca20059088ad8bdaac70d7d98811166839b27.camel@hadess.net> <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
In-Reply-To: <CAEQQxWyz-9iDU5Cs_NjHm81A6kdr0WUXPggp_2DTHeVVAQXUZQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 8 Jul 2020 14:14:37 -0700
Message-ID: <CABBYNZLzQH5ow02xB61d8pF7pcxXoP7Boa06G-HNxJ0Q66FGRg@mail.gmail.com>
Subject: Re: Temporary device removal during discovery
To:     Andrey Batyiev <batyiev@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Wed, Jul 8, 2020 at 8:56 AM Andrey Batyiev <batyiev@gmail.com> wrote:
>
> Hi Bastien, everyone,
>
> I've made a patch to the bluez, so the temporary devices are routinely
> purged based on their last_seen attribute.
>
> What do you think about such solution?
>
> Thanks,
>     Andrey
>
>
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 529002b02..101b03633 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -88,6 +88,7 @@
>
> #define CONN_SCAN_TIMEOUT (3)
> #define IDLE_DISCOV_TIMEOUT (5)
> +#define TEMP_DEV_REAPER_INTERVAL (30)
> #define TEMP_DEV_TIMEOUT (3 * 60)
> #define BONDING_TIMEOUT (2 * 60)
>
> @@ -1491,18 +1492,18 @@ static gboolean remove_temp_devices(gpointer user_data)
>
>        DBG("%s", adapter->path);
>
> -       adapter->temp_devices_timeout = 0;
> -
>        for (l = adapter->devices; l != NULL; l = next) {
>                struct btd_device *dev = l->data;
>
>                next = g_slist_next(l);
>
> -               if (device_is_temporary(dev) && !btd_device_is_connected(dev))
> +               if (device_is_temporary(dev) &&
> +                   !btd_device_is_connected(dev) &&
> +                   device_last_seen_delta(dev) > TEMP_DEV_TIMEOUT)

The delta logic might be a nice addition as a separate patch, it is
more for detecting devices disappearing then actually cleanup during
power off.

>                        btd_adapter_remove_device(adapter, dev);
>        }
>
> -       return FALSE;
> +       return TRUE;
> }
>
> static void discovery_cleanup(struct btd_adapter *adapter)
> @@ -1516,11 +1517,6 @@ static void discovery_cleanup(struct
> btd_adapter *adapter)
>                adapter->discovery_idle_timeout = 0;
>        }
>
> -       if (adapter->temp_devices_timeout > 0) {
> -               g_source_remove(adapter->temp_devices_timeout);
> -               adapter->temp_devices_timeout = 0;
> -       }
> -
>        g_slist_free_full(adapter->discovery_found,
>                                                invalidate_rssi_and_tx_power);
>        adapter->discovery_found = NULL;
> @@ -1536,9 +1532,6 @@ static void discovery_cleanup(struct btd_adapter *adapter)
>                if (device_is_temporary(dev) && !device_is_connectable(dev))
>                        btd_adapter_remove_device(adapter, dev);
>        }
> -
> -       adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
> -                                               remove_temp_devices, adapter);
> }
>
> static void discovery_free(void *user_data)
> @@ -2405,7 +2398,7 @@ static bool parse_pathloss(DBusMessageIter *value,
>        return true;
> }
>
> -static bool parse_transport(DBusMessageIter *value,
> +static bool parse_transport(DBusMessageIter *value,
>                                        struct discovery_filter *filter)
> {
>        char *transport_str;
> @@ -5362,6 +5355,11 @@ static void adapter_free(gpointer user_data)
>                adapter->passive_scan_timeout = 0;
>        }
>
> +       if (adapter->temp_devices_timeout > 0) {
> +               g_source_remove(adapter->temp_devices_timeout);
> +               adapter->temp_devices_timeout = 0;
> +       }
> +
>        if (adapter->load_ltks_timeout > 0)
>                g_source_remove(adapter->load_ltks_timeout);
>
> @@ -6343,6 +6341,9 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
>
>        adapter->auths = g_queue_new();
>
> +       adapter->temp_devices_timeout =
> g_timeout_add_seconds(TEMP_DEV_REAPER_INTERVAL,
> +                                               remove_temp_devices, adapter);
> +
>        return btd_adapter_ref(adapter);
> }
>
> diff --git a/src/device.c b/src/device.c
> index 0deee2707..cebbabab2 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4240,6 +4240,15 @@ void device_update_last_seen(struct btd_device
> *device, uint8_t bdaddr_type)
>                device->le_seen = time(NULL);
> }
>
> +time_t device_last_seen_delta(struct btd_device *device)
> +{
> +       const time_t now = time(NULL);
> +       const time_t bredr_time = now - device->bredr_seen;
> +       const time_t le_time = now - device->le_seen;
> +
> +       return bredr_time < le_time ? bredr_time : le_time;
> +}
> +
> /* It is possible that we have two device objects for the same device in
>  * case it has first been discovered over BR/EDR and has a private
>  * address when discovered over LE for the first time. In such a case we
> diff --git a/src/device.h b/src/device.h
> index cb8d884e8..75fd3ec60 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -44,6 +44,7 @@ void device_update_addr(struct btd_device *device,
> const bdaddr_t *bdaddr,
> void device_set_bredr_support(struct btd_device *device);
> void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type);
> void device_update_last_seen(struct btd_device *device, uint8_t bdaddr_type);
> +time_t device_last_seen_delta(struct btd_device *device);
> void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup);
> uint32_t btd_device_get_class(struct btd_device *device);
> uint16_t btd_device_get_vendor(struct btd_device *device);



-- 
Luiz Augusto von Dentz

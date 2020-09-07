Return-Path: <SRS0=Nonw=CQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84152C43461
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Sep 2020 02:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6372151B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Sep 2020 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxwG7PwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIGCjC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Sep 2020 22:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIGCjA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Sep 2020 22:39:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C74C061573
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2020 19:38:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so14140166wrs.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2020 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+9Hq78tnOIICkVeQNlHi/iq6rMPlgaPjzotk9Rd2Z4=;
        b=OxwG7PwXWIXAXOlyLg6Gt82MdXFXXxOmcq8AJgBW3HsWvj59NCOk7i/bd2znp4xrIy
         ASLqR0lIgAJtTS0c0ceQ+KpGjYjm9I5h7Mku36NhWlpBKCkAcGOlqr10hhQa8KyoFRUC
         3F/N2CzjHRebNlS3PY0GrGwsVvmHC18hRG+ouH12VrayAZZ92irr8u1aLvB+mhGxCjsT
         UOi7SfmHBFTUgEj8R1NSp/Eknj3baJMu8WCADV6iTn6OS4B3bfIZeoAdebEH2Tz/3kKe
         Wcodn5gsChZp9kgCD3XIKBDK+UCL7z3I2G9y2w/Lz9mTM39tmn1xHxc1hEn9EsQF8Whc
         VcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+9Hq78tnOIICkVeQNlHi/iq6rMPlgaPjzotk9Rd2Z4=;
        b=GS8fa7rpv7F1TnqXPowyC8ZF6rsqOYMkxa3Rb1Of/XwK0FtyyLYVf22mxa1+xA3WFA
         HtcYzBu/oasoeIf+pkLV/JYz/SrCwaLzTBV+qEbJPQx+boSjRC/boxDnYjuNRanltq41
         uX2HdvbbR3EjgYPtR/W3OoloacAmXWsWjmILZQJEFJzJwp3bZQ8SpecaIDWHsJgEzG2x
         cZPPrgUElkhvs0h0JlWNDoQIkzFi5gcdzCrcPb5N4sQMUK/vx8A1tYXOKgJrqAikgK/2
         Fz3NCH0eCdwsaobiIsSmMBd8GLp1xkp2hWe6csXAozEBdfGPT/fPfCFNOwEHuBgXlbrp
         YQag==
X-Gm-Message-State: AOAM531KRTaVRaQihNJWlhD1j0x3v9faFnhR2knCKbTOrZXhWt0NGGJD
        3k5RwNMl3qaOSV6jJBxk9hUVZ+bfHYOMyV4qDE2iCvkNfaM=
X-Google-Smtp-Source: ABdhPJx2EmPyd6UaFIgWzNeVfzcXqrJXBY36ubn9F8YZMLUp5IhGgMWyrOO09h2PqwQtG2NHzPs/EXH97cJCZ2tikRc=
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr20680994wrw.58.1599446337038;
 Sun, 06 Sep 2020 19:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200901113736.Bluez.v2.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
In-Reply-To: <20200901113736.Bluez.v2.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 7 Sep 2020 10:38:46 +0800
Message-ID: <CAJQfnxEopr6GzSsjbq4wQaWaw9QZDu_hmZMJF9_bS7i4nU5owQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] device: don't wait for timeout if RemoveDevice
 is called
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bluez maintainers,

Could you take another look at this patch?

Thanks,
Archie

On Tue, 1 Sep 2020 at 11:37, Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> RemoveDevice on adapter interface used to remove a device, even when
> the device is connected. However, since the introduction of the new
> 30 seconds timeout when setting a device as temporary, RemoveDevice
> doesn't immediately remove a connected device, but only disconnects
> it and waits for the timer to expire before effectively removes it.
>
> This patch removes the device as soon as it gets disconnected,
> provided the disconnection is triggered by a call to RemoveDevice.
> The regular timeout still applies for other cases.
>
> Tested manually by calling RemoveDevice on a connected device,
> and with ChromeOS autotest setup.
>
> Reviewed-by: Daniel Winkler <danielwinkler@google.com>
>
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> ---
>
> Changes in v2:
> * Rebasing to HEAD
>
>  src/adapter.c |  2 --
>  src/adapter.h |  2 ++
>  src/device.c  | 11 +++++++++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 1435e2bd7..ffd05aa0b 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -79,8 +79,6 @@
>  #include "advertising.h"
>  #include "eir.h"
>
> -#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> -
>  #define MODE_OFF               0x00
>  #define MODE_CONNECTABLE       0x01
>  #define MODE_DISCOVERABLE      0x02
> diff --git a/src/adapter.h b/src/adapter.h
> index f8ac20261..f835c984f 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -26,6 +26,8 @@
>  #include <dbus/dbus.h>
>  #include <glib.h>
>
> +#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> +
>  #define MAX_NAME_LENGTH                248
>
>  /* Invalid SSP passkey value used to indicate negative replies */
> diff --git a/src/device.c b/src/device.c
> index df440ce09..f20270017 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3007,6 +3007,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>  {
>         struct bearer_state *state = get_state(device, bdaddr_type);
>         DBusMessage *reply;
> +       bool remove_device = false;
>
>         if (!state->connected)
>                 return;
> @@ -3036,6 +3037,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>         while (device->disconnects) {
>                 DBusMessage *msg = device->disconnects->data;
>
> +               if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
> +                                                               "RemoveDevice"))
> +                       remove_device = true;
> +
>                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
>                 device->disconnects = g_slist_remove(device->disconnects, msg);
>                 dbus_message_unref(msg);
> @@ -3061,6 +3066,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>
>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connected");
> +
> +       if (remove_device)
> +               btd_adapter_remove_device(device->adapter, device);
>  }
>
>  guint device_add_disconnect_watch(struct btd_device *device,
> @@ -4477,6 +4485,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
>                 disconnect_all(device);
>         }
>
> +       if (device->temporary_timer > 0)
> +               g_source_remove(device->temporary_timer);
> +
>         if (device->store_id > 0) {
>                 g_source_remove(device->store_id);
>                 device->store_id = 0;
> --
> 2.28.0.402.g5ffc5be6b7-goog
>

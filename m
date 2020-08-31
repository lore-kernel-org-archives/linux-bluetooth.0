Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DCAC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E6320678
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlxgEndm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgHaRfq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHaRfp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 13:35:45 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CBDC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:35:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n23so6013646otq.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5VXzSpw3QdED1GgJDUjwLnGvGiM8SjQjH0TUfY3Ysc=;
        b=YlxgEndmh6kJiMlHMARt7f57E5pCD7FKzwAUcgEVAAgKWE2hXYXcPu+KK8mLJUQJH6
         9ouA/yf5vbhJoP8Km+c8pZB1g/a11gvlHRiab4VW7ZwpD3lF3ktb0w41g1YBw/kTmtjm
         yUjD5F1DK+5If+pxcyqvB8gO5wVCP5Xaqwa6NvEGw5JT52JQpDdjxLWjz4VYwrsQSIQm
         Ab/nqFdQ4puQLQS2WnYOwKebp2b1JZa1TMC359Z5ZFD5iA3Fv//1pZ9QssT9yj3kjqjO
         C7pD6N8FKlK0/pUST6RQIZ3WKvcacMufRoOQ0h6uyxSxvIq8jU9AdP4DYZwFDvGi+JVz
         L+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5VXzSpw3QdED1GgJDUjwLnGvGiM8SjQjH0TUfY3Ysc=;
        b=hJAP/K3h48pghN3M8QOyRko0w8Wa20dA4mqe9KG8YoPO7RRarUKCUf4EySX+IjYYod
         U3ZVW955IP3Cp/6cNMHgKB/nPtbLcFEg0WIqSIbjhY7GTqsEU7iOq0iD9sezVw5zgvme
         TgMT4ejuDtk9cbLONFQBevA6Vt1PUKWMw92DrkTC5Z5tN2+5Zm6GQ8WA+YXoqStN2z0Q
         x13o+UnzXS7Jn4eY9nZBwWOroOPa8PcoB8T5nP8ckCYvY/D5pNpmpt3g/DG719+n9AyB
         ZK/t6h7qapW4r2DGLgDVvTYKeHeT6CK/8x2a3KHzWA4ECrrfI0y2xmCvrwOdiJqqQxYJ
         C17A==
X-Gm-Message-State: AOAM530JK14HST5ckPdBPz25HetXXw0n6NnHRXmmnIctbYZtzoykmfSS
        fKMJlaS6qU8U09F9FasLsQMenzmM4AlneL0eo1A=
X-Google-Smtp-Source: ABdhPJzLO15tBkAivoQ6Z/upf1o7yj6nWEkEfAtB87tMBE701lCbJOQ8q7qlYtbuoVLieiEPTk5fqvHuWda3imEbKr8=
X-Received: by 2002:a9d:6053:: with SMTP id v19mr1576552otj.362.1598895344667;
 Mon, 31 Aug 2020 10:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200831161140.Bluez.v1.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
In-Reply-To: <20200831161140.Bluez.v1.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Aug 2020 10:35:34 -0700
Message-ID: <CABBYNZLTY_cFcttmMdiBH7PNU1xT2bw-eKnOQkHDak3+Y8WrXQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] device: don't wait for timeout if RemoveDevice
 is called
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Aug 31, 2020 at 1:12 AM Archie Pusaka <apusaka@google.com> wrote:
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
> ---
>
>  src/adapter.c |  2 --
>  src/adapter.h |  2 ++
>  src/device.c  | 11 +++++++++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..d6c65ff69 100644
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
> index bb8e07e8f..cee0ddfd2 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3001,6 +3001,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>  {
>         struct bearer_state *state = get_state(device, bdaddr_type);
> +       bool remove_device = false;
>
>         if (!state->connected)
>                 return;
> @@ -3018,6 +3019,10 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
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
> @@ -3043,6 +3048,9 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
>
>         g_dbus_emit_property_changed(dbus_conn, device->path,
>                                                 DEVICE_INTERFACE, "Connected");
> +
> +       if (remove_device)
> +               btd_adapter_remove_device(device->adapter, device);
>  }
>
>  guint device_add_disconnect_watch(struct btd_device *device,
> @@ -4457,6 +4465,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
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

Does not apply:

Applying: device: don't wait for timeout if RemoveDevice is called
error: patch failed: src/device.c:3001
error: src/device.c: patch does not apply



-- 
Luiz Augusto von Dentz

Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D70C43461
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 16:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C598920936
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUfXU1Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIOQ5H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgIOQwa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 12:52:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22778C061788
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 09:51:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c10so3848573otm.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZJ5c1oNq+PSxzLvAz6o8y4iFvnbqXrW0+p9q2WgnWU=;
        b=CUfXU1IkphycK6bsRwjflyuwE1/Em2IzPeqsbuVF34bcaPNQLzbGwk1mMZposk5ytP
         cBA1etA0WnkgscwRRK9xXLU+xokgCoukPb8T4/VF1Lo4e7F+7bAiTHh1Aje+uv3RRPpT
         qBEZ60QP2t8zg3JT92AFTllXyhW1FoKu6JmtS57M8OAv8aHQ7nf0ZjilA5Lc+DnZtKBq
         BSjDC2qrvPzURPONKJxdBgjGh21bTdmaAI6DosdUmCtIg/XpM7CRuOGgiTnHVxcgOyju
         vCwRSQJWU3tov7sYF6g6cNfsYB3unEEHyDJxMfS69xwS7wWwaQDBkZ2856ezU/PYujoi
         qJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZJ5c1oNq+PSxzLvAz6o8y4iFvnbqXrW0+p9q2WgnWU=;
        b=n+OCETZ+pU0ChlSJHVBxkd7K7hDjJ80GX2t9dTPfzBoymHNUSAUdQDD8GQBMKfFZmF
         eGDOsSsOZI0mOYc7FOgIwvkHfIH+tgphnFBIWndwjSwPkJXoq5/h7RwuGYsuxBKOFPzh
         ICorghw8EQwbRTdoFDooHaLBxatyV5iTnl1zbSUtnKILW1AwOKbfaIjpHaamJFqmFXU/
         9GAVH2FzXd+s94hjlD1/TLz0X+IHkKwvZZeflHTJSlgieudTYtli++ar9nD9aeqolglb
         dViFix3m2CxFGMBGlydWTGowVoRFqnHDP4li+h/QkWTF0sVl+EjCoDcqSf0dT11kpLe3
         vWQg==
X-Gm-Message-State: AOAM532l+MLuDU4ALHqU5LFiOHpvjquE1caGTG5alBNqD0v5jTnUImB6
        PeQxoB5bDyA2rRDfuKowXn40Wj1M0qcdCBrCil4=
X-Google-Smtp-Source: ABdhPJxhUHXJFxe9onWBC/pAzZbGIRjTdV/gF/IjfEU8TbaxsJC9Ub+nrOO8pPWuR3iCqcpP49s9nZooE8buK3ToCFE=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr5439144otd.362.1600188683403;
 Tue, 15 Sep 2020 09:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200915110347.Bluez.v3.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
In-Reply-To: <20200915110347.Bluez.v3.1.If16fd16b4a629ec4d4093a974256225a95b58044@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Sep 2020 09:51:12 -0700
Message-ID: <CABBYNZKQhnQDaTQ_e-FA6hCEW5ZChaOdOQ-qCx3gpQXSPBD29g@mail.gmail.com>
Subject: Re: [Bluez PATCH v3] device: don't wait for timeout if RemoveDevice
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

On Mon, Sep 14, 2020 at 8:04 PM Archie Pusaka <apusaka@google.com> wrote:
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
> Changes in v3:
> * Rebasing again
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
> index df628a7fd..4e27bd74b 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -80,8 +80,6 @@
>  #include "adv_monitor.h"
>  #include "eir.h"
>
> -#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> -
>  #define MODE_OFF               0x00
>  #define MODE_CONNECTABLE       0x01
>  #define MODE_DISCOVERABLE      0x02
> diff --git a/src/adapter.h b/src/adapter.h
> index c70a7b0da..2f1e4b737 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -29,6 +29,8 @@
>  #include <lib/bluetooth.h>
>  #include <lib/sdp.h>
>
> +#define ADAPTER_INTERFACE      "org.bluez.Adapter1"
> +
>  #define MAX_NAME_LENGTH                248
>
>  /* Invalid SSP passkey value used to indicate negative replies */
> diff --git a/src/device.c b/src/device.c
> index 8f73ce4d3..3e7784034 100644
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
> @@ -4482,6 +4490,9 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
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
> 2.28.0.618.gf4bc123cb7-goog
>

Applied, thanks.

-- 
Luiz Augusto von Dentz

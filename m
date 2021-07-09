Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC431C07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 05:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C137E6142D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 05:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhGIFhY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 01:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIFhY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 01:37:24 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE62C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jul 2021 22:34:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g5so12760886ybu.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jul 2021 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsUwRfst3BdsQPWHqc2pouUGcSHokUcyHHVK26nXUsc=;
        b=iaZpRHZv9gDSTo4wfsnb0NfYGwBtu/tpWJu1QLLs2IbrCOpg5fnVJy7jKRN7LpMbsc
         R4cMW77VXaHQTQzenCdJwHvaksY+jKSHWgNrJvH2z+MREwcdlYhYdxOYNDSrERrZuRFn
         mPL1TMGJnwg8IHLyYQnljF2vakeBqQya20g7E+Zc3AFKG3E7i7AGaNE3GJXSF+3iub7g
         XZbOOhVaAHFM7Y13f+MHp1e8bZqfPa/0cHkU0NgzsI/EC4J1sKLn01Da1iaIMVe2Tdru
         Sh8MjMFics2FWjeuFvV4/B9ccG96HZbb/j+fX0wWuy3Z173JKSQDQa8wAc2K0BJ0kPoI
         DOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsUwRfst3BdsQPWHqc2pouUGcSHokUcyHHVK26nXUsc=;
        b=U7yNHQ+gam0LeeUl2ksDr5uFjHHZS12c9IzFGW04fxKHGq8M9UXxrDBSIo2LK3NxXy
         eolF+oVC9b07qZpRcVwoLru+BBVFuih0a2LWltGxAlnUdVO0F4atPskemLlA0i0dmcqR
         Q4tjynhjFrKs25eSJLgVIpiVtkmYfVlKJdPaWgA/9GIHQuthpFUeZvRPz0S5SDg8VgFI
         EDF5WRhTsg1dK4/xh3TMISHXGp4Zk0C7wkTaH/zaPbJcyszUEuXAlPtbGHIL6/h3dNBs
         dRaXy/i0pw45nHiuA1AE1/qWghA12yT3q+YH2oHTYGudtShaPOglYLrtmG4fEzzO1JPT
         kwdQ==
X-Gm-Message-State: AOAM533PjYAoEGYlmpXd5iuxsEG70IKyvYn9UQCY2naDD71919OsDJxm
        a/IB2w1yvSjUwRZ2V5h15FnEdrd9W17nMX5l8pI=
X-Google-Smtp-Source: ABdhPJzGn55bJHKrqAElFb22XHMRW99AujGknb319yFA8NSB0uuVv7z9VM+4DhrleyuTieDH0RtCuKO+IxiHNg23aFQ=
X-Received: by 2002:a25:8205:: with SMTP id q5mr44076316ybk.440.1625808879297;
 Thu, 08 Jul 2021 22:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com> <20210708142059.Bluez.v1.5.I699a3837a5a18d9f889635300f6c717879f19dd2@changeid>
In-Reply-To: <20210708142059.Bluez.v1.5.I699a3837a5a18d9f889635300f6c717879f19dd2@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Jul 2021 22:34:28 -0700
Message-ID: <CABBYNZJie9UMrvLkdPPX1rU-7PXy0YHy9DJTrCAikaB_djx4uw@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 05/14] core: add device state and state callbacks
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This implements functions to register/unregister state changed callback
> functions, the functions will be called when a device's state changed.
> Currently the state only shows initializing, available and removing,
> which is enough for plugins to register dbus objects upon device
> creation and unregister it upon device removal.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
>  src/device.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h | 13 +++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index e1d82eab0988..0d7444706336 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -81,6 +81,13 @@
>
>  static DBusConnection *dbus_conn = NULL;
>  static unsigned service_state_cb_id;
> +static GSList *device_state_callbacks;

Use a struct queue instead of GSList.

> +
> +struct device_state_callback {
> +       btd_device_state_cb     cb;
> +       void                    *user_data;
> +       unsigned int            id;
> +};
>
>  struct btd_disconnect_data {
>         guint id;
> @@ -272,6 +279,8 @@ struct btd_device {
>
>         GIOChannel      *att_io;
>         guint           store_id;
> +
> +       enum btd_device_state_t state;
>  };
>
>  static const uint16_t uuid_list[] = {
> @@ -4095,6 +4104,23 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
>         gatt_services_changed(device);
>  }
>
> +static void device_change_state(struct btd_device *device,
> +                                       enum btd_device_state_t new_state)
> +{
> +       GSList *l;
> +       struct device_state_callback *cb_data;
> +
> +       if (device->state == new_state)
> +               return;
> +
> +       for (l = device_state_callbacks; l != NULL; l = g_slist_next(l)) {
> +               cb_data = l->data;
> +               cb_data->cb(device, new_state, cb_data->user_data);
> +       }
> +
> +       device->state = new_state;
> +}
> +
>  static struct btd_device *device_new(struct btd_adapter *adapter,
>                                 const char *address)
>  {
> @@ -4158,6 +4184,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
>
>         device->refresh_discovery = btd_opts.refresh_discovery;
>
> +       device_change_state(device, BTD_DEVICE_STATE_AVAILABLE);
> +
>         return btd_device_ref(device);
>  }
>
> @@ -6839,6 +6867,7 @@ void btd_device_unref(struct btd_device *device)
>
>         DBG("Freeing device %s", device->path);
>
> +       device_change_state(device, BTD_DEVICE_STATE_REMOVING);
>         g_dbus_unregister_interface(dbus_conn, device->path, DEVICE_INTERFACE);
>  }
>
> @@ -6980,3 +7009,38 @@ void btd_device_cleanup(void)
>  {
>         btd_service_remove_state_cb(service_state_cb_id);
>  }
> +
> +unsigned int btd_device_add_state_cb(btd_device_state_cb cb, void *user_data)
> +{
> +       struct device_state_callback *cb_data;
> +       static unsigned int id;
> +
> +       cb_data = g_new0(struct device_state_callback, 1);
> +       cb_data->cb = cb;
> +       cb_data->user_data = user_data;
> +       cb_data->id = ++id;
> +
> +       device_state_callbacks = g_slist_append(device_state_callbacks,
> +                                                               cb_data);
> +
> +       return cb_data->id;
> +}
> +
> +bool btd_device_remove_state_cb(unsigned int id)
> +{
> +       GSList *l;
> +
> +       for (l = device_state_callbacks; l != NULL; l = g_slist_next(l)) {
> +               struct device_state_callback *cb_data = l->data;
> +
> +               if (cb_data && cb_data->id == id) {
> +                       device_state_callbacks = g_slist_remove(
> +                                                       device_state_callbacks,
> +                                                       cb_data);
> +                       g_free(cb_data);
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> diff --git a/src/device.h b/src/device.h
> index 5f615cb4b6b2..a8424aa4f098 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -11,8 +11,18 @@
>
>  #define DEVICE_INTERFACE       "org.bluez.Device1"
>
> +enum btd_device_state_t {
> +       BTD_DEVICE_STATE_INITIALIZING,  /* Device object is creating */
> +       BTD_DEVICE_STATE_AVAILABLE,     /* Device object is registered */
> +       BTD_DEVICE_STATE_REMOVING,      /* Device object is being removed */
> +};

I got a bad feeling about adding this sort of state, are you trying to
cover some use case that we can't do with btd_service_add_state_cb? It
does seem a lot like it but at device level.

> +
>  struct btd_device;
>
> +typedef void (*btd_device_state_cb) (struct btd_device *device,
> +                                       enum btd_device_state_t new_state,
> +                                       void *user_data);
> +
>  struct btd_device *device_create(struct btd_adapter *adapter,
>                                 const bdaddr_t *address, uint8_t bdaddr_type);
>  struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
> @@ -179,3 +189,6 @@ bool btd_device_all_services_allowed(struct btd_device *dev);
>  void btd_device_update_allowed_services(struct btd_device *dev);
>  void btd_device_init(void);
>  void btd_device_cleanup(void);
> +
> +unsigned int btd_device_add_state_cb(btd_device_state_cb cb, void *user_data);
> +bool btd_device_remove_state_cb(unsigned int id);
> --
> 2.32.0.93.g670b81a890-goog
>


-- 
Luiz Augusto von Dentz

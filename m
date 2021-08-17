Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA130C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30F660EB5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhHQX0g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 19:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhHQX0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 19:26:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D08DC0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:26:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z128so1533049ybc.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoT/B4nt60xDUAc0N33clEpKq4w4/5IIyE/m6aRf/Ms=;
        b=Hf2qMqDOxtyk6bmIrxdbsVjN170gDGJpBbLG8pQjwF3J4JV3yU9Zw3/9ttERzbBoCt
         Sm3D/JIg5zWZTrDaYq8HjNKxNKR3P7mQBJvd9ALNjrtdV1NNIVLsHwXjYraZrwl66XNQ
         VV2qSNuARDN1hcCuWtEi4sfQNRD+IZwWh70v837tiKpC4MRjNW9kOBeqa2ceCDFU/3OG
         ts1IC96HO2b81ZZrprLsYR3otK/0yMw6fGjEsgymetrzrubAh8lNHq8KTVnvbfUkfYxM
         p/ObVqpkd83cJXzgg17j1wSQ2jgzTcbYsoIwcpXSHYAe6/x6KXPnzSmz/XlbtKdW6YOJ
         5iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoT/B4nt60xDUAc0N33clEpKq4w4/5IIyE/m6aRf/Ms=;
        b=G9QGvbePjVc3+TO9c2V+9fK2AsX9T0h5NKTCrJUNOi8mivyvtVmyV/YLReP6PYPYQP
         36d2qhsgxFknkp9JKzGGFatXBBEgdgW9RqFToeOFuefa4NK/wwoYEAUVh+/aiUuObRHu
         IopDbenqaEYs5Xti7GLPyy8mmyEQGc0d+WLTXrO7ELehZFOIslVE43jxQAly6XYopGBw
         5EJPBMmj1PzDvfU/WVBsTCe+bV/clzgpZzK5cB0APDwy7aJ0L1nvsRY5x0u155Ifmyoo
         qxg0cyGHg/c1vD+3PO1mya1rl3/dceOYBqQjvNYXHInb2/MkHn/VpNms+Wz7re8tXts1
         AraA==
X-Gm-Message-State: AOAM533t3KWL0IMs06RmLVNwleHT3kXwYI2Z0dPHPzAQc85NN8pAYP0e
        WdXmgRExin6sBkubxHfLEqloYbD2USchfy599qX7N7Df
X-Google-Smtp-Source: ABdhPJwdlvQaXHEkFqxkuW7FJ7EZZDHvHDQuN+V6Zc3bgs1NN2I2YO7l5unNwEXW9IaBBCWnjNrgsiY9kD92UHy318Y=
X-Received: by 2002:a25:bb13:: with SMTP id z19mr7739488ybg.347.1629242761449;
 Tue, 17 Aug 2021 16:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210817172909.18630-1-bernie@allthenticate.net> <20210817172909.18630-2-bernie@allthenticate.net>
In-Reply-To: <20210817172909.18630-2-bernie@allthenticate.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Aug 2021 16:25:50 -0700
Message-ID: <CABBYNZKFcf3AvbdxuJw00ZZxwYpdhrea4Ks7_22EFDoRYEksmA@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 1/1] Added GDBusMethod to notify one device of
 characteristic change
To:     Bernie Conrad <bernie@allthenticate.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bernie,

On Tue, Aug 17, 2021 at 10:30 AM Bernie Conrad <bernie@allthenticate.net> wrote:
>
> Implementation of the method and modification of the dbus method table.
>
> ---
>  src/gatt-database.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 99c95f2d6..7e6b70a80 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -3615,6 +3615,93 @@ static DBusMessage *manager_unregister_app(DBusConnection *conn,
>         return dbus_message_new_method_return(msg);
>  }
>
> +static DBusMessage *notify_characteristic_changed(DBusConnection *conn,
> +                                                                                       DBusMessage *msg, void *user_data)
> +{
> +       struct btd_gatt_database *database = user_data;
> +       uint8_t *value = NULL;
> +       int value_len = 0;
> +       DBusMessageIter args;
> +       DBusMessageIter array;
> +       const char *characteristic_path;
> +       const char *client_path;
> +       const char *application_path;
> +       struct svc_match_data match_data;
> +       const char *sender = dbus_message_get_sender(msg);
> +       struct gatt_app *app;
> +       struct external_service *service;
> +       struct external_chrc *chrc;
> +       struct notify notify;
> +       struct device_state *client_state;
> +       struct btd_device *client_device;
> +
> +       if (!dbus_message_iter_init(msg, &args))
> +               return btd_error_invalid_args(msg);
> +
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
> +               return btd_error_invalid_args(msg);
> +       dbus_message_iter_get_basic(&args, &application_path);
> +
> +       dbus_message_iter_next(&args);
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
> +               return btd_error_invalid_args(msg);
> +       dbus_message_iter_get_basic(&args, &client_path);
> +
> +       dbus_message_iter_next(&args);
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_OBJECT_PATH)
> +               return btd_error_invalid_args(msg);
> +       dbus_message_iter_get_basic(&args, &characteristic_path);
> +
> +       dbus_message_iter_next(&args);
> +       if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
> +               return btd_error_invalid_args(msg);
> +
> +
> +       dbus_message_iter_recurse(&args, &array);
> +       dbus_message_iter_get_fixed_array(&array, &value, &value_len);
> +
> +       match_data.path = application_path;
> +       match_data.sender = sender;
> +       app = queue_find(database->apps, match_app, &match_data);
> +       if (!app)
> +               return btd_error_does_not_exist(msg);
> +
> +
> +       service = queue_find(app->services, match_service_by_chrc,
> +                                         characteristic_path);
> +       if (!service)
> +               return btd_error_does_not_exist(msg);
> +
> +
> +       chrc = queue_find(service->chrcs, match_chrc, characteristic_path);
> +       if (!chrc)
> +               return btd_error_agent_not_available(msg);
> +
> +
> +       client_device = btd_adapter_find_device_by_path(database->adapter,
> +                                                                                                client_path);
> +       if (!client_device)
> +               return btd_error_does_not_exist(msg);
> +
> +       client_state = find_device_state(database,
> +                                                               device_get_address(client_device),
> +                                                               btd_device_get_bdaddr_type(client_device));
> +       if (!client_state)
> +               return btd_error_does_not_exist(msg);
> +
> +
> +       notify.handle = gatt_db_attribute_get_handle(chrc->attrib);
> +       notify.ccc_handle = gatt_db_attribute_get_handle(chrc->ccc);
> +       notify.database = database;
> +       notify.value = value;
> +       notify.len = value_len;
> +       notify.conf = conf_cb;
> +
> +       send_notification_to_device(client_state, &notify);
> +       DBG("Notification/Indication sent to %s.", client_path);
> +       return dbus_message_new_method_return(msg);
> +}
> +
>  static const GDBusMethodTable manager_methods[] = {
>         { GDBUS_ASYNC_METHOD("RegisterApplication",
>                                         GDBUS_ARGS({ "application", "o" },
> @@ -3623,6 +3710,12 @@ static const GDBusMethodTable manager_methods[] = {
>         { GDBUS_ASYNC_METHOD("UnregisterApplication",
>                                         GDBUS_ARGS({ "application", "o" }),
>                                         NULL, manager_unregister_app) },
> +       { GDBUS_ASYNC_METHOD("NotifyCharacteristicChanged",
> +                                       GDBUS_ARGS({"application", "o" },
> +                                       { "device", "o" },
> +                                       { "characteristic_path", "o"},
> +                                       { "value", "ay"}),
> +                                       NULL, notify_characteristic_changed) },

I don't think this will gonna fly, we should actually emit for the
server object and not directly to the device so I rather have a
different property e.g. object, array{byte} DeviceValue, that said
this is a bit of a layer violation since the GATT layer should be in
controller of things like device address, etc, in fact it doesn't know
which devices are subscribed to its CCC. In zephyr the way we handled
this was to push this to the application by having it handling the CCC
attribute, that said I think that can create non-compliant
implementation of CCC so Im not sure if we should do that either,
anyway we could block the DeviceValue notification if the device set
is not in fact subscribed.

>         { }
>  };
>
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz

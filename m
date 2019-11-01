Return-Path: <SRS0=Dn6D=YZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE91CA9ECF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F8420650
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Nov 2019 14:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra4kW6UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKAOuJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:50:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34839 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfKAOuJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Nov 2019 10:50:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id z6so8567271otb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2019 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1a4fZqN9HtleVcM7JNirQPzY52XIzSB+S8Q1piXxz8=;
        b=ra4kW6UY2BGv09aKaJSzUO07OTh5IT9XZiUJJpALrSWlY5z1LgFVr9Yd1SxjOuFxzV
         8mQKn8N0nq4SWHH4IM4hvHULpGPeaSFUa0QMJ+XV6Xrm6H8vcyh5aqUddGB/FJiBu387
         nFK5QZcEVGuGY6cC096cQ5jGjbq0VypuvBe/D7X28NKnNEU3z5Yp9yJTU97ytXJ6go/e
         3nIkF4wzfuQkIzOZVT5ZeIU9zu9aF8TMbVaalfsRpOQEabr83qpJMwpIXCbsGRMz5CK4
         5uzQMggbVXrzYTNmHB/fD3DkaXaCCoD6uTgRqjtQoNtFjCVfIXdfnNBcFFFQHb+pQXHJ
         7x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1a4fZqN9HtleVcM7JNirQPzY52XIzSB+S8Q1piXxz8=;
        b=UnZbi+79OImxn3cA1gQ3Ez8amqEKEVSx0oMVyWTlIXYaBHBjO/YTYIfka723lpppNw
         4y5EGishu0udR49sArj5IicvLdGGQZHWv0iFQfgCWMZZPQ9SvgpgfOKH4eS0cihvm+6G
         Dx8pDCk96lkXjH0SCfw0avkjGVD9Yth3R43M53/8wGZjcYSIUHgbWGDOHZmDIwEiCtQa
         eS6Ye+6pFCh4208Z6z/ydWOnAYSPLCdinZ/yYObK2w6l5W+j8JGU5Zv+8b2j5b+rWO+r
         UwQgztzDJ9Z7jGVR4Gc9Af0OnCo7iZEUHe3EOMSuBzbTSkQAhGPXMEpFsIz+Q3codNvN
         Byvw==
X-Gm-Message-State: APjAAAUUaoopq+PCXqnkZwXkM7aS3xglJIRU7zauy60ByAZGco9Fio/V
        uznOakxNqxXcw2iTa/yvy7bQTm4sOsBT/KJEZX7x4s0O
X-Google-Smtp-Source: APXvYqxXPGEP2ouNHkRkGJGkZx22KLD9S+KF27QRM9ugufybU05nv1c4w5ChVmN9F8NP2AxN2a7ncu8A8P1Y/Y4CNKw=
X-Received: by 2002:a9d:5c0e:: with SMTP id o14mr9331308otk.79.1572619807911;
 Fri, 01 Nov 2019 07:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <1572504777-12124-1-git-send-email-simon.mikuda@streamunlimited.com>
In-Reply-To: <1572504777-12124-1-git-send-email-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 Nov 2019 16:49:55 +0200
Message-ID: <CABBYNZ+SvYgxdr51rr_cYOWczLWLfRUz_xMJkJJrEv2gWSer5w@mail.gmail.com>
Subject: Re: [PATCH] advertising: Fix crash when advertisement is unregistered
 while MGMT ADD_ADVERTISEMENT call
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Oct 31, 2019 at 9:45 AM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:

Subject should be less than 72 characters so it first nicely on git
shortlog, you can add a short description before the backtrace.

> bluetoothd[29698]: src/advertising.c:register_advertisement() RegisterAdv=
ertisement
> bluetoothd[29698]: src/advertising.c:client_create() Adding proxy for /or=
g/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:register_advertisement() Registered =
advertisement at path /org/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding Service=
UUID: 180D
> bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding Service=
UUID: 180F
> bluetoothd[29698]: src/advertising.c:parse_manufacturer_data() Adding Man=
ufacturerData for ffff
> bluetoothd[29698]: src/advertising.c:parse_service_data() Adding ServiceD=
ata for 9999
> bluetoothd[29698]: src/advertising.c:parse_data() Adding Data for type 0x=
26 len 3
> bluetoothd[29698]: src/advertising.c:refresh_adv() Refreshing advertiseme=
nt: /org/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:unregister_advertisement() Unregiste=
rAdvertisement
> bluetoothd[29698]: src/advertising.c:add_adv_callback() Advertisement reg=
istered: =EF=BF=BD
> Segmentation fault (core dumped)
> ---
>  src/advertising.c | 53 +++++++++++++++++++++++++++++--------------------=
----
>  1 file changed, 29 insertions(+), 24 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 3ed1376..7d8cadf 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -63,6 +63,8 @@ struct btd_adv_manager {
>  #define AD_TYPE_PERIPHERAL 1
>
>  struct btd_adv_client {
> +       int ref_count;
> +
>         struct btd_adv_manager *manager;
>         char *owner;
>         char *path;
> @@ -136,13 +138,6 @@ static void client_free(void *data)
>         free(client);
>  }
>
> -static gboolean client_free_idle_cb(void *data)
> -{
> -       client_free(data);
> -
> -       return FALSE;
> -}
> -
>  static void client_release(void *data)
>  {
>         struct btd_adv_client *client =3D data;
> @@ -175,12 +170,19 @@ static void remove_advertising(struct btd_adv_manag=
er *manager,
>                         manager->mgmt_index, sizeof(cp), &cp, NULL, NULL,=
 NULL);
>  }
>
> -static void client_remove(void *data)
> +static struct btd_adv_client *client_ref(struct btd_adv_client *client)
> +{
> +       __sync_fetch_and_add(&client->ref_count, 1);
> +
> +       return client;
> +}
> +
> +static void client_unref(struct btd_adv_client *client)
>  {
> -       struct btd_adv_client *client =3D data;
>         struct mgmt_cp_remove_advertising cp;
>
> -       g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
> +       if (__sync_sub_and_fetch(&client->ref_count, 1))
> +               return;

While the idea of using refcount to protect might seem good I think we
would be better off using mgmt_cancel for this case so the callback is
not called, or you are not using it on purpose?

>         cp.instance =3D client->instance;
>
> @@ -188,10 +190,6 @@ static void client_remove(void *data)
>                         client->manager->mgmt_index, sizeof(cp), &cp,
>                         NULL, NULL, NULL);
>
> -       queue_remove(client->manager->clients, client);
> -
> -       g_idle_add(client_free_idle_cb, client);
> -
>         g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                                 adapter_get_path(client->manager->adapter=
),
>                                 LE_ADVERTISING_MGR_IFACE, "SupportedInsta=
nces");
> @@ -199,13 +197,18 @@ static void client_remove(void *data)
>         g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                                 adapter_get_path(client->manager->adapter=
),
>                                 LE_ADVERTISING_MGR_IFACE, "ActiveInstance=
s");
> +
> +       queue_remove(client->manager->clients, client);
> +
> +       client_free(client);
> +
>  }
>
>  static void client_disconnect_cb(DBusConnection *conn, void *user_data)
>  {
>         DBG("Client disconnected");
>
> -       client_remove(user_data);
> +       client_unref(user_data);
>  }
>
>  static bool parse_type(DBusMessageIter *iter, struct btd_adv_client *cli=
ent)
> @@ -564,7 +567,7 @@ static gboolean client_timeout(void *user_data)
>         client->to_id =3D 0;
>
>         client_release(client);
> -       client_remove(client);
> +       client_unref(client);
>
>         return FALSE;
>  }
> @@ -963,8 +966,6 @@ static void add_client_complete(struct btd_adv_client=
 *client, uint8_t status)
>                                                 mgmt_errstr(status), stat=
us);
>                 reply =3D btd_error_failed(client->reg,
>                                         "Failed to register advertisement=
");
> -               queue_remove(client->manager->clients, client);
> -               g_idle_add(client_free_idle_cb, client);
>
>         } else
>                 reply =3D dbus_message_new_method_return(client->reg);
> @@ -972,6 +973,8 @@ static void add_client_complete(struct btd_adv_client=
 *client, uint8_t status)
>         g_dbus_send_message(btd_get_dbus_connection(), reply);
>         dbus_message_unref(client->reg);
>         client->reg =3D NULL;
> +
> +       client_unref(client);
>  }
>
>  static void add_adv_callback(uint8_t status, uint16_t length,
> @@ -1060,8 +1063,11 @@ static DBusMessage *parse_advertisement(struct btd=
_adv_client *client)
>         }
>
>         err =3D refresh_adv(client, add_adv_callback);
> -       if (!err)
> +       if (!err) {
> +               /* Hold reference to client until add_adv_callback is fin=
ished */
> +               client_ref(client);
>                 return NULL;
> +       }
>
>  fail:
>         return btd_error_failed(client->reg, "Failed to parse advertiseme=
nt.");
> @@ -1082,14 +1088,12 @@ static void client_proxy_added(GDBusProxy *proxy,=
 void *data)
>                 return;
>
>         /* Failed to publish for some reason, remove. */
> -       queue_remove(client->manager->clients, client);
> -
> -       g_idle_add(client_free_idle_cb, client);
> -
>         g_dbus_send_message(btd_get_dbus_connection(), reply);
>
>         dbus_message_unref(client->reg);
>         client->reg =3D NULL;
> +
> +       client_unref(client);
>  }
>
>  static struct btd_adv_client *client_create(struct btd_adv_manager *mana=
ger,
> @@ -1189,6 +1193,7 @@ static DBusMessage *register_advertisement(DBusConn=
ection *conn,
>         DBG("Registered advertisement at path %s", match.path);
>
>         queue_push_tail(manager->clients, client);
> +       client_ref(client);
>
>         return NULL;
>  }
> @@ -1218,7 +1223,7 @@ static DBusMessage *unregister_advertisement(DBusCo=
nnection *conn,
>         if (!client)
>                 return btd_error_does_not_exist(msg);
>
> -       client_remove(client);
> +       client_unref(client);
>
>         return dbus_message_new_method_return(msg);
>  }
> --
> 2.7.4
>


--=20
Luiz Augusto von Dentz

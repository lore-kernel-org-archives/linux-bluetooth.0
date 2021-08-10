Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92335C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6567D60F56
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 16:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhHJQex (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhHJQex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 12:34:53 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11081C0613C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 09:34:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l3so4865486ybt.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SM6NlS4FQpaxAXlf9xg2ZPlE7w2ywNlx7c+2k5rIcPU=;
        b=aK3u+8Mh/FOXLvo1XksvUKG1zZztc5Ph2JTrs5zPU95Kbt2eIHWTajqAYfzDbGfwDL
         XxX+k35wbrb0Au+hfm3zOMo+qLJ3AaDRjg3FC5aZFtKh6JhDrJEu1Iw4rTno6PaLO2s/
         x94nVYrIBcb8Iw8J0x7iJMobpTM+3lHqgYPpxjlHsLDfCpgffJBFAIHI2bH1uPOwAh5C
         QdXWHV/cjWUwdbI0mam8ZgS2gMyzoRGEnH7A5UaJlYahYkrGPk21JgrhvEwJKaHghO/u
         CjiCHIG95kI16+k2Uzs/QcR4tGw/9VvwDEgC9eMGYEfKYy/B+zQ6W1qWfDlVEEuWMZx3
         knvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SM6NlS4FQpaxAXlf9xg2ZPlE7w2ywNlx7c+2k5rIcPU=;
        b=H8vVhdJ3fDJqmOps/FqsXcjXHp1e+Ny7qmnM2VQ64h6vQ3CeuGKmEM4E8+ppIX7kTG
         7JZntvvMpYS38t4Q4cGxki1Hw3gwF7r2y9+Z+feNacucvUrOdKKfitXzTa9yCOSKA3vk
         9s4v4ayThk9c/TFapzuNjpvKLnyL3Cr7vy1T0FI2CS0QER2rloLTKNWfwsb9Wtrgt3l/
         d8lBZCM3mJH+NtoRyaUS4MVPY6obhEZ0UxHZym9DrtjOLQ4s+H0QmQjsHDtzx65yTXOH
         WvfK4dydg8rK3WxwzuVjz31ppOmOHxi5GbadsFc00Rtz3vQf4r8R3PTJgqj2RGJRUQfy
         OD8w==
X-Gm-Message-State: AOAM530hVKR5vU6iyKRLfQjg8fM+4zuAq9P3WUpx9GnJRtnAchcMlb20
        1huj2+EypcJx7d61CKW65vb+ALNbIvbSJB2XR80=
X-Google-Smtp-Source: ABdhPJwcr/nK+y6tTveeGufYWqBV52xpykglYPtUmPxQF4l1PfkmiiGI7rOGAR3WextqJxdlMKwsfKBuqNQNotwpYMI=
X-Received: by 2002:a25:be02:: with SMTP id h2mr40364448ybk.91.1628613270159;
 Tue, 10 Aug 2021 09:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210810205522.v2.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
 <20210810205522.v2.2.I1d1cf4fbc02b11d62f186f0db23c2c537e296a64@changeid>
In-Reply-To: <20210810205522.v2.2.I1d1cf4fbc02b11d62f186f0db23c2c537e296a64@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Aug 2021 09:34:18 -0700
Message-ID: <CABBYNZJKjJuGm9mkUMzHF9ahEvs6c7gYaKzjoo3cadyx7VJs8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] client: add admin submenu and allow command
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, Aug 10, 2021 at 5:56 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This creates a menu - admin and add a commands to bluetoothctl
> - allow [clear/uuid1 uuid2 ...]
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> The following test steps were performed:
> 1. [bluetooth]# menu admin
> 2. [bluetooth]# allow 1124 180A 180F 1812 1801
> 3. [bluetooth]# allow
>    Service AllowedList:
>         00001801-0000-1000-8000-00805f9b34fb
>         00001812-0000-1000-8000-00805f9b34fb
>         0000180f-0000-1000-8000-00805f9b34fb
>         0000180a-0000-1000-8000-00805f9b34fb
>         00001124-0000-1000-8000-00805f9b34fb
> 4. [bluetooth]# allow clear
> 5. [bluetooth]# allow
>    Service AllowedList:
>
> Changes in v2:
> - Merge command set-service-allowlist and get-service-allowlist to allow
> - Update commit messages
>
>  Makefile.tools        |   4 +-
>  client/admin_policy.c | 133 ++++++++++++++++++++++++++++++++++++++++++
>  client/admin_policy.h |  25 ++++++++
>  client/main.c         |  71 ++++++++++++++++++++++
>  4 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 client/admin_policy.c
>  create mode 100644 client/admin_policy.h
>
> diff --git a/Makefile.tools b/Makefile.tools
> index c836b5984934..1b493d4d0ed6 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -9,7 +9,9 @@ client_bluetoothctl_SOURCES = client/main.c \
>                                         client/advertising.c \
>                                         client/adv_monitor.h \
>                                         client/adv_monitor.c \
> -                                       client/gatt.h client/gatt.c
> +                                       client/gatt.h client/gatt.c \
> +                                       client/admin_policy.h \
> +                                       client/admin_policy.c
>  client_bluetoothctl_LDADD = gdbus/libgdbus-internal.la src/libshared-glib.la \
>                                 $(GLIB_LIBS) $(DBUS_LIBS) -lreadline
>  endif
> diff --git a/client/admin_policy.c b/client/admin_policy.c
> new file mode 100644
> index 000000000000..21062c4f6185
> --- /dev/null
> +++ b/client/admin_policy.c

Looks like I missed the fact that the file was called admin_policy, I
guess it makes sense to rename it to admin as well so it can deal with
more than just policy interface.

> @@ -0,0 +1,133 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2021 Google LLC
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#include "gdbus/gdbus.h"
> +#include "src/shared/shell.h"
> +
> +#include "admin_policy.h"
> +#define _GNU_SOURCE
> +
> +static GDBusProxy *set_proxy;
> +static GDBusProxy *status_proxy;
> +
> +void admin_policy_set_set_proxy(GDBusProxy *proxy)
> +{
> +       set_proxy = proxy;
> +}
> +
> +void admin_policy_set_status_proxy(GDBusProxy *proxy)
> +{
> +       status_proxy = proxy;
> +}
> +
> +void admin_policy_read_service_allowlist(DBusConnection *dbus_conn)
> +{
> +       DBusMessageIter iter, subiter;
> +       char *uuid = NULL;
> +
> +       if (!status_proxy || !g_dbus_proxy_get_property(status_proxy,
> +                                               "ServiceAllowList", &iter)) {
> +               bt_shell_printf("Failed to get property\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
> +               bt_shell_printf("Unexpected return type\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("Service AllowedList:\n");
> +       dbus_message_iter_recurse(&iter, &subiter);
> +       while (dbus_message_iter_get_arg_type(&subiter) ==
> +                                               DBUS_TYPE_STRING) {
> +               dbus_message_iter_get_basic(&subiter, &uuid);
> +               bt_shell_printf("\t%s\n", uuid);
> +               dbus_message_iter_next(&subiter);
> +       }
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +struct uuid_list_data {
> +       char **uuid_list;
> +       size_t num;
> +};
> +
> +static void set_service_setup(DBusMessageIter *iter, void *user_data)
> +{
> +       struct uuid_list_data *data = user_data;
> +       DBusMessageIter arr_iter;
> +       size_t i;
> +
> +       dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
> +                                               DBUS_TYPE_STRING_AS_STRING,
> +                                               &arr_iter);
> +
> +       for (i = 0; i < data->num; i++) {
> +               dbus_message_iter_append_basic(&arr_iter, DBUS_TYPE_STRING,
> +                                                       &data->uuid_list[i]);
> +       }
> +
> +       dbus_message_iter_close_container(iter, &arr_iter);
> +}
> +
> +static void set_service_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (!dbus_set_error_from_message(&error, message)) {
> +               bt_shell_printf("Set allowed service successfully\n");
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
> +
> +       bt_shell_printf("Failed to set service allowed list: %s\n", error.name);
> +       dbus_error_free(&error);
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
> +void admin_policy_set_service_allowlist(DBusConnection *dbus_connd,
> +                                                       int argc, char *argv[])
> +{
> +       struct uuid_list_data data;
> +
> +       if (!set_proxy) {
> +               bt_shell_printf("Set proxy not ready\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       data.uuid_list = argv;
> +       data.num = argc;
> +
> +       if (!g_dbus_proxy_method_call(set_proxy, "SetServiceAllowList",
> +                                       set_service_setup, set_service_reply,
> +                                       &data, NULL)) {
> +               bt_shell_printf("Failed to call method\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +}
> diff --git a/client/admin_policy.h b/client/admin_policy.h
> new file mode 100644
> index 000000000000..1c8c2152d59d
> --- /dev/null
> +++ b/client/admin_policy.h
> @@ -0,0 +1,25 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2021 Google LLC
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +void admin_policy_set_set_proxy(GDBusProxy *proxy);
> +void admin_policy_set_status_proxy(GDBusProxy *proxy);
> +
> +void admin_policy_read_service_allowlist(DBusConnection *dbus_conn);
> +void admin_policy_set_service_allowlist(DBusConnection *dbus_conn,
> +                                                       int argc, char *argv[]);
> diff --git a/client/main.c b/client/main.c
> index c1a62edb7f99..142a2c08a07f 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -29,6 +29,7 @@
>  #include "gatt.h"
>  #include "advertising.h"
>  #include "adv_monitor.h"
> +#include "admin_policy.h"
>
>  /* String display constants */
>  #define COLORED_NEW    COLOR_GREEN "NEW" COLOR_OFF
> @@ -530,6 +531,23 @@ static void admon_manager_added(GDBusProxy *proxy)
>         adv_monitor_register_app(dbus_conn);
>  }
>
> +static void admin_policy_set_added(GDBusProxy *proxy)
> +{
> +       admin_policy_set_set_proxy(proxy);
> +}
> +
> +static void admin_policy_status_added(GDBusProxy *proxy)
> +{
> +       struct adapter *adapter;
> +
> +       adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
> +
> +       if (!adapter)
> +               return;
> +
> +       admin_policy_set_status_proxy(proxy);
> +}
> +
>  static void proxy_added(GDBusProxy *proxy, void *user_data)
>  {
>         const char *interface;
> @@ -565,6 +583,10 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
>         } else if (!strcmp(interface,
>                                 "org.bluez.AdvertisementMonitorManager1")) {
>                 admon_manager_added(proxy);
> +       } else if (!strcmp(interface, "org.bluez.AdminPolicySet1")) {
> +               admin_policy_set_added(proxy);
> +       } else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1")) {
> +               admin_policy_status_added(proxy);
>         }
>  }
>
> @@ -621,6 +643,23 @@ static void adapter_removed(GDBusProxy *proxy)
>         }
>  }
>
> +static void admin_policy_set_removed(GDBusProxy *proxy)
> +{
> +       admin_policy_set_set_proxy(NULL);
> +}
> +
> +static void admin_policy_status_removed(GDBusProxy *proxy)
> +{
> +       struct adapter *adapter;
> +
> +       adapter = find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
> +
> +       if (!adapter)
> +               return;
> +
> +       admin_policy_set_status_proxy(NULL);
> +}
> +
>  static void proxy_removed(GDBusProxy *proxy, void *user_data)
>  {
>         const char *interface;
> @@ -661,6 +700,10 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
>         } else if (!strcmp(interface,
>                         "org.bluez.AdvertisementMonitorManager1")) {
>                 adv_monitor_remove_manager(dbus_conn);
> +       } else if (!strcmp(interface, "org.bluez.AdminPolicySet1")) {
> +               admin_policy_set_removed(proxy);
> +       } else if (!strcmp(interface, "org.bluez.AdminPolicyStatus1")) {
> +               admin_policy_status_removed(proxy);
>         }
>  }
>
> @@ -2824,6 +2867,24 @@ static void cmd_adv_monitor_get_supported_info(int argc, char *argv[])
>         adv_monitor_get_supported_info();
>  }
>
> +static void cmd_admin_allow(int argc, char *argv[])
> +{
> +       if (check_default_ctrl() == FALSE)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       admin_policy_set_service_allowlist(dbus_conn, argc - 1, argv + 1);
> +
> +       if (argc <= 1) {
> +               admin_policy_read_service_allowlist(dbus_conn);
> +               return;
> +       }
> +
> +       if (strcmp(argv[1], "clear") == 0)
> +               argc--;
> +
> +       admin_policy_set_service_allowlist(dbus_conn, argc - 1, argv + 1);
> +}
> +
>  static const struct bt_shell_menu advertise_menu = {
>         .name = "advertise",
>         .desc = "Advertise Options Submenu",
> @@ -2978,6 +3039,15 @@ static const struct bt_shell_menu gatt_menu = {
>         { } },
>  };
>
> +static const struct bt_shell_menu admin_menu = {
> +       .name = "admin",
> +       .desc = "Admin Policy Submenu",
> +       .entries = {
> +       { "allow", "[clear/uuid1 uuid2 ...]", cmd_admin_allow,
> +                               "Allow service UUIDs and block rest of them"},
> +       {} },
> +};
> +
>  static const struct bt_shell_menu main_menu = {
>         .name = "main",
>         .entries = {
> @@ -3075,6 +3145,7 @@ int main(int argc, char *argv[])
>         bt_shell_add_submenu(&advertise_monitor_menu);
>         bt_shell_add_submenu(&scan_menu);
>         bt_shell_add_submenu(&gatt_menu);
> +       bt_shell_add_submenu(&admin_menu);
>         bt_shell_set_prompt(PROMPT_OFF);
>
>         if (agent_option)
> --
> 2.32.0.605.g8dce9f2422-goog
>


-- 
Luiz Augusto von Dentz

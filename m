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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B232C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B2660EE9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 21:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbhHFVlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244211AbhHFVlf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 17:41:35 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D23C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 14:41:18 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id w17so17586936ybl.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUeBbfgLq+rcwLhhgRub7YKK/T4eEMwBuYidqpHiCRY=;
        b=OeI7CztatU2SfXPo+xsOdiRVfsA9taBVXyKEmL/CKIQru/tnSSOPZoBzd51z8d76lL
         w7TiaEyTY7VkxMaP8t2DVWkmncg7c97WMIyEuv6Z/OH8cxug8zJcSTE8+4p8VgwOKyQE
         wUKzEt6kg4v9MV/TCK9fokRzLyXowJ/PD1DUlvFJbi4t/OnRT5FxDtLmJ4Q7sl2MuwFW
         0Vmyy/cHNJL8WuM7rko1mUMirHdWGiYSFQVemLvXPAzySRRaqDje3DxXdH4V0Zg70y3/
         y5uvGJ/wUeQrScHbuKQEK0M9gIwa3Ch7eQJU94m5mnMv4bR4fe5DtyNRLoAAGJ3Hq7v5
         7eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUeBbfgLq+rcwLhhgRub7YKK/T4eEMwBuYidqpHiCRY=;
        b=AkH7cuUUECaIumtAib3KOn9wD3EwNvAnST+An/otCR0uH7mR2H0xWq2QfPp0C6bSb4
         jmpi6oQSTz6MlVfUOS+2ypMkTN0ipkbU8QPeFk7Wk9Mvgk5Yt30LCLCo511+76PZQKsU
         vDy05KIA5X4JiJYzsbuRuBVHFPx5EpF3TasOEKbLuYbHWtZRFS9wmsIcMXykXllPwC/a
         pHbNXh5IX9JFvcYgMuyKXDaJauK9qe11JOLtpZgKvD9asJFxfv71keHOYvRU+yTM1KVU
         UUJBDabdMAQ0++1pR1sKTHxlwxQ3i7KUUgF+uulFsHn5ngHOnFNXgIAfHMpqK2w0dlTw
         aqJA==
X-Gm-Message-State: AOAM5323bEwDV3IW33hHqAyOOsqYntsjsftTPulNlTOytb6WZoeA1DX1
        F/GOSGNhCj6Bh81sYeUiAw7xnKRq3u6MjuiTxug=
X-Google-Smtp-Source: ABdhPJwP7/aYAsYY64jKP/mpiNpTvctnyQlvYY+G0+UizB1mI6+CDtSROQApUqmQs5C0IvBytyYjDF60bCu8dvqhb6A=
X-Received: by 2002:a25:bd89:: with SMTP id f9mr8755457ybh.222.1628286077727;
 Fri, 06 Aug 2021 14:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210806173706.v1.1.Ie7d876ad0b7defabfa86beb64e83f655f12be7ab@changeid>
 <20210806173706.v1.2.I1d1cf4fbc02b11d62f186f0db23c2c537e296a64@changeid>
In-Reply-To: <20210806173706.v1.2.I1d1cf4fbc02b11d62f186f0db23c2c537e296a64@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 6 Aug 2021 14:41:06 -0700
Message-ID: <CABBYNZKfwObFHQaZmZ4YJt-Np_Obx_hxa5g9zBwz0d81Og0jqw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] client: add service-allowlist command
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Fri, Aug 6, 2021 at 2:38 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This creates a menu - admin and adds two commands to bluetoothctl
> - set-service-allowlist [uuid1 uuid2 ...]
> - get-service-allowlist

How about we just do:

> allow [clear/uuid1 uuid2 ...]

So when no command is set it just prints the current list and in case
you want to clear it just enter allow clear.

> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> The following test steps were performed:
> 1. [bluetooth]# - menu admin
> 2. [bluetooth]# set-service-allowlist 1124 180A 180F 1812 1801
> 3. [bluetooth]# get-service-allowlist
> 4. Verify the printed UUIDs are the same as what we set.
>
>  Makefile.tools        |   4 +-
>  client/admin_policy.c | 133 ++++++++++++++++++++++++++++++++++++++++++
>  client/admin_policy.h |  25 ++++++++
>  client/main.c         |  72 +++++++++++++++++++++++
>  4 files changed, 233 insertions(+), 1 deletion(-)
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
> index c1a62edb7f99..5297760c8cec 100644
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
> @@ -2824,6 +2867,22 @@ static void cmd_adv_monitor_get_supported_info(int argc, char *argv[])
>         adv_monitor_get_supported_info();
>  }
>
> +static void cmd_set_service_allowlist(int argc, char *argv[])
> +{
> +       if (check_default_ctrl() == FALSE)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       admin_policy_set_service_allowlist(dbus_conn, argc - 1, argv + 1);
> +}
> +
> +static void cmd_get_service_allowlist(int argc, char *argv[])
> +{
> +       if (check_default_ctrl() == FALSE)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       admin_policy_read_service_allowlist(dbus_conn);
> +}
> +
>  static const struct bt_shell_menu advertise_menu = {
>         .name = "advertise",
>         .desc = "Advertise Options Submenu",
> @@ -2978,6 +3037,18 @@ static const struct bt_shell_menu gatt_menu = {
>         { } },
>  };
>
> +static const struct bt_shell_menu admin_menu = {
> +       .name = "admin",
> +       .desc = "Admin Policy Submenu",
> +       .entries = {
> +       { "set-service-allowlist", "[uuid1 uuid2 ...]",
> +                                               cmd_set_service_allowlist,
> +                                               "Set service allowlist"},
> +       { "get-service-allowlist", NULL, cmd_get_service_allowlist,
> +                                               "Get service allowlist"},
> +       {} },
> +};
> +
>  static const struct bt_shell_menu main_menu = {
>         .name = "main",
>         .entries = {
> @@ -3075,6 +3146,7 @@ int main(int argc, char *argv[])
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

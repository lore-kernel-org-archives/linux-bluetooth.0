Return-Path: <SRS0=CFtH=CY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86635C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 20:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1716C20B1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Sep 2020 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI/+8QzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgIOUJH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgIOUIk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Sep 2020 16:08:40 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D0C061788
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 13:08:37 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id t3so1084551ook.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2020 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qzH3qyKDcNmD9f8uTEY/0v4yXNJbPF9Xm/l/XfyVneQ=;
        b=RI/+8QzBmfUpNiNIen6zdNLiK5reeOmNzN0CozZ0zwiY3x+N1SpOquA1jpg/OfkhG5
         NMtZnDTva2eZyzETByNlW4/NoezB3OgRmXp8Po5rhk3lDKF9Fx2vpNl2KqfcnpuSbQV/
         m3EGB9MGJqkbhpR5o45WKdHB/ivt+iLbmAUxqP00uhdPRNejbkrDTWlrHGAxEvEwLaq+
         lXMszQ/UPyrKt1RomnlVz8JC2H46cUx3RRMJjPq59yfGAzDjCRVMBnqd2Lh7UeTSaGr7
         PFsfZ9ULxJ7vQ0TNAuTT7xoSr02LGA9T3LG0tUnRaC1n/6dRPus8bS1P3QXi0Xpow9q9
         oyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qzH3qyKDcNmD9f8uTEY/0v4yXNJbPF9Xm/l/XfyVneQ=;
        b=ihmR4RankU1snAHDJsNNaOCfi6BGtmIEB7XFJhk6Z45+LIlGbsAx+2P5PKZM6Akxqu
         c90fzbrwftyR8RkJRIp+vJiMC8HorHesMo7Y+meQQmFXHUQVx2fvSSiHT2wgf7m9prME
         TmvZyaFxlQLBxuQsiuPY19P7Q+pUaoEZxi7jR2a/AYUE3WWZ1a6ZTTDBbm4Fwb3LVR+Q
         hTSfMtuLctWKRlLjvDdRT14e+g1aVeyRjstG8oQZiz0r0SAzQvz+5v2L/fUt4iKtfQDq
         7/PGJmrojt37CiF1ySy+/fiDQnjY/42hMq2rGID6ie8BnKafAv4PDHSktbi1DwK67QfU
         a6hg==
X-Gm-Message-State: AOAM530VknUgJ/kaXxMeKWGuUihLZWYZn1Nrjq6pgtod9kG+Y8AkRG9K
        pucJSO0wPiQyaxvwCglzJGBRmIIyUOLAKzHJyMY=
X-Google-Smtp-Source: ABdhPJwR9GzbsfyNWilVE+ca/ygPXiIfpeQPfgTZeLA41ZFjLrO8KPEJLggc7inMSNl+ACRCpaP/i9MCWVTqOiFRDXc=
X-Received: by 2002:a4a:bf12:: with SMTP id r18mr11393911oop.9.1600200516678;
 Tue, 15 Sep 2020 13:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200914112137.BlueZ.v4.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
In-Reply-To: <20200914112137.BlueZ.v4.1.I8e067a74d324751fc788f53e0c14f60923683d01@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 15 Sep 2020 13:08:25 -0700
Message-ID: <CABBYNZLf64nFjJo6PqoVViDbkfmOqpiQcRjPrKrgtqgP-Y42Fw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4 1/4] client: Implement basic interface of ADV
 monitor in bluetoothctl
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Sun, Sep 13, 2020 at 8:26 PM Howard Chung <howardchung@google.com> wrote=
:
>
> This patch implements some basic functions for ADV monitor in
> bluetoothctl
>
> [bluetooth]# show
> ...
> Advertisement Monitor Features:
>         SupportedMonitorTypes: or_patterns
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> ---
>
> Changes in v4:
> - Remove PRE-UPSTREAM in commit title
>
> Changes in v3:
> - Rename advertisement_monitor to adv_monitor
>
> Changes in v2:
> - Update the add-pattern usage
> - Fix styling issue in patch 1
> - Fix storage class declaration issue
>
>  Makefile.tools       |   2 +
>  client/adv_monitor.c | 161 +++++++++++++++++++++++++++++++++++++++++++
>  client/adv_monitor.h |  23 +++++++
>  client/main.c        |  28 ++++++++
>  4 files changed, 214 insertions(+)
>  create mode 100644 client/adv_monitor.c
>  create mode 100644 client/adv_monitor.h
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 9b9236609..ed0fbf8a3 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -7,6 +7,8 @@ client_bluetoothctl_SOURCES =3D client/main.c \
>                                         client/agent.h client/agent.c \
>                                         client/advertising.h \
>                                         client/advertising.c \
> +                                       client/adv_monitor.h \
> +                                       client/adv_monitor.c \
>                                         client/gatt.h client/gatt.c
>  client_bluetoothctl_LDADD =3D gdbus/libgdbus-internal.la src/libshared-g=
lib.la \
>                                 $(GLIB_LIBS) $(DBUS_LIBS) -lreadline
> diff --git a/client/adv_monitor.c b/client/adv_monitor.c
> new file mode 100644
> index 000000000..2a62389d9
> --- /dev/null
> +++ b/client/adv_monitor.c
> @@ -0,0 +1,161 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2020 Google LLC
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
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +
> +#include "gdbus/gdbus.h"
> +#include "src/shared/util.h"
> +#include "src/shared/shell.h"
> +#include "adv_monitor.h"
> +
> +#define ADV_MONITOR_APP_PATH   "/org/bluez/adv_monitor_app"
> +#define ADV_MONITOR_INTERFACE  "org.bluez.AdvertisementMonitor1"
> +
> +static struct adv_monitor_manager {
> +       GSList *supported_types;
> +       GSList *supported_features;
> +       GDBusProxy *proxy;
> +       gboolean app_registered;
> +} manager =3D { NULL, NULL, NULL, FALSE };
> +
> +static void set_supported_list(GSList **list, DBusMessageIter *iter)
> +{
> +       char *str;
> +       DBusMessageIter subiter;
> +
> +       dbus_message_iter_recurse(iter, &subiter);
> +       while (dbus_message_iter_get_arg_type(&subiter) =3D=3D
> +                                               DBUS_TYPE_STRING) {
> +               dbus_message_iter_get_basic(&subiter, &str);
> +               *list =3D g_slist_append(*list, str);
> +               dbus_message_iter_next(&subiter);
> +       }
> +}
> +
> +void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy)
> +{
> +       DBusMessageIter iter;
> +
> +       if (manager.proxy !=3D NULL || manager.supported_types !=3D NULL =
||
> +                                       manager.supported_features !=3D N=
ULL) {
> +               bt_shell_printf("advertisement monitor manager already "
> +                               "added\n");
> +               return;
> +       }
> +
> +       manager.proxy =3D proxy;
> +
> +       if (g_dbus_proxy_get_property(proxy, "SupportedMonitorTypes", &it=
er))
> +               set_supported_list(&(manager.supported_types), &iter);
> +
> +       if (g_dbus_proxy_get_property(proxy, "SupportedFeatures", &iter))
> +               set_supported_list(&(manager.supported_features), &iter);
> +
> +}
> +
> +void adv_monitor_remove_manager(DBusConnection *conn)
> +{
> +       if (manager.supported_types !=3D NULL)
> +               g_slist_free(g_steal_pointer(&(manager.supported_types)))=
;
> +       if (manager.supported_features !=3D NULL)
> +               g_slist_free(g_steal_pointer(&(manager.supported_features=
)));
> +       manager.proxy =3D NULL;
> +       manager.app_registered =3D FALSE;
> +}
> +
> +static void register_setup(DBusMessageIter *iter, void *user_data)
> +{
> +       const char *path =3D ADV_MONITOR_APP_PATH;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path=
);
> +}
> +
> +static void register_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusConnection *conn =3D user_data;
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) =3D=3D FALSE) {
> +               bt_shell_printf("AdvertisementMonitor path registered\n")=
;

Missing bt_shell_noninteractive_quit(EXIT_SUCCESS);

> +       } else {
> +               bt_shell_printf("Failed to register path: %s\n", error.na=
me);
> +               dbus_error_free(&error);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }

Test dbus_set_error_from_message(&error, message) alone, I actually
would recommend not using =3D=3D TRUE/FALSE on new code. So I would have
done without the use of else clause:

if (!dbus_set_error_from_message)
 ...
 return bt_shell_noninteractive_quit(EXIT_FAILURE);

bt_shell_noninteractive_quit(EXIT_SUCCESS);

> +}
> +
> +static void unregister_setup(DBusMessageIter *iter, void *user_data)
> +{
> +       const char *path =3D ADV_MONITOR_APP_PATH;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path=
);
> +}
> +
> +static void unregister_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusConnection *conn =3D user_data;
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) =3D=3D FALSE) {
> +               bt_shell_printf("AdvertisementMonitor path unregistered\n=
");
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
> +
> +       bt_shell_printf("Failed to unregister Advertisement Monitor:"
> +                       " %s\n", error.name);
> +       dbus_error_free(&error);
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
> +void adv_monitor_register_app(DBusConnection *conn)
> +{
> +       if (manager.supported_types =3D=3D NULL || manager.app_registered=
 =3D=3D TRUE ||
> +               g_dbus_proxy_method_call(manager.proxy, "RegisterMonitor"=
,
> +                                       register_setup, register_reply,
> +                                       NULL, NULL) =3D=3D FALSE) {
> +               bt_shell_printf("Failed to register Advertisement Monitor=
\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +       manager.app_registered =3D TRUE;
> +}
> +
> +void adv_monitor_unregister_app(DBusConnection *conn)
> +{
> +       if (manager.app_registered =3D=3D FALSE ||
> +               g_dbus_proxy_method_call(manager.proxy, "UnregisterMonito=
r",
> +                                       unregister_setup, unregister_repl=
y,
> +                                       NULL, NULL) =3D=3D FALSE) {
> +               bt_shell_printf("Failed to unregister Advertisement Monit=
or\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +       manager.app_registered =3D FALSE;
> +}
> diff --git a/client/adv_monitor.h b/client/adv_monitor.h
> new file mode 100644
> index 000000000..77b0b62c6
> --- /dev/null
> +++ b/client/adv_monitor.h
> @@ -0,0 +1,23 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2020 Google LLC
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
> +void adv_monitor_add_manager(DBusConnection *conn, GDBusProxy *proxy);
> +void adv_monitor_remove_manager(DBusConnection *conn);
> +void adv_monitor_register_app(DBusConnection *conn);
> +void adv_monitor_unregister_app(DBusConnection *conn);
> diff --git a/client/main.c b/client/main.c
> index da877b546..75f8bc462 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -41,6 +41,7 @@
>  #include "agent.h"
>  #include "gatt.h"
>  #include "advertising.h"
> +#include "adv_monitor.h"
>
>  /* String display constants */
>  #define COLORED_NEW    COLOR_GREEN "NEW" COLOR_OFF
> @@ -58,6 +59,7 @@ static char *auto_register_agent =3D NULL;
>  struct adapter {
>         GDBusProxy *proxy;
>         GDBusProxy *ad_proxy;
> +       GDBusProxy *adv_monitor_proxy;
>         GList *devices;
>  };
>
> @@ -528,6 +530,19 @@ static void ad_manager_added(GDBusProxy *proxy)
>         adapter->ad_proxy =3D proxy;
>  }
>
> +static void admon_manager_added(GDBusProxy *proxy)
> +{
> +       struct adapter *adapter;
> +
> +       adapter =3D find_ctrl(ctrl_list, g_dbus_proxy_get_path(proxy));
> +       if (!adapter)
> +               adapter =3D adapter_new(proxy);
> +
> +       adapter->adv_monitor_proxy =3D proxy;
> +       adv_monitor_add_manager(dbus_conn, proxy);
> +       adv_monitor_register_app(dbus_conn);
> +}
> +
>  static void proxy_added(GDBusProxy *proxy, void *user_data)
>  {
>         const char *interface;
> @@ -560,6 +575,9 @@ static void proxy_added(GDBusProxy *proxy, void *user=
_data)
>                 ad_manager_added(proxy);
>         } else if (!strcmp(interface, "org.bluez.Battery1")) {
>                 battery_added(proxy);
> +       } else if (!strcmp(interface,
> +                               "org.bluez.AdvertisementMonitorManager1")=
) {
> +               admon_manager_added(proxy);
>         }
>  }
>
> @@ -653,6 +671,9 @@ static void proxy_removed(GDBusProxy *proxy, void *us=
er_data)
>                 ad_unregister(dbus_conn, NULL);
>         } else if (!strcmp(interface, "org.bluez.Battery1")) {
>                 battery_removed(proxy);
> +       } else if (!strcmp(interface,
> +                       "org.bluez.AdvertisementMonitorManager1")) {
> +               adv_monitor_remove_manager(dbus_conn);
>         }
>  }
>
> @@ -935,6 +956,13 @@ static void cmd_show(int argc, char *argv[])
>                 print_property(adapter->ad_proxy, "SupportedSecondaryChan=
nels");
>         }
>
> +       if (adapter->adv_monitor_proxy) {
> +               bt_shell_printf("Advertisement Monitor Features:\n");
> +               print_property(adapter->adv_monitor_proxy,
> +                                               "SupportedMonitorTypes");
> +               print_property(adapter->adv_monitor_proxy, "SupportedFeat=
ures");
> +       }
> +
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> --
> 2.28.0.618.gf4bc123cb7-goog

Doesn't compile:

make --no-print-directory all-am
  CC       client/adv_monitor.o
client/adv_monitor.c: In function =E2=80=98register_reply=E2=80=99:
client/adv_monitor.c:283:18: error: unused variable =E2=80=98conn=E2=80=99
[-Werror=3Dunused-variable]
  283 |  DBusConnection *conn =3D user_data;
      |                  ^~~~
client/adv_monitor.c: In function =E2=80=98unregister_reply=E2=80=99:
client/adv_monitor.c:306:18: error: unused variable =E2=80=98conn=E2=80=99
[-Werror=3Dunused-variable]
  306 |  DBusConnection *conn =3D user_data;
      |                  ^~~~
cc1: all warnings being treated as errors


--=20
Luiz Augusto von Dentz

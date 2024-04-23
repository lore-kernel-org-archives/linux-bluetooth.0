Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C3144D2B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908553; cv=none; b=miDwP9jVVSAEkMaQInQdUR6qbj8VOLkhhAk0ZZeVUQ3N8Kh9NGIPrNdiXfGjC/lHqb+9RSW97ondCLYk5YoGFrcjSKf4xLcezIwMMpc1G/NMm+0F8qRdEwqzCAxd2/W7Z3Pz7gqhgVWGSbngEbTrQ0jOG1F3t3Pf41LXy1+OpXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908553; c=relaxed/simple;
	bh=FxzeCAKhhAQC8bShS2odX1zVu2wAp8EzZFj3d36UOSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQOGgjPhv1kDqgkS0K+HV8g8qWJ1Vq+jwMkZIvLwQpB9QDB5+CQ76fipUpVAWqxwbeT2EDMyvZJsX0QfvYM7ZS7/XJTWJJqkaPRanagxY/CI9v9Mys31xgNc8nGDbi4j9QWUSPqrhKnHBXmPNY4/DDb4mY8tdMhQVaIJSHc5/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwyToPdU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwyToPdU"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so35998421fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713908548; x=1714513348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK3S66CZ3jOBAMM8Ahj5QUvRjjAW/P7JV8sfSMqxrPk=;
        b=KwyToPdUD5+BwcYD8taR1J/P2/KxiuwrIkeLks9wd0PclEeQ2hcn9d6qX36HBacG6X
         qWSXuTnd/mC5ODma5wp9e/O48cnqXQMTxdQUe91BrarwePYKrdLkuFmvSpSdiiyX05Lm
         9S97ruSVCHce07oFxUXv7FDuj9dZvTzt3gmcPh+kjGqJpaATV62RCkUhfZFNK1s0tYTx
         Yl9lW+V4DnjunvA0rNaZxTHsXwvs0QipQcNHrZFxG64zkpq37+EqwbMIMA7NOZAULQeE
         gBm6g79HvJb559FRnodSSl3p1qFDkUDAP/TNVH8wF9o3XFAY3U2DnFhaGNO8ErCpr1BW
         0Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713908548; x=1714513348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK3S66CZ3jOBAMM8Ahj5QUvRjjAW/P7JV8sfSMqxrPk=;
        b=InbGoRs9U1Jo+dEAASwk26BwgbriiQHcLkvwyzAJKyi8Ci4yQ1eixEN2MXbB4k+bXc
         2llQjld1b/17nhmuydnkgVNr6Z0MSypVbc+gIru4XwU/WmUC9pw3AoVpoDqlXq1zYkfP
         jB3lkVjJCXl1SSiAxaVYg1Wq4xsbhA7rm9D5IM/EUsw7rpWyrigJ2gCrSO2gq7rjd6YI
         OE1DwEYrmZ/UUGzGHAMv8l9Jqf3jQFVBiDMY65MRLFg/TO67ybai1SjjJ4uQXzq6Kaaz
         sa/6RoQUA4dG3hZw7z23PIPObl3/9WlF8Yh1hMxi36qzw+dXNEDOoL5yvuZ9/9P6C+4i
         jqQQ==
X-Gm-Message-State: AOJu0YyVDIbuG9x2xi+0NXQkQtU62MzQ8oNzRuGnU+3lyOJEYVMtrUbH
	OTbRiepnK4E0xcCSjcnPB1iZ3JPHSxZpb8q2puSDKHBFfWyxXUyxYoMQlPTxmnowp6Te1Qiaw4i
	1WMM6zFHi6A1eQz7/gPUfdRG1KoFg3w==
X-Google-Smtp-Source: AGHT+IG2ZH6zWBh8/E7nrun1uZmI9B9AitqEAObfmgMcb0ofgkYguS8YBRm6x+3uyVPo5pbHF6DiELqY8PkssCsVLFA=
X-Received: by 2002:a2e:7007:0:b0:2d7:1805:1079 with SMTP id
 l7-20020a2e7007000000b002d718051079mr285462ljc.7.1713908547805; Tue, 23 Apr
 2024 14:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423232622.1142256-1-ajay.k.v@intel.com>
In-Reply-To: <20240423232622.1142256-1-ajay.k.v@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Apr 2024 17:42:14 -0400
Message-ID: <CABBYNZJmg7HKDo_G3K9=WO569ei=4qjpJiMz-NmFnKwDq5GpPw@mail.gmail.com>
Subject: Re: [PATCH v1] bluetoothctl: CCP client interface for bluetoothctl
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ajay,

On Tue, Apr 23, 2024 at 2:04=E2=80=AFPM Ajay KV <ajay.k.v@intel.com> wrote:
>
> Allows bluetoothctl to send CCP client call control
> commands like answer/reject call
> ---
>  Makefile.plugins           |   3 +-
>  Makefile.tools             |   4 +-
>  client/main.c              |   4 +-
>  client/telephony_client.c  | 213 +++++++++++++++++++++++++++++++
>  client/telephony_client.h  |  12 ++
>  profiles/audio/ccp.c       | 150 ++++++++++++++++++----
>  profiles/audio/telephony.c | 173 ++++++++++++++++++++++++++
>  profiles/audio/telephony.h |  65 ++++++++++
>  src/shared/ccp.c           | 249 +++++++++++++++++++++++--------------
>  src/shared/ccp.h           |  19 ++-
>  10 files changed, 765 insertions(+), 127 deletions(-)
>  create mode 100644 client/telephony_client.c
>  create mode 100644 client/telephony_client.h
>  create mode 100644 profiles/audio/telephony.c
>  create mode 100644 profiles/audio/telephony.h
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 4aa2c9c92854..7c0e0bb23560 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -46,7 +46,8 @@ builtin_modules +=3D avrcp
>  builtin_sources +=3D profiles/audio/control.h profiles/audio/control.c \
>                         profiles/audio/avctp.h profiles/audio/avctp.c \
>                         profiles/audio/avrcp.h profiles/audio/avrcp.c \
> -                       profiles/audio/player.h profiles/audio/player.c
> +                       profiles/audio/player.h profiles/audio/player.c\
> +                       profiles/audio/telephony.c profiles/audio/telepho=
ny.h

It should be named ccp.c so we don't give the impression we are going
to write our own telefony stack, etc.

>  endif
>
>  if NETWORK
> diff --git a/Makefile.tools b/Makefile.tools
> index 27a753762d1c..e21f6e8e478e 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -13,7 +13,9 @@ client_bluetoothctl_SOURCES =3D client/main.c \
>                                         client/gatt.h client/gatt.c \
>                                         client/admin.h client/admin.c \
>                                         client/player.h client/player.c \
> -                                       client/mgmt.h client/mgmt.c
> +                                       client/mgmt.h client/mgmt.c \
> +                                       client/telephony_client.c \
> +                                       client/telephony_client.h
>  client_bluetoothctl_LDADD =3D lib/libbluetooth-internal.la \
>                         gdbus/libgdbus-internal.la src/libshared-glib.la =
\
>                         $(GLIB_LIBS) $(DBUS_LIBS) -lreadline
> diff --git a/client/main.c b/client/main.c
> index 51d08a67aa1a..438c45bb9c24 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -34,7 +34,7 @@
>  #include "admin.h"
>  #include "player.h"
>  #include "mgmt.h"
> -
> +#include "telephony_client.h"
>  /* String display constants */
>  #define COLORED_NEW    COLOR_GREEN "NEW" COLOR_OFF
>  #define COLORED_CHG    COLOR_YELLOW "CHG" COLOR_OFF
> @@ -3199,6 +3199,7 @@ int main(int argc, char *argv[])
>
>         admin_add_submenu();
>         player_add_submenu();
> +       telephony_add_submenu();
>         mgmt_add_submenu();
>
>         client =3D g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez"=
);
> @@ -3216,6 +3217,7 @@ int main(int argc, char *argv[])
>
>         admin_remove_submenu();
>         player_remove_submenu();
> +       telephony_remove_submenu();
>         mgmt_remove_submenu();
>
>         g_dbus_client_unref(client);

Replace telephony term with ccp.

> diff --git a/client/telephony_client.c b/client/telephony_client.c
> new file mode 100644
> index 000000000000..121255920dd0
> --- /dev/null
> +++ b/client/telephony_client.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Intel Corporation. All rights reserved.
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
> +#include "gdbus/gdbus.h"
> +#include "lib/bluetooth.h"
> +#include "src/shared/shell.h"
> +#include "print.h"
> +#include "telephony_client.h"
> +
> +/* String display constants */
> +#define COLORED_NEW    COLOR_GREEN "NEW" COLOR_OFF
> +#define COLORED_CHG    COLOR_YELLOW "CHG" COLOR_OFF
> +
> +#define BLUEZ_TELEPHONY_INTERFACE "org.bluez.telephonyCtrl"
> +
> +static DBusConnection *dbus_conn;
> +static GDBusProxy *default_call =3D NULL;
> +static GList *callList =3D NULL;
> +static GDBusClient *client =3D NULL;
> +
> +static char *proxy_description(GDBusProxy *proxy, const char *title,
> +                              const char *description)
> +{
> +       const char *path;
> +
> +       path =3D g_dbus_proxy_get_path(proxy);
> +       return g_strdup_printf("%s%s%s%s %s ",
> +                                       description ? "[" : "",
> +                                       description ? : "",
> +                                       description ? "] " : "",
> +                                       title, path);
> +}
> +
> +static void print_info(void *data, void *user_data)
> +{
> +       GDBusProxy *proxy =3D data;
> +       const char *description =3D user_data;
> +       char *str;
> +
> +       str =3D proxy_description(proxy, "Telephony", description);
> +
> +       bt_shell_printf("%s%s\n", str,
> +                       default_call =3D=3D proxy ? "[default]" : "");
> +
> +       g_free(str);
> +}
> +
> +static void call_reject_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
> +               bt_shell_printf("Failed to reject call: %s\n", error.name=
);
> +               dbus_error_free(&error);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("operation completed\n");
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_reject(int argc, char *argv[])
> +{
> +       if (!default_call) {
> +               bt_shell_printf("No active calls present\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (g_dbus_proxy_method_call(default_call, "reject", NULL,
> +                                    call_reject_reply, NULL, NULL) =3D=
=3D FALSE) {
> +               bt_shell_printf("Failed to reject call\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +}
> +
> +static void call_answer_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
> +               bt_shell_printf("Failed to answer call: %s\n", error.name=
);
> +               dbus_error_free(&error);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("operation completed\n");
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_answer(int argc, char *argv[])
> +{
> +       if (!default_call)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       if (g_dbus_proxy_method_call(default_call, "answer", NULL,
> +                                    call_answer_reply, NULL, NULL) =3D=
=3D FALSE) {
> +               bt_shell_printf("Failed to answer the call\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +}
> +
> +static const struct bt_shell_menu call_menu =3D {
> +       .name =3D "telephony",
> +       .desc =3D "telephony Settings Submenu",
> +       .entries =3D {
> +       { "answer", NULL, cmd_answer, "answer the active call" },
> +       { "reject", NULL, cmd_reject, "reject the active call" },
> +       {} },
> +};
> +
> +static void call_added(GDBusProxy *proxy)
> +{
> +       bt_shell_printf("[CHG] Telephony caller Added\n");
> +       callList =3D g_list_append(callList, proxy);
> +
> +       if (!default_call)
> +               default_call =3D proxy;
> +
> +       print_info(proxy, COLORED_NEW);
> +}
> +
> +static void call_removed(GDBusProxy *proxy)
> +{
> +       bt_shell_printf("[CHG] Telephony caller Removed\n");
> +
> +       if (default_call =3D=3D proxy)
> +               default_call =3D NULL;
> +
> +       callList =3D g_list_remove(callList, proxy);
> +}
> +
> +static void proxy_added(GDBusProxy *proxy, void *user_data)
> +{
> +       const char *interface;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +
> +       if (!strcmp(interface, BLUEZ_TELEPHONY_INTERFACE))
> +               call_added(proxy);
> +}
> +
> +static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +       const char *interface;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +
> +       if (!strcmp(interface, BLUEZ_TELEPHONY_INTERFACE))
> +               call_removed(proxy);
> +}
> +
> +static void telephony_property_changed(GDBusProxy *proxy, const char *na=
me,
> +                                      DBusMessageIter *iter)
> +{
> +       char *str;
> +
> +       str =3D proxy_description(proxy, "Telephony", COLORED_CHG);
> +       print_iter(str, name, iter);
> +       g_free(str);
> +
> +       bt_shell_printf("[CHG] Telephony property : %s\n", name);
> +}
> +
> +static void property_changed(GDBusProxy *proxy, const char *name,
> +                            DBusMessageIter *iter, void *user_data)
> +{
> +       const char *interface;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +
> +       if (!strcmp(interface, BLUEZ_TELEPHONY_INTERFACE))
> +               telephony_property_changed(proxy, name, iter);
> +}
> +
> +void telephony_add_submenu(void)
> +{
> +       bt_shell_add_submenu(&call_menu);
> +
> +       dbus_conn =3D bt_shell_get_env("DBUS_CONNECTION");
> +       if (!dbus_conn || client)
> +               return;
> +
> +       client =3D g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez"=
);
> +
> +       g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_remov=
ed,
> +                                        property_changed, NULL);
> +       g_dbus_client_set_disconnect_watch(client, NULL, NULL);
> +}
> +
> +void telephony_remove_submenu(void)
> +{
> +       g_dbus_client_unref(client);
> +}
> diff --git a/client/telephony_client.h b/client/telephony_client.h
> new file mode 100644
> index 000000000000..15c73f0051e0
> --- /dev/null
> +++ b/client/telephony_client.h
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024 Intel Corporation. All rights reserved.
> + *
> + *
> + */
> +
> +void telephony_add_submenu(void);
> +void telephony_remove_submenu(void);

client/ccp.c and client/ccp.h shall be made into its own set of patches.

> diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
> index fe678de9fede..21f98cfbcfb7 100644
> --- a/profiles/audio/ccp.c
> +++ b/profiles/audio/ccp.c
> @@ -40,7 +40,6 @@
>  #include "src/shared/gatt-db.h"
>  #include "src/shared/gatt-client.h"
>  #include "src/shared/gatt-server.h"
> -#include "src/shared/ccp.h"
>
>  #include "btio/btio.h"
>  #include "src/plugin.h"
> @@ -51,6 +50,8 @@
>  #include "src/service.h"
>  #include "src/log.h"
>  #include "src/error.h"
> +#include "src/shared/ccp.h"
> +#include "telephony.h"
>
>  #define GTBS_UUID_STR "0000184C-0000-1000-8000-00805f9b34fb"
>
> @@ -58,9 +59,132 @@ struct ccp_data {
>         struct btd_device *device;
>         struct btd_service *service;
>         struct bt_ccp *ccp;
> -       unsigned int state_id;
> +       unsigned int call_state_id;
> +       struct telephony_ctrl *tc;
>  };
>
> +static int ct_call_answer(struct telephony_ctrl *tc, void *user_data)
> +{
> +       struct bt_ccp *ccp =3D user_data;
> +
> +       DBG(" status %d index %d", tc->call_status, tc->call_index);
> +
> +       if (tc->call_status =3D=3D CALL_DISCONNECTED)
> +               return -1;
> +
> +       return bt_ccp_call_answer(ccp, tc->call_index);
> +}
> +
> +static int ct_call_reject(struct telephony_ctrl *tc, void *user_data)
> +{
> +       struct bt_ccp *ccp =3D user_data;
> +
> +       DBG(" status %d  index %d", tc->call_status, tc->call_index);
> +
> +       if (tc->call_status =3D=3D CALL_DISCONNECTED)
> +               return -1;
> +
> +       return bt_ccp_call_reject(ccp, tc->call_index);
> +}
> +
> +static const struct telephony_control_callback ct_cbs =3D {
> +       .call_answer =3D &ct_call_answer,
> +       .call_reject =3D &ct_call_reject,
> +};
> +
> +static void cb_call_list_update(struct bt_ccp *ccp,  const uint8_t *buf,
> +                               uint16_t length)
> +{
> +       struct telephony_ctrl *tc =3D bt_ccp_get_user_data(ccp);
> +       struct ccp_call_list_evt *evt;
> +
> +       DBG("");
> +
> +       if (length < sizeof(struct ccp_call_list_evt))
> +               return;
> +
> +       evt =3D (struct ccp_call_list_evt *)buf;
> +       tc->call_index =3D evt->index;
> +       tc->call_status =3D evt->state;
> +
> +       DBG(" status %d  index %d", tc->call_status, tc->call_index);
> +
> +       telephony_update_call_Info(tc);
> +}
> +
> +static void cb_incoming_call(struct bt_ccp *ccp,  const uint8_t *buf,
> +                            uint16_t length)
> +{
> +       struct ccp_incoming_call_evt *evt;
> +       struct telephony_ctrl *tc =3D bt_ccp_get_user_data(ccp);
> +
> +       DBG("");
> +
> +       if (length < sizeof(struct ccp_incoming_call_evt))
> +               return;
> +
> +       evt =3D (struct ccp_incoming_call_evt *)buf;
> +       tc->call_index =3D evt->index;
> +       tc->call_status =3D INCOMING_CALL;
> +
> +       DBG(" status %d  index %d", tc->call_status, tc->call_index);
> +
> +       telephony_update_call_Info(tc);
> +}
> +
> +static void cb_terminate_call(struct bt_ccp *ccp,  const uint8_t *buf,
> +                             uint16_t length)
> +{
> +       struct ccp_call_terminate_evt *evt;
> +       struct telephony_ctrl *tc =3D bt_ccp_get_user_data(ccp);
> +
> +       DBG("");
> +
> +       if (length < sizeof(struct ccp_call_terminate_evt))
> +               return;
> +
> +       evt =3D (struct ccp_call_terminate_evt *)buf;
> +       tc->call_index =3D evt->index;
> +       tc->call_status =3D CALL_DISCONNECTED;
> +
> +       DBG(" status %d  index %d", tc->call_status, tc->call_index);
> +
> +       telephony_update_call_Info(tc);
> +}
> +
> +static const struct bt_ccp_event_callback cbs =3D {
> +       .incoming_call =3D  cb_incoming_call,
> +       .terminate_call =3D  cb_terminate_call,
> +       .call_list_update =3D cb_call_list_update
> +};
> +
> +static int ccp_accept(struct btd_service *service)
> +{
> +       struct btd_device *device =3D btd_service_get_device(service);
> +       struct bt_gatt_client *client =3D btd_device_get_gatt_client(devi=
ce);
> +       struct ccp_data *data =3D btd_service_get_user_data(service);
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("%s", addr);
> +
> +       bt_ccp_attach(data->ccp, client);
> +
> +       data->tc =3D telephony_create_device(device_get_path(device), 0);
> +       if (!data->tc) {
> +               DBG("Unable to create telephony device object");
> +               data->tc =3D NULL;
> +               return -EINVAL;
> +       }
> +
> +       telephony_set_callbacks(data->tc, &ct_cbs, data->ccp);
> +       bt_ccp_set_user_data(data->ccp, data->tc);
> +       bt_ccp_set_event_callbacks(data->ccp, &cbs, data->tc);
> +       btd_service_connecting_complete(service, 0);
> +
> +       return 0;
> +}
> +
>  static void ccp_debug(const char *str, void *user_data)
>  {
>         DBG_IDX(0xffff, "%s", str);
> @@ -140,28 +264,6 @@ static void ccp_remove(struct btd_service *service)
>         ccp_data_remove(data);
>  }
>
> -static int ccp_accept(struct btd_service *service)
> -{
> -       struct btd_device *device =3D btd_service_get_device(service);
> -       struct bt_gatt_client *client =3D btd_device_get_gatt_client(devi=
ce);
> -       struct ccp_data *data =3D btd_service_get_user_data(service);
> -       char addr[18];
> -
> -       ba2str(device_get_address(device), addr);
> -       DBG("%s", addr);
> -
> -       if (!bt_ccp_attach(data->ccp, client)) {
> -               error("CCP unable to attach");
> -               return -EINVAL;
> -       }
> -
> -       /* TODO: register telephony operations here */
> -
> -       btd_service_connecting_complete(service, 0);
> -
> -       return 0;
> -}
> -
>  static int ccp_connect(struct btd_service *service)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
> diff --git a/profiles/audio/telephony.c b/profiles/audio/telephony.c
> new file mode 100644
> index 000000000000..68f27b5471cc
> --- /dev/null
> +++ b/profiles/audio/telephony.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Intel Corporation
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <inttypes.h>
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +#include <glib.h>
> +#include <dbus/dbus.h>
> +#include "gdbus/gdbus.h"
> +
> +#include "src/log.h"
> +#include "src/dbus-common.h"
> +#include "src/error.h"
> +#include "telephony.h"
> +
> +#define BLUEZ_TELEPHONY_INTERFACE "org.bluez.telephonyCtrl"

Don't thing we discussed about doing this sort of split of plugin just
to implement a D-Bus interface, don't see any reason for these changes
not to be part of ccp plugin, also the only reason for ccp plugin to
exist is probably to implement the D-Bus interface, which shall
document first under doc, and Id go with org.bluez.CCPTest1 as
interface and all properties and methods shall be marked as
experimental, in fact we may need a new tag for it since this
interface shall only be exposed when bluetoothd is set to something
like a test mode which can be used for validation purposes, and if
that is not enabled then the test interfaces shall not be enabled
either.

> +struct call_callback {
> +       const struct telephony_control_callback *cbs;
> +       void *user_data;
> +};
> +
> +void telephony_update_call_Info(struct telephony_ctrl *tc)
> +{
> +       DBG("");
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), tc->path,
> +                                    BLUEZ_TELEPHONY_INTERFACE, "call_sta=
te");
> +}
> +
> +static DBusMessage *telephony_answer_call(DBusConnection *conn,
> +                                         DBusMessage *msg, void *data)
> +{
> +       struct telephony_ctrl *tc =3D data;
> +       struct call_callback *cb =3D tc->cb;
> +       int err;
> +
> +       DBG("");
> +       if (!cb->cbs->call_answer)
> +               return btd_error_not_supported(msg);
> +
> +       err =3D cb->cbs->call_answer(tc, cb->user_data);
> +       if (err < 0)
> +               return btd_error_failed(msg, strerror(-err));
> +
> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> +}
> +
> +static DBusMessage *telephony_reject_call(DBusConnection *conn,
> +                                         DBusMessage *msg, void *data)
> +{
> +       struct telephony_ctrl *tc =3D data;
> +       struct call_callback *cb =3D tc->cb;
> +       int err;
> +
> +       DBG("");
> +
> +       if (!cb->cbs->call_reject)
> +               return btd_error_not_supported(msg);
> +
> +       err =3D cb->cbs->call_reject(tc, cb->user_data);
> +       if (err < 0)
> +               return btd_error_failed(msg, strerror(-err));
> +
> +       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
> +}
> +
> +static gboolean ccp_get_index(const GDBusPropertyTable *property,
> +                             DBusMessageIter *iter, void *data)
> +{
> +       struct telephony_ctrl *tc =3D data;
> +       uint32_t index =3D tc->call_index;
> +
> +       DBG("");
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &index);
> +
> +       return TRUE;
> +}
> +
> +static const GDBusSignalTable telephony_signals[] =3D {
> +};
> +
> +/* methods exposed to client to perform call operations */
> +static const GDBusMethodTable telephony_methods[] =3D {
> +       { GDBUS_METHOD("answer", NULL, NULL, telephony_answer_call) },
> +       { GDBUS_METHOD("reject", NULL, NULL, telephony_reject_call) },
> +       { }
> +};
> +
> +/*
> + * Inform registered clients on property changed events
> + * use g_dbus_emit_property_changed() API
> + */
> +static const GDBusPropertyTable telephony_properties[] =3D {
> +       { "call_state", "u", ccp_get_index, NULL, NULL },
> +       { }
> +};
> +
> +void telephony_destroy_device(struct telephony_ctrl *tc)
> +{
> +       DBG("%s", tc->path);
> +
> +       g_dbus_unregister_interface(btd_get_dbus_connection(),
> +                                   tc->path, BLUEZ_TELEPHONY_INTERFACE);
> +
> +       if (tc->path)
> +               g_free(tc->cb);
> +       if (tc->path)
> +               g_free(tc->path);
> +       if (tc->device)
> +               g_free(tc->device);
> +
> +       if (tc)
> +               g_free(tc);
> +}
> +
> +struct telephony_ctrl *telephony_create_device(const char *path, uint16_=
t id)
> +{
> +       struct telephony_ctrl *tc;
> +
> +       DBG("");
> +       tc =3D g_new0(struct telephony_ctrl, 1);
> +       tc->device =3D g_strdup(path);
> +       tc->path =3D g_strdup_printf("%s/Caller%u", path, id);
> +
> +       if (!g_dbus_register_interface(btd_get_dbus_connection(),
> +                                      tc->path, BLUEZ_TELEPHONY_INTERFAC=
E,
> +                                      telephony_methods,
> +                                      telephony_signals,
> +                                      telephony_properties, tc, NULL)) {
> +               error("D-Bus failed to register %s path", tc->path);
> +               telephony_destroy_device(tc);
> +               return NULL;
> +       }
> +
> +       DBG("%s", tc->path);
> +
> +       return tc;
> +}
> +
> +void telephony_set_callbacks(struct telephony_ctrl *tp,
> +                            const struct telephony_control_callback *cbs=
,
> +                            void *user_data)
> +{
> +       struct call_callback *cb;
> +
> +       DBG("");
> +
> +       if (tp->cb)
> +               g_free(tp->cb);
> +
> +       cb =3D g_new0(struct call_callback, 1);
> +       cb->cbs =3D cbs;
> +       cb->user_data =3D user_data;
> +
> +       tp->cb =3D cb;
> +}
> diff --git a/profiles/audio/telephony.h b/profiles/audio/telephony.h
> new file mode 100644
> index 000000000000..e321fb881beb
> --- /dev/null
> +++ b/profiles/audio/telephony.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Intel Corporation
> + *
> + */
> +
> +struct telephony_ctrl {
> +       char    *device;        /* Device path */
> +       char    *path;          /* Telephony object path */
> +       char    *status;
> +       uint8_t call_status;   /* call status of active call*/
> +       uint8_t call_index;    /* call index of active call */
> +       struct  call_callback   *cb;
> +};
> +
> +struct telephony_control_callback {
> +       int (*call_answer)(struct telephony_ctrl *tc, void *user_data);
> +       int (*call_reject)(struct telephony_ctrl *tc, void *user_data);
> +};
> +
> +struct telephony_ctrl *telephony_create_device(const char *path, uint16_=
t id);
> +
> +void telephony_set_callbacks(struct telephony_ctrl *tc,
> +                            const struct telephony_control_callback *cbs=
,
> +                            void *user_data);
> +
> +void telephony_destroy_device(struct telephony_ctrl *tc);
> +
> +void telephony_set_incom_call_settings(struct telephony_ctrl *tc,
> +                                      const char *key, void *data, size_=
t len);
> +void telephony_set_call_termination(struct telephony_ctrl *tc,
> +                                   const char *key, void *data, size_t l=
en);
> +
> +void telephony_update_call_Info(struct telephony_ctrl *tc);
> +
> +struct ccp_call_list_evt {
> +       uint8_t length;
> +       uint8_t index;
> +       uint8_t state;
> +       uint8_t flag;
> +};
> +
> +struct ccp_incoming_call_evt {
> +       uint8_t length;
> +       uint8_t index;
> +};
> +
> +struct ccp_call_terminate_evt {
> +       uint8_t length;
> +       uint8_t index;
> +       uint8_t reason;
> +};
> +
> +enum call_state {
> +       INCOMING_CALL =3D 0,
> +       DIALLING_CALL,
> +       ALERTING_CALL,
> +       ACTIVE_CALL,
> +       LOCAL_HOLD,
> +       REMOTE_HOLD,
> +       CALL_DISCONNECTED =3D 10
> +};

shared/ccp shall be on its own patch as well.

> diff --git a/src/shared/ccp.c b/src/shared/ccp.c
> index 8e1b0b58f93b..25bb39713a13 100644
> --- a/src/shared/ccp.c
> +++ b/src/shared/ccp.c
> @@ -3,7 +3,7 @@
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
> - *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2023  Intel Corporation. All rights reserved.
>   *
>   */
>
> @@ -112,6 +112,55 @@ struct bt_ccs {
>  };
>
>  static struct queue *ccp_db;
> +static struct bt_ccs *ccp_get_ccs(struct bt_ccp *ccp)
> +{
> +       if (!ccp)
> +               return NULL;
> +
> +       if (ccp->rdb->ccs)
> +               return ccp->rdb->ccs;
> +
> +       ccp->rdb->ccs =3D new0(struct bt_ccs, 1);
> +       ccp->rdb->ccs->mdb =3D ccp->rdb;
> +
> +       return ccp->rdb->ccs;
> +}
> +
> +static unsigned int ccp_send(struct bt_ccp *ccp, uint8_t index,
> +                            uint8_t operation)
> +{
> +       int ret;
> +       uint16_t handle;
> +       uint8_t cmd[2];
> +       struct bt_ccs *ccs =3D ccp_get_ccs(ccp);
> +
> +       cmd[0] =3D operation;
> +       cmd[1] =3D index;
> +
> +       if (!ccp->client)
> +               return -1;
> +
> +       if (!gatt_db_attribute_get_char_data(ccs->call_ctrl_point, NULL,
> +                                            &handle, NULL, NULL, NULL))
> +               return -1;
> +
> +       ret =3D bt_gatt_client_write_without_response(ccp->client, handle=
, false,
> +                                                   cmd, 2);
> +       if (!ret)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +unsigned int bt_ccp_call_answer(struct bt_ccp *ccp, uint8_t index)
> +{
> +       return ccp_send(ccp, index, 0);
> +}
> +
> +unsigned int bt_ccp_call_reject(struct bt_ccp *ccp, uint8_t index)
> +{
> +       return ccp_send(ccp, index, 1);
> +}
>
>  static void ccp_debug(struct bt_ccp *ccp, const char *format, ...)
>  {
> @@ -429,20 +478,6 @@ static struct bt_ccs *ccs_new(struct gatt_db *db)
>         return ccs;
>  }
>
> -static struct bt_ccs *ccp_get_ccs(struct bt_ccp *ccp)
> -{
> -       if (!ccp)
> -               return NULL;
> -
> -       if (ccp->rdb->ccs)
> -               return ccp->rdb->ccs;
> -
> -       ccp->rdb->ccs =3D new0(struct bt_ccs, 1);
> -       ccp->rdb->ccs->mdb =3D ccp->rdb;
> -
> -       return ccp->rdb->ccs;
> -}
> -
>  static void ccp_pending_destroy(void *data)
>  {
>         struct bt_ccp_pending *pending =3D data;
> @@ -503,6 +538,8 @@ static void ccp_cb_register(uint16_t att_ecode, void =
*user_data)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> +       DBG(ccp, "");
> +
>         if (att_ecode)
>                 DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
>
> @@ -515,27 +552,41 @@ static void ccp_cb_notify(uint16_t value_handle, co=
nst uint8_t *value,
>          /* TODO: generic handler for non-mandatory CCP notifications */
>  }
>
> -static void ccp_cb_status_flag_register(uint16_t att_ecode, void *user_d=
ata)
> +static void ccp_tc_update_call_list(struct bt_ccp *ccp,
> +                                   const uint8_t *value, uint16_t length=
)
>  {
> -       struct bt_ccp *ccp =3D user_data;
> +       struct event_callback *cb =3D ccp->cb;
>
> -       if (att_ecode)
> -               DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
> +       DBG(ccp, " ");
> +
> +       if (cb && cb->cbs && cb->cbs->call_list_update)
> +               cb->cbs->call_list_update(ccp, value, length);
>  }
>
> -static void ccp_cb_status_flag_notify(uint16_t value_handle,
> -                                     const uint8_t *value,
> -                                     uint16_t length, void *user_data)
> +static void ccp_tc_handle_incoming_call(struct bt_ccp *ccp,
> +                                       const uint8_t *value, uint16_t le=
ngth)
>  {
> -       struct bt_ccp *ccp =3D user_data;
> +       struct event_callback *cb =3D ccp->cb;
>
> -       DBG(ccp, "");
> +       DBG(ccp, " ");
>
> -       if (!length)
> -               return;
> +       if (cb && cb->cbs && cb->cbs->incoming_call)
> +               cb->cbs->incoming_call(ccp, value, length);
>  }
>
> -static void ccp_cb_terminate_register(uint16_t att_ecode, void *user_dat=
a)
> +static void ccp_tc_handle_terminate_call(struct bt_ccp *ccp,
> +                                        const uint8_t *value, uint16_t l=
ength)
> +{
> +       struct event_callback *cb =3D ccp->cb;
> +
> +       DBG(ccp, " ");
> +
> +       if (cb && cb->cbs && cb->cbs->terminate_call)
> +               cb->cbs->terminate_call(ccp, value, length);
> +}
> +
> +/* callback registered function */
> +static void ccp_cb_status_flag_register(uint16_t att_ecode, void *user_d=
ata)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> @@ -543,20 +594,15 @@ static void ccp_cb_terminate_register(uint16_t att_=
ecode, void *user_data)
>                 DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
>  }
>
> -static void ccp_cb_terminate_notify(uint16_t value_handle, const uint8_t=
 *value,
> -                                   uint16_t length, void *user_data)
> +static void ccp_cb_terminate_register(uint16_t att_ecode, void *user_dat=
a)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> -       DBG(ccp, "");
> -
> -       if (!length)
> -               return;
> -
> -       /* TODO: update call state in Local context */
> +       if (att_ecode)
> +               DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
>  }
>
> -static void ccp_cb_bearer_name_register(uint16_t att_ecode, void *user_d=
ata)
> +static void ccp_cb_call_list_register(uint16_t att_ecode, void *user_dat=
a)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> @@ -566,21 +612,17 @@ static void ccp_cb_bearer_name_register(uint16_t at=
t_ecode, void *user_data)
>                 DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
>  }
>
> -static void ccp_cb_bearer_name_notify(uint16_t value_handle,
> -                                     const uint8_t *value,
> -                                     uint16_t length, void *user_data)
> +static void ccp_cb_call_state_register(uint16_t att_ecode, void *user_da=
ta)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
>         DBG(ccp, "");
>
> -       if (!length)
> -               return;
> -
> -       /* TODO: update call details in Local context */
> +       if (att_ecode)
> +               DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
>  }
>
> -static void ccp_cb_call_list_register(uint16_t att_ecode, void *user_dat=
a)
> +static void ccp_cb_incom_call_register(uint16_t att_ecode, void *user_da=
ta)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> @@ -590,51 +632,52 @@ static void ccp_cb_call_list_register(uint16_t att_=
ecode, void *user_data)
>                 DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
>  }
>
> -static void ccp_cb_call_list_notify(uint16_t value_handle, const uint8_t=
 *value,
> -                                   uint16_t length, void *user_data)
> +static void ccp_cb_bearer_name_register(uint16_t att_ecode, void *user_d=
ata)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
>         DBG(ccp, "");
>
> -       if (!length)
> -               return;
> -
> -        /* TODO: update call list in Local context */
> +       if (att_ecode)
> +               DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
>  }
>
> -static void ccp_cb_call_state_register(uint16_t att_ecode, void *user_da=
ta)
> +static void ccp_cb_status_flag_notify(uint16_t value_handle,
> +                                     const uint8_t *value,
> +                                     uint16_t length, void *user_data)
>  {
>         struct bt_ccp *ccp =3D user_data;
> +       DBG(ccp, "length  %d", length);
>
> -       DBG(ccp, "");
> -
> -       if (att_ecode)
> -               DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
> +       if (!length)
> +               return;
>  }
>
> -static void ccp_cb_call_state_notify(uint16_t value_handle,
> -                                    const uint8_t *value,
> -                                    uint16_t length, void *user_data)
> +static void ccp_cb_terminate_notify(uint16_t value_handle,
> +                                   const uint8_t *value,
> +                                   uint16_t length, void *user_data)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> -       DBG(ccp, "");
> +       DBG(ccp, "length  %d", length);
>
>         if (!length)
>                 return;
>
> -       /* TODO: update call state in Local context */
> +       ccp_tc_handle_terminate_call(ccp, value, length);
>  }
>
> -static void ccp_cb_incom_call_register(uint16_t att_ecode, void *user_da=
ta)
> +static void ccp_cb_call_list_notify(uint16_t value_handle, const uint8_t=
 *value,
> +                                   uint16_t length, void *user_data)
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> -       DBG(ccp, "");
> +       DBG(ccp, "length  %d", length);
>
> -       if (att_ecode)
> -               DBG(ccp, "ccp cb notification failed: 0x%04x", att_ecode)=
;
> +       if (!length)
> +               return;
> +
> +       ccp_tc_update_call_list(ccp, value, length);
>  }
>
>  static void ccp_cb_incom_call_notify(uint16_t value_handle,
> @@ -643,12 +686,12 @@ static void ccp_cb_incom_call_notify(uint16_t value=
_handle,
>  {
>         struct bt_ccp *ccp =3D user_data;
>
> -       DBG(ccp, "");
> +       DBG(ccp, "length  %d", length);
>
>         if (!length)
>                 return;
>
> -       /* TODO: Handle incoming call notofiation, Answer/reject etc */
> +       ccp_tc_handle_incoming_call(ccp, value, length);
>  }
>
>  static void bt_ccp_incom_call_attach(struct bt_ccp *ccp)
> @@ -691,7 +734,7 @@ static void bt_ccp_call_state_attach(struct bt_ccp *c=
cp)
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle,
>                                                ccp_cb_call_state_register=
,
> -                                              ccp_cb_call_state_notify, =
ccp,
> +                                              NULL, ccp,
>                                                NULL);
>  }
>
> @@ -735,7 +778,7 @@ static void bt_ccp_name_attach(struct bt_ccp *ccp)
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle,
>                                                ccp_cb_bearer_name_registe=
r,
> -                                              ccp_cb_bearer_name_notify,=
 ccp,
> +                                              NULL, ccp,
>                                                NULL);
>  }
>
> @@ -799,7 +842,7 @@ static void bt_ccp_uci_attach(struct bt_ccp *ccp)
>         ccp->bearer_uci_id =3D bt_gatt_client_register_notify(ccp->client=
,
>                                                             value_handle,
>                                                             ccp_cb_regist=
er,
> -                                                           ccp_cb_notify=
, ccp,
> +                                                           NULL, ccp,
>                                                             NULL);
>  }
>
> @@ -820,7 +863,7 @@ static void bt_ccp_technology_attach(struct bt_ccp *c=
cp)
>         ccp->bearer_technology_id =3D
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle, ccp_cb_regis=
ter,
> -                                              ccp_cb_notify, ccp, NULL);
> +                                              NULL, ccp, NULL);
>  }
>
>  static void bt_ccp_strength_attach(struct bt_ccp *ccp)
> @@ -839,7 +882,7 @@ static void bt_ccp_strength_attach(struct bt_ccp *ccp=
)
>
>         ccp->signal_strength_id =3D
>                 bt_gatt_client_register_notify(ccp->client, value_handle,
> -                                              ccp_cb_register, ccp_cb_no=
tify,
> +                                              ccp_cb_register, NULL,
>                                                ccp, NULL);
>  }
>
> @@ -859,7 +902,7 @@ static void bt_ccp_ccid_attach(struct bt_ccp *ccp)
>         ccp->ccid_id =3D bt_gatt_client_register_notify(ccp->client,
>                                                       value_handle,
>                                                       ccp_cb_register,
> -                                                     ccp_cb_notify, ccp,=
 NULL);
> +                                                     NULL, ccp, NULL);
>  }
>
>  static void bt_ccp_tar_uri_attach(struct bt_ccp *ccp)
> @@ -879,7 +922,7 @@ static void bt_ccp_tar_uri_attach(struct bt_ccp *ccp)
>         ccp->target_bearer_uri_id =3D
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle, ccp_cb_regis=
ter,
> -                                              ccp_cb_notify, ccp,
> +                                              NULL, ccp,
>                                                NULL);
>  }
>
> @@ -900,7 +943,7 @@ static void bt_ccp_ctrl_point_attach(struct bt_ccp *c=
cp)
>         ccp->call_control_pt_id =3D
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle, ccp_cb_regis=
ter,
> -                                              ccp_cb_notify, ccp, NULL);
> +                                              NULL, ccp, NULL);
>  }
>
>  static void bt_ccp_ctrl_opcode_attach(struct bt_ccp *ccp)
> @@ -920,7 +963,7 @@ static void bt_ccp_ctrl_opcode_attach(struct bt_ccp *=
ccp)
>         ccp->call_control_opt_opcode_id =3D
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle, ccp_cb_regis=
ter,
> -                                              ccp_cb_notify, ccp, NULL);
> +                                              NULL, ccp, NULL);
>  }
>
>  static void bt_ccp_friendly_name_attach(struct bt_ccp *ccp)
> @@ -940,7 +983,7 @@ static void bt_ccp_friendly_name_attach(struct bt_ccp=
 *ccp)
>         ccp->friendly_name_id =3D
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle, ccp_cb_regis=
ter,
> -                                              ccp_cb_notify, ccp, NULL);
> +                                              NULL, ccp, NULL);
>  }
>
>  static void bt_ccp_signal_intrvl_attach(struct bt_ccp *ccp)
> @@ -960,7 +1003,7 @@ static void bt_ccp_signal_intrvl_attach(struct bt_cc=
p *ccp)
>         ccp->signal_reporting_intrvl_id =3D
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle, ccp_cb_regis=
ter,
> -                                              ccp_cb_notify, ccp, NULL);
> +                                              NULL, ccp, NULL);
>  }
>
>  static void bt_ccp_uri_list_attach(struct bt_ccp *ccp)
> @@ -980,7 +1023,7 @@ static void bt_ccp_uri_list_attach(struct bt_ccp *cc=
p)
>         ccp->bearer_uri_schemes_list_id =3D
>                 bt_gatt_client_register_notify(ccp->client,
>                                                value_handle, ccp_cb_regis=
ter,
> -                                              ccp_cb_notify, ccp, NULL);
> +                                              NULL, ccp, NULL);
>  }
>
>  static void foreach_ccs_char(struct gatt_db_attribute *attr, void *user_=
data)
> @@ -988,7 +1031,8 @@ static void foreach_ccs_char(struct gatt_db_attribut=
e *attr, void *user_data)
>         struct bt_ccp *ccp =3D user_data;
>         struct bt_ccs *ccs;
>         uint16_t value_handle;
> -       bt_uuid_t uuid;
> +       bt_uuid_t uuid, uuid16;
> +       uint16_t be16;
>
>         if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
>                                              NULL, NULL, &uuid))
> @@ -998,105 +1042,122 @@ static void foreach_ccs_char(struct gatt_db_attr=
ibute *attr, void *user_data)
>         if (!ccs || ccs->call_state)
>                 return;
>
> -       if (bt_uuid16_cmp(&uuid, BEARER_PROVIDER_NAME_CHRC_UUID)) {
> +       uuid16.type  =3D  uuid.type;
> +
> +       if (uuid.type =3D=3D BT_UUID16) {
> +               DBG(ccp, "uuid %x", uuid.value.u16);
> +               uuid16.value.u16 =3D uuid.value.u16;
> +       } else if (uuid.type =3D=3D BT_UUID128) {
> +               DBG(ccp, "uuid is u128 ");
> +               uuid16.type =3D BT_UUID16;
> +               memcpy(&be16, &uuid.value.u128.data[2], 2);
> +               uuid16.value.u16 =3D htons(be16);
> +       } else {
> +               DBG(ccp, "unexpected uuid type %d", uuid16.type);
> +               return;
> +       }
> +
> +       DBG(ccp, "uuid read from gatt database %x", uuid16.value.u16);
> +
> +       if (bt_uuid16_cmp(&uuid16, BEARER_PROVIDER_NAME_CHRC_UUID)) {
>                 DBG(ccp, "Found Bearer Name, handle 0x%04x", value_handle=
);
>
>                 ccs->bearer_name =3D attr;
>                 bt_ccp_name_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, BEARER_UCI_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, BEARER_UCI_CHRC_UUID)) {
>                 DBG(ccp, "Found Bearer Uci, handle 0x%04x", value_handle)=
;
>
>                 ccs->bearer_uci =3D attr;
>                 bt_ccp_uci_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, BEARER_TECH_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, BEARER_TECH_CHRC_UUID)) {
>                 DBG(ccp, "Found Bearer Technology, handle %x", value_hand=
le);
>
>                 ccs->bearer_technology =3D attr;
>                 bt_ccp_technology_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, BEARER_SIGNAL_STR_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, BEARER_SIGNAL_STR_CHRC_UUID)) {
>                 DBG(ccp, "Found Signal Strength, handle 0x%04x", value_ha=
ndle);
>
>                 ccs->signal_strength =3D attr;
>                 bt_ccp_strength_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, BEARER_SIGNAL_INTRVL_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, BEARER_SIGNAL_INTRVL_CHRC_UUID)) {
>                 DBG(ccp, "Found Signal Interval, handle 0x%04x", value_ha=
ndle);
>
>                 ccs->signal_reporting_intrvl =3D attr;
>                 bt_ccp_signal_intrvl_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, CALL_STATUS_FLAG_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, CALL_STATUS_FLAG_CHRC_UUID)) {
>                 DBG(ccp, "Found Status Flag, handle 0x%04x", value_handle=
);
>
>                 ccs->status_flag =3D attr;
>                 bt_ccp_status_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, BEARER_URI_SCHEME_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, BEARER_URI_SCHEME_CHRC_UUID)) {
>                 DBG(ccp, "Found URI Scheme, handle 0x%04x", value_handle)=
;
>
>                 ccs->bearer_uri_schemes_list =3D attr;
>                 bt_ccp_uri_list_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, CURR_CALL_LIST_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, CURR_CALL_LIST_CHRC_UUID)) {
>                 DBG(ccp, "Found Call List, handle 0x%04x", value_handle);
>
>                 ccs->current_call_list =3D attr;
>                 bt_ccp_call_list_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, BEARER_CCID_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, BEARER_CCID_CHRC_UUID)) {
>                 DBG(ccp, "Found CCID, handle 0x%04x", value_handle);
>
>                 ccs->ccid =3D attr;
>                 bt_ccp_ccid_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, INCOM_CALL_TARGET_URI_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, INCOM_CALL_TARGET_URI_CHRC_UUID)) {
>                 DBG(ccp, "Found Bearer Uri, handle 0x%04x", value_handle)=
;
>
>                 ccs->target_bearer_uri =3D attr;
>                 bt_ccp_tar_uri_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, CALL_CTRL_POINT_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, CALL_CTRL_POINT_CHRC_UUID)) {
>                 DBG(ccp, "Found Control Point, handle 0x%04x", value_hand=
le);
>
>                 ccs->call_ctrl_point =3D attr;
>                 bt_ccp_ctrl_point_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, CALL_CTRL_POINT_OPT_OPCODE_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, CALL_CTRL_POINT_OPT_OPCODE_CHRC_UUID))=
 {
>                 DBG(ccp, "Found Control opcode, handle 0x%04x", value_han=
dle);
>
>                 ccs->call_ctrl_opt_opcode =3D attr;
>                 bt_ccp_ctrl_opcode_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, TERMINATION_REASON_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, TERMINATION_REASON_CHRC_UUID)) {
>                 DBG(ccp, "Found Termination Reason, handle %x", value_han=
dle);
>
>                 ccs->termination_reason =3D attr;
>                 bt_ccp_term_reason_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, INCOMING_CALL_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, INCOMING_CALL_CHRC_UUID)) {
>                 DBG(ccp, "Found Incoming call, handle 0x%04x", value_hand=
le);
>
>                 ccs->incoming_call =3D attr;
>                 bt_ccp_incom_call_attach(ccp);
>         }
>
> -       if (bt_uuid16_cmp(&uuid, CALL_FRIENDLY_NAME_CHRC_UUID)) {
> +       if (bt_uuid16_cmp(&uuid16, CALL_FRIENDLY_NAME_CHRC_UUID)) {
>                 DBG(ccp, "Found Friendly name, handle 0x%04x", value_hand=
le);
>
>                 ccs->friendly_name =3D attr;
> diff --git a/src/shared/ccp.h b/src/shared/ccp.h
> index 28b8b034ece3..3298abe9014c 100644
> --- a/src/shared/ccp.h
> +++ b/src/shared/ccp.h
> @@ -3,7 +3,7 @@
>   *
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
> - *  Copyright (C) 2020  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2023  Intel Corporation. All rights reserved.
>   *
>   */
>
> @@ -18,14 +18,18 @@ struct bt_ccp;
>  struct bt_ccp_db;
>  struct bt_ccp_session_info;
>
> -typedef void (*bt_ccp_debug_func_t)(const char *str, void *user_data);
> -typedef void (*bt_ccp_destroy_func_t)(void *user_data);
> -
>  struct bt_ccp_event_callback {
> -       void (*call_state)(struct bt_ccp *ccp,  const uint8_t *value,
> -                          uint16_t length);
> +       void (*incoming_call)(struct bt_ccp *ccp,
> +                             const uint8_t *value, uint16_t len);
> +       void (*terminate_call)(struct bt_ccp *ccp,
> +                              const uint8_t *value, uint16_t len);
> +       void (*call_list_update)(struct bt_ccp *ccp,
> +                                const uint8_t *value, uint16_t len);
>  };
>
> +typedef void (*bt_ccp_debug_func_t)(const char *str, void *user_data);
> +typedef void (*bt_ccp_destroy_func_t)(void *user_data);
> +
>  void bt_ccp_set_event_callbacks(struct bt_ccp *ccp,
>                                 const struct bt_ccp_event_callback *cbs,
>                                 void *user_data);
> @@ -43,3 +47,6 @@ void bt_ccp_unref(struct bt_ccp *ccp);
>
>  bool bt_ccp_set_user_data(struct bt_ccp *ccp, void *user_data);
>  void *bt_ccp_get_user_data(struct bt_ccp *ccp);
> +
> +unsigned int bt_ccp_call_answer(struct bt_ccp *ccp, uint8_t index);
> +unsigned int bt_ccp_call_reject(struct bt_ccp *ccp, uint8_t index);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz

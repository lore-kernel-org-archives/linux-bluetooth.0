Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D38158873
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024670; cv=none; b=M9sPGCJkJwfcWWCPrKz//YH0qf5flRZJF5lZen9NldxeVznY0zI6GBNgsuujPkYgNPsE617ni3hUtS3MLdZTG8N3hVDUAGz68/nzoQRtbQLI6UVN9iGZXFY4UppBL8jZlAathMrHrPtx+mVVX2uMcfo+4jJB+v7mpDchictuU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024670; c=relaxed/simple;
	bh=10Ej75FdaE45KrUffZNBgE/ymdjPO6npQkHuV+gXOOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJcUPYHSLvsWn3yLF5Bkd+TUTNrm2AykSur/UbYQeqWMJArL+5be5M/uQgXYLy8VObhWJgq+SMIhpWRvVBSgIz5KKbCBc+Gtbwr9Do7aoKt4L9WL4g1eIRCC0dHvQIGXQBJJhkKwoMJdpIXFrsl+qDQBmYkZxTSdLqIPPLh16m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIDmZqb7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIDmZqb7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so29490881fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2024 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024667; x=1715629467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nowr/I6PbGtmXwkZ4g6TiSy87XL+NgkEmsLVdjCheCc=;
        b=dIDmZqb7pZTtzCXhvMILuAjJ2vhvQIEkgwV5Bz/6BkPlCY9rz2QGJdLUHuhLbo40BF
         ksigpXbwbN8SdgGMcCWmcXxZuZvUhyl7+NJCIjlWNMRwb3GUwD8mxu1VBN1eXh/Z5wlD
         Y0ZTN3AhR78KmgMpl7tn9dIxcQtplV13tZ3ux+dd9zBXy4Wg8IYd6Vx/phLHa60tDi2I
         VRsZJu94pMAafKOuKfT/R7lNcm9t/MAHEOcgGff0pZ9+6dYv2Lx4oe/Un3sPsApONShF
         nqpvEdp06IGgMcbYK2VX14lKuZL8XL2hpGwDagUb/SZfDPu2QEOaJeAUIFMLXU7XtrwY
         0v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024667; x=1715629467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nowr/I6PbGtmXwkZ4g6TiSy87XL+NgkEmsLVdjCheCc=;
        b=tEWRcREFZ5MQL+Fh7USz7Cr2AhDa62gJnshQKxcU2aUPOWriKWOkprmtu9go2qYApQ
         wR0VKHrY/yPVSIk/F6UkHdsaFzwnskO1Qs9ubSV62hU783pqUABWUMN2xSUI5UaiwUH6
         OFKfJ/IwJsfZfD4wD2Mm/FOqxEl4g/OvQVLRYvQZPhfGG/1pNdrsnWNeOTPWvFqCymz0
         cLWB7kHa+SGOGAG/BL9PXMx/mg5T1Ixv/+DBMaAR9b2M58efDrmRHziMSou4sAhDStP7
         6PaziaIEeB1Y8Zm/hez/0UFDT8Tc63cDyR+UGBLO2rGbPfaV7EK3+1+iu3sp2g6bwn/V
         NqUA==
X-Gm-Message-State: AOJu0YxFxN/TvqGD1u7yOhVFCS9Nt09vro3WEwfxe4/orFsvcvJkQPYY
	g+o61RySjYEol1ZjBpvsOFipV5OCnwUnvabFQi8b76VFmjq/5XVE/mmC00YXXJ/OdutrWcJpeSl
	CcLDxmJUwVOBJAhg2fQrhqhuTaD6t1w==
X-Google-Smtp-Source: AGHT+IHzZR0x0z2VCMKft8DYMikvwopNkdAK1ukweecQzTx0L7xp+mR0n5VpNmkcsHXFROXnp8Lp65PQWYeToze6O3A=
X-Received: by 2002:a2e:a9a4:0:b0:2e0:3f37:5af1 with SMTP id
 x36-20020a2ea9a4000000b002e03f375af1mr9095573ljq.33.1715024666494; Mon, 06
 May 2024 12:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506235643.114778-1-ajay.k.v@intel.com>
In-Reply-To: <20240506235643.114778-1-ajay.k.v@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 May 2024 15:44:13 -0400
Message-ID: <CABBYNZL7iKRTFsuyHKZixg8D7BzKKsA3QLy2iVL_N_qxsY5gNw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] bluetoothctl: Add submenu for Call control
 profile testing
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ajay,

On Mon, May 6, 2024 at 2:30=E2=80=AFPM Ajay KV <ajay.k.v@intel.com> wrote:
>
> This adds submeu in bluetoothctl for CCP Testing with
> options like answer and reject the active call . This feature
> is tested with windows machnine as CCP server which uses Teams
> application to make calls
>
> Signed-off-by: Ajay KV <ajay.k.v@intel.com>
> ---
>  Makefile.tools    |   4 +-
>  client/ccp_test.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++
>  client/ccp_test.h |  12 +++
>  client/main.c     |   5 +-
>  4 files changed, 231 insertions(+), 2 deletions(-)
>  create mode 100644 client/ccp_test.c
>  create mode 100644 client/ccp_test.h
>
> diff --git a/Makefile.tools b/Makefile.tools
> index 679c914bf8cd..a5587427f549 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -13,7 +13,9 @@ client_bluetoothctl_SOURCES =3D client/main.c \
>                                         client/gatt.h client/gatt.c \
>                                         client/admin.h client/admin.c \
>                                         client/player.h client/player.c \
> -                                       client/mgmt.h client/mgmt.c
> +                                       client/mgmt.h client/mgmt.c \
> +                                       client/ccp_test.c \
> +                                       client/ccp_test.h
>  client_bluetoothctl_LDADD =3D lib/libbluetooth-internal.la \
>                         gdbus/libgdbus-internal.la src/libshared-glib.la =
\
>                         $(GLIB_LIBS) $(DBUS_LIBS) -lreadline
> diff --git a/client/ccp_test.c b/client/ccp_test.c
> new file mode 100644
> index 000000000000..d53fc2393c13
> --- /dev/null
> +++ b/client/ccp_test.c
> @@ -0,0 +1,212 @@
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
> +#include "ccp_test.h"
> +
> +/* String display constants */
> +#define COLORED_NEW    COLOR_GREEN "NEW" COLOR_OFF
> +#define COLORED_CHG    COLOR_YELLOW "CHG" COLOR_OFF
> +
> +#define BLUEZ_CCP_TEST_INTERFACE "org.bluez.CCPTest1"

We probably need to start with the documentation of
org.bluez.CPPTest1, there is quite a few documentation under
doc/org.bluez*.rst.

> +
> +static DBusConnection *dbus_conn;
> +static GDBusProxy *default_call;
> +static GList *callList;
> +static GDBusClient *client;
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
> +       str =3D proxy_description(proxy, "CCPTest", description);
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
> +       .name =3D "ccp test",

I'd call it just ccp otherwise you may break autocomplete support by
adding spaces in between, in case you don't know bluetoothctl does
accept entering commands in a submenu.command format (e.g.
cpp.answer).

> +       .desc =3D "ccp test settings submenu",
> +       .entries =3D {
> +                   { "answer", NULL, cmd_answer, "answer the active call=
" },
> +                   { "reject", NULL, cmd_reject, "reject the active call=
" },
> +                  },

I guess we will need to add something like as "[call]" as parameter if
the intention is handle multiple calls simultaneously which if I
recall correctly is possible with CCP, btw I add as well command such
as list, to list current call objects and perhap a show command as
well to inspect the objects, but that can be done at a later stage if
you prefer that way.

> +};
> +
> +static void ccp_add_call(GDBusProxy *proxy)
> +{
> +       bt_shell_printf("[CHG] CCP Test caller added\n");
> +       callList =3D g_list_append(callList, proxy);
> +
> +       if (!default_call)
> +               default_call =3D proxy;
> +
> +       print_info(proxy, COLORED_NEW);
> +}
> +
> +static void ccp_remove_call(GDBusProxy *proxy)
> +{
> +       bt_shell_printf("[CHG] CCP Test caller removed\n");
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
> +       if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
> +               ccp_add_call(proxy);
> +}
> +
> +static void proxy_removed(GDBusProxy *proxy, void *user_data)
> +{
> +       const char *interface;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +
> +       if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
> +               ccp_remove_call(proxy);
> +}
> +
> +static void ccptest_property_changed(GDBusProxy *proxy, const char *name=
,
> +                                    DBusMessageIter *iter)
> +{
> +       char *str;
> +
> +       str =3D proxy_description(proxy, "CCP Test", COLORED_CHG);
> +       print_iter(str, name, iter);
> +       g_free(str);
> +
> +       bt_shell_printf("[CHG] CCP Test property : %s\n", name);
> +}
> +
> +static void property_changed(GDBusProxy *proxy, const char *name,
> +                            DBusMessageIter *iter, void *user_data)
> +{
> +       const char *interface;
> +
> +       interface =3D g_dbus_proxy_get_interface(proxy);
> +
> +       if (!strcmp(interface, BLUEZ_CCP_TEST_INTERFACE))
> +               ccptest_property_changed(proxy, name, iter);
> +}
> +
> +void ccptest_add_submenu(void)
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
> +void ccptest_remove_submenu(void)
> +{
> +       g_dbus_client_unref(client);
> +}
> diff --git a/client/ccp_test.h b/client/ccp_test.h
> new file mode 100644
> index 000000000000..fc2ab2042bb8
> --- /dev/null
> +++ b/client/ccp_test.h
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
> +void ccptest_add_submenu(void);
> +void ccptest_remove_submenu(void);
> diff --git a/client/main.c b/client/main.c
> index c8b0f7f1c2d8..dba6dea639d9 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -34,6 +34,7 @@
>  #include "admin.h"
>  #include "player.h"
>  #include "mgmt.h"
> +#include "ccp_test.h"
>
>  /* String display constants */
>  #define COLORED_NEW    COLOR_GREEN "NEW" COLOR_OFF
> @@ -3060,7 +3061,7 @@ static const struct bt_shell_menu gatt_menu =3D {
>                                         "Unregister application service" =
},
>         { "register-includes", "<UUID> [handle]", cmd_register_includes,
>                                         "Register as Included service in.=
" },
> -       { "unregister-includes", "<Service-UUID> <Inc-UUID>",
> +       { "unregister-includes", "<Service-UUID><Inc-UUID>",
>                         cmd_unregister_includes,
>                                  "Unregister Included service." },
>         { "register-characteristic",
> @@ -3199,6 +3200,7 @@ int main(int argc, char *argv[])
>
>         admin_add_submenu();
>         player_add_submenu();
> +       ccptest_add_submenu();
>         mgmt_add_submenu();
>
>         client =3D g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez"=
);
> @@ -3216,6 +3218,7 @@ int main(int argc, char *argv[])
>
>         admin_remove_submenu();
>         player_remove_submenu();
> +       ccptest_remove_submenu();
>         mgmt_remove_submenu();
>
>         g_dbus_client_unref(client);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz

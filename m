Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F64C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 18:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjHGSHX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjHGSHW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 14:07:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F6FA6
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 11:07:19 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so77140291fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 11:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691431638; x=1692036438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhgR69gZTryS2Trz0dNIchpm+R+Fb62Bnh9XcToZHmc=;
        b=YosQKQNQkFWwItGtHDDAzEK4ns/U//lSuA6miCrf26XMRmXJgIBeLYkLrk2qqovxhD
         Zo+SGdkkJrro42L2BwFZiz4hg7tIgboPPNzyS4bgiI7Q0SGVuTpapvFbBt9TfV+8gRLB
         LpVfc1zBrgP8LBOsIkJyoZ3pi5VMFkiyM5YNS/9IQfGG8VThxOm83QeqlmQ/NP/gTDs4
         a8d+ByIlGuDYBzxRCGGOrTQNYumeZGTDuHcyuLpuLSdxy+3Tg0ip+NZC9tcmn3OxfzLo
         leyYUa3kaVfcYc8kJzvh+LTd4plKImHPDyobVt9KEDe5sMSxHCLtXgVV2bgsKVCn7mWj
         OA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691431638; x=1692036438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhgR69gZTryS2Trz0dNIchpm+R+Fb62Bnh9XcToZHmc=;
        b=X22cEUmA6EamZB+WYSfm8Dyk8xfizzHl5mpcapQXIiw6E2Y4sKgjH1rZfuVpwu2Hyx
         Z2KBrrwFn+JllNW90DF3580cYqxXk3SMEfMs9sI4L0SI0qt5ew4hH5KHulO2vOrqZJ2m
         2bidE9Vs9xGXgK1FmV/k70pavk07dxTXKIpscivtuG8NogG6gumj9PA4CH2D7tt23s94
         2v/6IYUZkbetsNO5pstxcroBnW3zyT64GuGGGb5B113Ueprt0/6Ledb5Wn1NWl9dUZYO
         dJEVMPEFYg+9Bx7gNashZJ9raUQ46dVVMnQxHGtFlQuQvV2Z194Xsz17J+Hs46BP1VlP
         2Mlg==
X-Gm-Message-State: AOJu0Yyt7nz08do4RL55/SkclKiLBTvZ3ds6iaIDh7g33IkshyWtPpyZ
        BNdWNUiXm1+XNzvqWOVyoe9yy31KjUg5Uqo2Bs83jPG/
X-Google-Smtp-Source: AGHT+IE1VKoWBZ/rKNe+HS87fdxx0I+lV6oL/xsIdTMsinTUrHkXGbhky41BcTjmjTNgdbsZxQ7f5+SGvFaUqVHubow=
X-Received: by 2002:a2e:7e0f:0:b0:2b9:f3ca:e35b with SMTP id
 z15-20020a2e7e0f000000b002b9f3cae35bmr6529275ljc.44.1691431637492; Mon, 07
 Aug 2023 11:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230803072011.191449-1-mahesh.talewad@nxp.com> <20230803072011.191449-3-mahesh.talewad@nxp.com>
In-Reply-To: <20230803072011.191449-3-mahesh.talewad@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Aug 2023 11:07:05 -0700
Message-ID: <CABBYNZLf2zn2MqiREs6m-Z1nvp7siDKSOYD5FhNJubOwm0t+WA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/3] client/player: Add interface menu to
 configure MICP-MICS during PTS testing.
To:     Mahesh Talewad <mahesh.talewad@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Mahesh,

On Thu, Aug 3, 2023 at 12:20=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> - Includes implementations required for PTS testing for MICS and MICP.
> - Interface given in bluetoothctl/player menu for sending MICS and MICP
> commands while excecuting PTS test cases. Tested all MICP and MICS PTS
> test cases[LE] and all are passed.
> - Added flag - MICP_MICS_PTS_FLAG in configure.ac which enable/disable
> PTS testing related code during compilation. uncomment this flag in
> configure.ac inorder to enable PTS testing related code and comment
> it for disable. By default this flag is disabled.

We could perhaps have a more generic solution that the testing
interfaces with a testing flag, which we can perhaps enable at
runtime, that said in the past we took a different approach of having
a dedicated tool for testing protocols (e.g. avtest), but I think I
would rather do this with bluetoothctl nowadays.

> - Spec implementation/PTS testing:
> MICS - MICS_v1.0.pdf
> MICP - MICP_v1.0.pdf
> PTS Testing MICS: MICS.TS.p0ed2.pdf
> PTS Testing MICP: MICP.TS.p3.pdf
> ---
>  client/main.c     |  12 ++++
>  client/player.c   | 164 ++++++++++++++++++++++++++++++++++++++++++++++
>  client/player.h   |   4 ++
>  configure.ac      |   3 +
>  src/adapter.c     |  87 ++++++++++++++++++++++++
>  src/shared/micp.c | 122 ++++++++++++++++++++++++++++++++++
>  src/shared/micp.h |   8 +++
>  7 files changed, 400 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 0eac5bdf5..d7c735d19 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -413,6 +413,10 @@ static struct adapter *adapter_new(GDBusProxy *proxy=
)
>         if (!default_ctrl)
>                 default_ctrl =3D adapter;
>
> +#ifdef MICP_MICS_PTS_FLAG
> +       mics_set_proxy((void *)adapter);
> +#endif /* MICP_MICS_PTS_FLAG */

At the client side we should probably do a runtime detection, by
checking if a specific interface is supported, rather than depend on a
compilation flag since you may have the client and daemon coming from
different packages.

>         return adapter;
>  }
>
> @@ -892,6 +896,10 @@ static void cmd_show(int argc, char *argv[])
>                 }
>         }
>
> +#ifdef MICP_MICS_PTS_FLAG
> +       mics_set_proxy((void *)adapter);
> +#endif /*MICP_MICS_PTS_FLAG*/
> +
>         if (!g_dbus_proxy_get_property(adapter->proxy, "Address", &iter))
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>
> @@ -951,6 +959,10 @@ static void cmd_select(int argc, char *argv[])
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> +#ifdef MICP_MICS_PTS_FLAG
> +       mics_set_proxy((void *)adapter);
> +#endif /*MICP_MICS_PTS_FLAG*/
> +
>         if (default_ctrl && default_ctrl->proxy =3D=3D adapter->proxy)
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>
> diff --git a/client/player.c b/client/player.c
> index e5084967a..2e48025e8 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -596,6 +596,153 @@ static void cmd_show_item(int argc, char *argv[])
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> +#ifdef MICP_MICS_PTS_FLAG
> +struct mics_adapter {
> +       GDBusProxy *proxy;
> +};
> +static struct mics_adapter *mics_default_ctrl;
> +void mics_set_proxy(void *proxy)
> +{
> +       mics_default_ctrl =3D (struct mics_adapter *)proxy;
> +       if (mics_default_ctrl =3D=3D NULL) {
> +               bt_shell_printf("mics_default_ctrl is NULL\n");
> +               return;
> +       }
> +}
> +static gboolean parse_argument(int argc, char *argv[], const char **arg_=
table,
> +                                       const char *msg, dbus_bool_t *val=
ue,
> +                                       const char **option)
> +{
> +       const char **opt;
> +
> +       if (!strcmp(argv[1], "help")) {
> +               for (opt =3D arg_table; opt && *opt; opt++)
> +                       bt_shell_printf("%s\n", *opt);
> +               bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +               return FALSE;
> +       }
> +
> +       if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes")) {
> +               *value =3D TRUE;
> +               if (option)
> +                       *option =3D "";
> +               return TRUE;
> +       }
> +
> +       if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no")) {
> +               *value =3D FALSE;
> +               return TRUE;
> +       }
> +
> +       for (opt =3D arg_table; opt && *opt; opt++) {
> +               if (strcmp(argv[1], *opt) =3D=3D 0) {
> +                       *value =3D TRUE;
> +                       *option =3D *opt;
> +                       return TRUE;
> +               }
> +       }
> +
> +       bt_shell_printf("Invalid argument %s\n", argv[1]);
> +       return FALSE;
> +}
> +
> +static void cmd_set_mute_state(int argc, char *argv[])
> +{
> +       dbus_bool_t mute_state;
> +       char *str;
> +
> +       if (!parse_argument(argc, argv, NULL, NULL, &mute_state, NULL))
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       str =3D g_strdup_printf("mics %s", mute_state =3D=3D TRUE ? "on" =
: "off");
> +
> +       if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy, "mi=
cs",
> +                                       DBUS_TYPE_BOOLEAN, &mute_state,
> +                                       generic_callback, str, g_free) =
=3D=3D TRUE)
> +               return;
> +       g_free(str);
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
> +static void cmd_enable_disable_mute_state(int argc, char *argv[])
> +{
> +       dbus_bool_t mute_state;
> +       char *str;
> +
> +       if (!parse_argument(argc, argv, NULL, NULL, &mute_state, NULL))
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       str =3D g_strdup_printf("mics %s", mute_state =3D=3D TRUE ? "on" =
: "off");
> +
> +       if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
> +                               "mics_state", DBUS_TYPE_BOOLEAN, &mute_st=
ate,
> +                               generic_callback, str, g_free) =3D=3D TRU=
E)
> +               return;
> +       g_free(str);
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
> +static void cmd_micp_discover_mute(int argc, char *argv[])
> +{
> +       dbus_bool_t mute_state =3D 0;
> +       char *str;
> +
> +
> +       if (!parse_argument(argc, argv, NULL, NULL, &mute_state, NULL))
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       str =3D g_strdup_printf("mics %s", mute_state =3D=3D TRUE ? "on" =
: "off");
> +
> +       if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
> +                               "micp_disc", DBUS_TYPE_BOOLEAN, &mute_sta=
te,
> +                               generic_callback, str, g_free) =3D=3D TRU=
E)
> +               return;
> +       g_free(str);
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
> +static void cmd_enable_read_mute_state(int argc, char *argv[])
> +{
> +       char *endptr =3D NULL;
> +       int handle;
> +
> +       handle =3D strtol(argv[1], &endptr, 0);
> +       if (!endptr || *endptr !=3D '\0' || handle > UINT16_MAX) {
> +               bt_shell_printf("Invalid argument: %s\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +       bt_shell_printf("%s: %x\n", __func__, handle);
> +       if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
> +                               "micp_read_char", DBUS_TYPE_UINT16, &hand=
le,
> +                               generic_callback, NULL, NULL) =3D=3D TRUE=
)
> +               return;
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +
> +static void cmd_enable_write_mute_state(int argc, char *argv[])
> +{
> +       char *endptr =3D NULL;
> +       int handle;
> +
> +       handle =3D strtol(argv[1], &endptr, 0);
> +       if (!endptr || *endptr !=3D '\0' || handle > UINT16_MAX) {
> +               bt_shell_printf("Invalid argument: %s\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +       bt_shell_printf("%s : %x\n", __func__, handle);
> +       if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
> +                               "micp_write_char", DBUS_TYPE_UINT16, &han=
dle,
> +                               generic_callback, NULL, NULL) =3D=3D TRUE=
)
> +               return;
> +
> +       return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +}
> +#endif /* MICP_MICS_PTS_FLAG */
> +
>  static void cmd_show(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> @@ -969,6 +1116,23 @@ static const struct bt_shell_menu player_menu =3D {
>                                                         item_generator},
>         { "show-item",   "<item>",    cmd_show_item, "Show item informati=
on",
>                                                         item_generator},
> +#ifdef MICP_MICS_PTS_FLAG
> +       { "mics_mute",     "<on/off>", cmd_set_mute_state,
> +                                       "Set Mics Mute state to on / off"=
,
> +                                                       NULL },
> +       { "mics_state",     "<on/off>", cmd_enable_disable_mute_state,
> +                                       "Set Mics Mute state to on[enable=
] / off[disable]",
> +                                                       NULL },
> +       { "micp_discover",     "<on/off>", cmd_micp_discover_mute,
> +                                       "discover Mute Characteristic",
> +                                                       NULL },
> +       { "micp_read",     "<handle>", cmd_enable_read_mute_state,
> +                                       "Read Mute Characteristic",
> +                                                       NULL },
> +       { "micp_write",     "<handle>", cmd_enable_write_mute_state,
> +                                       "Write Mute Characteristic",
> +                                                       NULL },
> +#endif /* MICP_MICS_PTS_FLAG */
>         {} },
>  };
>
> diff --git a/client/player.h b/client/player.h
> index e7778cb1e..316090721 100644
> --- a/client/player.h
> +++ b/client/player.h
> @@ -10,3 +10,7 @@
>
>  void player_add_submenu(void);
>  void player_remove_submenu(void);
> +
> +#ifdef MICP_MICS_PTS_FLAG
> +void mics_set_proxy(void *proxy);
> +#endif /*MICP_MICS_PTS_FLAG*/
> diff --git a/configure.ac b/configure.ac
> index 9a8856380..a190d9168 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -215,6 +215,9 @@ AC_ARG_ENABLE(micp, AS_HELP_STRING([--disable-micp],
>                 [disable MICP profile]), [enable_micp=3D${enableval}])
>  AM_CONDITIONAL(MICP, test "${enable_micp}" !=3D "no")
>
> +#AC_DEFINE(MICP_MICS_PTS_FLAG, 1,
> +#      [Enable/Disable PTS related code changes in MICP and MICS])
> +
>  AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
>                 [disable CSIP profile]), [enable_csip=3D${enableval}])
>  AM_CONDITIONAL(CSIP, test "${enable_csip}" !=3D "no")
> diff --git a/src/adapter.c b/src/adapter.c
> index 2679d4302..89f6d76f4 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -68,6 +68,10 @@
>  #include "eir.h"
>  #include "battery.h"
>
> +#ifdef MICP_MICS_PTS_FLAG
> +#include "src/shared/micp.h"
> +#endif /*MICP_MICS_PTS_FLAG*/
> +
>  #define MODE_OFF               0x00
>  #define MODE_CONNECTABLE       0x01
>  #define MODE_DISCOVERABLE      0x02
> @@ -3333,6 +3337,82 @@ static void property_set_pairable(const GDBusPrope=
rtyTable *property,
>         property_set_mode(adapter, MGMT_SETTING_BONDABLE, iter, id);
>  }
>
> +#ifdef MICP_MICS_PTS_FLAG

The code below definitely _doesn't_ belong to the daemon core.

> +static void property_set_mute_state(const GDBusPropertyTable *property,
> +                               DBusMessageIter *iter,
> +                               GDBusPendingPropertySet id, void *user_da=
ta)
> +{
> +       dbus_bool_t enable;
> +
> +       dbus_message_iter_get_basic(iter, &enable);
> +       DBG("SET %s: %d\n", __func__, enable);
> +       mics_change_mute_state(enable);
> +       g_dbus_pending_property_success(id);
> +}
> +
> +static void property_mute_enable_disable(const GDBusPropertyTable *prope=
rt,
> +                               DBusMessageIter *iter,
> +                               GDBusPendingPropertySet id, void *user_da=
ta)
> +{
> +       dbus_bool_t enable;
> +
> +       dbus_message_iter_get_basic(iter, &enable);
> +       DBG("%s: %d\n", __func__, enable);
> +       mics_enable_disable_mute(enable);
> +       g_dbus_pending_property_success(id);
> +}
> +
> +static void property_micp_discover_mute(const GDBusPropertyTable *proper=
t,
> +                               DBusMessageIter *iter,
> +                               GDBusPendingPropertySet id, void *user_da=
ta)
> +{
> +       dbus_bool_t enable;
> +
> +       dbus_message_iter_get_basic(iter, &enable);
> +       DBG("%s : %d\n", __func__, enable);
> +       micp_discover_mute_char();
> +       g_dbus_pending_property_success(id);
> +}
> +
> +static void property_micp_read_mute(const GDBusPropertyTable *propert,
> +                               DBusMessageIter *iter,
> +                               GDBusPendingPropertySet id, void *user_da=
ta)
> +{
> +       uint16_t handle;
> +
> +       if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_UINT16) {
> +               g_dbus_pending_property_error(id,
> +                               ERROR_INTERFACE ".InvalidArguments",
> +                               "Expected UINT16");
> +               return;
> +       }
> +       dbus_message_iter_get_basic(iter, &handle);
> +       DBG("%s : %x\n", __func__, handle);
> +
> +       mics_mute_char_read(handle);
> +       g_dbus_pending_property_success(id);
> +}
> +
> +static void property_micp_write_mute(const GDBusPropertyTable *propert,
> +                               DBusMessageIter *iter,
> +                               GDBusPendingPropertySet id, void *user_da=
ta)
> +{
> +       uint16_t handle;
> +
> +       if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_UINT16) {
> +               g_dbus_pending_property_error(id,
> +                               ERROR_INTERFACE ".InvalidArguments",
> +                               "Expected UINT16");
> +               return;
> +       }
> +       dbus_message_iter_get_basic(iter, &handle);
> +       DBG("%s : %x\n", __func__, handle);
> +
> +       micp_char_write_value(handle);
> +       g_dbus_pending_property_success(id);
> +}
> +#endif /*MICP_MICS_PTS_FLAG*/
> +
>  static gboolean property_get_pairable_timeout(
>                                         const GDBusPropertyTable *propert=
y,
>                                         DBusMessageIter *iter, void *user=
_data)
> @@ -3886,6 +3966,13 @@ static const GDBusPropertyTable adapter_properties=
[] =3D {
>         { "DiscoverableTimeout", "u", property_get_discoverable_timeout,
>                                         property_set_discoverable_timeout=
 },
>         { "Pairable", "b", property_get_pairable, property_set_pairable }=
,
> +#ifdef MICP_MICS_PTS_FLAG
> +       { "mics", "b", NULL, property_set_mute_state },
> +       { "mics_state", "b", NULL, property_mute_enable_disable },
> +       { "micp_disc", "b", NULL, property_micp_discover_mute },
> +       { "micp_read_char", "q", NULL, property_micp_read_mute },
> +       { "micp_write_char", "q", NULL, property_micp_write_mute },

Perhaps rather than doing this via profile specific interface we could
check the runtime flag and expose the adapter GATT database, then at
bluetoothctl one could select the attributes, since you probably are
doing this to enable testing the procedures without having to depend
on things like MediaTransport.Volume which depends on BAP to setup a
stream first which I guess PTS doesn't utilize currently?

Anyway, tapping on GATT procedures directly shall cover all testing
when the upper profile uses GATT procedures, that way we don't have to
keep adding new interfaces for testing with PTS, anyway I would
recommend you split these changes to a different set after we have
done merging the initial code for MICP.

> +#endif /*MICP_MICS_PTS_FLAG*/
>         { "PairableTimeout", "u", property_get_pairable_timeout,
>                                         property_set_pairable_timeout },
>         { "Discovering", "b", property_get_discovering },
> diff --git a/src/shared/micp.c b/src/shared/micp.c
> index 25ffa6940..c5b814d98 100644
> --- a/src/shared/micp.c
> +++ b/src/shared/micp.c
> @@ -6,6 +6,10 @@
>   *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
>   *
>   */
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
>  #define _GNU_SOURCE
>  #include <inttypes.h>
>  #include <string.h>
> @@ -74,6 +78,11 @@ struct bt_micp {
>         void *user_data;
>  };
>
> +#ifdef MICP_MICS_PTS_FLAG
> +struct bt_mics *pts_mics;
> +struct bt_micp *pts_micp;
> +#endif /*MICP_MICS_PTS_FLAG*/
> +
>  static struct queue *micp_db;
>  static struct queue *micp_cbs;
>  static struct queue *sessions;
> @@ -532,6 +541,9 @@ static struct bt_micp_db *micp_db_new(struct gatt_db =
*db)
>         mdb->mics =3D mics_new(db);
>         mdb->mics->mdb =3D mdb;
>
> +#ifdef MICP_MICS_PTS_FLAG
> +       pts_mics =3D mdb->mics;
> +#endif /*MICP_MICS_PTS_FLAG*/
>         queue_push_tail(micp_db, mdb);
>
>         return mdb;
> @@ -783,6 +795,10 @@ static void foreach_mics_char(struct gatt_db_attribu=
te *attr, void *user_data)
>         bt_uuid_t uuid, uuid_mute;
>         struct bt_mics *mics;
>
> +#ifdef MICP_MICS_PTS_FLAG
> +       pts_micp =3D micp;
> +#endif /*MICP_MICS_PTS_FLAG*/
> +
>         if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
>                         NULL, NULL, &uuid))
>                 return;
> @@ -920,3 +936,109 @@ bool bt_micp_attach(struct bt_micp *micp, struct bt=
_gatt_client *client)
>                                                 micp);
>         return true;
>  }
> +
> +#ifdef MICP_MICS_PTS_FLAG
> +void mics_change_mute_state(bool state)
> +{
> +       if (pts_micp =3D=3D NULL)
> +               return;
> +
> +       DBG(pts_micp, "%s: %d", __func__, state);
> +       state =3D=3D true ? mics_muted(pts_mics, pts_micp, 0) :
> +                                       mics_not_muted(pts_mics, pts_micp=
, 0);
> +}
> +
> +static uint8_t mics_mute_enable_disable(struct bt_mics *mics, uint8_t st=
ate)
> +{
> +       uint8_t *mute_state;
> +
> +       mute_state =3D mdb_get_mute_state(mics->mdb);
> +
> +       *mute_state =3D state;
> +
> +       return 0;
> +}
> +
> +void mics_enable_disable_mute(bool state)
> +{
> +       state =3D=3D true ? mics_mute_enable_disable(pts_mics, MICS_MUTED=
) :
> +                       mics_mute_enable_disable(pts_mics, MICS_DISABLED)=
;
> +}
> +
> +static void micp_char_search_cb(bool success, uint8_t att_ecode,
> +                                               struct bt_gatt_result *re=
sult,
> +                                               void *user_data)
> +{
> +       DBG(pts_micp, "micp_char_search_cb");
> +
> +}
> +
> +static void micp_foreach_mics_service(struct gatt_db_attribute *attr,
> +                                                       void *user_data)
> +{
> +       uint16_t start, end;
> +       bool primary;
> +       bt_uuid_t uuid;
> +       struct bt_gatt_request *gatt_ret;
> +       struct bt_att *micp_att;
> +       struct bt_micp *micp =3D user_data;
> +       struct bt_mics *mics =3D micp_get_mics(micp);
> +
> +       if (!gatt_db_attribute_get_service_data(attr, &start, &end, &prim=
ary,
> +               &uuid)) {
> +               DBG(micp, "%s: ERR! gatt_db_attribute_get_service_data\n"=
,
> +                       __func__);
> +               return;
> +
> +       }
> +       micp_att =3D bt_micp_get_att(micp);
> +       gatt_ret =3D bt_gatt_discover_characteristics(micp_att, start, en=
d,
> +                                       micp_char_search_cb, NULL, NULL);
> +
> +       if (gatt_ret)
> +               DBG(micp, "MICP GATT DISCOVER START\n");
> +       else
> +               DBG(micp, "MICP GATT DISCOVER FAILED\n");
> +
> +       mics->service =3D attr;
> +
> +       gatt_db_service_set_claimed(attr, true);
> +       gatt_db_service_foreach_char(attr, foreach_mics_char, micp);
> +}
> +
> +void micp_discover_mute_char(void)
> +{
> +       bt_uuid_t uuid;
> +
> +       bt_uuid16_create(&uuid, MICS_UUID);
> +       gatt_db_foreach_service(pts_micp->ldb->db, &uuid,
> +                                       micp_foreach_mics_service, pts_mi=
cp);
> +}
> +
> +void mics_mute_char_read(uint16_t handle)
> +{
> +       DBG(pts_micp, "%s. handle: %x\n", __func__, handle);
> +       micp_read_value(pts_micp, handle, read_mute_state, pts_micp);
> +}
> +
> +static void micp_write_cb(bool success, uint8_t att_ecode, void *user_da=
ta)
> +{
> +       if (success)
> +               DBG(pts_micp, "MICP Write successful\n");
> +       else
> +               DBG(pts_micp, "\nWrite failed: 0x%02x\n", att_ecode);
> +}
> +
> +void micp_char_write_value(uint16_t handle)
> +{
> +       const uint8_t value =3D 0x01;
> +
> +       if (!pts_micp->client) {
> +               DBG(pts_micp, "%s: pts_micp->client is NULL", __func__);
> +               return;
> +       }
> +       bt_gatt_client_write_value(pts_micp->client, handle, &value, 0x01=
,
> +                       micp_write_cb, NULL, NULL);
> +
> +}
> +#endif /*MICP_MICS_PTS_FLAG*/
> diff --git a/src/shared/micp.h b/src/shared/micp.h
> index b307ac9f4..4a9807ed4 100644
> --- a/src/shared/micp.h
> +++ b/src/shared/micp.h
> @@ -44,3 +44,11 @@ bool bt_micp_ready_unregister(struct bt_micp *micp, un=
signed int id);
>
>  bool bt_micp_unregister(unsigned int id);
>  struct bt_micp *bt_micp_new(struct gatt_db *ldb, struct gatt_db *rdb);
> +
> +#ifdef MICP_MICS_PTS_FLAG
> +void mics_change_mute_state(bool state);
> +void mics_enable_disable_mute(bool state);
> +void micp_discover_mute_char(void);
> +void mics_mute_char_read(uint16_t handle);
> +void micp_char_write_value(uint16_t handle);
> +#endif /*MICP_MICS_PTS_FLAG*/
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

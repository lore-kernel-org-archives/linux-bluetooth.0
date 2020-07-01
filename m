Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 17:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C913F207F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/AKkttC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbgGAR4h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbgGAR4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 13:56:37 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08162C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 10:56:37 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y22so8752333oie.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Ls8IsKIk7NU/ETs03RIvkIdisdmmvQF6Bl4XBfF4+E=;
        b=Z/AKkttCI2eIXOQi6/fByvTN36UJdKkDOn1aVIAp6HIpABDE/tZedpbPg7FpCQQ2vm
         oRA8obcuJrEnJV9ghlxUxyR4H3xeWCJ4eDydzJRZiR9UWx6HiHy6nHvCa2G5gMpDsGyx
         fQwDx1ctEtZ7JW5auvgnZvyuZ+ppttIaQvMywb6XJVFy1NHlEYMeH0v34t7USYUr1kfy
         sru9l9Xww165JMhZijnT80pLpGO2AZVN6cZWawylNg4e3i3G+3rowBNy2N1q7x7kZ+Nd
         KC3+0j31zqOF2smpwBUrYg6loj9y2RPg2drFkKuhIUdXkAq5bfb9/xx0jJQxOsU5uVRo
         7/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Ls8IsKIk7NU/ETs03RIvkIdisdmmvQF6Bl4XBfF4+E=;
        b=sQjsVCYK4KqjLS5biSUKx73RnyvnwQQYTEMXXykc9Y65+J4Xgsc7rgbxCi1IQAN9ec
         rkfIgs8gxEQMV9urt3o0iFXitjFmHkHUf7Y920OhOcjqXYVEvF9qTHGzuBbydY7gvmrQ
         2RKT+7GOoi0r3DZWyzKOHQaulKr52FC9+iE1XkC0r0Zk+pQsmDmZhNHtSEipdjX3IVtZ
         xaERmCUoOFA7RuWbTE0j5jzAHrhmF4jz1LEvMZgnMr9RkYIsRE7wfUibr+ldhqO5nrqb
         U4unlXYn2aP1PSmCqZHJMSrQ2O2Ovvm/9ju4PDo40dX8Sy4/pcYCSMpT33tMnhR3TG2H
         CUqw==
X-Gm-Message-State: AOAM531RVPPP92yhK5uxatunF4ETBiWmOU2NAjLDycohfO+pryEJbj4e
        uho3Er2doy3JP1tx55y2mZmRp0C0MfP0gbODmNE=
X-Google-Smtp-Source: ABdhPJyeEQSUGGoHfHKC8otW9FaxyxClTDkRoO8nLu3vK7lper9WpURQGnJ2GtVw0vzXH6p459QUH+GxkRZkwyCOk/k=
X-Received: by 2002:aca:cf81:: with SMTP id f123mr15017156oig.137.1593626196366;
 Wed, 01 Jul 2020 10:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200630184629.95013-1-sonnysasaka@chromium.org>
In-Reply-To: <20200630184629.95013-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Jul 2020 10:56:24 -0700
Message-ID: <CABBYNZKvKNhZeQ52sEE8uZYdrX9cBjM2Wh_BrOpZnkJUc5YcKQ@mail.gmail.com>
Subject: Re: [PATCH v2] client: Add battery command
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Tue, Jun 30, 2020 at 1:48 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> This adds the "battery" command to show battery information of a peer
> device based on org.bluez.Battery1 API. Example usage:
>
> [bluetooth]# battery XX:XX:XX:XX:XX:XX
> Percentage: 100%

It might be better to put the battery level under info command.

> ---
>  client/main.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 422da5593..8c1ed00fb 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -65,6 +65,7 @@ static struct adapter *default_ctrl;
>  static GDBusProxy *default_dev;
>  static GDBusProxy *default_attr;
>  static GList *ctrl_list;
> +static GList *battery_proxies;
>
>  static const char *agent_arguments[] = {
>         "on",
> @@ -107,7 +108,9 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
>         bt_shell_set_prompt(PROMPT_OFF);
>
>         g_list_free_full(ctrl_list, proxy_leak);
> +       g_list_free_full(battery_proxies, proxy_leak);
>         ctrl_list = NULL;
> +       battery_proxies = NULL;
>
>         default_ctrl = NULL;
>  }
> @@ -445,6 +448,16 @@ done:
>         g_free(desc);
>  }
>
> +static void battery_added(GDBusProxy *proxy)
> +{
> +       battery_proxies = g_list_append(battery_proxies, proxy);
> +}
> +
> +static void battery_removed(GDBusProxy *proxy)
> +{
> +       battery_proxies = g_list_remove(battery_proxies, proxy);
> +}
> +
>  static void device_added(GDBusProxy *proxy)
>  {
>         DBusMessageIter iter;
> @@ -539,6 +552,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
>                 gatt_add_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
>                 ad_manager_added(proxy);
> +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> +               battery_added(proxy);
>         }
>  }
>
> @@ -630,6 +645,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
>                 gatt_remove_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
>                 ad_unregister(dbus_conn, NULL);
> +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> +               battery_removed(proxy);
>         }
>  }
>
> @@ -763,6 +780,20 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
>         return NULL;
>  }
>
> +static GDBusProxy *find_battery_by_path(GList *source, const char *path)
> +{
> +       GList *list;
> +
> +       for (list = g_list_first(source); list; list = g_list_next(list)) {
> +               GDBusProxy *proxy = list->data;
> +
> +               if (strcmp(g_dbus_proxy_get_path(proxy), path) == 0)
> +                       return proxy;
> +       }
> +
> +       return NULL;
> +}
> +
>  static GDBusProxy *find_proxy_by_address(GList *source, const char *address)
>  {
>         GList *list;
> @@ -1650,6 +1681,35 @@ static void cmd_info(int argc, char *argv[])
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> +static void cmd_battery(int argc, char *argv[])
> +{
> +       DBusMessageIter iter;
> +       GDBusProxy *device_proxy;
> +       GDBusProxy *battery_proxy;
> +       unsigned char percentage;
> +
> +       device_proxy = find_device(argc, argv);
> +       if (!device_proxy)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       battery_proxy = find_battery_by_path(battery_proxies,
> +                                       g_dbus_proxy_get_path(device_proxy));
> +       if (!battery_proxy) {
> +               bt_shell_printf("Device %s does not have battery information\n",
> +                               argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (g_dbus_proxy_get_property(battery_proxy, "Percentage", &iter) ==
> +                                                                       FALSE)
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       dbus_message_iter_get_basic(&iter, &percentage);
> +       bt_shell_printf("Percentage: %d%%\n", percentage);
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
>  static void pair_reply(DBusMessage *message, void *user_data)
>  {
>         DBusError error;
> @@ -2785,6 +2845,8 @@ static const struct bt_shell_menu main_menu = {
>                                                         dev_generator },
>         { "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
>                                                         dev_generator },
> +       { "battery",      "[dev]",    cmd_battery, "Show device battery",
> +                                                       dev_generator },
>         { } },
>  };
>
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz

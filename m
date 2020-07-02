Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C60C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 05:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A8620737
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 05:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMgSbogJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGBFUM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgGBFUL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 01:20:11 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2AC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 22:20:11 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k15so23185638otp.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 22:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QuSF3vVBHGBgyyhE3tJdb3M+cAv1YvUDZ6m/v58lP8=;
        b=iMgSbogJ2VIELyvkevpGa1KBWZGHJr/i39GF9DUDy6BcUQIc8Kcv1y6mbHdW1x+YRh
         0Qy0oDao55DwDsxuGGCkSMVOJvVMY5pxt2/hSGvxVLlHDm54n8eO+ufRUwYoNZPZ/uba
         +nDYn0ma6ciojnTq1mM0JaUuYg5f4U79Pw98gNIQ/5NBG7+H6WI9uHQufDbNj4i5opJ/
         X5hnszT2wodgiG6b9zqVhiaoaA0W0vVM3vKB8XPnX59AF9nW3dWCCq04w36iRABYI7GY
         hVvnSj0vLn1mlxsAA63D3AxVJY21m1E7xeIB1NzgOzcBsfEezCBqJ133mKnUxwAWrhUz
         wn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QuSF3vVBHGBgyyhE3tJdb3M+cAv1YvUDZ6m/v58lP8=;
        b=rbe9/5PuHrm8/GzGsolk4xGgpm4W5DspIdBDhVlu6X7unR72kmz5/l2Z2dSERwuBKA
         aN/w8sbJYIcaSJyWNlYJGrzDi8suFho8VVtxvTrWP8wEMYPVoqvqn9qqdfdhbQpLc0uB
         6lmgaQRBUTg2Gao4/zK/KxlNceDZ0GpAgAXkHPtEmFFuX8KsKP/BD/wmZ7vsu7gtVuZD
         l1fDdp3sApydST2LWeoM0S7J/GOg6yOLmuuXfUdysRkwKIyc0Y5Eh+N6bmCthzB9UAAp
         tpVUobIT77qsnVPIpUgNfXdUl55AXG6jJ+9qqSQ8nwy5AZBGBZjrHPIvZFHMQYyVwkri
         LA0w==
X-Gm-Message-State: AOAM531C9O4PgnO//ZitsOUFNclCPZu2HRzCIdo/co551IR8oFBI9ytj
        pU89FUuRL0ZaBJ/LMPOxIKnnIKxL+QHqkYnhn68=
X-Google-Smtp-Source: ABdhPJxdQiYxok6hDiKMNWxvwbeQ4fgJNtvPes/Mz5/Jp1ZPAeiqcOgg0qjjO/zvxLlAyqyVmGrLVjsQpuSY0JN5zSw=
X-Received: by 2002:a9d:6c09:: with SMTP id f9mr8047001otq.362.1593667210999;
 Wed, 01 Jul 2020 22:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200701192202.9508-1-sonnysasaka@chromium.org>
In-Reply-To: <20200701192202.9508-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Jul 2020 22:19:55 -0700
Message-ID: <CABBYNZKsM52hLuNEYSqhHoiMXE5Kix_pp6AoCJeJ4rd6f-NyWg@mail.gmail.com>
Subject: Re: [PATCH v2] client: Add battery percentage to info command
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Wed, Jul 1, 2020 at 12:24 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> This adds the Battery Percentage to the info command based on
> org.bluez.Battery1 API. Example usage:
>
> [bluetooth]# info XX:XX:XX:XX:XX:XX
> Device XX:XX:XX:XX:XX:XX (random)
>         Name: ...
>         Alias: ...
>         ...
>         Modalias: ...
>         Battery Percentage: 100%
> ---
>  client/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 422da5593..4b787240e 100644
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
> @@ -1606,8 +1637,10 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
>  static void cmd_info(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> +       GDBusProxy *battery_proxy;
>         DBusMessageIter iter;
>         const char *address;
> +       unsigned char percentage;
>
>         proxy = find_device(argc, argv);
>         if (!proxy)
> @@ -1647,6 +1680,16 @@ static void cmd_info(int argc, char *argv[])
>         print_property(proxy, "AdvertisingFlags");
>         print_property(proxy, "AdvertisingData");
>
> +       battery_proxy = find_battery_by_path(battery_proxies,
> +                                       g_dbus_proxy_get_path(proxy));

I'd replace the lines below with just print_property(battery_proxy,
"Percentage"); and just make print_property check for NULL proxy if it
doesn't already.

> +       if (battery_proxy && g_dbus_proxy_get_property(
> +                               battery_proxy, "Percentage", &iter)) {
> +               dbus_message_iter_get_basic(&iter, &percentage);
> +               bt_shell_printf("\tBattery Percentage: %d%%\n", percentage);
> +       } else {
> +               bt_shell_printf("\tNo battery information\n");
> +       }
> +
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz

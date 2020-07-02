Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9285CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 23:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C5520760
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 23:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxGv5o8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGBXX0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXXZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 19:23:25 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFDDC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2020 16:23:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 18so25401095otv.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2020 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=So6hipOar99ikd7Np37Ut+mfDA/xdCw/Ua65a7snIDc=;
        b=GxGv5o8lkJmvD/98WMAAZd3gnyzxKHowthL/AohDBJ9xVCshlp8IoimYU8duL4ZYC6
         MM9nTHP9xZq40hGOYeMEmpitIwmhY7DCq+byPwzSbPrsCOn1Pi7cpMAmu6ZRR0qC0Zpy
         ppv70NRMh4C3I+jW7keWuqmfFQ4rYjGzElIFH7lUpYIbcBwplgX2HFgrstxJAQMdFzz0
         0yo2YaX7NZZx27EzVX80eVbNqllcFcOiTSV7Wy8LxQIiAk8ztCmw8HG/IM17cb6zqWx1
         Yf3udPIyoO2uQ5dSBDmrcNy/xJWzmTcPsLAfi7Q8bhfMH5DuPLMI4J8RgTdaUdI47FMZ
         BKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=So6hipOar99ikd7Np37Ut+mfDA/xdCw/Ua65a7snIDc=;
        b=XxK2Sxz5a7oSLjooZPYQqtzYRtbirwfJnkh+cO/4mv0SngTiBJHxTmLwAGmW8fPvxT
         11qF1n7hRBUXv6DWKuRiXmXXqCJNeHX/nV5S0UrGDDlDLmaS/n9qMLDP0aqAeBIZOF9J
         zSGfgDiPuF6GRn6XyRlNnl82P9sVoFENtcgn7lDvF44SicQDOjqAoEbTIMKt17j6ENz8
         iefMhWuz0v/FJL0nDON/k0eetV7M/yTZhONWluijGgH4GckuTE8aoVXGLJ/6SYf/NjNq
         GnsO+8Nq+W6AxFM708Nf7j4U2arP+Cmwi01Y9EoU9rKSTBkMoL8HmKD973M8Ae1V47la
         V1jA==
X-Gm-Message-State: AOAM531wQ47bgbZrTG44qax/2/uEkhJLbU+dkycnSsMKg4rJAFJ4ouF7
        78Qa1NBxgiFygsQWF8eBhnXtFZ84qEmB+FL/fCmmOADc
X-Google-Smtp-Source: ABdhPJw3hu+pGr9nI1dlGSJDn4o8KXaUp0GEsEJlZz6fV+bDWt6T9iyUOseZkaxCnAkFV5Gq5phkPoYFsBQVmy78dj8=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id v19mr26172598ota.91.1593732204409;
 Thu, 02 Jul 2020 16:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZK5SyZL6mx0D2dtRqz1P7m6+JZSBXMP-xRKjNBngf-oaA@mail.gmail.com>
 <20200702180155.24260-1-sonnysasaka@chromium.org>
In-Reply-To: <20200702180155.24260-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jul 2020 16:23:12 -0700
Message-ID: <CABBYNZLWJ7XEnP=ncVXfyLccrb_PTfDdC7ftAiVX9_n1JiAexw@mail.gmail.com>
Subject: Re: [PATCH v3] client: Add battery percentage to info command
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Jul 2, 2020 at 11:06 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
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
>         Battery Percentage: 0x64 (100)
> ---
>  client/main.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index 422da5593..c0b351aed 100644
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
> @@ -271,7 +274,7 @@ static void print_iter(const char *label, const char *name,
>                 break;
>         case DBUS_TYPE_BYTE:
>                 dbus_message_iter_get_basic(iter, &byte);
> -               bt_shell_printf("%s%s: 0x%02x\n", label, name, byte);
> +               bt_shell_printf("%s%s: 0x%02x (%d)\n", label, name, byte, byte);
>                 break;
>         case DBUS_TYPE_VARIANT:
>                 dbus_message_iter_recurse(iter, &subiter);
> @@ -309,14 +312,20 @@ static void print_iter(const char *label, const char *name,
>         }
>  }
>
> -static void print_property(GDBusProxy *proxy, const char *name)
> +static void print_property_with_label(GDBusProxy *proxy, const char *name,
> +                                       const char *label)
>  {
>         DBusMessageIter iter;
>
>         if (g_dbus_proxy_get_property(proxy, name, &iter) == FALSE)
>                 return;
>
> -       print_iter("\t", name, &iter);
> +       print_iter("\t", label ? label : name, &iter);
> +}
> +
> +static void print_property(GDBusProxy *proxy, const char *name)
> +{
> +       print_property_with_label(proxy, name, NULL);
>  }
>
>  static void print_uuid(const char *uuid)
> @@ -445,6 +454,16 @@ done:
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
> @@ -539,6 +558,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
>                 gatt_add_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
>                 ad_manager_added(proxy);
> +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> +               battery_added(proxy);
>         }
>  }
>
> @@ -630,6 +651,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
>                 gatt_remove_manager(proxy);
>         } else if (!strcmp(interface, "org.bluez.LEAdvertisingManager1")) {
>                 ad_unregister(dbus_conn, NULL);
> +       } else if (!strcmp(interface, "org.bluez.Battery1")) {
> +               battery_removed(proxy);
>         }
>  }
>
> @@ -763,6 +786,20 @@ static struct adapter *find_ctrl_by_address(GList *source, const char *address)
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
> @@ -1606,6 +1643,7 @@ static struct GDBusProxy *find_device(int argc, char *argv[])
>  static void cmd_info(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> +       GDBusProxy *battery_proxy;
>         DBusMessageIter iter;
>         const char *address;
>
> @@ -1647,6 +1685,11 @@ static void cmd_info(int argc, char *argv[])
>         print_property(proxy, "AdvertisingFlags");
>         print_property(proxy, "AdvertisingData");
>
> +       battery_proxy = find_battery_by_path(battery_proxies,
> +                                       g_dbus_proxy_get_path(proxy));
> +       print_property_with_label(battery_proxy, "Percentage",
> +                                       "Battery Percentage");
> +
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
>
> --
> 2.17.1
>

Applied, thanks.

-- 
Luiz Augusto von Dentz

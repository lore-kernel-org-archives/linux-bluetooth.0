Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BBC433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B88A208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvtLUksp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgE2Uhm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgE2Uhk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 16:37:40 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C74C08C5CA
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 13:30:36 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i22so3743106oik.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vXcmgq3209f97ieb1zDC7TluF90nRDpN1LlNgJ8NZm4=;
        b=qvtLUkspI1HOObs8Zprlnk8H481JsrEbElbuNHHQiLpX/g+ASr7tmeNdJiAtuL4q6N
         Gg+aU3+3lQTIneqceyd/ZI7nj+PzkQSmXEWdiaRGpQAcmbmCOc1NUFM+6Sy/EuLDxR86
         AuYZjoKKqrMCAewncCGYBEhoENDvAkf8I31nldAbXcnWchk/blUbu3GEGzTlwK14o+h3
         S60ogHT91QMxaVi937x5M9NGQRWC5TTZPk30DOVRfPB6qITm6WucIefBOVYDyVsMA2Qm
         NIWDipt5d2pi0lMhdoBo1z3DkKcKp2B27vmn72Jh91/SxyM6mbVOhM9HFXHFqFdbc0iR
         /PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vXcmgq3209f97ieb1zDC7TluF90nRDpN1LlNgJ8NZm4=;
        b=p+ROb6BUzwf46Zunv9YD9p7YjQ6ctbwzacUVCJRj8hjUAXRT091MmVgLdz01FoCfp6
         Q3CSI9JzGKH2ldI+1CoeWN8nyZzj6x7F6bcJAHe4Z6cZJMOgebaRrBREfC+LmJ4Clf+X
         9eJ9V7/nlrsucrONoypnjQsPHiyVxOyYTARS6tP2t5RHpBL6yxmQPWhcT4tq9FDTLT4j
         1PcsGcgzgaJQJ/FuNmCpDA4dRyM64EckoGNrCRZlO7D2iC3adWcpJCXyE272wd+yZ5vv
         xrjwMHAfiM8s/HhT1eCw6dApWbnog2NxZV7wAHvTlXYEGcius6Eqv0tfLZwjN4FS6KaK
         OX0Q==
X-Gm-Message-State: AOAM533itGAmXLBt+pdwEjAv7z2RsRQ0TfDqOvaecELMFWNVFtA5MWyv
        5utCCVD1VpekIw3R2oyvhjKJVXsYNyqhAt6kkQmtoQ==
X-Google-Smtp-Source: ABdhPJxUIKnsevjMZ1uDmQfTDFTks4eV2G/s6LAd/f4MO9K8TUReoIr7EqoMFJ9Jlo/Pe7XxoKEybWgLsKx2F3NSBME=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr7449501oif.108.1590784235309;
 Fri, 29 May 2020 13:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200528221519.227605-1-luiz.dentz@gmail.com>
In-Reply-To: <20200528221519.227605-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 29 May 2020 13:30:24 -0700
Message-ID: <CABBYNZKkbwcs39ERYoxSbCo_oieK28s3V2t0XtKHK_=wgm4e9g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix not removing client from discovery list
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, May 28, 2020 at 3:15 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If command MGMT_OP_START_DISCOVERY fails we reply with btd_error_busy
> but we don't remove the client from the list which would prevent the
> client to start it once again.
> ---
>  src/adapter.c | 225 +++++++++++++++++++++++++-------------------------
>  1 file changed, 113 insertions(+), 112 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 972d88772..c3d60697a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1468,6 +1468,118 @@ static void free_discovery_filter(struct discovery_filter *discovery_filter)
>         g_free(discovery_filter);
>  }
>
> +static void invalidate_rssi_and_tx_power(gpointer a)
> +{
> +       struct btd_device *dev = a;
> +
> +       device_set_rssi(dev, 0);
> +       device_set_tx_power(dev, 127);
> +}
> +
> +static gboolean remove_temp_devices(gpointer user_data)
> +{
> +       struct btd_adapter *adapter = user_data;
> +       GSList *l, *next;
> +
> +       DBG("%s", adapter->path);
> +
> +       adapter->temp_devices_timeout = 0;
> +
> +       for (l = adapter->devices; l != NULL; l = next) {
> +               struct btd_device *dev = l->data;
> +
> +               next = g_slist_next(l);
> +
> +               if (device_is_temporary(dev) && !btd_device_is_connected(dev))
> +                       btd_adapter_remove_device(adapter, dev);
> +       }
> +
> +       return FALSE;
> +}
> +
> +static void discovery_cleanup(struct btd_adapter *adapter)
> +{
> +       GSList *l, *next;
> +
> +       adapter->discovery_type = 0x00;
> +
> +       if (adapter->discovery_idle_timeout > 0) {
> +               g_source_remove(adapter->discovery_idle_timeout);
> +               adapter->discovery_idle_timeout = 0;
> +       }
> +
> +       if (adapter->temp_devices_timeout > 0) {
> +               g_source_remove(adapter->temp_devices_timeout);
> +               adapter->temp_devices_timeout = 0;
> +       }
> +
> +       g_slist_free_full(adapter->discovery_found,
> +                                               invalidate_rssi_and_tx_power);
> +       adapter->discovery_found = NULL;
> +
> +       if (!adapter->devices)
> +               return;
> +
> +       for (l = adapter->devices; l != NULL; l = next) {
> +               struct btd_device *dev = l->data;
> +
> +               next = g_slist_next(l);
> +
> +               if (device_is_temporary(dev) && !device_is_connectable(dev))
> +                       btd_adapter_remove_device(adapter, dev);
> +       }
> +
> +       adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
> +                                               remove_temp_devices, adapter);
> +}
> +
> +static void discovery_free(void *user_data)
> +{
> +       struct watch_client *client = user_data;
> +
> +       if (client->watch)
> +               g_dbus_remove_watch(dbus_conn, client->watch);
> +
> +       if (client->discovery_filter) {
> +               free_discovery_filter(client->discovery_filter);
> +               client->discovery_filter = NULL;
> +       }
> +
> +       if (client->msg)
> +               dbus_message_unref(client->msg);
> +
> +       g_free(client->owner);
> +       g_free(client);
> +}
> +
> +static void discovery_remove(struct watch_client *client, bool exit)
> +{
> +       struct btd_adapter *adapter = client->adapter;
> +
> +       DBG("owner %s", client->owner);
> +
> +       adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
> +                                                               client);
> +
> +       adapter->discovery_list = g_slist_remove(adapter->discovery_list,
> +                                                               client);
> +
> +       if (!exit && client->discovery_filter)
> +               adapter->set_filter_list = g_slist_prepend(
> +                                       adapter->set_filter_list, client);
> +       else
> +               discovery_free(client);
> +
> +       /*
> +        * If there are other client discoveries in progress, then leave
> +        * it active. If not, then make sure to stop the restart timeout.
> +        */
> +       if (adapter->discovery_list)
> +               return;
> +
> +       discovery_cleanup(adapter);
> +}
> +
>  static void trigger_start_discovery(struct btd_adapter *adapter, guint delay);
>
>  static void start_discovery_complete(uint8_t status, uint16_t length,
> @@ -1538,6 +1650,7 @@ fail:
>                 reply = btd_error_busy(client->msg);
>                 g_dbus_send_message(dbus_conn, reply);
>                 g_dbus_remove_watch(dbus_conn, client->watch);
> +               discovery_remove(client, false);
>                 return;
>         }
>
> @@ -1784,90 +1897,6 @@ static void discovering_callback(uint16_t index, uint16_t length,
>         }
>  }
>
> -static void invalidate_rssi_and_tx_power(gpointer a)
> -{
> -       struct btd_device *dev = a;
> -
> -       device_set_rssi(dev, 0);
> -       device_set_tx_power(dev, 127);
> -}
> -
> -static gboolean remove_temp_devices(gpointer user_data)
> -{
> -       struct btd_adapter *adapter = user_data;
> -       GSList *l, *next;
> -
> -       DBG("%s", adapter->path);
> -
> -       adapter->temp_devices_timeout = 0;
> -
> -       for (l = adapter->devices; l != NULL; l = next) {
> -               struct btd_device *dev = l->data;
> -
> -               next = g_slist_next(l);
> -
> -               if (device_is_temporary(dev) && !btd_device_is_connected(dev))
> -                       btd_adapter_remove_device(adapter, dev);
> -       }
> -
> -       return FALSE;
> -}
> -
> -static void discovery_cleanup(struct btd_adapter *adapter)
> -{
> -       GSList *l, *next;
> -
> -       adapter->discovery_type = 0x00;
> -
> -       if (adapter->discovery_idle_timeout > 0) {
> -               g_source_remove(adapter->discovery_idle_timeout);
> -               adapter->discovery_idle_timeout = 0;
> -       }
> -
> -       if (adapter->temp_devices_timeout > 0) {
> -               g_source_remove(adapter->temp_devices_timeout);
> -               adapter->temp_devices_timeout = 0;
> -       }
> -
> -       g_slist_free_full(adapter->discovery_found,
> -                                               invalidate_rssi_and_tx_power);
> -       adapter->discovery_found = NULL;
> -
> -       if (!adapter->devices)
> -               return;
> -
> -       for (l = adapter->devices; l != NULL; l = next) {
> -               struct btd_device *dev = l->data;
> -
> -               next = g_slist_next(l);
> -
> -               if (device_is_temporary(dev) && !device_is_connectable(dev))
> -                       btd_adapter_remove_device(adapter, dev);
> -       }
> -
> -       adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
> -                                               remove_temp_devices, adapter);
> -}
> -
> -static void discovery_free(void *user_data)
> -{
> -       struct watch_client *client = user_data;
> -
> -       if (client->watch)
> -               g_dbus_remove_watch(dbus_conn, client->watch);
> -
> -       if (client->discovery_filter) {
> -               free_discovery_filter(client->discovery_filter);
> -               client->discovery_filter = NULL;
> -       }
> -
> -       if (client->msg)
> -               dbus_message_unref(client->msg);
> -
> -       g_free(client->owner);
> -       g_free(client);
> -}
> -
>  static bool set_discovery_discoverable(struct btd_adapter *adapter, bool enable)
>  {
>         if (adapter->discovery_discoverable == enable)
> @@ -1882,34 +1911,6 @@ static bool set_discovery_discoverable(struct btd_adapter *adapter, bool enable)
>         return set_discoverable(adapter, enable, 0);
>  }
>
> -static void discovery_remove(struct watch_client *client, bool exit)
> -{
> -       struct btd_adapter *adapter = client->adapter;
> -
> -       DBG("owner %s", client->owner);
> -
> -       adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
> -                                                               client);
> -
> -       adapter->discovery_list = g_slist_remove(adapter->discovery_list,
> -                                                               client);
> -
> -       if (!exit && client->discovery_filter)
> -               adapter->set_filter_list = g_slist_prepend(
> -                                       adapter->set_filter_list, client);
> -       else
> -               discovery_free(client);
> -
> -       /*
> -        * If there are other client discoveries in progress, then leave
> -        * it active. If not, then make sure to stop the restart timeout.
> -        */
> -       if (adapter->discovery_list)
> -               return;
> -
> -       discovery_cleanup(adapter);
> -}
> -
>  static void stop_discovery_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> --
> 2.25.3
>

Applied.

-- 
Luiz Augusto von Dentz

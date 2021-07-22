Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AF4C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 18:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6B61380
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 18:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhGVRWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGVRWd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 13:22:33 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EAC061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 11:03:06 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id i18so9568770yba.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QD2EuU/Y1LO438xQgvsG20pep6YO+xFcCEAf110jj4U=;
        b=g81dvLpBbFqZQRsEdabti/VviyECjSZcYmve39kjkw9hHCvsEhJA1i4/uejyZJa1hm
         73nUS/VlTJQHpIe5/IHr/ISUrreXVFGKBDUb4x3qzVXZWMwDKTwjgkoZZswXYeW4dZx6
         7PHZXmgbz52nj6jk715fZ+LblgBpAdReXL+YoTxrGvz9MB5tuOCJzs9r2gbIktx+VV4K
         Lh9UVCxu3QG5Pv6r1OkHBVmChw4AedmJ9yeEgLNzCZbhUIclCo00BgUoHCxiKR+8H7vP
         LwF4in43MQlI/6EOIzFUdNKpAqRDxz70XKS4CIhvelWLEcZDjovWYL6GuaMIKdsPqcDE
         BUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QD2EuU/Y1LO438xQgvsG20pep6YO+xFcCEAf110jj4U=;
        b=UfzwlUeTd1696Eo+d7o0d5F5r05cI//MHpqKDNm3GLdJtPsENhJEeHKupg/1dSm1dP
         gk5Pf3vKSRYMHWmevSoQpzoWLvFNQFAW8lUAgSnxtP1xRhxNLMg66l8BgNVXdv152gyt
         vr6GuCGdV8Wh1hLMVCSp5SDgnsAfDC6HPZUaDLIS04Ko5qd5UW7UQ0JuLc1XK6kN8cp8
         T5Me8evKYlqncZEepjlrrJvxdrQI8GR3oovC1SjVRRGYDuP8pGuxaipGQirnPLxAMCnO
         f9CcjGaljHOwbdXpHswM0COpyN314+1BBbnVxlL1q76uj9zzCXVCCEYLaTaRJVKmPB7N
         cIOw==
X-Gm-Message-State: AOAM5324qlIVwhVWFAY+e4LQSdx77JyE5ShOl+6yDDC94YFGlnXAsoUy
        7V+ROLsq7NDemd0Er1su3pLBxMW5QVpBeStQvVY=
X-Google-Smtp-Source: ABdhPJwoVTzSichi6QrY1oUnaBA02Qbwh+ChBNXyR5lxuymJWAA6W35ra4oUtN6TeOMVmjHA6mbtJUM7azE0LDW75d0=
X-Received: by 2002:a25:8205:: with SMTP id q5mr977286ybk.440.1626976986033;
 Thu, 22 Jul 2021 11:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com> <20210722152159.Bluez.v2.8.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
In-Reply-To: <20210722152159.Bluez.v2.8.I517e5199ac8019b770c7ee8c92a294ec1c752748@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Jul 2021 11:02:54 -0700
Message-ID: <CABBYNZ+yDret+DA6iYmcgxawnHWaCJZMXV4GdKxrZ=rDHuwuQg@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 08/11] plugins/admin_policy: listen for device
 add and remove
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Thu, Jul 22, 2021 at 12:23 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> This adds an D-BUS client to listen for DeviceAdd and DeviceRemove. It
> is necessary for implementation of "AffectedByPolicy" property since it
> needs to register an interface for each device object and unregister it
> once the device gets removed.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> The following test steps were performed:
> 1. start discovery using UI
> 2. verify device_data were added by checking system log
> 3. stop discovery
> 4. verify device_data were removed after a few seconds by checking
> system log
>
> (no changes since v1)
>
>  plugins/admin_policy.c | 154 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 150 insertions(+), 4 deletions(-)
>
> diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
> index 270d42366cd6..73d695ef976b 100644
> --- a/plugins/admin_policy.c
> +++ b/plugins/admin_policy.c
> @@ -20,6 +20,7 @@
>
>  #include "src/adapter.h"
>  #include "src/dbus-common.h"
> +#include "src/device.h"
>  #include "src/error.h"
>  #include "src/log.h"
>  #include "src/plugin.h"
> @@ -29,7 +30,12 @@
>  #define ADMIN_POLICY_SET_INTERFACE     "org.bluez.AdminPolicySet1"
>  #define ADMIN_POLICY_STATUS_INTERFACE  "org.bluez.AdminPolicyStatus1"
>
> +#define DBUS_BLUEZ_SERVICE             "org.bluez"
> +#define BTD_DEVICE_INTERFACE           "org.bluez.Device1"
> +
>  static DBusConnection *dbus_conn;
> +static GDBusClient *dbus_client;
> +static struct queue *devices; /* List of struct device_data objects */
>
>  /* |policy_data| has the same life cycle as btd_adapter */
>  static struct btd_admin_policy {
> @@ -38,6 +44,11 @@ static struct btd_admin_policy {
>         struct queue *service_allowlist;
>  } *policy_data = NULL;
>
> +struct device_data {
> +       struct btd_device *device;
> +       char *path;
> +};
> +
>  static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
>  {
>         struct btd_admin_policy *admin_policy = NULL;
> @@ -203,8 +214,122 @@ static const GDBusPropertyTable admin_policy_adapter_properties[] = {
>         { }
>  };
>
> +static bool device_data_match(const void *a, const void *b)
> +{
> +       const struct device_data *data = a;
> +       const struct btd_device *dev = b;
> +
> +       if (!data) {
> +               error("Unexpected NULL device_data");
> +               return false;
> +       }
> +
> +       return data->device == dev;
> +}
> +
> +static bool device_data_match_by_path(const void *a, const void *b)
> +{
> +       const struct device_data *data = a;
> +       const char *path = b;
> +
> +       if (!data) {
> +               error("Unexpected NULL device_data");
> +               return false;
> +       }
> +
> +       return strcmp(data->path, b) == 0;
> +}
> +
> +static void free_device_data(void *data)
> +{
> +       struct device_data *device_data = data;
> +
> +       g_free(device_data->path);
> +       g_free(device_data);
> +}
> +
> +static void remove_device_data(void *data)
> +{
> +       struct device_data *device_data = data;
> +
> +       DBG("device_data for %s removing", device_data->path);
> +
> +       queue_remove(devices, device_data);
> +       free_device_data(device_data);
> +}
> +
> +static void add_device_data(struct btd_device *device)
> +{
> +       struct btd_adapter *adapter = device_get_adapter(device);
> +       struct device_data *data;
> +
> +       if (queue_find(devices, device_data_match, device))
> +               return;
> +
> +       data = g_new0(struct device_data, 1);
> +       if (!data) {
> +               btd_error(btd_adapter_get_index(adapter),
> +                               "Failed to allocate memory for device_data");
> +               return;
> +       }
> +
> +       data->device = device;
> +       data->path = g_strdup(device_get_path(device));
> +       queue_push_tail(devices, data);
> +
> +       DBG("device_data for %s added", data->path);
> +}
> +
> +static struct btd_device *find_device_by_proxy(GDBusProxy *proxy)
> +{
> +       const char *path = g_dbus_proxy_get_path(proxy);
> +       const char *iface = g_dbus_proxy_get_interface(proxy);
> +       struct btd_device *device;
> +
> +       if (strcmp(iface, BTD_DEVICE_INTERFACE) != 0)
> +               return NULL;
> +
> +       device = btd_adapter_find_device_by_path(policy_data->adapter, path);
> +
> +       if (!device) {
> +               btd_warn(adapter_get_path(policy_data->adapter),
> +                                       "Device path %s is not found", path);
> +       }
> +
> +       return device;
> +}
> +
> +static void object_added_cb(GDBusProxy *proxy, void *user_data)
> +{
> +       struct btd_device *device;
> +
> +       device = find_device_by_proxy(proxy);
> +
> +       if (!device)
> +               return;
> +
> +       add_device_data(device);
> +}
> +
> +static void object_removed_cb(GDBusProxy *proxy, void *user_data)
> +{
> +       const char *path = g_dbus_proxy_get_path(proxy);
> +       const char *iface = g_dbus_proxy_get_interface(proxy);
> +       struct device_data *data;
> +
> +       if (strcmp(iface, BTD_DEVICE_INTERFACE) != 0)
> +               return;
> +
> +       data = queue_find(devices, device_data_match_by_path, path);
> +
> +       if (data)
> +               remove_device_data(data);
> +}
> +
>  static int admin_policy_adapter_probe(struct btd_adapter *adapter)
>  {
> +       const char *adapter_path;
> +
>         if (policy_data) {
>                 btd_warn(policy_data->adapter_id,
>                                                 "Policy data already exists");
> @@ -216,33 +341,43 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
>         if (!policy_data)
>                 return -ENOMEM;
>
> -       if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
> +       adapter_path = adapter_get_path(adapter);
> +
> +       if (!g_dbus_register_interface(dbus_conn, adapter_path,
>                                         ADMIN_POLICY_SET_INTERFACE,
>                                         admin_policy_adapter_methods, NULL,
>                                         NULL, policy_data, admin_policy_free)) {
>                 btd_error(policy_data->adapter_id,
>                         "Admin Policy Set interface init failed on path %s",
> -                                               adapter_get_path(adapter));
> +                                                               adapter_path);
>                 return -EINVAL;
>         }
>
>         btd_info(policy_data->adapter_id,
>                                 "Admin Policy Set interface registered");
>
> -       if (!g_dbus_register_interface(dbus_conn, adapter_get_path(adapter),
> +       if (!g_dbus_register_interface(dbus_conn, adapter_path,
>                                         ADMIN_POLICY_STATUS_INTERFACE,
>                                         NULL, NULL,
>                                         admin_policy_adapter_properties,
>                                         policy_data, admin_policy_free)) {
>                 btd_error(policy_data->adapter_id,
>                         "Admin Policy Status interface init failed on path %s",
> -                                               adapter_get_path(adapter));
> +                                                               adapter_path);
>                 return -EINVAL;
>         }
>
>         btd_info(policy_data->adapter_id,
>                                 "Admin Policy Status interface registered");
>
> +       dbus_client = g_dbus_client_new(dbus_conn, DBUS_BLUEZ_SERVICE,
> +                                                               adapter_path);
> +
> +       g_dbus_client_set_proxy_handlers(dbus_client, object_added_cb,
> +                                               object_removed_cb, NULL, NULL);
> +
> +       g_dbus_client_set_ready_watch(dbus_client, NULL, NULL);

I hope it wasn't one of my comments that led you to do this, because
it is really a bad idea to listen to our own signals like that since
it comes from the same process it just adds a round trip to the D-Bus
daemon for no reason. Perhaps we could extend the btd_adapter_driver
to have device_added/device_remove callbacks so whenever a new device
is added or removed the driver will get notified.

> +
>         return 0;
>  }
>
> @@ -257,6 +392,7 @@ static int admin_policy_init(void)
>         DBG("");
>
>         dbus_conn = btd_get_dbus_connection();
> +       devices = queue_new();
>
>         return btd_register_adapter_driver(&admin_policy_driver);
>  }
> @@ -266,9 +402,19 @@ static void admin_policy_exit(void)
>         DBG("");
>
>         btd_unregister_adapter_driver(&admin_policy_driver);
> +       queue_destroy(devices, free_device_data);
>
>         if (policy_data)
>                 admin_policy_free(policy_data);
> +
> +       if (dbus_client) {
> +               g_dbus_client_set_disconnect_watch(dbus_client, NULL, NULL);
> +               g_dbus_client_set_proxy_handlers(dbus_client, NULL, NULL, NULL,
> +                                                                       NULL);
> +               g_dbus_client_set_ready_watch(dbus_client, NULL, NULL);
> +               g_dbus_client_unref(dbus_client);
> +               dbus_client = NULL;
> +       }
>  }
>
>  BLUETOOTH_PLUGIN_DEFINE(admin_policy, VERSION,
> --
> 2.32.0.402.g57bb445576-goog
>


-- 
Luiz Augusto von Dentz

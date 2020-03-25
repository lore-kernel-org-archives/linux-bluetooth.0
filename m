Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBAC2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702D520658
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8//yeJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgCYTzD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:55:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44082 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYTzC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 15:55:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id v134so3280277oie.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48b3Y00amLYxF+eDVfWb36MQ+rYXsmfQpSg499v7rLI=;
        b=J8//yeJkKLDuf79Bk2HqyVknyCeAP6ET06wJBCbUymCgDrxNEA0gksRUgEvvSp++4b
         3JVlFuCwlOfH3tN8lgRyPJn7SZxhccnGhSwn4/3EWhG5gvK2I6lC8f/YD1u+ptySkDwH
         UqmR3S8kJOUOX5s62lBrvW1XfjOndtCLeeIVHRiovnjljmUqv1VhAjP0IKl099FijVao
         NWvmw7ye8VJjGjalLb9XT0zgZNzUDyCk+4luSZUuqFwvzEFGS+Q1HOkK85+7lorVPHHR
         pAV/pQwYvsNvrfOuZlxpn5gbYcohhItKkZSY92NHUCRunkGEF/BufJsSWB2uHAmUoeOs
         5zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48b3Y00amLYxF+eDVfWb36MQ+rYXsmfQpSg499v7rLI=;
        b=NjmZp0tcQOZTheukSGFAPwWqSNVAVFUA5O7LD77AkAQ/CGN1CZIjtQ9w6yh1otfOPv
         iH5hg0o8n66UHGO/fNVypdselOBRitcdozvS/z4+S4JSSnibhdXpj4XvrILzeHckXW7k
         TT9AN9A97C8A8nqaBTe790+7Gng4RtXSH3AiBZYW13NzsI836Scs9G4C7+UDMilpsLbq
         7QbIMFBBn1/XwslzZ1EtQJqWTigc+d5ba4u1LN0TOcI0B/CHJzQogkv5JYSQA7LrBY44
         oDMIEH9pfHLDEdqJa6CjptioxCvMl0QLRhuqF2wnYn7xauGyZ1PLp/5c6thX7NJtFjw2
         vAvA==
X-Gm-Message-State: ANhLgQ39LKLvMDOZA7aTNXa4zX0g9r6fjzpKyJVrBntKb1MwNekVj2YN
        T3D9Cf3PdhlrSOLTHpCQDz46skPe+KY7tKHyRO4=
X-Google-Smtp-Source: ADFU+vtMg+WEBw5vF05unytjCUApdhR/Zq5TG5wDVYBm08V+l+Yi3qVeyLrJM6LvLBdkFRpW0k1RUoeZcn7FO9TvH+Y=
X-Received: by 2002:aca:5345:: with SMTP id h66mr3810309oib.110.1585166099155;
 Wed, 25 Mar 2020 12:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200320015023.85896-1-abhishekpandit@chromium.org> <20200319185000.BlueZ.v4.2.I2cd5c420daf55ee6084b53e025461824521d744a@changeid>
In-Reply-To: <20200319185000.BlueZ.v4.2.I2cd5c420daf55ee6084b53e025461824521d744a@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Mar 2020 12:54:47 -0700
Message-ID: <CABBYNZL2G7f+OO+W+h+P3v=Gep9tevrJhhNa2w42Le6z3hfYeQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4 2/5] device: Support marking a device with wake allowed
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Thu, Mar 19, 2020 at 6:50 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> If a device is allowed to wake the host system from suspend, it should
> be marked as wake allowed. We add support for a new property that is
> sent to the kernel via flags in the add_device mgmt op. We also add the
> dbus endpoint to allow the wake allowed setting to be controlled.
>
> In order for wake allowed to be set, the profile must also support wake.
> This setting isn't exposed to the user but must be set by profiles that
> intend to support wake from suspend.
> ---
>
> Changes in v4:
> * Renamed wake_capable to wake_allowed
> * Removed set_wake_capable mgmt op and updated add_device to accept
>   flags to set whether a device is wakeable
> * Refactored adapter_whitelist_add and adapter_auto_connect_add to call
>   adapter_add_device
>
> Changes in v3:
> * Added profile_wake_support and made wake_capable dependent on it
>
> Changes in v2:
> * Added dbus api "WakeCapable" to set value
> * Update device_set_wake_capable to be called by
>   adapter_set_wake_capable_complete so we can emit property changed
>
>  lib/mgmt.h    |   3 ++
>  src/adapter.c | 112 ++++++++++++++++----------------------------
>  src/adapter.h |   1 +
>  src/device.c  | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h  |   8 ++++
>  5 files changed, 177 insertions(+), 72 deletions(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 7682537fe..732d3afa8 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -395,10 +395,13 @@ struct mgmt_rp_get_clock_info {
>  struct mgmt_cp_add_device {
>         struct mgmt_addr_info addr;
>         uint8_t action;
> +       uint8_t flags_mask;
> +       uint8_t flags_value;
>  } __packed;
>  struct mgmt_rp_add_device {
>         struct mgmt_addr_info addr;
>  } __packed;
> +#define DEVICE_FLAG_WAKEABLE           0x1
>
>  #define MGMT_OP_REMOVE_DEVICE          0x0034
>  struct mgmt_cp_remove_device {
> diff --git a/src/adapter.c b/src/adapter.c
> index 972d88772..6bfd31fb0 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4654,7 +4654,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
>         trigger_passive_scanning(adapter);
>  }
>
> -static void add_whitelist_complete(uint8_t status, uint16_t length,
> +static void add_device_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
>         const struct mgmt_rp_add_device *rp = param;
> @@ -4670,8 +4670,8 @@ static void add_whitelist_complete(uint8_t status, uint16_t length,
>
>         ba2str(&rp->addr.bdaddr, addr);
>
> -       dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr,
> -                                                       rp->addr.type);
> +       dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr, rp->addr.type);
> +
>         if (!dev) {
>                 btd_error(adapter->dev_id,
>                         "Add Device complete for unknown device %s", addr);
> @@ -4680,29 +4680,50 @@ static void add_whitelist_complete(uint8_t status, uint16_t length,
>
>         if (status != MGMT_STATUS_SUCCESS) {
>                 btd_error(adapter->dev_id,
> -                                       "Failed to add device %s: %s (0x%02x)",
> -                                       addr, mgmt_errstr(status), status);
> +                       "Failed to add device %s (%u): %s (0x%02x)",
> +                       addr, rp->addr.type, mgmt_errstr(status), status);

Don't we have to handle the case where the kernel is older and the
command fails?

> +
> +               if (rp->addr.type != BDADDR_BREDR)
> +                       adapter->connect_list =
> +                               g_slist_remove(adapter->connect_list, dev);
>                 return;
>         }
>
> -       DBG("%s added to kernel whitelist", addr);
> +       /* Update flag results if any */
> +       device_add_complete(dev);
> +
> +       DBG("%s (%u) added to kernel connect list", addr, rp->addr.type);
>  }
>
> -void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
> +int adapter_add_device(struct btd_adapter *adapter, struct btd_device *device)
>  {
>         struct mgmt_cp_add_device cp;
> +       const bdaddr_t *bdaddr;
> +       uint8_t bdaddr_type;
>
>         if (!kernel_conn_control)
> -               return;
> +               return 0;
> +
> +       bdaddr = device_get_address(device);
> +       bdaddr_type = btd_device_get_bdaddr_type(device);
>
>         memset(&cp, 0, sizeof(cp));
> -       bacpy(&cp.addr.bdaddr, device_get_address(dev));
> -       cp.addr.type = BDADDR_BREDR;
> -       cp.action = 0x01;
> +       bacpy(&cp.addr.bdaddr, bdaddr);
> +       cp.addr.type = bdaddr_type;
>
> -       mgmt_send(adapter->mgmt, MGMT_OP_ADD_DEVICE,
> -                               adapter->dev_id, sizeof(cp), &cp,
> -                               add_whitelist_complete, adapter, NULL);
> +       /* BREDR will always have action = 0x1 (allow incoming connection) */
> +       cp.action = bdaddr_type == BDADDR_BREDR ? 0x1 : 0x2;
> +       cp.flags_mask = device_get_flags_mask(device);
> +       cp.flags_value = device_get_flags_value(device);

An alternative to check if the command fails due to the kernel not
understanding the command flags perhaps we could send it based on the
revision provided we bump the revision with this change, anyway we
will need to make it work with older kernels as well. Also perhaps we
should add tests to mgmt-tester to validate this set, it should skip
the test if the kernel is too old and don't support it.

> +
> +       return mgmt_send(adapter->mgmt, MGMT_OP_ADD_DEVICE,
> +                       adapter->dev_id, sizeof(cp), &cp, add_device_complete,
> +                       adapter, NULL);
> +}
> +
> +void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
> +{
> +       adapter_add_device(adapter, dev);
>  }
>
>  static void remove_whitelist_complete(uint8_t status, uint16_t length,
> @@ -4743,76 +4764,23 @@ void adapter_whitelist_remove(struct btd_adapter *adapter, struct btd_device *de
>                                 remove_whitelist_complete, adapter, NULL);
>  }
>
> -static void add_device_complete(uint8_t status, uint16_t length,
> -                                       const void *param, void *user_data)
> -{
> -       const struct mgmt_rp_add_device *rp = param;
> -       struct btd_adapter *adapter = user_data;
> -       struct btd_device *dev;
> -       char addr[18];
> -
> -       if (length < sizeof(*rp)) {
> -               btd_error(adapter->dev_id,
> -                               "Too small Add Device complete event");
> -               return;
> -       }
> -
> -       ba2str(&rp->addr.bdaddr, addr);
> -
> -       dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr,
> -                                                       rp->addr.type);
> -       if (!dev) {
> -               btd_error(adapter->dev_id,
> -                       "Add Device complete for unknown device %s", addr);
> -               return;
> -       }
> -
> -       if (status != MGMT_STATUS_SUCCESS) {
> -               btd_error(adapter->dev_id,
> -                       "Failed to add device %s (%u): %s (0x%02x)",
> -                       addr, rp->addr.type, mgmt_errstr(status), status);
> -               adapter->connect_list = g_slist_remove(adapter->connect_list,
> -                                                                       dev);
> -               return;
> -       }
> -
> -       DBG("%s (%u) added to kernel connect list", addr, rp->addr.type);
> -}
> -
>  void adapter_auto_connect_add(struct btd_adapter *adapter,
> -                                       struct btd_device *device)
> +                             struct btd_device *device)
>  {
> -       struct mgmt_cp_add_device cp;
> -       const bdaddr_t *bdaddr;
> -       uint8_t bdaddr_type;
> -       unsigned int id;
> -
> -       if (!kernel_conn_control)
> -               return;
> +       uint8_t bdaddr_type = btd_device_get_bdaddr_type(device);
>
>         if (g_slist_find(adapter->connect_list, device)) {
>                 DBG("ignoring already added device %s",
> -                                               device_get_path(device));
> +                   device_get_path(device));
>                 return;
>         }
>
> -       bdaddr = device_get_address(device);
> -       bdaddr_type = btd_device_get_bdaddr_type(device);
> -
>         if (bdaddr_type == BDADDR_BREDR) {
> -               DBG("auto-connection feature is not avaiable for BR/EDR");
> +               DBG("auto-connection feature is not available for BR/EDR");
>                 return;
>         }
>
> -       memset(&cp, 0, sizeof(cp));
> -       bacpy(&cp.addr.bdaddr, bdaddr);
> -       cp.addr.type = bdaddr_type;
> -       cp.action = 0x02;
> -
> -       id = mgmt_send(adapter->mgmt, MGMT_OP_ADD_DEVICE,
> -                       adapter->dev_id, sizeof(cp), &cp, add_device_complete,
> -                       adapter, NULL);
> -       if (id == 0)
> +       if (adapter_add_device(adapter, device) == 0)
>                 return;
>
>         adapter->connect_list = g_slist_append(adapter->connect_list, device);
> diff --git a/src/adapter.h b/src/adapter.h
> index d0a5253bd..a5a9e917a 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -213,6 +213,7 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
>                                         struct btd_device *device);
>  void adapter_connect_list_remove(struct btd_adapter *adapter,
>                                                 struct btd_device *device);
> +int adapter_add_device(struct btd_adapter* adapter, struct btd_device* dev);
>  void adapter_auto_connect_add(struct btd_adapter *adapter,
>                                         struct btd_device *device);
>  void adapter_auto_connect_remove(struct btd_adapter *adapter,
> diff --git a/src/device.c b/src/device.c
> index 69f98e488..c646a7fee 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -184,11 +184,15 @@ struct btd_device {
>         uint8_t         conn_bdaddr_type;
>         bdaddr_t        bdaddr;
>         uint8_t         bdaddr_type;
> +       uint8_t         mgmt_flags_mask;   /* Flags to update on add_device */
> +       uint8_t         mgmt_flags_value; /* Flag values for add_device */
>         char            *path;
>         bool            bredr;
>         bool            le;
>         bool            pending_paired;         /* "Paired" waiting for SDP */
>         bool            svc_refreshed;
> +       bool            wake_support;           /* Profile supports wake */
> +       bool            wake_allowed;           /* Can wake from suspend */
>         GSList          *svc_callbacks;
>         GSList          *eir_uuids;
>         struct bt_ad    *ad;
> @@ -415,6 +419,9 @@ static gboolean store_device_info_cb(gpointer user_data)
>         g_key_file_set_boolean(key_file, "General", "Blocked",
>                                                         device->blocked);
>
> +       g_key_file_set_boolean(key_file, "General", "WakeAllowed",
> +                                                       device->wake_allowed);
> +
>         if (device->uuids) {
>                 GSList *l;
>                 int i;
> @@ -1318,6 +1325,79 @@ dev_property_advertising_data_exist(const GDBusPropertyTable *property,
>         return bt_ad_has_data(device->ad, NULL);
>  }
>
> +bool device_get_wake_support(struct btd_device *device)
> +{
> +       return device->wake_support;
> +}
> +
> +void device_set_wake_support(struct btd_device *device, bool wake_support)
> +{
> +       device->wake_support = wake_support;
> +}
> +
> +bool device_get_wake_allowed(struct btd_device *device)
> +{
> +       return device->wake_allowed;
> +}
> +
> +void device_set_wake_allowed(struct btd_device *device, bool wake_allowed)
> +{
> +       device->mgmt_flags_mask |= DEVICE_FLAG_WAKEABLE;
> +       if (wake_allowed)
> +               device->mgmt_flags_value |= DEVICE_FLAG_WAKEABLE;
> +       else
> +               device->mgmt_flags_value &= ~DEVICE_FLAG_WAKEABLE;
> +
> +       adapter_add_device(device->adapter, device);
> +}
> +
> +static gboolean
> +dev_property_get_wake_allowed(const GDBusPropertyTable *property,
> +                            DBusMessageIter *iter, void *data)
> +{
> +       struct btd_device *device = data;
> +       dbus_bool_t wake_allowed =
> +                       device_get_wake_allowed(device) ? TRUE : FALSE;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &wake_allowed);
> +
> +       return TRUE;
> +}
> +
> +static void dev_property_set_wake_allowed(const GDBusPropertyTable *property,
> +                                        DBusMessageIter *value,
> +                                        GDBusPendingPropertySet id, void *data)
> +{
> +       struct btd_device *device = data;
> +       dbus_bool_t b;
> +
> +       if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
> +               g_dbus_pending_property_error(id,
> +                                       ERROR_INTERFACE ".InvalidArguments",
> +                                       "Invalid arguments in method call");
> +               return;
> +       }
> +
> +       if (device->temporary) {
> +               g_dbus_pending_property_error(id,
> +                                       ERROR_INTERFACE ".Unsupported",
> +                                       "Cannot set property while temporary");
> +               return;
> +       }
> +
> +       dbus_message_iter_get_basic(value, &b);
> +       device_set_wake_allowed(device, b);
> +       g_dbus_pending_property_success(id);
> +}
> +
> +static gboolean dev_property_wake_allowed_exist(
> +               const GDBusPropertyTable *property, void *data)
> +{
> +       struct btd_device *device = data;
> +
> +       return device_get_wake_support(device) ? TRUE : FALSE;
> +}
> +
>  static gboolean disconnect_all(gpointer user_data)
>  {
>         struct btd_device *device = user_data;
> @@ -2779,6 +2859,9 @@ static const GDBusPropertyTable device_properties[] = {
>         { "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
>                                 NULL, dev_property_advertising_data_exist,
>                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +       { "WakeAllowed", "b", dev_property_get_wake_allowed,
> +                               dev_property_set_wake_allowed,
> +                               dev_property_wake_allowed_exist },
>         { }
>  };
>
> @@ -3030,6 +3113,7 @@ static void load_info(struct btd_device *device, const char *local,
>         char *str;
>         gboolean store_needed = FALSE;
>         gboolean blocked;
> +       gboolean wake_allowed;
>         char **uuids;
>         int source, vendor, product, version;
>         char **techno, **t;
> @@ -3141,6 +3225,14 @@ next:
>                 btd_device_set_pnpid(device, source, vendor, product, version);
>         }
>
> +       /* Mark wake allowed */
> +       wake_allowed = g_key_file_get_boolean(key_file, "General",
> +                                             "WakeAllowed", NULL);
> +       if (wake_allowed) {
> +               device->mgmt_flags_mask |= DEVICE_FLAG_WAKEABLE;
> +               device->mgmt_flags_value |= DEVICE_FLAG_WAKEABLE;
> +       }
> +
>         if (store_needed)
>                 store_device_info(device);
>  }
> @@ -3959,6 +4051,39 @@ char *btd_device_get_storage_path(struct btd_device *device,
>                                 dstaddr, filename);
>  }
>
> +void device_add_complete(struct btd_device *device)
> +{
> +       bool flag = false;
> +
> +       /* No flags updated */
> +       if (!device->mgmt_flags_mask)
> +               return;
> +
> +       if (device->mgmt_flags_mask & DEVICE_FLAG_WAKEABLE)
> +       {
> +               flag = device->mgmt_flags_value & DEVICE_FLAG_WAKEABLE;
> +               device->wake_allowed = flag;
> +
> +               store_device_info(device);
> +               g_dbus_emit_property_changed(dbus_conn, device->path,
> +                                            DEVICE_INTERFACE, "WakeAllowed");
> +       }
> +
> +       /* Clear mask and values for next completion */
> +       device->mgmt_flags_mask = 0;
> +       device->mgmt_flags_value = 0;
> +}
> +
> +uint8_t device_get_flags_mask(struct btd_device *device)
> +{
> +       return device->mgmt_flags_mask;
> +}
> +
> +uint8_t device_get_flags_value(struct btd_device *device)
> +{
> +       return device->mgmt_flags_value;
> +}
> +
>  void btd_device_device_set_name(struct btd_device *device, const char *name)
>  {
>         if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
> diff --git a/src/device.h b/src/device.h
> index 06b100499..85e33f1cd 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -33,6 +33,10 @@ struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
>  char *btd_device_get_storage_path(struct btd_device *device,
>                                 const char *filename);
>
> +void device_add_complete(struct btd_device *device);
> +uint8_t device_get_flags_mask(struct btd_device *device);
> +uint8_t device_get_flags_value(struct btd_device *device);
> +
>  void btd_device_device_set_name(struct btd_device *device, const char *name);
>  void device_store_cached_name(struct btd_device *dev, const char *name);
>  void device_get_name(struct btd_device *device, char *name, size_t len);
> @@ -139,6 +143,10 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
>                                                                 uint16_t value);
>  void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
>                                                         uint16_t *ccc_bredr);
> +bool device_get_wake_support(struct btd_device *device);
> +void device_set_wake_support(struct btd_device *device, bool wake_support);
> +bool device_get_wake_allowed(struct btd_device *device);
> +void device_set_wake_allowed(struct btd_device *device, bool wake_allowed);
>
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
>                                         void *user_data);
> --
> 2.25.1.696.g5e7596f4ac-goog
>


-- 
Luiz Augusto von Dentz

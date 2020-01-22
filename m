Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E92C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 23:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6D2253D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 23:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb4XnITj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVXWW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:22:22 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37648 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgAVXWW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 18:22:22 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so1036069otn.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 15:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hl/dUFXQe4HAFzaUtI4YdhzXV84M9FxBHvZ/RzUHOpw=;
        b=Gb4XnITjmlrbgs42B3vZprQMyWbMrOE/5wOSHjfTyQSKjNRxjGlm5lNXDPF18l5YLi
         wOQvehrxEpltsjfzKzzSBqryQz913P0wse5MmKsGdK3ElUjVrLptgjDm4cO2tRuNAZKw
         9im8pr+rsQhW4Vh8J6viG3cbi+m0eCWu+nKzVJjFCpfCY4ZrIAW+QaJhtCg6DIVTT5tt
         CJI8nzcgtTQjgGbXM5Ftl6df4mGRjlvLy1F6gDqQ/k/AdvMaPu6FXqiEM0yKb8sSS+tq
         vyZ7Ko9UGwZGGAyo02sZTty2yuwJ1uSf4QEVjLsjF5L2yQX8v4h9jw7TeoAqZE3TvEw/
         2ohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl/dUFXQe4HAFzaUtI4YdhzXV84M9FxBHvZ/RzUHOpw=;
        b=Exa8I2Z0IPsVhnjnqV0x+7lJu8A9/vJHAdmcP7FV4r6G/HNhbLH0FEhwCGnQmtuwyA
         oj+vRijKRmnfhLm1ZTfpvijdrMksAY8xgJts0vvo+u7XpcBGdsCihFdhtK+3tTODrAlo
         oErXwu+LG/FyBFV/g5jXNbIYKh5HhVG4s9xOR/ho+wNedLoAxaWQAbDAmHRxBX6ix8Ni
         B6gfs+226oENKLfrXc5/VYdkj59SXbqqDNPSFZF7YO/7D+GEci+kwb01Yb8rMUXIjrf2
         yvfI3ERCSx2nQSQLPn9RiDwrubO3jWpWZ28G5IPIwVVbP1rrnodgTC7N9koAbbiQ8x5k
         Fylg==
X-Gm-Message-State: APjAAAVVvQztDrl/eZrv6MYV+kotgFbqoW7FYNAYvtLCYalrtqhmgTdo
        dDQeCWGn63f4DUGUzeKzHD5iQELnDHrHRO6Z2xo=
X-Google-Smtp-Source: APXvYqyzZVRwXhx38raERrINGi2ounagA494a+bSSc+5dcjvo767u3U++ZUUVvLjWRgJ/WqgC4eYTV92w+i01m8oGNc=
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr9488888otf.11.1579735340171;
 Wed, 22 Jan 2020 15:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20200121232700.158933-1-abhishekpandit@chromium.org> <20200121152640.BlueZ.v2.2.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
In-Reply-To: <20200121152640.BlueZ.v2.2.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Jan 2020 15:22:08 -0800
Message-ID: <CABBYNZ+TYp6ZmMtp34_XvTYc11Fk2-o4f3zYBGzy5i=eZPUb+g@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2 2/3] device: Allow device to be marked as wake capable
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Tue, Jan 21, 2020 at 3:27 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> If a device is capable of waking the host system from suspend, it should
> be marked as wake capable. We introduce a new management operation here
> to set this property and implement the API needed to call it. We also
> add the dbus endpoint to allow the wake capable setting to be
> controlled.
>
> ---
>
> Changes in v2:
> * Added dbus api "WakeCapable" to set value
> * Update device_set_wake_capable to be called by
>   adapter_set_wake_capable_complete so we can emit property changed
>
>  lib/mgmt.h    |  9 +++++++
>  src/adapter.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h |  2 ++
>  src/device.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h  |  2 ++
>  5 files changed, 137 insertions(+)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 276445d0a..cf19dd086 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -599,6 +599,13 @@ struct mgmt_cp_set_blocked_keys {
>         struct mgmt_blocked_key_info keys[0];
>  } __packed;
>
> +#define MGMT_OP_SET_WAKE_CAPABLE                       0x0047
> +#define MGMT_SET_WAKE_CAPABLE_SIZE                     8
> +struct mgmt_cp_set_wake_capable {
> +       struct mgmt_addr_info addr;
> +       uint8_t wake_enable;
> +} __packed;
> +
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         uint16_t opcode;
> @@ -893,6 +900,8 @@ static const char *mgmt_op[] = {
>         "Set Appearance",
>         "Get PHY Configuration",
>         "Set PHY Configuration",
> +       "Set Blocked Keys",
> +       "Set Wake Capable",
>  };
>
>  static const char *mgmt_ev[] = {
> diff --git a/src/adapter.c b/src/adapter.c
> index 329c3ae0b..1ea5905b5 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4685,6 +4685,71 @@ void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
>                                 add_whitelist_complete, adapter, NULL);
>  }
>
> +static void set_wake_capable_complete(uint8_t status, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       const struct mgmt_cp_set_wake_capable *rp = param;
> +       struct btd_adapter *adapter = user_data;
> +       struct btd_device *dev;
> +
> +       char addr[18];
> +
> +       if (length < sizeof(*rp)) {
> +               btd_error(adapter->dev_id,
> +                         "Too small Set Wake Capable complete event");
> +               return;
> +        }
> +
> +       ba2str(&rp->addr.bdaddr, addr);
> +
> +       dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr,
> +                                     rp->addr.type);
> +       if (!dev) {
> +               btd_error(adapter->dev_id,
> +                         "Set Wake Capable complete for unknown device %s",
> +                         addr);
> +               return;
> +       }
> +
> +       if (status != MGMT_STATUS_SUCCESS) {
> +               btd_error(adapter->dev_id,
> +                         "Failed to set wake capable %s(%u) = %d: %s (0x%02x)",
> +                         addr, rp->addr.type, rp->wake_enable,
> +                         mgmt_errstr(status), status);
> +               return;
> +       }
> +
> +       device_set_wake_capable(dev, rp->wake_enable);
> +
> +       DBG("Set wake capable complete %s (%u)", addr, rp->addr.type);
> +}
> +
> +void adapter_set_wake_capable(struct btd_adapter* adapter,
> +                             struct btd_device* dev,
> +                             bool wake_enable)
> +{
> +       struct mgmt_cp_set_wake_capable cp;
> +       char addr[18];
> +
> +       memset(&cp, 0, sizeof(cp));
> +       bacpy(&cp.addr.bdaddr, device_get_address(dev));
> +       cp.addr.type = btd_device_get_bdaddr_type(dev);
> +       cp.wake_enable = wake_enable;
> +
> +       ba2strlc(&cp.addr.bdaddr, addr);
> +
> +       if (!mgmt_send(adapter->mgmt, MGMT_OP_SET_WAKE_CAPABLE, adapter->dev_id,
> +                      sizeof(cp), &cp, set_wake_capable_complete, adapter,
> +                      NULL)) {
> +               btd_warn(adapter->dev_id,
> +                        "Could not set wake capable = %u on %s (%u)",
> +                        cp.wake_enable, addr, cp.addr.type);
> +       }
> +
> +       DBG("Setting %s (%u) to wake capable = %u", addr,
> +           cp.addr.type, cp.wake_enable);
> +}
> +
>  static void remove_whitelist_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> diff --git a/src/adapter.h b/src/adapter.h
> index d0a5253bd..e990279ed 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -221,6 +221,8 @@ void adapter_whitelist_add(struct btd_adapter *adapter,
>                                                 struct btd_device *dev);
>  void adapter_whitelist_remove(struct btd_adapter *adapter,
>                                                 struct btd_device *dev);
> +void adapter_set_wake_capable(struct btd_adapter* adapter,
> +                             struct btd_device* dev, bool wake_enable);
>
>  void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
>                                                 struct oob_handler *handler);
> diff --git a/src/device.c b/src/device.c
> index a4fe10980..7bfd73093 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -189,6 +189,7 @@ struct btd_device {
>         bool            le;
>         bool            pending_paired;         /* "Paired" waiting for SDP */
>         bool            svc_refreshed;
> +       bool            wake_capable;           /* Can wake from suspend */
>         GSList          *svc_callbacks;
>         GSList          *eir_uuids;
>         struct bt_ad    *ad;
> @@ -415,6 +416,9 @@ static gboolean store_device_info_cb(gpointer user_data)
>         g_key_file_set_boolean(key_file, "General", "Blocked",
>                                                         device->blocked);
>
> +       g_key_file_set_boolean(key_file, "General", "WakeCapable",
> +                                                       device->wake_capable);
> +
>         if (device->uuids) {
>                 GSList *l;
>                 int i;
> @@ -1318,6 +1322,39 @@ dev_property_advertising_data_exist(const GDBusPropertyTable *property,
>         return bt_ad_has_data(device->ad, NULL);
>  }
>
> +static gboolean
> +dev_property_get_wake_capable(const GDBusPropertyTable *property,
> +                            DBusMessageIter *iter, void *data)
> +{
> +       struct btd_device *device = data;
> +       dbus_bool_t wake_capable =
> +                       device_get_wake_capable(device) ? TRUE : FALSE;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &wake_capable);
> +
> +       return TRUE;
> +}
> +
> +static void dev_property_set_wake_capable(const GDBusPropertyTable *property,
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
> +       dbus_message_iter_get_basic(value, &b);
> +
> +       adapter_set_wake_capable(device->adapter, device, b == TRUE);
> +       g_dbus_pending_property_success(id);
> +}
> +
>  static gboolean disconnect_all(gpointer user_data)
>  {
>         struct btd_device *device = user_data;
> @@ -1509,6 +1546,20 @@ void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
>         bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
>  }
>
> +bool device_get_wake_capable(struct btd_device *device)
> +{
> +       return device->wake_capable;
> +}
> +
> +void device_set_wake_capable(struct btd_device *device, bool wake_capable)
> +{
> +       device->wake_capable = wake_capable;
> +
> +       store_device_info(device);
> +       g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
> +                                    "WakeCapable");
> +}
> +
>  static void device_set_auto_connect(struct btd_device *device, gboolean enable)
>  {
>         char addr[18];
> @@ -2779,6 +2830,8 @@ static const GDBusPropertyTable device_properties[] = {
>         { "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
>                                 NULL, dev_property_advertising_data_exist,
>                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +       { "WakeCapable", "b", dev_property_get_wake_capable,
> +                               dev_property_set_wake_capable},

We are missing the documentation for these changes, we might want to
enable the property only for certain type of devices, the way I would
do is to have the plugin flag that the device as wake capable and then
use the exist callback to check that, that way the property only
appear for devices were it makes sense to enable this feature, so you
would need to have a second filed saying if it active or not or
perhaps have an enum with 3 possible values, UNSUPPORTED, DISABLED,
ENABLED.

>         { }
>  };
>
> @@ -3030,6 +3083,7 @@ static void load_info(struct btd_device *device, const char *local,
>         char *str;
>         gboolean store_needed = FALSE;
>         gboolean blocked;
> +       gboolean wake_capable;
>         char **uuids;
>         int source, vendor, product, version;
>         char **techno, **t;
> @@ -3141,6 +3195,11 @@ next:
>                 btd_device_set_pnpid(device, source, vendor, product, version);
>         }
>
> +       /* Mark wake capable */
> +       wake_capable = g_key_file_get_boolean(key_file, "General",
> +                                             "WakeCapable", NULL, NULL);
> +       adapter_set_wake_capable(device->adapter, device, wake_capable == TRUE);
> +
>         if (store_needed)
>                 store_device_info(device);
>  }
> diff --git a/src/device.h b/src/device.h
> index 06b100499..44df8e22e 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -139,6 +139,8 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
>                                                                 uint16_t value);
>  void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
>                                                         uint16_t *ccc_bredr);
> +bool device_get_wake_capable(struct btd_device *device);
> +void device_set_wake_capable(struct btd_device *device, bool wake_capable);
>
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
>                                         void *user_data);
> --
> 2.25.0.341.g760bfbb309-goog
>


-- 
Luiz Augusto von Dentz

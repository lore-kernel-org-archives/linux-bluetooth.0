Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295ACC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C726D206A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPWTQpIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgA1U3h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:29:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36635 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1U3h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 15:29:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so11688617oic.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8To7b04e1zJapvMrX210HfRlrgbpO84m+G9c3jwNgnM=;
        b=UPWTQpIhrbrx0OpFPJFk3vscKFPTuFlGkubiYOUdgepMLnnjFehdk1BEB47uiQiLB0
         Gk4pbLjD/9wsg6osZkav3zY6DlqyDoHP4IIxNOKHKAeoeZR0jMTJNIvjlJVkXdvjhlwp
         GbogI+rQgS3DzDEzY/6e5v88xPzIH21A9vJzK/nmQZAPZB3w591qB05spP8sxBFS1fwF
         tFBFDu15DiG4KH1A5YCSFX/l7AcejlRrIR4rNQmZNB2VPheKunV3Whrvyvj14dJR6W1E
         PUyepnHhmmKjAA0iUiFZ2EQE/gVNjeMFWuhkqd0c9PcXoXlDccEQ66LVxXgp6+V7+lZv
         ipSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8To7b04e1zJapvMrX210HfRlrgbpO84m+G9c3jwNgnM=;
        b=mccICqgDFEjb9peeO7Jj2ugi8vBX//AH2YEAncGKqrLbuynz2BNJSUDlgWMeNjpQmM
         LD9x7DLluSgN7q17SFsaMeA1ivAIsm6NL52WTFFSbktoFVqPB46rKTYcXjOShWtP68C+
         4aTmhS93rXLnv52xHpbTrxDeHKndqlXCsWIVuk7VvtnAvdMEU0hmRAqyh3gkPm5aNxUo
         Qu3A9/0uZkV2mIMikzlSysZefm9dus79AABvup9CSzk9huuFRH8+tVO0Csq/yyONBbGQ
         BwX8514SLUd8pAR2xzHi6vb8vcdKsBdq4RPbU5LPMgpOwlOMVy/sQpa3rKenl+hw+9d4
         LNgg==
X-Gm-Message-State: APjAAAUyoIBo7bM8T+ZyOQSY2D2I3uujWUDkROWncStGdlhWSqj11MgO
        bPLUBYLu9UAZCXrIQflhSzJOBKYq8Xqxc/hj24z0GYir
X-Google-Smtp-Source: APXvYqxT3XCGOfJzYb2laYeiNdQDNt+XsIf3s/in/2122TVit+n3zS9SGJJuEUvgfmc9NgDZTObF5LJ0CMStBpmmCkA=
X-Received: by 2002:aca:ab51:: with SMTP id u78mr4161850oie.21.1580243375817;
 Tue, 28 Jan 2020 12:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20200128104327.BlueZ.v3.2.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
In-Reply-To: <20200128104327.BlueZ.v3.2.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Jan 2020 12:29:24 -0800
Message-ID: <CABBYNZJMmVNBBCkY-7pyPP1kUQVx6RDM=yuhMoBqVkSR-RSgZg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 2/5] device: Allow device to be marked as wake capable
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

On Tue, Jan 28, 2020 at 10:44 AM Abhishek Pandit-Subedi
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
> Changes in v3:
> * Added profile_wake_support and made wake_capable dependent on it
>
> Changes in v2:
> * Added dbus api "WakeCapable" to set value
> * Update device_set_wake_capable to be called by
>   adapter_set_wake_capable_complete so we can emit property changed
>
>  lib/mgmt.h    |  9 ++++++
>  src/adapter.c | 65 ++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h |  2 ++
>  src/device.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h  |  5 ++++
>  5 files changed, 164 insertions(+)
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
> index 329c3ae0b..294a9c9e4 100644
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

Extra empty line not needed.

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

Shouldn't there be a way to check if the kernel does actually support
the command first? We shouldn't be attempting to use it with kernels
that don't support it and the property should also not appear in that
case, so it is only visible if:

1. Kernel reports that Wake Capable command is supported
2. A driver/plugin/profile calls device_set_wake_support

Also in case those 2 conditions are attended bu the command fails we
should reply with an error since there won't be any PropertiesChanged
to indicate something went wrong.

> +       memset(&cp, 0, sizeof(cp));
> +       bacpy(&cp.addr.bdaddr, device_get_address(dev));
> +       cp.addr.type = btd_device_get_bdaddr_type(dev);
> +       cp.wake_enable = device_get_profile_wake_support(dev) && wake_enable;
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
> index a4fe10980..7a455e1e9 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -189,6 +189,8 @@ struct btd_device {
>         bool            le;
>         bool            pending_paired;         /* "Paired" waiting for SDP */
>         bool            svc_refreshed;
> +       bool            profile_wake_support;   /* Profile supports wake */

I guess we can drop the profile term here since that is implicit already.

> +       bool            wake_capable;           /* Can wake from suspend */
>         GSList          *svc_callbacks;
>         GSList          *eir_uuids;
>         struct bt_ad    *ad;
> @@ -415,6 +417,9 @@ static gboolean store_device_info_cb(gpointer user_data)
>         g_key_file_set_boolean(key_file, "General", "Blocked",
>                                                         device->blocked);
>
> +       g_key_file_set_boolean(key_file, "General", "WakeCapable",
> +                                                       device->wake_capable);
> +
>         if (device->uuids) {
>                 GSList *l;
>                 int i;
> @@ -1318,6 +1323,47 @@ dev_property_advertising_data_exist(const GDBusPropertyTable *property,
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
> +static gboolean dev_property_wake_capable_exist(
> +               const GDBusPropertyTable *property, void *data)
> +{
> +       struct btd_device *device = data;
> +
> +       return device_get_profile_wake_support(device) ? TRUE : FALSE;
> +}
> +
>  static gboolean disconnect_all(gpointer user_data)
>  {
>         struct btd_device *device = user_data;
> @@ -1509,6 +1555,34 @@ void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
>         bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
>  }
>
> +bool device_get_profile_wake_support(struct btd_device *device)
> +{
> +       return device->profile_wake_support;
> +}
> +
> +void device_set_profile_wake_support(struct btd_device *device,
> +                                    bool wake_support)
> +{
> +       device->profile_wake_support = wake_support;
> +       /* WakeCapable is only visible when wake_support is true */
> +       g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
> +                                    "WakeCapable");
> +}
> +
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
> @@ -2779,6 +2853,9 @@ static const GDBusPropertyTable device_properties[] = {
>         { "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
>                                 NULL, dev_property_advertising_data_exist,
>                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> +       { "WakeCapable", "b", dev_property_get_wake_capable,
> +                               dev_property_set_wake_capable,
> +                               dev_property_wake_capable_exist },
>         { }
>  };
>
> @@ -3030,6 +3107,7 @@ static void load_info(struct btd_device *device, const char *local,
>         char *str;
>         gboolean store_needed = FALSE;
>         gboolean blocked;
> +       gboolean wake_capable;
>         char **uuids;
>         int source, vendor, product, version;
>         char **techno, **t;
> @@ -3141,6 +3219,11 @@ next:
>                 btd_device_set_pnpid(device, source, vendor, product, version);
>         }
>
> +       /* Mark wake capable */
> +       wake_capable = g_key_file_get_boolean(key_file, "General",
> +                                             "WakeCapable", NULL);
> +       adapter_set_wake_capable(device->adapter, device, wake_capable == TRUE);
> +
>         if (store_needed)
>                 store_device_info(device);
>  }
> diff --git a/src/device.h b/src/device.h
> index 06b100499..43f633e38 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -139,6 +139,11 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
>                                                                 uint16_t value);
>  void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
>                                                         uint16_t *ccc_bredr);
> +bool device_get_profile_wake_support(struct btd_device *device);
> +void device_set_profile_wake_support(struct btd_device *device,
> +                                    bool wake_support);
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

Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16396C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 22:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C531E21739
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 22:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mTACF6JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgA1WMq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:12:46 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32837 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgA1WMq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 17:12:46 -0500
Received: by mail-ua1-f66.google.com with SMTP id a12so5457568uan.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nsu18orQuk0dbmxPCcSiluaVbyTV5gU0e6+jxSAI5GA=;
        b=mTACF6JAZg67LZYyZHocActjujAtbgiqeYk5D8xwnyJfUFmlkz1sAP+B2/IF91uIJ4
         PGv74DFT84WmldXmYYHOXiYAB6RLMSpeQeSNOtHHRtb4o66eiDT1mMu0fnEcZpsxrIf/
         ABvGw+H67rjRjAeMu8gs+wgYjKb/yOAP0iVYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nsu18orQuk0dbmxPCcSiluaVbyTV5gU0e6+jxSAI5GA=;
        b=Kythm+MDm71hquvvGgUWM3teFp1SDZdkQQyRmsVArP4ZNmTub52Wfakj29o31fU4Cs
         V+xzIhxgcRNg6V6p4ApmooAumjGhH5BWEmgqM4A55/5S3/U7UGkQo8ifS+yG4gCwcf35
         StIo1LM4MohfLTpWndPgX6lwiZy+JB5OCYINlcZKG8oGvvc9lMSoRZjpeOLsmaZe5qQH
         SI/blvOu6QJ6TL7tMgOZZMBG6Nvt+9iqXdCewUZiMNliJGPA31maKl068ue4BlKC7gWY
         HWVe3pz1kPp6IOPDaiQI2VqVBRjHuvprQbYrwZ5M9qRuXOgGNyN2lMW67NzOThE1VMUv
         F0NQ==
X-Gm-Message-State: APjAAAXlsYWxF93ChpAO1LsdV+Tcj6yNBdtTXHLjQ0OAhGHIO471yCAs
        Dx/I2gmeV+E7ZbqvF8D2WjY/eoIVImK7v0k5hh8w+g==
X-Google-Smtp-Source: APXvYqwuj3MSjBOhtE/9S2YmhQoijTz88hQv8WBsvYylkjJ1hdMTmzySu22mmEcRK8OxtEbgOfzoCzvCzNC3EBTxkdM=
X-Received: by 2002:ab0:2252:: with SMTP id z18mr13818660uan.60.1580249564111;
 Tue, 28 Jan 2020 14:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20200128104327.BlueZ.v3.2.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
 <CABBYNZJMmVNBBCkY-7pyPP1kUQVx6RDM=yuhMoBqVkSR-RSgZg@mail.gmail.com>
In-Reply-To: <CABBYNZJMmVNBBCkY-7pyPP1kUQVx6RDM=yuhMoBqVkSR-RSgZg@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 28 Jan 2020 14:12:33 -0800
Message-ID: <CANFp7mXNwryRp1Mygi=gGHj7cc8mBWWjUVck627r2FRD3Xr22Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 2/5] device: Allow device to be marked as wake capable
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Jan 28, 2020 at 12:29 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Tue, Jan 28, 2020 at 10:44 AM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > If a device is capable of waking the host system from suspend, it should
> > be marked as wake capable. We introduce a new management operation here
> > to set this property and implement the API needed to call it. We also
> > add the dbus endpoint to allow the wake capable setting to be
> > controlled.
> >
> > ---
> >
> > Changes in v3:
> > * Added profile_wake_support and made wake_capable dependent on it
> >
> > Changes in v2:
> > * Added dbus api "WakeCapable" to set value
> > * Update device_set_wake_capable to be called by
> >   adapter_set_wake_capable_complete so we can emit property changed
> >
> >  lib/mgmt.h    |  9 ++++++
> >  src/adapter.c | 65 ++++++++++++++++++++++++++++++++++++++++
> >  src/adapter.h |  2 ++
> >  src/device.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/device.h  |  5 ++++
> >  5 files changed, 164 insertions(+)
> >
> > diff --git a/lib/mgmt.h b/lib/mgmt.h
> > index 276445d0a..cf19dd086 100644
> > --- a/lib/mgmt.h
> > +++ b/lib/mgmt.h
> > @@ -599,6 +599,13 @@ struct mgmt_cp_set_blocked_keys {
> >         struct mgmt_blocked_key_info keys[0];
> >  } __packed;
> >
> > +#define MGMT_OP_SET_WAKE_CAPABLE                       0x0047
> > +#define MGMT_SET_WAKE_CAPABLE_SIZE                     8
> > +struct mgmt_cp_set_wake_capable {
> > +       struct mgmt_addr_info addr;
> > +       uint8_t wake_enable;
> > +} __packed;
> > +
> >  #define MGMT_EV_CMD_COMPLETE           0x0001
> >  struct mgmt_ev_cmd_complete {
> >         uint16_t opcode;
> > @@ -893,6 +900,8 @@ static const char *mgmt_op[] = {
> >         "Set Appearance",
> >         "Get PHY Configuration",
> >         "Set PHY Configuration",
> > +       "Set Blocked Keys",
> > +       "Set Wake Capable",
> >  };
> >
> >  static const char *mgmt_ev[] = {
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 329c3ae0b..294a9c9e4 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -4685,6 +4685,71 @@ void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
> >                                 add_whitelist_complete, adapter, NULL);
> >  }
> >
> > +static void set_wake_capable_complete(uint8_t status, uint16_t length,
> > +                                       const void *param, void *user_data)
> > +{
> > +       const struct mgmt_cp_set_wake_capable *rp = param;
> > +       struct btd_adapter *adapter = user_data;
> > +       struct btd_device *dev;
>
> Extra empty line not needed.

My git merging skills have failed me yet again. Will fix in next patch.

>
> > +       char addr[18];
> > +
> > +       if (length < sizeof(*rp)) {
> > +               btd_error(adapter->dev_id,
> > +                         "Too small Set Wake Capable complete event");
> > +               return;
> > +        }
> > +
> > +       ba2str(&rp->addr.bdaddr, addr);
> > +
> > +       dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr,
> > +                                     rp->addr.type);
> > +       if (!dev) {
> > +               btd_error(adapter->dev_id,
> > +                         "Set Wake Capable complete for unknown device %s",
> > +                         addr);
> > +               return;
> > +       }
> > +
> > +       if (status != MGMT_STATUS_SUCCESS) {
> > +               btd_error(adapter->dev_id,
> > +                         "Failed to set wake capable %s(%u) = %d: %s (0x%02x)",
> > +                         addr, rp->addr.type, rp->wake_enable,
> > +                         mgmt_errstr(status), status);
> > +               return;
> > +       }
> > +
> > +       device_set_wake_capable(dev, rp->wake_enable);
> > +
> > +       DBG("Set wake capable complete %s (%u)", addr, rp->addr.type);
> > +}
> > +
> > +void adapter_set_wake_capable(struct btd_adapter* adapter,
> > +                             struct btd_device* dev,
> > +                             bool wake_enable)
> > +{
> > +       struct mgmt_cp_set_wake_capable cp;
> > +       char addr[18];
>
> Shouldn't there be a way to check if the kernel does actually support
> the command first? We shouldn't be attempting to use it with kernels
> that don't support it and the property should also not appear in that
> case, so it is only visible if:
>
> 1. Kernel reports that Wake Capable command is supported
> 2. A driver/plugin/profile calls device_set_wake_support
>
> Also in case those 2 conditions are attended bu the command fails we
> should reply with an error since there won't be any PropertiesChanged
> to indicate something went wrong.

That sounds reasonable. Are all supported management apis reported
somewhere? (I may discover the answer to this just by reading code)

Also, what's a good way to report an error on PropertiesChanged? Just
logging the error (i.e. error("Failed to set wake capable property"))
or actually calling something like g_dbus_emit_property_error (I don't
think this is real; just using an example)?

>
> > +       memset(&cp, 0, sizeof(cp));
> > +       bacpy(&cp.addr.bdaddr, device_get_address(dev));
> > +       cp.addr.type = btd_device_get_bdaddr_type(dev);
> > +       cp.wake_enable = device_get_profile_wake_support(dev) && wake_enable;
> > +
> > +       ba2strlc(&cp.addr.bdaddr, addr);
> > +
> > +       if (!mgmt_send(adapter->mgmt, MGMT_OP_SET_WAKE_CAPABLE, adapter->dev_id,
> > +                      sizeof(cp), &cp, set_wake_capable_complete, adapter,
> > +                      NULL)) {
> > +               btd_warn(adapter->dev_id,
> > +                        "Could not set wake capable = %u on %s (%u)",
> > +                        cp.wake_enable, addr, cp.addr.type);
> > +       }
> > +
> > +       DBG("Setting %s (%u) to wake capable = %u", addr,
> > +           cp.addr.type, cp.wake_enable);
> > +}
> > +
> >  static void remove_whitelist_complete(uint8_t status, uint16_t length,
> >                                         const void *param, void *user_data)
> >  {
> > diff --git a/src/adapter.h b/src/adapter.h
> > index d0a5253bd..e990279ed 100644
> > --- a/src/adapter.h
> > +++ b/src/adapter.h
> > @@ -221,6 +221,8 @@ void adapter_whitelist_add(struct btd_adapter *adapter,
> >                                                 struct btd_device *dev);
> >  void adapter_whitelist_remove(struct btd_adapter *adapter,
> >                                                 struct btd_device *dev);
> > +void adapter_set_wake_capable(struct btd_adapter* adapter,
> > +                             struct btd_device* dev, bool wake_enable);
> >
> >  void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
> >                                                 struct oob_handler *handler);
> > diff --git a/src/device.c b/src/device.c
> > index a4fe10980..7a455e1e9 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -189,6 +189,8 @@ struct btd_device {
> >         bool            le;
> >         bool            pending_paired;         /* "Paired" waiting for SDP */
> >         bool            svc_refreshed;
> > +       bool            profile_wake_support;   /* Profile supports wake */
>
> I guess we can drop the profile term here since that is implicit already.

Will change in next patch.

>
> > +       bool            wake_capable;           /* Can wake from suspend */
> >         GSList          *svc_callbacks;
> >         GSList          *eir_uuids;
> >         struct bt_ad    *ad;
> > @@ -415,6 +417,9 @@ static gboolean store_device_info_cb(gpointer user_data)
> >         g_key_file_set_boolean(key_file, "General", "Blocked",
> >                                                         device->blocked);
> >
> > +       g_key_file_set_boolean(key_file, "General", "WakeCapable",
> > +                                                       device->wake_capable);
> > +
> >         if (device->uuids) {
> >                 GSList *l;
> >                 int i;
> > @@ -1318,6 +1323,47 @@ dev_property_advertising_data_exist(const GDBusPropertyTable *property,
> >         return bt_ad_has_data(device->ad, NULL);
> >  }
> >
> > +static gboolean
> > +dev_property_get_wake_capable(const GDBusPropertyTable *property,
> > +                            DBusMessageIter *iter, void *data)
> > +{
> > +       struct btd_device *device = data;
> > +       dbus_bool_t wake_capable =
> > +                       device_get_wake_capable(device) ? TRUE : FALSE;
> > +
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &wake_capable);
> > +
> > +       return TRUE;
> > +}
> > +
> > +static void dev_property_set_wake_capable(const GDBusPropertyTable *property,
> > +                                        DBusMessageIter *value,
> > +                                        GDBusPendingPropertySet id, void *data)
> > +{
> > +       struct btd_device *device = data;
> > +       dbus_bool_t b;
> > +
> > +       if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
> > +               g_dbus_pending_property_error(id,
> > +                                       ERROR_INTERFACE ".InvalidArguments",
> > +                                       "Invalid arguments in method call");
> > +               return;
> > +       }
> > +
> > +       dbus_message_iter_get_basic(value, &b);
> > +
> > +       adapter_set_wake_capable(device->adapter, device, b == TRUE);
> > +       g_dbus_pending_property_success(id);
> > +}
> > +
> > +static gboolean dev_property_wake_capable_exist(
> > +               const GDBusPropertyTable *property, void *data)
> > +{
> > +       struct btd_device *device = data;
> > +
> > +       return device_get_profile_wake_support(device) ? TRUE : FALSE;
> > +}
> > +
> >  static gboolean disconnect_all(gpointer user_data)
> >  {
> >         struct btd_device *device = user_data;
> > @@ -1509,6 +1555,34 @@ void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
> >         bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
> >  }
> >
> > +bool device_get_profile_wake_support(struct btd_device *device)
> > +{
> > +       return device->profile_wake_support;
> > +}
> > +
> > +void device_set_profile_wake_support(struct btd_device *device,
> > +                                    bool wake_support)
> > +{
> > +       device->profile_wake_support = wake_support;
> > +       /* WakeCapable is only visible when wake_support is true */
> > +       g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
> > +                                    "WakeCapable");
> > +}
> > +
> > +bool device_get_wake_capable(struct btd_device *device)
> > +{
> > +       return device->wake_capable;
> > +}
> > +
> > +void device_set_wake_capable(struct btd_device *device, bool wake_capable)
> > +{
> > +       device->wake_capable = wake_capable;
> > +
> > +       store_device_info(device);
> > +       g_dbus_emit_property_changed(dbus_conn, device->path, DEVICE_INTERFACE,
> > +                                    "WakeCapable");
> > +}
> > +
> >  static void device_set_auto_connect(struct btd_device *device, gboolean enable)
> >  {
> >         char addr[18];
> > @@ -2779,6 +2853,9 @@ static const GDBusPropertyTable device_properties[] = {
> >         { "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
> >                                 NULL, dev_property_advertising_data_exist,
> >                                 G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
> > +       { "WakeCapable", "b", dev_property_get_wake_capable,
> > +                               dev_property_set_wake_capable,
> > +                               dev_property_wake_capable_exist },
> >         { }
> >  };
> >
> > @@ -3030,6 +3107,7 @@ static void load_info(struct btd_device *device, const char *local,
> >         char *str;
> >         gboolean store_needed = FALSE;
> >         gboolean blocked;
> > +       gboolean wake_capable;
> >         char **uuids;
> >         int source, vendor, product, version;
> >         char **techno, **t;
> > @@ -3141,6 +3219,11 @@ next:
> >                 btd_device_set_pnpid(device, source, vendor, product, version);
> >         }
> >
> > +       /* Mark wake capable */
> > +       wake_capable = g_key_file_get_boolean(key_file, "General",
> > +                                             "WakeCapable", NULL);
> > +       adapter_set_wake_capable(device->adapter, device, wake_capable == TRUE);
> > +
> >         if (store_needed)
> >                 store_device_info(device);
> >  }
> > diff --git a/src/device.h b/src/device.h
> > index 06b100499..43f633e38 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -139,6 +139,11 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
> >                                                                 uint16_t value);
> >  void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
> >                                                         uint16_t *ccc_bredr);
> > +bool device_get_profile_wake_support(struct btd_device *device);
> > +void device_set_profile_wake_support(struct btd_device *device,
> > +                                    bool wake_support);
> > +bool device_get_wake_capable(struct btd_device *device);
> > +void device_set_wake_capable(struct btd_device *device, bool wake_capable);
> >
> >  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
> >                                         void *user_data);
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
>
>
> --
> Luiz Augusto von Dentz

--
Thanks,
Abhishek

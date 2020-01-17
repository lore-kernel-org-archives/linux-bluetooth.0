Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8834C33CB6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 22:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8497620748
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 22:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owAbMYti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgAQWGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:06:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41903 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbgAQWGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 17:06:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so23856523otc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 14:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqQ2oBjE/IguWWVdMP9KpLXXCiJ76wFjx0AlpZCXcSY=;
        b=owAbMYtij/2EuPVipHxleNusg9U7U73UfnHTrUPg+0BZvkPKVTRkKgET4MIfVedF+g
         4A1C3YCQFmniV3eRJ8f5zlYrGsuwcOzY6muu7b972J9nQnaL9ptEnHvrvXinvNWxzc8p
         IcEHkHOiFwSK8VV0HOEYkYrPL5YCzaHYdWW/u/iXxONmDiGTxk2ONzuM1sQFinxePVzt
         OLFDSUKzxzC2i8XqRtFcWpCkREhhgg5M0rEednKZQ4kYJaAU9j2tQRrlb+MjNj2iVBVg
         HjdyipHvDIKV1qd9+XKYRJynhK6Mvilfo7+ox1iC3OjdR0DD7epDFbstwu08BaNlTNSx
         32dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqQ2oBjE/IguWWVdMP9KpLXXCiJ76wFjx0AlpZCXcSY=;
        b=MEHcGpfWkf95XnD47ubD2XmHOQe3H2fu9e6lpD0D0R/iezPtnPiHkscIjn8lrkYHmN
         dgMaZuMJUiMSzKc0NR3HiTQii7LZjLA9L483IHoJC6Eh+WHUEhTRkJHxQ98ybGXUCBJC
         4i9POekdeMhqxqPd+SJW+OY9vm828y8wiasHU1AA7k3rSR72yYrxvXr1T71mMOGZiR1V
         TYiWSY8pnWfzzjqIDH8b6Ty61wVeCaGD0sHTrkeCqJE7kkddvGf1txEAYijjWGT4QR5a
         rUQshAqArQro5IeCFt0zLNAPZsMvSMEj5YAnqqLsVZSo1vsw1p4wJKNpRUIM0595EH6u
         RYKA==
X-Gm-Message-State: APjAAAV/R/flnCGojD65bP2j2dvwfejGrMfNvlLL9aLQW9Pp3BBVEHwt
        r/pq0AlALYPFw98nw+sJRaTYFMh+eXS4FM/mX8r+nh69
X-Google-Smtp-Source: APXvYqzW9dBTrN9F1qU5E4zRrUp1R+K5JushFkzZPYrQI4w2RgEDWIKckE51sIcZf0nYsOIfFPd2u00Co+NnCwta2lw=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr7379022otp.177.1579298775706;
 Fri, 17 Jan 2020 14:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
In-Reply-To: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jan 2020 14:06:03 -0800
Message-ID: <CABBYNZK-LJRpH+NFGySdRQQjxBvsqWVBiV3wWguDnx61g_s8HQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH 1/2] adapter: Add set wake capable operation
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

On Fri, Jan 17, 2020 at 1:28 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> If a device is capable of waking the host system from suspend, it should
> be marked as wake capable. We introduce a new management operation here
> to set this property and implement the API needed to call it.
>
> ---
>
>  doc/mgmt-api.txt | 19 +++++++++++++++
>  lib/mgmt.h       |  8 +++++++
>  src/adapter.c    | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.h    |  2 ++
>  src/device.c     | 15 ++++++++++++
>  src/device.h     |  2 ++
>  6 files changed, 108 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 1e59acc54..8a73a9bb9 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3047,6 +3047,25 @@ Load Blocked Keys Command
>         Possible errors:        Invalid Parameters
>                                 Invalid Index
>
> +Set Wake Capable Command
> +===========================
> +
> +       Command Code:           0x0047
> +       Controller Index:       <controller id>
> +       Command Parameters:     Address (6 Octets)
> +                               Address_Type (1 Octet)
> +                               Wake Capable (1 Octet)
> +       Return Parameters:      Address (6 Octets)
> +                               Address_Type (1 Octet)
> +                               Wake Capable (1 Octet)
> +
> +       This command sets whether a bluetooth device is capable of waking the
> +       system from suspend. This property is used to set the event filter and
> +       LE whitelist when the system enters suspend.
> +
> +       Possible errors:        Failed
> +                               Invalid Parameters
> +                               Invalid Index

Please always have the documentation changes as a separated patch so
we can discuss these changes in a separate thread. Btw, Im missing the
D-Bus API changes in order for the application to control this
setting, we could probably consider doing this with auto-connect logic
but I assume this would need user input in order to use devices to
wake their systems, right? Anyway even if we were to do as a separate
setting if the device address is not programmed in the controller
whitelist I fail to see how it would be able to wake the system, so we
need the logic to work together with auto-connect.

For such features it probably make sense to have a cover letter for
the patch-set explaining the feature so we don't try guessing how it
could be used, also this sort of feature may have both security and
power impact, for instance if we don't have a controller capable of
resolving private addresses this may wake up the system for no reason,
in that case I would guess it is better to disable this feature for
devices that do use private addresses, also we may still have some
limitations either way because controllers have limited number of
slots in both the white list and resolving list.

Also, keep in mind the kernel has no persistent storage so we also
will need to store these settings in the storage so may make sense to
allow the command to set a list rather than just going one by one when
i.e. restarting the daemon, doing this via application is probably not
recommended as it may not be active when the daemon is starting.

>  Command Complete Event
>  ======================
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 276445d0a..da2cce8c5 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -597,6 +597,12 @@ struct mgmt_blocked_key_info {
>  struct mgmt_cp_set_blocked_keys {
>         uint16_t key_count;
>         struct mgmt_blocked_key_info keys[0];
> +
> +#define MGMT_OP_SET_WAKE_CAPABLE                       0x0047
> +#define MGMT_SET_WAKE_CAPABLE_SIZE                     8
> +struct mgmt_cp_set_wake_capable {
> +       struct mgmt_addr_info addr;
> +       uint8_t wake_capable;
>  } __packed;
>
>  #define MGMT_EV_CMD_COMPLETE           0x0001
> @@ -893,6 +899,8 @@ static const char *mgmt_op[] = {
>         "Set Appearance",
>         "Get PHY Configuration",
>         "Set PHY Configuration",
> +       "Set Blocked Keys",
> +       "Set Wake Capable",
>  };
>
>  static const char *mgmt_ev[] = {
> diff --git a/src/adapter.c b/src/adapter.c
> index 329c3ae0b..a35cf1349 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4685,6 +4685,68 @@ void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
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
> +                         addr, rp->addr.type, rp->wake_capable,
> +                         mgmt_errstr(status), status);
> +               return;
> +       }
> +
> +       DBG("Set wake capable complete %s (%u)", addr, rp->addr.type);
> +}
> +
> +void adapter_set_wake_capable(struct btd_adapter* adapter,
> +                             struct btd_device* dev)
> +{
> +       struct mgmt_cp_set_wake_capable cp;
> +       char addr[18];
> +
> +       memset(&cp, 0, sizeof(cp));
> +       bacpy(&cp.addr.bdaddr, device_get_address(dev));
> +       cp.addr.type = btd_device_get_bdaddr_type(dev);
> +       cp.wake_capable = device_get_wake_capable(dev);
> +
> +       ba2strlc(&cp.addr.bdaddr, addr);
> +
> +       if (!mgmt_send(adapter->mgmt, MGMT_OP_SET_WAKE_CAPABLE, adapter->dev_id,
> +                      sizeof(cp), &cp, set_wake_capable_complete, adapter,
> +                      NULL)) {
> +               btd_warn(adapter->dev_id,
> +                        "Could not set wake capable = %u on %s (%u)",
> +                        cp.wake_capable, addr, cp.addr.type);
> +       }
> +
> +       DBG("Setting %s (%u) to wake capable = %u", addr,
> +           cp.addr.type, cp.wake_capable);
> +}
> +
>  static void remove_whitelist_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> diff --git a/src/adapter.h b/src/adapter.h
> index d0a5253bd..bb63db574 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -221,6 +221,8 @@ void adapter_whitelist_add(struct btd_adapter *adapter,
>                                                 struct btd_device *dev);
>  void adapter_whitelist_remove(struct btd_adapter *adapter,
>                                                 struct btd_device *dev);
> +void adapter_set_wake_capable(struct btd_adapter* adapter,
> +                             struct btd_device* dev);
>
>  void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
>                                                 struct oob_handler *handler);
> diff --git a/src/device.c b/src/device.c
> index a4fe10980..221f23b09 100644
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
> @@ -1509,6 +1510,20 @@ void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
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
> +       if (device->wake_capable == wake_capable)
> +               return;
> +
> +       device->wake_capable = wake_capable;
> +       adapter_set_wake_capable(device->adapter, device);
> +}
> +
>  static void device_set_auto_connect(struct btd_device *device, gboolean enable)
>  {
>         char addr[18];
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

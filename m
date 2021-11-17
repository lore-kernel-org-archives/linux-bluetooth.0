Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A582FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE8561BC1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 21:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbhKQVp6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 16:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhKQVp6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 16:45:58 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460EEC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 13:42:59 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id a129so2541500vkb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fpnMHgP0OWWnK21bg7YGqnhJqvldn1vQD+JY0t37Lxw=;
        b=cwvql51TK8Wk+hMhq65lQsjrY7nAUxvrgB4C+yjTM6Gg2waih+fOJuLdjLXIqZ0/Bt
         n6aED50mS0jJxJeYnOxJf0GGvUEVBuQ/mdF+0KYtGgYgQw7VR2gOkSuUFd8A2CucVJuz
         6/b2qW4GEuYswbDIcZjHcVR3BIdnW9jurclNG2BDRkJJhCfE9D02guiNxI2MreEoEDd3
         FsOpoOwwEBJBm3+5BPteFj6VsWW6Qhh5EItz8AghPrxrhnCgBjdMy12T+jChESzUPysI
         iY4jlB5/X6LvMYZWGthOjIHsSYBbXPT0z5FuziYE5bAK4R+jJZ9EHt4QwVwr7P6xfrgJ
         lVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fpnMHgP0OWWnK21bg7YGqnhJqvldn1vQD+JY0t37Lxw=;
        b=EtowcRJVd9iVrF9MZlVAxZSGmaHAXq4PtQaPByLwIWbLNNf61D2NFTxksPVfJIzOpB
         jn08BWlN2P/acrxzXPDVynSE8SqCtnbJT7LD8ODDwQMHaVhLQT7qZ6h/4xg2tyJ+wOtH
         L0PhzJs+OruKIsjKZWyDyRsyGy2F1IJ+t1jRkvqR5Xal04Gexsgm9LYDJybWi9rThS4+
         LFPQtYN/KmYo1RAtx8O62kNMq9bTY32u79nNh0LAbPv2dMIfYeKMI95Ra2H1xy1wYX/B
         o7/M8S4EjfOLUCvsxtJQV2dZKim3hECZNXx1mFc+2T7Lsc8VE+smG0mKXTqqpY6kJ4ID
         3UDQ==
X-Gm-Message-State: AOAM5316zaSbJEq2EWA4wNzyIF+5EKenkAugohyaN+eDFAi9N07IVjer
        4xEDlNXpFq/IbuudF+WObb2MUDsgyasQSCK7+vY=
X-Google-Smtp-Source: ABdhPJwqZprbfhO56SV4/TzmVRor4LE8xgn/0Jzlxg1vwGf3w246fh4XmDcEyQCCSlJrX7VG69HNhVES/gRQjuRe/c4=
X-Received: by 2002:a05:6122:2005:: with SMTP id l5mr94668377vkd.4.1637185378180;
 Wed, 17 Nov 2021 13:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <20211117110627.BlueZ.v5.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
In-Reply-To: <20211117110627.BlueZ.v5.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Nov 2021 13:42:47 -0800
Message-ID: <CABBYNZJR+0u53GuBPe-C3KSALxFo5Dn0FLRvCObYCq8Q8QLj7Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 3/6] adv_monitor: Receive the Device Found/Lost events
To:     Manish Mandlik <mmandlik@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Wed, Nov 17, 2021 at 11:15 AM Manish Mandlik <mmandlik@google.com> wrote=
:
>
> This patch registers callback functions to receive the Advertisement
> Monitor Device Found and Device Lost events. It also disables software
> based filtering whenever controller offloading support is available.
>
> Test performed:
> - Verified by logs that the MSFT Monitor Device is received from the
>   controller and the bluetoothd is notified whenever the controller
>   starts/stops monitoring a device.
>
> Reviewed-by: Miao-chen Chou <mcchou@google.com>
> ---
>
> Changes in v5:
> - Update the Adv Monitor Device Found event to include fields from the
>   existing Device Found event and update the device object.
> - Disable the software based filtering whenever controller offloading is
>   available.
>
> Changes in v4:
> - Add Advertisement Monitor Device Found event.
>
> Changes in v3:
> - Fix indentation of the adv_monitor_device_lost_callback() name and
>   it's arguments.
>
> Changes in v2:
> - Update function name adv_monitor_tracking_callback() to
>   adv_monitor_device_lost_callback() as it will receive only Device Lost
>   event.
>
>  src/adapter.c     | 47 +++++++++++++-----------
>  src/adapter.h     |  8 +++++
>  src/adv_monitor.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/adv_monitor.h |  2 ++
>  4 files changed, 128 insertions(+), 20 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index d0d38621b..42463a3c1 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -6984,12 +6984,13 @@ static bool device_is_discoverable(struct btd_ada=
pter *adapter,
>         return discoverable;
>  }
>
> -static void update_found_devices(struct btd_adapter *adapter,
> +void btd_adapter_update_found_device(struct btd_adapter *adapter,
>                                         const bdaddr_t *bdaddr,
>                                         uint8_t bdaddr_type, int8_t rssi,
>                                         bool confirm, bool legacy,
>                                         bool not_connectable,
> -                                       const uint8_t *data, uint8_t data=
_len)
> +                                       const uint8_t *data, uint8_t data=
_len,
> +                                       bool monitoring)
>  {
>         struct btd_device *dev;
>         struct bt_ad *ad =3D NULL;
> @@ -6999,20 +7000,24 @@ static void update_found_devices(struct btd_adapt=
er *adapter,
>         bool duplicate =3D false;
>         struct queue *matched_monitors =3D NULL;
>
> -       if (bdaddr_type !=3D BDADDR_BREDR)
> -               ad =3D bt_ad_new_with_data(data_len, data);
> +       if (!btd_adv_monitor_offload_supported(adapter->adv_monitor_manag=
er)) {
> +               if (bdaddr_type !=3D BDADDR_BREDR)
> +                       ad =3D bt_ad_new_with_data(data_len, data);
>
> -       /* During the background scanning, update the device only when th=
e data
> -        * match at least one Adv monitor
> -        */
> -       if (ad) {
> -               matched_monitors =3D btd_adv_monitor_content_filter(
> -                                       adapter->adv_monitor_manager, ad)=
;
> -               bt_ad_unref(ad);
> -               ad =3D NULL;
> +               /* During the background scanning, update the device only=
 when
> +                * the data match at least one Adv monitor
> +                */
> +               if (ad) {
> +                       matched_monitors =3D btd_adv_monitor_content_filt=
er(
> +                                               adapter->adv_monitor_mana=
ger,
> +                                               ad);
> +                       bt_ad_unref(ad);
> +                       ad =3D NULL;
> +                       monitoring =3D matched_monitors ? true : false;
> +               }
>         }
>
> -       if (!adapter->discovering && !matched_monitors)
> +       if (!adapter->discovering && !monitoring)
>                 return;
>
>         memset(&eir_data, 0, sizeof(eir_data));
> @@ -7025,7 +7030,7 @@ static void update_found_devices(struct btd_adapter=
 *adapter,
>
>         dev =3D btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
>         if (!dev) {
> -               if (!discoverable && !matched_monitors) {
> +               if (!discoverable && !monitoring) {
>                         eir_data_free(&eir_data);
>                         return;
>                 }
> @@ -7064,7 +7069,7 @@ static void update_found_devices(struct btd_adapter=
 *adapter,
>          */
>         if (!btd_device_is_connected(dev) &&
>                 (device_is_temporary(dev) && !adapter->discovery_list) &&
> -               !matched_monitors) {
> +               !monitoring) {
>                 eir_data_free(&eir_data);
>                 return;
>         }
> @@ -7072,7 +7077,7 @@ static void update_found_devices(struct btd_adapter=
 *adapter,
>         /* If there is no matched Adv monitors, don't continue if not
>          * discoverable or if active discovery filter don't match.
>          */
> -       if (!matched_monitors && (!discoverable ||
> +       if (!monitoring && (!discoverable ||
>                 (adapter->filtered_discovery && !is_filter_match(
>                                 adapter->discovery_list, &eir_data, rssi)=
))) {
>                 eir_data_free(&eir_data);
> @@ -7202,6 +7207,7 @@ static void device_found_callback(uint16_t index, u=
int16_t length,
>         bool confirm_name;
>         bool legacy;
>         char addr[18];
> +       bool not_connectable;
>
>         if (length < sizeof(*ev)) {
>                 btd_error(adapter->dev_id,
> @@ -7230,11 +7236,12 @@ static void device_found_callback(uint16_t index,=
 uint16_t length,
>
>         confirm_name =3D (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
>         legacy =3D (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
> +       not_connectable =3D (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
>
> -       update_found_devices(adapter, &ev->addr.bdaddr, ev->addr.type,
> -                                       ev->rssi, confirm_name, legacy,
> -                                       flags & MGMT_DEV_FOUND_NOT_CONNEC=
TABLE,
> -                                       eir, eir_len);
> +       btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
> +                                       ev->addr.type, ev->rssi, confirm_=
name,
> +                                       legacy, not_connectable, eir, eir=
_len,
> +                                       false);
>  }
>
>  struct agent *adapter_get_agent(struct btd_adapter *adapter)
> diff --git a/src/adapter.h b/src/adapter.h
> index db3c17f23..cd0d037af 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -87,6 +87,14 @@ struct btd_device *btd_adapter_find_device(struct btd_=
adapter *adapter,
>  struct btd_device *btd_adapter_find_device_by_path(struct btd_adapter *a=
dapter,
>                                                    const char *path);
>
> +void btd_adapter_update_found_device(struct btd_adapter *adapter,
> +                                       const bdaddr_t *bdaddr,
> +                                       uint8_t bdaddr_type, int8_t rssi,
> +                                       bool confirm, bool legacy,
> +                                       bool not_connectable,
> +                                       const uint8_t *data, uint8_t data=
_len,
> +                                       bool monitored);
> +
>  const char *adapter_get_path(struct btd_adapter *adapter);
>  const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
>  uint8_t btd_adapter_get_address_type(struct btd_adapter *adapter);
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index a3b33188b..e5bdfb6ef 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -1531,6 +1531,78 @@ static void adv_monitor_removed_callback(uint16_t =
index, uint16_t length,
>                 ev->monitor_handle);
>  }
>
> +/* Processes Adv Monitor Device Found event from kernel */
> +static void adv_monitor_device_found_callback(uint16_t index, uint16_t l=
ength,
> +                                               const void *param,
> +                                               void *user_data)
> +{
> +       const struct mgmt_ev_adv_monitor_device_found *ev =3D param;
> +       struct btd_adv_monitor_manager *manager =3D user_data;
> +       uint16_t handle =3D le16_to_cpu(ev->monitor_handle);

Make sure each patch don't break the build:

src/adv_monitor.c: In function =E2=80=98adv_monitor_device_found_callback=
=E2=80=99:
src/adv_monitor.c:1541:18: error: unused variable =E2=80=98handle=E2=80=99
[-Werror=3Dunused-variable]
 1541 |         uint16_t handle =3D le16_to_cpu(ev->monitor_handle);
      |

> +       const uint16_t adapter_id =3D manager->adapter_id;
> +       struct btd_adapter *adapter =3D manager->adapter;
> +       const uint8_t *ad_data =3D NULL;
> +       uint16_t ad_data_len;
> +       uint32_t flags;
> +       bool confirm_name;
> +       bool legacy;
> +       char addr[18];
> +       bool not_connectable;
> +
> +       if (length < sizeof(*ev)) {
> +               btd_error(adapter_id,
> +                               "Too short Adv Monitor Device Found event=
");
> +               return;
> +       }
> +
> +       ad_data_len =3D btohs(ev->ad_data_len);
> +       if (length !=3D sizeof(*ev) + ad_data_len) {
> +               btd_error(adapter_id,
> +                               "Wrong size of Adv Monitor Device Found e=
vent");
> +               return;
> +       }
> +
> +       if (ad_data_len > 0)
> +               ad_data =3D ev->ad_data;
> +
> +       flags =3D btohl(ev->flags);
> +
> +       ba2str(&ev->addr.bdaddr, addr);
> +       DBG("hci%u addr %s, rssi %d flags 0x%04x ad_data_len %u",
> +                       index, addr, ev->rssi, flags, ad_data_len);
> +
> +       confirm_name =3D (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
> +       legacy =3D (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
> +       not_connectable =3D (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
> +
> +       btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
> +                                       ev->addr.type, ev->rssi, confirm_=
name,
> +                                       legacy, not_connectable, ad_data,
> +                                       ad_data_len, true);
> +}
> +
> +/* Processes Adv Monitor Device Lost event from kernel */
> +static void adv_monitor_device_lost_callback(uint16_t index, uint16_t le=
ngth,
> +                                               const void *param,
> +                                               void *user_data)
> +{
> +       struct btd_adv_monitor_manager *manager =3D user_data;
> +       const struct mgmt_ev_adv_monitor_device_lost *ev =3D param;
> +       uint16_t handle =3D le16_to_cpu(ev->monitor_handle);
> +       const uint16_t adapter_id =3D manager->adapter_id;
> +       char addr[18];
> +
> +       if (length < sizeof(*ev)) {
> +               btd_error(adapter_id,
> +                               "Wrong size of Adv Monitor Device Lost ev=
ent");
> +               return;
> +       }
> +
> +       ba2str(&ev->addr.bdaddr, addr);
> +       DBG("Adv Monitor with handle 0x%04x stopped tracking the device %=
s",
> +               handle, addr);
> +}
> +
>  /* Allocates a manager object */
>  static struct btd_adv_monitor_manager *manager_new(
>                                                 struct btd_adapter *adapt=
er,
> @@ -1555,6 +1627,14 @@ static struct btd_adv_monitor_manager *manager_new=
(
>                         manager->adapter_id, adv_monitor_removed_callback=
,
>                         manager, NULL);
>
> +       mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
> +                       manager->adapter_id, adv_monitor_device_found_cal=
lback,
> +                       manager, NULL);
> +
> +       mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_DEVICE_LOST,
> +                       manager->adapter_id, adv_monitor_device_lost_call=
back,
> +                       manager, NULL);
> +
>         return manager;
>  }
>
> @@ -1666,6 +1746,17 @@ void btd_adv_monitor_manager_destroy(struct btd_ad=
v_monitor_manager *manager)
>         manager_destroy(manager);
>  }
>
> +bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *m=
anager)
> +{
> +       if (!manager) {
> +               error("Manager is NULL, get offload support failed");
> +               return false;
> +       }
> +
> +       return !!(manager->enabled_features &
> +                               MGMT_ADV_MONITOR_FEATURE_MASK_OR_PATTERNS=
);
> +}
> +
>  /* Processes the content matching based pattern(s) of a monitor */
>  static void adv_match_per_monitor(void *data, void *user_data)
>  {
> diff --git a/src/adv_monitor.h b/src/adv_monitor.h
> index d9cb9ccbb..bed6572d0 100644
> --- a/src/adv_monitor.h
> +++ b/src/adv_monitor.h
> @@ -27,6 +27,8 @@ struct btd_adv_monitor_manager *btd_adv_monitor_manager=
_create(
>                                                 struct mgmt *mgmt);
>  void btd_adv_monitor_manager_destroy(struct btd_adv_monitor_manager *man=
ager);
>
> +bool btd_adv_monitor_offload_supported(struct btd_adv_monitor_manager *m=
anager);
> +
>  struct queue *btd_adv_monitor_content_filter(
>                                 struct btd_adv_monitor_manager *manager,
>                                 struct bt_ad *ad);
> --
> 2.34.0.rc1.387.gb447b232ab-goog
>


--=20
Luiz Augusto von Dentz

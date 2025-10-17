Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC7330B26
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Oct 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716406; cv=none; b=sSckkZib8O/HXmPnBl5paPuAFs0/TDVrbD8UjjKWSTa2TQhCTMIdGI7WD0tdF041yVxMkE6knAXgL2D4HXSWYQfUl2NFPl+EVUyugqV2Lga+LFIOjpr682TkzYyslFdT6HO9JMhSGXoEfsfFWwm/OI5GCBWTNEja/nmvISLhAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716406; c=relaxed/simple;
	bh=RASeDaZMQt77mN+UHk5K8MSnSRq4FnFQkGryOWt2iAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRw9xpUQqar8ihdllHtQlgPhADZkill/DdVFFuB8Emo0nzc3D+H/xl0Eit0wT8R8vdZZMZvaE+NRvnqPZkBR2S+wgGGR56MaFQMfdvCP3jLvtuzdPJKXU/aCYLPc+jEK9iSIWoVwATrlGPKqVzn++Rg6LIWYy60g5mJy0MJVBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebRD5L9G; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebRD5L9G"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-371e4858f74so24431411fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Oct 2025 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760716403; x=1761321203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRVgq7nT20/CuVDaF/C9hxbeyFdQtUV8C8G1xqbD4qE=;
        b=ebRD5L9GBb1jFKaeuLez5amz1eSPG//pBwB3yoH48qRTbgMIGkwQ4olwVgpijL6znC
         c3hXvW42aRCMWJWyPx5weKPXR/U9UnWMqiWITjQPrNIJmULNzLxFzc3jQAAiFRhAha+0
         uq1+3sJBgicw/1zJf43NekLgQjLarChg4DiBEXPCBf3HUk1bZmsMoTZeGWxiykK8AeHo
         L7l06pWqu9mvsMYQZxs5gTYhezYX4pFKPPFRK6n7kmji94J7QvptLMjYe37DE6Uhd9Qw
         aOOuO0dNBvQ6Kjfpb9nGP/ZvMn+7IO11wR0XT3XpErl92EnHH+cZLKVFTEQA8/bGyvjf
         vAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716403; x=1761321203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRVgq7nT20/CuVDaF/C9hxbeyFdQtUV8C8G1xqbD4qE=;
        b=ETHijF+QYPeE54CglveCU5ofQwfyY8z68hhG5zuC5k4Z8fMQmpZZk13qeEHAL0hw+W
         lcCyNsO8Qbx3i4UEKnUt08F4TGpt43kgKqy4hxhBzhjmEzq2BE6xGi/Kljd87aKEafhB
         XjcQHawjYXqOBKWKlSIlRsspj2JB/s8wIInrFkmAwfdYq7xjzpPiqFz/2/LIsj+I3age
         uo+sKq7A30xh6nyeZi74+dVM5H8F08fzI8KsCq8gUxKHJFQbc27k5ag2J96L9/0hgbe5
         M6BgOTB1Ujsg5WsechFSyW6rW1gk6hfQVJaep98GWEdrDl5HE3SlUM3GQqrRr/Gb49BM
         R2ig==
X-Gm-Message-State: AOJu0Yw3WUegWVMPZLUgB8H/8SOWE8V7XRVysBfQjqQVLUGuKJutVjq3
	Woax6FBkBUCEeVsEi6LP2stIPE69bV7gvo5XQxKULtTh0u12YsJLrOZlRMwPZLBigBeA9atsta1
	Kf6E9yTy9MXoWoo9CissqLotHKZmVerU=
X-Gm-Gg: ASbGnctN0r5J3xsjskzCM2j5HPBWc2SLRmfOG8KDaZptBYWK/Fv4hc/7ZCOpNK3ubmA
	7RxqAr8oQJ1ct5DiLOhVP3dJ2y7p31QdQs7GZN9FzfQfaPatzlY95bNljtPYYy8eLqEzRLXGzmT
	Gzw+H1iqF2QfxSh47V5EVRb+ntMF8WoVosYQCkgJ+Y3hlVJWYbwiIioTdVCrlpZWXsF8/tvcoQJ
	QBJlgK3mupp0EDAHTZ53xwyV8X4V+RY+txWKRhNqQ3Z4FoANlVOtE/6IJs=
X-Google-Smtp-Source: AGHT+IGg8PLOiODKOiDXYJvtVC4ODqRXf30E1tQGPdYJd2rx0HHtngIZ6hfjXhCjbAZ8WxTloy4imU31ydYBdVWWcUA=
X-Received: by 2002:a2e:b8c5:0:b0:36b:8874:cdae with SMTP id
 38308e7fff4ca-377978ab85fmr14823981fa.15.1760716402389; Fri, 17 Oct 2025
 08:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010135521.4854-1-adrian-constantin.dudau@nxp.com> <20251010135521.4854-2-adrian-constantin.dudau@nxp.com>
In-Reply-To: <20251010135521.4854-2-adrian-constantin.dudau@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Oct 2025 11:53:09 -0400
X-Gm-Features: AS18NWAa5HuNxUkq-lWSB8Y06yJqEHLkne9aluF3sSXiV-Ijb1fOPU6fYxRPqp0
Message-ID: <CABBYNZLJ8uBONV99R2hV=G2FhFT9k2Z5f-qb7ZhOHbEhyzMGZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tools: Add raw advertising data support to BlueZ
To: Adrian Dudau <adrian-constantin.dudau@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Fri, Oct 10, 2025 at 9:55=E2=80=AFAM Adrian Dudau
<adrian-constantin.dudau@nxp.com> wrote:
>
> This patch introduces support for storing and exposing raw advertising
> data from Bluetooth Low Energy devices through D-Bus properties and
> internal APIs.
>
> Key changes:
> - Add raw_data fields to eir_data and bt_ad structures
> - Implement bt_ad_set_raw_data(), bt_ad_clear_raw_data(),
>   bt_ad_has_raw_data(), and bt_ad_get_raw_data() APIs
> - Expose RawAdvertisingData D-Bus property on device objects
> - Store raw advertising data during EIR parsing
> - Update BTP client to include raw advertising data in device found event=
s

Please split these changes, bt_ad, documentation, implementation and
then usage on btpclient shall each be a separate commit.

>
> The RawAdvertisingData property is marked with G_DBUS_PROPERTY_FLAG_TESTI=
NG
> for debugging and protocol testing purposes. This enables applications to
> access complete raw advertising packet contents for custom parsing,
> compliance testing, and troubleshooting scenarios.
>
> The raw data format follows the Extended Inquiry Response Data Format
> as described in BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.
>
> Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>
> ---
>  src/adapter.c     |  5 +++++
>  src/device.c      | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/device.h      |  2 ++
>  src/eir.c         |  7 ++++++
>  src/eir.h         |  3 +++
>  src/shared/ad.c   | 50 +++++++++++++++++++++++++++++++++++++++++
>  src/shared/ad.h   |  8 +++++++
>  tools/btpclient.c | 56 ++++++++++++++++++++++++++++++++++++++++++----
>  8 files changed, 184 insertions(+), 4 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 1ee2f3a08164..66d48c90fe8a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7471,6 +7471,11 @@ void btd_adapter_device_found(struct btd_adapter *=
adapter,
>         if (eir_data.data_list)
>                 device_set_data(dev, eir_data.data_list, duplicate);
>
> +       if (eir_data.raw_data_len > 0)
> +               device_set_raw_adv_data(dev, eir_data.raw_data,
> +                                       eir_data.raw_data_len,
> +                                       duplicate);
> +
>         if (bdaddr_type !=3D BDADDR_BREDR)
>                 device_set_flags(dev, eir_data.flags);
>
> diff --git a/src/device.c b/src/device.c
> index 8d74ae0ea0ff..a244ab1cb796 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1615,6 +1615,47 @@ dev_property_advertising_data_exist(const GDBusPro=
pertyTable *property,
>         return bt_ad_has_data(device->ad, NULL);
>  }
>
> +static gboolean
> +dev_property_get_raw_advertising_data(const GDBusPropertyTable *property=
,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct btd_device *device =3D data;
> +       uint8_t *raw_data =3D NULL;
> +       size_t raw_data_len =3D 0;
> +       DBusMessageIter array;
> +
> +       if (!device)
> +               return FALSE;
> +
> +       bt_ad_get_raw_data(device->ad, &raw_data, &raw_data_len);
> +
> +       if (!raw_data || raw_data_len =3D=3D 0)
> +               return FALSE;
> +
> +       dbus_message_iter_open_container(iter,
> +                                       DBUS_TYPE_ARRAY,
> +                                       DBUS_TYPE_BYTE_AS_STRING,
> +                                       &array);
> +
> +       dbus_message_iter_append_fixed_array(&array,
> +                                       DBUS_TYPE_BYTE,
> +                                       &raw_data,
> +                                       raw_data_len);
> +
> +       dbus_message_iter_close_container(iter, &array);
> +
> +       return TRUE;
> +}
> +
> +static gboolean
> +dev_property_raw_advertising_data_exist(const GDBusPropertyTable *proper=
ty,
> +                                       void *data)
> +{
> +       struct btd_device *device =3D data;
> +
> +       return bt_ad_has_raw_data(device->ad);
> +}
> +
>  static bool device_get_wake_support(struct btd_device *device)
>  {
>         return device->wake_support;
> @@ -2401,6 +2442,19 @@ void device_set_manufacturer_data(struct btd_devic=
e *dev, GSList *list,
>         g_slist_foreach(list, add_manufacturer_data, dev);
>  }
>
> +void device_set_raw_adv_data(struct btd_device *dev,
> +                       const uint8_t *data, size_t len,
> +                       bool duplicate)
> +{
> +       if (!dev)
> +               return;
> +
> +       if (duplicate)
> +               bt_ad_clear_raw_data(dev->ad);
> +
> +       bt_ad_set_raw_data(dev->ad, data, len);
> +}
> +
>  static void add_service_data(void *data, void *user_data)
>  {
>         struct eir_sd *sd =3D data;
> @@ -3619,6 +3673,9 @@ static const GDBusPropertyTable device_properties[]=
 =3D {
>                                         dev_property_flags_exist },
>         { "AdvertisingData", "a{yv}", dev_property_get_advertising_data,
>                                 NULL, dev_property_advertising_data_exist=
 },
> +       { "RawAdvertisingData", "ay", dev_property_get_raw_advertising_da=
ta,
> +                               NULL, dev_property_raw_advertising_data_e=
xist,
> +                               G_DBUS_PROPERTY_FLAG_TESTING },
>         { "WakeAllowed", "b", dev_property_get_wake_allowed,
>                                 dev_property_set_wake_allowed,
>                                 dev_property_wake_allowed_exist },
> diff --git a/src/device.h b/src/device.h
> index 9ff9cdfefc28..84dfa9faaa82 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -81,6 +81,8 @@ void btd_device_add_uuid(struct btd_device *device, con=
st char *uuid);
>  void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
>  void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
>                                                         bool duplicate);
> +void device_set_raw_adv_data(struct btd_device *device, const uint8_t *d=
ata,
> +                               size_t len, bool duplicate);
>  void device_set_service_data(struct btd_device *dev, GSList *list,
>                                                         bool duplicate);
>  void device_set_data(struct btd_device *dev, GSList *list,
> diff --git a/src/eir.c b/src/eir.c
> index 68ed74fe6493..497e11bd3125 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -243,6 +243,13 @@ void eir_parse(struct eir_data *eir, const uint8_t *=
eir_data, uint8_t eir_len)
>         if (eir_data =3D=3D NULL)
>                 return;
>
> +       if (eir_len > 0 && eir_len <=3D EIR_MAX_LEN) {
> +               memcpy(eir->raw_data, eir_data, eir_len);
> +               eir->raw_data_len =3D eir_len;
> +       } else {
> +               eir->raw_data_len =3D 0;
> +       }
> +
>         while (len < eir_len - 1) {
>                 uint8_t field_len =3D eir_data[0];
>                 const uint8_t *data;
> diff --git a/src/eir.h b/src/eir.h
> index b9f7c3874eb3..bb7b74527d97 100644
> --- a/src/eir.h
> +++ b/src/eir.h
> @@ -53,6 +53,7 @@
>
>  #define EIR_SD_MAX_LEN              238  /* 240 (EIR) - 2 (len) */
>  #define EIR_MSD_MAX_LEN             236  /* 240 (EIR) - 2 (len & type) -=
 2 */
> +#define EIR_MAX_LEN                 240
>
>  struct eir_msd {
>         uint16_t company;
> @@ -91,6 +92,8 @@ struct eir_data {
>         GSList *msd_list;
>         GSList *sd_list;
>         GSList *data_list;
> +       uint8_t raw_data[EIR_MAX_LEN];
> +       size_t raw_data_len;
>  };
>
>  void eir_data_free(struct eir_data *eir);
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index 9e21cbf61a29..443ba002fc56 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -35,6 +35,8 @@ struct bt_ad {
>         struct queue *solicit_uuids;
>         struct queue *service_data;
>         struct queue *data;
> +       uint8_t *raw_data;
> +       size_t raw_data_len;
>  };
>
>  struct pattern_match_info {
> @@ -55,6 +57,8 @@ struct bt_ad *bt_ad_new(void)
>         ad->service_data =3D queue_new();
>         ad->data =3D queue_new();
>         ad->appearance =3D UINT16_MAX;
> +       ad->raw_data =3D NULL;
> +       ad->raw_data_len =3D 0;
>
>         return bt_ad_ref(ad);
>  }
> @@ -199,6 +203,8 @@ void bt_ad_unref(struct bt_ad *ad)
>
>         free(ad->name);
>
> +       free(ad->raw_data);
> +
>         free(ad);
>  }
>
> @@ -1252,6 +1258,50 @@ bool bt_ad_has_data(struct bt_ad *ad, const struct=
 bt_ad_data *data)
>         return queue_find(ad->data, data_match, data);
>  }
>
> +void bt_ad_set_raw_data(struct bt_ad *ad, const uint8_t *data, size_t le=
n)
> +{
> +       if (!ad)
> +               return;
> +
> +       bt_ad_clear_raw_data(ad);
> +
> +       ad->raw_data =3D malloc(len);
> +       if (!ad->raw_data)
> +               return;
> +
> +       memcpy(ad->raw_data, data, len);
> +       ad->raw_data_len =3D len;
> +}
> +
> +void bt_ad_clear_raw_data(struct bt_ad *ad)
> +{
> +       if (!ad)
> +               return;
> +
> +       free(ad->raw_data);
> +       ad->raw_data =3D NULL;
> +       ad->raw_data_len =3D 0;
> +}
> +
> +bool bt_ad_has_raw_data(struct bt_ad *ad)
> +{
> +       if (!ad)
> +               return false;
> +
> +       return (ad->raw_data && ad->raw_data_len > 0);
> +}
> +
> +bool bt_ad_get_raw_data(struct bt_ad *ad, uint8_t **data, size_t *data_l=
en)
> +{
> +       if (!ad || !data || !data_len)
> +               return false;
> +
> +       *data_len =3D ad->raw_data_len;
> +       *data =3D ad->raw_data;
> +
> +       return (ad->raw_data && ad->raw_data_len > 0);
> +}
> +
>  void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_=
data)
>  {
>         if (!ad)
> diff --git a/src/shared/ad.h b/src/shared/ad.h
> index 7c5d94db0458..8a7e018e9387 100644
> --- a/src/shared/ad.h
> +++ b/src/shared/ad.h
> @@ -176,6 +176,14 @@ bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, =
void *data, size_t len);
>
>  bool bt_ad_has_data(struct bt_ad *ad, const struct bt_ad_data *data);
>
> +void bt_ad_set_raw_data(struct bt_ad *ad, const uint8_t *data, size_t le=
n);
> +
> +void bt_ad_clear_raw_data(struct bt_ad *ad);
> +
> +bool bt_ad_has_raw_data(struct bt_ad *ad);
> +
> +bool bt_ad_get_raw_data(struct bt_ad *ad, uint8_t **data, size_t *data_l=
en);
> +
>  void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_=
data);
>
>  bool bt_ad_remove_data(struct bt_ad *ad, uint8_t type);
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index a140253d92a6..9b990746d811 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -2510,12 +2510,18 @@ static void btp_gap_device_found_ev(struct l_dbus=
_proxy *proxy)
>  {
>         struct btp_device *device =3D find_device_by_proxy(proxy);
>         struct btp_adapter *adapter =3D find_adapter_by_device(device);
> +       struct l_dbus_message_iter dict_iter;
> +       struct btp_device_found_ev *p_ev =3D NULL;
>         struct btp_device_found_ev ev;
>         struct btp_gap_device_connected_ev ev_conn;
>         const char *str, *addr_str;
>         int16_t rssi;
>         uint8_t address_type;
>         bool connected;
> +       const uint8_t *raw_data =3D NULL; /* Buffer for Raw Advertising D=
ata */
> +       uint32_t data_len =3D 0U; /* Length of the raw_data buffer*/
> +
> +       ev.eir_len =3D 0U;
>
>         if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) =
||
>                                         str2ba(addr_str, &ev.address) < 0=
)
> @@ -2538,11 +2544,53 @@ static void btp_gap_device_found_ev(struct l_dbus=
_proxy *proxy)
>                                         BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
>                                         BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
>
> -       /* TODO Add eir to device found event */
> -       ev.eir_len =3D 0;
> +       do {
> +               /* dict_iter will contain the item for RawAdvertisingData=
 */
> +               if (!l_dbus_proxy_get_property(proxy,
> +                                               "RawAdvertisingData",
> +                                               "ay",
> +                                               &dict_iter))
> +                       break;
> +
> +               /* raw_data contains the Advertising Data, in raw format
> +                * data_len contains the length read in the data buffer
> +                */
> +               if (!l_dbus_message_iter_get_fixed_array(&dict_iter,
> +                                                               &raw_data=
,
> +                                                               &data_len=
))
> +                       break;
> +
> +               if (data_len <=3D 0U)
> +                       break;
> +
> +               /* Allocate new buffer, recalculated to sustain new data
> +                * size of previous struct + new length
> +                */
> +               p_ev =3D (struct btp_device_found_ev *)
> +                       l_malloc(sizeof(*p_ev) + data_len);
>
> -       btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->=
index,
> -                                               sizeof(ev) + ev.eir_len, =
&ev);
> +               if (!p_ev)
> +                       break;
> +
> +               /* Populate structure that will contain the raw adv data =
*/
> +               memcpy(p_ev, &ev, sizeof(ev));
> +               memcpy(p_ev->eir, raw_data, data_len);
> +
> +       } while (false);
> +
> +       if (p_ev) {
> +               p_ev->eir_len =3D data_len;
> +
> +               btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
> +                               adapter->index, sizeof(*p_ev) + data_len,
> +                               p_ev);
> +
> +               l_free(p_ev);
> +       } else {
> +               btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
> +                               adapter->index, sizeof(ev) + ev.eir_len,
> +                               &ev);
> +       }
>
>         if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected=
) &&
>                                                                 connected=
) {
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz

Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585A27FD56
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419746; cv=none; b=mCo9S8IJL/GI+bxH+RjMcyr8Zz6A1ToEROo5trHu0gNp+QszLtRYwirmynnkX7HXVQp6NrVvVKaYsZo+/NQkeW+S/WwVAg4r0slZ04uo6QdLjE7bmmqtWHutYmdJyxm0wXxXbujyK0L5lwVYRTmYFLNVyO4bOvF/OFNfcVnlJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419746; c=relaxed/simple;
	bh=UYFWqwqdb664dKUjxRkTOVLN9XxVNpE8fYiANc3ljUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcPn5SML3UiGVEq0z5CK0gmaYSA7p1ylKjl/goPqTPGP3XcJZcVIrMhP2YiiD5TBbcxd3jPHVmYmbGsjXfH3knny50LMbdqUiuokpnnCkxGoV34Ng8DTGoK3zOJtbGwn/YiNP2N/e3dvcv5/Q91ZRizBIcESwtKHZSAJaa515to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA92TcVQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA92TcVQ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so56758581fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419742; x=1746024542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HSPpO72j6Gz7n/ZW3A6v1GMkidOIlDV/QRzS33eyNk=;
        b=HA92TcVQHVAPZzuN29yNGnLHB0UIdz3AraMZ5cTJKuqB+smhF1M8gdxSaNJWM6BIgt
         zOIFpzF94s15esHgx6Oo1OuqgaMIRUsWapPhX7NIhH7+QNV1+f53bZXB8HlZNzQMWBkp
         XXfok4x3CuxHRnoTuTdXwmGvYWa14vzsrOEyJFdhg1yvYMTW0UZ/l+WWYH5vybI0Rl9a
         PTNprUpPeIBm8I3ARqAEbx+nRimZcazcsFl8jFejw6IpeDH35sX33evd1Mc4LD6wFF+h
         dH59r+cS6sHjvhIrSAuLpju6Dr5gXSVMKe2cwDGsUMHF4Nzdr3ttrSJ2kPaQZ3VgIDpT
         tmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419742; x=1746024542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HSPpO72j6Gz7n/ZW3A6v1GMkidOIlDV/QRzS33eyNk=;
        b=AkPtGqS5d5ebxF4eUcmuqu3VmL6cqFgURKIxUYatTgpB+jnFtNZYb5MRDmt1G5TdA3
         6ygt67BSN0LyWnOivjR+xV4UE0XOtffOS3NyT5NtTEdYzLIWlUTB3k3CmMRux3UzE7Ta
         /s9DrojvYWj0ZJuZNLzUx3aR/5bVpsbPwXWiRhq8Nm9OsBqbyWCeQMwS4FM/oA0KHvQD
         gYRsFyP3Zvr8MLi/kcbiGHOgVmsbto+bkF+7P47B2olgneQPAwxy3cWwRFW3v5KRoYid
         k9whB4Lg6uMbsGDCVfwe/bQJBFFxQOdL0IvrBFg4POvYUOLFs7KCGHwbQhlSDiGSq4W/
         zcwQ==
X-Gm-Message-State: AOJu0YyCTjUfUbPXeAf+t6PBZwynRISSvOf2/Y4rMyUyDFAx+N5l31bk
	RzTEcUZCXpXyrVE/QyJkLGzEHD2H6jSzErufZihX0YDx+EN5vBXyATuCWsJtNtwzmJhBwkR3uM8
	GKE/o0N7fWNyOJim1XBFdjMHjVcNNkqCpUCI=
X-Gm-Gg: ASbGncu9Hofs6KHDtL5QTi18FR326dnS6rteRxgq/3W/du/Xi/FZ6ll6oJTH3q+sCe3
	ncLMFviptmhOxDqk4xArO9It8h3KCzbIVNAmP1LSLrdgnAhCaAv4mJeNRwjOoDBGFMoC1rS8iZE
	s9EBH+S9ld69SwKz6jdfiA
X-Google-Smtp-Source: AGHT+IFKy5Og0daSpTi04FzmJtWx4byhfl9B/u4QBkwmVU5pOyVO6otAgpTI8CmFtMBQG5ZT3WAGSv1rA4HumfZ+yXo=
X-Received: by 2002:a2e:a582:0:b0:310:506c:613 with SMTP id
 38308e7fff4ca-310905794d0mr52313191fa.37.1745419741995; Wed, 23 Apr 2025
 07:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423144020.358828-1-ludovico.denittis@collabora.com> <20250423144020.358828-2-ludovico.denittis@collabora.com>
In-Reply-To: <20250423144020.358828-2-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Apr 2025 10:48:49 -0400
X-Gm-Features: ATxdqUGIOofZef2YM8Eytn7c-Ql5fM_XRlY51GhU_49sSSoECKtMgb4sF56wGpM
Message-ID: <CABBYNZ+7myVzJgHkdw9ZqBJmcD=O-z9WQX17ftmaw6pyDpy-fQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/8] src: Add new SixaxisCablePairing property
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Wed, Apr 23, 2025 at 10:41=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> This adds initial support for a new SixaxisCablePairing property.
> The property can be used to set a device as being a "real" Sixaxis
> gamepad and then handle it differently when needed.
> ---
>  doc/org.bluez.Device.rst |  6 ++++++
>  src/device.c             | 44 ++++++++++++++++++++++++++++++++++++++++
>  src/device.h             |  3 +++
>  3 files changed, 53 insertions(+)
>
> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> index 13328249b..2d85d0dc2 100644
> --- a/doc/org.bluez.Device.rst
> +++ b/doc/org.bluez.Device.rst
> @@ -279,6 +279,12 @@ boolean LegacyPairing [readonly]
>         Bluetooth 2.1 (or newer) devices that have disabled Extended Inqu=
iry
>         Response support.
>
> +boolean SixaxisCablePairing [readonly]
> +``````````````````````````````````````
> +
> +       Set to true if the device was paired using the Sixaxis USB custom=
 protocol.
> +       If true, the device connection will happen without enforcing encr=
yption.

Can't we make this more generic and just call it CablePairing? For the
core I don't think it really matters what method of cable pairing it
was used.

>  string Modalias [readonly, optional]
>  ````````````````````````````````````
>
> diff --git a/src/device.c b/src/device.c
> index b82a905f9..b11b5c8e4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -239,6 +239,7 @@ struct btd_device {
>         GSList          *watches;               /* List of disconnect_dat=
a */
>         bool            temporary;
>         bool            connectable;
> +       bool            sixaxis_cable_pairing;
>         unsigned int    disconn_timer;
>         unsigned int    discov_timer;
>         unsigned int    temporary_timer;        /* Temporary/disappear ti=
mer */
> @@ -507,6 +508,9 @@ static gboolean store_device_info_cb(gpointer user_da=
ta)
>         g_key_file_set_boolean(key_file, "General", "Blocked",
>                                                         device->blocked);
>
> +       g_key_file_set_boolean(key_file, "General", "SixaxisCablePairing"=
,
> +                                                       device->sixaxis_c=
able_pairing);
> +
>         if (device->wake_override !=3D WAKE_FLAG_DEFAULT) {
>                 g_key_file_set_boolean(key_file, "General", "WakeAllowed"=
,
>                                        device->wake_override =3D=3D
> @@ -908,6 +912,11 @@ bool btd_device_is_trusted(struct btd_device *device=
)
>         return device->trusted;
>  }
>
> +bool device_is_sixaxis_cable_pairing(struct btd_device *device)
> +{
> +       return device->sixaxis_cable_pairing;
> +}
> +
>  static gboolean dev_property_get_address(const GDBusPropertyTable *prope=
rty,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -1153,6 +1162,17 @@ static gboolean dev_property_get_legacy(const GDBu=
sPropertyTable *property,
>         return TRUE;
>  }
>
> +static gboolean dev_property_get_sixaxis_cable_pairing(const GDBusProper=
tyTable *property,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct btd_device *device =3D data;
> +       dbus_bool_t val =3D device->sixaxis_cable_pairing;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
> +
> +       return TRUE;
> +}
> +
>  static gboolean dev_property_get_rssi(const GDBusPropertyTable *property=
,
>                                         DBusMessageIter *iter, void *data=
)
>  {
> @@ -3483,6 +3503,7 @@ static const GDBusPropertyTable device_properties[]=
 =3D {
>         { "Trusted", "b", dev_property_get_trusted, dev_property_set_trus=
ted },
>         { "Blocked", "b", dev_property_get_blocked, dev_property_set_bloc=
ked },
>         { "LegacyPairing", "b", dev_property_get_legacy },
> +       { "SixaxisCablePairing", "b", dev_property_get_sixaxis_cable_pair=
ing },
>         { "RSSI", "n", dev_property_get_rssi, NULL, dev_property_exists_r=
ssi },
>         { "Connected", "b", dev_property_get_connected },
>         { "UUIDs", "as", dev_property_get_uuids },
> @@ -4062,6 +4083,9 @@ next:
>         if (blocked)
>                 device_block(device, FALSE);
>
> +       device->sixaxis_cable_pairing =3D g_key_file_get_boolean(key_file=
, "General",
> +                                                       "SixaxisCablePair=
ing", NULL);
> +
>         /* Load device profile list */
>         uuids =3D g_key_file_get_string_list(key_file, "General", "Servic=
es",
>                                                 NULL, NULL);
> @@ -4857,6 +4881,9 @@ void device_merge_duplicate(struct btd_device *dev,=
 struct btd_device *dup)
>         dev->trusted =3D dup->trusted;
>         dev->blocked =3D dup->blocked;
>
> +       /* Skip sixaxis_cable_pairing property because it doesn't support=
 LE, so we
> +        * never expect to have a duplicate device in that case */
> +
>         for (l =3D dup->uuids; l; l =3D g_slist_next(l))
>                 dev->uuids =3D g_slist_append(dev->uuids, g_strdup(l->dat=
a));
>
> @@ -6416,6 +6443,23 @@ void device_set_legacy(struct btd_device *device, =
bool legacy)
>                                         DEVICE_INTERFACE, "LegacyPairing"=
);
>  }
>
> +void device_set_sixaxis_cable_pairing(struct btd_device *device,
> +                                                       gboolean sixaxis_=
cable_pairing)
> +{
> +       if (!device)
> +               return;
> +
> +       if (device->sixaxis_cable_pairing =3D=3D sixaxis_cable_pairing)
> +               return;
> +
> +       DBG("setting sixaxis cable pairing %d", sixaxis_cable_pairing);
> +
> +       device->sixaxis_cable_pairing =3D sixaxis_cable_pairing;
> +
> +       g_dbus_emit_property_changed(dbus_conn, device->path,
> +                                       DEVICE_INTERFACE, "SixaxisCablePa=
iring");
> +}
> +
>  void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr=
_type,
>                                                                 uint16_t =
value)
>  {
> diff --git a/src/device.h b/src/device.h
> index 2e4a9771d..c0fa6ec3a 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -94,6 +94,7 @@ bool device_is_connectable(struct btd_device *device);
>  bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
>  bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
>  bool btd_device_is_trusted(struct btd_device *device);
> +bool device_is_sixaxis_cable_pairing(struct btd_device *device);
>  void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
>  void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
>  void btd_device_set_temporary(struct btd_device *device, bool temporary)=
;
> @@ -101,6 +102,8 @@ void btd_device_set_trusted(struct btd_device *device=
, gboolean trusted);
>  void btd_device_set_connectable(struct btd_device *device, bool connecta=
ble);
>  void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type);
>  void device_set_legacy(struct btd_device *device, bool legacy);
> +void device_set_sixaxis_cable_pairing(struct btd_device *device,
> +                                                       gboolean sixaxis_=
cable_pairing);
>  void device_set_rssi_with_delta(struct btd_device *device, int8_t rssi,
>                                                         int8_t delta_thre=
shold);
>  void device_set_rssi(struct btd_device *device, int8_t rssi);
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz

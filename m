Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980E2EB847
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609803; cv=none; b=EHuJcCuF1a2CLBfd0SIExFZNZrzyNN4DnjNKsWCvXgoJ9VFuPYqlziFyAgAyY/TbYY5qaNBtKCXf1s3fupSPaVVhcbPgohZpOyxWPrCMvtqBMFop0kL3NBXXyyd9mK/5JTGJxb1MN4PBeCnzoNuZq2H1+6Awn+yxwBEUXIFGNho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609803; c=relaxed/simple;
	bh=J8OzK0AJruu7OZok6cV/oWjVRn6qpjqIigdbCCDcARc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoPokEucvV0oLnyOESOH+fYBfHSVsx+2285HV5cv2LFM5Q4Qb+VJFX1OspD3UxE43Sa1aLs6l+/f5dS6q62Td2xC5X+1yzUxVk0OOUtI/53AG9PGuchcWWvefUSWdQIFmkRmJ6fN46epCG8TL0ymG5HQ7Lfsdg26a6FklLT6osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlksJY99; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlksJY99"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-333f8ef8483so40207921fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Aug 2025 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755609799; x=1756214599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJTH5IA8lZnNx912y02bTqIgmoAXtN/hrbV0sCcztbY=;
        b=mlksJY99wwMephj3+VKiieoBa51T+Cstp5XujAxT1fRYqBlw4c1seYRuB/Rt0cSD7W
         LuAkOsm2ZRLm9yhPK7HbXyHYNveF1k0NMv/WZUZMo7sqGNKt90+lRX45fO1j/+60hupl
         PUOasNtUIho+sGlpkXd8fhvwh7e9GRZiOdAzOB1ICU0v9NAW6+7zN9S3WRb6YUVqP6Re
         8iDrcPeAFP960WUr6samQocvaDoaer74zNmE+uvSdvBwQhC+wZ2AJ6iWpo9aSt9CZaFB
         BaxkweSyNKT0eL3D3vZmHY2sj/uJ1+3JE/Okao4Mzzxj6KIsKXktpe/DR8WdbwK2XstB
         hkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609799; x=1756214599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJTH5IA8lZnNx912y02bTqIgmoAXtN/hrbV0sCcztbY=;
        b=luIyF5x+8zrJ/Ox+ko0eE5lLOf7NdP3nDVbTPhUF0Nthtzv9FIZFBYeGVBLgbT8RH0
         9iC6Q++kzXxwysRDCWadualJE2RUmtNH1dSE5gw8xc1q8A5e43TcdqTft/zobUoi9JuD
         C3eCGF9Zt48l1FN1Q3sUqQcE6524Bg2GGOClvsMNpj4ErNmfiCbVnbWOKvWWyi0QRt4U
         EDMFMBqaa1OoU4LztfPPS7H2qbTs4nIMKUj3GjjlFroz2jJw6BpRzAcUPcSbp0YBOIIo
         Z3NzK82ogbjr7Mmr3Hw9WcFBCEnIDjj8hHCBPAn08QAUI+SMPCuE7KtL9EPQIb4z8jy/
         4t9A==
X-Gm-Message-State: AOJu0YxJrJVvN4ctfxTQg5WzRCsm9yCrf5G0/4n0sRux0hlBwhrXAwI8
	rL9tgI0pf2T3CqbdPAJFD6vpTGbg0khjqBqakr8L2tDOpAEc1b1W3M6WSSyIkzpiLCfqQ0/B8Hi
	AFtL34CogVIQ5NPPcBtC+9x5EbFu3p2elC1m9emw=
X-Gm-Gg: ASbGncu+BkxxpkPFDBul84X7D5/06umIoYvkUQ1DDfLYv4JgbFOn/V03URY1MT8DpR+
	9ZtYArY8w81m6F/ZEnHjRhqH9kpGzJHpctlXNtupdRNW6omEFXFmZpPfip3RA0RcjBq5Hloq/2B
	umnAujA3J3QYpXzNvR2gUcsUci4pSL0u9eazz5Na20fZ/2Po3zxhgoviPBOpI7tmPr0IHv7s0v9
	5TdXkGEO1gyzEainMUyiySrdKc=
X-Google-Smtp-Source: AGHT+IE6YtrBjJdt0F5GaQ8YzlLVp2K6T+rzDa5CcBEjenmyQDQyGS7ZlkckwHV4I5/AuQgFVTc91W7QSvm4/jYaAKw=
X-Received: by 2002:a05:651c:2111:b0:32a:6aa0:2173 with SMTP id
 38308e7fff4ca-3353068053bmr6247761fa.20.1755609798644; Tue, 19 Aug 2025
 06:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-adapter-sync-bcast-v1-1-4a739f99c156@amlogic.com>
 <CABBYNZLU1pA_YJ4KRvrD2SYYv+dDHr9=bN1ZgruZNvc4eurPdw@mail.gmail.com>
 <a07d9f1c-d39f-4c5f-a964-a9cb3d608a66@amlogic.com> <CABBYNZJkH8+-k9KjmVs=0v8moEEWRNdDUXJDFrMT-+wu8pvKOQ@mail.gmail.com>
 <93d84f99-85f3-4593-87d7-f4f0c3d9f16f@amlogic.com>
In-Reply-To: <93d84f99-85f3-4593-87d7-f4f0c3d9f16f@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Aug 2025 09:23:06 -0400
X-Gm-Features: Ac12FXxP2ChpV4KdcnAI2c2Jz3U6qLfU7b7hD0GM8H4-I6UNFVQUPjg-NEhqkt0
Message-ID: <CABBYNZLDpmkobZPbejxxU7ns=DfzmRhXWLYPghpf0iR3mDHTGA@mail.gmail.com>
Subject: Re: [PATCH bluez] As a BIS sink role, BlueZ currently defaults to
 synchronizing with the first broadcast source device discovered by the le
 discovery procedure. This behavior may not align with user expectations, as
 it removes control over the target device selection.
To: Ye He <ye.he@amlogic.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 19, 2025 at 3:41=E2=80=AFAM Ye He <ye.he@amlogic.com> wrote:
>
> Hi Luiz,
>
> Hi,
>
> On Fri, Aug 15, 2025 at 6:04=E2=80=AFAM Ye He <ye.he@amlogic.com> wrote:
>
> Hi Luiz,
>
> Hi,
>
> On Wed, Aug 13, 2025 at 3:12=E2=80=AFAM Ye He via B4 Relay
> <devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch introduces a new SyncBroadcast method to the device1 interface=
,
> allowing users to explicitly choose which broadcast source device to
> synchronize with.
>
> Hold on, why do you think we don't have a explicit way to select the
> broadcast to synchronize? Have you read Transport.Select
> documentation:
>
> https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaTransport.r=
st#void-select
>
> Also if the plan is to introduce another method to enumerate
> MediaTransport for Broadcaster I don't think it is a good idea since
> it affect scan state anyway and then we have the problem that the
> device needs to be discovered first in order to have an object.
>
>
> As far as I understand, the Transport.Select method is intended
> for selecting a BIS to synchronize with when there are multiple
> BISes within a broadcast device.
>
> However, if there are multiple broadcast devices, BlueZ currently
> defaults to synchronizing with the first one it encounters during
> the LE discovery procedure, which may not what the user expects.
>
> By introducing a new SyncBroadcast method in device1, the application
> layer could choose the target one to synchronize with from cached
> broadcast devices based on their own criteria =E2=80=94 for example, choo=
sing
> the device with the strongest RSSI or device with custom UUIDs.
>
> You are confusing PA Sync with BIG Sync, during the general discovery
> what BlueZ does is a short lived PA Sync to discover the streams
> configuration (BASE), it _doesn't_ do a BIG sync, then the user can
> use Transport.Select to select which stream(s) to synchronize.
>
>
> I'm sorry for previously confusing PA sync with BIG sync. After reviewing=
 the
> BIS synchronization process, I believe the actual issue I encountered is =
that
> when multiple BIS source devices are present, BlueZ currently establishes=
 PA
> sync with the first device it discovers by default.

That is not the entire explanation, the PA sync is done for every
Broadcast found, not just the first:

https://github.com/bluez/bluez/blob/master/profiles/audio/bap.c#L3651

> In this case, the application layer has no way to select the target broad=
cast
> device =E2=80=94 it can only accept the one that BlueZ chooses by default=
 for creating
> PA sync. To address this limitation, I suggest introducing a new method
> (e.g., Device1.SyncPA) that would allow applications to explicitly select=
 the
> desired device for PA synchronization.
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
>  doc/org.bluez.Device.rst | 15 +++++++++++++++
>  plugins/neard.c          |  2 +-
>  src/adapter.c            |  4 ++--
>  src/device.c             | 39 ++++++++++++++++++++++++++++++++++++---
>  src/device.h             |  3 ++-
>  5 files changed, 56 insertions(+), 7 deletions(-)
>
> diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
> index 61c394dd2d0b371fe10508b8e64087ed87a2e6e0..44d929e8850659cdfbcafa81f=
18dd44e4aa53d03 100644
> --- a/doc/org.bluez.Device.rst
> +++ b/doc/org.bluez.Device.rst
> @@ -155,6 +155,21 @@ Possible errors:
>  :org.bluez.Error.NotConnected:
>  :org.bluez.Error.DoesNotExist:
>
> +void SyncBroadcast() [experimental]
> +```````````````````````````````````
> +
> +Initiates synchronization with a broadcast source device that contains B=
roadcast
> +Announcements UUID. This method can be used on devices that are capable =
of
> +broadcast synchronization.
>
> +If the device is not capable of broadcast synchronization, this method w=
ill
> +fail with `org.bluez.Error.NotSupported`.
> +
> +Possible errors:
> +
> +:org.bluez.Error.Failed:
> +:org.bluez.Error.NotSupported:
> +
>  Signals
>  -------
>
> diff --git a/plugins/neard.c b/plugins/neard.c
> index c84934025cd8541bf604efe9520c1c3e9c83068f..8c231a8e84b0090b450f3b61e=
75cc4d4c6e4a14f 100644
> --- a/plugins/neard.c
> +++ b/plugins/neard.c
> @@ -633,7 +633,7 @@ static void store_params(struct btd_adapter *adapter,=
 struct btd_device *device,
>         }
>
>         if (params->services)
> -               device_add_eir_uuids(device, params->services);
> +               device_add_eir_uuids(device, params->services, true);
>
>         if (params->hash) {
>                 btd_adapter_add_remote_oob_data(adapter, &params->address=
,
> diff --git a/src/adapter.c b/src/adapter.c
> index b771cf66ade30dcfe0a6fa41cd28f1ba46bed5a4..b12d75c815ee936aeaf3210f9=
7831eee8ee945a2 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1740,7 +1740,7 @@ static void discovery_cleanup(struct btd_adapter *a=
dapter, int timeout)
>                 next =3D g_slist_next(l);
>
>                 if (device_is_temporary(dev) && !device_is_connectable(de=
v)
> -                       && !btd_device_is_connected(dev))
> +                       && !btd_device_is_connected(dev) && !btd_device_i=
s_bcast_syncable(dev))
>                         btd_adapter_remove_device(adapter, dev);
>         }
>  }
> @@ -7452,7 +7452,7 @@ void btd_adapter_device_found(struct btd_adapter *a=
dapter,
>                                                         eir_data.did_prod=
uct,
>                                                         eir_data.did_vers=
ion);
>
> -       device_add_eir_uuids(dev, eir_data.services);
> +       device_add_eir_uuids(dev, eir_data.services, false);
>
>         if (adapter->discovery_list)
>                 g_slist_foreach(adapter->discovery_list, filter_duplicate=
_data,
> diff --git a/src/device.c b/src/device.c
> index 0179c3dab603ece0faedfd122c87b99f35a2ca6e..410a051391529799d83102d3e=
8b041a264fd415a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -78,6 +78,8 @@
>
>  #define RSSI_THRESHOLD         8
>
> +#define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
> +
>  static DBusConnection *dbus_conn =3D NULL;
>  static unsigned service_state_cb_id;
>
> @@ -2356,7 +2358,7 @@ done:
>         dev->connect =3D NULL;
>  }
>
> -void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
> +void device_add_eir_uuids(struct btd_device *dev, GSList *uuids, bool pr=
obe)
>  {
>         GSList *l;
>         GSList *added =3D NULL;
> @@ -2372,7 +2374,8 @@ void device_add_eir_uuids(struct btd_device *dev, G=
SList *uuids)
>                 dev->eir_uuids =3D g_slist_append(dev->eir_uuids, g_strdu=
p(str));
>         }
>
> -       device_probe_profiles(dev, added);
> +       if (probe)
> +               device_probe_profiles(dev, added);
>  }
>
>  static void add_manufacturer_data(void *data, void *user_data)
> @@ -2411,7 +2414,7 @@ static void add_service_data(void *data, void *user=
_data)
>                 return;
>
>         l =3D g_slist_append(NULL, sd->uuid);
> -       device_add_eir_uuids(dev, l);
> +       device_add_eir_uuids(dev, l, false);
>         g_slist_free(l);
>
>         g_dbus_emit_property_changed(dbus_conn, dev->path,
> @@ -3488,6 +3491,21 @@ static DBusMessage *get_service_records(DBusConnec=
tion *conn, DBusMessage *msg,
>         return reply;
>  }
>
> +static DBusMessage *sync_broadcast_device(DBusConnection *conn, DBusMess=
age *msg,
> +                                                       void *user_data)
> +{
> +       struct btd_device *dev =3D user_data;
> +
> +       DBG("Sync with broadcast device %s", batostr(&dev->bdaddr));
> +
> +       if (!btd_device_is_bcast_syncable(dev))
> +               return btd_error_not_supported(msg);
> +
> +       btd_device_add_uuid(dev, BCAAS_UUID_STR);
> +
> +       return dbus_message_new_method_return(msg);
> +}
> +
>  static const GDBusMethodTable device_methods[] =3D {
>         { GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
>         { GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
> @@ -3500,6 +3518,7 @@ static const GDBusMethodTable device_methods[] =3D =
{
>         { GDBUS_EXPERIMENTAL_METHOD("GetServiceRecords", NULL,
>                                     GDBUS_ARGS({ "Records", "aay" }),
>                                     get_service_records) },
> +       { GDBUS_EXPERIMENTAL_ASYNC_METHOD("SyncBroadcast", NULL, NULL, sy=
nc_broadcast_device) },
>         { }
>  };
>
> @@ -3654,6 +3673,20 @@ bool btd_device_bdaddr_type_connected(struct btd_d=
evice *dev, uint8_t type)
>         return dev->le_state.connected;
>  }
>
> +bool btd_device_is_bcast_syncable(struct btd_device *dev)
> +{
> +       if (dev->bredr_state.connected || dev->le_state.connected)
> +               return false;
> +
> +       for (GSList *l =3D dev->eir_uuids; l !=3D NULL; l =3D l->next) {
> +               const char *str =3D l->data;
> +               if (bt_uuid_strcmp(str, BCAAS_UUID_STR) =3D=3D 0)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static void clear_temporary_timer(struct btd_device *dev)
>  {
>         if (dev->temporary_timer) {
> diff --git a/src/device.h b/src/device.h
> index 9e7c30ad71864932d3da2211f30e3c7ffc4b02f7..70f4dc1a11a12bce4514fcfa3=
62c713d4d2a5235 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -76,7 +76,7 @@ void btd_device_gatt_set_service_changed(struct btd_dev=
ice *device,
>                                                 uint16_t start, uint16_t =
end);
>  bool device_attach_att(struct btd_device *dev, GIOChannel *io);
>  void btd_device_add_uuid(struct btd_device *device, const char *uuid);
> -void device_add_eir_uuids(struct btd_device *dev, GSList *uuids);
> +void device_add_eir_uuids(struct btd_device *dev, GSList *uuids, bool pr=
obe);
>  void device_set_manufacturer_data(struct btd_device *dev, GSList *list,
>                                                         bool duplicate);
>  void device_set_service_data(struct btd_device *dev, GSList *list,
> @@ -110,6 +110,7 @@ void device_set_tx_power(struct btd_device *device, i=
nt8_t tx_power);
>  void device_set_flags(struct btd_device *device, uint8_t flags);
>  bool btd_device_is_connected(struct btd_device *dev);
>  bool btd_device_bearer_is_connected(struct btd_device *dev);
> +bool btd_device_is_bcast_syncable(struct btd_device *dev);
>  bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t ty=
pe);
>  uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
>  bool device_is_retrying(struct btd_device *device);
>
> ---
> base-commit: 9cdbad590b7476b83e2ef240a486fd5159251be8
> change-id: 20250813-adapter-sync-bcast-871fb45c702a
>
> Best regards,
> --
> Ye He <ye.he@amlogic.com>
>
>
>
>
> --
> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

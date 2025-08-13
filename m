Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC672136347
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089724; cv=none; b=RX6VRxBsqeqSQt9ljP+ENle+XFo7AptfUCjR8OPU7TnmqPkGSx05n4yvDbaGgsxIandxT8A1EOL+TyxauImJMHetwJ4apxR1Kkt7hW/3s4+nIF9hmXE+Htax4W69hmoF4YOWriU6NzMGC1xKIkCQWtZjXDxAlZRRZh6+4FyTrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089724; c=relaxed/simple;
	bh=3+CtX7CZ3dvdWZNIeEkqnKW5u2kvpfO4e48xB+jbcBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+dhbTqo+q1LTojnJZaJROyWY7QbUyDS3YjwGgrHmURSt6tCk0whZ1ckAqj2RlSjYqNwdSPsuilv+pEEl79SZ6fuwGHrB19cfG9rZS9BLdiGX7iEYbxpi8GYhzygVBGVKLbvNHJckJaZWdfRADz8HerJ+PWkH6tuY2dwwzx1vTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6+BD6LW; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6+BD6LW"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so59750501fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755089721; x=1755694521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoD4oOB9e5X2snh3SebgL4mjkOxhmHtQAtCffQ7PEJU=;
        b=Q6+BD6LW5d27CBSIOokdFxLcdsgXPJOCOmXVTsf13GylHZhmdgoUPi0Xr4jjCcO9Pz
         cX/ybxagMspZgxPW+lWIoj7nSQeFZ1AK5JwhGR/QalkZnJe6H79OC7zHk9rlub4oETqX
         Xtnd1UeiQfqlSp6Sv66oJtT1gRp4AuwUdnN/NRrhlVHLaQkj8WFZz2VoNYBo2g57fxHX
         TI2ux3VXc5L3y34f+bUFPPFtuxj5Dx/CX+TIAr+VBfG4t4vKcxsOHqwS7PDcR6H+nnRb
         pLkfjY+8HsWYvStpZVzcO5DZhv1e8Wpu41d4gLMhSF1oDA2gFCQcB1+1Gz2fzKbF9ZLA
         jmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755089721; x=1755694521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoD4oOB9e5X2snh3SebgL4mjkOxhmHtQAtCffQ7PEJU=;
        b=cXJleG+y0ho4BbGMpIwbZXYO38lMIyqcK+MaLzICOsBIEKu1Ca1IpS2/LtqgaEJuGQ
         PU01i180f/WtuWHL16EJhZoZ0XPuCLtBRdtTWBe+govHGjI1gi/yN/vd57bfCTTDrU6v
         0gO4JSzHWudl99ZPJc2f6lnFFbRx2/apIAqSpQrW+gtEq5vqZoLegCjn7ooBjqlnyuNP
         glAQzo8mxMillx38IKR2fI5rOY4z7ObRZwBYRo7Sr34MKDM7WdfTsYDUkqJqPPQbj90a
         Ao2kh0wpj4E7csHnbnInT45iD/aOWmZxDRR0MPy1eanlF5n/KIecZhvZIQO+id3fUC5a
         lATA==
X-Gm-Message-State: AOJu0YxiNvyyI485EQ99TZYR1bG0FJTAj/fe6TpOZ6QTSHSqsY/uFJwI
	YZMZlb/rCFT+0W009a8t5SoFWG9OqagkXwYNRWTp73mYkWlU4sEjgswQg9dJzCRpgGJy4rfQ8Mv
	S0BomA+Oa91gmlEWfT8kzGq1VCnwVRy0WK+QB
X-Gm-Gg: ASbGncveAbZWW4LwdA47eraQG+wOrAsxbZw5SFXQViW0ObVFGDO5Phre8dNMLBOXids
	ZiUqg+k7qN4KBpHp4coW9TclyFRjziGs5uDwPqlXECSNz9Rg4yXC86B3RyKNPD14v3Txkd39ZYq
	EhlhB7P47325mZkDMe309IC7mAX40DtZmuWNAtJmCi3nMIvHlQyXwrBCcHPcXnlHKLM0Uhu3otF
	lJfqQ==
X-Google-Smtp-Source: AGHT+IGxjaiDvzsQWzWGwat55QdIqFE4j+rZjNYjwTRfe9ziFnYmKGN6xk+POcfRJrIZCWG5N5T4y61xRKk/hlfKQNk=
X-Received: by 2002:a2e:bc15:0:b0:333:b782:b8ed with SMTP id
 38308e7fff4ca-333e9421258mr10690501fa.8.1755089720473; Wed, 13 Aug 2025
 05:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-adapter-sync-bcast-v1-1-4a739f99c156@amlogic.com>
In-Reply-To: <20250813-adapter-sync-bcast-v1-1-4a739f99c156@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Aug 2025 08:55:08 -0400
X-Gm-Features: Ac12FXzYrRKJZmyj17jkNX3SYdUmXAyDktNP4Kd1YEIuvDACRvy6JvXtUUx7u7w
Message-ID: <CABBYNZLU1pA_YJ4KRvrD2SYYv+dDHr9=bN1ZgruZNvc4eurPdw@mail.gmail.com>
Subject: Re: [PATCH bluez] As a BIS sink role, BlueZ currently defaults to
 synchronizing with the first broadcast source device discovered by the le
 discovery procedure. This behavior may not align with user expectations, as
 it removes control over the target device selection.
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 13, 2025 at 3:12=E2=80=AFAM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch introduces a new SyncBroadcast method to the device1 interface=
,
> allowing users to explicitly choose which broadcast source device to
> synchronize with.

Hold on, why do you think we don't have a explicit way to select the
broadcast to synchronize? Have you read Transport.Select
documentation:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaTransport.rst=
#void-select

Also if the plan is to introduce another method to enumerate
MediaTransport for Broadcaster I don't think it is a good idea since
it affect scan state anyway and then we have the problem that the
device needs to be discovered first in order to have an object.

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


--=20
Luiz Augusto von Dentz

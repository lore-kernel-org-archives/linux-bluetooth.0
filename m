Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAD3F6C41
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932120; cv=pass; b=BOeqEiFSGGzHZc5+CG26iCZTr8kr9oVun7dGVt5/MPjjtP5uUojpPca0bacZSqZq21K5ADaAVoWcmh2nR2Upxn4/rMadYgY/txL0rIi2rtJuDlYY36uy2R7qoHBDuJhsxv/m0oWF3uVFacYHPNLDhoZzL2uzcEm41zNQdN/+4X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932120; c=relaxed/simple;
	bh=d9njwJ3IMY0s5JXKvVycreE/Bfn0Dr/xyi+FgvTALyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo8+X59v1o4KAZgAbA1nWuVxAzDWVA1fF1X3BilI09LhZcJIITijCyI1T2hz8HuGNVFhMk9kApQP+ytd3EEu1WyZ4r8yhCWOoUrT+nvIYxbdx+vyGLQDTNCGH2urBfO9mBDXxqr/nyGVIotnIcasKzyjCfcx9XzXIyPxnvOMDOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSN0kD5A; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSN0kD5A"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66058b880e9so4434626d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 08:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780932118; cv=none;
        d=google.com; s=arc-20240605;
        b=gKbEW+1HMkdoTK/tFMX710kIM3ahfPt1p2JOZxVGXiMv1sCmChxwkuYgSDKOti84zA
         2pB5YG80mkCNqb+uLuV1PO8aE4mTCP+uu2KYnksTeH8urr9LEC7J8iVOdr5qBaq0TPrW
         eKF9Qzv3mT9DM+M/HY8d5yS8Dxbte7fLbAGQ1rMSWnc6xbDi71r3nlFtL1jRYoc7mjUI
         T8iOiN11ziMk4Hezw1eOAAcRgFicxyOY+wg/ZF3xPSW7yHB3+CqJzjBO3BCIS/UWBM2O
         prv52NBMtpO7sR/nrnC/nNnBAZfA/s7ZamiSZkeeedxysnZvfafkeTB25ADPy7huWzBn
         vUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+d6noQnvKuxJQSKAFkSndrFyqWN5y/MdtCbBNuJyW8g=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=hh/ovjKXJAWH3+NERSTNfC1E1Gpn5vlK8EodNZfA6iiCxc757LEzVNomelIpkdCoW7
         dUaOOk1luVxg94ApSM4xF4sAocASDZ5YTeIife/8mRW9OzF8N129i6pDsu4d0Y8naLjH
         I1gfsNHicEW93pwv9WK/Cr33LtpDqOa5EOg/SFkH2WPUN/xz4YXdx/AHhp1CwazOS6Nr
         HUSAw7X7t56ir39lt2G7hGKoHc26RzwJmNoaWt8BwVTISNoASBFyCMoDpWFQ9KDaNth6
         OKq6j23AXUqzkg4dLAGjziyzX4mB501mPeaHuiCXvb80j072HkDhKyZ0dbciJ8Tv4tTU
         4Yzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780932118; x=1781536918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d6noQnvKuxJQSKAFkSndrFyqWN5y/MdtCbBNuJyW8g=;
        b=ZSN0kD5AHelccSlpPOwLZjjeAp3y3puDY1p0QTdOU0ZNtP2R627wB7d9YXTd+MNOx4
         HvT/uAr4Mc7ueplj6DcMQIJsltDBlrNhy19oQlWvuyecYRxeBqOlQI6o1GQmmbIYV9rM
         SNCZnRFRk5wX/ZQutXd8Ni9Mz+NkQ4DiCy4R4M3jsp71SeDNgVBUIblAKD4R4OvFChh3
         LqNZH+Z5az1/Lux6zK4Vb5iY340iwfDvU+u+40Tu2jOpnABY5RGIQKhkQndsVKZLoG4N
         iR0L7wP8beTUC2kpHr1dM5IFS2Q51nnRYGYyG82B08m8QQfCkISzM7wud3DWAbQq/HPA
         OiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932118; x=1781536918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+d6noQnvKuxJQSKAFkSndrFyqWN5y/MdtCbBNuJyW8g=;
        b=XVwB8VIX4JGGfc2/fZGNy5Wqi8a3wbGeqiZPCkKzgdN4C83TE/NmtGOZPQIqvdfkrY
         xK1Qgbi/RA1n7YJzoDPD+C5mdfSfZ8vEtCHI8idFDwntEn0pA29AxYRuwua25iRF4r59
         ngf59o51YYQSIzT4W+t0/ENcZOgiekWl/7EVdHQDrxcLFVx4X+k39YUdfAsKyTnCCYTZ
         dUoI5cCE1RLkOtKKkkRmXSp/68WgU5mDISIl3Pf6ezsWjAR0m2HLMowdm7sTYTVf6WWn
         o9jksXVDZ8Vxxe/lAw+lde6PvVCzihwMvAIEJgBV4YzBsImfNp36sp47LiSsi3Obu5WU
         RccA==
X-Gm-Message-State: AOJu0YzOlV1VX2/4sz4VW8T5pCyfTTw1mR1sjq2Nr424hZJrxIEGwxwF
	MFVzgmfSJ0ZpPm+9JyJAEpHaNpbxde8ErVtt6vguLSfliEBpyL2JYMQ8OdI/hrpJzD14/eXUrbM
	cOPj7jJSh5otAjiHLYPlSgawOU+66++Y=
X-Gm-Gg: Acq92OG5nBTReQ3CEGcP3E1CKAZjLwZTnXkBRlbBTJZaFyB9iK6vyZZfI9LGk+lV7uS
	EYtuLmgbxX3405O8dR8eEYGLMmNHyKfuv9LGOBEcc38n71RtUtZd55FvMWF6TrrN1zRSRTywDAK
	1YmOT6qRoD5aDp6itoy8e1UNu843E2sqY9+6vR57kqhTbbfEJv5VFlneGW28gbzxjHKDAp1JRP3
	JFj6agtM3Wt20sb2ETbNBj/hEE0WF5AC24mCODH01uu+B4yKi3Af9YKL4F1m6SrcAfidcoelCqa
	5PjlH55gbDNWBcSCMz3s/lcUwnOKm7LMlxtLpL5WQxKKUDxqevC9cbBdPqxLxs+JdmDkSms4NmA
	c/g==
X-Received: by 2002:a05:690e:1908:b0:660:5ce2:58e6 with SMTP id
 956f58d0204a3-66106f4e6eemr13879474d50.21.1780932117879; Mon, 08 Jun 2026
 08:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608142050.3742000-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608142050.3742000-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jun 2026 11:21:46 -0400
X-Gm-Features: AVVi8Cc3LdSAaZhuXzioRZtABaA1Q4-03k6e4mfqLM5Up_8Yvffr1MDzATlxHIs
Message-ID: <CABBYNZL-A=NpnfiO9GO66TNX5QaEuvpSZ9fuBk0Jo+aNtr7huA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt-client: Add PreferredNotifyType property
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jun 8, 2026 at 10:31=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> When a characteristic supports both notifications and indications the
> CCC we always register for notifications, leaving no way to choose
> indications from D-Bus.
>
> Add PreferredNotifyType (string, "notification"/"indication") to
> org.bluez.GattCharacteristic1, only present when both flags are set.
> StartNotify() and AcquireNotify() honor it on the next CCC write.
> ---
>  doc/org.bluez.GattCharacteristic.rst | 21 +++++++
>  src/gatt-client.c                    | 85 ++++++++++++++++++++++++++++
>  src/shared/gatt-client.c             | 31 +++++++++-
>  src/shared/gatt-client.h             |  3 +
>  4 files changed, 138 insertions(+), 2 deletions(-)
>
> diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCha=
racteristic.rst
> index 805f39593..f7e541590 100644
> --- a/doc/org.bluez.GattCharacteristic.rst
> +++ b/doc/org.bluez.GattCharacteristic.rst
> @@ -401,3 +401,24 @@ uint16 MTU [read-only]
>
>  Characteristic MTU, this is valid both for **ReadValue()** and **WriteVa=
lue()**
>  but either method can use long procedures when supported.
> +
> +string PreferredNotifyType [readwrite, optional, experimental]
> +``````````````````````````````````````````````````````````````
> +
> +Selects whether **StartNotify()** and **AcquireNotify()** enable notific=
ations
> +or indications when the characteristic supports both. Only present when =
both
> +"notify" and "indicate" flags are set.
> +
> +Possible values:
> +
> +:"notification":
> +
> +       Enable notifications (CCC =3D 0x0001). Default.
> +
> +:"indication":
> +
> +       Enable indications (CCC =3D 0x0002).
> +
> +Note: the preference applies on the next CCC write. If another client ha=
s
> +already enabled the CCC on this characteristic, the existing setting is =
kept
> +and the new preference takes effect only after the last subscriber stops=
.

Well the spec seems to have changed to allow setting both notify and
indicate simultaneously as well:

If both the Notification and Indication bits are set, then the server
shall use the notification procedure (see Section 4.10) when an
acknowledgment is not required by a higher-layer specification or
shall use the indication procedure (see Section 4.11) when an
acknowledgment is required. The server should not use both procedures
to send the same characteristic value.

So perhaps we need to handle that as well, that said I don't know if
it wouldn't be more efficient to add another method which would enable
passing the value directly rather modifying the
StartNotify/AcquireNotify behavior, but then we would need to create a
different interface name in order to break the existing methods, so
maybe going wit this is better and we just need to handle 0x0003 as
being both enabled and the server decides what to do with it.

> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 3baf95c4f..29564a87d 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -115,6 +115,7 @@ struct characteristic {
>         struct queue *descs;
>
>         bool notifying;
> +       bool prefer_indicate;
>         struct queue *notify_clients;
>  };
>
> @@ -1595,6 +1596,9 @@ static DBusMessage *characteristic_acquire_notify(D=
BusConnection *conn,
>         if (!client)
>                 return btd_error_failed(msg, "Failed allocate notify sess=
ion");
>
> +       bt_gatt_client_set_notify_prefer_indicate(gatt, chrc->value_handl=
e,
> +                                                       chrc->prefer_indi=
cate);
> +
>         client->notify_id =3D bt_gatt_client_register_notify(gatt,
>                                                 chrc->value_handle,
>                                                 register_notify_io_cb,
> @@ -1673,6 +1677,9 @@ static DBusMessage *characteristic_start_notify(DBu=
sConnection *conn,
>
>         op =3D async_dbus_op_new(msg, client);
>
> +       bt_gatt_client_set_notify_prefer_indicate(gatt, chrc->value_handl=
e,
> +                                                       chrc->prefer_indi=
cate);
> +
>         client->notify_id =3D bt_gatt_client_register_notify(gatt,
>                                                 chrc->value_handle,
>                                                 register_notify_cb, notif=
y_cb,
> @@ -1719,6 +1726,76 @@ static DBusMessage *characteristic_stop_notify(DBu=
sConnection *conn,
>         return dbus_message_new_method_return(msg);
>  }
>
> +static gboolean
> +characteristic_get_prefer_notify_type(const GDBusPropertyTable *property=
,
> +                                       DBusMessageIter *iter, void *data=
)
> +{
> +       struct characteristic *chrc =3D data;
> +       const char *str =3D chrc->prefer_indicate ? "indication" : "notif=
ication";
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
> +
> +       return TRUE;
> +}
> +
> +static void
> +characteristic_set_prefer_notify_type(const GDBusPropertyTable *property=
,
> +                                       DBusMessageIter *iter,
> +                                       GDBusPendingPropertySet id, void =
*data)
> +{
> +       struct characteristic *chrc =3D data;
> +       struct bt_gatt_client *gatt =3D chrc->service->client->gatt;
> +       const char *str;
> +       bool prefer;
> +
> +       if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_STRING) {
> +               g_dbus_pending_property_error(id,
> +                                       ERROR_INTERFACE ".InvalidArgument=
s",
> +                                       "Invalid arguments in method call=
");
> +               return;
> +       }
> +
> +       dbus_message_iter_get_basic(iter, &str);
> +
> +       if (!strcmp(str, "notification"))
> +               prefer =3D false;
> +       else if (!strcmp(str, "indication"))
> +               prefer =3D true;
> +       else {
> +               g_dbus_pending_property_error(id,
> +                                       ERROR_INTERFACE ".InvalidArgument=
s",
> +                                       "Invalid arguments in method call=
");
> +               return;
> +       }
> +
> +       if (chrc->prefer_indicate =3D=3D prefer) {
> +               g_dbus_pending_property_success(id);
> +               return;
> +       }
> +
> +       chrc->prefer_indicate =3D prefer;
> +
> +       if (gatt)
> +               bt_gatt_client_set_notify_prefer_indicate(gatt,
> +                                               chrc->value_handle, prefe=
r);
> +
> +       g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->pat=
h,
> +                                       GATT_CHARACTERISTIC_IFACE,
> +                                       "PreferredNotifyType");
> +
> +       g_dbus_pending_property_success(id);
> +}
> +
> +static gboolean
> +characteristic_prefer_notify_type_exists(const GDBusPropertyTable *prope=
rty,
> +                                       void *data)
> +{
> +       struct characteristic *chrc =3D data;
> +
> +       return (chrc->props & BT_GATT_CHRC_PROP_NOTIFY) &&
> +                               (chrc->props & BT_GATT_CHRC_PROP_INDICATE=
);
> +}
> +
>  static const GDBusPropertyTable characteristic_properties[] =3D {
>         { "Handle", "q", characteristic_get_handle },
>         { "UUID", "s", characteristic_get_uuid, NULL, NULL },
> @@ -1733,6 +1810,10 @@ static const GDBusPropertyTable characteristic_pro=
perties[] =3D {
>         { "NotifyAcquired", "b", characteristic_get_notify_acquired, NULL=
,
>                                 characteristic_notify_acquired_exists },
>         { "MTU", "q", characteristic_get_mtu, NULL, characteristic_mtu_ex=
ists },
> +       { "PreferredNotifyType", "s", characteristic_get_prefer_notify_ty=
pe,
> +                               characteristic_set_prefer_notify_type,
> +                               characteristic_prefer_notify_type_exists,
> +                               G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
>         { }
>  };
>
> @@ -2282,6 +2363,10 @@ static void register_notify(void *data, void *user=
_data)
>         op =3D new0(struct async_dbus_op, 1);
>         op->data =3D notify_client;
>
> +       bt_gatt_client_set_notify_prefer_indicate(client->gatt,
> +                                       notify_client->chrc->value_handle=
,
> +                                       notify_client->chrc->prefer_indic=
ate);
> +
>         notify_client->notify_id =3D bt_gatt_client_register_notify(clien=
t->gatt,
>                                         notify_client->chrc->value_handle=
,
>                                         register_notify_cb, notify_cb,
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index a6abe8ac2..403d22758 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -217,6 +217,7 @@ struct notify_chrc {
>         uint16_t properties;
>         unsigned int notify_id;
>         int notify_count;  /* Reference count of registered notify callba=
cks */
> +       bool prefer_indicate;
>
>         /* Pending calls to register_notify are queued here so that they =
can be
>          * processed after a write that modifies the CCC descriptor.
> @@ -1671,9 +1672,13 @@ static bool notify_data_write_ccc(struct notify_da=
ta *notify_data, bool enable,
>
>         if (enable) {
>                 /* Try to enable notifications or indications based on
> -                * whatever the characteristic supports.
> +                * whatever the characteristic supports. If both are
> +                * available honor the per-chrc prefer_indicate flag.
>                  */
> -               if (properties & BT_GATT_CHRC_PROP_NOTIFY)
> +               if (notify_data->chrc->prefer_indicate &&
> +                               (properties & BT_GATT_CHRC_PROP_INDICATE)=
)
> +                       value =3D cpu_to_le16(0x0002);
> +               else if (properties & BT_GATT_CHRC_PROP_NOTIFY)
>                         value =3D cpu_to_le16(0x0001);
>                 else if (properties & BT_GATT_CHRC_PROP_INDICATE)
>                         value =3D cpu_to_le16(0x0002);
> @@ -3838,6 +3843,28 @@ unsigned int bt_gatt_client_register_notify(struct=
 bt_gatt_client *client,
>                                                         user_data, destro=
y);
>  }
>
> +bool bt_gatt_client_set_notify_prefer_indicate(struct bt_gatt_client *cl=
ient,
> +                                               uint16_t value_handle,
> +                                               bool prefer)
> +{
> +       struct notify_chrc *chrc;
> +
> +       if (!client || !client->db || !value_handle)
> +               return false;
> +
> +       chrc =3D queue_find(client->notify_chrcs, match_notify_chrc_value=
_handle,
> +                                               UINT_TO_PTR(value_handle)=
);
> +       if (!chrc) {
> +               chrc =3D notify_chrc_create(client, value_handle);
> +               if (!chrc)
> +                       return false;
> +       }
> +
> +       chrc->prefer_indicate =3D prefer;
> +
> +       return true;
> +}
> +
>  bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>                                                         unsigned int id)
>  {
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 63cf99500..0d08f8014 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -124,6 +124,9 @@ unsigned int bt_gatt_client_register_notify(struct bt=
_gatt_client *client,
>                                 bt_gatt_client_destroy_func_t destroy);
>  bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
>                                                         unsigned int id);
> +bool bt_gatt_client_set_notify_prefer_indicate(struct bt_gatt_client *cl=
ient,
> +                                               uint16_t value_handle,
> +                                               bool prefer);
>
>  bool bt_gatt_client_set_security(struct bt_gatt_client *client, int leve=
l);
>  int bt_gatt_client_get_security(struct bt_gatt_client *client);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz

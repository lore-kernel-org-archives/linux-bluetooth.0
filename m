Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CA3624CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052013; cv=none; b=mYG5Z7HbzEan4ydDamA0+VCG2+Xbq/To7g6b/4SEfUkc9NKFWZKoubI9eylTTdi6e2DxrSgIMcUAIeWBGcdhgNrSTusa/a89AWpoXxBCRBIiK84o+bEWxJkU+59dUt5bslHiL05gJXcRo/x/Cin56TUS0nL+1EZnAly3r5UfFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052013; c=relaxed/simple;
	bh=MoT63F523lZ3XcWwTYUI/frNRTNYjalqQyi9p3mV4yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwN6LvUiOxMs0u7Gcvsf8ay5Q2ohuV+OjABQIxf5yeSx0fpSG5NN7spHML+ly0rbeORh/npg9Od/Lw8yqgFOzRLtVFq3uWSIbo528ywH3o/SoBHpv9deUyDm3+MQITeP39kUAi+aXNs8bMg9MamDyKbxr53xhtr8/BrV/PWH/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUE5Rn3e; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUE5Rn3e"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so8271441fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052009; x=1763656809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLAGLaCugnCTN2oRwoHyf5ow2hdQsL+E/DRXxp/S13E=;
        b=aUE5Rn3epwG8+JlSbHKBLxVOhd7lyrYiexUOM2nEdQZ2P0pbFyO3TQkXfjifYC+Yn0
         SXFiODEu/Gt7UnRIx0rpfccUzuNP0jgxzz0AS58xzFBJejNl2zQBGPKEbUrskMTnqHUd
         D/sktnejolix5iX+ZZ3QhTFhZJJJ2WTeIuimOKjuy7+HKk8IWKltpLTkVcXzMlKfYyTs
         KWTDigd93nc2ozZ+fGZqwfnd3Mt9z/I5smbH60YvgK0/0K0ey7+fbFt0262NZarmyI7L
         t3c/Q7AXuxRfIxtyO4rkDXoAhGhSOEq0mrkpCC6wnnGSSR7jkGxBAyyfBhaG7mMrQ0jR
         6ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052009; x=1763656809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLAGLaCugnCTN2oRwoHyf5ow2hdQsL+E/DRXxp/S13E=;
        b=Lijg1UMTUhB5hfSFozBJxb5ZbanHTpyCMjK+JR87iqiEIj5jVntoV4PDCmMQjjsCXC
         4Fe1F4TqawegKlv2JtdVh8wKojWgvFPE+5VWRf/dH71yOBGQejlmVhDhm8yWr1xOjGU2
         4bxD1U3uAltJgkmOosj3A/D+A41L5pAMDxaovV/XlY5rYZl//SyjSbACbxQUiR/+2Q9w
         oqz0CUxjn69/gU/g508oDOHQrnuk6WBoeWpwyKZe6+xvChxqwvDbPFo0rS7InRJL6qR4
         RWalNneTVnlDHhTvggwiaeSwsMQ+Ij7N8j3IVHZQzbabGGCzohxrHn3tnt4WtePNl+29
         xQQg==
X-Gm-Message-State: AOJu0YzgfP13FaBzCMWwbLrhfcgz5tazgrFV5F8wnKhU1wtZ2H46OEex
	4mLGVitY8uBXC2xSBfN3iKm3dqMpOmjme/RFnOlSVZTfAtGWixlgjIY71wfy0ZCJ/D9/Ztr1rhU
	COnF4s3wncQELlFC15RrgqSiNc9qPgVjA2w==
X-Gm-Gg: ASbGnctdhhEagGMX2p/ZS34j7XnrYIxojhDMRr8/kSoQHxRu8IjhFMZHoWDde+ROca0
	DPfHgKnCPyFfFlkDH93OWQHYQHponjJ0Pm1CgqTmnrVNK0TXT3QycOG3bzd5xloGZHSlXvU/ESn
	akXR++mYNK4cjb/0OXQZRdjdbPknBFzDVJt3q0eJ9zqo+bAEbVV9/hZk3GYJ7gqLQVVVPkshooD
	TEHe4/bq5aKEEKCbiHbsQNDkwUDPb1rwRYw003zvjVCP7zOL8hT5D6O2fFLcO8+OFtG8A==
X-Google-Smtp-Source: AGHT+IFPNvHYdmFA4qWeNPmN89nrXTJ+/AfRMGXUdnwXlK3Axu1u+RgyVjzqmIBzAJqfTpJL2IUkJzUlQxmyUoocx24=
X-Received: by 2002:a2e:9550:0:b0:37a:4c29:3aa1 with SMTP id
 38308e7fff4ca-37b8c39f960mr17375491fa.38.1763052009026; Thu, 13 Nov 2025
 08:40:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com>
In-Reply-To: <20251113-bearer-impl-v2-1-c3e825cc6758@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Nov 2025 11:39:56 -0500
X-Gm-Features: AWmQ_blAhjWlI3iOJlMH4C3Ke6HusFIvkoni1_n28iwINwb7DM5Wq_jX_bAL6Pk
Message-ID: <CABBYNZKgJEMviz6ffcs9K2kbqZK9fS3r81R5vT6xs_4LNjuC5g@mail.gmail.com>
Subject: Re: [PATCH bluez v2] bearer: Implement Connect/Disconnect methods
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 12, 2025 at 10:43=E2=80=AFPM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch provides implementations for the Connect and Disconnect
> methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
> interfaces.
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> Changes in v2:
> - Fix build error & warning.
> - Link to v1: https://patch.msgid.link/20251111-bearer-impl-v1-1-f4158514=
4218@amlogic.com
> ---
>  src/bearer.c |  57 ++++++++++++-
>  src/device.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++++-----=
------
>  src/device.h |   4 +
>  3 files changed, 280 insertions(+), 52 deletions(-)
>
> diff --git a/src/bearer.c b/src/bearer.c
> index 9723b59e2e7b39b2974e258363aa0ace95862651..c18d134e5783108ce048e3f52=
f17da835387b245 100644
> --- a/src/bearer.c
> +++ b/src/bearer.c
> @@ -40,6 +40,8 @@ struct btd_bearer {
>         struct btd_device *device;
>         uint8_t type;
>         const char *path;
> +       GSList *disconnects; /* disconnects message */
> +       GSList *connects; /* connects message */

Use struct queue for storing the connect/disconnect requests.

>  };
>
>  static void bearer_free(void *data)
> @@ -52,14 +54,46 @@ static void bearer_free(void *data)
>  static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *ms=
g,
>                                                         void *user_data)
>  {
> -       /* TODO */
> +       struct btd_bearer *bearer =3D user_data;
> +
> +       if (btd_device_bdaddr_type_connected(bearer->device, bearer->type=
)) {
> +               if (msg)
> +                       return btd_error_already_connected(msg);
> +               return NULL;
> +       }
> +
> +       if (bearer->connects) {
> +               if (msg)
> +                       return btd_error_in_progress(msg);
> +               return NULL;
> +       }
> +
> +       if (msg)
> +               bearer->connects =3D g_slist_append(bearer->connects,
> +                                               dbus_message_ref(msg));
> +
> +       device_request_connect_bearer(bearer->device, bearer->type, msg);
> +
>         return NULL;
>  }
>
>  static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage =
*msg,
>                                                         void *user_data)
>  {
> -       /* TODO */
> +       struct btd_bearer *bearer =3D user_data;
> +
> +       if (!btd_device_bdaddr_type_connected(bearer->device, bearer->typ=
e)) {
> +               if (msg)
> +                       return btd_error_not_connected(msg);
> +               return NULL;
> +       }
> +
> +       if (msg)
> +               bearer->disconnects =3D g_slist_append(bearer->disconnect=
s,
> +                                               dbus_message_ref(msg));
> +
> +       device_request_disconnect_bearer(bearer->device, bearer->type, ms=
g);
> +
>         return NULL;
>  }
>
> @@ -200,9 +234,19 @@ void btd_bearer_bonded(struct btd_bearer *bearer)
>
>  void btd_bearer_connected(struct btd_bearer *bearer)
>  {
> +       DBusMessage *msg;
> +
>         if (!bearer || !bearer->path)
>                 return;
>
> +       while (bearer->connects) {
> +               msg =3D bearer->connects->data;
> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
> +                                               DBUS_TYPE_INVALID);
> +               bearer->connects =3D g_slist_remove(bearer->connects, msg=
);
> +               dbus_message_unref(msg);
> +       }
> +
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->p=
ath,
>                                         bearer_interface(bearer->type),
>                                         "Connected");
> @@ -212,10 +256,19 @@ void btd_bearer_disconnected(struct btd_bearer *bea=
rer, uint8_t reason)
>  {
>         const char *name;
>         const char *message;
> +       DBusMessage *msg;
>
>         if (!bearer || !bearer->path)
>                 return;
>
> +       while (bearer->disconnects) {
> +               msg =3D bearer->disconnects->data;
> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
> +                                               DBUS_TYPE_INVALID);
> +               bearer->disconnects =3D g_slist_remove(bearer->disconnect=
s, msg);
> +               dbus_message_unref(msg);
> +       }
> +
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->p=
ath,
>                                         bearer_interface(bearer->type),
>                                         "Connected");
> diff --git a/src/device.c b/src/device.c
> index 91b6cc0c65eaae8058cd445c0942ffee57289f0d..b05c508674f194c3c6b0cef96=
f6ac3bc6a300d9a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -250,7 +250,8 @@ struct btd_device {
>         bool            temporary;
>         bool            connectable;
>         bool            cable_pairing;
> -       unsigned int    disconn_timer;
> +       unsigned int    disconn_bredr_timer;
> +       unsigned int    disconn_le_timer;
>         unsigned int    discov_timer;
>         unsigned int    temporary_timer;        /* Temporary/disappear ti=
mer */
>         struct browse_req *browse;              /* service discover reque=
st */
> @@ -315,8 +316,13 @@ static const uint16_t uuid_list[] =3D {
>         0
>  };
>
> +static bool disconnect_le(gpointer user_data);
> +static bool disconnect_bredr(gpointer user_data);
>  static int device_browse_gatt(struct btd_device *device, DBusMessage *ms=
g);
>  static int device_browse_sdp(struct btd_device *device, DBusMessage *msg=
);
> +static void device_set_auto_connect(struct btd_device *device, gboolean =
enable);
> +static DBusMessage *connect_profiles(struct btd_device *dev,
> +                       uint8_t bdaddr_type, DBusMessage *msg, const char=
 *uuid);
>
>  static struct bearer_state *get_state(struct btd_device *dev,
>                                                         uint8_t bdaddr_ty=
pe)
> @@ -922,8 +928,11 @@ static void device_free(gpointer user_data)
>                 sdp_list_free(device->tmp_records,
>                                         (sdp_free_func_t) sdp_record_free=
);
>
> -       if (device->disconn_timer)
> -               timeout_remove(device->disconn_timer);
> +       if (device->disconn_bredr_timer)
> +               timeout_remove(device->disconn_bredr_timer);
> +
> +       if (device->disconn_le_timer)
> +               timeout_remove(device->disconn_le_timer);
>
>         if (device->discov_timer)
>                 timeout_remove(device->discov_timer);
> @@ -1903,23 +1912,6 @@ static gboolean dev_property_set_exists(const GDBu=
sPropertyTable *property,
>         return !queue_isempty(device->sirks);
>  }
>
> -static bool disconnect_all(gpointer user_data)
> -{
> -       struct btd_device *device =3D user_data;
> -
> -       device->disconn_timer =3D 0;
> -
> -       if (device->bredr_state.connected)
> -               btd_adapter_disconnect_device(device->adapter, &device->b=
daddr,
> -                                                               BDADDR_BR=
EDR);
> -
> -       if (device->le_state.connected)
> -               btd_adapter_disconnect_device(device->adapter, &device->b=
daddr,
> -                                                       device->bdaddr_ty=
pe);
> -
> -       return FALSE;
> -}
> -
>  int device_block(struct btd_device *device, gboolean update_only)
>  {
>         int err =3D 0;
> @@ -1927,10 +1919,15 @@ int device_block(struct btd_device *device, gbool=
ean update_only)
>         if (device->blocked)
>                 return 0;
>
> -       if (device->disconn_timer > 0)
> -               timeout_remove(device->disconn_timer);
> +       if (device->disconn_le_timer > 0)
> +               timeout_remove(device->disconn_le_timer);
> +
> +       if (device->disconn_bredr_timer > 0)
> +               timeout_remove(device->disconn_bredr_timer);
> +
> +       disconnect_bredr(device);
>
> -       disconnect_all(device);
> +       disconnect_le(device);
>
>         while (device->services !=3D NULL) {
>                 struct btd_service *service =3D device->services->data;
> @@ -2022,6 +2019,28 @@ static void dev_disconn_service(gpointer a, gpoint=
er b)
>         btd_service_disconnect(a);
>  }
>
> +static void dev_disconnect_watches_notify(struct btd_device *device)
> +{
> +       if (!device || !device->watches)
> +               return;
> +
> +       while (device->watches) {
> +               struct btd_disconnect_data *data =3D device->watches->dat=
a;
> +
> +               if (data->watch)
> +                       /* temporary is set if device is going to be remo=
ved */
> +                       data->watch(device, device->temporary,
> +                                                       data->user_data);
> +
> +               /* Check if the watch has been removed by callback functi=
on */
> +               if (!g_slist_find(device->watches, data))
> +                       continue;
> +
> +               device->watches =3D g_slist_remove(device->watches, data)=
;
> +               g_free(data);
> +       }
> +}
> +
>  void device_request_disconnect(struct btd_device *device, DBusMessage *m=
sg)
>  {
>         if (device->bonding)
> @@ -2055,7 +2074,7 @@ void device_request_disconnect(struct btd_device *d=
evice, DBusMessage *msg)
>                 device->disconnects =3D g_slist_append(device->disconnect=
s,
>                                                 dbus_message_ref(msg));
>
> -       if (device->disconn_timer)
> +       if (device->disconn_bredr_timer && device->disconn_le_timer)
>                 return;
>
>         g_slist_foreach(device->services, dev_disconn_service, NULL);
> @@ -2063,21 +2082,7 @@ void device_request_disconnect(struct btd_device *=
device, DBusMessage *msg)
>         g_slist_free(device->pending);
>         device->pending =3D NULL;
>
> -       while (device->watches) {
> -               struct btd_disconnect_data *data =3D device->watches->dat=
a;
> -
> -               if (data->watch)
> -                       /* temporary is set if device is going to be remo=
ved */
> -                       data->watch(device, device->temporary,
> -                                                       data->user_data);
> -
> -               /* Check if the watch has been removed by callback functi=
on */
> -               if (!g_slist_find(device->watches, data))
> -                       continue;
> -
> -               device->watches =3D g_slist_remove(device->watches, data)=
;
> -               g_free(data);
> -       }
> +       dev_disconnect_watches_notify(device);
>
>         if (!btd_device_is_connected(device)) {
>                 if (msg)
> @@ -2085,14 +2090,166 @@ void device_request_disconnect(struct btd_device=
 *device, DBusMessage *msg)
>                 return;
>         }
>
> -       device->disconn_timer =3D timeout_add_seconds(DISCONNECT_TIMER,
> -                                                       disconnect_all,
> +       if (!device->disconn_bredr_timer)
> +               device->disconn_bredr_timer =3D timeout_add_seconds(
> +                                                       DISCONNECT_TIMER,
> +                                                       disconnect_bredr,
> +                                                       device, NULL);
> +
> +       if (!device->disconn_le_timer)
> +               device->disconn_le_timer =3D timeout_add_seconds(
> +                                                       DISCONNECT_TIMER,
> +                                                       disconnect_le,
>                                                         device, NULL);
>  }
>
>  bool device_is_disconnecting(struct btd_device *device)
>  {
> -       return device->disconn_timer > 0;
> +       return (device->disconn_le_timer > 0) ||
> +                               (device->disconn_bredr_timer > 0);
> +}
> +
> +static void dev_disconn_bearer_service(gpointer a, gpointer b)
> +{
> +       struct btd_service *service =3D a;
> +       uint8_t type =3D *(uint8_t *)b;
> +       struct btd_profile *profile;
> +       bt_uuid_t uuid;
> +
> +       profile =3D btd_service_get_profile(service);
> +       if (!profile)
> +               return;
> +
> +       if (!profile->remote_uuid)
> +               return;
> +
> +       if (bt_string_to_uuid(&uuid, profile->remote_uuid) !=3D 0)
> +               return;
> +
> +       switch (type) {
> +       case BDADDR_BREDR:
> +               if (uuid.value.u16 < 0x1100 || uuid.value.u16 > 0x11FF)
> +                       return;
> +               break;
> +       case BDADDR_LE_PUBLIC:
> +       case BDADDR_LE_RANDOM:
> +               if (uuid.value.u16 < 0x1800 || uuid.value.u16 > 0x18FF)
> +                       return;
> +               break;
> +       default:
> +               DBG("Unsupported bearer addr type: %u", type);
> +               return;
> +       }
> +
> +       DBG("Disconnecting profile %s (UUID 0x%04x) for bearer addr type =
%u",
> +           profile->name ?: "(unknown)", uuid.value.u16, type);
> +
> +       btd_service_disconnect(service);
> +}
> +
> +static bool disconnect_bredr(gpointer user_data)
> +{
> +       struct btd_device *device =3D user_data;
> +
> +       device->disconn_bredr_timer =3D 0;
> +
> +       if (device->bredr_state.connected)
> +               btd_adapter_disconnect_device(device->adapter, &device->b=
daddr,
> +                                                               BDADDR_BR=
EDR);
> +
> +       return FALSE;
> +}
> +
> +static bool disconnect_le(gpointer user_data)
> +{
> +       struct btd_device *device =3D user_data;
> +
> +       device->disconn_le_timer =3D 0;
> +
> +       if (device->le_state.connected)
> +               btd_adapter_disconnect_device(device->adapter, &device->b=
daddr,
> +                                                       device->bdaddr_ty=
pe);
> +
> +       return FALSE;
> +}
> +
> +void device_request_disconnect_bearer(struct btd_device *device,
> +                               uint8_t bdaddr_type, DBusMessage *msg)
> +{
> +       if (device->bonding)
> +               bonding_request_cancel(device->bonding);
> +
> +       if (device->browse) {
> +               if ((device->browse->type =3D=3D BROWSE_SDP &&
> +                       bdaddr_type =3D=3D BDADDR_BREDR) ||
> +                       (device->browse->type =3D=3D BROWSE_GATT &&
> +                       bdaddr_type !=3D BDADDR_BREDR))
> +                       browse_request_cancel(device->browse);
> +       }
> +
> +       g_slist_foreach(device->services, dev_disconn_bearer_service,
> +                                       &bdaddr_type);
> +
> +       dev_disconnect_watches_notify(device);
> +
> +       if (bdaddr_type =3D=3D BDADDR_BREDR) {
> +               g_slist_free(device->pending);
> +               device->pending =3D NULL;
> +
> +               if (device->disconn_bredr_timer)
> +                       return;
> +
> +               device->disconn_bredr_timer =3D timeout_add_seconds(
> +                                                       DISCONNECT_TIMER,
> +                                                       disconnect_bredr,
> +                                                       device, NULL);
> +       } else {
> +               if (device->att_io) {
> +                       g_io_channel_shutdown(device->att_io, FALSE, NULL=
);
> +                       g_io_channel_unref(device->att_io);
> +                       device->att_io =3D NULL;
> +               }
> +
> +               if (device->disconn_le_timer)
> +                       return;
> +
> +               device->disconn_le_timer =3D timeout_add_seconds(
> +                                                       DISCONNECT_TIMER,
> +                                                       disconnect_le,
> +                                                       device, NULL);
> +       }
> +}
> +
> +void device_request_connect_bearer(struct btd_device *device,
> +                               uint8_t bdaddr_type, DBusMessage *msg)
> +{
> +       int err;
> +
> +       if (device->bonding) {
> +               g_dbus_send_message(dbus_conn, btd_error_in_progress(msg)=
);
> +               return;
> +       }
> +
> +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> +               connect_profiles(device, bdaddr_type, msg, NULL);
> +       else {
> +               if (device->le_state.connected) {
> +                       dbus_message_new_method_return(msg);
> +                       return;
> +               }
> +
> +               btd_device_set_temporary(device, false);
> +
> +               if (device->disable_auto_connect) {
> +                       device->disable_auto_connect =3D FALSE;
> +                       device_set_auto_connect(device, TRUE);
> +               }
> +
> +               err =3D device_connect_le(device);
> +               if (err < 0)
> +                       g_dbus_send_message(dbus_conn,
> +                               btd_error_failed(msg, strerror(-err)));
> +       }
>  }
>
>  static void add_set(void *data, void *user_data)
> @@ -3880,17 +4037,24 @@ void device_remove_connection(struct btd_device *=
device, uint8_t bdaddr_type,
>         if (!state->connected)
>                 return;
>
> +       if (bdaddr_type =3D=3D BDADDR_BREDR) {
> +               if (device->disconn_bredr_timer > 0) {
> +                       timeout_remove(device->disconn_bredr_timer);
> +                       device->disconn_bredr_timer =3D 0;
> +               }
> +       } else {
> +               if (device->disconn_le_timer > 0) {
> +                       timeout_remove(device->disconn_le_timer);
> +                       device->disconn_le_timer =3D 0;
> +               }
> +       }
> +
>         state->connected =3D false;
>         state->initiator =3D false;
>         device->general_connect =3D FALSE;
>
>         device_set_svc_refreshed(device, false);
>
> -       if (device->disconn_timer > 0) {
> -               timeout_remove(device->disconn_timer);
> -               device->disconn_timer =3D 0;
> -       }
> -
>         /* This could be executed while the client is waiting for Connect=
() but
>          * att_connect_cb has not been invoked.
>          * In that case reply the client that the connection failed.
> @@ -5359,9 +5523,16 @@ void device_remove(struct btd_device *device, gboo=
lean remove_stored)
>         device->pending =3D NULL;
>
>         if (btd_device_is_connected(device)) {
> -               if (device->disconn_timer > 0)
> -                       timeout_remove(device->disconn_timer);
> -               disconnect_all(device);
> +               if (device->disconn_bredr_timer > 0) {
> +                       timeout_remove(device->disconn_bredr_timer);
> +                       device->disconn_bredr_timer =3D 0;
> +               }
> +               if (device->disconn_le_timer > 0) {
> +                       timeout_remove(device->disconn_le_timer);
> +                       device->disconn_le_timer =3D 0;
> +               }
> +               disconnect_bredr(device);
> +               disconnect_le(device);
>         }
>
>         clear_temporary_timer(device);
> diff --git a/src/device.h b/src/device.h
> index 6ed8affa0d4a9274d30cac9b48e8a6826edefd64..f756fbbd4abfda467a669a38a=
95ddbcf586d8ff6 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -141,6 +141,10 @@ void device_remove_connection(struct btd_device *dev=
ice, uint8_t bdaddr_type,
>                                                         uint8_t reason);
>  void device_request_disconnect(struct btd_device *device, DBusMessage *m=
sg);
>  bool device_is_disconnecting(struct btd_device *device);
> +void device_request_disconnect_bearer(struct btd_device *device,
> +                                       uint8_t bdaddr_type, DBusMessage =
*msg);
> +void device_request_connect_bearer(struct btd_device *device,
> +                                       uint8_t bdaddr_type, DBusMessage =
*msg);

I thinking in implementing this as part of bearer.c to minimize the
chance of affecting existing code and causing regression, we have
already struct btd_bearer that can be used to store timers, etc, what
perhaps we will need to do is to either make struct btd_device
definition available or have some helper functions to access the
necessary information, in either case the changes to device.c should
be as minimal as possible since that is already overloaded with so
many things I don't think adding another one really helps us in the
long run.

>  void device_set_ltk(struct btd_device *device, const uint8_t val[16],
>                                 bool central, uint8_t enc_size);
>  bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
>
> ---
> base-commit: 5e41d1e1d361e7288964e4c2c5ed90736025662f
> change-id: 20251111-bearer-impl-5f7e396174aa
>
> Best regards,
> --
> Ye He <ye.he@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz

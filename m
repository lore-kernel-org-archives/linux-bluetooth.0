Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F70331A69
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475262; cv=none; b=Soy23/WRu/k80dI9pENayFDm41AB91wlZvu944dbT+vKYrtGo8ppteJBXUfbg9hSWYlZOpobqC3Zw2eq2mDhdDQMSncWxXtKs7RZBZjXfw8Z2AUxa6MLNafz26ruhpbvpur2mO0AII37DgnpSzuh1CoCHE+iVNJ7dKGrOKgdPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475262; c=relaxed/simple;
	bh=ukXv1ice+mGTlmpfm02r/+jOVuv5WEb52HyrXO9S05Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWoPOAo2gBwlzD14tOJ90E9aBG+XXYubmKUqkgEyWvnBZemWeS/AujOVWqdQO27CNSjs0ost0kaRcbfsTaPZGFlcNB65MbjJ3P5IYVRRfI9QCnJ9Bzyz8nzepRk0rpge5K+WlbI6mhwrj7Dg5e+thGXMP/k6L003L0PzOmvSeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUgDWc11; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUgDWc11"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37ba781a6c3so41376411fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 06:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475258; x=1764080058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P84uEOt1Gnc69BxFoA9dodxSvTUTTlXm1z1HBlNPdTc=;
        b=FUgDWc113kLPe2ZxbQBOSkmuQHixvptnWX6KsejOLtP6KNAXlNcSAnDshWwcTFYCjn
         Dmf+XAkYgHITLd1NFNOMqFEg1CURPkyoY0vwStzht8rlp3okfOmK4pX3Kj5lfE5NW8Yn
         UbYG0FqeOfKiAXjhUzTRS4DYjMtP6JwVn3oyejCKjw643gZiNkWtS+29Jh+V3brXeLU1
         yeavQmPYKFq67MZTgN9QM7IZm9fzvv8448WGx9FBJ+5AUsFobWOSIi2jNhSRn28rLZ1J
         WAwX9c62j+j501M/MpnKdzetK7j17OlXsGCJHRxN/EiSZXiQxuHalpj2hjq54g01FkkV
         xgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475258; x=1764080058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P84uEOt1Gnc69BxFoA9dodxSvTUTTlXm1z1HBlNPdTc=;
        b=n6YjRsSNCCRCE+GvrQkCXCn6fljEr79HCnODAVoGbXGVd8S7L36SpTZA+7ubfTztmA
         FVp2mJNse8I1TtN/NYGHV0ROSsy7C1uH5fVz71nEaeGGVwH/hDkgPXmDtb5TGmAy5rK7
         bGK+eRobbdLAb0BKeD8ebj7eEd2ExOtQoes5k9UdwjWYv/6BkB7xuxvcLXnbi7iCO/LW
         eDpOCAINDoHGBTBaLFVhUEML4umB70t769XNWL0SZQhTe+GoyUho8XNMT87ZBGhFpiUu
         nKThPkmF4JZOGPhvf0hm5k5OJiNMyd/5pfxX3zorcUZ/9TaX9Jls7/Kf/Pr5hBtjZD08
         ss4g==
X-Gm-Message-State: AOJu0Yw/oMuNJg1SAxtrJseBsv/iGkhcpmRcPLl5nObJiARhq8de95GA
	tckSjTBaFYWOiEL808sPRaID9ibYQhtad79M2rzJNSQHEkR3RoIu/mjLc76T8QRuDKxOA7AU5/B
	P7fudVfYx8QjeSXeELB2t6oGX6fYSF0nP0PKj
X-Gm-Gg: ASbGncsPslNnOFqjSmcerUJKOkuQjGN+bqikWSbCzTMb+jc5DBMCl8JTGHmJL8qYPh4
	8leKWu22jyyR0w07wGoU1MsDaQ1nIcHS6suyB9XUChD1CuW23WEJuTlpgNGCqoq5fwDQZBmB8Ed
	yPkjNYt2XNFc3cOxwP5AiolWMxGx/Ytqwk1yNJsVapSKj9qtzTG+UYB2FJPjVFWwkK+QiNMYt13
	Wak447dk1NgeWC03bCYZqCrUvbeqVb/S8SZAx6U5nJQdotFT2uTcodEMqSjLywUfVySNw==
X-Google-Smtp-Source: AGHT+IEAegYaomfPCXK+msaxFsYsanOVA1MKWRY+2jUyW5bPgZsBqX5GSS6n58CTu3xXIA7BBp9e0rCgOcRzQgW0saQ=
X-Received: by 2002:a05:651c:31d6:b0:378:e88e:70b7 with SMTP id
 38308e7fff4ca-37babb4ea00mr44499481fa.8.1763475257505; Tue, 18 Nov 2025
 06:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com>
In-Reply-To: <20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Nov 2025 09:14:05 -0500
X-Gm-Features: AWmQ_blEPKAYzRhkuUJdkkxE5O3ZzFkoFSC4MKGskCpdehh8oOPpM29HT1hyB-8
Message-ID: <CABBYNZKZ-Y2PqH620t0Tyr9sygoKikeyjdKTVOjV+7LDNxPRgQ@mail.gmail.com>
Subject: Re: [PATCH bluez v3] bearer: Implement Connect/Disconnect methods
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 18, 2025 at 4:32=E2=80=AFAM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch provides implementations for the Connect and Disconnect
> methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
> interfaces.

Ok, we will need some coverage in bluetoothctl in order to exercise this AP=
I.

> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> Changes in v3:
> - Move the modification logic from the device to bearer, and add
> - some helper functions to the device.
> - Link to v2: https://patch.msgid.link/20251113-bearer-impl-v2-1-c3e825cc=
6758@amlogic.com
>
> Changes in v2:
> - Fix build error & warning.
> - Link to v1: https://patch.msgid.link/20251111-bearer-impl-v1-1-f4158514=
4218@amlogic.com
> ---
>  src/bearer.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  src/device.c | 130 ++++++++++++++++++++++++++++++++++++++++--------
>  src/device.h |  17 +++++++
>  3 files changed, 285 insertions(+), 22 deletions(-)
>
> diff --git a/src/bearer.c b/src/bearer.c
> index 9723b59e2e7b39b2974e258363aa0ace95862651..46e272b16096740ce28bcc80d=
0e2426df8538a2e 100644
> --- a/src/bearer.c
> +++ b/src/bearer.c
> @@ -25,23 +25,38 @@
>
>  #include "bluetooth/bluetooth.h"
>  #include "bluetooth/mgmt.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>  #include "src/shared/util.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/timeout.h"
>
>  #include "log.h"
>  #include "error.h"
>  #include "adapter.h"
>  #include "device.h"
> +#include "profile.h"
> +#include "service.h"
>  #include "dbus-common.h"
>  #include "bearer.h"
>
> +#define DISCONNECT_TIMER       2
> +
>  struct btd_bearer {
>         struct btd_device *device;
>         uint8_t type;
>         const char *path;
> +       unsigned int disconn_timer;
> +       struct queue *disconnects; /* disconnects message */
> +       DBusMessage *connect; /* connect message */

This doesn't sound quite right, why don't we queue connect messages?

>  };
>
> +static void bearer_free_dbus_message(void *data)
> +{
> +    dbus_message_unref((DBusMessage *)data);
> +}
> +
>  static void bearer_free(void *data)
>  {
>         struct btd_bearer *bearer =3D data;
> @@ -49,17 +64,126 @@ static void bearer_free(void *data)
>         free(bearer);
>  }
>
> +static void bearer_disconnect_service(struct btd_service *service, void =
*user_data)
> +{
> +       uint8_t bdaddr_type =3D *(uint8_t *)user_data;
> +       struct btd_profile *profile;
> +       bt_uuid_t uuid;
> +
> +       profile =3D btd_service_get_profile(service);
> +       if (!profile || !profile->remote_uuid)
> +               return;
> +
> +       if (bt_string_to_uuid(&uuid, profile->remote_uuid) !=3D 0)
> +               return;
> +
> +       if (bdaddr_type =3D=3D BDADDR_BREDR) {
> +               if (uuid.value.u16 < 0x1100 || uuid.value.u16 > 0x11FF)
> +                       return;
> +       } else {
> +               if (uuid.value.u16 < 0x1800 || uuid.value.u16 > 0x18FF)
> +                       return;
> +       }

What are these ranges above?

> +
> +       DBG("Disconnecting profile %s (UUID 0x%04x) for bearer addr type =
%u",
> +       profile->name ?: "(unknown)", uuid.value.u16, bdaddr_type);
> +
> +       btd_service_disconnect(service);
> +}
> +
> +static bool bearer_disconnect_link(gpointer user_data)
> +{
> +       struct btd_bearer *bearer =3D user_data;
> +       struct btd_device *device =3D bearer->device;
> +
> +       bearer->disconn_timer =3D 0;
> +
> +       if (btd_device_bdaddr_type_connected(device, bearer->type))
> +               btd_adapter_disconnect_device(device_get_adapter(device),
> +                                               device_get_address(device=
),
> +                                               bearer->type);
> +       return FALSE;
> +}
> +
>  static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *ms=
g,
>                                                         void *user_data)
>  {
> -       /* TODO */
> +       struct btd_bearer *bearer =3D user_data;
> +       struct btd_device *device =3D bearer->device;
> +       int err;
> +
> +       if (btd_device_bdaddr_type_connected(device, bearer->type)) {
> +               if (msg)
> +                       return btd_error_already_connected(msg);
> +               return NULL;
> +       }
> +
> +       if (device_is_bonding(device, NULL)) {
> +               if (msg)
> +                       return btd_error_in_progress(msg);
> +               return NULL;
> +       }
> +
> +       if (device_is_connecting(device) ||
> +               bearer->connect) {
> +               if (msg)
> +                       return btd_error_in_progress(msg);
> +               return NULL;
> +       }
> +
> +       if (msg)
> +               bearer->connect =3D dbus_message_ref(msg);
> +
> +       if (bearer->type =3D=3D BDADDR_BREDR)
> +               return device_connect_profiles(device, BDADDR_BREDR,
> +                                                               msg, NULL=
);
> +       else {
> +               btd_device_set_temporary(device, false);
> +               err =3D device_connect_le(device);
> +               if (err < 0)
> +                       return btd_error_failed(msg, strerror(-err));
> +       }
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
> +       struct btd_device *device =3D bearer->device;
> +
> +       if (!btd_device_bdaddr_type_connected(device, bearer->type)) {
> +               if (msg)
> +                       return btd_error_not_connected(msg);
> +               return NULL;
> +       }
> +
> +       if (device_is_disconnecting(device)) {
> +               if (msg)
> +                       return btd_error_in_progress(msg);
> +               return NULL;
> +       }
> +
> +       if (msg)
> +               queue_push_tail(bearer->disconnects, dbus_message_ref(msg=
));

This also makes no sense, if you are going to queue the disconnect
message why are you sending in progress error if it is already
disconnecting?

> +       device_cancel_bonding(device, MGMT_STATUS_DISCONNECTED);
> +
> +       device_cancel_browse(device, bearer->type);
> +
> +       btd_device_foreach_service(device, bearer_disconnect_service,
> +                                                       &bearer->type);
> +
> +       device_remove_pending_services(device, bearer->type);
> +
> +       if (bearer->disconn_timer)
> +               return NULL;
> +
> +       bearer->disconn_timer =3D timeout_add_seconds(DISCONNECT_TIMER,
> +                                                       bearer_disconnect=
_link,
> +                                                       bearer, NULL);
> +
>         return NULL;
>  }
>
> @@ -151,6 +275,7 @@ struct btd_bearer *btd_bearer_new(struct btd_device *=
device, uint8_t type)
>         bearer->device =3D device;
>         bearer->type =3D type;
>         bearer->path =3D device_get_path(device);
> +       bearer->disconnects =3D queue_new();
>
>         if (!g_dbus_register_interface(btd_get_dbus_connection(),
>                                         bearer->path, bearer_interface(ty=
pe),
> @@ -174,6 +299,16 @@ void btd_bearer_destroy(struct btd_bearer *bearer)
>                 return;
>         }
>
> +       if (bearer->disconnects) {
> +               queue_destroy(bearer->disconnects, bearer_free_dbus_messa=
ge);
> +               bearer->disconnects =3D NULL;
> +       }
> +
> +       if (bearer->connect) {
> +               dbus_message_unref(bearer->connect);
> +               bearer->connect =3D NULL;
> +       }
> +
>         g_dbus_unregister_interface(btd_get_dbus_connection(), bearer->pa=
th,
>                                         bearer_interface(bearer->type));
>  }
> @@ -203,6 +338,13 @@ void btd_bearer_connected(struct btd_bearer *bearer)
>         if (!bearer || !bearer->path)
>                 return;
>
> +       if (bearer->connect) {
> +               g_dbus_send_reply(btd_get_dbus_connection(), bearer->conn=
ect,
> +                                               DBUS_TYPE_INVALID);
> +               dbus_message_unref(bearer->connect);
> +               bearer->connect =3D NULL;
> +       }
> +
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->p=
ath,
>                                         bearer_interface(bearer->type),
>                                         "Connected");
> @@ -212,10 +354,24 @@ void btd_bearer_disconnected(struct btd_bearer *bea=
rer, uint8_t reason)
>  {
>         const char *name;
>         const char *message;
> +       DBusMessage *msg;
> +       const struct queue_entry *entry;
>
>         if (!bearer || !bearer->path)
>                 return;
>
> +       if (!btd_device_is_connected(bearer->device))
> +               device_disconnect_watches_callback(bearer->device);
> +
> +       while (!queue_isempty(bearer->disconnects)) {
> +               entry =3D queue_get_entries(bearer->disconnects);
> +               msg =3D entry->data;
> +               g_dbus_send_reply(btd_get_dbus_connection(), msg,
> +                                               DBUS_TYPE_INVALID);
> +               queue_remove(bearer->disconnects, msg);
> +               dbus_message_unref(msg);
> +       }
> +
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), bearer->p=
ath,
>                                         bearer_interface(bearer->type),
>                                         "Connected");
> diff --git a/src/device.c b/src/device.c
> index 91b6cc0c65eaae8058cd445c0942ffee57289f0d..918f1e51acd3a9cd6b776cc08=
0c198885511fb20 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2022,6 +2022,28 @@ static void dev_disconn_service(gpointer a, gpoint=
er b)
>         btd_service_disconnect(a);
>  }
>
> +void device_disconnect_watches_callback(struct btd_device *device)
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
> @@ -2063,21 +2085,7 @@ void device_request_disconnect(struct btd_device *=
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
> +       device_disconnect_watches_callback(device);
>
>         if (!btd_device_is_connected(device)) {
>                 if (msg)
> @@ -2095,6 +2103,11 @@ bool device_is_disconnecting(struct btd_device *de=
vice)
>         return device->disconn_timer > 0;
>  }
>
> +bool device_is_connecting(struct btd_device *device)
> +{
> +       return device->connect !=3D NULL;
> +}
> +
>  static void add_set(void *data, void *user_data)
>  {
>         struct sirk_info *sirk =3D data;
> @@ -2712,8 +2725,8 @@ int btd_device_connect_services(struct btd_device *=
dev, GSList *services)
>         return connect_next(dev);
>  }
>
> -static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bda=
ddr_type,
> -                                       DBusMessage *msg, const char *uui=
d)
> +DBusMessage *device_connect_profiles(struct btd_device *dev,
> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid)
>  {
>         struct bearer_state *state =3D get_state(dev, bdaddr_type);
>         int err;
> @@ -2826,7 +2839,7 @@ static DBusMessage *dev_connect(DBusConnection *con=
n, DBusMessage *msg,
>                 return NULL;
>         }
>
> -       return connect_profiles(dev, bdaddr_type, msg, NULL);
> +       return device_connect_profiles(dev, bdaddr_type, msg, NULL);
>  }
>
>  static DBusMessage *connect_profile(DBusConnection *conn, DBusMessage *m=
sg,
> @@ -2848,7 +2861,7 @@ static DBusMessage *connect_profile(DBusConnection =
*conn, DBusMessage *msg,
>                 return btd_error_invalid_args_str(msg,
>                                         ERR_BREDR_CONN_INVALID_ARGUMENTS)=
;
>
> -       reply =3D connect_profiles(dev, BDADDR_BREDR, msg, uuid);
> +       reply =3D device_connect_profiles(dev, BDADDR_BREDR, msg, uuid);
>         free(uuid);
>
>         return reply;
> @@ -3421,7 +3434,7 @@ static DBusMessage *new_authentication_return(DBusM=
essage *msg, uint8_t status)
>         }
>  }
>
> -static void device_cancel_bonding(struct btd_device *device, uint8_t sta=
tus)
> +void device_cancel_bonding(struct btd_device *device, uint8_t status)
>  {
>         struct bonding_req *bonding =3D device->bonding;
>         DBusMessage *reply;
> @@ -6629,6 +6642,38 @@ static int device_browse_sdp(struct btd_device *de=
vice, DBusMessage *msg)
>         return err;
>  }
>
> +static gboolean device_is_browsing(struct btd_device *device, uint8_t bd=
addr_type)
> +{
> +       if (!device->browse)
> +               return FALSE;
> +
> +       if (bdaddr_type =3D=3D BDADDR_BREDR && device->browse->type =3D=
=3D BROWSE_SDP)
> +               return TRUE;
> +
> +       if (bdaddr_type !=3D BDADDR_BREDR && device->browse->type =3D=3D =
BROWSE_GATT)
> +               return TRUE;
> +
> +       return FALSE;
> +}
> +
> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type=
)
> +{
> +       struct btd_adapter *adapter =3D device->adapter;
> +
> +       DBG("");
> +
> +       if (!device_is_browsing(device, bdaddr_type))
> +               return;
> +
> +       if (bdaddr_type =3D=3D BDADDR_BREDR)
> +               bt_cancel_discovery(btd_adapter_get_address(adapter),
> +                                                       &device->bdaddr);
> +       else
> +               attio_cleanup(device);
> +
> +       browse_request_free(device->browse);
> +}
> +
>  int device_discover_services(struct btd_device *device)
>  {
>         int err;
> @@ -8088,3 +8133,48 @@ void btd_device_foreach_service_data(struct btd_de=
vice *dev, bt_ad_func_t func,
>  {
>         bt_ad_foreach_service_data(dev->ad, func, data);
>  }
> +
> +
> +void btd_device_foreach_service(struct btd_device *dev,
> +                               btd_device_service_func_t func,
> +                               void *user_data)
> +{
> +       GSList *l;
> +
> +       for (l =3D dev->services; l; l =3D l->next)
> +               func(l->data, user_data);
> +}
> +
> +void device_remove_pending_services(struct btd_device *dev,
> +                                       uint8_t bdaddr_type)
> +{
> +       GSList *l =3D dev->pending;
> +       GSList *next;
> +       struct btd_service *service;
> +       struct btd_profile *profile;
> +       bt_uuid_t uuid;
> +       bool match =3D false;
> +
> +       while (l) {
> +               next =3D l->next;
> +               service =3D l->data;
> +
> +               profile =3D btd_service_get_profile(service);
> +               if (profile && profile->remote_uuid &&
> +                       bt_string_to_uuid(&uuid, profile->remote_uuid) =
=3D=3D 0) {
> +
> +                       if (bdaddr_type =3D=3D BDADDR_BREDR)
> +                               match =3D uuid.value.u16 >=3D 0x1100 ||
> +                                       uuid.value.u16 <=3D 0x11FF;
> +                       else
> +                               match =3D uuid.value.u16 >=3D 0x1800 ||
> +                                       uuid.value.u16 <=3D 0x18FF;
> +
> +                       if (match)
> +                               dev->pending =3D g_slist_remove(dev->pend=
ing,
> +                                                               service);
> +               }
> +
> +               l =3D next;
> +       }
> +}
> \ No newline at end of file
> diff --git a/src/device.h b/src/device.h
> index 6ed8affa0d4a9274d30cac9b48e8a6826edefd64..fee1ad50dc9c7ae248acd819d=
ae07762c783ac35 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -120,6 +120,7 @@ void device_bonding_complete(struct btd_device *devic=
e, uint8_t bdaddr_type,
>  gboolean device_is_bonding(struct btd_device *device, const char *sender=
);
>  void device_bonding_attempt_failed(struct btd_device *device, uint8_t st=
atus);
>  void device_bonding_failed(struct btd_device *device, uint8_t status);
> +void device_cancel_bonding(struct btd_device *device, uint8_t status);
>  struct btd_adapter_pin_cb_iter *device_bonding_iter(struct btd_device *d=
evice);
>  int device_bonding_attempt_retry(struct btd_device *device);
>  long device_bonding_last_duration(struct btd_device *device);
> @@ -134,6 +135,9 @@ int device_notify_pincode(struct btd_device *device, =
gboolean secure,
>                                                         const char *pinco=
de);
>  void device_cancel_authentication(struct btd_device *device, gboolean ab=
orted);
>  gboolean device_is_authenticating(struct btd_device *device);
> +
> +void device_cancel_browse(struct btd_device *device, uint8_t bdaddr_type=
);
> +
>  void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
>                                                         uint32_t flags);
>  void device_remove_connection(struct btd_device *device, uint8_t bdaddr_=
type,
> @@ -141,6 +145,7 @@ void device_remove_connection(struct btd_device *devi=
ce, uint8_t bdaddr_type,
>                                                         uint8_t reason);
>  void device_request_disconnect(struct btd_device *device, DBusMessage *m=
sg);
>  bool device_is_disconnecting(struct btd_device *device);
> +bool device_is_connecting(struct btd_device *device);
>  void device_set_ltk(struct btd_device *device, const uint8_t val[16],
>                                 bool central, uint8_t enc_size);
>  bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
> @@ -170,6 +175,7 @@ guint device_add_disconnect_watch(struct btd_device *=
device,
>                                 disconnect_watch watch, void *user_data,
>                                 GDestroyNotify destroy);
>  void device_remove_disconnect_watch(struct btd_device *device, guint id)=
;
> +void device_disconnect_watches_callback(struct btd_device *device);
>  int device_get_appearance(struct btd_device *device, uint16_t *value);
>  void device_set_appearance(struct btd_device *device, uint16_t value);
>
> @@ -184,6 +190,9 @@ void btd_device_set_pnpid(struct btd_device *device, =
uint16_t source,
>
>  int device_connect_le(struct btd_device *dev);
>
> +DBusMessage *device_connect_profiles(struct btd_device *dev,
> +               uint8_t bdaddr_type, DBusMessage *msg, const char *uuid);
> +
>  typedef void (*device_svc_cb_t) (struct btd_device *dev, int err,
>                                                         void *user_data);
>
> @@ -225,3 +234,11 @@ void btd_device_set_conn_param(struct btd_device *de=
vice, uint16_t min_interval,
>  void btd_device_foreach_service_data(struct btd_device *dev,
>                                         bt_device_ad_func_t func,
>                                         void *data);
> +
> +typedef void (*btd_device_service_func_t)(struct btd_service *service,
> +                                       void *user_data);
> +void btd_device_foreach_service(struct btd_device *dev,
> +                               btd_device_service_func_t func,
> +                               void *user_data);
> +void device_remove_pending_services(struct btd_device *dev,
> +                                       uint8_t bdaddr_type);
> \ No newline at end of file
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

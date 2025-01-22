Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFD215769
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737575857; cv=none; b=h/xt+XMPLp90URpRDdETuCRhN3c7Fh4j8LIgvIibhPWUgbTiJWUMBg9ZD0LMbK4s5Z5M0MRhtZ+VJGGJ4V1lNfTBCKGyZOq5V3pBfpiTBlyLuOb6UZu/p3qPJ5CIB3AEOdNaFT+QZv/UlrJDf/SIqQWLt+tdJGriG6y4JL2vXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737575857; c=relaxed/simple;
	bh=1VrYE63pR+b8JA0MrKvI7B0K5YSgqev+bGegbi+D76Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVFaL0M9l7g3WdWJ935VZGnWicH68zde7jkPNFF7Mj0+SREIqHYePvjyNfKRH3RbOdT4w4VGQvdNGXIvw9487Tpib7BPiXoBaQIHTDPjTMqog20CqWy4K3xkQb135sT+IEwwugy7TqjhsyVvoDzSDJ1qDKyNqx9Foc7WzNY1FDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLzuP7tX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLzuP7tX"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3002c324e7eso627921fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737575853; x=1738180653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6zYMcaS8i502LCk96rNNil09spb3Inog0Ko3CIM0zQ=;
        b=XLzuP7tXZCDzi64SGAvFH1RFloZ7wqCscpudyQgEJXyM98xu9pN3uIrowFwdPyDsB0
         ikpWJySKou2POSlAIRVhUiTZT3CZGqoeebGyR1l2S4VKHRzT91O0jUR4zm1A7f7NkS8E
         raABtfnkszabJBHA8Gfao9u8wMXxiDaYaXpzf/RBncKOPrBjNmk2JPoXWJgRJ19Ddtrs
         NfanW3QLVVEj1lfP3p64r6NAkuWLcq1pRy3d6q1MqcXX8qADj9N4+caI+CrNAfSv+KEM
         aCrwZ2M7+EIhEpVqTarBi6rFQseCLkhlheZYPxgJv4zfIde++HUo/BKd0wVsf95Sp9gQ
         wEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737575853; x=1738180653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6zYMcaS8i502LCk96rNNil09spb3Inog0Ko3CIM0zQ=;
        b=HUzVa1ZYD9ab99r1FBg+xREUWp7CB8vUJWl8giI3zFy+gLiAQ4QQLRd5OaUsHtuBju
         AyFK44eEM1coZasDxWasndXBiutNj9FcM0hy0WqpCJjl0foPFBbOXUt0GgSe7KHWnh/5
         o3YdwcLhOh7oHhz4Lg1RIGPc6fyGzEEcBCo5emV+9Up2E0EhOBiIWdZqVKTjBnj/rYz1
         UUeQN7eBsdHX6Z9hAgnekz+zovMvVfwSi8sEKYd62ulUvAEle8IWPOcT06aT10pbjoo1
         LmWXSXAtH0GICKQX0a+jJ7Sg1KjkjAGkA51k/hu1hr2lUbBVQerEFdaKT+wq/b53TVIS
         Fhsw==
X-Gm-Message-State: AOJu0Yy8e55iD5T7Ptqi3gGfutMfAl5BrBd39QIKxB37gx2cXc+i2UKk
	/Eehnjj+hbvnZrNbj7J+N3j+EMOZiRXpLjX5US2eaA0bv3SK1tA0Kb+qd6AqZa/TxXSDCBxKeys
	GkbuXGKPfVxLBbuFgCBRmwW6uDJ3y23Kd3g0=
X-Gm-Gg: ASbGncsoZA+RyzJvg86CkQo+oBJ3m+iw0VN3QDTkqpai6KEOehyjnd7zbdY+dQtRq7e
	+plcO9hjpZJ1k4btvHJ+Xzw+PeYI7Uxo37GStp27CIdYRWw6NKaff
X-Google-Smtp-Source: AGHT+IFCVARL0z0+oCMW1cK5k7FOmG3gU42b327LC674jJnNUiiksNyIqAwjNQswc+8AiFHRxg6w0xw006ien9+usKM=
X-Received: by 2002:a05:651c:11cf:b0:300:360b:bc3f with SMTP id
 38308e7fff4ca-3072ca69448mr59559851fa.15.1737575853095; Wed, 22 Jan 2025
 11:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122113256.1107629-1-hadess@hadess.net> <20250122113256.1107629-3-hadess@hadess.net>
In-Reply-To: <20250122113256.1107629-3-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Jan 2025 14:57:21 -0500
X-Gm-Features: AbW1kvYcGSpHpUt4NwqL3ZAOwlVmggV7_lhnvxAH5MJDpP6oc-wLEj8HBfMjv5c
Message-ID: <CABBYNZLP-n25ZYVvJz2E8+kbkS5ah23tqZmeVkYLwt1xCAWamA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] device: Better "Connect" debug
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Jan 22, 2025 at 6:33=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Output clearer debug information so that it's possible to follow the
> decisions made by the bluetoothd daemon when a client such as
> bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
> device.
> ---
>  client/error.c |  1 +
>  client/main.c  |  5 +++--
>  src/device.c   | 36 +++++++++++++++++++++++++++++-------
>  3 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/client/error.c b/client/error.c
> index 975e4030dfc0..aa8a058cce98 100644
> --- a/client/error.c
> +++ b/client/error.c
> @@ -19,6 +19,7 @@ struct {
>         { "br-connection-profile-unavailable", "Exhausted the list of BR/=
EDR profiles to connect to" },
>         { "br-connection-busy", "Cannot connect, connection busy" },
>         { "br-connection-adapter-not-powered", "Cannot connect, adapter i=
s not powered" },
> +       { "br-connection-page-timeout", "Device is unpowered or not in ra=
nge" },

Not really following why do you want to translate the error message in
bluetoothctl and not directly on bluetoothd side? Well perhaps there
could be application expecting these strings to be sort of errors code
really, in that case perhaps this is valid but I'd rather have it
output both error.message and its description, but I would begin by
defining them in the documentation:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#void-co=
nnect

Right now we only document the error.code not the error.message

>  };
>
>  const char *error_code_to_str(const char *error_code)
> diff --git a/client/main.c b/client/main.c
> index 322326ab9b80..0c39e8795762 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -30,6 +30,7 @@
>  #include "gdbus/gdbus.h"
>  #include "print.h"
>  #include "agent.h"
> +#include "error.h"
>  #include "gatt.h"
>  #include "advertising.h"
>  #include "adv_monitor.h"
> @@ -1977,8 +1978,8 @@ static void connect_reply(DBusMessage *message, voi=
d *user_data)
>         dbus_error_init(&error);
>
>         if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
> -               bt_shell_printf("Failed to connect: %s %s\n", error.name,
> -                               error.message);
> +               bt_shell_printf("Failed to connect: %s: %s\n", error.name=
,
> +                               error_code_to_str(error.message));
>                 dbus_error_free(&error);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
> diff --git a/src/device.c b/src/device.c
> index e8bff718c201..9ec6b4d4bd2e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -2477,8 +2477,9 @@ static DBusMessage *connect_profiles(struct btd_dev=
ice *dev, uint8_t bdaddr_type
>         DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
>                                                 dbus_message_get_sender(m=
sg));
>
> -       if (dev->pending || dev->connect || dev->browse)
> +       if (dev->pending || dev->connect || dev->browse) {
>                 return btd_error_in_progress_str(msg, ERR_BREDR_CONN_BUSY=
);
> +       }
>
>         if (!btd_adapter_get_powered(dev->adapter)) {
>                 return btd_error_not_ready_str(msg,
> @@ -2497,6 +2498,7 @@ static DBusMessage *connect_profiles(struct btd_dev=
ice *dev, uint8_t bdaddr_type
>                                                         "Connect") &&
>                                 find_service_with_state(dev->services,
>                                                 BTD_SERVICE_STATE_CONNECT=
ED)) {
> +                               DBG("Already connected to services");
>                                 return dbus_message_new_method_return(msg=
);
>                         } else {
>                                 return btd_error_not_available_str(msg,
> @@ -2509,8 +2511,10 @@ static DBusMessage *connect_profiles(struct btd_de=
vice *dev, uint8_t bdaddr_type
>
>         err =3D connect_next(dev);
>         if (err < 0) {
> -               if (err =3D=3D -EALREADY)
> +               if (err =3D=3D -EALREADY) {
> +                       DBG("Already connected");
>                         return dbus_message_new_method_return(msg);
> +               }
>                 return btd_error_failed(msg,
>                                         btd_error_bredr_conn_from_errno(e=
rr));
>         }
> @@ -2583,12 +2587,20 @@ static uint8_t select_conn_bearer(struct btd_devi=
ce *dev)
>         return dev->bdaddr_type;
>  }
>
> +static const char *bdaddr_type_strs[] =3D {
> +       "BR/EDR",
> +       "LE public",
> +       "LE random"
> +};
> +
>  static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
>                                                         void *user_data)
>  {
>         struct btd_device *dev =3D user_data;
>         uint8_t bdaddr_type;
>
> +       DBG("Calling \"Connect\" for device %s", dev->path);
> +
>         if (dev->bredr_state.connected) {
>                 /*
>                  * Check if services have been resolved and there is at l=
east
> @@ -2596,20 +2608,30 @@ static DBusMessage *dev_connect(DBusConnection *c=
onn, DBusMessage *msg,
>                  */
>                 if (dev->bredr_state.svc_resolved &&
>                         find_service_with_state(dev->services,
> -                                               BTD_SERVICE_STATE_CONNECT=
ED))
> +                                               BTD_SERVICE_STATE_CONNECT=
ED)) {
>                         bdaddr_type =3D dev->bdaddr_type;
> -               else
> +                       DBG("Selecting address type %s, as BR/EDR service=
s are resolved "
> +                           " and connected", bdaddr_type_strs[dev->bdadd=
r_type]);
> +               } else {
>                         bdaddr_type =3D BDADDR_BREDR;
> -       } else if (dev->le_state.connected && dev->bredr)
> +                       DBG("Selecting address type BR/EDR, as services n=
ot resolved "
> +                           "or not connected");
> +               }
> +       } else if (dev->le_state.connected && dev->bredr) {
>                 bdaddr_type =3D BDADDR_BREDR;
> -       else
> +               DBG("Selecting address type BR/EDR, as LE already connect=
ed");
> +       } else {
>                 bdaddr_type =3D select_conn_bearer(dev);
> +               DBG("Selecting address type %s", bdaddr_type_strs[dev->bd=
addr_type]);
> +       }
>
>         if (bdaddr_type !=3D BDADDR_BREDR) {
>                 int err;
>
> -               if (dev->le_state.connected)
> +               if (dev->le_state.connected) {
> +                       DBG("Device already connected through LE");
>                         return dbus_message_new_method_return(msg);
> +               }
>
>                 btd_device_set_temporary(dev, false);
>
> --
> 2.47.1
>
>


--=20
Luiz Augusto von Dentz

Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E71E504
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143934; cv=none; b=ioodpOFIhTPQST9ZUXYUmx6oN74chRomiSdPq5aY0Jk6Bc18kQv+PKp7oQhZnLMhLUUOyj+RmY1X8LXim/fQnMSvB6qkmbhWX/I5GZ6xp6TXMq5QhdxEVrypCcTPmurXEyI083cJgllo7fcJ47zggopeTC+Oe+FJ9qKnJ6ZUS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143934; c=relaxed/simple;
	bh=oulGp9ar12hjpO+fpYc40B8dRhZDf+E+ryZ/ITfxiDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LG/0aiMhzPTvzNZUCDBmsXxsRFkRVvNrV/aiCcEWt6LofUZhviacVyNA6u2JWElRhjtVlqbhl+zyX4eXGAoGfToIrX4Y9fB8uv+cXjlPytbHM+cuQsYzEi1xSh3fTqbv5a1f4LZbeFHHmwcBfFRXDJGpHVZSXmgRs+sZ/JN+f7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUmk5kX2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUmk5kX2"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso28327791fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714143930; x=1714748730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2ghM+5ArCPXL11LECTy7LYM0lEPVtX1SCapEGy/CEI=;
        b=MUmk5kX2Un9zs0COk4dsE5BLeM4ilQeRTSPakuGcF7gKn6OqMmAUW0t6tgGqz6j4H9
         DuJryFT3miw+zSnJ4B290X4XAW5B8mvMUC6hShJT4QjMURSQiSN13pYNYEoTiWZXfdzg
         z/kzALxHzlCr1FvftL2ji3HNFSvsK/ddkpWwqabxSPUbYTfclRqGCt2L6MT0oREIe17+
         bD5DoiuvkFXX7YCCrMFXhbXW3o1uWCx4MiK+pvhFJgK0jeZTd9/yLM7qoTpakXcQTAFK
         ++uhd1qO3Dx/XCNDt95tf/aUsSfqHHuCjdxr87iFwny+zqMjnNCVGbdfnCZIAE4goP2g
         k/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714143930; x=1714748730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2ghM+5ArCPXL11LECTy7LYM0lEPVtX1SCapEGy/CEI=;
        b=NQDF6Z554hI8jo0z9BeqZCqVEYx++b9WAqxqnr3W6kW205IzoyHi/JDYaPRXVO60Je
         V2LF1Lud6IN/Cqd9Gul6hq0vHSWefgvUJy9ybnD8/BHyEwFoQEYu8ADSmdmjmeGsULqE
         7vDQ3UF7X9ZwP/slWSp4hygXEudEs60MKT14sgkguDPy7dCjvbp1naHWRbAolwOpRLve
         GkPnTRPvv7bO1R048JdJ8G0XoiolvN1Ztt6dcLnOjy+pT84nFYWVGxOVxZxMChPB/vde
         kUnUKSqNOMCq3/4CKi6QFRsYvnpfNI0HC1IfG/kspKk/6mu/E1wGBlqKJXpRKJBn8rZ3
         PhNg==
X-Gm-Message-State: AOJu0YyZlPlfVskGm1A/v0eY0LcyDbxg4ZmsUtHpAjcDzMoWJTGI50iZ
	8XVMqMIQz/vQIq0BIEl1pN8E8LQW7utvS/lBzcW4vWUJISZoBim52x5XOZ4/RnPQyScTqXqoelA
	OeQ9Ca5jdScIIp9yL4R5NMwiza+dCGQ==
X-Google-Smtp-Source: AGHT+IEZldICiivaWoICQ2M9RCArD69myxzw3HHsbfkSu0ivGyLny5VxUbMR3kUFpbKzFhZhqAvvv4If8orfeRxjuu8=
X-Received: by 2002:a2e:934b:0:b0:2dc:b91f:81ce with SMTP id
 m11-20020a2e934b000000b002dcb91f81cemr2331687ljh.10.1714143930079; Fri, 26
 Apr 2024 08:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426132342.732682-1-frederic.danis@collabora.com>
In-Reply-To: <20240426132342.732682-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 26 Apr 2024 11:05:16 -0400
Message-ID: <CABBYNZKEfKiXZXCEzH-FyLozJgSfMUx=mFgv-go-vACUPPD=aQ@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ] plugins: Add new plugin to manage wake policy
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Fri, Apr 26, 2024 at 9:23=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> By default all class of devices providing the correct service (HID, HoG)
> are allowed to wake up the host.
> This plugin allows to choose which class of devices are allowed or not to
> do it.
>
> E.g. only the Peripheral class, or more specifically the Peripheral
> Joystick and Gamepad devices, could be allowed but not the other type of
> devices like e.g. the headsets.
> For the first case, all Major classes in /etc/bluetooth/wake-policy.conf
> except Peripheral should be uncommented and set to 'false', while for the
> second case Peripheral should also be uncommented and set to '01;02'.
> ---
>
> I send this as an RFC as I'm not sure creating a wake policy plugin is th=
e
> correct way to get it merged upstream.
>
> Could it be better to move the device_set_wake_support() call from
> profiles/input/{device,hog}.c files to src/device.c:device_svc_resolved()
> which could perform Service and Class of Device checks?
>
> Any advice much appreciated.

At first I didn't get what you were trying to do since we do already
allow to overwrite via Device.WakeAllowed property, but I guess you
want to generalize it so other classes, other than just input, could
wake up the host?

In that case I would suggest doing it directly via main.conf and
perhaps allow something using a UUIDs:

WakeAllowed=3Dtrue/false/uuid1, uuid2...

That said we might need to introduce support for flagging driver that
do really support setting wakeallowed property otherwise
WakeAllowed=3Dtrue may have a bad impact if users try to enable it for
everything including SDP for example, or we could just got with the
uuid list and default to HID and HoG for now and in case it is set
empty than it disables but there is no way to simply enable to
everything, thoughts?

>  Makefile.plugins         |   4 +
>  plugins/wake-policy.c    | 180 +++++++++++++++++++++++++++++++++++++++
>  plugins/wake-policy.conf |  21 +++++
>  src/device.c             |   2 +-
>  src/device.h             |   1 +
>  5 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 plugins/wake-policy.c
>  create mode 100644 plugins/wake-policy.conf
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 4aa2c9c92..fbd4e4155 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -11,6 +11,10 @@ builtin_sources +=3D plugins/autopair.c
>  builtin_modules +=3D policy
>  builtin_sources +=3D plugins/policy.c
>
> +builtin_modules +=3D wake_policy
> +builtin_sources +=3D plugins/wake-policy.c
> +EXTRA_DIST +=3D plugins/wake-policy.conf
> +
>  if ADMIN
>  builtin_modules +=3D admin
>  builtin_sources +=3D plugins/admin.c
> diff --git a/plugins/wake-policy.c b/plugins/wake-policy.c
> new file mode 100644
> index 000000000..34e77c615
> --- /dev/null
> +++ b/plugins/wake-policy.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024 Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabor=
a.com>
> + *
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdbool.h>
> +
> +#include <glib.h>
> +
> +#include "bluetooth/bluetooth.h"
> +
> +#include "src/plugin.h"
> +#include "src/adapter.h"
> +#include "src/device.h"
> +#include "src/log.h"
> +#include "src/textfile.h"
> +
> +static GKeyFile * key_file;
> +
> +static gboolean is_allowed_to_wake(const char *major, guint minor)
> +{
> +       guint *minor_list;
> +       gsize length;
> +       gboolean allowed =3D false;
> +       GError *gerr =3D NULL;
> +
> +       if (!g_key_file_has_key(key_file, "WakeAllowed", major, NULL))
> +               return true;
> +
> +       allowed =3D g_key_file_get_boolean(key_file, "WakeAllowed", major=
, &gerr);
> +       if (!gerr)
> +               return allowed;
> +
> +       g_error_free(gerr);
> +       gerr =3D NULL;
> +
> +       minor_list =3D (guint *)g_key_file_get_integer_list(key_file,
> +                                               "WakeAllowed",
> +                                               major, &length, &gerr);
> +       if (gerr) {
> +               DBG("Failed to get allowed minor list for %s", major);
> +               return false;
> +       }
> +
> +       for (gsize i =3D 0; i < length; i++) {
> +               if (minor_list[i] =3D=3D minor) {
> +                       allowed =3D true;
> +                       break;
> +               }
> +       }
> +
> +       return allowed;
> +}
> +
> +static const struct {
> +       uint8_t val;
> +       const char *str;
> +} major_class_table[] =3D {
> +       { 0x00, "Miscellaneous" },
> +       { 0x01, "Computer"      },
> +       { 0x02, "Phone"         },
> +       { 0x03, "LAN/Network"   },
> +       { 0x04, "Audio/Video"   },
> +       { 0x05, "Peripheral"    },
> +       { 0x06, "Imaging"       },
> +       { 0x07, "Wearable"      },
> +       { 0x08, "Toy"           },
> +       { 0x09, "Health"        },
> +       { 0x1f, "Uncategorized" },
> +       { }
> +};
> +
> +static gboolean is_class_allowed_to_wake(uint32_t class)
> +{
> +       uint8_t major =3D (class & 0x1f00) >> 8;
> +       uint8_t minor =3D (class & 0x00fc) >> 2;
> +
> +       if ((major >=3D 0x01 && major <=3D 0x09) || major =3D=3D 0x1f)
> +               return is_allowed_to_wake(major_class_table[major].str, m=
inor);
> +
> +       return true;
> +}
> +
> +static void wake_policy_device_resolved(struct btd_adapter *adapter,
> +                                    struct btd_device *device)
> +{
> +       char *filename;
> +       GKeyFile *device_key_file;
> +       GError *gerr =3D NULL;
> +
> +       if (key_file =3D=3D NULL)
> +               return;
> +
> +       // Does device support to wake the host?
> +       if (!device_get_wake_support(device))
> +               return;
> +
> +       // Check if WakeAllowed has already been stored,
> +       // if yes do not change it
> +       filename =3D btd_device_get_storage_path(device, "info");
> +       device_key_file =3D g_key_file_new();
> +       if (!g_key_file_load_from_file(device_key_file, filename, 0, &ger=
r)) {
> +               error("Unable to load key file from %s: (%s)", filename,
> +                                                       gerr->message);
> +               g_clear_error(&gerr);
> +       } else {
> +               if (g_key_file_has_key(device_key_file, "General",
> +                                       "WakeAllowed", NULL)) {
> +                       DBG("%s WakeAllowed already stored",
> +                               device_get_path(device));
> +                       return;
> +               }
> +       }
> +       g_key_file_free(device_key_file);
> +       g_free(filename);
> +
> +       // Check if Class of Device is allowed to wake up the host
> +       if (!is_class_allowed_to_wake(btd_device_get_class(device))) {
> +               DBG("%s Force WakeAllowed to false", device_get_path(devi=
ce));
> +               device_set_wake_override(device, false);
> +               device_set_wake_allowed(device, false, -1U);
> +       }
> +}
> +
> +static int wake_policy_probe(struct btd_adapter *adapter)
> +{
> +       GError *gerr =3D NULL;
> +
> +       DBG("");
> +       key_file =3D g_key_file_new();
> +       if (!g_key_file_load_from_file(key_file,
> +                                       CONFIGDIR "/wake-policy.conf",
> +                                       0,
> +                                       &gerr)) {
> +               error("Unable to load key file from %s: (%s)",
> +                       CONFIGDIR "/wake-policy.conf",
> +                       gerr->message);
> +               g_clear_error(&gerr);
> +               g_key_file_free(key_file);
> +               key_file =3D NULL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void wake_policy_remove(struct btd_adapter *adapter)
> +{
> +       DBG("");
> +       if (key_file)
> +               g_key_file_free(key_file);
> +}
> +
> +static struct btd_adapter_driver wake_policy_driver =3D {
> +       .name   =3D "wake-policy",
> +       .probe  =3D wake_policy_probe,
> +       .remove =3D wake_policy_remove,
> +       .device_resolved =3D wake_policy_device_resolved,
> +};
> +
> +static int wake_policy_init(void)
> +{
> +       return btd_register_adapter_driver(&wake_policy_driver);
> +}
> +
> +static void wake_policy_exit(void)
> +{
> +       btd_unregister_adapter_driver(&wake_policy_driver);
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(wake_policy, VERSION, BLUETOOTH_PLUGIN_PRIORITY_=
LOW,
> +                       wake_policy_init, wake_policy_exit)
> diff --git a/plugins/wake-policy.conf b/plugins/wake-policy.conf
> new file mode 100644
> index 000000000..e6220bad1
> --- /dev/null
> +++ b/plugins/wake-policy.conf
> @@ -0,0 +1,21 @@
> +[WakeAllowed]
> +# By default each Class of Devices providing the correct service (HID, H=
oG) is
> +# allowed to wake up the host.
> +# The following values are used to control the default WakeAllowed value=
 based
> +# on the Class of Device.
> +# It is still possible for the user to override the WakeAllowed value pe=
r
> +# device afterwards.
> +#
> +# Possible values for each Major Class:
> +# true,false,<Minor Class allowed list (integer separated by ;)>
> +
> +#Computer=3Dtrue
> +#Phone=3Dtrue
> +#LAN/Network=3Dtrue
> +#Audio/Video=3Dtrue
> +#Peripheral=3Dtrue
> +#Imaging=3Dtrue
> +#Wearable=3Dtrue
> +#Toy=3Dtrue
> +#Health=3Dtrue
> +#Uncategorized=3Dtrue
> diff --git a/src/device.c b/src/device.c
> index 1d4b8ab36..d970745f5 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1500,7 +1500,7 @@ dev_property_advertising_data_exist(const GDBusProp=
ertyTable *property,
>         return bt_ad_has_data(device->ad, NULL);
>  }
>
> -static bool device_get_wake_support(struct btd_device *device)
> +bool device_get_wake_support(struct btd_device *device)
>  {
>         return device->wake_support;
>  }
> diff --git a/src/device.h b/src/device.h
> index 5722ca9ca..f8c744baf 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -149,6 +149,7 @@ void device_set_wake_support(struct btd_device *devic=
e, bool wake_support);
>  void device_set_wake_override(struct btd_device *device, bool wake_overr=
ide);
>  void device_set_wake_allowed(struct btd_device *device, bool wake_allowe=
d,
>                              guint32 id);
> +bool device_get_wake_support(struct btd_device *device);
>  void device_set_refresh_discovery(struct btd_device *dev, bool refresh);
>
>  typedef void (*disconnect_watch) (struct btd_device *device, gboolean re=
moval,
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz

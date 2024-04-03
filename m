Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7C14831D
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152252; cv=none; b=OyW7oOwwNycEDv1TloHb6VGflqDQi24OmkgB2334ovCT6c77i2TvzMktILVffkCgwo0xJjU9GYwAvg+1RaKcN3F8Ox8c5vGFkmjVvTCqfHNMuSuluoMXBvDUW/TS3Rue8XNy6YV13JyYreteqAno3sIKAq6vRqFslE17aWqlaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152252; c=relaxed/simple;
	bh=d+ReEHmcQvQ3Zlp6Ngorh0c8S9BU9MNCHwOT3fLSo64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RG4RB4UrAC5Gvvk5iSxtAr6tmbw6EeA6mp9cayzghSB29mMExU81LLCNDD/bkuOPujfOndT1QkTBfs2e+RiRqq3hOyntxQNu9h3utMSpvGafAg/1nHp+u8lJSUXDWDJ6E2g2BTfLxu0WD+GwyO1OGi5vTvrjzy5QuRHC/UQ4Ayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=kulAHpwj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="kulAHpwj"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d717269fso7609071e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1712152248; x=1712757048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wXhryY2mZi0KKsuU1at2JuZl+X3Fq9B5y2NlIDFsYg=;
        b=kulAHpwjTKej1tGi/eLNY049wOFVgABIRyNqfCmUO3qUkcK3s27c0UdDsDRx00M6oW
         4SlJhDzciSA7GIrip1m/o7Q17D+hyrFElSN8oZTu+8giItWWhnlOmL4oJLfJ/Os6J1z5
         +vsdKv+bdEt2XM7ay8hO1NTdhclkroS9FDul47IBLrjAXK3mVZlV2j45B5KbsrsmzUdO
         V9URd1dpK/FiyZHw8CBLHg0gD+DdPu+ft4PKyqbThgz7SXLHj4GJqMVE+yVlgu1Chy6G
         VAUjAPMiEhIeKBG0I7hE780zbdxFYd3NxnIDPTuBiCsBQ+H5nwYEVXm/E9twwPkEm+fN
         5BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152248; x=1712757048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wXhryY2mZi0KKsuU1at2JuZl+X3Fq9B5y2NlIDFsYg=;
        b=NcQwTOKsBfg5TecKHXHae4LhAVu20Oc9uxkUyWXXKK65fyiid77W9XMPlOVbjB9MWv
         Oohv8pwDCNxtfBhtb+Lhbgk0uHkPHGaY0Fjff3orCDU5mBxsFpK2OBbXSn/LSOuoHfbD
         5M0s3HFAgWF7JjWnhB06t63PCULVfRgAuPX5WXxrEHAUrDw4sywzZzJBd/gKBDMJeMRc
         GMiY8UaZCRBoYjgc0FzMY+NWGcdgTr1CZbA1m3M4ZnYzTrr5vAMMw0lHpJyy7RSNFOXZ
         K6OxlkpZuiLmWlc/BZMoBELxJP2HdoVv+9yB/IS6GoaxAI0njIdhfSs1MExSYIh4iiPA
         fevg==
X-Gm-Message-State: AOJu0YwF8k6I4zdlAtAqcDibUSB6BMgfKuS1Xd/YzUFlHaiMnpVX/C7b
	DyGYh6+qJwfY/iVIKEEObYtl5/oXH2FWLdp4d/bPs0svMiPGkxCo7f3e95PG87derhrVBQxEivS
	peNrex+ikjkKxHCcCTKBgWjOr9cGK2Z7w7ZZuRYo3UUQ0S/kKazA=
X-Google-Smtp-Source: AGHT+IGTCS+FAEg4zIxdnomn51NxKaSmy75PnlUHEBaolLZNbQR4jib1QUWe6ej/EVnX/2jVhwCETFOKTV7fTexJQI0=
X-Received: by 2002:a05:6512:3711:b0:515:d037:d8e with SMTP id
 z17-20020a056512371100b00515d0370d8emr8689946lfr.40.1712152248197; Wed, 03
 Apr 2024 06:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403110808.805771-1-frederic.danis@collabora.com>
In-Reply-To: <20240403110808.805771-1-frederic.danis@collabora.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Wed, 3 Apr 2024 15:50:37 +0200
Message-ID: <CAAEJBhL6pb=PeO_mezcga+aVxDew+zQwTDhTWkHT-wnfXONHtQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] plugins: Add new plugin to fix airpods pairing
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 3 Apr 2024 at 13:08, Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Apple Airpods are discoverable and pairable in BREDR mode, but also
> advertise in unconnectable mode in LE with the same Public address, at th=
e
> same time. As the pairing process uses the latest seen address, sometimes
> it uses the LE Public address to pair, which fails.
>
> This commit adds a new adapter driver plugin which force the BREDR last
> seen time on LE Public address device found event related to an Apple
> device, allowing pairing process to always use the BREDR.
>

While I'm fine with having plugin for this specific case, I wonder if
select_conn_bearer() shouldn't take
bearer's connectable state into account when selecting bearer for connectio=
n

> This commit is based on proposal
> https://lore.kernel.org/all/20240103101328.1812899-1-clancy_shang@163.com=
/
> ---
>  Makefile.plugins  |   3 ++
>  plugins/airpods.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 plugins/airpods.c
>
> diff --git a/Makefile.plugins b/Makefile.plugins
> index 4aa2c9c92..2ebd8aaf6 100644
> --- a/Makefile.plugins
> +++ b/Makefile.plugins
> @@ -11,6 +11,9 @@ builtin_sources +=3D plugins/autopair.c
>  builtin_modules +=3D policy
>  builtin_sources +=3D plugins/policy.c
>
> +builtin_modules +=3D airpods
> +builtin_sources +=3D plugins/airpods.c
> +
>  if ADMIN
>  builtin_modules +=3D admin
>  builtin_sources +=3D plugins/admin.c
> diff --git a/plugins/airpods.c b/plugins/airpods.c
> new file mode 100644
> index 000000000..5043f0cca
> --- /dev/null
> +++ b/plugins/airpods.c
> @@ -0,0 +1,132 @@
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
> +#include "lib/mgmt.h"
> +#include "src/plugin.h"
> +#include "src/adapter.h"
> +#include "src/device.h"
> +#include "src/eir.h"
> +#include "src/log.h"
> +#include "src/shared/mgmt.h"
> +#include "src/shared/util.h"
> +
> +#define APPLE_INC_VENDOR_ID 0x004c
> +
> +static struct mgmt *mgmt;
> +
> +static bool eir_msd_is_apple_inc(GSList *msd_list)
> +{
> +       GSList *msd_l, *msd_next;
> +
> +       for (msd_l =3D msd_list; msd_l !=3D NULL; msd_l =3D msd_next) {
> +               const struct eir_msd *msd =3D msd_l->data;
> +
> +               msd_next =3D g_slist_next(msd_l);
> +
> +               if (msd->company =3D=3D APPLE_INC_VENDOR_ID)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static void airpods_device_found_callback(uint16_t index, uint16_t lengt=
h,
> +                                       const void *param, void *user_dat=
a)
> +{
> +       struct btd_device *dev;
> +       const struct mgmt_ev_device_found *ev =3D param;
> +       struct btd_adapter *adapter =3D user_data;
> +       uint16_t eir_len;
> +       uint32_t flags =3D le32_to_cpu(ev->flags);
> +       struct eir_data eir_data;
> +
> +       dev =3D btd_adapter_find_device(adapter,  &ev->addr.bdaddr,
> +                                       ev->addr.type);
> +       if (!dev)
> +               return;
> +
> +       if (length < sizeof(*ev)) {
> +               warn("Too short device found event (%u bytes)", length);
> +               return;
> +       }
> +
> +       eir_len =3D btohs(ev->eir_len);
> +       if (length !=3D sizeof(*ev) + eir_len) {
> +               warn("Device found event size mismatch (%u !=3D %zu)",
> +                                       length, sizeof(*ev) + eir_len);
> +               return;
> +       }
> +
> +       if (eir_len =3D=3D 0)
> +               return;
> +
> +       memset(&eir_data, 0, sizeof(eir_data));
> +       eir_parse(&eir_data, ev->eir, eir_len);
> +
> +       if (eir_msd_is_apple_inc(eir_data.msd_list) &&
> +                               (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE) =
&&
> +                               (ev->addr.type =3D=3D BDADDR_LE_PUBLIC)) =
{
> +               DBG("Force BREDR last seen");
> +               device_set_bredr_support(dev);
> +               device_update_last_seen(dev, BDADDR_BREDR, true);
> +       }
> +}
> +
> +static int airpods_probe(struct btd_adapter *adapter)
> +{
> +       if (!mgmt)
> +               mgmt =3D mgmt_new_default();
> +
> +       if (!mgmt) {
> +               fprintf(stderr, "Failed to open management socket\n");
> +               return 0;
> +       }
> +
> +       mgmt_register(mgmt, MGMT_EV_DEVICE_FOUND,
> +                                       btd_adapter_get_index(adapter),
> +                                       airpods_device_found_callback,
> +                                       adapter, NULL);
> +
> +       return 0;
> +}
> +
> +static void airpods_remove(struct btd_adapter *adapter)
> +{
> +       mgmt_unregister_index(mgmt, btd_adapter_get_index(adapter));
> +}
> +
> +static struct btd_adapter_driver airpods_driver =3D {
> +       .name   =3D "airpods",
> +       .probe  =3D airpods_probe,
> +       .remove =3D airpods_remove,
> +};
> +
> +static int airpods_init(void)
> +{
> +       return btd_register_adapter_driver(&airpods_driver);
> +}
> +
> +static void airpods_exit(void)
> +{
> +       btd_unregister_adapter_driver(&airpods_driver);
> +}
> +
> +BLUETOOTH_PLUGIN_DEFINE(airpods, VERSION,
> +               BLUETOOTH_PLUGIN_PRIORITY_LOW, airpods_init, airpods_exit=
)
> --
> 2.34.1
>
>


--=20
pozdrawiam
Szymon K. Janc

Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B4314D3C
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226126; cv=none; b=bkNgKOA1u69kib8h4iymbcHMCDJXw6Y3UrsZbarGRmkrB/cdoUO2UvmkL8wEq6a5FtIvRRqi25hOIQcjg5l1D333nsGu+v7PBotToa/IyVtDFLHvDU8XOmdOYUtV3q3qUEnveRbRIHDBD+3tkELNXR3yqc2mQwhcqwdAJu/N2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226126; c=relaxed/simple;
	bh=hmVR+fiEzrsjdMyOgu35shuQSdS39zxfjo3swR4tGCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0QUQJYYYocGjXpSIEpiUjtg4OP9XcRr7BVM5FieqKztXtY8s/bN7bdGnqhcinFGjMPVl8nQPYwVTUx/NxLb7PuqkvPE/YVoqazl4ZZ8itI50XT6fRikqcSYHvdlBSd/ZDH4cVrYdA846p37p5OIwyCpOVnunwYrsiS/lAqsOAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGYl2ix0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGYl2ix0"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-378de7d3057so4516521fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761226120; x=1761830920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeWUpQ9d5rLaLQIFIM8mSdAbOusqmLG6a/19UiQhHB0=;
        b=LGYl2ix0C6i59o3PSKo30nHYl8dF9RMXTx8BKLRZ3NSOYF1e9N3CwRu3E7vRG6V/Oz
         6yWf9iCA+Fe0PLScQ4kTS3BeuyIAUemciSXQIkGkXnn/kugdiC/YxOKaAl1Ywp5tgWHE
         qTG2CDlJv4OF4nBnO37zphLCF9pJWH1FTqong9fWPM/zth0qbMHfbBpsR9kWKSlG+bFG
         7+n5OBpubsx8TJ8iS80tnY5LhH3b4sG+31XhzdafBl+NbRugqDhPLkAFL4mCBYcugmch
         9jQ8Eh/rPd/SAmkEdgL3oKUSC8CklAtjrsEzH5poW9fPBnZ5pA32odhQ3op3KefWB/oK
         h4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226120; x=1761830920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeWUpQ9d5rLaLQIFIM8mSdAbOusqmLG6a/19UiQhHB0=;
        b=BAOWUIfN4kMjTn2YO5C68XHC+73u0Ac/nXf3+gjK58zHezgLuwXyqrbtAWwsuk0qzQ
         fvlDbdAbMXOk0+ROoN29PR4P3k6gAMXi4A/4HzjrZ4vO/Se2ThZkeNAreUT13tO42CtC
         pnwl2CJr8OE5u5snATRjWT95rLwMh35wK428yUqerYaLJ+pkx1tCp4RkIDCljxYW95C5
         EUcTu3hN/6K8RuyO1275alu1XWvA6VdTzKKHY4H8EhwpEUJAOhVtkKbDBubIMegEPMhP
         dyjDQq7GoLr5yHfxfphRK/eaB1bGpmjGxa3Hk2bQjKcW234UYB39K8cKu31PBvxGNloU
         COag==
X-Gm-Message-State: AOJu0Yz7VZRJunKBVl65u1sE3ZD73LRoA3CwvihKyJqvbs+lr6SN01b5
	gLSMz6a/4SkUOpoC/j+3vL/Psamsk3bpf6mksINXT8Vcd7uD3HcW0EEOGFkD2ka6LmOCA88mkXR
	O0C66ilP4DkNSqd0PFXHtYunsZKh6ATdapyzh
X-Gm-Gg: ASbGncvJUPZpYF12P7PpRwPkCngzUZzeGZiltzM01ZZbxRlcA2JeFrONZasipo7Ll8A
	3p4rWjsDDK4K7K+NhCATDuTt5n+0kamXvQKSshJs7bebEl8NFwFs7Jl8SFVwu4/bn1sWnDKCPiK
	xZXntZEuIvTQ1RBs0Vji8HUemGQTqK1j8AFWGoDMCexeWs1MMOxTEMKCdgqHisdRkkDApK6feG0
	oZl1VTtxDP6vRybMQxq1KmRZD6UJpfIHNO/7DK1aT6+8FSboq7LH8AmTNOa16z4TQABxA==
X-Google-Smtp-Source: AGHT+IFJwE82Bdj4Tz5WfGgLHa+ytuFX0BQyJNk+P/QiV4vO3pofwa2SKtqJSoC3nZozNwgvwK8pO8NgzYM2gn1KfIo=
X-Received: by 2002:a2e:a584:0:b0:36a:297a:7d73 with SMTP id
 38308e7fff4ca-3779782a1d8mr83418521fa.5.1761226120181; Thu, 23 Oct 2025
 06:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022155822.88438-1-r.smirnov@omp.ru>
In-Reply-To: <20251022155822.88438-1-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Oct 2025 09:28:27 -0400
X-Gm-Features: AS18NWBHBaSNecNHXIdCS4sIZQV3dwOxCZkknHGNi_Qs_iXPCYtmZaQHgRcSM7E
Message-ID: <CABBYNZJ4dODys_fogdWqTeGQNUbAH394f3REDzZDdjpETpLL6A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] battery: improve the display of the charge level
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Wed, Oct 22, 2025 at 11:59=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> w=
rote:
>
> At the moment, the charge level of the connected devices can
> fluctuate in the range of several values. This is due to changes
> in the conditions in which the battery is located (for example,
> heating or cooling).
>
> Save the last 4 charge levels. Choose the lowest one.

This sounds more like a work around a device that doesn't calibrate
its sensor and end up with fluctuating value, so Id only apply such
logic to them but in order to do that we need some logic that detects
it is fluctuating to begin with, perhaps by checking if the battery is
discharging and its value increases over time it is probably an
indication that it is fluctuating. Btw, I wonder if such logic exists
in other subsystems that display the battery level so we can follow a
more tried method rather than inventing our own.

> Fixes: https://github.com/bluez/bluez/issues/1612
> ---
>  src/battery.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/src/battery.c b/src/battery.c
> index 59e4fc570..370a5c1d0 100644
> --- a/src/battery.c
> +++ b/src/battery.c
> @@ -33,10 +33,13 @@
>  #define BATTERY_PROVIDER_MANAGER_INTERFACE "org.bluez.BatteryProviderMan=
ager1"
>
>  #define BATTERY_MAX_PERCENTAGE 100
> +#define LAST_CHARGES_SIZE 4
>
>  struct btd_battery {
>         char *path; /* D-Bus object path */
>         uint8_t percentage; /* valid between 0 to 100 inclusively */
> +       uint8_t *last_charges; /* last received charge percentages */
> +       uint8_t lru_charge_id; /* oldest received charge id */
>         char *source; /* Descriptive source of the battery info */
>         char *provider_path; /* The provider root path, if any */
>  };
> @@ -92,6 +95,12 @@ static struct btd_battery *battery_new(const char *pat=
h, const char *source,
>         battery =3D new0(struct btd_battery, 1);
>         battery->path =3D g_strdup(path);
>         battery->percentage =3D UINT8_MAX;
> +       battery->last_charges =3D new0(uint8_t, LAST_CHARGES_SIZE);
> +       battery->lru_charge_id =3D 0;
> +
> +       for (uint8_t id =3D 0; id < LAST_CHARGES_SIZE; id++)
> +               battery->last_charges[id] =3D UINT8_MAX;
> +
>         if (source)
>                 battery->source =3D g_strdup(source);
>         if (provider_path)
> @@ -105,6 +114,9 @@ static void battery_free(struct btd_battery *battery)
>         if (battery->path)
>                 g_free(battery->path);
>
> +       if (battery->last_charges)
> +               g_free(battery->last_charges);
> +
>         if (battery->source)
>                 g_free(battery->source);
>
> @@ -219,6 +231,8 @@ bool btd_battery_unregister(struct btd_battery *batte=
ry)
>
>  bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
>  {
> +       uint8_t min_charge =3D BATTERY_MAX_PERCENTAGE;
> +
>         DBG("path =3D %s", battery->path);
>
>         if (!queue_find(batteries, NULL, battery)) {
> @@ -231,10 +245,18 @@ bool btd_battery_update(struct btd_battery *battery=
, uint8_t percentage)
>                 return false;
>         }
>
> -       if (battery->percentage =3D=3D percentage)
> +       battery->last_charges[battery->lru_charge_id] =3D percentage;
> +       battery->lru_charge_id =3D (battery->lru_charge_id + 1) % LAST_CH=
ARGES_SIZE;
> +
> +       for (uint8_t id =3D 0; id < LAST_CHARGES_SIZE; id++) {
> +               if (battery->last_charges[id] < min_charge)
> +                       min_charge =3D battery->last_charges[id];
> +       }
> +
> +       if (battery->percentage =3D=3D min_charge)
>                 return true;
>
> -       battery->percentage =3D percentage;
> +       battery->percentage =3D min_charge;
>         g_dbus_emit_property_changed(btd_get_dbus_connection(), battery->=
path,
>                                      BATTERY_INTERFACE, "Percentage");
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz

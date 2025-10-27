Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380E3043D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580760; cv=none; b=QGS60wGacMppMkKuCVqybr1slXZBPBWpdBrg/iSTO3xferv8pcMWPzxcyxsrdlC5Pqz+0Gv99Ew32TCpJqUlWUIR8UXYdUHrE+/wUSS7ZKl6Xu8O/4EpYgAI9TWsE1MKFLK0ImIzm3VZgKGlZsFcgjKGTZGVFL3V9rzDhjeBPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580760; c=relaxed/simple;
	bh=Ovsy1UwpZT6VOYt1xN1M9y6FCZXkZ8vk2Q1Gg3BdZrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj1njVjWm157PD+1gLL6vaMgOqKxPzsCEY/qqeQ4TzZy+dp1VYEnFUvwKsxfELnhtVjsGCApEBUyMXA+3wjo9uozA8AvkUJ1S0DJqod5MvojVf7DWMYXhjK+XGUhZgxu3tlTOu2N5JrOsUuKcMWVaZaVb10JIwSSvfieAoHvitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5IHq76v; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5IHq76v"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592fdbeb7b2so4596289e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761580756; x=1762185556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfpm5CSM7/KFwuitrzNBVUhDmQwNPvQlEbiozOFEaHc=;
        b=h5IHq76vg/WM67+WpyQoKnb/fGZuYsHlb3zqFFddkyP03dn1QHm4vmutjyQRcMFknz
         j5aXJ81Tbtw/9OTFalU6oSN5rBawRnAk8/+omyPUzfMsQyDOgvlL16aWcoe2Y6igrqEG
         SSHr1fG7aKoUm94/D1W99iIlTazEWXodlWP6FhRTc4KVNbkgb8gFUr84YuMP+UgGxRYO
         CcFbuf6hI6JLU8tcqTel7Ejd6gV+ZmjKbEA2dcQ7J9UqIV7jYPXdJufkBeoSjBTJv/Eb
         cailmVaIR/+PgnjFYyKm3ehlsEVnkgUVZOgN2GWTg9MKLVneeSFb72Fa38+sXYSCqFMv
         ksIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580756; x=1762185556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xfpm5CSM7/KFwuitrzNBVUhDmQwNPvQlEbiozOFEaHc=;
        b=VwDL0EInw9ksdYQKUDWXiR4MQFXPwy3Q3ZP9qYqXtnJ+EL5NAxinVmkEsRNXUD25+N
         5VaSi3V873gU3HJO932DNtNi9S+G7SutU/LPYKVsttAkz19PvNB9FdKL7xxfNYpYedJE
         zJu+STtv/UmKmynQ136RwoepR3+sia1tvHaQGyqC0cOFZTfy7oW8MkxgN8T3YiMx6QWK
         TqbJGjO9dp+tqCY8M0FXj5C0FqN7994d+7D01ISm66wvChhpBnioz7lk1+fc7hfVYAfZ
         2vawojFC0UrkTbxIQ2GKgZ6iAmsE+jmL+rJhK7GpV1wJ+CJ5J99TtwXbSgGeur+Wlp04
         SdLg==
X-Gm-Message-State: AOJu0YyQyEFkvPkQs0FJkH3hIpnWKbvBFUEixeoARZXQhZRc7sX/TZxM
	mLjovhqKZLEGo0jyGKEkPI08mWvvtoZ1+3fkm5dSPMwiBTCTrqOx2yjAgqd5WRFj1tiseWmYPeI
	xoNOFfQT3frAF22TsJRX3pmbniJc0sffzFA==
X-Gm-Gg: ASbGncvVvBa2DkRk1ijHrae0soYErSt8lMH8DBNcnLfcJS5O3xtfvw1ILUchenQczNN
	qVduWAq/TEBbnOfQgSKTBZbv7bUIkBQklbJcimHxrFQjjH/2BaYVS+FrDr227CdjgSNaNnxe9pC
	gy4083OIkqJb7TSfotIoL+6RsO+DG+49BZvi/YdUN6EukM64Mwn2CmHREUzTTD568nk6GpgZXZ7
	aR8KspAHDzLM8Hi6xbCAqdMO+kOBnTHFq6Jk7acBABmbC8Um5F+PevmFnvka9WAfAafgA==
X-Google-Smtp-Source: AGHT+IEN6Mw2MWuIqRoeNHpWvOY3ORotBZyJFgHoGGYOQMOA0yIYOto5mllganE2BcDicdjYL5XfivF49NJExmV736k=
X-Received: by 2002:a05:6512:230e:b0:55f:435e:36bd with SMTP id
 2adb3069b0e04-5930e9311ebmr194140e87.0.1761580755481; Mon, 27 Oct 2025
 08:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027151108.106713-1-r.smirnov@omp.ru>
In-Reply-To: <20251027151108.106713-1-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Oct 2025 11:59:01 -0400
X-Gm-Features: AWmQ_blOduwtVKU6aBXbhk8HgTvaEcgl86L8uGzpU1gbu1tdqqge5Zn3xb48kR8
Message-ID: <CABBYNZL22wrX1m2EzzPEw8gPsyM_Gurxmtf_rsKDxB9N0Y6Zfw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] battery: improve the display of the charge level
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Mon, Oct 27, 2025 at 11:19=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> w=
rote:
>
> The battery charge level may fluctuate due to uncalibrated
> sensors. Commit smooths out such fluctuations.
>
> The algorithm for determining uncalibrated sensors consists of
> finding the number of changes in charge direction (i.e., "spikes").
> If the number of spikes is zero, the device is charging or discharging.
> If there is one spike, it may mean that the device has started charging
> or has been disconnected from charging. If there are two or more
> spikes, this is a clear indication of an uncalibrated sensor.
>
> Check that the battery charge is fluctuating. If the battery charge
> is fluctuating, use the average charge value, otherwise use the current
> value.

Is this method based on something used already? Or it is yet again
something you came up with?

> Fixes: https://github.com/bluez/bluez/issues/1612
> ---
>  src/battery.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/src/battery.c b/src/battery.c
> index 59e4fc570..f97d9b8f3 100644
> --- a/src/battery.c
> +++ b/src/battery.c
> @@ -33,10 +33,16 @@
>  #define BATTERY_PROVIDER_MANAGER_INTERFACE "org.bluez.BatteryProviderMan=
ager1"
>
>  #define BATTERY_MAX_PERCENTAGE 100
> +#define LAST_CHARGES_SIZE 8
> +#define MAX_CHARGE_STEP 5
>
>  struct btd_battery {
>         char *path; /* D-Bus object path */
>         uint8_t percentage; /* valid between 0 to 100 inclusively */
> +       uint8_t *last_charges; /* last charges received */
> +       uint8_t lru_charge_id; /* oldest battery charge */
> +       float avg_charge; /* average battery charge */
> +       bool is_fluctuating; /* true, if the battery sensor fluctuates */
>         char *source; /* Descriptive source of the battery info */
>         char *provider_path; /* The provider root path, if any */
>  };
> @@ -92,6 +98,11 @@ static struct btd_battery *battery_new(const char *pat=
h, const char *source,
>         battery =3D new0(struct btd_battery, 1);
>         battery->path =3D g_strdup(path);
>         battery->percentage =3D UINT8_MAX;
> +       battery->last_charges =3D new0(uint8_t, LAST_CHARGES_SIZE);

I'd prefer to use a queue rather than an array for looking back.

> +       battery->lru_charge_id =3D 0;
> +       battery->avg_charge =3D 0;
> +       battery->is_fluctuating =3D false;
> +
>         if (source)
>                 battery->source =3D g_strdup(source);
>         if (provider_path)
> @@ -105,6 +116,9 @@ static void battery_free(struct btd_battery *battery)
>         if (battery->path)
>                 g_free(battery->path);
>
> +       if (battery->last_charges)
> +               g_free(battery->last_charges);
> +
>         if (battery->source)
>                 g_free(battery->source);
>
> @@ -217,6 +231,39 @@ bool btd_battery_unregister(struct btd_battery *batt=
ery)
>         return true;
>  }
>
> +static void check_fluctuations(struct btd_battery *battery)
> +{
> +       uint8_t spikes =3D 0;
> +       int8_t step =3D 0;
> +       int8_t direction =3D 0;
> +       int8_t prev_direction;
> +
> +       for (uint8_t id =3D 0; id < LAST_CHARGES_SIZE - 1; id++) {
> +               prev_direction =3D direction;
> +               step =3D battery->last_charges[id] - battery->last_charge=
s[id + 1];

I prefer to avoid this type of construct, even though it seems to be
safe to access id + 1 since the loop is limited to LAST_CHARGES_SIZE -
1, I'd rather use a queue to access elements, anyway I also think it
is probably a good idea to store the direction as well.

> +
> +               /*
> +                * The battery charge fluctuates too much,
> +                * which may indicate a battery problem, so
> +                * the actual value should be displayed.
> +                */
> +               if (step > MAX_CHARGE_STEP) {
> +                       battery->is_fluctuating =3D false;
> +                       return;
> +               }
> +
> +               if (step > 0)
> +                       direction =3D 1;
> +               else if (step < 0)
> +                       direction =3D -1;
> +
> +               if (direction !=3D prev_direction && !prev_direction)
> +                       spikes++;
> +       }
> +
> +       battery->is_fluctuating =3D (spikes > 1) ? true : false;
> +}
> +
>  bool btd_battery_update(struct btd_battery *battery, uint8_t percentage)
>  {
>         DBG("path =3D %s", battery->path);
> @@ -231,6 +278,21 @@ bool btd_battery_update(struct btd_battery *battery,=
 uint8_t percentage)
>                 return false;
>         }
>
> +       if (!battery->avg_charge)
> +               battery->avg_charge =3D percentage;
> +
> +       /* exponential smoothing */
> +       battery->avg_charge =3D battery->avg_charge * 0.7 + percentage * =
0.3;
> +       battery->last_charges[battery->lru_charge_id] =3D percentage;
> +
> +       if (battery->lru_charge_id =3D=3D LAST_CHARGES_SIZE - 1)
> +               check_fluctuations(battery);
> +
> +       battery->lru_charge_id =3D (battery->lru_charge_id + 1) % LAST_CH=
ARGES_SIZE;
> +
> +       if (battery->is_fluctuating)
> +               percentage =3D battery->avg_charge;
> +
>         if (battery->percentage =3D=3D percentage)
>                 return true;
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz

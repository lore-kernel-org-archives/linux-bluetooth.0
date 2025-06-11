Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1128C2AF
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653109; cv=none; b=XY1dpYyKVTRNSpt8Z8oQkEyetJ9ggSJYZIWM+mRIBf6EmiAgFkMV+dggD/Ii5t7lcF5cPhpVloHsuAZmhR/AjQNZyfvwmpyW5AjIMD1cuumLUap+2FUtJsws5DlL7WJjpM6HYC9HCruTYKlSQwj7TVuS/cAUFZ379xlkgyy7RQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653109; c=relaxed/simple;
	bh=oqmgWKfWRGHXpk1muxCjroF94TOqNOoX5+nZRYn6mH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpm86gPC9a/oIJA2EMN7oHqr3mYGht3i3sMtcF5+MMFxNWPrptVXFQ+U7OJBQ7V7U5aWOjNPzFyi0hFz/HywJ6rvELP8um0S3el4b7DIsY8QtpE0jpjSSFg54rFUScUNkS/J+yObjHdIVBgmjgyfWVubWou3mD7YfudjWgm7+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQTQ5WGC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQTQ5WGC"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553246e975fso7892796e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749653105; x=1750257905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5Dj2Tp0zkv/0JPV6iSdx+JQ2yNfo4mLZ2r8Ck2I9DY=;
        b=BQTQ5WGC+NY0V2Fjd5tj0ZocDuF9llWwbk/mtUVSUYlB0JrxoBRXjF2Jwf6kVHThw2
         XgyEHJ85lQ2Zx6ghFmA5/h9YIICGcxAhk5rBjrYofZzB5nPS5L7xJa5XQQuCgMx0TWY9
         s/wpf4jVUdp+yiuo6c6Qb6hEF+7VgBj7uMbK+gGuq5vyO7rdj4D4CtlO66ZG58ch0/in
         NkUR5SCDiMWGYxq9/2lYuGj9jDw/GTbxrDMu3swUADXGoWFLHhW3tGAUp1fe+YBtmWhT
         nSyxLA63MGNlmKOC2YQMUePR7cSQZKRqnhB2YrWJrYRF+N/QsiMSH7aOCZczSZdsnZxi
         XGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653105; x=1750257905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5Dj2Tp0zkv/0JPV6iSdx+JQ2yNfo4mLZ2r8Ck2I9DY=;
        b=jlS28OcY+xXI4R23NaU4L7N+8zZCqUFRWlKRO/pGqG+CwnDh/Y+mgX8T9XyxMgbSu5
         l9wRbjreeOoFfgfBoPsGK5im8d+0IlwuiXmYvXLeWqM6sbjksVIj9XMhKupOV+sAkN+A
         NhR+I/ZcHJmtJytF4xVoj2x9hz01IbpW4xGezGNbx8Ep/6De7nAkp8vQsPRL8XceNjeY
         Mljc3JpTe57J4Ve/hom4tXnWxTdQu4woFqIISSU5H+0VLix20tLpadpbkAURAsrR1KUS
         /fDHD4AoM6hPDrbKgUzTPV7mZmoUZ9EVxGwW4UXSzEgHEGREYj7s4ATn9QkMnTi5DKkx
         XIAQ==
X-Gm-Message-State: AOJu0Ywv95mSbjQuzQPvqcmzQuLoAwpbIdUc/9QmU6xDL3hZyp8PUqK0
	IXixLVoSTic0vokUEm/Jpzt3oS1kA3cYHkkMEuB2wGudbajggsRouxijcYCVfu451JEDRuAUrHr
	VaudU3wUrGSmJ4sDpayrAEaOeBoB35SMo1Bu8CfGGkw==
X-Gm-Gg: ASbGncvHKoF6JN7ntfwCSTyJOxHW2887hMzeyvAJ9pl3n265AnxKziks53459q2dKhD
	4qQEsJygS27KprI7qbm8qS7OZpAMT3ty+kKeh7tpOEGuW0fRHxm2LR9w3Gf9Ha10q/3juxGLM6D
	Qrk+aYoDxXXZz5OJjGKQuDEKssQjxQl5lJYX9AijmmDQ==
X-Google-Smtp-Source: AGHT+IFFEppoMMLBW0tgCa5Yag8LxsvIibQK8zO4b7RSO056HquF9cUSR53mNJdGVDhwg9yGVbb+rO4OlZPEI9soC6o=
X-Received: by 2002:a2e:be9a:0:b0:32a:5e74:5726 with SMTP id
 38308e7fff4ca-32b224235f8mr10579081fa.38.1749653094053; Wed, 11 Jun 2025
 07:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611080044.26730-1-adrian-constantin.dudau@nxp.com> <20250611080044.26730-2-adrian-constantin.dudau@nxp.com>
In-Reply-To: <20250611080044.26730-2-adrian-constantin.dudau@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Jun 2025 10:44:41 -0400
X-Gm-Features: AX0GCFt09RgaCb0QHF2qId6-mIyoi6mpn9eDfC8662l6wNZk8nlrage2XP9VaAI
Message-ID: <CABBYNZL9kX1owOk6PJ3NGjueJBJLKGShzrFZ6KK2mjhQw0MzAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: Expose the raw advertising data available on
 D-bus to PTS tester
To: Adrian Dudau <adrian-constantin.dudau@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, Jun 11, 2025 at 4:01=E2=80=AFAM Adrian Dudau
<adrian-constantin.dudau@nxp.com> wrote:
>
> This patch extracts the AdvertisingData property exposed by
> bluetoothd on D-Bus. It will iterate the variable message structure
> and will construct the eir buffer in the format described in
> BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.
>
> Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>
> ---
>  tools/btpclient.c | 80 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 76 insertions(+), 4 deletions(-)
>
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 055270edb51b..f80b4532a248 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -2510,12 +2510,23 @@ static void btp_gap_device_found_ev(struct l_dbus=
_proxy *proxy)
>  {
>         struct btp_device *device =3D find_device_by_proxy(proxy);
>         struct btp_adapter *adapter =3D find_adapter_by_device(device);
> +       struct l_dbus_message_iter dict_iter;
> +       struct l_dbus_message_iter variant_iter;
> +       struct l_dbus_message_iter array_iter;
> +       struct btp_device_found_ev *p_ev =3D NULL;
> +       struct btp_device_found_ev *p_ev_temp =3D NULL;
>         struct btp_device_found_ev ev;
>         struct btp_gap_device_connected_ev ev_conn;
>         const char *str, *addr_str;
>         int16_t rssi;
>         uint8_t address_type;
>         bool connected;
> +       uint8_t key =3D 0U; /* AD Type will be stored here */
> +       uint8_t *data =3D NULL; /* AD Data will be stored here */
> +       uint32_t len =3D 0U; /* Length of the AD Data buffer */
> +       uint32_t eir_couter =3D 0U; /* Byte count of AD Type, AD Length, =
AD Data */
> +
> +       ev.eir_len =3D  0U;
>
>         if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) =
||
>                                         str2ba(addr_str, &ev.address) < 0=
)
> @@ -2538,11 +2549,72 @@ static void btp_gap_device_found_ev(struct l_dbus=
_proxy *proxy)
>                                         BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
>                                         BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
>
> -       /* TODO Add eir to device found event */
> -       ev.eir_len =3D 0;
> +       /* dict_iter will contain the variant for AdvertisingData */
> +       if (l_dbus_proxy_get_property(proxy, "AdvertisingData", "a{yv}", =
&dict_iter)) {
> +               /* key will contain the AD Type, variant_iter will contai=
n the variant
> +                * for the current elem
> +                */
> +               while (l_dbus_message_iter_next_entry(&dict_iter, &key, &=
variant_iter)) {
> +                       /* Unpack the variant to get the byte array */
> +                       if (!l_dbus_message_iter_get_variant(&variant_ite=
r, "ay", &array_iter))
> +                               continue;
> +
> +                       /* data contains AD Data, len is the length exclu=
ding the AD Type*/
> +                       if (!l_dbus_message_iter_get_fixed_array(&array_i=
ter, &data, &len))
> +                               continue;
> +
> +                       if (len <=3D 0U)
> +                               continue;
>
> -       btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->=
index,
> -                                               sizeof(ev) + ev.eir_len, =
&ev);
> +                       p_ev_temp =3D p_ev;
> +
> +                       /* Allocate new buffer, recalculated to sustain n=
ew data
> +                        * eir_counter length from previous data,
> +                        * len is size for new data,
> +                        * 2U (1Byte AD Type, 1Byte AD Length)
> +                        */
> +                       p_ev =3D (struct btp_device_found_ev *)
> +                                       malloc(sizeof(struct btp_device_f=
ound_ev) +
> +                                       eir_couter + len + 2U);
> +
> +                       if (!p_ev) {
> +                               p_ev =3D p_ev_temp;
> +                               break;
> +                       }
> +
> +                       /* There is AD data elemets to be moved after res=
ize */
> +                       if (p_ev_temp && eir_couter !=3D 0U) {
> +                               memcpy(p_ev, p_ev_temp,
> +                                       sizeof(struct btp_device_found_ev=
) + eir_couter);
> +                               free(p_ev_temp);
> +                       } else {
> +                               memcpy(p_ev, &ev, sizeof(struct btp_devic=
e_found_ev));
> +                       }
> +
> +                       /* Populate buffer with length */
> +                       p_ev->eir[eir_couter++] =3D len + 1U;
> +                       /* Populate buffer with AD Type */
> +                       p_ev->eir[eir_couter++] =3D key;
> +
> +                       /* Move the data in the p_ev->eir that will be se=
nt via btp */
> +                       for (uint32_t i =3D 0U; i < len; i++)
> +                               p_ev->eir[eir_couter + i] =3D data[i];
> +
> +                       eir_couter +=3D len;
> +               }
> +       }
> +
> +       if (p_ev) {
> +               p_ev->eir_len =3D eir_couter;
> +
> +               btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, a=
dapter->index,
> +                sizeof(struct btp_device_found_ev) + eir_couter, p_ev);
> +
> +               free(p_ev);
> +       } else {
> +               btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, a=
dapter->index,
> +                sizeof(ev) + ev.eir_len, &ev);
> +       }
>
>         if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected=
) &&
>                                                                 connected=
) {
> --
> 2.45.2

There is quite a lot of lines going over 80 columns:

https://github.com/bluez/bluez/actions/runs/15579687793/job/43871802897?pr=
=3D1336

Also notice the usage of sizeof(type) rather than just use sizeof(var)
which normally is a lot shorter and may help staying within 80
columns.

--=20
Luiz Augusto von Dentz

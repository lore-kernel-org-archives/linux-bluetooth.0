Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C978270ED7
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061897; cv=none; b=oPA+jujsw2CHmQd17VmY3VeM/cK1nbJsK0pnkg7M2FK7Cr5y3rtOYHIO15UuVXgM0i5rwpQiye083knu29qIJKN8f8hrenY2552Obg94nNOdU9Thb7xqAsUe90t97iMFlE+f6Fhtz1H9XvALTi1g/wNvykZnvYYJ/KjmOfG1lAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061897; c=relaxed/simple;
	bh=j8aN5nRfDeTx4WXr3RnnrLD752EYqlLStvldpRGrYZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mru+vh5OKIzuYybPs4O8m+c1mK4QCo/1xdVb/zQJOOk6s9x94RJxQf74Ntd1UUhtIHFuVTquyVnoLTpWjBeYoM0iHzBUfEVlw8aIjoB0hjm9AqAji/nSrixQEyE8rYYoEvsnLdibW5PSyI1mst0iP/Sc0ujHllGb2tB5SXdesh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV0G1vqk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV0G1vqk"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32e14ce168eso10276561fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Aug 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754061893; x=1754666693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3POoRucE6+LgKRCq+mkTUTB7OFoSht7g8BEv7mebAA=;
        b=QV0G1vqkj3UOvl05hP31Hca5zdDAUT5sVVdtMgaVkXr9ul1BafO1cU0h3BjLwLXBd2
         HjFBOG7ecR2p+xlYCZ/3tO1JtPLbvjhAtSo7bHOewuaJHB4xSSwdibii1kqFInAuzAgY
         pdDEtbGLLociaAJo5aCknBY7srNzMqIN27SIMr+Y+WvZNyZpkVeA5F0uRNItXFl2yuF8
         EEpwesgjxWdXhbE9K9RBDQ9jqZtzEaRFbxcsxGgmFBw3RA2OeBxmLthYEq+BCYz+dqqj
         +7Ha77uJl2xSeEvYkK0oiFEB38nNQ5Q9YDs0pPAhQFNyw/bjizXdRuiUQ3eVjScUDf61
         JEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061893; x=1754666693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3POoRucE6+LgKRCq+mkTUTB7OFoSht7g8BEv7mebAA=;
        b=A7Nm4uIviu2ICF1K3FBECPiRKzAAm53yzY8Sv6DeK97wJ5vGsvv4vg426xmqpAGrko
         Lt9PpZaDbgeAeD2cAf+SUr/3TU4xUVu8IjPZjWo66FkqGas8Osaaa+Ub+AknpeJJ1bpW
         gcP+HDYwJstImyiV8G/NfUN4NxxewbkwJaADkYXsteOk3im6HVx2xtCiGtBv/9qBlVlW
         3LhhL2OMf0AULzAIwl9d5nJHGOo7DQzh18WjHc3IIP3MVJIbWZ7K1/HrzF4f0q/Sl4Xq
         nwHOp29boe3gQBITZdMm9MVJElPuMROG1MbnO4oYOYaSUHJIMD9PBOlCzRYN1/1S12l2
         twEw==
X-Gm-Message-State: AOJu0YzfBBnjJmEQ06/KkSutHgk4EKPMbrLrPDL02M4xVSYrPGezQBtz
	+Y/T8ObDZkPdSrLjTd6DGGlUATRgGeCqPyfEkyCPXvMXFRDjNXlzKXBmORARlOS8vx0PjOQVbt6
	K5oCObmk4uO+HXtPndWzvlnjMiNKo0HuLlg==
X-Gm-Gg: ASbGncughzsyYltywBwvYEw93nT2lm/SPRonlVd9vwcjyvTtY675URa5W3hGrQ3H3i0
	kJkGVbd4dIq5KaFqsC4TGwZdQi8Ds8GUCEsM8+p/1pajvQgUePEVgh2wY7h+s9yxzeFWxGgreyh
	NIlErqG50uhzHOGQICzCboMkFud8iQBYEJ/Ps2ukG3MzP8wsJzkGdvmVc0es7hfCUTwLE8gVX+8
	ZZajLDtpgtNLBZ/9wk4lLheWLY=
X-Google-Smtp-Source: AGHT+IEs601mHkzlkA7uyDFuWIsuYYTurhgqMnPOSuUf4OptxsQuUsQdOF26sV+QpCmvlt48xPYy/Q8ihIhEJGEDMrM=
X-Received: by 2002:a05:651c:2155:b0:32a:78f7:9bef with SMTP id
 38308e7fff4ca-33224a797a7mr25153991fa.8.1754061893176; Fri, 01 Aug 2025
 08:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801070909.7890-1-adrian-constantin.dudau@nxp.com> <20250801070909.7890-2-adrian-constantin.dudau@nxp.com>
In-Reply-To: <20250801070909.7890-2-adrian-constantin.dudau@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Aug 2025 11:24:40 -0400
X-Gm-Features: Ac12FXwl4vGD1K4FadtR4H9W9gTrNJbwge8q9ABjvwVd8xJV2nzEEQ_NDoFFNWU
Message-ID: <CABBYNZLW-MDJhD8ut-ovjjSnMYgdqtoVDTdAEMxsmBBfLN0PLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tools: Expose the raw advertising data available
 on D-bus to PTS tester
To: Adrian Dudau <adrian-constantin.dudau@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Fri, Aug 1, 2025 at 3:09=E2=80=AFAM Adrian Dudau
<adrian-constantin.dudau@nxp.com> wrote:
>
> This patch extracts the AdvertisingData property exposed by
> bluetoothd on D-Bus. It will iterate the variable message structure
> and will construct the eir buffer in the format described in
> BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Ok, if the idea is to use the raw format then perhaps we need a
different approach and just expose the raw format directly, that said
Id probably expose it only with main.conf:Testing=3Dtrue so we don't
really affect the D-Bus API to raw advertisements.

> Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>
> ---
>  tools/btpclient.c | 98 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 94 insertions(+), 4 deletions(-)
>
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index 055270edb51b..5d5a7ea4a2ae 100644
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
> +       const uint8_t *data =3D NULL; /* AD Data will be stored here */
> +       uint32_t len =3D 0U; /* Length of the AD Data buffer */
> +       uint32_t eir_counter =3D 0U; /* Count of AD Type, AD Length, AD D=
ata */
> +
> +       ev.eir_len =3D 0U;
>
>         if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) =
||
>                                         str2ba(addr_str, &ev.address) < 0=
)
> @@ -2538,11 +2549,90 @@ static void btp_gap_device_found_ev(struct l_dbus=
_proxy *proxy)
>                                         BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
>                                         BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
>
> -       /* TODO Add eir to device found event */
> -       ev.eir_len =3D 0;
> +       /* dict_iter will contain the variant for AdvertisingData */
> +       if (l_dbus_proxy_get_property(proxy,
> +                                       "AdvertisingData",
> +                                       "a{yv}",
> +                                       &dict_iter)) {
> +               /* key will contain the AD Type,
> +                * variant_iter will contain the variant
> +                * for the current elem
> +                */
> +               while (l_dbus_message_iter_next_entry(&dict_iter,
> +                                                       &key,
> +                                                       &variant_iter)) {
> +                       /* Unpack the variant to get the byte array */
> +                       if (!l_dbus_message_iter_get_variant(&variant_ite=
r,
> +                                                               "ay",
> +                                                               &array_it=
er))
> +                               continue;
> +
> +                       /* data contains AD Data,
> +                        * len is the length excluding the AD Type
> +                        */
> +                       if (!l_dbus_message_iter_get_fixed_array(&array_i=
ter,
> +                                                                       &=
data,
> +                                                                       &=
len))
> +                               continue;
> +
> +                       if (len <=3D 0U)
> +                               continue;
> +
> +                       p_ev_temp =3D p_ev;
> +
> +                       /* Allocate new buffer, recalculated to sustain n=
ew data
> +                        * eir_counter length from previous data,
> +                        * len is size for new data,
> +                        * 2U (1Byte AD Type, 1Byte AD Length)
> +                        */
> +                       p_ev =3D (struct btp_device_found_ev *)
> +                               l_malloc(sizeof(*p_ev) +
> +                               eir_counter + len + 2U);
> +
> +                       if (!p_ev) {
> +                               p_ev =3D p_ev_temp;
> +                               break;
> +                       }
> +
> +                       /* There is AD data elemets to be moved after res=
ize */
> +                       if (p_ev_temp && eir_counter !=3D 0U) {
> +                               memcpy(p_ev, p_ev_temp,
> +                                       sizeof(*p_ev) +
> +                                       eir_counter);
> +                               l_free(p_ev_temp);
> +                       } else {
> +                               memcpy(p_ev, &ev,
> +                                       sizeof(ev));
> +                       }
> +
> +                       /* Populate buffer with length */
> +                       p_ev->eir[eir_counter++] =3D len + 1U;
> +                       /* Populate buffer with AD Type */
> +                       p_ev->eir[eir_counter++] =3D key;
> +
> +                       /* Move the data in the p_ev->eir
> +                        * that will be sent via btp
> +                        */
> +                       for (uint32_t i =3D 0U; i < len; i++)
> +                               p_ev->eir[eir_counter + i] =3D data[i];
>
> -       btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->=
index,
> -                                               sizeof(ev) + ev.eir_len, =
&ev);
> +                       eir_counter +=3D len;
> +               }
> +       }
> +
> +       if (p_ev) {
> +               p_ev->eir_len =3D eir_counter;
> +
> +               btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
> +                               adapter->index, sizeof(*p_ev) + eir_count=
er,
> +                               p_ev);
> +
> +               l_free(p_ev);
> +       } else {
> +               btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND,
> +                               adapter->index, sizeof(ev) + ev.eir_len,
> +                               &ev);
> +       }
>
>         if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected=
) &&
>                                                                 connected=
) {
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz

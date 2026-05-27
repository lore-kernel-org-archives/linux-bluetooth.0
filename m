Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473934E75E
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916588; cv=pass; b=D7gJLT5JIjjby/k3dtJ11tJdQJIdPCca4/yYxBsrbHkDLaayILBhFPsZAJciUW9vbjLvJFZoGhGi8Jxpt9YW2M6LjVK0Iuio9ioZPnW0mk3NTZyYOFqHYG42EyBn3vCKy3i9UoN6KlhL9OCDfwjhbAbp48H3EUawoVsoQlozbC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916588; c=relaxed/simple;
	bh=IVMQftOxFnPN16u/NPRu1KPbFKI3ofKP5GNvLu6+UK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shAbsd8to03TBF4t9lQwkwQb0LILfyjlAXuTIKcsz6/aQh3zNg2X4kEbp30/ulSJa71qrkNXr5Yem7nKBqUncipwZyh97sVVey0KPr71AAKgtzmS5AiTgDzoJy5mFuikiEevxOgXh8dB3sCGiODcb9YTURt9SsYjpucMcsBhizE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKnWYcVr; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKnWYcVr"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so12087049d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 14:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779916586; cv=none;
        d=google.com; s=arc-20240605;
        b=ViQzM+r+fX6JlOc4wx5dgcnTHxEbJ86jgaFt7rUGjDGQo//djxjWLj96bt1UychOZA
         bEn9tvoRtu2TNYRnkNx4lvUMJl/7VxvQUMLpmZdYSt/igGhXGdmQSIBxahO7KIlG3COd
         SrQIf/VG4MhsktLkARNlAS1TQJ275FomIa+AOu7guBAbcfSFKg/VZmgKaAMgq5dU+81l
         nAM6h0Kt26rcCiawRKcKaBUSJuzStIVgsMq/EmuQO+VBLyh8HSHldS/BjkkHRd43Vcf4
         ZKdUKTWPAlRbirpOQExz8895W2CSx9DM5DlEgSP8mQI723WAYOBl3ftnSJTxsoEVHQii
         IrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KCPC1P3XFAWCX8rPdXp2ZD8fB2lQGeYCXb21LibMlO8=;
        fh=1K7M3FjntfzuPoN0fuUH3r7WVaWhgGUkd0CT0Qb+gKg=;
        b=aqPqHg5YpL6LW5TWUMpJhz1nlGxlTvsCcel9WHePOW3cmE6MfPjk1z3G743t238QNM
         RSVa3pVheWkK4nm5pifmgll3Rctc68LaYXIA2dAyNbBgb+AG40iTJX7QMUkupEHnB+/U
         qEL2fWXE0fehOqUCVJYeSz8er1AwGw6iCqzMKJrh8BPQV17zcRqygJyR2TFdOv1bnJPQ
         tocShfb+RASZzUjV6ZcjD8gL1Y7aIpPhlBVF6GPwUFG88MBrfil2fZvG9XvEzEBjdJCP
         ngFjRt9Cyy6CKC6VDMj/j/PhqPfmvMVTB02b/xjjB7Il4vfbdl0tmsVvdeLh50h74/l3
         ZU5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779916586; x=1780521386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCPC1P3XFAWCX8rPdXp2ZD8fB2lQGeYCXb21LibMlO8=;
        b=IKnWYcVr5ZEDYNLExE3hUNGZX30TayIX130BDQk1apiPz8832RBiRflQI9HpmGPoeF
         2k2kDxEmd5ZatIZg25PXsgnMUxYgkiG4yghk7FM+yjdwiYZNzHr5mXts9YNzNHS22kqp
         okEuTiy19w25EEt0vSw2j7/GXxmL6k8aXzJgkggRxPldMHm5urdk/lfI5+668OzRckLq
         bQXNnnIlj3oGh3LKfRuxHFavwUT0sjR0EK2zh5t/Q5peoj585msRcP4m414fjmwnvHUA
         UYYuSPrZ8k3VOnjFVefebyBsDDxErdQWzEy//Zbh+yhT+jzX6fMmuxFC1mvq1WbdXZ9K
         KkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779916586; x=1780521386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCPC1P3XFAWCX8rPdXp2ZD8fB2lQGeYCXb21LibMlO8=;
        b=GsHMW+6CseRvr5gvow2tQv0JGPoFhJXbeq4Yt4XymiaGwYaELK5UoP79jN8/+zPLNi
         jUJJ/znMd8nuJNgPm0z6e8swr+HbogFj49wqUITLH8n00eitkt2hP+NDgAC43sFKD+tn
         oUE6fNwVKSAvsYZ/fW7qOdM6pt+SD0WBUDmYzBjfvK7A4YZ3fOwMpk4QfZ5TVp5yMQVc
         0PEZVJopEIg+1+559xnEjmBDbLe8GaWtUoFfyPm+STndyaqcPGM6eaPow7fm2thiNyNr
         uHyX7EdxJErtaR5rVEIvdErBR8McJlNAIfGTCLhkOhVJ7Sbf/ETDD+1DKmnrSzY3yj5d
         pHBQ==
X-Gm-Message-State: AOJu0YzeWirvwehBJZLkmENhItdOT9cu6E6FJggerfJj6R3X1UnPNUIJ
	vIGmNiyUfmc6AnE8zLcXYX6FkX39aGWfubFrdp/d9v12iicma+v5+osGNX5hMJZEtuLJz+s4xyC
	STmMVz20CMxa4vB85DBizSgzJfFtKAoDblv/C
X-Gm-Gg: Acq92OExC/NrtJr31weYYr5MuSZZr5wChRURFy65YZ85rPfVvbe0fXEIIENmjtZN0EL
	fywJICaI7GC6zF12evngGTzCjXIg3J6ZR78zv0qp0GRijbc645tbLkuHG8t03xVFkLI40nIFXRR
	46j+GLRz33lN9D6bNvlQqwJOJf9osETh+3pinmeiFJDahtAvpbARCFVGs6sqQfIZYBuC01cfbYH
	DRaWa6ptHev9LflsM51AKfPUHOwF67c0zW7A2iY8DmoQrn5P9cYmEDJb+lNTjVGexoPQglAWAa+
	Mn00cA12RvQM2kElZ71XlnCSiskit6ZN/4Hz9juvckSmzxAmVv/USDePvrxNwkcAjEOjqweAohr
	Zbyw3+ujU7PtjQCo=
X-Received: by 2002:a05:690e:b8b:b0:653:8b36:f204 with SMTP id
 956f58d0204a3-65ec91032ebmr23229251d50.0.1779916586202; Wed, 27 May 2026
 14:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525041151.3893522-1-michal.dzik@streamunlimited.com>
In-Reply-To: <20260525041151.3893522-1-michal.dzik@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 May 2026 17:16:15 -0400
X-Gm-Features: AVHnY4JgcKlTDWPB5iwcC7ZgofaH_dvLaMS99mk38hfHM92tAKSlWl5eSRwPxbI
Message-ID: <CABBYNZ+Z+TA=TVtc8tdv7N_FPLqWDzXTyJJtMpfyNwLJCEY88A@mail.gmail.com>
Subject: Re: [PATCH BlueZ] advertising: add property with advertisement ID
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Mon, May 25, 2026 at 12:12=E2=80=AFAM Michal Dzik
<michal.dzik@streamunlimited.com> wrote:
>
> Identifier is an internal value, but it must be exposed to client app
> if client app wants to use a advertisement in BAP broadcast
> ---
>  doc/org.bluez.LEAdvertisement.rst |  6 ++++++
>  src/advertising.c                 | 13 ++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertis=
ement.rst
> index aae80f08f..4dd36a0cc 100644
> --- a/doc/org.bluez.LEAdvertisement.rst
> +++ b/doc/org.bluez.LEAdvertisement.rst
> @@ -235,3 +235,9 @@ The provided value is used only if the "CanSetTxPower=
" feature is enabled on the
>  **org.bluez.LEAdvertisingManager(5)**.
>
>  Values must be in range [-127 to +20], where units are in dBm.
> +
> +byte Identifier [read-write, optional]
> +``````````````````````````````````````

We use the term instance in other part of the API so Id got with that:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.LEAdvertisingManag=
er.rst#byte-activeinstances-readonly

> +Identifier of the advertisement. Set by bluetoothd after advertisement i=
s registered with
> +**org.bluez.LEAdvertisingManager(5)**.
> diff --git a/src/advertising.c b/src/advertising.c
> index f529ecd14..3b758f51e 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -1511,8 +1511,19 @@ static void add_client_complete(struct btd_adv_cli=
ent *client, uint8_t status)
>                 queue_remove(client->manager->clients, client);
>                 g_idle_add(client_free_idle_cb, client);
>
> -       } else
> +       } else {
> +               DBusMessageIter iter;
> +
> +               /* Check if the attribute has the Identifier property */
> +               if (g_dbus_proxy_get_property(client->proxy, "Identifier"=
,
> +                                                               &iter)) {
> +                       g_dbus_proxy_set_property_basic(client->proxy,
> +                               "Identifier", DBUS_TYPE_BYTE, &client->in=
stance,
> +                               NULL, NULL, NULL);
> +               }
> +
>                 reply =3D dbus_message_new_method_return(client->reg);
> +       }
>
>         g_dbus_send_message(btd_get_dbus_connection(), reply);
>         dbus_message_unref(client->reg);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz

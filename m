Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2254769;
	Tue,  8 Jul 2025 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000363; cv=none; b=p+JH8k7vKOkP+TtYzdtQQhsHu5JqR6Wt9s7torMe8zDFGvYwH7EqrrDgZJ98XCs5Q0LeHIqOo3NOERB2J3IwW82fLX4X+wtXE5qKv0cUGgFQFCWgMSJ05ij5MzPIZBAoMONBphpfJPmSnUDa+tY7OxSWVKqjp5M9r3rUUdpyHtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000363; c=relaxed/simple;
	bh=8dXXfLLdoPFLJfFpfPwne5HOEAelddNRC7uC+1IRMuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMv7BIKJc3m9hkiIf0pWc8Vl6LD6Sj2oOzzTprSh1FN96rSiT5pqIyckcsIPeG/Q9ZT4muFFj4IBHzmTf64tAszHK4Vs1aMVHaKSO91kMk7yMw7lYsVg4fTgUcGJ+sJfoeEqp6WiWQ8DoqoydSO4FVxVpZdXEkalytJQjmqpMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHSNkIvt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHSNkIvt"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso39815281fa.1;
        Tue, 08 Jul 2025 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752000360; x=1752605160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVNW2LmSpM43uoc9ePIuGFhxgCCqgN+VZjCsdL/aUEw=;
        b=iHSNkIvtpsu4XLuPfaOYbxEtTVPFFHe/6tLdKiNPMbBu7As45SOJgNuOszprA+51y/
         3/BTQLtqCABwxmKZxg0CQNaS/EVJiVj07XE91vYGCcueUQGchqsN9KY1qH15xXoOzX6K
         2wAz8t2NSu5513FS80pBOUT+pkFLQcqNYe+2IiZjBuB+R8Uc9Byl5PlU+9j0xaF6X5/r
         IQEbJWwQfQ1Iqy1kRQbdifd5W/tO7bwJAFsw92tzrgoRrL64GBeG6tuSC3GwxRN4w1l+
         KywqlOmSWHOa0nDNSxv6riBM/RK1xRA7ZM/EEVHHC6uyp80htjcTvqiuEKSmkZ4wIGXv
         cc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000360; x=1752605160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVNW2LmSpM43uoc9ePIuGFhxgCCqgN+VZjCsdL/aUEw=;
        b=F8M2SL9RFIh/SNS2HVaMkQ0u41TkowyggbhXen28TmHQNTEw/pbYisSHi8+e2Dy4g0
         bogRsdnlOExF/aQkd0VkdtWj0qWqZ9ugpWC7wx791MSzYFnzeR9V7qmmsbETa2wiyV8P
         LIzOJSFA9D/DO3WE79kkGRAlQedtPD1ZY598jYHSff9ffeMU4F1oW9OKIDxM+4dHoK6q
         j0dKvaXR5YZVeSKtkN/VxKC4O7D6sKzTaHVWZQcm3gQpYH8DUYJEZ5OS5nIKM/4R9KmZ
         SLeY+KFwtKHyOP5n0imB2KalwQvQPLF3Bqi8Ocf4+mrl7YWFCzzrQ6eAGwzwhrAA+e0a
         /Hpg==
X-Forwarded-Encrypted: i=1; AJvYcCWDwIswQQ5HIisijjj12y46MnE3womtNqI7PQVNsP2B6Fn5VHqY3MSMmJl3whq72l9TDjYm2fDvfKy3rh8oBvE=@vger.kernel.org, AJvYcCX0/Qvoo2YsetMmxniNPdq5M7jXx3L7bcE5yTn+wgClXxKdAyQ/hbli4B7n8UvKXasXnnuy9WWqo3F8DQhz@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTTbj03JG8pB96uf33iyym7S4Y4N7m/83UOm+EH+iA8u8YwOF
	txmuDXB+8oAGfO/WAlPxMrqsR/UsYx6XCxGtQ76nKYrz7n4rFEOZFTFZTwuZ7TIDD9u2nHx/A1a
	0VY9g7KQUMyAJtpuJ6GySFHzWc3Bq3g6dWX8h
X-Gm-Gg: ASbGncumILf5dwKKmr0/DcXMsvGC81ktiDoEd8cEKZFs2uOC+eR3FHzWIC0sPzfYWxq
	2+RcKBjaVg504ekZFlAR+2GLij76zy0HmHFgqI+pgIlrUvomzS8qfd2cgg9TKu01PrObrN3Mqdt
	aqCRMQUmvkrPEkikc+21kzZcEbLJAwLM0XS74G3GSPIsmH1dYDjsuPZP3+
X-Google-Smtp-Source: AGHT+IF22uYs5AAzmK5bTeX1d4pT+M02Yu8ssSATceo3IbMWwKQPJSKEdRD9c0W6fqY5retTpGh0QURaGdsFR1snE+U=
X-Received: by 2002:a2e:be07:0:b0:32b:7ddd:279e with SMTP id
 38308e7fff4ca-32f00c94639mr37159711fa.14.1752000359289; Tue, 08 Jul 2025
 11:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708141617.3691-2-alex.gasbarroni@gmail.com>
In-Reply-To: <20250708141617.3691-2-alex.gasbarroni@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 14:45:45 -0400
X-Gm-Features: Ac12FXx_X0wFgoSZOwqoWzzVArII0bAoLYypedj7J7QV9mx7iex-n1ZW2Ew1-XI
Message-ID: <CABBYNZJ9jLwiieHC=ohp+EjtoO7_4Umd2giRKNe1y0u-qpP1ww@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix connectable extended advertising
 when using static random address
To: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alessandro,

On Tue, Jul 8, 2025 at 10:17=E2=80=AFAM Alessandro Gasbarroni
<alex.gasbarroni@gmail.com> wrote:
>
> Currently, the connectable flag used by the setup of an extended
> advertising instance drives whether we require privacy when trying to pas=
s
> a random address to the advertising parameters (Own Address).
> If privacy is not required, then it automatically falls back to using the
> controller's public address. This can cause problems when using controlle=
rs
> that do not have a public address set, but instead use a static random
> address.
>
> e.g. Assume a BLE controller that does not have a public address set.
> The controller upon powering is set with a random static address by defau=
lt
> by the kernel.
>
>         < HCI Command: LE Set Random Address (0x08|0x0005) plen 6
>                 Address: E4:AF:26:D8:3E:3A (Static)
>         > HCI Event: Command Complete (0x0e) plen 4
>               LE Set Random Address (0x08|0x0005) ncmd 1
>                 Status: Success (0x00)
>
> Setting non-connectable extended advertisement parameters in bluetoothctl
> mgmt
>
>         add-ext-adv-params -r 0x801 -x 0x802 -P 2M -g 1
>
> correctly sets Own address type as Random
>
>         < HCI Command: LE Set Extended Advertising Parameters (0x08|0x003=
6)
>         plen 25
>                 ...
>             Own address type: Random (0x01)
>
> Setting connectable extended advertisement parameters in bluetoothctl mgm=
t
>
>         add-ext-adv-params -r 0x801 -x 0x802 -P 2M -g -c 1
>
> mistakenly sets Own address type to Public (which causes to use Public
> Address 00:00:00:00:00:00)
>
>         < HCI Command: LE Set Extended Advertising Parameters (0x08|0x003=
6)
>         plen 25
>                 ...
>             Own address type: Public (0x00)
>
> This causes either the controller to emit an Invalid Parameters error or =
to
> mishandle the advertising.
>
> This patch makes sure that we use the already set static random address
> when requesting a connectable extended advertising when we don't require
> privacy and our public address is not set (00:00:00:00:00:00).
>
> Signed-off-by: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 77b3691f3423..012a9e9a4f9b 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6815,8 +6815,19 @@ int hci_get_random_address(struct hci_dev *hdev, b=
ool require_privacy,
>                 return 0;
>         }
>
> -       /* No privacy so use a public address. */
> -       *own_addr_type =3D ADDR_LE_DEV_PUBLIC;
> +       /* No privacy
> +        *
> +        * Even though no privacy is requested, we have to use the assign=
ed random static address
> +        * if we don't have a public address.
> +        */
> +       if (bacmp(&hdev->bdaddr, BDADDR_ANY) =3D=3D 0 && bacmp(&hdev->sta=
tic_addr, BDADDR_ANY) !=3D 0) {
> +               /* Re-use the static address if one is set */
> +               bacpy(rand_addr, &hdev->static_addr);
> +               *own_addr_type =3D ADDR_LE_DEV_RANDOM;
> +       } else {
> +               /* Use a public address. */
> +               *own_addr_type =3D ADDR_LE_DEV_PUBLIC;
> +       }

Hmm, we should probably be using hci_copy_identity_address instead
here, or have you tried and it didn't work?

>
>         return 0;
>  }
> --
> 2.50.0
>


--=20
Luiz Augusto von Dentz

Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAB74C14
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193624; cv=none; b=O9LEF7Ep57h5ec9fmDEuqczB9J5CXAZQigFZygVZ9qT7V22U3CYEy1RBdpWS9yHfEeUlpUXF0SZ54ux/yjb+2v20up2ITtWtV+7xROpYwf4qaQ+CqVeLvJK2wqGX9SZLVlSsMs3bqcV3dJz1wH6HXgSp3Eia2L1ctd1MSo7R91I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193624; c=relaxed/simple;
	bh=3oh3IvmL1fhEfZLdjkYZCuAvQ7Moz4Ucd+NER3k50gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrfGTkuuwg+9QT5ta2bNqOjcvBYw+TytDgfuvsgo5sLoKZm9kC/JSqOsfGoUMycRNzN0S7R+A5Pu7q869b/2rbXcoazc+APr2TKqseF3aZjTCTvYno45U3nxhLNMqT57lz9my4JOkdAWjpvG8AeEGc31b4nNtXS4k0N9TXYhY8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlBWf03L; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlBWf03L"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so37557551fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193618; x=1713798418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G5X+PRVQ7xkVqh/i95xsAblVEzcYYR/My4u2rLSQtI=;
        b=XlBWf03L87RgySaSXaTHlh5ib5SptpAdV3A+8NnFjl1bhknoshdntlaD5D7iVaQqV3
         KGKnMVBQXCjyGsT/HAiTzw/xg1uqyiUUX0W1aKcFQY8mwqS+Odxmkul6s1y4QkDlttPc
         W3i/CMIRhHaSfZRzZ+UNVbd6X9WnZnMHtfNt1VJeWTQlPJtH4WuDVcODqfocmXMz6tFt
         nnBw7l7jZ2Z7b/5MPcK8roQsYUf284opu7DLMcu0+PoqxFYm3VemifGl4Ai2Up0iioK5
         qNOSlvAey4rR/0NrjKQuEtq0R9ihCkjLfVdT5C0AaLD8h8+9QA3f2XbXUU2GWzVr+C9o
         8utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193618; x=1713798418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G5X+PRVQ7xkVqh/i95xsAblVEzcYYR/My4u2rLSQtI=;
        b=S/nf/rmVB3uNpd9hi/vBRtgI2/rRbBTYxGV/4AUJCE4PyMJlqq6r9RBZhh8/r5OKXR
         BlQbwpUyxY077Dl0MMOL6rk2fpJdVafnzmJGHZJA+bMG52sqvdrZXBthbC9FfUsPtefD
         T3A+B1QUF+zN1tJDgNZRXNqhgG3Jp2z6WOM7BjT25K8znrrObzrVUAFpAiJKNll32Z9P
         CsH9p+d8BaJ24+IL7oVuaUcYouCmXfuzOjN8RosMUt7mjuxjsSWgNqpIcqxTizb6WqPs
         ugSVdxPCnLG7R86zWispzMQCCyHXblMI5U1Fb4xNeyBMlHvsOCCjTHwoMQ5i5R+yJi/H
         oaTg==
X-Gm-Message-State: AOJu0YxJXDYJZ/HzOYfsGj9WiorrTE0srwr1kmniszc+Gi9FTnWR2tr/
	IfmwJp8YxBeXcjpWkI+xmcoHM6wE+Kzzk2zzpI7AAaqk6oby1UsAiSMjjOKuzcxzgJMYXAtsYKA
	XW3kkWP1i+5EHXKGL4j1F4k1DkR0=
X-Google-Smtp-Source: AGHT+IERpEeyqiWd7leO8mu1PKxWsb123LPx+mZkfUj0Y6bapvlNpHM/bi9RidMgXWa0hI4ACH4DrldHv58TXgl5550=
X-Received: by 2002:a2e:b00a:0:b0:2d8:3a02:9113 with SMTP id
 y10-20020a2eb00a000000b002d83a029113mr6186765ljk.12.1713193617926; Mon, 15
 Apr 2024 08:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415144430.34450-1-vlad.pruteanu@nxp.com> <20240415144430.34450-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240415144430.34450-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Apr 2024 11:06:45 -0400
Message-ID: <CABBYNZ+DXQf6UF-uHSwY4RSA5NjKaFZjEeQvjHWjj5zYL1OdJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: hci_event: Fix setting of unicast qos interval
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Mon, Apr 15, 2024 at 10:45=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> qos->ucast interval reffers to the SDU interval, and should not
> be set to the interval value reported by the LE CIS Established
> event since the latter reffers to the ISO interval. These two
> interval are not the same thing:
>
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 6, Part G
>
> Isochronous interval:
> The time between two consecutive BIS or CIS events (designated
> ISO_Interval in the Link Layer)
>
> SDU interval:
> The nominal time between two consecutive SDUs that are sent or
> received by the upper layer.

I assume they are not the same because the ISO interval can have more
than one subevents, but otherwise if BN=3D1 then it shall be aligned, so
we are probably missing the BN component here.

> ---
>  net/bluetooth/hci_event.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 868ffccff773..83cf0e8a56cf 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6824,10 +6824,6 @@ static void hci_le_cis_estabilished_evt(struct hci=
_dev *hdev, void *data,
>
>         pending =3D test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags)=
;
>
> -       /* Convert ISO Interval (1.25 ms slots) to SDU Interval (us) */
> -       qos->ucast.in.interval =3D le16_to_cpu(ev->interval) * 1250;

This most likely needs to be le16_to_cpu(ev->interval) * 1250 *
ev->bn, anyway it probably makes sense to indicate what the BN is
causing this problem.

> -       qos->ucast.out.interval =3D qos->ucast.in.interval;
>
>         switch (conn->role) {
>         case HCI_ROLE_SLAVE:
>                 /* Convert Transport Latency (us) to Latency (msec) */
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz

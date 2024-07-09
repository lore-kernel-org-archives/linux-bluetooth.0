Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074719A284
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533743; cv=none; b=lT5LjLAi9XarrAygx0xUhCjJ5PDZOhoTqH4p7zZgIQ9JHNKJ1oPlDPKrUoG/Rfq/D1yQV4+vHLb0ygHOrkJ/DtSOPkR3ZKeKHFXDsIaKLguY9iko6CwUVtBQan4ZvJ7Zccvyt2atyQyAgeVfXHO7Kf1AmYKKmCBj6uEgLw9QMCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533743; c=relaxed/simple;
	bh=HXzMVvqLp5MFTG0CufPINnKmyrWO+fA0DWgp2BS+Hy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skaxoztaDJDaSbqkiIxdJlrL5H63h7EVAMS9bJgmnsxZdzUpgy7w0tSYXduebCX9E3ADaYA/oLp9Tssmw9X4N5SGRXlOhJRqe+ReY84WBtwpBZHLex2OVoj+jqDPaUozP97Z8QsHlkMYPFttU1b1LtRu++1PVyGplR89KLktm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMf4M2ba; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMf4M2ba"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so54821081fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720533737; x=1721138537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9K9MfhAivN0UzKP3RXFB4hX35iC5phezLV5mdYAksI=;
        b=XMf4M2babH6tRV++M0ujhQXgaVtcBOqliik1ScIJw6wcwA3lwPh4cST9Q0ZmP1BtGH
         pZ8ASf3rpc2RpLYESY1/O3jZDY3KXHrxFAEIXhmd5XgOM59wFFNappCYDJrnmPmOrEUU
         b6a44R0kX1XP++ET7hivy+rqhcsrcSj//zZ+nXRO/AAg/KNlsCHflobluDuOu7UHVu5z
         3H6+5TxW5+q2N6rAw3EQyleEBaExgWwFIh+ZcHeH0hLHU3m28fufC40/xG4qjXOER9JH
         QdB9IRP2SggI5uQPan8FEPF2AaTgjuSxw4t/kCPqhCU4j7r921WLekwN2OMAH8o8N197
         9DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720533737; x=1721138537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9K9MfhAivN0UzKP3RXFB4hX35iC5phezLV5mdYAksI=;
        b=aqAEKaro1wY1lzkco21R0CkKGuZddTK16M12XxTSKC9ofOdNMoZSMwm4oR8TPRnZvl
         Li4+sqrqDkhjqgSn8Rmt8R9PeEJIqUYRTEZIbL3siWnKpcTMoE/Kc5utsWziDbP2n1bV
         0bjh+HMyykIFWjHYpaVZXOJa20lKWqdU4f3HniMmC3NujWdrI+Ia8jUBU0rX4XgF/Tjz
         cCdGKtRoyHY7IL4hJEVdna2W/GqK6yRQg00Tkl+QLSAo751r/7tj23Qd9bQZEFSRW8BK
         C0PKpPvuAfOQuz35Ra30XQhish4JkzEnNkYgDjvP3b8TT2DI6592+QxALRo2xuYcDM4z
         xPRw==
X-Gm-Message-State: AOJu0YwXn4Iy1oc9NZU7cy/d0F/nTXy+rF0WaaEKsiE1o1eVDL9TxPxp
	vzMT7rtTT6Xxv4kfRKxubWQHhvaXezwibWFyQTZQNQAAfIxo23RElT4japPrC8qIUl0NM8lGyS9
	wIFAlOboo0b8V3g2HdAxK5oQX57ppPmpl
X-Google-Smtp-Source: AGHT+IFS06O0QA4a4w7NfRBzUEmgwK6o27HABFmzD+gBV3cYk8BdRu0LyJFQ5RgBFe1mXYYbWA4PHap0IS5JdJJydkI=
X-Received: by 2002:a2e:8199:0:b0:2ec:c8:2755 with SMTP id 38308e7fff4ca-2eeb30fd5fbmr16899461fa.24.1720533737124;
 Tue, 09 Jul 2024 07:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709120031.105038-1-r.smirnov@omp.ru> <20240709120031.105038-4-r.smirnov@omp.ru>
In-Reply-To: <20240709120031.105038-4-r.smirnov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Jul 2024 10:02:04 -0400
Message-ID: <CABBYNZLK=hqsn1RxAweXChkr_LB_w70gjJYuNVOKMOQwPc8gMQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 3/4] settings: limit the string size in load_service()
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Tue, Jul 9, 2024 at 8:01=E2=80=AFAM Roman Smirnov <r.smirnov@omp.ru> wro=
te:
>
> Calculate the length of the first string and use it to create
> a pattern. The pattern will limit the maximum length of the
> string, which will prevent the buffer from overflowing.
>
> Found with the SVACE static analysis tool.
> ---
>  src/settings.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/src/settings.c b/src/settings.c
> index b61e694f1..4eccf0b4e 100644
> --- a/src/settings.c
> +++ b/src/settings.c
> @@ -187,13 +187,30 @@ static int load_service(struct gatt_db *db, char *h=
andle, char *value)
>         char type[MAX_LEN_UUID_STR], uuid_str[MAX_LEN_UUID_STR];
>         bt_uuid_t uuid;
>         bool primary;
> +       char pattern[16];
> +       char *colon_pos;
> +       size_t len;
>
>         if (sscanf(handle, "%04hx", &start) !=3D 1) {
>                 DBG("Failed to parse handle: %s", handle);
>                 return -EIO;
>         }
>
> -       if (sscanf(value, "%[^:]:%04hx:%36s", type, &end, uuid_str) !=3D =
3) {

Can't we just do %36[^:] instead since it is the same size of
uuid_str, the only real difference is that it reads until the ':'
rather than until the end, but %36s is also _at most_ 36 characters.

> +       colon_pos =3D memchr(value, ':', MAX_LEN_UUID_STR);
> +       if (!colon_pos) {
> +               DBG("Failed to parse value: %s", value);
> +               return -EIO;
> +       }
> +
> +       len =3D colon_pos - value;
> +       if (!len) {
> +               DBG("Failed to parse value: %s", value);
> +               return -EIO;
> +       }
> +
> +       snprintf(pattern, sizeof(pattern), "%%%lds:%%04hx:%%36s", len);
> +
> +       if (sscanf(value, pattern, type, &end, uuid_str) !=3D 3) {
>                 DBG("Failed to parse value: %s", value);
>                 return -EIO;
>         }
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz

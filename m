Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C11BDCF
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079014; cv=none; b=BHEza11mWgpEDbe4E98vPg45PFR0K/AiV6IJw+s1e8Ji+8WSpmHqIthIpSjo9ojEuCkF8HABL+tbqX747z/meLonDrnekv5WA1IHAMCYyBwUh9nF8xb3Ar9PgLCC9sZrJ3aH7EkLD6kbRRf9wcWOTD3lSlhObjdiuuyM4Hqj5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079014; c=relaxed/simple;
	bh=2llCW8KLBq7UbOYx6K8XZMraxESz8wFCkXmh4t4byQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lxnsgf5YR2LF6U8fiqNU79Yke8DWHRxM/YuNr58a0AvrVCz41Asqre2R7gdY88L6cNigaKv4TIFhs0Z+NF2HgR77/7yOvD3IzzvqVgZ7Gb6Nrlz3vcKM098DsB4p+l8l/eOYSVvrySB+lXChHLoznarax/puCwvHJEwgcfC6UWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJQzHevV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJQzHevV"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3e2f5163dso5037661fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724079011; x=1724683811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItlTxF43SUIEgaerVaIsQQis4cN8edgndpfV/1OkxnU=;
        b=FJQzHevVUWegnBtVhtQNHT8cZOmR2nnlvkKhokGassGAfzxvhFU1yPaW10euoExkjE
         Rw9fZQ4i5xaZS/Y4+9GZXglHtuzDBuLF9fvJMke8gSiK1v8T9agWPWc6CEs26Y0vUqOf
         ppsQFOPGcP+V4GwihDLODWoPKTkTwPqS2JdmgRZnALq8LeFYLs64/KmAOT2MFNQ3wOl+
         OUvymMnOSiMziTLJeoLY3snh9BMKrIFpIvJzHCy72qUqhvrKaaKNfBfJB247btFFa9x3
         ZdX0lN70UBo8nu0+GGJH7YN5yYP23F0U5aEZibAtSdgEMBIOnC4US7uxMHrpWkyFjira
         ILeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724079011; x=1724683811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItlTxF43SUIEgaerVaIsQQis4cN8edgndpfV/1OkxnU=;
        b=qyQ5MbARKAFUMSQjAS9Q0U/oGIbYqEh2S2p+WPeuQ+NJV5PlMIq68XYLqUE3cfXDUO
         Qye9CYT6GcAyW8uQIZOm7Oa75HyWXs+ZE9je1ksz3bqPJF0tAuLRsCp5VsuNT9XvMruO
         d2SpEvONeW7SIABRG8hGBVyw9GEFGjYPIeTf5RJ8x4bXqDKxduC1olGdzAAksqweSbI8
         hlgL5aXQRPQnIdlBG3eziHTHWQdYk4TaFX8RcLK1bIVMEGQS4IxfPdHkE0e+G5DGDf6Z
         ee5jS1AgNEkq1az66diMx+Sufa66C2gPK0fQUDTvVVxTmAK/lzQMGYItjHdox41SPLMS
         DqPA==
X-Gm-Message-State: AOJu0Ywl3NHcbhleEAJqxontPrGHKIB5/kA5f+F26i0Tv1NSKuN2l8J1
	khkG35nJtXEdKO+Uk0H99zMNsaVNpNySveU3SnTjbHu4uvUAi36ZR45NRISFij+Q4IHQtbfYw5K
	nMN+UtejjXGTcJ9YiFHUy0jCyQzV7kB/X
X-Google-Smtp-Source: AGHT+IETQXOa96DIlSVj8SaLosGfeKR2n1mIIK6RIyh3zw8d+Ek32/xmDq98Ip5XIC3a/2QlrzK3KYZhWn1zETi7g4E=
X-Received: by 2002:a2e:8717:0:b0:2ef:24e8:fd83 with SMTP id
 38308e7fff4ca-2f3c8f25f54mr49117541fa.38.1724079010732; Mon, 19 Aug 2024
 07:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814130018.263129-1-frederic.danis@collabora.com>
In-Reply-To: <20240814130018.263129-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Aug 2024 10:49:58 -0400
Message-ID: <CABBYNZJsmq6KYEZi9+KbdtN40uoi+6M6j+D5-a732X_34H1-fA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Use speed set by btattach as oper_speed
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, Aug 14, 2024 at 9:07=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Starting a BCM UART controller not defined as a platform device or
> a serdev with "btattach -B /dev/ttyS1 -P bcm -S 3000000" works fine
> but the serial port remains at the init_speed, i.e. 115200.
>
> The oper_speed is only set if a device is declared in ACPI, device
> tree or as a platform device.
>
> When no registered device has been found this commit will use the
> current tty speed set by btattach as the oper_speed.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>
> This has been tested with 5.4 kernel only.
> Afaict there's no change in this driver which should be impacted by
> this commit in latest kernel.
>
>  drivers/bluetooth/hci_bcm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 89d4c2224546..57cacf63ae12 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -508,6 +508,11 @@ static int bcm_open(struct hci_uart *hu)
>
>                 if (err)
>                         goto err_unset_hu;
> +       } else {
> +               /* This is not a serdev or platform device, it should hav=
e been started by
> +                * btattach, in this case use the tty speed set by btatta=
ch as oper_speed
> +                */
> +               hu->oper_speed =3D hu->tty->termios.c_ospeed;
>         }

While Im fine with the general idea of derive the speed from the tty
what Im not sure where it should be done since doing this on the
driver may duplicate the logic if we later found there is a better
place to do it.

Looks at hci_uart.c it seems like we could actually register a set_termios:

 * @set_termios: [TTY] ``void ()(struct tty_struct *tty, const struct
ktermios *old)``
 *
 *    This function notifies the line discpline that a change has been made
 *    to the termios structure.
 *
 *    Optional.

So I assume when the user changes the speed the above callback gets
called and we could then reflect the changes to the oper_speed, or
perhaps the real problem was that hci_uart_set_baudrate was not
called?

>         mutex_unlock(&bcm_device_lock);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz

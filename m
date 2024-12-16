Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513024B34;
	Mon, 16 Dec 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360750; cv=none; b=WHnsZZISW+XXtZXRuF4se1KuGBXH1EofUWcjQKgDGhcYmytIVWwCiIisRtlO1p9jiiLYMCyc+tEUPRMSK7Buh8SWGJDVqijz6tY7v+J8JqvCEfeMxhuH/dtaAXrZLYeI6l4kvJD9P1gq7kR2TxF8nyqIQI6TR6QwozsdjNQSmbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360750; c=relaxed/simple;
	bh=n7fpU+SC39T8RldMuPqzx9FZJoD/RN0VzaM8P5PZLPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViiFIJbABw8AusZMc5MV+nJf4mSBnT0zGvFBHFsq5BdQHExinC7xZy/uuahHvKGwhfQgBpfY96eXa0PWJ1USwlmkJ7hwcuTe1gv+6R+/hKPU8o7+m6h9VFWBTPRTz41RstxI3TeArdR3I8vDvMLXoQrdESVjbEolCgvuPMcH2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePym7UBa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePym7UBa"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3022484d4e4so47793631fa.1;
        Mon, 16 Dec 2024 06:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734360743; x=1734965543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trdXo5m3hzsJ+wm6hIAb/8LUnuB+TKKoS08uSjvrSH4=;
        b=ePym7UBaP5FTQuSdnn5VlpNX8JhzYN5u3oRu9+epERfsvj+XC3YOOhWzjTeneMOjmu
         qEQ2o70e3KDlQxam5xFAfNtC/Ni8luj48l03Mz+OZMEhzDDTdd7sTD3+NvcVOMX8+HRU
         vW0SvvegaxJ4B8Yo2HHKxuox1GAJndEFDHwtn8xyw4p3wpsyR2eGnhO1aM8i0gU3FQvJ
         cLF9+aH9hgYfAa1RPCjkI+jdfoTM2QPR049pEsSVI3Hx0DQe4e8rio6WXSPQNW0tSqb+
         b4lRgkCqWFwgiKpYzwZT6dYu0BO4Vzqkdi/Pg2SJBVISbBaXSCMcmh2XqjkoBR/RfTjc
         g63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360743; x=1734965543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trdXo5m3hzsJ+wm6hIAb/8LUnuB+TKKoS08uSjvrSH4=;
        b=fVRCn2mEVz4czu/bAfdZL8RuHIgcmf8APYUjxyBnJ4xvlEh59pQThbWvxF/w3nqolM
         3yDclAnVhcDRJ2PAKfSkBPDhn46rjG/G8yDt1/jRVi1CGtLFCyXQipEEbWDuWfKKtymy
         vuMyMlwXcYtgj/9TspbzIWEnsnypi+PRtHq4BFzXZykJrvrhSZGsB+8Wga8snQC2FQau
         yPcyYxnLLcptF67WkaWTi21cKE4CJ/Cth4MZ250aya/Sa8HNR7P28Ea/QaHOxVTl0oeb
         nO65PCzicZgIWvfMU+djKxl26wlRddBEC7Sw8kgHkXsmgfPgFTTshHxNgxHY9BIEmjwD
         NJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCWUxusMv6UHM1EJzgHX47QylkbnWi1NU5+/nMzJTeBOWBfAgc4m5kOC0qQSWgi1TwnjqUnhRvE2MJUvd/mY@vger.kernel.org, AJvYcCXajaUa6I8voQTTq5AiIs5XRDBGVeDbQP/4v5mjwlKF2mFVhJA+b4h7Zc9bfOqjLb2J38holF/HWOXUYlKe7GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUe8fGCk7s7JazOdNKHWHbNtiVXOs7aPe4/C7bmuQP7VcsK+T
	T6JdYi1KlrIeH4dtk6GR+daPsHXBoLY9FsfG359g5Z1ChCfClpkPJre2q47CWXrI82+Jsi2wWgw
	rAbbaRVLeLVj38JLzuBGViTpZ514TmpE3
X-Gm-Gg: ASbGnctcmdeCI5BR2CkuDRW7c5feJNbpT0V7oYjIAXPDQRhGbKj8kG/77sSg/6q1Y7p
	k7LqScxXYTZt9+3TxTiAozh3l/f0mwmSdoi3J
X-Google-Smtp-Source: AGHT+IEIrXZEtRGkQkC/37jybcKymAIgGbmU+DmfCpXu3xlvjD32Aoh7VBkNt/7yUhvF+wthvTwGMMtZ97RlnkbCBUo=
X-Received: by 2002:a05:651c:2205:b0:302:3a46:10a7 with SMTP id
 38308e7fff4ca-304434da015mr73081fa.5.1734360742560; Mon, 16 Dec 2024 06:52:22
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com>
In-Reply-To: <a1db0c90-1803-e01c-3e23-d18e4343a4eb@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Dec 2024 09:52:10 -0500
Message-ID: <CABBYNZL6ZJkf=jQpdUyxYxZZwqRjHxWzDk4nCb74xdB78-33yg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_uart: fix race during initialization
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oxffffaa@gmail.com, ddrokosov@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arseniy,

On Wed, Nov 27, 2024 at 7:38=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> 'hci_register_dev()' calls power up function, which is executed by
> kworker - 'hci_power_on()'. This function does access to bluetooth chip
> using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'.
> Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
> if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
> 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' will
> be executed before setting this bit. In that case HCI init logic fails.
>
> Patch adds one more bit in addition to 'HCI_UART_PROTO_READY' which
> allows to perform power up logic without original bit set.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++-----
>  drivers/bluetooth/hci_uart.h  |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 30192bb083549..2e20f00649bd7 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -102,7 +102,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct=
 hci_uart *hu)
>         if (!skb) {
>                 percpu_down_read(&hu->proto_lock);
>
> -               if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
> +               if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
> +                   test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>                         skb =3D hu->proto->dequeue(hu);
>
>                 percpu_up_read(&hu->proto_lock);
> @@ -124,7 +125,8 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
>         if (!percpu_down_read_trylock(&hu->proto_lock))
>                 return 0;
>
> -       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
> +       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
> +           !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>                 goto no_schedule;
>
>         set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
> @@ -278,7 +280,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, =
struct sk_buff *skb)
>
>         percpu_down_read(&hu->proto_lock);
>
> -       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> +       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
> +           !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
>                 percpu_up_read(&hu->proto_lock);
>                 return -EUNATCH;
>         }
> @@ -582,7 +585,8 @@ static void hci_uart_tty_wakeup(struct tty_struct *tt=
y)
>         if (tty !=3D hu->tty)
>                 return;
>
> -       if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
> +       if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
> +           test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>                 hci_uart_tx_wakeup(hu);
>  }
>
> @@ -608,7 +612,8 @@ static void hci_uart_tty_receive(struct tty_struct *t=
ty, const u8 *data,
>
>         percpu_down_read(&hu->proto_lock);
>
> -       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> +       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags) &&
> +           !test_bit(HCI_UART_PROTO_INIT, &hu->flags)) {
>                 percpu_up_read(&hu->proto_lock);
>                 return;
>         }
> @@ -704,12 +709,16 @@ static int hci_uart_set_proto(struct hci_uart *hu, =
int id)
>
>         hu->proto =3D p;
>
> +       set_bit(HCI_UART_PROTO_INIT, &hu->flags);
> +
>         err =3D hci_uart_register_dev(hu);
>         if (err) {
>                 return err;
>         }
>
>         set_bit(HCI_UART_PROTO_READY, &hu->flags);
> +       clear_bit(HCI_UART_PROTO_INIT, &hu->flags);

This should be quite obvious, why don't you just move the
HCI_UART_PROTO_READY above hci_uart_register_dev?

>         return 0;
>  }
>
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 00bf7ae82c5b7..39f39704be41f 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -89,6 +89,7 @@ struct hci_uart {
>  #define HCI_UART_REGISTERED            1
>  #define HCI_UART_PROTO_READY           2
>  #define HCI_UART_NO_SUSPEND_NOTIFIER   3
> +#define HCI_UART_PROTO_INIT            4
>
>  /* TX states  */
>  #define HCI_UART_SENDING       1
> --
> 2.30.1



--=20
Luiz Augusto von Dentz

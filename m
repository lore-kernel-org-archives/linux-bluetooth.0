Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610431D362
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774037075; cv=pass; b=SGUuh150gSXLXsjUGkqqOfL/1O/z5Rzjl5OzqSUuSvqOHrXoPHGz7biZFUDAuEisa0dLnwKwy35BFQ5/FPhrE9ysHKMZmBVkENruIAfxnu5WL7GoEgB4aqwLS9wDWUerno1hVnfmI4XrBzxZYla4SUDCRLnXrWXI6AmxMABuf6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774037075; c=relaxed/simple;
	bh=PCCAH75FdWSWdrziLvg+ikPpjrrIxNO/KKCAb4zPY68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3p/de990d/DfVxCL19id6rxyiI/hGTM59ii8TTON7HYfQHUXz1Ni4WIOjYljb4Wd0pOBK0mRzhu18DY8+/Mf7bytIXyBU4SPM2DCPl9IHBvorb0O1XDTvgMdScm+Nu/mOjozfAMQw81k26p23QvIatZk0PIoS7MAUSpx32gmtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx1X9gSo; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx1X9gSo"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64e9f79cae8so1917487d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 13:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774037073; cv=none;
        d=google.com; s=arc-20240605;
        b=IiYlpVKDj+f6+93fD/Zd2niJkCmsa4riv4RjGEYPQG7LK1PqDC7BFjecHVFqgc3k0m
         H/xvSEPCSnoxMMn9bEL/Qwhqd1h1+rjSdLfAeZXWdVI9pxWEwpH14FyJH2u2hW7uhOKI
         nBLAz4B0pQMhpiz/qifYNLMmMC5FVdGJT16uf4VQ9O899nOpqAS71+iHxxXsBWJ0e9dN
         3mNu8GBlrfCtYoVQAXiiOHRVMbmXuePWxmiK1MEJ0YGDS8FRM4u8j+w+UweOgNEoZ8Uf
         lugCiEWygEW4SjPwOAz/aDrWsCWOJ+LJJA8I2kNmkFO97rckFUj1cSFLSeJ8flmD9FPp
         585Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jb/kPLHB9x86b/yNYeShN9qCBRpafUNvwYt90JlqOUg=;
        fh=52uJ954Babu58Oy0KI3vTLJepWMKp3PIUtj65lBTnQ0=;
        b=DdIOrtFW2xIY83WsCvzSZP9HJQxgh6C7xKcqb9DpZ8zEwQQMQVStkl+HDbISBS/NBn
         4itUDLWFRRyCeptALPBwI05iV+uY5AGEDuml5on5wMdDSs/Jda3dAa7SnaaHS3Sstvis
         aM2UlhSqnpC32buBiOSrqJm1JOKfpzqimbm3OITpPqekRL3kLiRZf0mnO796QV6kfJ6c
         xg+fj/B8xHfAlvDYDL0jyp7hgz5INV+cNv0oTOXv6K5I06Ql1/2QVEuow40k2gI3j+sD
         oshIYv8hTyrHRyWGcriu8KoEM1jgoz0TzisJZ6BuonpvKQ6jdYL01G9J/O8NMkmQ2yv+
         pKaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774037073; x=1774641873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb/kPLHB9x86b/yNYeShN9qCBRpafUNvwYt90JlqOUg=;
        b=Hx1X9gSofkRh4ClPKLnhwS/H2EZWFMiPQ6+88uHKSfawpxV9EykAPLmGpjdtjpXVK8
         y47U3kd52FLlpohCbSA8ckFf2hu+yp0wSnYDX8b4UBdgnvtSDm5d8l0JyUWPJMQKFpw+
         ny9TVGtrebCPsXhZcRDhhTJPGojvs8IeE/2PH9hsiMiW2HVL/tS3QB2c7LA939zITHQz
         /Shs03/RHb0d+UCowgvvPNn/nuPHDHdbOrvc9WUNERgkLJL1KvbxxoGhsEJ83oLI1MzN
         5+ncvzdfRjx74ixQuiF3ky3vfrIWi60oiaxmRfRTMa4Z9PXz3UkNyqbQauOpqHL+tDDa
         IiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774037073; x=1774641873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jb/kPLHB9x86b/yNYeShN9qCBRpafUNvwYt90JlqOUg=;
        b=Q4q2tgruPiFgmf75uuufHQoxgsRNt/MUDFGR6xZDvgSaQ/Jbt3L0HqEkKpf3KyhCd1
         uziNtPeoyevYIs+6l7+JBbVhQfOPE0PsPynT71HdnYs4+JtaAaWP5ZHpkU/YxlzrtQlH
         /MSclCxMdECpcyj4bP/dgjG9YMdSmVtvfGLaJ8OWDQUG4MrSHPrOd44zRDanco+LeCGE
         BYyPdOgnE7eUMBcNYaLjnclQCx/v78fKgrVU76LcYMHqRP2EZEJ2VTvOlosScnTxALSh
         g2JulAdFsgH0DM7MH29l1nckItRDFOqgIfxhBcJiN6VoLC+8nzDTiQqn9ZfMr4frBzHV
         wglw==
X-Forwarded-Encrypted: i=1; AJvYcCWy3Pypx7Zwp0yOKpPaCzGk5NVfIviI/lk2hpGiVgL0CZVVwFx8RwreE/NPDrVxGLei1fkRsEkH0AWbhw/bZ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDxhRLsFJRBq+3ARaHbot18EjASdmDrxYdRrQjkmSvWSMR4b8
	G1oyMobKWnCW9W+75jQkJCyKXl6JZfn3bPo98m+1fslLB1rhFoITvVccn2YKQMLRS0N/SJhjBLn
	XPQz52uZT6zrVH2mRwkmxfTyh4Kw1Vrr9dU+B
X-Gm-Gg: ATEYQzwLI56uqpsoPJqnjrf3TsTgJ25dzLYnYjzOsU4MHhTM5dGx2ips1hh1sOyC6KB
	ExrgmGxwRV7aYwig29Jm46RPu2tYh10wBsS4NIp2Hh9mtMahvOZKJjhanP1RU4Fc8dJKAh0S9Gd
	+hNYi/NxJ+1xBzusXl3sbYplMRLnMFAgwUgzMaLWtuXcrI7WdjSWspxlQYNNiCkvsTqOK4fCkdn
	GaOh9Hu5U4VK5j2tE9a7vyywm0qd6fqGQgtZdzf3COB3zTAC7aFlxwPYKEZ1B5aKwjcU9GgX6kR
	Tbbd6TOPES8t6Mn6Kbl8RTanGN9iDCy1P5kxUjbTqqjNoxIVcSuH1LNDa7Ltlq2HWVJhF59ooie
	drA==
X-Received: by 2002:a05:690e:1181:b0:64e:a853:624d with SMTP id
 956f58d0204a3-64eaa6b5ab4mr4412534d50.19.1774037073096; Fri, 20 Mar 2026
 13:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
In-Reply-To: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Mar 2026 16:04:22 -0400
X-Gm-Features: AaiRm53UZPGPRPktL8VVpCVP17SaE0uTYP18r98nsnTSAuOOA1PFBX9O9w7teBQ
Message-ID: <CABBYNZKkK-SU51kjexh0uKx0N9m-63dZf0vnGA3c5LsSkmFPOg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h4: Fix race during initialization
To: Jonathan Rissanen <jonathan.rissanen@axis.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@axis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Fri, Mar 20, 2026 at 8:10=E2=80=AFAM Jonathan Rissanen
<jonathan.rissanen@axis.com> wrote:
>
> Commit 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during
> initialization") fixed a race for hci commands sent during initialization=
.
> However, there is still a race that happens if an hci event from one of
> these commands is received before HCI_UART_REGISTERED has been set at
> the end of hci_uart_register_dev(). The event will be ignored which
> causes the command to fail with a timeout in the log:
>
> "Bluetooth: hci0: command 0x1003 tx timeout"
>
> This is because the hci event receive path (hci_uart_tty_receive ->
> h4_recv) requires HCI_UART_REGISTERED to be set in h4_recv(), while the
> hci command transmit path (hci_uart_send_frame -> h4_enqueue) only
> requires HCI_UART_PROTO_INIT to be set in hci_uart_send_frame().
>
> The check for HCI_UART_REGISTERED was originally added in commit
> c2578202919a ("Bluetooth: Fix H4 crash from incoming UART packets")
> to fix a crash caused by hu->hdev being null dereferenced. That can no
> longer happen: once HCI_UART_PROTO_INIT is set in hci_uart_register_dev()
> all pointers (hu, hu->priv and hu->hdev) are valid, and
> hci_uart_tty_receive() already calls h4_recv() on HCI_UART_PROTO_INIT
> or HCI_UART_PROTO_READY.
>
> Remove the check for HCI_UART_REGISTERED in h4_recv() to fix the race
> condition.
>
> Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
> ---
>  drivers/bluetooth/hci_h4.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> index ec017df8572c..1e9e2cad9ddf 100644
> --- a/drivers/bluetooth/hci_h4.c
> +++ b/drivers/bluetooth/hci_h4.c
> @@ -109,9 +109,6 @@ static int h4_recv(struct hci_uart *hu, const void *d=
ata, int count)
>  {
>         struct h4_struct *h4 =3D hu->priv;
>
> -       if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> -               return -EUNATCH;
> -
>         h4->rx_skb =3D h4_recv_buf(hu, h4->rx_skb, data, count,
>                                  h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
>         if (IS_ERR(h4->rx_skb)) {
>
> ---

There is some interesting comments on:

https://sashiko.dev/#/patchset/20260320-hci-init-fix-v1-1-e1960a41baf2%40ax=
is.com

It seems the issues pointed out there are unrelated to this change,
but I guess it is worth double checking just in case.

--=20
Luiz Augusto von Dentz

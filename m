Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41B21C9EA
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913614; cv=none; b=MFKdO8kUQUSqd1rhesAEjKY/iTw5/Xib5v92zaIztX6iiFs6E+4y2soagwx0Pv5dyJRQ6leBJGyTXFfnvMxxHvgEX0acUPYwzxr3mbYcsfmkGfE58jqXsHk0Rf7mDQUJ+IZ/vMQvwuibU77aIVQcIxiVCCmvT9SjXSuzBiPWiZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913614; c=relaxed/simple;
	bh=kIBnwYrf0eS3+QyXPWwf17pQ2sJU2KhxtX8im2c2SyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfiGkrsst/VCImU7S6VTXCbovFWx5KETDJ/bCLJKFrZu6L48oplFBLCzr1irIPKKAviTXAusF2yf1s4Ji8W2gfhQnI64K6QXEvIBV62pvhYnCKjfDtL0nM5HPEiYlD880VeFXdjv/KZLSykQfRyrgp233d4yIeBLUAxVffi9Eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A53uOenB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A53uOenB"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b49ac6431so28400851fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751913611; x=1752518411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTD4lVI2GdTpv4qnYDIn2P7k9nPsRxV0CPMYMmASDls=;
        b=A53uOenB0Qxq9Js5IDxjDa3AWgnRAr5v+Pag9y6c9C5fIviYzbqNrtUrGuo0lx0o4R
         tM8ZW9I8d0wvV1yi4+0WbNfp+x9sL9LjAV/lOLiByBl4sAZcxH/SKkjz5hF8yLwyg6EY
         J4EQK+mW8AAI98XDtH7a4GRk5k/bEDE8k9ywafJSS7ObOWhNrNEdteiiF/Z6XAXh3C5J
         GUxBOJ/BvfB17Jpj7wkHv7J6xlNU88j7waRso7FXZdaCorb8sT/8UowxvxURIRKihF1d
         /13tVrtSKN4RI+1hHJGUNOPAK8HcspaZIhzXb4AbEzT9qnGpLzi4YqSrN/jNIEpTPsNl
         umhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913611; x=1752518411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTD4lVI2GdTpv4qnYDIn2P7k9nPsRxV0CPMYMmASDls=;
        b=fAo9NXXOWeE4T42nt5bm4Gow60WSTQNBHpdCWcDzSmaKKPGhfuoD95xEVKFJ8PSO7u
         C/o4R9mQdQRQBe/32u/29CYta71rNWn6hf/birkj4R+YLXWB0LP1inKAiAt3h/+5Qyg7
         J03XLbwhMYgZ3ysv2smmggcwEYCWDUgmU/3YI2ogWPtDLTiBZ/1SlrscMAS6r0+QUV6B
         HLUqL5Ni2ylbvRkZK6Ckw1WDJ/usSJTTO7mWIKVwjVCgFWOHexH5W2nsnjpwytFvyt8o
         gdfxVr0+a7fvzDcYxBz83Jot4kCP2PwCXKYV590fILqHdgQjR7mNpL/sEO9jsorJUQ5c
         aONQ==
X-Gm-Message-State: AOJu0YxUH5aWwfNxmJjTD/Dkf1ws0UrURxvJsNgwZSsc3d2HrVLPsJVA
	XVvFRDJx2gZgDaGkt7rSJeFE1e6nGZ/UKL9/RB90+1jmNcIa/mE/N2XyRWMiaWeYxaPaO45+1y+
	It16WSGr0iZeH1wokd/N87fdXbtMWrSUYMB89
X-Gm-Gg: ASbGnctw2mI9JzfLcrUwjGFGtAGESHeR8KlRUc1D+Jzd1PJnkHsypwQ6OTXUgsE7wUf
	CIgMWt1z0zb8JoAdsb6acOX5GbWdO/2FyI3khix3lkMRxJmU0w4QkfGU6TUUyUJEL29phweRM5K
	t52JboppesWtRuEeS1kOpSC7dWaw2jHjfnWpNw+hlaiA==
X-Google-Smtp-Source: AGHT+IHoXMqLJa4UzaG3JSs3w5K2C+EvtqosZRH0LLDixMfLJwZiHCF6mhB7LE1l0pWWP7wEVnws2V9OtNtdBZJEf1g=
X-Received: by 2002:a2e:a715:0:b0:32b:7cdb:aa4d with SMTP id
 38308e7fff4ca-32f19afab70mr21549751fa.31.1751913610750; Mon, 07 Jul 2025
 11:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627061707.3631422-1-quic_shuaz@quicinc.com>
In-Reply-To: <20250627061707.3631422-1-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Jul 2025 14:39:58 -0400
X-Gm-Features: Ac12FXzLOxIOw6ShjW8bOl8TAhf05I1_LPbHzKxUSTWtL0CpFzieuEF81oGQfWA
Message-ID: <CABBYNZLZQkz2pamxqOODJ00+TX=c7urYtAmX7v0RJjp4T46w3w@mail.gmail.com>
Subject: Re: [PATCH v2] driver: bluetooth: hci_qca: fix ssr fail when BT_EN is
 pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_bt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Jun 27, 2025 at 2:17=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.com=
> wrote:
>
> Q1=EF=BC=9A
> If the SoC always enables the bt_en pin via hardware and the driver
> cannot control the bt_en pin of the SoC chip, then during SSR,
> the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
> This leads to a reset command timeout failure.
>
> Fix1=EF=BC=9A
> To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits
> after the coredump collection is complete.
> Also, add msleep delay to wait for controller to complete SSR.

Not sure why you are sending with Q and Fix tags, never seen this
format being used for kernel patches before, each fix shall be sent
separately.

> Q2:
> When the SSR (Sub-System Restart) duration exceeds 2 seconds, it triggers
> host tx_idle_timeout, which sets host TX state to sleep. due to the
> hardware pulling up bt_en, the firmware is not downloaded after the SSR.
> As a result, the controller does not enter sleep mode. Consequently,
> when the host sends a command afterward, it sends 0xFD to the controller,
> but the controller does not respond, leading to a command timeout.
>
> Fix2:
> Reset the tx_idle_timer after SSR (Sub-System Restart).
>
> Changes in v2:
> - Modified the format.
> - Add changes to fix tx_idle_timeout
> - Link to v1: https://lore.kernel.org/all/20250609105553.3756688-1-quic_s=
huaz@quicinc.com/

The version history shouldn't be part of patch description, either add
it as comments after the description or add a cover letter to capture
the history.

> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4e56782b0..d415a3f31 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1653,6 +1653,24 @@ static void qca_hw_error(struct hci_dev *hdev, u8 =
code)
>                 skb_queue_purge(&qca->rx_memdump_q);
>         }
>
> +       /* If the SoC always enables the bt_en pin via hardware and the d=
river
> +        * cannot control the bt_en pin of the SoC chip, then during SSR,
> +        * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be clea=
red.
> +        * This leads to a reset command timeout failure.
> +        *
> +        * To address this, clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED =
bits
> +        * after the coredump collection is complete.
> +        * Also, add msleep delay to wait for controller to complete SSR.
> +        */
> +       if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> +               clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +               clear_bit(QCA_IBS_DISABLED, &qca->flags);
> +               mod_timer(&qca->tx_idle_timer, jiffies +
> +                         msecs_to_jiffies(qca->tx_idle_delay));
> +               qca->tx_ibs_state =3D HCI_IBS_TX_AWAKE;
> +               msleep(50);

This is probably racy since it doesn't seem you are able to validate
SSR has been completed after 50 ms.

> +       }
> +
>         clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>  }
>
> @@ -2478,7 +2496,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>                         return PTR_ERR(qcadev->susclk);
>                 }
>         }
> -
> +
>         err =3D hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>         if (err) {
>                 BT_ERR("serdev registration failed");
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz

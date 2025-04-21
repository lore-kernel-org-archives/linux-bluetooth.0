Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18527463;
	Mon, 21 Apr 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263209; cv=none; b=XGlBz3+Ix+VXac2ymOHr+BtQQdRnWLts0pTzr79PizpY8w1Vop+yeTrPV9DjzZHHqDGY2gCPGNQRVZv7Na2wVmc0jr0uHcrK1d7N7blifi1/LbUG5UYUX54YJ+jTjb7ugjJ7SRvzdVAxXgMGiV60e4mqglMzk8q3Voi4DDzjRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263209; c=relaxed/simple;
	bh=GYhBSuvOd94T2wIA87TS8lozvlXyu0nmtsd4xTPXieo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgJFt+5dmg/ucc993f9Bxwwp7oS86iMVOHwEUIpurOZmXf8RC02kP2utjvyHSLJFepEZyvPMOREpFJGA9OoZz/a4YLM5Np7aEoeyjj1ygfHQouYIf2zQVUq6Szj+lyqcCClDj2SIIpp2KEygGxy9nXr0sWNYmIoXXM0TlOxSz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPL1nqGl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPL1nqGl"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54298ec925bso6361288e87.3;
        Mon, 21 Apr 2025 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745263204; x=1745868004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGSXO/dPI5+jUcYdtbCw4JQ75NbzfN4qotDsVJGePCc=;
        b=jPL1nqGlebOvOYR0rk3/LGVgBr/NGGib0/Tz76vBsE8hDx/Qe9djgbpbEWMq6A3OMp
         f7wMjKlr3ciMKcRFYrQzaeBBNE+1JyjGwMGWT+Df+r/KllbLOYWb71N0XTdwKu7vmLcp
         HqqtkB7n/1JuYTl3ZcmDlBvPIXB6ZZvDViQeh0omTvQvmBPgMAqjnhzHK6MUEmFz2ueC
         16Pe5giNYccNyDQDMcyHc5mO3hGHiufW3TcBxsU3wBn4hppGk/MjFSB/trL0L7+lR/cV
         fu084dtaF7cAPvtwOEYCbbS3GL61qrziTbYYHfIPJr9SofD20772RVqjkrIWtOcjWRji
         /LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745263204; x=1745868004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGSXO/dPI5+jUcYdtbCw4JQ75NbzfN4qotDsVJGePCc=;
        b=XfWFIcnVdUnvGIxBLO2eM366zPphQQZSDEmo+SF2AO9dey9L3I0xGe1wTpD853EAcM
         5bkS+Gl2LGNUF+EdCKTNCYR0TDYPWACKEDKhUtjKEu2rmSJRcZwh/x0fDLrI+8Xaewcm
         Qcrh2kyex+KK+Uj9inwA9PvPLOyh34iZfO8q997C4kr1m8Yg0G7GRYV3cNK6Att+vOwz
         98Xn1GUmtq7mRreOF2z6nsuCF0wDstay499h6ppJfzaeVAzuGiD5/EcUXwXwACDs1b+A
         w45Oa2O63hwxmJpqewRnXzBY66RX4OQ8ZS6ZMoYzC3bEfhMGVhVJa+7+koptTaKRkNJK
         8RCw==
X-Forwarded-Encrypted: i=1; AJvYcCVdaQkoRuaOq2MOt6elQsZDM9p2lSJAJLsWO3nTj+YWkyGHjw8JJu/6zzcDau03p2Llj9hi3A/O9EVaEAE6qBw=@vger.kernel.org, AJvYcCWudC/ZLCNYjoO3CwVnvCbaRj5GJxi2sb/Mq8xRUVjJGuN6mTO4YxdntPSkV8jR8Tti5h/rIpClmFjqiaON@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cJkH8A1wTPwclxd39fcD5Ilh2dv4xDkKAuoYgk8IZW53XrYx
	qWqTg43eSfumoMiF0uJ50f9EK2wT92aGziGSs57L/tPvVxjiY8C1L7kz6iXm4xQs0FIVWhFxZ1F
	naDlLezXCexQl40tL5E9z/V50QzPyQIzyFYSgcg==
X-Gm-Gg: ASbGncv8h5uiuHmJe5zsJB5aoE7/ecpfQmCr8LHl5ufbAt4v/2ZNPNaCYRrTFiUw1cv
	wCWuZZ80zg/ga4b0mq5RGH0fBQkAYyjqpnJYrgKTwJq3y9YInz5DMFVS1ofKpQYqT7jtfR7QjiH
	Sq27d5Y0+o+72MCoC41UyeY5vp1reQ09c=
X-Google-Smtp-Source: AGHT+IGWThofn9kjjT1rYmsVcaPR8mJeAZVdYEgrHXFQvPh13eYbpQ/cssZm6gZPLFnSLYTrbE/DfygAH4fyrYRssLM=
X-Received: by 2002:a05:6512:3b93:b0:54d:6574:faec with SMTP id
 2adb3069b0e04-54d6e62b403mr3576751e87.20.1745263204132; Mon, 21 Apr 2025
 12:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421072914.466092-1-chris.lu@mediatek.com> <20250421072914.466092-3-chris.lu@mediatek.com>
In-Reply-To: <20250421072914.466092-3-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 15:19:51 -0400
X-Gm-Features: ATxdqUGeWWnEGKGhSE2EeBxAvnphjMU67tQYCCQZGa1NbEsf5e652QVfEsmaqSg
Message-ID: <CABBYNZLb_yqUsnRzcUxxtFnqEYwhD4hRXaAn-QwT8s6cZvTv_A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Bluetooth: btmtksdio: Do close if SDIO card
 removed without close
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>, 
	Will Lee <will-cy.lee@mediatek.com>, SS Wu <ss.wu@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Mon, Apr 21, 2025 at 3:29=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> To prevent Bluetooth SDIO card from being physically removed suddenly,
> driver needs to ensure btmtksdio_close is called before btmtksdio_remove
> to disable interrupts and txrx workqueue.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>

Ditto, please add Fixes tag.

> ---
>  drivers/bluetooth/btmtksdio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index 3c66e3ee9834..c16a3518b8ff 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -1447,11 +1447,15 @@ static void btmtksdio_remove(struct sdio_func *fu=
nc)
>         if (!bdev)
>                 return;
>
> +       hdev =3D bdev->hdev;
> +
> +       /* Make sure to call btmtksdio_close before removing sdio card */
> +       if (test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
> +               btmtksdio_close(hdev);
> +
>         /* Be consistent the state in btmtksdio_probe */
>         pm_runtime_get_noresume(bdev->dev);
>
> -       hdev =3D bdev->hdev;
> -
>         sdio_set_drvdata(func, NULL);
>         hci_unregister_dev(hdev);
>         hci_free_dev(hdev);
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz

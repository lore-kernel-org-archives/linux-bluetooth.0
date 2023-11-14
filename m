Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8424122A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Nov 2023 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83341F9;
	Tue, 14 Nov 2023 07:14:23 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9c603e2354fso1154706266b.1;
        Tue, 14 Nov 2023 07:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699974861; x=1700579661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxz8QkUMUdK70UcIufkcCTFuHM/iFKukNXMBMippDVw=;
        b=FIBpXliRegubGy+6t3SLZZwguEKbefm3L9aQ85WbDYkbvsfUqFNJ2xN3c0swfetd8n
         k3GzwS2EFw0z3yde+Ct2F5umIHBEiEdDW2wHRJTS7iGyn9Oydi/zq66aVsb8Uc052PnV
         HUA2MNawtAFk4T3pwr1xZLsPMVEXL2IAkss7TrIMHcD1RO99rZLbx1y24uYvXL46NJf+
         W+ecnXIkNrj3Z5rZK/R/DEmNyiG5p84MZUqiFCgpANn4UbEWOYanWHeQnHvhqDg+0K+W
         bjr/obiRu9qpAe5Kqq/wc28kp38DOwUB53GkkMckBkdar81XSIYqjb34nRaVn0g2AQPy
         +PfA==
X-Gm-Message-State: AOJu0YxkV6vet8vlyO/5s3wMSfLt4i3lSjgl4CcBWb7dbVvEDmOM2Wpp
	77JKRGj4UYO29L8LVbPFsfaTwS2zdHY7iAkYjWo=
X-Google-Smtp-Source: AGHT+IEgOIolvgTrfEjV0AmDGor4/vOucGkOxuTp6WsVbqYowytfw1cdybx6FVvSq9b7+MGpLatTlg==
X-Received: by 2002:a17:906:68d6:b0:9a1:b528:d0f6 with SMTP id y22-20020a17090668d600b009a1b528d0f6mr2181514ejr.27.1699974861181;
        Tue, 14 Nov 2023 07:14:21 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id rp13-20020a170906d96d00b009ddb919e0aasm5664465ejb.138.2023.11.14.07.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 07:14:20 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so11571581a12.1;
        Tue, 14 Nov 2023 07:14:20 -0800 (PST)
X-Received: by 2002:a05:6402:440f:b0:531:14c4:ae30 with SMTP id
 y15-20020a056402440f00b0053114c4ae30mr3214229eda.0.1699974860727; Tue, 14 Nov
 2023 07:14:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-bluetooth-msgid-fix-v1-1-1d15394bf342@marcan.st>
In-Reply-To: <20231114-bluetooth-msgid-fix-v1-1-1d15394bf342@marcan.st>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 14 Nov 2023 10:13:43 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-SvvMpAAqtOPgaKt1PuoZi37K0Tprf3KDts-SBTzNpUA@mail.gmail.com>
Message-ID: <CAEg-Je-SvvMpAAqtOPgaKt1PuoZi37K0Tprf3KDts-SBTzNpUA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Fix msgid release
To: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Aditya Garg <gargaditya08@live.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 2:05=E2=80=AFAM Hector Martin <marcan@marcan.st> wr=
ote:
>
> We are releasing a single msgid, so the order argument to
> bitmap_release_region must be zero.
>
> In practice this was probably harmlessly masked to 0 anyway, which is
> why it worked, but it trips ubsan.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 =
PCIe boards")
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 19ad0e788646..5e9f79235cde 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -715,7 +715,7 @@ static void bcm4377_handle_ack(struct bcm4377_data *b=
cm4377,
>                 ring->events[msgid] =3D NULL;
>         }
>
> -       bitmap_release_region(ring->msgids, msgid, ring->n_entries);
> +       bitmap_release_region(ring->msgids, msgid, 0);
>
>  unlock:
>         spin_unlock_irqrestore(&ring->lock, flags);
>
> ---
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> change-id: 20231114-bluetooth-msgid-fix-29769be7e45b
>
> Best regards,
> --
> Hector Martin <marcan@marcan.st>
>
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

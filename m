Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3585624
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015046; cv=none; b=qnuYbtxcQGQyNQW7XRoWulZVCDhz0dlLnQAfNaUgiYVLipjSclvSqfaK8+RqXNNfB+tNCTaWvDome/S9eRWkqHeEBWk3pV7gqChuMPyOaQu+QErLeGCd//OJVjBTzhqeDobNnrCrNbfCXEmEVf+8Jnwr5RIhx6uVfCXhpyGSxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015046; c=relaxed/simple;
	bh=ZPGcOv8Ohbm4FY5YgMauAYgdoF/wQ2zZ/ngF+ha4THM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utCBKcNXZRLeTudrCaEoIylkyiAWY9jkcKMA8fk/KFHTKHnyS4ES1YxJnr5NKLNcTG6hME9pf71NQPdAIUQ2GhFtMOG0bSR74CZMnDBib5CaQz7SW8UXoX3XpRTQxEp9+7TeLYw49qw8z4LI5WkWs34hnHjbhRgYiRH0qhJczos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6+/nhtQ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6+/nhtQ"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so60856221fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015043; x=1720619843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOuUTdRytMSg7kUPKdwMLf3lq7p6Okran1hGsal0DIc=;
        b=L6+/nhtQeBt9UIiNoPXFvipqsh6/7lCaPc9e0qIf/Aqrz0uUiMdTV+pxU1MD1r4id+
         /EyXbmbn8T7kBobR8Hhxy9wf9geDx+5cKhN6uR5+FB78YyjobQzjGRs8MEjC9xmKOxM+
         19reHw3c7x7o60ov82osPOrOp8PE8MYe4IwRShdWkXw2WXLIHwHPvoHOmycNZsdO4u5Q
         64Q0WzYIHuHp2mYF5LLb02XafbPVufR+4/FuIoGjLyu2PeiDQ3GV9u4IWVPFQ9DCzerd
         kXdZylsmELTkE8vgTpi41TJPE694PV0fQEVI7M+NOZ3XBG0LdPS1zHwHN1X0mxHLASM2
         XrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015043; x=1720619843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOuUTdRytMSg7kUPKdwMLf3lq7p6Okran1hGsal0DIc=;
        b=i9mC0Cf2zOgDPU6q6lE+CdarTtvNTDsK0wcMFxoCge4iYXdiGD3XMMnmPH+EQHkDnz
         fHTdQQF7vuAFGerZGh3FREjxRrYXlaALdUbvHKx8AjWnuSV/+1ScqTBsD+hOh8jRfBlF
         Fh0EDkNL7A3VKXlTdD9mDJYE+EZTjttUnzgEkR7cinNDF9+OdTar4GQEsBQxCVeMRLtE
         jIOCWxpsw12770Ecj2pnVSOx/Ks+0r478tluTBPprh5zHppxif3ASsfm1iTt/DDNNRSx
         kerUlyaq9i8TppalGNoBaespcgoB+2RbUZ1NQQglkkUpKnX/+94f4ZHED1VfcUAjD4DS
         MzAw==
X-Gm-Message-State: AOJu0YxYKZ41x94Z2gPOauNzcFmdsTQUw7s4s6o1+dhxmZUhW5WqhAoa
	MWMdeNlUU+kxhpsxsrKobrfsvjYwy0+RdtgmUUQcQoSz1x9gW+qMnHrd+RSrHVuRn8RLxgA5Uwy
	XtGyieRRogIwKA70Q6G8Qr/6Vjr9OV55g
X-Google-Smtp-Source: AGHT+IErNR/+MRiYDpf3Nq7hYJ0mxcWPAgc950jcXnokIKFjTZvEsAc4Kf6Ks+SWU9E3Qg+HUaD7frbhp7Euu7CteWY=
X-Received: by 2002:a05:651c:2228:b0:2ec:89b8:3d2f with SMTP id
 38308e7fff4ca-2ee5e3adb58mr95266131fa.19.1720015042844; Wed, 03 Jul 2024
 06:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703070220.15246-1-quic_prathm@quicinc.com>
In-Reply-To: <20240703070220.15246-1-quic_prathm@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jul 2024 09:57:10 -0400
Message-ID: <CABBYNZKaqNa_yR4PO3S4R9pvne7XYvy8nX5GCBK+7T9DsuDRpA@mail.gmail.com>
Subject: Re: [PATCH v2] Added BREDR not supported bit in AD Flag when
 discoverable is off
To: quic_prathm@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 3, 2024 at 3:02=E2=80=AFAM <quic_prathm@quicinc.com> wrote:
>
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>
> Fix for GAP/DISC/NONM/BV-02-C
> As per GAP.TS.p44 test spec
> IUT does not contain General Discoverable mode and Limited Discoverable
> mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
> case, thus added BR/EDR not supported bit in the AD Type Flag when
> discoverable is off.
>
> Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
> ---
>  src/advertising.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 5d373e088..cfb239585 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -734,8 +734,7 @@ static bool set_flags(struct btd_adv_client *client, =
uint8_t flags)
>         /* Set BR/EDR Not Supported if adapter is not discoverable but th=
e
>          * instance is.
>          */
> -       if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
> -                       !btd_adapter_get_discoverable(client->manager->ad=
apter))
> +       if (!btd_adapter_get_discoverable(client->manager->adapter))
>                 flags |=3D BT_AD_FLAG_NO_BREDR;
>
>         if (!bt_ad_add_flags(client->data, &flags, 1))
> @@ -1499,6 +1498,17 @@ static DBusMessage *parse_advertisement(struct btd=
_adv_client *client)
>                 goto fail;
>         }
>
> +       /* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
> +        * page 158:
> +        * IUT does not contain
> +        * =E2=80=98LE General Discoverable Mode=E2=80=99 flag or the
> +        * =E2=80=98LE Limited Discoverable Mode=E2=80=99 flag in the Fla=
gs AD Type
> +        * But AD Flag Type should be there for the test case to
> +        * PASS. Thus BR/EDR Not Supported BIT shall be included
> +        * in the AD Type flag.
> +        */
> +       set_flags(client, bt_ad_get_flags(client->data));

Was there a bug or something that you are having to add this code here?

>         err =3D refresh_advertisement(client, add_adv_callback);
>
>         if (!err)
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz

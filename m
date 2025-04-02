Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CE723814A
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604499; cv=none; b=gNGyL1fXV59A5cNuTCvR2o9BR9KxzgMBOkj00sK9odNUz2/G63O816uUeHTiFTNx++EnOS71VbDjOGJ9Gm75k7O+lo2B/lBH72+CmsA18RQKQZhLGUWfs6GaBvHED+DnmCjvywdQLVONLCbdZxFTIEC3XaobMSfmQ+a4t+6AvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604499; c=relaxed/simple;
	bh=3pwTnHg9PxVVs1lHOe9Zd0o/T4cwfO3R5hLt1A5Ei+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bF2mgapcP0CQc+rBtT0wzgI2fSu79f80DsAVs3qnIjUEc392gq7/IEqy0F5Xvg0AOwAmsBc/14VI+DvKwiuF2ETcouVfNQRerRInb/nghCdE05W3o3bsEm2KXXNL7Fm8eCvOj3QwwBoYnEXT3Hu8EyDaLMrZKzZPOdEx008uhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ9YCNrc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ9YCNrc"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30de488cf81so43916061fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743604496; x=1744209296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/Sb67zS86kTMiAdsACOKoKVipLXST2BhHsgH7eLnF4=;
        b=eZ9YCNrc/6Y9Dz3HnDrdOF2avg1k7+/FevecaCo7oH32qlUmQ90X8VfhMJBc9JjFdp
         EusVkkj6wEgADI507QcdyX2BJHtzcggdukTPOm5AshGLPBm77GEQS3EOKUU8wjuDWGHr
         75zXCRVR9PfQIb3+DK+a/3KOwcPFRkOUzU6qoPnpM+T4FYFiTyeLj1S19JRNDCV4P9i/
         ROUkcH/syJilQI2z98U2bk/Y50whjzxorY21j8aDH1J9gNazfQ7hGwpQmJDo7eupyFvL
         pBmRcQCs4TW5orAuih3kgFTOrQeswRy1DA9rOqIaMsx1G8UJQoHZ5zWi9TX6FDxbk00n
         kRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743604496; x=1744209296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/Sb67zS86kTMiAdsACOKoKVipLXST2BhHsgH7eLnF4=;
        b=nTu/bL9hWsFgaybLmHw82+9Ae0iIaMj8DxE9I1Zpu/jladUj7Xmu6xKxpV5IjAHAQT
         p0z2jJjldisgZct2aLqqzWzDz8Dlc8odabdB1opyLqFamGKOIPvYQFEB2Too5O6aAOnA
         cPH33FnkZbEWUlr9idQhdCGC34oUZ+UJQkHtN0mMbGLy4pa10kc6nAIPV4/GNAeooCx/
         MNUq6a1UgyzmvyRGUJ1LJE3HBm62X0odryEgoy7eIFI+XarJSicc6KTRgAxwdTpsFonI
         p4QRh0EzqzfGm6GYWFGx1vHjI5j97vraPLhqSMqX25L5NwkJ7o8nCYHKNKS+UKnwaPP2
         f5+Q==
X-Gm-Message-State: AOJu0YwvvB8wXdV4TW6HNv0YKvtVguYba8zCPqeh31lC8J+Il2idNp/m
	ZppIwvoSRMVnWU06CKxHOiKOKD2ckw8L/VTxwl5/GvKsByXMyr15Blalka1MpwU6Jqq3HTaLBWs
	aC3Qc+f2VDzYnF70CuwztN5C6xRPtJO0N
X-Gm-Gg: ASbGncthbRjszOxALhgVhjo7fmmDDoFQRsEXdL3vy4C1Z0IyzdyjhO2R1I43zNs80HN
	NTkTed3Ypw5Xe4pFy24j+ZfRZIvHNunM8WSvjIKcE4ZSPERC4zvINqQrBsXVJqDyAm4bVKANkQe
	bYvpu4g2sRD9xpAX94+gNVG3FQ
X-Google-Smtp-Source: AGHT+IH5g/td5VoisH/MQeSsEiHnCukSYaB1C/mvUdrYSBhFAuz/cxDHwhQp8JQAqe4F8WAa2ICISQMK8aPh8fVPwi0=
X-Received: by 2002:a05:651c:543:b0:30c:2efb:6608 with SMTP id
 38308e7fff4ca-30ef91e8cfemr9928671fa.34.1743604495347; Wed, 02 Apr 2025
 07:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
In-Reply-To: <20250402-bass-v1-1-3e753841faa5@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Apr 2025 10:34:41 -0400
X-Gm-Features: AQ5f1JpuGW_SvwmJ_czMh3AVigQnhQnVLJUBq9-AQK_06DM06p963YQttS_IC3s
Message-ID: <CABBYNZJB4YJWyLBc9p0HDkY0cEpkLFj4ZRod0sDJXvmnWNx91g@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bass: Clear the temporary flag of the BIS
 source device
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Wed, Apr 2, 2025 at 3:33=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When BIG sync succeeds, remove the temporary timer. Otherwise,
> the device will timeout and be removed, triggering the automatic
> termination of BIG.
>
> issue: https://github.com/bluez/bluez/issues/1144
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  profiles/audio/bass.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> index c36f43277..99f1decce 100644
> --- a/profiles/audio/bass.c
> +++ b/profiles/audio/bass.c
> @@ -565,6 +565,9 @@ static void confirm_cb(GIOChannel *io, void *user_dat=
a)
>         g_io_channel_ref(io);
>         dg->io =3D io;
>
> +       /* Clear temporary flag*/
> +       btd_device_set_temporary(dg->device, false);

This is not quite right, we shall not persist the broadcasters, as
they are likely not pairable/bondable, that said the device shall be
marked as connected which would prevent them to be removed. That said
we should be handling if the service is marked as connected:

static bool device_disappeared(gpointer user_data)
{
    struct btd_device *dev =3D user_data;

    /* If there are services connected restart the timer to give more time
     * for the service to either complete the connection or disconnect.
     */
    if (device_service_connected(dev))
        return TRUE;

And it looks like that is done in iso_bcast_confirm_cb in bap plugin
which calls btd_service_connecting_complete.


>         /* Update Broadcast Receive State characteristic value and notify
>          * peers.
>          */
>
> ---
> base-commit: 6d20a300642f312290af0bc9869a0e1b416c58dc
> change-id: 20250402-bass-66200bb7eba1
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz

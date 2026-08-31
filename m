Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC73408614
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188209; cv=pass; b=OBPXF4R5guOR/tuM24Sb4WLqdjCeuhGuA8ENJO/bcqGyYGsY3Kwm8IFydAVPRPxjsRPkAg7by8j/bc0de+A15mO9Y31AKCBmkWC52CeXN9yA61WGiL9G/7bN2gY+vyI0Gd9y5+8qYNnUxREro+QCBxjbmmLMzO4d/G2EOmYuXdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188209; c=relaxed/simple;
	bh=fQ1KczgVjn2OLco7PJvTjX7kIErM4YB9Db2mGLKYUkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiW1yj6DsEZGBZqhxcn4Vc0m/0kuFJWrskj12RkVoHD7mCi1SNg19SNa5G5+KCUPy7uMvmOeMssGAzPiCG1JOD9iaIXLi9PxbM+fKks3iZ2eJKxUPJOIBHMZl5y6Qh3Pd4yc+07dsqFo32jPe5QCW3/Gr2CfZvGJ4hLQO401XNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH9z+jnp; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH9z+jnp"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66bd7857841so4018539d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 07:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788188207; cv=none;
        d=google.com; s=arc-20260327;
        b=prZhzL5PnMpoFI0XI0uJ6sYa0TfHWAktQrLXYWnZwYZSUtMdLdfNtLhNs2QIu2rxWR
         T/rcVT91qdpOPU2VHZxdeNCehfJI302JH0BvAHPDUPfEaLtY3DTKUm5fGt4lAonrKOMW
         ZAyMXEZXSUQzYqIsDhlzos9uGxXDYbNqyudlSDtHuh8X9EVDphaNcQzE3w/ZWXPEXD/L
         q0LZmDra2qsb+1XAhaK75eaPT4uiY4UfH4g5wUJX1xwZfbULT5iTGJEuo9dOMy5LXfFK
         8oVQ8x0ecD2OKRQ4S/gWQgs9FibLclKPhxlK7OQtDpQ3oFRq/HYYaWFUgfpOplNPh6Rd
         4TDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5+zq9GHEAhd7KerkGfPIO/cZTORFxbM5JF3XjkEQQ4=;
        fh=JHrmtYyqz6aUt7hr9ABW/uKWauoWoww825TCryzN5wI=;
        b=k4dvfJuFPDARd5+cTQmxfja+jcSHP3RVzbnQr52DvHeb0tj/S1At5vbjs3Og99zkCa
         jZe6/NohSt1wU2vAM0bZCZJ+nDnTSH7Ij1j5Vvr2FBBEnJHrV6lg/EN/DmPZPLCjYfBO
         QYPRCsFKWwTSnd8fMCyNxY8jWRMc88hYTnrvgLs3/2wBloH0CKugPRCPH07mZAkqnBSK
         yYQblLahFKLTPl2MbG4uwZwXpLhF7mltgJgit9m0aZFtdFJeuEQfRA2r8InP8A7mpSO9
         fO33zzab6G59B7xz0mKMokCy8XaegoJYIB/1BM7vtKsa0oRyZ832AL3yp9WWgXdwY53c
         gQ2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788188207; x=1788793007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5+zq9GHEAhd7KerkGfPIO/cZTORFxbM5JF3XjkEQQ4=;
        b=AH9z+jnpTr6viH5QfSWpZS41FE0KKOtMFYTOE6FTMpX7curKo81TJb0fw/W5XDNir3
         +RWgWCAfm954ONAuCA4f/jBTM5zjCiwS04Jojiu+yQvN+SdT3gOUFGl78ai5qPb1LvYk
         zCLn2Pl9Y1dRwoYREoFE6oSFVGr0y/7LfBfMTQk5oTgegiZ5ZNwEW8ahfVOPV+3TXE5U
         lmgZSy9yHGI6DtsVkaD37A24NcUGEvacvKvF0HhUXiOuLbeUW/f5hoUAH6s7Akalz5Pk
         EiVIqvu+eRetKpPR8bEKEuhi2D4PU5lcN2r7B4leJUndx+dJeKSUHYbqtewGjA2n2SOH
         KHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188207; x=1788793007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5+zq9GHEAhd7KerkGfPIO/cZTORFxbM5JF3XjkEQQ4=;
        b=g4+fdRolFVUobKGus4NOMwegOVKTLMYYFJTBi2iYV6fBGtbAxgmKKRcWa5xHxVoZXC
         9zspildL6rALnDAT7GltM4JKirJt1hsDkDAIZX0xPNzaKxHV8llo97c5lYNVzl9NeSzL
         WXjV6kmne+NMVWD0aHW2WPoEpiCxF/CnNYpwT9uL7xUBshVZPQnOo5lARBze+wYBrX8J
         BVx+xj7MhljDI0MIXvgPZdgdK07VVquoLGejUhHSIXHS5JFyi82n3eogRWJQyx0njhqe
         UH/PcaBo0gKVYLPsHNO36U1L0n7MR0Qo5VLpVZcsQyA3FOd/hmTeWfnOpPR0VcuHfFt6
         f5Ng==
X-Forwarded-Encrypted: i=1; AKwUvBy9xahO+h9b6UNA0osm32bjVN8VF8jYnS1Um7Zr3ObYAtmBb2X8S6MfjcXDXmDYXDez3MlZ6b2YJ/qGiZS7G8U=@vger.kernel.org
X-Gm-Message-State: AFuF++kAVo0GP4Pw7Cey0RN7F0EEGX5EqwCskfsn3Lm/JI7vFvMyFzM7
	xAMJQbIBXMSR1/a4XOO5hpX5VdSvxSWoJL69X/2CTBE3NASE+59aTOAYivzqafVROEoAxPwygS2
	rOmIDiKUVMR3hsZpkf1EDF30mjfRIJlZSsuPTadVDRx9a
X-Gm-Gg: AYBFou1Ie0CW5AtFnyaO+v2vK+s+vGzfJxR3vo26/+gqVt6OsqksXvIjFGuFX+J+t9D
	L3DKdgJMeoGRk0j4J8Bs/cT5o9vnYZ69KHlgu7JgQtACJ8ozvu+LV4nuySRUyDktzYmhwiB+L5o
	udFaEYpbL9cJeY4837tZe/yW+abXtXbQB5kU7hOXu3DoURRME4J+nS/THuhBlx5CpjoDe3jVigT
	ErAuASafUk4s4FHeaocphVp014fFzP2TStQthmmb3950CIP8AEVP7l3ltWh4YAc0uWfDieotGbD
	owvlHPLkcGMEkP8r4s8kD/k5LizCxrKum/XARe0xaTm3GPaf+S96ZHCxzPGKqUBkKJhPLruvOsg
	84AAyljvVSJ9CCMjnlOfXsfiYC0WsZA==
X-Received: by 2002:a05:690c:38b:b0:866:4769:d59a with SMTP id
 00721157ae682-8664769db91mr24745417b3.2.1788188207079; Mon, 31 Aug 2026
 07:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829100205.113655-1-paul@crapouillou.net>
In-Reply-To: <20260829100205.113655-1-paul@crapouillou.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 10:56:36 -0400
X-Gm-Features: AcwNN1UGwPwFC7jqs3bkEilU0Bk-oM2hKNvPUBlkzQ7uK2iT30q9xmjCCkBzrPU
Message-ID: <CABBYNZKNSbc7CNsJG3W2AgU_JLng7+Y2Jh4KUbKZQXOMGJ8ALw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: Default to 4 Mbps
To: Paul Cercueil <paul@crapouillou.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, Aug 29, 2026 at 6:02=E2=80=AFAM Paul Cercueil <paul@crapouillou.net=
> wrote:
>
> The ACPI path already did default to 4000000 baud, while the OF path did
> not, for some reason. This meant that unless overridden with the
> 'max-speed' OF property, the serial port would stay at the init speed of
> 115200 bps, making it unsuitable with high-speed Bluetooth devices like
> audio equipment.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/bluetooth/hci_bcm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 9a103db7e355..c44d552f9ad5 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -1224,6 +1224,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>
>  static int bcm_of_probe(struct bcm_device *bdev)
>  {
> +       bdev->oper_speed =3D 4000000;
>         bdev->use_autobaud_mode =3D device_property_read_bool(bdev->dev,
>                                                             "brcm,require=
s-autobaud-mode");
>         device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_spee=
d);
> --
> 2.53.0

Sashiko flagged a problem with this:

https://sashiko.dev/#/patchset/20260829100205.113655-1-paul%40crapouillou.n=
et

--=20
Luiz Augusto von Dentz

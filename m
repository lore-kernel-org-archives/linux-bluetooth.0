Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD31E49F
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863566; cv=none; b=Zgx+bv7ZtWrnE7eL96MuUkHNWzrbCODjZF7U7V2vrcPUr58pSokySOs8PcLePQSFQZnoRmVDHdee9q+9xC3GoJYRWNbf0wXVHfe5wOlj/9w3GAOEg/pBC+TNDFzi88TW81xze7n9tt6STf2CT+UQ35WMoq3ZBbyw2nhh7/378E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863566; c=relaxed/simple;
	bh=l535lu9tP7tZ/Y0wqUFYS/bLAi37OpKiNnTnZPOjnQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9SWallDkrZ9h+wSvjefUATMGDQ9XnnXW3hAFFuKLAyjJCcoPhqwg5wOpIXP6rdKxN2R8bqnFChMTexGP046Kiae5KQKcbmEz88wkfJGosdd8Umc1VLZfJkWP1b1FtPS+KF9iX8ZrwHStd+7z8mLvXoGSjZ3t87EKkGsnItM1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/G8K9rC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/G8K9rC"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f15790b472so57552821fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722863563; x=1723468363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l535lu9tP7tZ/Y0wqUFYS/bLAi37OpKiNnTnZPOjnQ0=;
        b=X/G8K9rCaWeIvocd/nVatp0GAtENoi0DMQMEpmSS893RXB9WF+y0YtbLqUhrKdftFK
         5wpkKXrwC2U1Fi9/QMPQZvyoz41nGCdfU1fH2p3MN+d2SVRBb4cWc7GjGt1YGk+Up8id
         UQSbZdiEoWAGlDClk5MxlUMTp3fjWxUjFfROPf6l1MeNxKZ9PvU6xokxduyHRJJQWTVG
         S/ds57TjV7ugbq+V3qtCxQu9c/xjy5/Smra1ugB7H0waibocAShFXbCBHzk0KiNLV5JN
         +gRooiZmsMZz+SEdqXZxOcY65kvwhm3i5s+YN8HWeUJb1JMUJfa+bp4wQ0wuKfXg96xD
         qX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863563; x=1723468363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l535lu9tP7tZ/Y0wqUFYS/bLAi37OpKiNnTnZPOjnQ0=;
        b=mDtBiT0/dSGZokccSBPWMznQhYvUQJaFd1+dBsaFkZJG+P20XpWsKbTRJvY5XhM/SU
         RJ0jFJNCT+ZkvLIN1MtNgLr7b1Fg0z2kwVjD5jZ0+AJcZjuyVd4nGCpCmfXP8h2Q7kUV
         pU/e/QdaeN/jjon5Y9q8f4yFh7zsxR/fw2OraY6Iixv3s4RQSRVkaIFDRcAHuVq2fy/+
         yhOJcnrsHz88RVyyUDknXVfkDmd3jujzPcEmCyrZwcHb/gfj9MkddItJkyciLIuKv8Ya
         Eqtae2QVZt8GqRSNNr6RrQek99tfMGxGKSxsFnN0BlAv1okhIICopjuisX3hjthon4eT
         oAlg==
X-Gm-Message-State: AOJu0Yy/7VlfGZtfkMFUG1EG6oqcZpDbqf1sui1e9/0HZf0YGC7IblxM
	A86qOCV3tLk0DIv+wvntV/ltq/36dJqWfj4CuODfXD+s5bCMaH9q0tTjJwzwkBWYdLXbhKo05hn
	DXbucjfSZmgpZLpPnV3D8290Sxzk=
X-Google-Smtp-Source: AGHT+IHe6zs3mXJRAmgvD0Bw/cGLckAEFYnRfxg+KkyAjepNeP7kfIzjZE9mnazQTuf/YEEAzCuPfrZ6J/LWbTj4LeQ=
X-Received: by 2002:a2e:95d4:0:b0:2ef:2c6f:c472 with SMTP id
 38308e7fff4ca-2f15aa968c5mr69379751fa.18.1722863562809; Mon, 05 Aug 2024
 06:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GVXPR02MB8256E67B738C97EC57D1FA0F9CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
 <CABBYNZ+HwmhFhUZsSnhW1KU-cXQhHKGt3xJeCX1sxt6xyBBnHw@mail.gmail.com>
In-Reply-To: <CABBYNZ+HwmhFhUZsSnhW1KU-cXQhHKGt3xJeCX1sxt6xyBBnHw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Aug 2024 09:12:30 -0400
Message-ID: <CABBYNZLCDU+vQFzdYKoUCKvuWMGUPbjxoHJYCVsE3J1=1i3iww@mail.gmail.com>
Subject: Re: GATT characteristic for only LE or BR/EDR
To: Alexander Ganslandt <Alexander.Ganslandt@axis.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Mon, Aug 5, 2024 at 9:04=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alexander,
>
> On Mon, Aug 5, 2024 at 8:31=E2=80=AFAM Alexander Ganslandt
> <Alexander.Ganslandt@axis.com> wrote:
> >
> > Hello!
> >
> > I found a previous discussion about this here: https://lore.kernel.org/=
all/59CDEBDF.3090200@digi.com/t/, but there was no conclusion. Now I'm havi=
ng the same issue 7 years later :)
> >
> > I'm trying to pass BT SIG tests but fail on two test cases: GATT/SR/GAR=
/BI-34-C and GATT/SR/GAR/BI-35-C. To my understanding, in order to pass the=
se tests, you need to register a GATT characteristic that is readable only =
through LE or BR/EDR, but not both at the same time. However, when I regist=
er a service+characteristic through bluetoothctl, it is automatically regis=
tered for both LE and BR/EDR. To verify this, I use gatttool with and witho=
ut "-p 31" to connect over BR/EDR and LE respectively, and the characterist=
ic shows up in both. Based on the previous discussion, and based on reading=
 the BlueZ API, there doesn't seem to be a way to only support ONE transpor=
t for a characteristic? Is this conclusion correct?
>
> You can detect what bearer it is connected via:
>
> bluez/doc/org.bluez.GattCharacteristic.rst at master =C2=B7 bluez/bluez =
=C2=B7 GitHub
>
> Looks like we are missing one of the options is link which can be
> either LE or BR/EDR:
>
> bluez/src/gatt-database.c at master =C2=B7 bluez/bluez =C2=B7 GitHub

Here is the commit that added support for it which specifically targets BI-=
34-C:

gatt: Add implementation of link option =C2=B7 bluez/bluez@e577e47 =C2=B7 G=
itHub

> > If so, how can one pass these BT SIG tests? In the previous thread I li=
nked, the "solution" seemed to be to write an application that simply rejec=
ts the read request for a certain transport, but this seems like more of a =
hack than a solution to me. Is there any other solution?
> >
> > Very thankful for any thoughts!
> >
> > Best regards,
> > Alexander
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

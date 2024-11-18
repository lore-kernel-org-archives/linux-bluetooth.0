Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1C196C7C;
	Mon, 18 Nov 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943731; cv=none; b=bZW8WZjxJcMpFwGfKR2upPNdHzZDk9yA4P7hGMV7hQG/vLGENYEhTGsSqRt7CwTmsmlk9maiE0Gq1AqxGlvye9g9mDwRkYdrIn6l1/XkFRC6T5Ap6xqMLPyFHOXEeN/XFZHf4+5rvCvTH86SqXqnOZqxSrItGgTBvDIh+bRKfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943731; c=relaxed/simple;
	bh=DKSXMzCHRuQc16Dm4kX+dYr2VQCzqmllGk2Y0Ca5f6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yfa43MoR+nQwPP14nUY5xrqfzbJldkko2ChC3X6Xs3qOg+EB1H0oP2HLfnkzD9C+8yZmPOpXmjJK1QPDX3IBxICJkfvexEQIWepo5CDJVPvDqmzR41lOCValCqIbbWnipZS4r6Bfym3DVseQk7k4RJ2ccKg3RI4t/7aLWE/Eh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFDbpEYw; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFDbpEYw"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb5111747cso30117471fa.2;
        Mon, 18 Nov 2024 07:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731943728; x=1732548528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+54sMoaEOpYpUQrCt1Qn/OWUSNClUalft8bTtiFvPy4=;
        b=AFDbpEYwqTU0h2wPtu389y9EXl86ePV6YMze+uf54lnk4lHbNAatsKK/KFLkTzw64X
         KlA8mMWLpWgMttnKiHOyGZX3ATXzUt8lDYO5GyVRYj9vnZlOVmpWt5zrtCQy9V475fCN
         UOdQnPrbdQV7rnk+W6CU6xF2OCTzIvviLvmxYy5fAhPRXV1xVKPhmEkqJq1SAr7uR8qA
         aYqbChQjXK+2jX8biWKeXz5XfoVp7gcxUO1l1+xJs5UbHFqdEwOC1TLGL4OwFx4OGgyt
         7K52ps8UhslC3RU3lXhBS7ycpYJj7+olkVsWnuR+j/NoBOoUjAiwaIKjJpZoU3hfjpHa
         pmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943728; x=1732548528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+54sMoaEOpYpUQrCt1Qn/OWUSNClUalft8bTtiFvPy4=;
        b=l6bWHNnvbxXthfIIAeuxTIOIPn6rJ/Y9qiREnePSRZUhbrS8F3xRK3WZWPot51NKHk
         6R+Aot+QCMcVIu2wDZvA6YBsED9W0o1+e2IGNKjOgWmp0xTniUcFlVYnNfj6K5eqSYkd
         J5uH/aTJgQfIH8ZjW1qknyLz9zqsfr7J3pKSDg97vysX6+tnu64Ef8lWfYkq+SOdB2EK
         WRatghe+BOWF6el0bqRdjrKntCWZNoDzHZziHeI4sNgCAj8wZKsvDZoNU1CA8ru4VjS8
         cwH39bu9MMMeC8RHAdkI4F8XpryHS6giBZJ86NvKoVJoNdAOglslohd1AcAcI/Ud7I/M
         AV/A==
X-Forwarded-Encrypted: i=1; AJvYcCVl7onVZqXJw4dRvJcNG4ui2vIstQCO44oAULfYvzbugw72u03YZZkLtSlRH1GrB5Pu5k2qLkM+GQcDl7za@vger.kernel.org, AJvYcCW2j2hC/+q9MMuIpUN969j7/l6Rcp8hF+7DxCmznsZlce+VWTFRQj/Ucv4qeDpiamtCFRY4j+ebRu/s9TN68iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoccAdc71ocPMvkZa22fRSoKAiZu1Z4SGy4ef0/3aM1P+sKlor
	E/4xcANyw1K6eAObkP/Bim2oLKE3alaw/Lp/fy/8x9tx2+fOUY/yu1fmZ/ChsgxLpgVEK6AXqgC
	BZ0xz8NbOLV9LXWFvd/rXQX6QdHo=
X-Google-Smtp-Source: AGHT+IGqC9FeISx2roYOZCNm1FPTQHZcluBhzAV1Fx3I/aYTIm0ZSY55bj9h8zChIDBVNkyyDjiAKkhqLt+TR10yJcQ=
X-Received: by 2002:a05:651c:245:b0:2fa:c59d:1af3 with SMTP id
 38308e7fff4ca-2ff606933a3mr57292651fa.20.1731943728018; Mon, 18 Nov 2024
 07:28:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118151947.3323927-1-andre.groenewald@streamunlimited.com>
In-Reply-To: <20241118151947.3323927-1-andre.groenewald@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Nov 2024 10:28:35 -0500
Message-ID: <CABBYNZJPG+-m5WwDLOBMpw-O+a-GY9RmNV6hiz7AQv_4=m66kQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix LE init stage 3 failure
To: =?UTF-8?Q?Andr=C3=A9_Groenewald?= <andre.groenewald@streamunlimited.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Mon, Nov 18, 2024 at 10:19=E2=80=AFAM Andr=C3=A9 Groenewald
<andre.groenewald@streamunlimited.com> wrote:
>
> A controller may indicate support for the extended advertising feature bu=
t
> doesn't support the HCI_LE_Read_Number_of_Supported_Advertising_Sets
> command, which will cause the initialization to fail.

It might be a good idea to mention the model and include the HCI trace
so it is easier for others to find out there is a fix for this
controller.

> Signed-off-by: Andr=C3=A9 Groenewald <andre.groenewald@streamunlimited.co=
m>
> ---
>  net/bluetooth/hci_sync.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c86f4e42e69c..c07be5813113 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4416,6 +4416,15 @@ static int hci_le_read_num_support_adv_sets_sync(s=
truct hci_dev *hdev)
>         if (!ext_adv_capable(hdev))
>                 return 0;
>
> +       /* Checking for extended advertising capabilities is not enough; =
refine
> +        * by checking if the HCI_LE_Read_Number_of_Supported_Advertising=
_Sets
> +        * command is supported. Since this command is part of the LE ini=
t
> +        * stage 3, the initialization will fail whenever the command is =
not
> +        * supported for devices that indicate extended advertising featu=
res.
> +        */
> +       if (!(hdev->commands[36] & 0x80))
> +               return 0;

Is this enough though? How can we figure the number of sets supported?
Or we shall assume it is just 1? Otherwise it might be better to just
revert to using legacy advertising commands instead.

>         return __hci_cmd_sync_status(hdev,
>                                      HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SET=
S,
>                                      0, NULL, HCI_CMD_TIMEOUT);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

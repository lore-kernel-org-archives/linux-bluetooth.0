Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DE3090DE
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122372; cv=pass; b=Ub6+7qjd6Grd/uPJgfr160rbzxgOLx+TncvCNPnlmMxFY8aYAHzLvh1lfrGRpVfPvM1cBbJnNnsDnE31jLiY1WxwkrZ/IXo1KUtt5hmXrmYRZ7ijYXIwPDgm4seZ0B8maARHnuo+s/0jka370Uvc5YUthP3fLC9tG9W/wUGT+mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122372; c=relaxed/simple;
	bh=qU7uUs0NK6uKgPUe8Qg+r0hQV4tX0S6hMpE5TbcUIzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIAwdsiZgpscKSsGGt5RdD7F8Xy4g6DKL8ZKo8Fg+TMmRRNDHwCvVofEVYLTxyMhz3ec14q/EbRsgVvbinLc8YgIVeIvjbNfffh81J2PZbRDRplXGJkX67kEWsdTfLy58p8DCLK0wEJNf46e7B5tgKqvjljrNSdXCc2d81rh14E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiju0oap; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiju0oap"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651c7ddf514so2344327d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 09:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779122370; cv=none;
        d=google.com; s=arc-20240605;
        b=hR3NXLx6+86HImcpFWnu/phtH3Ovyi+M/LQtuVR13wdx8pUL82TXlCwEX+WQIr8qqw
         IZpTApCTJZolwW5fXLl68on6hZaooscYzbxsSWqrBZWsNVlWSvnrO+U8JPvD29HyigP4
         va33IvLat8tVKtjZRU5utIQnFhmfKxyWVaswfB3GgdgcD7EoIqkrSsIWnQNwnG1xX/LQ
         oIDGu47t3iDnkqRNTZI4ED1+iAQRJf0MMLBwQDdkYZ2DT8ylP6tCBIzh7rBs/BI73ILD
         5U7CEB7wDoti7s4WJpA6Drsk+Mf7N+rW15WHGJ0/QJ569BecrpvYFfyXYpzsc4c04GPK
         B5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qU7uUs0NK6uKgPUe8Qg+r0hQV4tX0S6hMpE5TbcUIzM=;
        fh=Ch4Gjgq+uQbxVX5g+qBQD/n6qQtZdF9JaCnavv3Rfcw=;
        b=MGQeYoNTCJ2fd+C+zZ4SkmFrzI4lwSRWBV99SeA/TUiNJG8UFVyzX/iuM61iHleSix
         QO4pqOgivne3qA4iYRPLkDgUfcD/+F3pEJGeiRL/4aBsfmD7Di4TYPzioZ6uwIVv6+KP
         DAGs1TT5MYU5YUbLDzZrwC/QsPFTwPUqXsfKuE/Oa4W5+KItusgnQ29Zkm0SUAE/viN/
         yafVMivo83aF/NMYfp7SfaaEqBvZDS0DiC4ZaSSpYNdh7FpObnoxXN4pXJ49AIbqp3CN
         2Yut2yQ/e7SbrDeTEqZPZNfbwW+NvIM2cL4duIKI8DGtdBaGes2T7YLIYEKEmqh5SwcU
         0s8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122370; x=1779727170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU7uUs0NK6uKgPUe8Qg+r0hQV4tX0S6hMpE5TbcUIzM=;
        b=oiju0oap3b6KHdRJ8dykMiYYYYGw4/ZWwGVtK8grMNsyOUiwKtf9fGtPdrzfgrktfT
         eADv5esnIKNrdws1DHkD6bN/LIeK32DFtdt8OGMS8JPfZ4FP6o3R7bzrSpfZD7qylKKy
         FyEhALJ1m7uIK1VzRodV9+359T3roeAcCyKTy+BDRRaoYKfpaqYgUd08wmP0uV+0xSM3
         FivCUyDD9SIp7Z+KpCuqXQEVDR5HKJVHpJLHmsJQwZdxNqAClXcSAKc5pSE3qJxiM1IQ
         bBzQKiyhX2V1AMOqTx7Ewd1yHK3ftEARQP+6g5glDoNEFiwtCkSSWgW9xofSmaPXDtgC
         NM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122370; x=1779727170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qU7uUs0NK6uKgPUe8Qg+r0hQV4tX0S6hMpE5TbcUIzM=;
        b=Zk8vZjburmVR3D2DttQkq9oE85iRxsX3kKWw5+lUgbCKDkvDTdt01ZFxqubyv9Wb8m
         CoMnuG9a3kwhbq8zCsZyJwl5UORG0IBWyo9mpuWgt1mWCVKOCRc9Hpc/8U0EFs76ebDn
         6fHmNzTIV6osFuE8TzD3FU4xssqqInip293fI1Orba7y8vF8wz0ezU8RSJSVzJ/Ja6xW
         FNIMMZTDP0Ve2ocfcfM4cZEE5LZWsIcd+5EkMEag7orn7G/iCyLG4Vg31f+Ec8RM3SjD
         OvF8cDP+AD83W8fxSN9mhW0wYZ05jYUYt7rgwTK5erTm2VZChsA+iQefPfoO6kPiPM9D
         Z4KQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lZf+3M9bIOFJrh6uCDuV3b9IKUMO2DE+Q4DOgYTzLaFR2OXdQdazmRD3ydFhiz8619fq25AxAtCj6LmrxQNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RpB7ICyE+YN/IWLqtoIJvgCydi6I+HK/T8XTfskOeiV8mrED
	U/mRCy1CDxI9j73kxlHA0Jc+wwheAJSMBFcpVsDEeFbE5C7dEmOGnGbL4J5HKaDmjITWx0vuokr
	OSyhlPVuyMRnAsLwpds8iNnbiaNDxO2s=
X-Gm-Gg: Acq92OHniPm023KrDtufgXg5c6THagYx5FH+UtwAtOMpE+G5WftV2I4ay6/MpjXKNVC
	WOAiw3MTd7DkFZc99fidoW9tFFmoK+1QbSl3vvkx4BmdSbdnV9btyopOVJjRfywZ8BFEMftsSLA
	o0HKuAqmoX4RmGxz5LgqLEv8TvEns5nBGOTdffAQSM09+6SojXVRVguTo7lMyU5W4w5AXgZyr3M
	rzYf3gzvqa3ukj/jvz5kfij3JiBCT3mmwVHoKtD3I+Z5xvc1VgK88rm1SkVikEa0Nuyxf5KYfls
	lNBajcnA6OlhKrjXF2p0vstf1X3nx+LwcOtEmwitDUc2IclMZUZTXmNsi4umCm1FPmc=
X-Received: by 2002:a05:690e:151b:b0:651:be68:77e3 with SMTP id
 956f58d0204a3-65e227be426mr14633351d50.31.1779122370411; Mon, 18 May 2026
 09:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi>
 <79571779-316d-4d7b-bbca-554328ec7dd6@gmx.com>
In-Reply-To: <79571779-316d-4d7b-bbca-554328ec7dd6@gmx.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 May 2026 12:39:18 -0400
X-Gm-Features: AVHnY4JKR7EW2Y7fh9Ry1FXstveHWvemeXRYsMRqeLo5qpbHBWWCY7ZWjLaMSPc
Message-ID: <CABBYNZLe0UGzJ-99uBWosy7exYNQ=vLr1018x2e2ugsCWqTKUg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: accept too short WMT FUNC_CTRL events
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: pav@iki.fi, linux-bluetooth@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, mark-yw.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Artem,

On Mon, May 18, 2026 at 12:33=E2=80=AFPM Artem S. Tashkinov <aros@gmx.com> =
wrote:
>
> Hello,
>
> The kernel bug tracker already has half a dozen bug reports in regard to
> this regression, yet almost a week later I still don't see the fix
> pushed to stable.
>
> Please do.

No offense, but I recommend checking the list before generating this
kind of response:

https://patchwork.kernel.org/project/bluetooth/patch/20260514172340.1515042=
-1-luiz.dentz@gmail.com/

PR is in progress and will be merged in the next RC.

> Regards,
> Artem
>


--=20
Luiz Augusto von Dentz

Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC852AE90;
	Tue, 29 Jul 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753812583; cv=none; b=FNc0PJy8EmU6InjBkvWoHvLoWNU51946FyaFpRgYLewj5MybikVfZZPwpqfc9vm7xY5ESPcAFWAP9cMwRAIqX+pm6lyw9I6hCBSPtmQcNOExShWiKzqXGEBae5LkGNHARKnsG8+qmoLVA4djhtjOFMJq3/y+j8AG6GtZjjcHevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753812583; c=relaxed/simple;
	bh=ywqvu+KrKdqKad+AKdA4ygwDzPPd7QjOOhpjC2V8Pbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFEv61GiZXjf9YPZvwBVFRdQEboa+kyqwnd1yMHWYNfV12UhnZdoNcrEWOIgInfFmkFHvVRkSdoqXn9mdodPqJg0pUtmFj+fLBPoMMlHbZfz/5TFnfZy7OmcRdGGYbA2gj8tjM4yaavstDvg+lFGebseOzB/zzR4LM6NLPxuFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMX4zuex; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMX4zuex"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b5226e6beso51058141fa.2;
        Tue, 29 Jul 2025 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753812579; x=1754417379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRH8pLPGb1KqaZNb18HazOqZ8bQupnXae13vT3Qg1TU=;
        b=DMX4zuex2ncyM4URetii3r4U60wcl1n6x5REJOvJycqjrb9FUeQcuuWDpn9JqWk6//
         boUHhd523xEH6OrHbMMJIlufpF5tFcVM8fgHCXos9tFLN/7odaH6JYf3M72ZZdN58LFe
         sxrjwLfE5X3y7BB5c56utMA0Q9mbkXo5/P0AakU0Z4D+kFZnhYeHTwzKN2U+nwRL8FmP
         HB7GDwmldiIyyYytd9rxH0NzdtS8+n+TsG02oicY1zEZnHe4vWNowv1p2wB2OTRwnAFE
         qM44K8tb0+akC1moa+3rpTlc3OF6MCixmyicFNsRlWVQEp5T1qx8/e4YiJAJ4N3DNkNw
         E08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753812579; x=1754417379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRH8pLPGb1KqaZNb18HazOqZ8bQupnXae13vT3Qg1TU=;
        b=pxa54LuShyiztEwmI2XpJtINFgSGEL0jk2/OoQx6SlwfL+c7UtgYDUo/rBEKU+K9tB
         1uEAawNZg3Cfj3tTi+4tI2dLKeXW5iHv4W3TBFM/J1jkRcGrUZc0QNmwT7GHc0w7e50+
         pbVDSxEBHUHNvAhqYXtCDizvG7WXJhqT9luGxJN4JCmt7nEpc/paDriIn4//YnCDspqL
         s9/A2ho64/KEfDEgpFCdduDuK/Blny+gNuhm1BzyIfqsofIQSAH06EUoXRV3s2WmED3b
         cvddhbeyognMVf6gYxTHEfX/eQhTPeLomw7CfrzUILSIZEpKGUopeeAG7lmjq4UwcHT5
         33JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgEx1nNMiLzo3nUwTWsl74NgovCvljYcjVEb+ivsi5B2PmgcwnnVqpsXZP2S2pOUJYnk64/O0YWucthMwS@vger.kernel.org, AJvYcCXW6nPJs6/f2MdBZ7rFKG0lRlJ+4MbeLlFJHxRyr/LgWBPUbLxrH2Zh2WX7Z8z/Y1Y9ohhqaMb1LMQUcUKgs+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+LMIjC9AGYFnL5NVZF9bxeZu6zD3+FcFcTxf+pPKqoXGfxZO
	M4aplenno35vNNV1hyKPm9POwPpaYsRdKLYqKk2dSjNriJEurVVfH6NO4eKLXIfcXyAEq7ALpwI
	aAXU70GTQ35a21walDipFQRVowkTMUTs=
X-Gm-Gg: ASbGncuNMz/3EMlS0Nlp0I0pBOZao7IH4l1lPJsY6a1l9ePNBOkvzI7golw0rSwA0xT
	iYK0hvug8k11gsHCzfAlCIfS7Z6GOsqsgHQSquqgsTzM0cMIyuFiILmpzOLzn8LCHPqccV73p7b
	mSmORP0Q/HPw3ZYxyKKbVyRO3UoK3MD+8PouhzKn4mbh/AQCl1+zVTyGPFOFNXsJdz5Yk5a5MiW
	0G7Yg==
X-Google-Smtp-Source: AGHT+IHlpvqrRu9z+KD5pfs45/H08BEm1z8FNPDDdVDgZDQmY2eeOnq/THFvNlCRyMaUK+JlW9EC53z7GMcwNBEo1TI=
X-Received: by 2002:a2e:a005:0:b0:32a:778d:be76 with SMTP id
 38308e7fff4ca-33224ba02damr724221fa.26.1753812579170; Tue, 29 Jul 2025
 11:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729152743.2394727-1-arnd@kernel.org>
In-Reply-To: <20250729152743.2394727-1-arnd@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Jul 2025 14:09:26 -0400
X-Gm-Features: Ac12FXzP7ozXTfw7dL1L74mia_Wa8v0jXJtc91QPj7y2bY-PN859ffQcnUdE500
Message-ID: <CABBYNZLk8ZrMLuEmjx=CwgWrtqC1rBcsFb89ZqdFffdBs_LhvA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix CONFIG_PM_SLEEP check
To: Arnd Bergmann <arnd@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Kiran K <kiran.k@intel.com>, 
	Paul Menzel <pmenzel@molgen.mpg.de>, Arnd Bergmann <arnd@arndb.de>, 
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Vijay Satija <vijay.satija@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, Jul 29, 2025 at 11:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Using both pm_sleep_ptr() and an #ifdef around the definition is not
> valid:
>
> In file included from include/linux/kernel.h:36,
>                  from drivers/bluetooth/btintel_pcie.c:9:
> drivers/bluetooth/btintel_pcie.c:2674:36: error: 'btintel_pcie_pm_ops' un=
declared here (not in a function); did you mean 'btintel_pcie_in_op'?
>  2674 |         .driver.pm =3D pm_sleep_ptr(&btintel_pcie_pm_ops),
>       |                                    ^~~~~~~~~~~~~~~~~~~
>
> Remove the #ifdef check to let the compiler's dead-code-elimination drop
> this as intended by pm_sleep_ptr().
>
> Fixes: d1b3de23042b ("Bluetooth: btintel_pcie: Add support for _suspend()=
 / _resume()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ive fixed it up in place since this hasn't been merged yet, thanks.

> ---
>  drivers/bluetooth/btintel_pcie.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 8e65def192a9..aa47bc38d298 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2574,7 +2574,6 @@ static void btintel_pcie_coredump(struct device *de=
v)
>  }
>  #endif
>
> -#ifdef CONFIG_PM_SLEEP
>  static int btintel_pcie_suspend_late(struct device *dev, pm_message_t me=
sg)
>  {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
> @@ -2664,7 +2663,6 @@ static const struct dev_pm_ops btintel_pcie_pm_ops =
=3D {
>         .poweroff =3D btintel_pcie_hibernate,
>         .restore =3D btintel_pcie_resume,
>  };
> -#endif
>
>  static struct pci_driver btintel_pcie_driver =3D {
>         .name =3D KBUILD_MODNAME,
> --
> 2.39.5
>


--=20
Luiz Augusto von Dentz

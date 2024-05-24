Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518295BACF;
	Fri, 24 May 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579584; cv=none; b=NSOIbWvR6+nlI3dFNuq/5WIYXkuvha0OM977FCu1de5iDaYemIv54iW97l0DXtnDaCz2AmhbUJOsr4PVcB8JBaQm1fVhK7diZ8aDAhjmazxla+oWNmi1vGqGeGFSjQxW4wCYgwoQUmixIJgjScktEFLwe2I9f/o6CNrz58Lfrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579584; c=relaxed/simple;
	bh=AO6flEiY5GN86OBnbWq/A3cQxhOqbBj/HG/J6IbbzR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edXwNp2Y2tiQjlN+JncbXnfGuSfby9R5EdAtJ2Zzkfb3zbtSdIhty2sCRmLYZlv/g6K1m9qGMQRrOTFmYY5jZRE3ik8Jpkwbx3RPCBGI32heE0bRTPreZleuEwVWrkMkJb6Z7ir79ghEePtKvtQHuJoAPrxHfwDjel1iyw85URA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpNqhp7m; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpNqhp7m"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e719bab882so79656891fa.3;
        Fri, 24 May 2024 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716579581; x=1717184381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvA1TEXJy8UZ30B8rAec5iNH0YYUOMkxldrbK8cu0os=;
        b=fpNqhp7mEyZmRsonidx1iLVfgQMsxODqXHqFQjtcwik/bVS71vfMR6ppE/l89inEPu
         SRX7D0j7QtYGPIn5aLjlthMNKz+AKLjt0bwuibRD6btcgml0ddsaQoKK4fKhTwRBU1Oc
         c28aOzgg0VBS6zhMBWX40hAj6AQrsNCzKcu2PZjCuRJ8l2R8Qo8zTqHYX4QiilDF1C/V
         U/Q9qmQCYjREc11Vc+fIbh7P6FzSM01OdVL6G+BsiUr2h+S/lGD71KrE5Sv4vIIAo0gx
         q2y9mxwQohBdoLWrO13NyA7UeVq+Afdn2fsfE4cMA/aFiT4hz6DYmcF6dVgFG/uBStP6
         PN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579581; x=1717184381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvA1TEXJy8UZ30B8rAec5iNH0YYUOMkxldrbK8cu0os=;
        b=Fae0I5QoxJoANM9sPV8YVhZUoDgTdziSR2QdvEWorII8T7MMgNrY3dNCTOdnzf7/OD
         1knUTRM3ty8S7P0HsRC6My9aregaTJOgbHMKsjPs3wa3dmUoorwrtx0hv0BHG0tVeVWq
         A52QLJvlKPyJ2FCT1RCrIG19Eblxb7BmvggUTofUa+hTAdmg619f0h2xS0triu9L7EyF
         qzJ9Xk6MCBcR0RU3bW6uM+jvXx6K52owbpzutC3IL63jraGOxwOVsSbujd3o+4aBgATJ
         BNxzPxgjsmLZ88rDGOf87f88ZjX1Udw6+NtSZkVCvsYB34CWxSZJDRJ+JNN0RrCrWVee
         lU5w==
X-Forwarded-Encrypted: i=1; AJvYcCWTeRBbECuQWhmUpCoKyAx0pj2rPch445fKkoqXy73PL6j0FnlTloM2Y5n+oCIn36kcq88FkPw/nJ4xjgwQk9T/Ef6u8xgh4PpWfZDOWOJ3XgJkH1VzSatgSTc7FityEaUO3UeEr0gvcUT0EaSI0V1I6SHyUqMzpM5AR1KT9FUuTREb8Olv0QmXhvmFb45l
X-Gm-Message-State: AOJu0YxiD5V+6eo1e38VrQ6Y7FnwqvwKiDeGdMlDwUrvKHMyXiJOtau/
	GKc3HjdcXoO1sjLypMvdqQwWQF/+HqZqlniYSHCONzMQq0iKwMsSK/6JMsRdtpE474RMyBu2EhR
	yCmuhWMvFh1F3eaiHOpWzO+0Q9kqwvQ==
X-Google-Smtp-Source: AGHT+IH/Fts2MZ9JzhPQTFc1u/R6qIz3bkV8n8VX15J9OkSYxcuMJAlWmONNhgDMZkSm5Y85aUEXz0rqzNRZEaB/Riw=
X-Received: by 2002:a2e:b74c:0:b0:2de:8685:d07b with SMTP id
 38308e7fff4ca-2e95b2cf26bmr17130481fa.46.1716579581149; Fri, 24 May 2024
 12:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 May 2024 15:39:28 -0400
Message-ID: <CABBYNZLeM7MQrBuGE49KN9Xm1EQ-cFK3nR57sg2hWB0jOUFn7A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Fix the error handling path of btintel_pcie_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tedd Ho-Jeong An <tedd.an@intel.com>, Kiran K <kiran.k@intel.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Mon, May 20, 2024 at 3:42=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Some resources freed in the remove function are not handled by the error
> handling path of the probe.
>
> Add the needed function calls.
>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe trans=
port")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> Maybe incomplete.
> ---
>  drivers/bluetooth/btintel_pcie.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 5b6805d87fcf..d572576d0dbc 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1280,17 +1280,17 @@ static int btintel_pcie_probe(struct pci_dev *pde=
v,
>
>         err =3D btintel_pcie_config_pcie(pdev, data);
>         if (err)
> -               goto exit_error;
> +               goto exit_destroy_worqueue;
>
>         pci_set_drvdata(pdev, data);
>
>         err =3D btintel_pcie_alloc(data);
>         if (err)
> -               goto exit_error;
> +               goto exit_free_irq_vectors;
>
>         err =3D btintel_pcie_enable_bt(data);
>         if (err)
> -               goto exit_error;
> +               goto exit_free_pcie;
>
>         /* CNV information (CNVi and CNVr) is in CSR */
>         data->cnvi =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_HW_RE=
V_REG);
> @@ -1299,17 +1299,25 @@ static int btintel_pcie_probe(struct pci_dev *pde=
v,
>
>         err =3D btintel_pcie_start_rx(data);
>         if (err)
> -               goto exit_error;
> +               goto exit_free_pcie;
>
>         err =3D btintel_pcie_setup_hdev(data);
>         if (err)
> -               goto exit_error;
> +               goto exit_free_pcie;
>
>         bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
>                    data->cnvr);
>         return 0;
>
> -exit_error:
> +exit_free_pcie:
> +       btintel_pcie_free(data);
> +
> +exit_free_irq_vectors:
> +       pci_free_irq_vectors(pdev);
> +
> +exit_destroy_worqueue:
> +       destroy_workqueue(data->workqueue);
> +

This looks a bit messy, perhaps we should really be calling
btintel_pcie_remove instead and adapt it to check if a field has been
initialized or not then proceed to free/cleanup/etc.

>         /* reset device before exit */
>         btintel_pcie_reset_bt(data);
>
> --
> 2.45.1
>


--=20
Luiz Augusto von Dentz

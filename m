Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5491EEA56;
	Mon, 21 Apr 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263157; cv=none; b=IGhm6IoCq3qVkGrkkyPxbg/npUFkrohluBLD1fichcno5tmQzPFUsp6dFNB31EXYT3PMj9HWRZg7qrdD+jFtt03Pit3XJHJS94JEwIzs+vxo6D3crhAujIQLZg03oY63kJsRRCcX7blvQimyGnSGeBT/cNlpeg0nfncqf/ab/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263157; c=relaxed/simple;
	bh=DYO3AST2o4cYujiXtTVLxnklyh1EeJ0a9ELH1uW0/4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRB6pJkIqJiPXSeuVoQmV0f8cesboA+eGOczf7m2kW8uREp1rNBEJ+voROqUYaKW6A19DLNLjtH3I0xXxv5E8yg/oPbHRj+TtljV3oYRpoDEWlLqDA5W4dlC2Mi5JG9FQXp/ifVjOhNY03Z6ex3y4V+suFc46VD9vNZKuowasw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAzdaqfL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAzdaqfL"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54d98aa5981so3074108e87.0;
        Mon, 21 Apr 2025 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745263153; x=1745867953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJcRqfa5CCPmTaOo2sTvJJGxZ9DlOMCI9iLuHheiPr8=;
        b=HAzdaqfLVj5cCkKa+X+aiomkAFSsvkGTY9nbGrdEtvQ6EIoeZ9Jyo7iXcBccedk/+5
         xV37iiqpczm260z8NDR6+Fn+EFAMmBvXdYnFigXGNkWN75YdPb8IbDOWmcpwvlKqw7GY
         dSOV/GrVgQfBmFvfhPpNmzXV4eO9hNN/MT9ZTlQkKhe1uUJmdDPc80xeLmcXbs57Ax78
         EE1iFxRqpAlZa+fa+aerWwQKgPtzV5Uz25vqPCoogzLNiS7rv/nvDkIfycRMPa0s7ITJ
         7DpGdPR/8faQS6LhTfgc63j2i2LToXBoMAanMy+ARocnNlKX5b8/y0zsFrG+mMaVkrIy
         aUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745263153; x=1745867953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJcRqfa5CCPmTaOo2sTvJJGxZ9DlOMCI9iLuHheiPr8=;
        b=A3BTjdLJSew2/1T4MgClIWi8EiyTY3x9gMijx/VY5EhcGeJfa/aC4dkvqF4ExrPWUm
         zLFAMSrP4RkyHMf2Dd5+ALKKIH/BZd2qFCB94rNBKb8mjNsmgApM/YpZwZqdtwNstbyM
         QFdbWlv8hSmdE5zft8t3uU3Pb82wMRprgjOyMHg4N2Yfne6n/pqDTu7FGA/qjnDh0sbb
         yiNhOr4Q2bOJ8ZHXLVJ+iL48JsHL17n+swqEPjUl4PptqQt6PIt81uclta4z7UEdF3tF
         Z89IJX9TnmITDrlSDyvjq9M8CvOswBTbcbXvJkFx7iEwqu9yhXRItOXtV/gGxsbsFQQy
         G/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUn+ykMSGf6FOdPQ0IRjXhTd+6T34brT3DBCSy+ISKggLgASDZ5hefs782qVe9HH04jI6e4ehnLuFTefKuu@vger.kernel.org, AJvYcCV2xvXjgBfabWAwyKxNNWP/K/3DzvZGP4c43oFNx0wEdUy+Ld0Uyf+fNJJpA2mH+1se6M0Pd8mfpa4j/UdGm0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8xbKlgHPlPNCSKCf6X6owXPCXzAQVr09HSfP1lcQvtXUDn4/
	oMUxXky20yIEbTJXK1JkU5JlhZLSHzwHGSzabRscq8PClEYuzYBkkHfbebzzpABQjyZdIojxEb5
	hQWApr6qlQNeAC/aVb3+XklO+k0c=
X-Gm-Gg: ASbGncsWbUkbDRK2tttUtcTedFGBDijNGjpTC7DdFaKkN1nFxhufLp7VVlnlkgJleuZ
	aD4MxEMEcxXzb/eLwl1aBq8iTPvZfqP3C43cOcv1UpnOiamSjs3g+gpu0eaCkHzhFbnaLAfEWOf
	5BR5yHdX/28BCdMS4tW4a9
X-Google-Smtp-Source: AGHT+IHXHFlrF4EijWInQ0q6byiERQ/3YNIJpnij63pytbHmgcPlJabHpsS0ZaHrvX3ER21PDg85XpuTKP5mo+QMWuE=
X-Received: by 2002:a05:6512:4020:b0:54c:a49:d3de with SMTP id
 2adb3069b0e04-54d6e61ba8amr3683500e87.10.1745263152985; Mon, 21 Apr 2025
 12:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421072914.466092-1-chris.lu@mediatek.com> <20250421072914.466092-2-chris.lu@mediatek.com>
In-Reply-To: <20250421072914.466092-2-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Apr 2025 15:19:00 -0400
X-Gm-Features: ATxdqUGL3FDMyjw1v0Rvzf5QBxrifSLl3fT6ELdaZgKRxwz3EqxSIe_IBUO2sh0
Message-ID: <CABBYNZLZ7tx6nm1=gzuShgrp5xV4_4AT4_Y=kvAg8zbWjTR5dQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btmtksdio: Check function enabled
 before doing close
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
> Check BTMTKSDIO_FUNC_ENABLED flag before doing close to prevent
> btmtksdio_close been called twice.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>

Please add Fixes tag.

> ---
>  drivers/bluetooth/btmtksdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index 566c136e83bf..3c66e3ee9834 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -723,6 +723,10 @@ static int btmtksdio_close(struct hci_dev *hdev)
>  {
>         struct btmtksdio_dev *bdev =3D hci_get_drvdata(hdev);
>
> +       /* Skip btmtksdio_close if BTMTKSDIO_FUNC_ENABLED isn't set */
> +       if (!test_bit(BTMTKSDIO_FUNC_ENABLED, &bdev->tx_state))
> +               return 0;
> +
>         sdio_claim_host(bdev->func);
>
>         /* Disable interrupt */
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz

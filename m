Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808C02D73B8
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400959; cv=none; b=RRS59jfmWllRmCMy7ssqCKuALeJNeVLa8ZTKzuYPS246aMr4TmF69VrDgRnW+YRrse1Z7HhD8OgadWbeyLljiJc6POLfd/UQvuLG+yrRPdppRqMTq8pfT6mEOrLgCkk44H/7FztHWf/PxzJW+low5W1/nc4fUPB5qXT0i0ZReWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400959; c=relaxed/simple;
	bh=+JwZdOS4OO4M4sPyj7QLRNlKidsDHfjjGOTQ6H2spos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7UpKf8caa5W2SBb1t7EOGZrZILJeHFB2bPtCZZVPdtbW99Z+zu/p7MPdKuoswTsDXOrifR8Oso1lO7cuNjjhNZnoEAloBO71naIzD+gX86E2r6bMaXDooShuCmdr2kpOohBOnSEltbeyHEW4ec/KWeZWAGgKgVjFLM1+KDjlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf3fKTJX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf3fKTJX"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37d96f97206so1673901fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765400956; x=1766005756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ET/9QO44rDBP9OpaiN9wAo/Ddh/RnDMf08D3p9at9V0=;
        b=Xf3fKTJXtAaXPQQzcRM183sxAuJN+JGDC+2zNudR3exGwhar6bvzq2Hy6MG9xCd2tw
         G9kSdSiA/MTm6Aoo80f0Y1xe1pjVgcfNJjzVzVifApcDrnpXvpy22do1INLjxVJ7VVlL
         3VbLzxAzeiBJDo/aJFUsiLuRHSvb8q55539taIZAmZNswoWSzHTKxlZ5ugcjbDOSnTqT
         FVcqRX5VFO6YgXrP/2Ta7FnG+uiiPoTdjNb80IKFtsVArqq+CGoHnpMZsrSdLbA4FH4H
         VPOKyd7zthBPaqQSMfx9rBQDVzUL8wYpjmRDK+uch7pGbDSDEYr/3JqBwiQI1wIt1FbR
         0pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765400956; x=1766005756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ET/9QO44rDBP9OpaiN9wAo/Ddh/RnDMf08D3p9at9V0=;
        b=dL03VrsVs5PGrGPdeDA5+9zhn+60HRILgeyIuJZK1/uTIodP2+rNChdM1R9A8r5UCe
         /Y48gCm76DO8jd+aFFvE1sryU6USG3zArfngrAfVLWvYzjU9rLKLG9ZW4Vg0vCK1uK5I
         its/cSXeTdzlY9PifAuSCo4ZlqO728Lw0zA9M7A5xogP6CNgGtc7nDwq3iX3rm/gML7M
         1EY8OxJhHTLgXRYuQ8x3xKxjAd4E16NrBXebESxWhAaYNYDFi4XX6EEGqFtaTM7tKbCN
         yRyJTrskgMCTVzbWZYNtfh/yG7i9x4PHJLd7lgQ25kq/jKW2aAlW2cc16ajcAID1IYzu
         efGw==
X-Forwarded-Encrypted: i=1; AJvYcCXBrV0SQx3xGQ5EMpaqCOQnJlHz4nxsLeCVq8Leiu847OWT+5G+ey0I39WdoyKX9iWT/R0+qp8T08cBGBYRNDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3tlrN7VUb1gNF0k3EBqInYvXKWen/3GriPx5bDraH1l4/Zt1
	FDZl59XCls67GGWXcOmobRyGTo1IfPYzpDfXxVAPWBA7zUmVJ6OLFdw4kUF59LC9++iFPB4+/gu
	+dEhpW4QR6MVqOd4tH++ovurWj/mezb4=
X-Gm-Gg: AY/fxX6UdWetH/fkza535WL4TpC+zYJTqlhB1cWW3U0CIe/ecLp8TDczarOnEAuUssI
	KLo69cSmnTXRVzaCUaPlU000cMpT/nrpkRaEsmsb67s1hX2xzPbkgGxV9LKwP7vhUhYPBznWrLo
	woqIMRWT8m7YQ5cGA5WcIiDq9VsBfFNCn2rNNmpL4YI7wUdMdwX4R7aQdfeTPQ/tz/S/nKzacqf
	wDejkQVUc5baivwrgcRCnwcYuyt3PA6uX8ZWOk4n7Fyt2GN3A4Zsuon2SFUtmt39qSIbg==
X-Google-Smtp-Source: AGHT+IHdCox96E67zeHTDjL/WO2yGbC6snv7WJvcW8t/0qFT9DOrWg8r9WPmdGrMqw4kUG3QDe03qZMxxZ+Jt9yBp50=
X-Received: by 2002:a05:651c:1505:b0:37b:b8c0:b5d4 with SMTP id
 38308e7fff4ca-37fb208c3bfmr10569841fa.23.1765400955319; Wed, 10 Dec 2025
 13:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209120559.2991698-1-chris.lu@mediatek.com>
In-Reply-To: <20251209120559.2991698-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Dec 2025 16:09:03 -0500
X-Gm-Features: AQt7F2pUKepbtCaHCSB5Wq10ueXFl0KdG1dLSST2gFITkH7g0XHmlMzylb_0RLQ
Message-ID: <CABBYNZ+o_ewu7fwDLSW0c4BEosG-CqugK+7JgY3TBf2PcPrm8A@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btmtk: Trigger reset on firmware download failure
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>, 
	SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, Dec 9, 2025 at 7:06=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wro=
te:
>
> Initiate reset flow if MT79xx series BT failed to download firmware when
> doing setup.
> If driver is not able to get event after reset in the first section of
> btmtk_usb_setup, the protocol is deemed unuable and driver will return to
> prevent from repeatedly executing resets.
>
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index a8c520dc09e1..8b1443b9e9cf 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1333,7 +1333,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>                                                 btmtk_usb_hci_wmt_sync);
>                 if (err < 0) {
>                         bt_dev_err(hdev, "Failed to set up firmware (%d)"=
, err);
> -                       return err;
> +                       goto reset_fw;
>                 }
>
>                 /* It's Device EndPoint Reset Option Register */
> @@ -1353,7 +1353,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>                 err =3D btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
>                 if (err < 0) {
>                         bt_dev_err(hdev, "Failed to send wmt func ctrl (%=
d)", err);
> -                       return err;
> +                       goto reset_fw;
>                 }
>
>                 hci_set_msft_opcode(hdev, 0xFD30);
> @@ -1444,6 +1444,13 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>         }
>         kfree_skb(skb);
>
> +reset_fw:
> +       if (btmtk_data->reset_sync) {
> +               bt_dev_err(hdev, "Mediatek do firmware reset");

This message is a bit cryptic to me, why do we need to print that you
will be doing a reset?

> +               btmtk_reset_sync(hdev);

This seems to be doing a hard reset, which I assume you are doing as
an attempt to recover by retrying to setup, but if it fails we may go
into a loop condition trying to setup so we better limit the number of
attempts.

> +               return err;
> +       }
> +
>  done:
>         rettime =3D ktime_get();
>         delta =3D ktime_sub(rettime, calltime);
> --
> 2.45.2
>


--=20
Luiz Augusto von Dentz

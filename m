Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63E401A1F
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364554; cv=pass; b=IY2Kp16o5tKIVHWHP+vTt8c+iTqFZvnIo+cAa4d4lVORZ8NmsSFjB7t5useT69IUfPtn06I4kNRl+PX76DWt+5dg9f7CCuUO6hgFnTyOnaQ8sdyj80P/PgIWmTiGXlni0TNAFLRbnyhTbwNT41KygT/7zlB4T9NaCUbIJjRlsTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364554; c=relaxed/simple;
	bh=W1a7sd8lE8ldO+Hcla/zjRAZekhU2DZk2ZHiTscRCjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDvbTrkK017v7cNCuzkU4CrPTP+QDQJHC4sLnqLVnbIDK/kDhSNXRqHi139BRewrm7nT6Z6OrHy65/+tin5+Rzu9Sou9HZzWUBHd4q3Dpk7hBz3sLjii1OPMDT0VelxUZoDBXTb5av6+2/ouCOcPhJM9+06Y7hwHw/CC/6A8Nds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqRvaUVB; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqRvaUVB"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46726528f1cso3716189b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 08:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364552; cv=none;
        d=google.com; s=arc-20240605;
        b=XkV9ji4TJNLheRLw2cQgaLEoQ+YbpK7bzPJ1h/oEi0u2ftzevEle0b2CTIQriWmwMk
         xjfbUGk5Ue+9vbzYBAj4iJ3GMp2a13kjgTrtOnXIjEW5vg5KccwXjsUcLmtQEA7a35uR
         rddP0aKNFryLGIab4wNub/hN86uj1WtTcaEtX0KzOhxiw2W1mM1sPpr8ZYGYzeadRsEA
         JbvgF75LywNqcbW5vpQURavnFRxUP7S1xtHw+90bCesdEmjs+bmGwPaK56bRORXJe39C
         j4gYLQwq5i6/7RqHXKSfl/hNQSrf+Al7vJs7B4wzpnMWDUButllKrS2G15cXQ2OwYU4/
         M/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wvigr17fBk/dQC1zbpz1VzS+x6v7XXvCtHsA3oWqSuM=;
        fh=+DPgPtLFvUq4iZn0QgfRzQwbOv67Xd+hkyTsy68VKEE=;
        b=LmOK14bn8Akvqpfnb1ijsmrKAEBUSDkh5sJ1TjwrzdJOSNgLaxC5Xy5ajlYBLj570r
         hZot9Y9vjM6hXTOuFKHVuv1a73WWk/vS9hYrkmXF39NZMZ8J2Hf897iIxKQVjMuaD7nJ
         OwDImo5Qfq4tSdhNypgs2yh9RBvWDaHgOwj2E0s8N8/QXFLvhJwFSVCt4JNg6KgbiH02
         YTyDFXIZZ4C8HXJ+9rhK83PHeXUYxojSMkYMJI1qvvbH58B5m9Fssosk+DOXucnyz/3z
         XBXEUM78oyoKb0PdYdgsOs7O4IMeGMp4GYq1ap3NZqLh4153e19rnZIYdNEAXO8QH6oN
         0TAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364552; x=1774969352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvigr17fBk/dQC1zbpz1VzS+x6v7XXvCtHsA3oWqSuM=;
        b=dqRvaUVBwxGSHfzGFelFxV0l0p3GFMufJBY2yN+fJ0sjp1y8pmCmX2bi+0v9lQPWZW
         8AqIg3td/4k6ugDRS/BdtaA2h9wXvBVMs6OYOvdJuksOMR9COVpzN7tC40RDeabh+lpU
         DjcpTzAGHovTO+Q/q8Nxgkh1ObHyN2wR2+ZLanl4TKpR6k4hGxbf6QZSlGVKxL+FlgDG
         YgyCbI1qTHxtU6/XQZ6oPRnNjMp8sDFkxrseaXRLkVK0OyorZ7bXUYIBbOE9RifopZow
         SeSNo225+NLCgfvRMMZxyn8IN/QZmRhfFoNkEugFWlHeBOOy6jDiiku06fw2CvZOtKtm
         EKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364552; x=1774969352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wvigr17fBk/dQC1zbpz1VzS+x6v7XXvCtHsA3oWqSuM=;
        b=tBuEUyLKVjkmTdgyTAzOtCX2N9ngD+B8YbBRY06hYjzUyO/hNh7DfVBtuZ5lo9hQ9j
         Aphe4qBGeAMhkzSEfmNYyZx9W03G2k3CtSDjyd2bz9VZgMWqFcSym+I4WpLPnKyeh5A4
         +7kzsar/k1IWCKU8mc20ZeY0Vt4IKMGie9bfzH8hk3QvYo/TmttoNnkcQPLufmFMeSMt
         QqLkSh7xZJP/JKPP3uekDxkqzBrhyK8cd+i7X0OxFBYS5PtMWyTuYyZNXvrAxtxjXzCi
         XA90SE0K4y/8JCmosdb2ismozG/yBjRlrUoCRebRw3MyQ/DEColQ/yv/VGnODVJeUSXT
         K9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO26bYgJP3mWtlOyQONIhQxjCPnq3ZFEiHP6e7u8vvc+Go3RJQ8bF7rjuOar841k5PMo0e3Bhi3ABVgj9d6LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCeS3A8UIEtBR1oBHJ0TM3EflHjTkMSJqWOZqlhIUHcLJ0toBQ
	e38dTMt3+jN8caQer/w1SpKPmSGOmQSbldEZqQf0rSdabTa2JAIwjTG18AAcwm0/usEUUOWvNB3
	QdX+fl9gAzM/Ufo8cLkF4rfvfiYYhijAFDYRT
X-Gm-Gg: ATEYQzwKAdBU3CgaQR9mxueK1wkd//geU8wdItmRYkiHJiBDcHZrumCkockV++vypcV
	p1Iz/iD0HQKH+pjRZhvavGBO8iDFRKib+/T797Uvrrv53o99px/hWIJWVF6Z9s8fKlfeFfK6bUk
	hrP+o2LW5yVa/tasfqrS5ldnAQInQB92UQERHwnjGS4cRVaTgGmj1wrMxpwQWOAw/AzIjQ+wKLi
	Q0llPH4cXESy1kkxBp9W/wVzf/tRaXeaiPsFi2dlcsRtM0YXd139/obyl5+7fEPfYNpB7nd5YVn
	S6O1LQAVxyu4OOIZRb0DJIROX/Larqe2k0G0s6JGfll+MblsPNkbq5RVEETAhRsW7nUNkvwlFpW
	iyQ==
X-Received: by 2002:a05:6808:5384:b0:45c:83dc:fab with SMTP id
 5614622812f47-467e5f52672mr9202586b6e.40.1774364551059; Tue, 24 Mar 2026
 08:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 11:02:19 -0400
X-Gm-Features: AQROBzC2tvn1w-rKRwsuBxeDyYomWGPZQR8HKgAJAGUI345AFcDh3f5LVSWE7A0
Message-ID: <CABBYNZJs5swzc7tGdDZbG0a-tFpHGB_y4Yq6G_+4+984+4joyg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: validate completion ring indices
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Kiran K

On Tue, Mar 24, 2026 at 4:51=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> The MSI-X RX and TX completion handlers trust the shared ring indices
> read from data->ia.cr_tia[] and data->ia.cr_hia[] before using cr_tia as
> an index into the fixed urbd ring arrays. If the device reports a stale
> or malformed completion index, the driver can step past rxq->urbd1s[] or
> txq->urbd0s[] before it gets a chance to recover.
>
> Validate both completion ring indices against the queue depth before
> walking the descriptor arrays.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/bluetooth/btintel_pcie.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 37b744e35bc4..06c2b81f2b6e 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1008,6 +1008,13 @@ static void btintel_pcie_msix_tx_handle(struct bti=
ntel_pcie_data *data)
>
>         txq =3D &data->txq;
>
> +       if (cr_tia >=3D txq->count || cr_hia >=3D txq->count) {
> +               bt_dev_err(data->hdev,
> +                          "TXQ: invalid ring indices tia=3D%u hia=3D%u",
> +                          cr_tia, cr_hia);
> +               return;
> +       }
> +
>         while (cr_tia !=3D cr_hia) {
>                 data->tx_wait_done =3D true;
>                 wake_up(&data->tx_wait_q);
> @@ -1403,6 +1410,12 @@ static void btintel_pcie_msix_rx_handle(struct bti=
ntel_pcie_data *data)
>
>         rxq =3D &data->rxq;
>
> +       if (cr_tia >=3D rxq->count || cr_hia >=3D rxq->count) {
> +               bt_dev_err(hdev, "RXQ: invalid ring indices tia=3D%u hia=
=3D%u",
> +                          cr_tia, cr_hia);
> +               return;
> +       }
> +
>         /* The firmware sends multiple CD in a single MSI-X and it needs =
to
>          * process all received CDs in this interrupt.
>          */
> --
> 2.50.1 (Apple Git-155)

Can you review these changes?

--=20
Luiz Augusto von Dentz

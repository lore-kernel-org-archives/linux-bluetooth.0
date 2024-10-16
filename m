Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876F1384B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093944; cv=none; b=dYgw6OjPY7rVM1UibRGPG8VKHNJc5B3QabPYJwPib25qgY648znpuObUcEmcjSp6lH2fBl1/m8PshO4HB1tN/VY5SdFoUnS60Lm8aANuVFPmtOiNbiH2mZZa5334tPKFGO/pKDS5ppzBIyXlLbSI5iD41HH1VJNWVVMJpICVfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093944; c=relaxed/simple;
	bh=2NDRH+TYAAY7I7X1yW81rj3IGQ3e83kpLYentzfSvAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kat8kwE4RyjBLDCQpVtnXDa2ctaiAQxPNLPkzeoOeG7dX+Shkk/Rt9rRvF+A/1jfbIsyBim6R5Wj9tFBaVaLWfND9HfaU+POlCnQkJU49xCOMhdk86zYZRcTjz55E1qsmnNbJe9vVqB5Q687EZ85LS1jrM0Pq26gyhTgAQML0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEqwvdTt; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEqwvdTt"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso49993731fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729093941; x=1729698741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DifIXuX1F/3Vv3DflyTxzu38Cos+BImnu6gDNN9EbM=;
        b=PEqwvdTtNCbTCLXXVlx2D+Xv1mFdQ/0cRDm3qmw5SK7ga/FJaXFj7/IFk8oeGlIJB0
         aNm4P9CFDh0dJLGipIPdx3qfKfwv60UqFThzBKp63jHqY2/QE82Ezit73+sLpwnwkVrB
         +qUn3Pv9U1S3JaFlcDLkVU1KseMK1MTjU0NdlXoP+/El2IHu+5GO8AjlInd3ncZ9J3b2
         wEqp4pF/lBxFfxmA/RUgZpq5gd65/lngvEKJ9g/IiYIySEn61MR/rCl4WpWclIyMU7lq
         oQPAuis/dcmQXhQS7qXf1A5WPSBD8jEZhO+kmd/tkIZV2NSecmzqXZ9bNx8i3Xs16No3
         5+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093941; x=1729698741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DifIXuX1F/3Vv3DflyTxzu38Cos+BImnu6gDNN9EbM=;
        b=ZnZ81TRyNOOX3xAROTPX4AKZt/safyVVoWXRct8G97zLW70Ii4gRjn6JGqq3Mt9Q0A
         FhIXE2tlxkWdVLWtbvx/mVhae2cgh/a5klDUyBk3fAd7fDZQd7ZhP3qI3no8+A445/QS
         le5jEsdkHQ7zwmYPSxXKNV9eQ+eVgXEx/Wb4lW8PxPuHWHv1jvlRMyG6Xq/zIhT+RUqM
         5dXMQX7gmrTyIcgJ1BkNjFQS5Fa3EygpuRxCIl+zQVJ/bCrxB6xuRx72ubfvoXlGFb13
         IsIWtmOi1lwTys4eRNTdWv5QY9ooEh4d6EwWEnENE0GSX6EOpJgFIwByIwkEdN7CMJwJ
         xWvA==
X-Gm-Message-State: AOJu0Yw7NGJ++LsbhB282oYTX/gHl+a4Y+umtr4+cuppJw/DXYJKza17
	yR24o9JMh3K6Z2XD+xTjYRQG+vC5A3SderK8gO7a26uOI0tXENon+SUfFQ3ABcb+8AzEam0x4Hk
	X5SjBphQ0hDrf9KDTaR32G6/+eAo=
X-Google-Smtp-Source: AGHT+IFfa5My3HGKbHFuAFzsERssmHos0yv2zdD/Nnid299NZwpbFIMYrjfb4aQi3XdSCMv/Uf3jZPhZLie8+Il83BA=
X-Received: by 2002:a05:651c:1987:b0:2fb:4f8e:efd with SMTP id
 38308e7fff4ca-2fb4f8e10ebmr94154181fa.32.1729093940211; Wed, 16 Oct 2024
 08:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014085602.711258-1-kiran.k@intel.com>
In-Reply-To: <20241014085602.711258-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Oct 2024 11:52:07 -0400
Message-ID: <CABBYNZJDsR8HjHb83x6bOZT0ZCoxLvHKcD+CqmFjK4Ct3mzpxQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth:btintel: Do no pass vendor events to stack
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, Oct 14, 2024 at 4:41=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> During firmware download, vendor specific events like boot up and
> secure send result are generated. These events can be safely processed at
> the driver level. Passing on these events to stack prints unnecessary
> below warning log.
>
> --
> Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> --
>
> Signed-off-by: Kiran K <kiran.k@intel.com>

We need the Fixes tag.

> ---
>  drivers/bluetooth/btintel.c      | 6 ++++--
>  drivers/bluetooth/btintel_pcie.c | 9 ++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 432f723e3869..652a5595fb16 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3383,7 +3383,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct=
 sk_buff *skb)
>                                  * indicating that the bootup completed.
>                                  */
>                                 btintel_bootup(hdev, ptr, len);
> -                               break;
> +                               kfree_skb(skb);
> +                               return 0;
>                         case 0x06:
>                                 /* When the firmware loading completes th=
e
>                                  * device sends out a vendor specific eve=
nt
> @@ -3391,7 +3392,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct=
 sk_buff *skb)
>                                  * loading.
>                                  */
>                                 btintel_secure_send_result(hdev, ptr, len=
);
> -                               break;
> +                               kfree_skb(skb);
> +                               return 0;

Perhaps we should have a common way to drop the skb e.g. goto drop.

>                         }
>                 }
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index d581a539d439..b2eeb6838247 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -551,7 +551,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hd=
ev, struct sk_buff *skb)
>                                 if (btintel_pcie_in_op(data)) {
>                                         btintel_pcie_wr_sleep_cntrl(data,=
 BTINTEL_PCIE_STATE_D0);
>                                         data->alive_intr_ctxt =3D BTINTEL=
_PCIE_INTEL_HCI_RESET2;
> -                                       break;
> +                                       kfree_skb(skb);
> +                                       return 0;
>                                 }
>
>                                 if (btintel_pcie_in_iml(data)) {
> @@ -568,7 +569,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hd=
ev, struct sk_buff *skb)
>                                                 btintel_wake_up_flag(data=
->hdev,
>                                                                      INTE=
L_WAIT_FOR_D0);
>                                 }
> -                               break;
> +                               kfree_skb(skb);
> +                               return 0;
>                         case 0x06:
>                                 /* When the firmware loading completes th=
e
>                                  * device sends out a vendor specific eve=
nt
> @@ -576,7 +578,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hd=
ev, struct sk_buff *skb)
>                                  * loading.
>                                  */
>                                 btintel_secure_send_result(hdev, ptr, len=
);
> -                               break;
> +                               kfree_skb(skb);
> +                               return 0;

Ditto.

>                         }
>                 }
>
> --
> 2.40.1
>
>


--=20
Luiz Augusto von Dentz

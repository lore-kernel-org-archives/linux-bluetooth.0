Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538E41D20D
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186894; cv=pass; b=iE27QxkoR/ymzOC5J+UAndj0pcajtKavICSvwcq3+U7JytR6q25wNItWjdD4XXK2vBNKDmeuPSwD2Tw6XEIi+I+vtqUA9Io+jV3A46JEzPUxYaao28cIAZmZP/BmPqDodehtSwJgLfhjrOPdgRkLfFGj94G1dkvv/NW76OK5yKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186894; c=relaxed/simple;
	bh=Vg6qa/oWCykbJ7SodXP9U7iBmt3nJIPr4+ems69bI8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4FK9jLVGyxg/+OzNKRMRHj9JbuA1ZBT9hZDPcGk/Qsxh3g6MI7IKMI3gyPD6x776OnlXLmqgVkSFg7OqqEZ8uqjmA4C/lp7OTv025hGpTtinFa+s8HoMYmGbkIoFDR+dlKGQVkjJN1e9QqtrdWO2h7owdRg2BKrB5sKw8wDINU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUVaIfII; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUVaIfII"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66f7f62e915so901983d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 07:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788186892; cv=none;
        d=google.com; s=arc-20260327;
        b=SmNVhCuavj0laBVCI0/vHICVgxtux3M6YLooOXJk76hUKsIvOCSawxOj/FdESH6kF/
         LoOW2AmkcvXWVqipTsHrHgYQrBqKiueZQSWTg70NBwe020MRsGQxZ7oAAahtPxnyk31v
         EPIhZbDFUWwN6g3SGR7o/3JmC+uTvaqjRxkYPjGPmK5y1JEgdogEywGHLzZQ7Kp91yQW
         HooRJT5vCx6/WvNd5JAQDxuTCHtIPwUI4D9aOxJqNDGvHhd1crI5QIln7fEwPRv9uFGH
         mUuBpzIFkfLY7opwBfvGjQ8G83XDav+9sdBNTRCsZDBtQHAbw7A+SJE+QMzpVLlFrz6e
         /FuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XY6f+IczaGd3eHuBAFGxtvbUpgrl4v2MVITJxiyqmjQ=;
        fh=mgMPOrqmPOrexIOUqRRePul2mY4IBaRnrLssuOQFZlc=;
        b=Dg6cWgrB4pG10eQYUYJE3ep+lqWbRPF97tmQaMRaL/aIb3EEU1UF1w5aZBs2B2kwYc
         EbY0xj4k+ys/qpw6brjj6acItJuy99iUpah0+1pMXKTYmZtrxPpWoNu/LIUfBC96o9GJ
         Ekd5oMIxozliIY1YTA5sUMyNuWpw/8LVEgadQiW5muuBZbCjWpKdIx/PxSvFqC5ziyBG
         1WJ+JppyB2o5+DFmqwI+DM1oPGIkBMbUTQthlGtrklkwJGGLmEWtVRb6m+UgiCNgv8s3
         zB9weDubI2dtLFdegp0dS1rugiGBdYqLxJVTxYiI0gN9Bnb2ch2tK3ROxr8SaQBFidP/
         v2zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788186892; x=1788791692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XY6f+IczaGd3eHuBAFGxtvbUpgrl4v2MVITJxiyqmjQ=;
        b=VUVaIfII1A2EPaIKOk6AxCi3PVdc2+NpP2UBTlp6I8mpnBMCa4dEZ/VxdHVGXSi+mq
         3YxcsvDaqrFwszt2ypYX9J92YRY1HG5Lk50sj7/tao9xhQifDST67UVxJ32kJMiQ4tog
         tHvDfqlVbZ+X3tmugfBAkpzTTB53cypULimtJMQGQp2zcPVMeAlAs4cVV69n3pPMycqa
         NUebNs8BFVfDozb+H97/bCWEHpnXqv0qcKL5BdyCnaZwkBonTtBlEqu8qDQVSCiAd22s
         ba6XjY0BMQaQ9GuJbJlzGP7zh+7ivBvFoBcpQ7t3DtzMQRQvXs5O8+/kZkEfAGfibDJr
         PAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788186892; x=1788791692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XY6f+IczaGd3eHuBAFGxtvbUpgrl4v2MVITJxiyqmjQ=;
        b=n+Mz8R5aUvwk3y2mfCUdw8iHw6x0olPV6hSHFjLG+1tMaJB5Zp5XUxuIyZ0s3FFIIa
         BgCg544LINaNJ9l/0C/9HFh02PetGf3JHV5cyibO8j8h/denFSIs/v75716pWZgMFKpP
         8uVXGrluARxvWM2cb3Yr29gyJhSmO/vb5REnIbVa/LiTMWZL/HsYIrmOEj08a7pF3rFQ
         0c354P4GFS4UXofCfELo2O0EN0BgM9cdDs5EkJG+fxP1pbGdl4F5vHWtj3P9GhSjsXIy
         7FaTFKz0iH7uxi6QVsPxGACmuhSXrZx9lutmEZ3pW1Ey8stHwbQcQ4a81yRnOpnWl+PD
         JmAg==
X-Forwarded-Encrypted: i=1; AKwUvBzyD0FY5GasvRi5L/e8SsatK1Shc89jCY2GZbgCIwEcsE5znXUYbKBCMGYyIp7FZoUzf/fHh9eutLnV6DI7dbU=@vger.kernel.org
X-Gm-Message-State: AFuF++k0tjtDDZq1nrfbQC9x2tzurMWKoshbUyeCQ/0aGMRCIQBfOu8H
	Odn/RELO8tRM1eNe7aK7IMDBu4rbDdhE0E3W0R9VqeGXLfaMvcu/PsTNxxhjVzrT3ZZhohp1CeE
	uVvyVCBv62IXE+VV39ZHnQdw2Otm0+48vXnf9pYS/fbmp
X-Gm-Gg: AR+sD12oTBGdOeueL3LzkhbigZbyxBNd027OHd9T0ml3U8/Xlh3M92xNWVWQ6L/6GX4
	/W2ybZ2aoOqdb45AkqGJLHhYaHxqfSyUM3IYRRTisOvM8X6ACN1Bc+wwTJK4hB+pR9RWSVTsH3q
	hgWDU5tRw1zlkB3Qalvt0Oepg8fK2WfLNJw8ULUijZO/zlGudxaPcqP9cvP3kdQXZmUoJiKDaVv
	GUyRQGbL/hxBJLrs1PfWUJyNogpaqAYnSYcBgP4kgw2ihYPiv2U1foiJTjWlXUiFTAv3sIboByG
	fc+W/eCqGXfjftAq9Js5E0SLDoIehLca0ofnykjuc4JiyBEi5XzoKANKJpOmeyIB1UYjD1Sy35r
	39O2F969u8It3c2Q0l46lvicDExhr
X-Received: by 2002:a05:690e:2513:20b0:66e:6554:af0e with SMTP id
 956f58d0204a3-66f87f572fdmr307746d50.40.1788186892292; Mon, 31 Aug 2026
 07:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
In-Reply-To: <20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Aug 2026 10:34:39 -0400
X-Gm-Features: AcwNN1Vj_rechvkr1r3wCtvAgnmugKU5yVnftGuW_e-pNh31_EPDAcuGWAXykD8
Message-ID: <CABBYNZLvrc9=bfjEuj_tXbzZ3V+SQqXPxY_2sS9bs0Fc8xiyZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Aug 31, 2026 at 1:04=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> Hi Luiz,
>
> This revision addresses issues below you raised in our previous discussio=
n.
> Could you take a look at this new revision when you get a chance, and let
> me know if you have any further comments?
>
> - Pre-process the PERI frame
> - Don't hci_send_to_monitor() for PERI frame
> - Don't use the safer skb_pull_data() helper
>
> A malformed PERI frame, once identified for what it is, is sometimes stil=
l
> valuable, so don't drop it early via a min_len/max_len check.
> For example, a malformed memdump frame needs to reach its final handler t=
o
> abort an in-progress memdump procedure.
>
> This patch series is to support Qualcomm multi-subsystem QCC2072, the
> first 3 commits are simple dependencies of the last one, previously
> sent separately but now combined into this series, each commit includes
> its own changelog below the commit message.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Zijun Hu (4):
>       Bluetooth: btusb: Add recv_intr() hook to btusb_data
>       Bluetooth: Add generic support for vendor HCI packets
>       Bluetooth: btusb: Build the driver from multiple source files
>       Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
>
>  drivers/bluetooth/Kconfig                   |   14 +
>  drivers/bluetooth/Makefile                  |    3 +
>  drivers/bluetooth/{btusb.c =3D> btusb_main.c} |   77 +-
>  drivers/bluetooth/btusb_qcom.c              | 4513 +++++++++++++++++++++=
++++++
>  drivers/bluetooth/btusb_qcom.h              |   91 +
>  include/net/bluetooth/bluetooth.h           |    6 +
>  include/net/bluetooth/hci.h                 |    1 +
>  include/net/bluetooth/hci_core.h            |    5 +
>  include/net/bluetooth/hci_mon.h             |    2 +
>  net/bluetooth/hci_core.c                    |   44 +
>  net/bluetooth/hci_sock.c                    |   53 +-
>  11 files changed, 4802 insertions(+), 7 deletions(-)
> ---
> base-commit: bcb621272aa04a116a74ab5fcc9324231ffa3acb
> change-id: 20260824-btusb_qcc2072-abb918ab4220
>
> Best regards,
> --
> Zijun Hu <zijun.hu@oss.qualcomm.com>

Sashiko found several issues with this series:

https://sashiko.dev/#/patchset/20260830-btusb_qcc2072-v2-0-5c0e0c9dd98b%40o=
ss.qualcomm.com

--=20
Luiz Augusto von Dentz

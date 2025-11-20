Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA41D8E10
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600000; cv=none; b=IuoKFVDxbvvGJ8/QIf5L7BD/ygLREFM9F356coEEbLKTRCZW6DaCsjiLj6YUrgKaIFZQmt+9G5Zv+HjDYokfU5kXHdUYRl25X2/vvaUKIpJrkFy9iRf/HeXAQlIy5rHjadWE6dOi4Uty40aMpazaLWIhvMhQhlxOB+/vfA10FiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600000; c=relaxed/simple;
	bh=aucR+9aT+lKrGwwXTyqF+EFKBa3URGwEfMKLSCv4XjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjKxqviWDiieQX5P/4aJsb2X1xTLRKOrrq3dZVMvxGSFHt7+y9NHyIuqyuldO11bZ2mdqOa5Nl6VVBerlSGBFFK2J6V3Cqc4dQqAouQM91V/uvf8pFiQ0NnJUhKypWpbHmMKTXrwCV9bSyZrOsaP7tKz6e+LsY8ps7Az2BYNYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XvADL4p7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XvADL4p7"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so521680a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 16:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763599996; x=1764204796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW8I6Fq9t2L7adxKOxyY9vGDX1ivVL7y0AgvnnUr40s=;
        b=XvADL4p7+Tt72ZVQEYBycpqTucMWNjh+A5obFg5MMXiryp4x4+fC2K52dEtZ4ErQa7
         w6e3pF6Dch1gIaMlRwu/YlQEzQfMpu6Fvo04l8yCZs/Qt6J64hT1mFgemBEVb5V5Iaqs
         hvdrujkGsWcJjM8NrT1LxzzWxYAt5N+ztNxVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763599996; x=1764204796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GW8I6Fq9t2L7adxKOxyY9vGDX1ivVL7y0AgvnnUr40s=;
        b=oVVqWrh+NS7Djx/NZ2aIOY0KNY6rgDiChAHdeJo/n1OtG1ANTn7ta3ZXqecpUQpZJj
         /QHJiiJkCQy9DXOlNMykg1B2gCI492xElVt1crNVeBJ9tJak09HzvS80+dwQVt7CMUeh
         TqpT/zPBa0BMUpE2Dq5+EPJQmC9lWN5tOMCWfs1S3bdRj4dMcUkuc5OiJzyRToX8p7bm
         hqGhGYanBRLsa5cQsQNpr056+c4ssA4YWL2xPCI7ehQMx6EoGyYts8tDipyc8pWuuTtS
         sQQno2NcfP+npvWX2v4xY4ubBjPrhiTHOIG+BL4+vaSYyoN1n+bBo3EGGmePqvLjLPOI
         HpRw==
X-Forwarded-Encrypted: i=1; AJvYcCVBSF9csBpvpKmO+RpuD8uddZq/io/5all7xytMvpCAiS7zYSNHz++uUpmfCeZ7891rJoD+NL8N0Mp+TEn0cLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gltwgX3cbpRKZlf4CFMPwnPpyPYubZ0L+Kp+76Ktc9NziCVw
	qK9dTx2pxvsbgFerqrX2E8xPBSWFOraS1kHbROiD1lg1wPvSqyHLT36KwRO7MHo0AMKj9x0c8iP
	q3apijszY
X-Gm-Gg: ASbGncuhMcrqa7TiyvO45FUCAoZ0oXLT+bUGLeaCHG7ecjGKnucIxULQE4MyG5Bacv6
	gh2+AjH9cEnxNY/H7JRMsDqofjxf22tAAi6L0V3q507WkSKM1gQ4R5wsyOK+tnmu/V3qmZFGOZH
	yLtUXmLCP+QWZR7Y+GUBd3MH/nYefpd1cwIGYiyOl91ajEc/vJl9Yo4MUp7CENkZVbmYUN20Swl
	rhjRSd3nWukNXMsoMJMTFhCSKPWQZMuCVaQz99u2k+cf9riTJB9e0Vfnmls/J2EByJOPtj7SePI
	R/hkBvUws9tq2dhb1qrZjRrN3nSwQvyctq1CSc7Fg8wFf67mdtNRZ5OErpM6SnHzC4zTEuwzsaV
	lH8IDhLAzjiTcP9ne5PO+EEdKtIoMwYtbYAYWGAvLGH7X8LZmqDp/hbqvdHjvBZfqJqeuiMBGAj
	aL9znbIgPUP8iN0EkdTlLFbJAfZx8Mm8r+FGjBVit4eECIRThnuA==
X-Google-Smtp-Source: AGHT+IGP267Mpv5e5vln1IvVoPxQn7qw115+EPR2yWCtdrYMIxh1zlQew8WRMV0xbiW/hq+qqTaSCQ==
X-Received: by 2002:a17:907:84a:b0:b72:5e29:5084 with SMTP id a640c23a62f3a-b765869343emr26060366b.4.1763599996019;
        Wed, 19 Nov 2025 16:53:16 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cf0435sm74371666b.4.2025.11.19.16.53.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 16:53:14 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so2076595e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 16:53:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWDi9dc2K1Xpf7TzqCHXSHaRfQLz8jF7DuJQIvWchJ4R96TsG3frplNfxaIS+NZT7vYetteIAbK0RqjaLLlEY=@vger.kernel.org
X-Received: by 2002:a5d:5f45:0:b0:42b:3c3e:5d53 with SMTP id
 ffacd0b85a97d-42cbb2783c3mr86119f8f.16.1763599994388; Wed, 19 Nov 2025
 16:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me>
 <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info> <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info>
 <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com>
 <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me>
 <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com> <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me>
In-Reply-To: <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Nov 2025 16:53:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnxqYh2GblOKOFIt0kJU2HklGRNL4MV5MetawgKuhQ8ix4i6fyRlr-tsRI
Message-ID: <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized
 since v6.13.2
To: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, 
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 19, 2025 at 4:43=E2=80=AFPM <incogcyberpunk@proton.me> wrote:
>
> Yes, manually updating `drivers/btusb/btusb.c` , with the below proposed =
patch fixes the regression issue.
> The proposed patch solves the regression of `bluetooth adapter provided b=
y btusb not being recognized in both the stable and the mainline kernel sin=
ce 6.13.2`
>
> The proposed patch:
> `
> index a722446ec73d..1466e0f1865d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2714,6 +2714,11 @@ static void btusb_mtk_claim_iso_intf(struct btusb_=
data *data)
>         struct btmtk_data *btmtk_data =3D hci_get_priv(data->hdev);
>         int err;
>
> +       if (!btmtk_data->isopkt_intf) {
> +               bt_dev_err(data->hdev, "Can't claim NULL iso interface");
> +               return;
> +       }
> +
>         /*
>          * The function usb_driver_claim_interface() is documented to nee=
d
>          * locks held if it's not called from a probe routine. The code h=
ere
> `
>
> I applied the patch as suggested, but now what do I have to do to get thi=
s fixed upstream and fixed in the next mainline & stable releases.

Excellent. The best way to get the fix landed is to respond to the
post I made at:

https://lore.kernel.org/r/20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd817=
36649568a@changeid

...and add your "Tested-by" tag. With that, the Bluetooth maintainers
(if they're happy with the patch) will land it and it can start
working its way to stable.


> Also, could you brief a bit, on how this proposed patch containing , a NU=
LL check for the `btmtk_data->isopkt_intf`; solves the problems introduced =
by the problematic commit with: [ Upstream commit e9087e828827e5a5c85e124ce=
77503f2b81c3491 ]

Check out the commit message on the patch I posted. I explained why
the NULL check fixes the problem there. If that's unclear, I can try
rewording.


-Doug

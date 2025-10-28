Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B433FE0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666533; cv=none; b=PKakqvpDxcYVPFfTgfQ85ryLrbLU6LTFXb2lV57fzY10tqpCN/3RxmW/G2AzBmh0z4JCvbrJFVVU8Y/Y1rYgB/fTOy9PZxWCKvpqua5pAF+ApLhB00LKxIadA0XtjaUvYXxit0M5x/zWBv7WyAUiaGwwt+2OFinmHTOfSj5KqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666533; c=relaxed/simple;
	bh=k8I9h+2k6IeAyl3/Vc6zs1prRM4rel0Sjd0zv9duXjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjCNLBiyBxtde3brNEbzckdVnFZLhTpR3GW1H6aEOCtRJ+C+/6jSNBfwG48lGY4DDfjhtkIC4oLn0DYZesqbgmd2V1WgIgNsFsgg9SckocJZAjFZGPl3cC02Qem6X21r2tE4m4Q+H4SfeClVrzO5nT5rKjPleVjlUvgNRYxfZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ksuUqZ0Y; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ksuUqZ0Y"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5930f751531so1199637e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761666529; x=1762271329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwnCWAx8OAVXDxRLd+WdlJJdVlnMbvByJtUaS0y34MA=;
        b=ksuUqZ0Ypzyeyx4wH585OL1Kw2LbSuTiBo2MRICReaYuuSEND/RtKHtCyzwAhD4UqP
         tF+2gfp/B8Qf0MiR9QZEvZr/YLKGHhePhe4ap8Uee7mEkAW2wz6LEESQiGQqGQZl2/Mo
         z39AD1wnCuZLlDhRNv/dFi13d82/8ofXGtWT2mputn9eeZ/ej9qU0NjLufzhph9o+zHp
         h5We5NPUFgs6KwtWlWfZDZ8enQBZl6xN2KF2O1NvHtahiqDtESJ/d0WI7ajrVRk/Zio4
         TP68X2lL+VaHMqvzhWka2GgnsdgsjFCN8oEZ7feQDT3eyMT3V6PbYvFKZVp3DOSEfM/U
         u0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666529; x=1762271329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwnCWAx8OAVXDxRLd+WdlJJdVlnMbvByJtUaS0y34MA=;
        b=BweF9TkjF+HoFvDr/Ch1JlCp8W0TAAC2Han+VmobZW7OOEZKYLuRis6fgGmJjO4k8H
         NsXNGei2p8lQS34W25efnfLXwT2dif2JC/G6DT/dvbqOf+7PH3VNRix7nzJTBynALLzP
         0c0B7pw+1vV5ahTZ3TTp2tkh7jd72IlkYJbSSclf02TfRFcL7QpcfwgBwGZ+imzudNK8
         L9DMbM2eeLG0LE4Pv9AXXGOkEop5WjsT6w1Y2Bici8Fn8WjV6cNhiQKii6qcgj38Emrc
         u8fKsNW7SaqZSdoZWr2+lzT2FmWluCVJT8dwqLkz7SZxMYvxq32uyEIXbIqO31LWG6kB
         759w==
X-Forwarded-Encrypted: i=1; AJvYcCXEtx7tjF7PXU660xoTLV7lbsqM6AEiqGf1OSPVIu88VLhafmV5EtTEgVmeOyfCKKc6CJ5lfKMZ2wEe8YXkBTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQRAD+9a+XO5iwSzPfYfOL1UJdu2D6CbtTX2CXCQ/UWsi5b9p
	628g0Zbo5jaEB5K/MCvWHomRQ1fHSqwcdOe9W9CI8rjRJUrPWsjyiScMWbUPNvsAsvN5e3ZmnDy
	cHjx/03lH40HLxC83RKA1WQQf6ll4JHn5xgZj6It/hQ==
X-Gm-Gg: ASbGncvdK2fDNR3OtlQ4exy/wXfie+BSq26Gyp0VuYuPJogZ6qO/L+GLIdf/Uq2UP1E
	y0cRcNv95EK/ah/lnLlBxEgsJIzgvljk1iADnGZpC+nc/NLgQI4gRir7hrhnByFL9eYCJowb1FM
	ydeCH9rDUkSWuasDV1u89lXw6htzZPf34osuGuQfqWuvBVo9L+Iok6ZKjZqRMM8R1GKvsDRKTJj
	p+MM3ojC07XOhWcSm02u11mdflcesopDh0I/0bZwBG+IQ7x/r9xLYdaHk4ecDmia8hQlXqPwMLT
	TRROOkOXf9epmAuKinaXk4tHZVI=
X-Google-Smtp-Source: AGHT+IHHQJDBFfYRgVJqX8xhSBA+9GpHTt9NgT260wr0JACLtpxb1RyGaZnV1bwmlzp3ct/hmGOguYUodPiD3cQebnM=
X-Received: by 2002:a05:6512:1095:b0:592:fc21:bc17 with SMTP id
 2adb3069b0e04-5930e99bc4emr1498445e87.3.1761666528580; Tue, 28 Oct 2025
 08:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
 <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
 <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com> <bd5bb1f2-a8ba-4828-9d04-2e1d433ecadb@linaro.org>
In-Reply-To: <bd5bb1f2-a8ba-4828-9d04-2e1d433ecadb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 16:48:36 +0100
X-Gm-Features: AWmQ_blgYmNnJtX1_PVoBYu1p1yrIy4vMPH61Mm6WV-4oL23HbeoCUDP69m6qE0
Message-ID: <CAMRc=MdL4yqY2em5myZO106FEzRF1RQuYroc74Qt_iHm-KBn-A@mail.gmail.com>
Subject: Re: [PATCH 01/12] Bluetooth: MAINTAINERS: Orphan Qualcomm hci_qca
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:47=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/10/2025 16:43, Bartosz Golaszewski wrote:
> > On Tue, Oct 28, 2025 at 4:33=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> There are no maintainers of Qualcomm hci_qca Bluetooth driver, so make
> >> it explicit that driver was orphaned and no one cares to keep it
> >> maintained.  That's also indication for future removal from the Linux
> >> kernel.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  MAINTAINERS | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 8abdc0e50699..be637b9dc7c0 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -21146,7 +21146,7 @@ F:      drivers/net/wwan/qcom_bam_dmux.c
> >>
> >>  QUALCOMM BLUETOOTH DRIVER
> >>  L:     linux-arm-msm@vger.kernel.org
> >> -S:     Maintained
> >> +S:     Orphan
> >>  F:     drivers/bluetooth/btqca.[ch]
> >>  F:     drivers/bluetooth/btqcomsmd.c
> >>  F:     drivers/bluetooth/hci_qca.c
> >>
> >> --
> >> 2.48.1
> >>
> >>
> >
> > Actually, I added that entry so that the arm-msm list can get Cc'ed on
>
> Ahaha, nice :)
>
> > patches. The fact it didn't use to, caused some regressions. I have
>
> It also points out that drivers do not have a maintainer.
>
> > done some work on it, so I can take it over as maintainer.
> Sure, I'll send separate patch for that replacing this one. Shall I add
> you to the bindings as well? All or only some?
>

I'm more familiar with the C part but sure, why not.

Bart

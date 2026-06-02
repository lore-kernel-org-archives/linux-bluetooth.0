Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8E2C029D
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387157; cv=none; b=Trje3wMyAgrUZSL51i3NGnC9rkeGQnoKgSLMKf2ERIudjKedv/s52xr5MbClrD3lbXwLe78bIh8KqdoQB1jHL0KnUzcWYIsqw2UluqPZ9KDBY4fmqLoatyOj8Gf7+GDud3AIkqXmpTE9eIzeV0nHh5d5/Q7gC0/fP9HAw43JlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387157; c=relaxed/simple;
	bh=G/HpCIqlG2HxGomUFcoIVzuyzpu9MWocyL926EjXgmk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtxObH7lqvvLaZQU34pyp6U9M7oQqV2xZbHVErKt2Cfooo5kNkG+/KHtfGDiXXpx1dmNYZk/YydfRJDJFIw+nukrlC+Df+pVPcp7mZLeZlZNpwnmik1WZ9u4y45RzlCMsFdr+UJr/lCeUhcTpXJGaVz4lkUTh/lPaRhxhan7RwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU56cKix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU56cKix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16E81F00A07
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780387155;
	bh=G/HpCIqlG2HxGomUFcoIVzuyzpu9MWocyL926EjXgmk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=VU56cKixBIDeC2J/S3kuGNTkdWzTND796sQiRbvRjPsWIIxdR5AQTls/gapJ2Kpz4
	 CP7v+v/I6a+Hb66HaYbyE4LUTpx3UPrkYmtHQy/d4PAVJyNxz4nPgaPzgBiYcthFNI
	 D3hPSHH+PDZXPAofn1wbxBiY1Cn0Hq25kS8/spmGAMHUaxlXt9EZNLrS2LwTdzogUp
	 TtOT1oTZXVGf6vLEJC7NzyJYEapDmkadUxV1BscXVTw6VZJJht4ikMmgLXDm1sLN9d
	 HIpFP9J+wzk58cp+Z7ZDpVcbtBflzOZZBVQaiXNTs7//x5FCI9dSkIyMRegbC41DdW
	 zdd8ZwBNJtLJA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-395f24a5f2cso91825341fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 00:59:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8C5J73aAhpjsCEZWl0rrpeSzp2BzBXnj7j3UknoHDg6s0DJlYOSQioSWagjUZAcWAbZzgu1ShDJtE2CJ1KPb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlgW9Pj4So9WHpNHGcF8vwMWJqC3V6Ex5+9BCW9dHMnqYBBHG
	UrTdCPW7lReoImvh8GZRETF7lTZ5vTIbWWRd/5prAjg1JeLOurBYnwNnOcc7r20ipMix4A5Iu1K
	bUwuMj5FpdQ/rVFTN8qTlNZDzy8SvgxLP0/IaOKEN/g==
X-Received: by 2002:a2e:bea6:0:b0:396:9897:4cc5 with SMTP id
 38308e7fff4ca-3969a852edamr10861651fa.5.1780387154481; Tue, 02 Jun 2026
 00:59:14 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:59:12 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 07:59:12 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com> <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 07:59:12 +0000
X-Gmail-Original-Message-ID: <CAMRc=Me1OFX9YO9bqBKFffaCS8FH7-_bSS4BsVgW+qoYQmDjVg@mail.gmail.com>
X-Gm-Features: AVHnY4Jj6PQ-4DZSgjCutJzrmJiIfEI2Eoc9MefyrTPUsszRaLc0Op3HHJ1m_C8
Message-ID: <CAMRc=Me1OFX9YO9bqBKFffaCS8FH7-_bSS4BsVgW+qoYQmDjVg@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, devicetree@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 11:46:54 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> The recent suggestion is to have PERST# / WAKE pins and PHYs in the PCIe
> port rather than RC device. The kernel recently started warning about
> the older style of DT. Modernize DT for SM8350 platform by moving the
> entries under the root port device node.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

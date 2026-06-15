Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FB9388E72
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513230; cv=none; b=B5ZsjK4MFtL/8e+3YFRiT0DeCWw2udLXoyLcSVn6+hhFLZngIYpZdElogSrMjiBaUqGWcNxSgPGaQ7wfQaDLbu6lcqGKyb64wTOdtJhHQfjdbBu3Nmc+5oUZ1uJn4fIztONP9erDqN/AdEql/xQSjPg0S3KUeHMF5qBIuU9ujro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513230; c=relaxed/simple;
	bh=36Eqe3P0lexDFT9WtRGkeP33r12T3Ldt/0fjyKtZHsA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK4DiEIzznxwV4E7sdw3nE7mhm3p1eTxgrWvHKp8VKy+3w+sSvG33hW3VmXpbnXGS/NR1wDlz25++wN5aGecF+4D6kAcMR7K6NPWyJ94ZvYCsyA9/nJHOcscfrO3T4G653CYOA8/ulP5eUrtQBz7HkLDeYciQbUycmSXPk4aX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihkxr7IK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihkxr7IK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635B71F00ADE
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781513229;
	bh=36Eqe3P0lexDFT9WtRGkeP33r12T3Ldt/0fjyKtZHsA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Ihkxr7IK9UQqH9939NKfzpzZPtyXug9rksT7re6jcnEAjJ5KkJaT25gIZcDrDlryE
	 VXPdtnFAe9S1DUdHvYq42Vs2JIoPKGKlRi+y/GR4Bm4PWDQn8A7CQ6luRtmOnNFwNo
	 1wLlldKK/P9owFbjFGkwVFJKLDwjsmgJr/G+DouPALuVcN1YnCevUi4RuPex0AzcuL
	 eGzP8y/i2iID2lXwOm//y9IgLPAeL4JaWdKspPxYssTs83N+150FgJh/6ciYUtDlYK
	 8FPZmF7XqZ8AZteDJvJc11uWYhutkVlAAVTCkkBv4KNNhkWA9XJemsf0Er7lYpk77f
	 lhtzbwUDYaYSQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3967724bed1so34327591fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 01:47:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3bdIdjk9upfso5Ec3tKTSrk09PLf8haXdf/s4iEzxHxxQQf+9hG5pI5O6aHet9MUIYj7y4rLIEQ185HuiX/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkGQlHiEOSEncRpllcuT6yaAhja/FxwSPIv2QkYWUvIJALw1t
	uC6+++00PhG8MSTJvnJ2itSM6w7CZX78WX3LyHn2ex3qyPAGVeWOz2Znl/3Ibq9MPQsenagGnKK
	NINc90TF5Wo4QiRY7s/5s8hCuE4t8e5KdW/bEduxVLw==
X-Received: by 2002:a05:651c:1594:b0:396:5f6f:6e40 with SMTP id
 38308e7fff4ca-39935760c65mr24339471fa.22.1781513227972; Mon, 15 Jun 2026
 01:47:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 01:47:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 01:47:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com> <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 01:47:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeNhR=30Q=gvPt0XwXbjJHgwjdC8gJ4nstwu2iKBD0x5w@mail.gmail.com>
X-Gm-Features: AVVi8Cd1V_fZoItE_I9KGUw7uwZ51MCBbXABRmFn8vXyiXcSneoYaZc7Se-syqA
Message-ID: <CAMRc=MeNhR=30Q=gvPt0XwXbjJHgwjdC8gJ4nstwu2iKBD0x5w@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 15:20:53 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Child nodes of a fixed-partitions node are not necessarily partition
> entries, for example an nvmem-layout node has no reg property. The
> current code passes a NULL reg pointer and uninitialized len to the
> length check, which can result in a kernel panic or silent failure to
> register any partitions.
>
> Fix validate_of_partition() to return a skip indicator when no reg
> property is present. Guard add_of_partition() with a reg property
> check for the same reason.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

I think this warrants a Cc: stable and backporting as well as a Fixes tag.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

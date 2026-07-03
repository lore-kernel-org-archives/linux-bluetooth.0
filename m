Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53B30C158
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067582; cv=none; b=ahhWMWjBlVV9cJxRHqvcvTES0ypdQGYrqqkXWigA7YqpDKPGdlE4h2r0ZJMlVtuXihXlUkvbi4RsBWrxoeJUxDgm6x9hHrBWUwzlbN8s+7hQ8uKNdr2zkzAFGPBWPqJm7oLT4cWAaIwmJUKJ2aXT9SMy/r+PcILORIY66t6nD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067582; c=relaxed/simple;
	bh=BX2+Mfh4UHlpcFxgAxx5LFl1BquzeclLU3ZjHmLK7cQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs9LPZpfyuEZyWxFPzKEkCZoUFivj5E958xC2TzQ4h0MmN/AgJYV5Smy7Zwo98SGe5GZrN26pyqgenKZm9RljE2zW8bKh3xhWK5T908zL8DrYm3rlY3AJ9tGH9SQW6CrdPSpuymYXRTbgiNst70Mb+pVfo7cVX983+beiCj5Kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyVnfZL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyVnfZL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1174B1F000E9
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783067580;
	bh=BX2+Mfh4UHlpcFxgAxx5LFl1BquzeclLU3ZjHmLK7cQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=RyVnfZL6/I/JwEeZTBBf+amQs92HXTWCwruQyfoiRixCTuQP8O0uHNvtsMG24gShb
	 D6QNd/pzXl1XkL0NUp/hEh8v8sNGNPpAr/lFR6PUQ0pxZPN6lTtBS7KGjF6zFGDAKX
	 P+X7sn99th37A96aHfwG6CmhMX5TU5cbkUXW4kQ2Re/6g85RL9E/+md/3y06OPNHQc
	 29J2h9mzGl8PIbDM/+28vY70iwTrwOnh7MWLHX8Rp6mnrKokyXxXF41T171ULtoJ/d
	 gT84+fNlbP7iNFVuP/GB8aBnH7Crqz5bM8kh48WKhllKQopsPfV2r4yszMzkRGBOox
	 pu2T9H46m5GZg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39b315585a4so2049621fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 01:32:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoGhDELbAtKUbqvEZYjlx0BE4Dm8mMFf5prdYe7BSANjtVQyQ1iRBVPBO/dk8RBGrU8HjgGsMoUiTrnjqem/mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpMmBYAd81nMhvk6yDVOSI2JEHCTVMQ+LO5FhlXniucNQT+wy
	geTFWlDUN5gxyVCl2EIpgM9y62+gXfpGErtSLR0jTDH6LCOKgwlveaGtANc+DA1oRYoJLQT0eqp
	LK9LoJB2gxJ/N83xksNUyazyTUhaLS57TWhdHpIu3Mg==
X-Received: by 2002:a2e:8094:0:b0:399:87c9:45a9 with SMTP id
 38308e7fff4ca-39b34071778mr13977201fa.19.1783067578841; Fri, 03 Jul 2026
 01:32:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:32:56 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:32:56 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703-ipq5018-bluetooth-v3-1-62da72818ab3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com> <20260703-ipq5018-bluetooth-v3-1-62da72818ab3@outlook.com>
Date: Fri, 3 Jul 2026 03:32:56 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mc+nMjEwAiE7gHgFTD9NjwmqS7+1Wk-UKpCbQPyn-AcvQ@mail.gmail.com>
X-Gm-Features: AVVi8CfnRuKaV-kcx1kKH9jzZhKIbi1CmXts7IlDKU_0RcVJyvJ8qac7psYrHhk
Message-ID: <CAMRc=Mc+nMjEwAiE7gHgFTD9NjwmqS7+1Wk-UKpCbQPyn-AcvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: george.moussalem@outlook.com
Cc: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 07:01:49 +0200, George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> said:
> From: George Moussalem <george.moussalem@outlook.com>
>
> Document the Qualcomm IPQ5018 Bluetooth controller.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

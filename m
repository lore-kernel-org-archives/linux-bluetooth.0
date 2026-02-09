Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834F37105C
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636927; cv=none; b=TfsM06cbbIqP0JwhW0LgoXjw5/YFIWOzB0eO3RObDR+sQYIz4uTjXymCW1rryfywlLO3nAp9gf0DnpH5eh6AtvJNxsEw57KxlWE/N291wCWzQmWd2J4jZFzFM0nSHGEtM2oPdztmB9ghSBMb/fBdlBBjG079JmKJDrS7/uUtp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636927; c=relaxed/simple;
	bh=52ZnTTwCU6ma5VGHBGZTKykJyZwNc2akaww0BZAxEwM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lITSMpiNOJ9NGsanugxejS6oXv0Gafq+XPPPcu+vcD3ofnFv5+m4w2XPvPtOWAT6SnO8iqJ2m+LyG8pcxqVZoUC8IwJY0LC0wYSM+aYxmCvsOttJPXD7I7iFoAWwD+S6L/P5xlUnMbh4gDwI/W/D/gsz/SGXP2edqt67OGqay+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iyc4b7cj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iyc4b7cj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCF5C2BC9E
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770636927;
	bh=52ZnTTwCU6ma5VGHBGZTKykJyZwNc2akaww0BZAxEwM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Iyc4b7cjpQ0xc4d7KPFC1NzS/nadMYwOxPiqGwgFY5ZjEV/N7+qU4l0bx+ymaAlJ+
	 isupo1FIVNnO9bmHKI/D+XPoWoZA4jN56DzvvfmLIhsH1ft/8/IkW1y18S3JFYKAos
	 lcefWhjtG11Jknz3WkR+EvKsEFdmoQKfeIiRFRMAoBqW0xFzV3/xa2jh0uhRhnWGog
	 wz5ghjTJ2ntRxraSWO0t2fVZMyfu7m9DvAicwZCax7QEuQ8I4N6DrABm8HzUB8U5hZ
	 4VajzJ1oq44L229V34kF1dlkAVropxNynu+VUJdbwORvn8CWKw+CAJQFLJUrXakOiz
	 YE5+9U1ddP+Zw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-382fd45a1feso43095121fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 03:35:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSyRiq8f1z9T/soPLGJ/zhmX5V6MT6bMBuiPlzHXVxXU1w2gHeOnTnbpiiFCG19qoKRXddXPneugSDXiabTdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxMvo3zToI2pJF4o/V4O/qe6ppIw0OjNF9OXrJsFjdWobkJyQp
	Byegx4j7nLVQzFBWXIjKjNCvo+DDeDFqeEvJMZzYoGc/AN9JSIPvAZz/vsEZjMs1of1u/SCT4f2
	3nJcl+JM2zs59aiNrPLPyZZs6s+pdI6UDiQBpF+m6/A==
X-Received: by 2002:a05:651c:548:b0:385:f202:a787 with SMTP id
 38308e7fff4ca-386b5547738mr43444311fa.9.1770636925624; Mon, 09 Feb 2026
 03:35:25 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:35:23 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:35:23 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <7cb9a945-651c-426d-8cc7-1ec1174ac68b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
 <20260209080613.217578-2-vivek.sahu@oss.qualcomm.com> <7cb9a945-651c-426d-8cc7-1ec1174ac68b@kernel.org>
Date: Mon, 9 Feb 2026 05:35:23 -0600
X-Gmail-Original-Message-ID: <CAMRc=Md=f_fpfZ6i2PKOvhtgVs_H_XL9u_uRsjF1OfryR-0aVQ@mail.gmail.com>
X-Gm-Features: AZwV_Qg5yf4vIpdAfGn9f7D0Ri5TRZ26eMgjRzKm34rnqwn3a6graqhIH0vI0Nk
Message-ID: <CAMRc=Md=f_fpfZ6i2PKOvhtgVs_H_XL9u_uRsjF1OfryR-0aVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: qualcomm: add
 bindings for QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Vivek Sahu <vivek.sahu@oss.qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 09:07:58 +0100, Krzysztof Kozlowski <krzk@kernel.org> said:
> On 09/02/2026 09:06, Vivek Sahu wrote:
>> QCC2072 is a WiFi/BT connectivity chip.
>> It requires different firmware, so document it as a new compat string.
>>
>> Correct the sorting of other chipsets for better readability.
>>
>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 ++-
>
> There is no such file.
>

Ah, -ETOOFAST, I'm retracting by R-b. Thanks Krzysztof for catching it.

Bartosz

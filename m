Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E38309F13
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636743; cv=none; b=GGMf5S7WT80RYXpGZWo2eCCF9LV9xptlDcBJiTtzbTnHN1eVOugatb8dsaX16IyjR8c9g9MxirjhSay605wYh8IpMNitqr7DepHOQWws+nKA5UYwbzD6xtA7RfIzUnhNUvMxjPAw5tQkNJGQJSyEBFwgWDzYGD1obsJHlLM9SVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636743; c=relaxed/simple;
	bh=j8Pi2ksY+iGpnuw6D18Fu7LEu4cw370HLF6C6Z4/mpk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM4moD8uHPuwBq7Jw7z1zrbhUOZ2Vz7OC/LkxYOUIYX0jFZEc3aAbm2+5lr3mTrjq4Fow7XDuvc/rAkhIFymJEUiopEjkQ2FFQeM65pkPJD3AD3r1dknLgYhmaXKSbh2tb4yea786PFYfE7oEIaWvMYP0jnFVI92889S7JuQf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmrC2ViW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmrC2ViW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64985C19424
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770636743;
	bh=j8Pi2ksY+iGpnuw6D18Fu7LEu4cw370HLF6C6Z4/mpk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=QmrC2ViWCzLj6XHOijrjze66ujr0k29MAjyfM/BUs777zRdgE964hw7YRjOZrMFGP
	 c4bv/nwOBTRsMsi1tvHtal9R736H2vlz0FvxpGZjIoNwHtkQNz7FLnh6n+O7S24Af8
	 5GRcl2SS/AgMAOaOop+ZAUYXBFCu4qWoI+bjWxNiHjWu1yo3yzbBWKAFL4FjGUJ91A
	 9mG1eIq7+bcVxV+CSLDMgDz4HS58mEv5ehYZ1RyeRB/WTUYEEZoDCudR6d7T1Jk4M0
	 yBrLZ2DmEbdummH/ndv0lUnJb6KbYuRQ+4zoB48KMQL5KjOGlmy+IQ1ZteJ0tz/Ebj
	 2EqTJPn+8xESQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b6c89d302so4255018e87.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 03:32:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWPNAa3f536ByhMYxCW02z8HEiIQt2TUVLffq2RE+KhPeBtbx3R+FLNK8JwKSdeWDem0ZH5OsqmUCachaPDOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIoNHdNk3OY7WK+lb5miTQlFf22Zdj8CzK0bnC6RsbqmFjNnzB
	QZRwM9Fy9LarbToqbX8NXLJd0Y3d5NLsW/k5i1IGctJjo3ma/EFBO9R/TpBQBpI7+hpusXqx7Y9
	1NNKh1gayDfp54QmXd7pdvJFkdekAKwkHlQMLHUvrQQ==
X-Received: by 2002:a05:6512:1152:b0:59d:e018:5648 with SMTP id
 2adb3069b0e04-59e45150e88mr3570829e87.32.1770636742093; Mon, 09 Feb 2026
 03:32:22 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:32:21 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 05:32:21 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260209080613.217578-2-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com> <20260209080613.217578-2-vivek.sahu@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 05:32:21 -0600
X-Gmail-Original-Message-ID: <CAMRc=McvJa=hVPsPgNNz0Uv9vxPSBUymGJVQ2keGCLu3_qpypQ@mail.gmail.com>
X-Gm-Features: AZwV_QjCjmmgbB97aqFgLGCCA1CHsOAUbS2i5hadaP4Fm9EPkI13UuC0if7xfkk
Message-ID: <CAMRc=McvJa=hVPsPgNNz0Uv9vxPSBUymGJVQ2keGCLu3_qpypQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: qualcomm: add
 bindings for QCC2072
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 09:06:12 +0100, Vivek Sahu
<vivek.sahu@oss.qualcomm.com> said:
> QCC2072 is a WiFi/BT connectivity chip.
> It requires different firmware, so document it as a new compat string.
>
> Correct the sorting of other chipsets for better readability.
>
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index 6353a336f382..85cf65efca92 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -18,13 +18,14 @@ properties:
>      enum:
>        - qcom,qca2066-bt
>        - qcom,qca6174-bt
> +      - qcom,qca6390-bt
>        - qcom,qca9377-bt
> +      - qcom,qcc2072-bt
>        - qcom,wcn3950-bt
>        - qcom,wcn3988-bt
>        - qcom,wcn3990-bt
>        - qcom,wcn3991-bt
>        - qcom,wcn3998-bt
> -      - qcom,qca6390-bt
>        - qcom,wcn6750-bt
>        - qcom,wcn6855-bt
>        - qcom,wcn7850-bt
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

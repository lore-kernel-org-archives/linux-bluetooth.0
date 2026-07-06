Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEB3BED4F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362993; cv=pass; b=m/j+aJ0/KVx88YI9Pi+KJgTk09kjDKQ+hmu4oA80rJ0RCDhqpFfZ1TwRmYO0VNn8t/Ix4UaBEQqtWMgoi6l7wLIQQb+1PVF8AmCls0027YKmF5gemS6FRkL5pWOuVCQSqOZyAr76GOPn+oTVY/shrmOJO1NGPzON3xBCt0V/U4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362993; c=relaxed/simple;
	bh=PQ/1xy6a3puINBaYqT2e7b7BbcSZZGAO5m3b6c5J4R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgCEFR0WMwTUO2UhcTBnMPbjUnjYvPpGryz8Ek5moYoH6XQpb2dde0Rm0UotycpffYuD9HhBwUXqg7EWNNwEfMo/zFeeZ8YmzO+jGpWEP2v9MnFlYyrSo/P4J9IrQSonNWvFMbZRCSioDkdeXrqspIZe+wNfiwGWxmVvvqQZc8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8U2QCUH; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8U2QCUH"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664ae993e4bso232073d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2026 11:36:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783362991; cv=none;
        d=google.com; s=arc-20260327;
        b=r6aHOXoWlYmvTxazExDXUD+RH0Xk7bhnXbnbHZULYb8aEPHNoMwukk8+EouqWTWLza
         5BgTv9AzFpjcLGKwB0cK+z2nL6kGfhKtxB6phC8lIR0rAt91g6u/yHwRb4SOblcgzReR
         dlEcK7OsiZ+Hy5KnCweC/E0xTzyoAHAnItbOaoGAGxBNNthmdkPeSznj/WPVUW9CrloF
         nYjC1cLT5uv+a8ZeEIiKfESxzP9kpLJ7D23mNxFEd4f/8rxpKG/lEqJLe34yFt4JWkou
         W6a1cIFttHWrHbP+tc/+FRCLBNl5j6WY5bbFk/9ArJOEQCnmYTON6ibYLm0P1v0s3xmQ
         O7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fZqkJjaKpXhp4TDNIgLLDiBbOKbRzti84NpGMNpZWKU=;
        fh=/tdZATM6D1CeA7B1eghKX3g7S0qlN/bKleL73ijHStk=;
        b=p21IVfb13xxyurTZQHkFR48BFY7yhk2aCVD+lFEI1knMAQYLow0iYaf9j3qVyK5WXM
         bAoNQ6wNVi6K2giRlwsjtQE8qwZJizEP2eKHJdNZvktYmYZix8LfrE4yduFWu5Qg+/ox
         JZ8gV8yYXol3JjNOkwLbsv2lQho4hkR0DUXR674k28cpRrof9cxNxXxRWTdu5/vt3bQ2
         MRrwEW9T5S7oXydhSTfTTXGWt4tZyg7j74nRWkPvLCCnee3bTaMMq9gvDqumZ4fUvHnL
         3MTZTJEEvIMjXrZLcicADwnJZOlMhtQjl6o7JeT6jU1bAa0QuSgnxQKIimbt7n3KZP0R
         MBeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783362991; x=1783967791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZqkJjaKpXhp4TDNIgLLDiBbOKbRzti84NpGMNpZWKU=;
        b=W8U2QCUHxDpz1sPQZ7XOrkaH/Tu3fq65L5KpzU5sPh1YdO8OUZ+zQk3quIMY5Pi6Yu
         SlIg56KE9SbP9ufLGoV1XOlZXtLi1HPJmNUncReb2kRQ2x/4TjmysQW+WrUUoWqMU5Wq
         ydsNQBGF8y5p9XUQzqhyySyFn/3tOp271B2uX0R3Gi1dYXc9jOA+pUamLc1m8i+Fci9H
         Ff2sQkEQrSE2CcJ2Mm2wX6/4qD0TPk8Qxd3LCPYwV17WNRpVOc5m6GAHtRTmahYi723l
         NTjfTbiWE2Dc/QkRTIQsLI+IC52eEigtUdTOb3NxGTTkNigoCvdcTixJluUtoDfY1U8j
         X8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362991; x=1783967791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fZqkJjaKpXhp4TDNIgLLDiBbOKbRzti84NpGMNpZWKU=;
        b=fwDuS1CFhqhPIo+ynCPlU1q9UoPlCE1OtkhXpX7bVrhjgfQ+lRIs8SFhRqCqL91Bbe
         b0XIywlI/rGDNEzl8BY8IKiNvgmlSeG8jl2S9Ow1sQHrk5XPiSEYeCAaYsBIh6YH5gmv
         oDE6C4bn0nwQ5F9T/o84pB/e/K3ptc5wT++oThZePSGKNY35yM8Ep/iOZvLhK5HLsH2d
         7/Q7QH/WBYSXJKUunUt49zAjdL1rRrmb0j4l2af2okndIUS48NoNDMfIK6Mb98cHvuqK
         pH6NAc2aomvrmuNCZa5xocsUcC2ZkeWH8fOQyH5Os+3H7vIScxH/klTRTDAViL9SIgEe
         QHxA==
X-Forwarded-Encrypted: i=1; AHgh+RpSLuWBfqDfT3ILaGTXca49ltplpNNj91X/YFpexgWJpTrcjpnvEEaueXLzMEzGcCczz2TRJNtaxREjISRPzyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UDYyZ+niwldTfrGfQvosvOkFyMTHEaxZfxMj6GzAn2qgxQSq
	2G42+Qn4fyoIxGHI0t4d4EDLjHHZkB0cH50Q+oqCYrIwgmQt8LFdRGTTV8NGZr3YFizKLSqWyD8
	KDobA+BCOuZPbtO2p9VhYSgR1g93y21g=
X-Gm-Gg: AfdE7clZ+UrZ8GnThpxahXkMbW4FoA8+M8B4n8GycQFIBra1QdnmqqnHnV6tya83YZ0
	AAsuPgKyNq4rXoic7c4cb3vQYaWidjTau46NDppA5+MZP42EtMFgK1BGy0/qr62e/i0bNdMOI5k
	7MMX8FeCAifbHDgH3Q9NQbJR3P03VoXO35jDm7hfKKux5oeweCtb3nZbQ7nXHyzlE3AcG4QVpXe
	7A5FYEAvxkyZwCjRiI0obV0XiiHtL3JoxOYTtHSWKcbSZeVgrYBla6BOFwUn8kG2P1fVvkJpNSs
	nTH7YL+MAm38rv3Pp9WTQyAKI5inmQzRBFJ/wrBvik+XV7ZngSoViHB3
X-Received: by 2002:a05:690e:11c1:b0:664:c5f8:e342 with SMTP id
 956f58d0204a3-66780d9d9bcmr1088563d50.3.1783362991520; Mon, 06 Jul 2026
 11:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-ipq5018-bluetooth-v4-0-350262a30959@outlook.com> <20260706-ipq5018-bluetooth-v4-6-350262a30959@outlook.com>
In-Reply-To: <20260706-ipq5018-bluetooth-v4-6-350262a30959@outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jul 2026 14:36:19 -0400
X-Gm-Features: AVVi8CcGJO8Ch3pCjXKhOWgi95XsZ_kdRoHC9Z0sM3JRFuLLpn2tg0JlAJ13czI
Message-ID: <CABBYNZ+6BYa-CrC08piL++ysOomiWK2gbYAv3ecWwpE+RpsNOw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] MAINTAINERS: Add entry for Qualcomm IPQ5018
 Bluetooth driver
To: george.moussalem@outlook.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi George,

On Mon, Jul 6, 2026 at 1:27=E2=80=AFPM George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> wrote:
>
> From: George Moussalem <george.moussalem@outlook.com>
>
> Add maintainers entry for Qualcomm IPQ5018 Bluetooth driver.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b9d7c8276ac..60f7251d1a16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22289,6 +22289,13 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulat=
or.yaml
>  F:     drivers/regulator/vqmmc-ipq4019-regulator.c
>
> +QUALCOMM IPQ5018 BLUETOOTH DRIVER
> +M:     George Moussalem <george.moussalem@outlook.com>

Do you work for Qualcomm or have access to their specs?

> +L:     linux-bluetooth@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.y=
aml
> +F:     drivers/bluetooth/btqcomipc.c
> +
>  QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
>  M:     Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>  M:     Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz

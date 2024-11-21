Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8121364
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 04:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163927; cv=none; b=EO5FF2WQD3q4mFjNliaYbwgoTcKUWHJemBbpDkZxw/zDZwPm4UjhK10FmVTLggI+guvr/rvAWe+69kSYb4xF4sDhzhQSE/C2x2V+zzdJoIDRz03Tt+0pBhsr2PRQpqzj6Ysi5iEvIeMQExKuejsJI07GmfScRd/G9AZF3Pev6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163927; c=relaxed/simple;
	bh=6R/H2aCpWWe9mDwoGtCzoGDBGd4Em2C16yy77qhvZSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI051QpL5GV4lbJRE2U6EL9672mSLEYeozTyDluAE/t9oV2z5+Ob0XnsVJVEUuFHsxV26qTjBrSDi2ObauCUbPtKAC81B6HKnF6kLpfEjoL4eSiiaea1gUERzhtDe8btZAO9CfguqFkNnlEeoVE4p61oBSDFyU76Cx5rGnJsV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZSYuPck0; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSYuPck0"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e388d8850d3so477071276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 20:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732163924; x=1732768724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kHq3g3nEaimpSCWtvuF8a7MUOkKPxPFfmbJ4EXDd6nY=;
        b=ZSYuPck02Z3xZoMz3/g7zpJ+l0mYnjrS2MBDrJjr5faEibwR5xXBzqvGzAbGaICjBI
         jIAOA01Y3yNC4+0p1+uxZRfQ70OybJyCsmcXwgtn/psPJsvMiw8AJP9VZZwVE9xZr57g
         jgG8bx6hPe5HIgvvjyfBVn8/SIQHkgxRF3uvFjeyfkJgSSZuwDSSKyLnwbbAn9O7EkgM
         HvoJhgq2kuM3Z9o82sYa6s0b1wxB197fAlgBFP4dTDeIDi4pIkrJe+Bem4+8UHn9SXhO
         xKwJg5rKFQGgK0/3q9EkSiwTE0rUhCMQyngAVaTHPn7EDB6H4z4fkVCHgVVZhKetw1qr
         K52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163924; x=1732768724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHq3g3nEaimpSCWtvuF8a7MUOkKPxPFfmbJ4EXDd6nY=;
        b=dzbTr+w2xREpVjXQyvy1G/+DnprOr0DMoPdwXmGXLthF+o5OSFtVuvOJYKce+mK2rJ
         WbCqSwx/A/enpXD/EpmTLpwytWI8RdYfmNJbU7pVUCTJ7Mw7s+xg6gSWVZIANduNAS8s
         LvY7GJn34vwSIaWoVSJk7mGjDsdu9HYAhye5i6szHWxw6hEnZtQK1gv7oKRyoGCo9Nje
         g2P6mYrpEU0s8qBYwLflmlkZfC2jphgdZY0Ci/caWoOfMBXXy4S8gW1PsGcVIiNdtALV
         1nm7pmgvESOGNOJY9YzcMx5rsxi315iDOVYHzUDaUktTrV/vi6hczr8+tm84NHRkT8Zy
         FSuw==
X-Forwarded-Encrypted: i=1; AJvYcCWShVdo5y28tqOEqmhZW99l+t4gqJAu8NgMVSdayvpZv/lO/ZCKWnTWM11cSuKGgKEaMpbgIQ4UMxpEKVwBZqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5z5vUaVLy5DgGc7StCfWknqwTPGNDANZPsy8P6a/f7hUnbVm2
	yTzgDjTHhCbCj0vaOL9biLq5cO2cozHdvHRRWI8WBB7fr+cYLISm5HqzbY4qrjTHIYCcJCHGE9R
	T3UFlww64nRqjrGjl/E2ij0Sr9P1+LWhZOyrbVw==
X-Gm-Gg: ASbGncu1U2nrGhcpH9T6GdQGNXh+5fxqGDGIoEk+b1IiKjXqzpCWgsQl6c+f4y9d8E2
	tYbfXN+ti9t/C83+nX4V36Gc+uab77Q==
X-Google-Smtp-Source: AGHT+IGy/j+wiEKXbWpg+rdcMPTv/vGoVdsPjG4eyoPMFGLTqsk3vYC/qn1djx+YzFpaj4sluNr2T8hKE9K+QOCRfe8=
X-Received: by 2002:a05:6902:2781:b0:e30:c872:176d with SMTP id
 3f1490d57ef6-e38cb70ab2fmr5251355276.49.1732163924089; Wed, 20 Nov 2024
 20:38:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-2-quic_chejiang@quicinc.com> <454tdpuglu23nmxfqqesv42h5rk3vqiji7spo3naf2djqwojqt@6x3ram3lnlkq>
 <fb5bc38b-83b3-4924-b1d0-39219a2927b4@quicinc.com>
In-Reply-To: <fb5bc38b-83b3-4924-b1d0-39219a2927b4@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Nov 2024 06:38:33 +0200
Message-ID: <CAA8EJpqAOD_+SLG2LbiodWOs28_rquvMefmSH5CY1yB_rkiZPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add 'qcom,product-variant'
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	quic_zijuhu@quicinc.com, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 06:02, Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 11/20/2024 6:43 PM, Dmitry Baryshkov wrote:
> > On Wed, Nov 20, 2024 at 05:54:25PM +0800, Cheng Jiang wrote:
> >> Several Qualcomm projects will use the same Bluetooth chip, each
> >> focusing on different features. For instance, consumer projects
> >> prioritize the A2DP SRC feature, while IoT projects focus on the A2DP
> >> SINK feature, which may have more optimizations for coexistence when
> >> acting as a SINK. Due to the patch size, it is not feasible to include
> >> all features in a single firmware.
> >>
> >> Therefore, the 'product-variant' devicetree property is used to provide
> >> product information for the Bluetooth driver to load the appropriate
> >> firmware.
> >>
> >> If this property is not defined, the default firmware will be loaded,
> >> ensuring there are no backward compatibility issues with older
> >> devicetrees.
> >>
> >> The product-variant defines like this:
> >>   0 - 15 (16 bits) are product line specific definitions
> >>   16 - 23 (8 bits) are for the product line.
> >>   24 - 31 (8 bits) are reserved for future use, 0 currently
> >
> > Please use text strings instead of encoding this information into random
> > integers and then using just 3 bits out of 32.
> Ack. Originally intended to make it more flexible for future use. It can be
> text strings for current requirement.

No, fixed-format data isn't flexible. Fine-grained properties are.
Please define exactly what is necessary rather than leaving empty
holes "for future expansion".=

> >
> >>
> >> |---------------------------------------------------------------------|
> >> |                       32 Bits                                       |
> >> |---------------------------------------------------------------------|
> >> |  31 - 24 (bits)   |    23 - 16 (bits)   | 15 - 0 (16 bits)          |
> >> |---------------------------------------------------------------------|
> >> |   Reserved        |    0: default       | 0: default                |
> >> |                   |    1: CE            |                           |
> >> |                   |    2: IoT           |                           |
> >> |                   |    3: Auto          |                           |
> >> |                   |    4: Reserved      |                           |
> >> |---------------------------------------------------------------------|
> >>
> >> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >> ---
> >>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml          | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> index 7bb68311c609..9019fe7bcdc6 100644
> >> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> @@ -110,6 +110,12 @@ properties:
> >>      description:
> >>        boot firmware is incorrectly passing the address in big-endian order
> >>
> >> +  qcom,product-variant:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description:
> >> +      specify the product information for driver to load the appropriate firmware
> >
> > DT describes hardware. Is this a hardware property?
>
> It has been added to identify the firmware image for the platform. The driver
> parses it, and then the rampatch is selected from a specify directory. Currently,
> there is a 'firmware-name' parameter, but it is only used to specify the NVM
> (config) file. We also need to specify the rampatch (TLV file).
>
>
> Can we re-use the "firmware-name"? add two segments like the following?
> firmware-name = "rampatch_xx.tlv",  "nvm_xx.bin";

I think this is the better solution

>
> Or add a new property to specify the rampatch file?
> rampatch-name = "rampatch_xx.tlv";
>
> >
> >> +
> >> +
> >>  required:
> >>    - compatible
> >>
> >> --
> >> 2.25.1
> >>
> >
>


-- 
With best wishes
Dmitry

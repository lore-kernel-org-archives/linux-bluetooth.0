Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D398220E704
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Feb 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593087; cv=none; b=jN4LFKI/wBLLpXMkDJSYgpUli42cb95yhBFRTXpn4ZKq52LtxuyO1LFPBojS1VFsVzlVA7Jj0mW+8xwD+HYeFRxcY8YTBoREPc6Umi2l5UlMYruC8BsDPRNn/CfUEcGI2XH4oUuD0sCDGqT2dFozzjUmWTrRGW74Uy9tFAeThzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593087; c=relaxed/simple;
	bh=DQrineTon4oBDwNOMF4wAf5CmVWaPXA6hctLTPhSRGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNLBlhwh8g/KsnCIn4p/Nn42Y3rjCtRKrz0+YmT9Bad3sooCuohQSw5lLpHzYqgsU53svPgO+CAbQ4XiCeSFY17jR2P4VHfQbK25CYVxlFrzNVOgeNNACEo4jLzC7ml90NpONfFRYqEtH4wrznlDmrppQ31UZ8J70c8fKuLRZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zb+GY5TI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zb+GY5TI"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30613802a59so49954011fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2025 06:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738593083; x=1739197883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVDFcnyLh4wiaaDr8pcIi9tA5w30/ZdPI8YjayS2Hzg=;
        b=zb+GY5TIhM2nbK06gYj/ZNfnr2LTdO2txfz9X/A5chWrBFx2IU1ezNk9jPmQmSTxtv
         R8r9XlKzhmL0FqqVP8KgiDOZ4RLYBz6RTKPYeiaWb4MQ65p43NrBNtWzDB9vZ3um+ISA
         v179MO1PyEWcugimeTGIjyZQUFThabrzPgOpClQRrliD7Nd8xCZ3Yrvvkr9VBdnHjW72
         nNJJpFzuBSqn+TNQ7YfsG6BRHAjiEz6rhXeSWzNWIoL/woNu3puY+Ra10miLTNAwnj8/
         CD+i/kr9EHmNkfWqMre4Ja4JCl5z6jA7CetlwjY1GZr3w1qtdY44jFRrfS605EjY8TaS
         FQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593083; x=1739197883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVDFcnyLh4wiaaDr8pcIi9tA5w30/ZdPI8YjayS2Hzg=;
        b=T3wzOgBrEi6hCDxW64OV1A9gFEWz9/d6HOrDx3NueOSRYvumNjQscdhQ5hWvy0eJ5s
         lxDlMMgUBLwqfV1ThUBaCzV6cyVtXVA5t6n5yIzMtiQOVpZlbzfHU5mNkNMI97vuQSEq
         sfuHcHTX1G78zIfxQAf8Grixx0987b+XnvaTMBnWAhBbimGVvuQfPW0StdYZd9NSfQPK
         kWOqQzmU74FjIkllPuwLOPybcbJ1BsUt8dvvLo9tn6gfDjie7FrSBv2ZINWiZEWrRoni
         KCRh3iBDGY+fVN5EMnwd79i4I9qGB5QEmSHbNluZduJpk7T7uAeXTcHkoKBlqgQB8t+L
         hyqw==
X-Forwarded-Encrypted: i=1; AJvYcCUadxER0Mb+cQE5G9cYhmoHdV8wIZDBnlR2ltA2ZqzYaDdSfFHQNgC4WKxPeZF/EEZQ+nCoEh8HiL+uV0QawaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMG4yr8yb9yiMjkcc3QQmXbihIQy1hGl3CNrZoF4jp7YGY7t9
	PkfHMtzy7LWq0ApulPx3wFbap2NvAGvYlumlrJX8xE3sz6HmzXfuZhAeTcWJsCs=
X-Gm-Gg: ASbGncsi/AN3wULdKAtHBwLmGsEcNnUMzRATCIZhHdw/rOk1wwMkdy0nozi09wCSvCw
	vCWqKFiyg1UPZ52LqMZeRGGB0kq9F1SnfLzD2yKBy70Po6LYYgMsFI5ZogSbB8pWcpqkJ4O7Bkg
	Jh2peTdd9QF/radA44CKfsXbvRUf8IlMsUzFCCjd/0KhNEIktIdJh/B9pXEANDmdYHtu7u2UQlm
	/Kk0wPLvJSQlVGJSsu0bfh0rIFoJ7rOurj/efn33aHq7NSS7NrybRe1adZzpCM9hlZ4m3U2jW86
	d+1fwGduDdTMirw/8qZ+8gLyiswUFHPtgGsKsEMUSUUkH3CG49csVvviaXvvp+6avxyhevQ=
X-Google-Smtp-Source: AGHT+IHUghVJimpcvkNuryRp2QSiMsGJ5k9kaBv83gYo738k+5t/tc8gK88ES/UIqhPDyfIJKtVIKA==
X-Received: by 2002:a05:651c:508:b0:300:33b1:f0cc with SMTP id 38308e7fff4ca-307968fcfb9mr89069701fa.34.1738593082745;
        Mon, 03 Feb 2025 06:31:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a33f7cd2sm14901271fa.65.2025.02.03.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:31:21 -0800 (PST)
Date: Mon, 3 Feb 2025 16:31:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: qrb2210-rb1: add Bluetooth
 support
Message-ID: <ajojztm3jr6iciwqhlbc7xnndlhrq6z7z6bvbbnb7sjlybqjqq@e6sdxcjolmd3>
References: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org>
 <20250202-rb1-bt-v3-6-6797a4467ced@linaro.org>
 <a6fe746c-c5e2-4c39-afa8-46b225256cb9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6fe746c-c5e2-4c39-afa8-46b225256cb9@oss.qualcomm.com>

On Mon, Feb 03, 2025 at 02:50:52PM +0100, Konrad Dybcio wrote:
> On 2.02.2025 1:16 PM, Dmitry Baryshkov wrote:
> > Add support for the onboard WCN3950 BT/WiFi chip. Corresponding firmware
> > has been merged to linux-firmware and should be available in the next
> > release.
> > 
> > Bluetooth: hci0: setting up wcn399x
> > Bluetooth: hci0: QCA Product ID   :0x0000000f
> > Bluetooth: hci0: QCA SOC Version  :0x40070120
> > Bluetooth: hci0: QCA ROM Version  :0x00000102
> > Bluetooth: hci0: QCA Patch Version:0x00000001
> > Bluetooth: hci0: QCA controller version 0x01200102
> > Bluetooth: hci0: QCA Downloading qca/cmbtfw12.tlv
> > Bluetooth: hci0: QCA Downloading qca/cmnv12.bin
> > Bluetooth: hci0: QCA setup on UART is completed
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> 
> [...]
> 
> > +&uart3 {
> > +	/delete-property/ interrupts;
> > +	interrupts-extended = <&intc GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> > +			      <&tlmm 11 IRQ_TYPE_LEVEL_HIGH>;
> > +	pinctrl-0 = <&uart3_default>;
> > +	pinctrl-1 = <&uart3_sleep>;
> > +	pinctrl-names = "default", "sleep";
> > +	status = "okay";
> 
> As you're going to resend, please add a newline before status

I thought I added it, but it seems it got lost during the plane landing.
Do you want me to resend it?

-- 
With best wishes
Dmitry

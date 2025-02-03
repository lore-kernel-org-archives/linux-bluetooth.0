Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932682063E2
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Feb 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591239; cv=none; b=jwCe0DLOdyxxjaKKgIze1VNhKp/pQtjjGQgPNAiIftN7ODcsreAC17kuR+bRK/WvJFP5uNF10OhXJ2h5o5yf+r78YPY1glNjYSCKdakFCN59VCorihVZJwFtvun8S2GjJzPuPUkd5UH7R8EO157BVjmgENHwncyaa+93dvIoNIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591239; c=relaxed/simple;
	bh=YEBc9w8PsnWAIH0OCO/5q9BJSPFXkTLscni1Aov5z9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stFEMskPr7+0aBFxenPOrXlWiZsoX1JOHYAfCa/uzoOq/Q7XDotYSEfipzOkYmTw0iY+5RH1hDI+FzukStqTWU7ZShH8RXYEau1eJ6VJ53UKeybvACu7u3Rkdof3horDbaHJRc/oACXyl2vzV1onCdgV4YGUM9NeIhVZ+vUS2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V9V84eji; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9V84eji"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f6ca9a3425so27644587b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2025 06:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738591236; x=1739196036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3ZAg9pl88KjIvs5mS1f1EZymy0dyDgkN4GT1M3eKZY=;
        b=V9V84eji9P0HdcWV65pg2VDRgL/ECXM/J3o0xCoJb+98/pWGKI8rmPrjBzlqhwNVlV
         m+IQRGRUBT2/BKK1IblkVojJGo3u2oLoucIEhnsY2uGRQBiR30eqHJwDLJDkO5H69TEc
         RFWAn91/KBOM1pDeu0tFpS8lCIPKFkxM6oOnxVGWD79uKuRYi3xbXaDo6wHfB2eie/sE
         v8EGbHywSl9nVjIBs5RLqX2HrRvhYjSKkkX6ziKpviwCf1QZnsDjKOOy2F3tvGyrUSxd
         maGkyCQqhdqXRzP1uiyWUJSkuTB5GFbwxmw0aXIZ1u4uMRsSWIp1TrhVLsVZsqvf2Q5w
         Pz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591236; x=1739196036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3ZAg9pl88KjIvs5mS1f1EZymy0dyDgkN4GT1M3eKZY=;
        b=Wcs6le+OxcMLaTWNetisq0jt8QgrGkO90xlwyebKL9gjAj3ootSvlmYWdlsFU20ik2
         kFrODHqqpMWgQKHEUc8Zb5T4XbGB0Mm50Hb/FeqjVKNYCW3hQg5mjqHukVTevKTzyJR4
         i/nDx3yRWCHXWhfvPT9LCEJrbdlYACyo12DY77sdaWhswkOjwHZdEDXSYnCePpo+Ig/K
         leXyAKDtMRo0p4XBYjGCcISdHz1hUojKBGjqP7O7J6iTMIhOpf9jvhZizJs85EyDw7IH
         6vmFbRsTptCJEIbRAz/m+Ne6y46UHL0OcXPY3ZkQqnEcR++8FwvyeXMHsb1b7yshvpDt
         7S/w==
X-Forwarded-Encrypted: i=1; AJvYcCWvggkud6WNVX9T1fJok53xQsVzZTUbk6jlEvxojIthJNUQ/Mlbqkl+ByYPS8rPKEWuQkeJmJp7dx6oj/jFpCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnfDS1LEZzYyWrMpMYxI9C2FbiVf2TCMfO1B3O8XhA7dAQoh+
	hV08Kfb8PhHFLUUGXo71p3+WpG4CxXBpW1OZ8OQNNi34XvHVFw5XhwPZakTMm8QXDi9TozeSWyF
	WJR0pxwoa8ctM0ZqMS8z53VVtq2ibN40MjhV86A==
X-Gm-Gg: ASbGncuiCriGIKfYmmpsTDGy/vLWk5kSIdROmu3tNTqV+3ZHqHBw/CdKGCNhSdcKoN6
	rnrgRHKmHjElAkont6dHqIWR0TlYPSJLI7HTLQvr8YfboyIQ89/3213jP7q74vAldM7sAMg==
X-Google-Smtp-Source: AGHT+IHuL252vql+MeLPa1il2bPxNj6ynbBWo3mzurFA8SbfqbWEn52CWFCkQZHR2nMMtJaAFqXqFRxN0N0x3eiX1YU=
X-Received: by 2002:a05:690c:6486:b0:6f6:c8fc:61b1 with SMTP id
 00721157ae682-6f7a83fe138mr161266737b3.28.1738591234763; Mon, 03 Feb 2025
 06:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202-rb1-bt-v3-0-6797a4467ced@linaro.org> <20250202-rb1-bt-v3-4-6797a4467ced@linaro.org>
 <d5e1e6ae-b773-4ec8-a66b-2e1830827164@oss.qualcomm.com>
In-Reply-To: <d5e1e6ae-b773-4ec8-a66b-2e1830827164@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 3 Feb 2025 16:00:26 +0200
X-Gm-Features: AWEUYZmz1ECIXn-mrFsqggOTDVeuYLmbYaHev8MsZuEQbvNP_yfferj5PUkoYTw
Message-ID: <CAA8EJppMVzuRLLakNJd4M9MRbW5P-0x=rTf1p9kj0zj88SOOGA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: qcom: qcm2290: fix (some) of QUP interconnects
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Feb 2025 at 15:50, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 2.02.2025 1:16 PM, Dmitry Baryshkov wrote:
> > While adding interconnect support for the QCM2290 platform some of them
> > got the c&p error, rogue MASTER_APPSS_PROC for the config_noc
> > interconnect. Turn that into SLAVE_QUP_0 as expected.
> >
> > Fixes: 5b970ff0193d ("arm64: dts: qcom: qcm2290: Hook up interconnects")
> > Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> > index f0746123e594d5ce5cc314c956eaca11556a9211..6e3e57dd02612f3568f07f1e198028413f463c69 100644
> > --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> > @@ -1073,7 +1073,7 @@ spi0: spi@4a80000 {
> >                               interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
> >                                                &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
> >                                               <&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
> > -                                              &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;
> > +                                              &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
>
> Still incorrect, this should be &qup_virt SLAVE_QUP_CORE_0

Hmm, why? qup_virt has its own path. I think this one (using CNOC)
matches the usage on other platforms.

>
> Konrad



-- 
With best wishes
Dmitry

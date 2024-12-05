Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E8A217704
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400791; cv=none; b=TRh0RE9c2beY54OocohF5xjLLU7Su8JfGt9k4Ma4UXyM/zV118Dnb/iZu6aBYOWfQSo150jUxM0NYV/ekOcbWlMg+ipVwayUKKlqttHDcp+jwSFFwDnL+M7DrM92mzm32GXixc17TbHpJcjj7fzwsgNlMan6mjCws2JBHfbdAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400791; c=relaxed/simple;
	bh=sHboXScQQp3WVNf3+fBRjPqQ6bd3yAYGJGxj1YWQxLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBmM7wRK0MqD3beaUfHRjLvgJV9p9L7DBsYT6Jf8fXTMxJvmskp4rYpA4h5OY4xuU3aFKV7K9SsBe51Mu0Z18X3WG5SCxNRKrkl9WV82g/RYhgo+q4u7kd4g3dnrsH0xyse6sGTDXCxlE+U5m85m5t5ASnYHmaCoSEFrNwJYfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXITlRob; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXITlRob"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so6984431fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2024 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733400788; x=1734005588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwrzwX+VjMp3rjgyMNnFp0aWkMg9bE4xU/GitUl2qDI=;
        b=bXITlRobOZZnemPXHadM7zA38iH8zx9yqh4fFNPtCJuJNwr2DDB0yEaU9mkq1RH2nD
         7O8aOCyT8k+HWqjNmdI9LkwtPHF/ryXUcSBLE9ar6bXCPOpNVxqKnNuVE09/Bny3K2vJ
         TozLQPr0GYj3BJZoAJju9E0RKUCXMy7e7jwk+jPu5rk9DDlGZopkvlpOgn4vh+ui2Mud
         jJE214tnlfJgCoFHdsZV5ICzUH1PnzB9XNMUAh+kGJemCb08rcwxdfLax8/c4uAXVayw
         pWVGiV51HwbUbOF5RaXoPbaVKElP/pNRQAM+rxoxM8Tbh8gYri7yK6GDFIgzsy3PM4jb
         72RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400788; x=1734005588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwrzwX+VjMp3rjgyMNnFp0aWkMg9bE4xU/GitUl2qDI=;
        b=HfrNpUj1AnArTQEXJOOrnTJDWPY7nDzAFGgF/YZ2vjtdjkqrl9C+ApgmbEfB+8Zwm5
         D5qOVytzYcBkkOK8pVj4choWC5FBHRw7OvsZr8YO+T7jirmSv5BVB51q0gGTrkVQcetE
         5cehYgRjY9EyNt9ZLzIKZhqRex6aOR4NmvvoLCKsvs394ZE21mFoG0R9UlyIUM+pAuEf
         +16sMtZzYbjQ0XbhNJ/AGqx2OUa3q+E0mPMpUzWgTaLOv7KUUpEBAtwKWsG0IgrEdriu
         lUgnwv3jNwH0XvvHh+xH99hQqnG7zJsnUj5yfr83ei2UJ6KTUUSzp9N+/4fPKy3WKyPo
         peNA==
X-Forwarded-Encrypted: i=1; AJvYcCVBkhbDs4ECPtycGwQUeDvOdyE0muiN2Gh9p/0tzbuOP9hZ4aU5MddX3vumvjL4aofjkNuRkwAkhFdy1hmSd68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdN9mximIuMVawLHPWfVfEG1Z4NbfVgbrwLc8PxccS51xNDdx
	ZKG2ajtuU70bHAOJtls//p6Wm8TzNj7snHPkBnxbh4EnKLxL/rLWEwu5xmAsVng=
X-Gm-Gg: ASbGnctTo9m3RaSWmaiWVsntWIFTKhxcQe3YISSR/j3ynPDu1w2VMiEq5qEnfLbpTQU
	6ntLfFLwqu8sfrFfyNn/89+IlV4P0/8ZhCeEJBivyPkonwCQFUbOUK+aKYxjBtBuv3KwJW2W4jj
	aNG8yxdlf50zAi1wj7BLQrKIX9nl3irMRYxfavMfNm51C2jucap2f4hAM3Zx6ef9sKia9mYrOPe
	G5nitmu+sBJplgR1HcjnNzH0KDHeyDnpKMctgi7mcSE+uZP6HPHmHLjZJ/xW0yLvOdmQ908q4bi
	uiOgcGm/tgk6tS8cwBNk1uxVvxaLtw==
X-Google-Smtp-Source: AGHT+IGIy5upWqQ/8rBXR0DSluBGUFaFQ1r+E84LOe3qMZ/THup3+2GJi7v+gFPtvdOWb134Dp/BPg==
X-Received: by 2002:a2e:b8c7:0:b0:2ff:c69c:db0f with SMTP id 38308e7fff4ca-30009c8abf3mr63428231fa.34.1733400787878;
        Thu, 05 Dec 2024 04:13:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020da27f1sm2063141fa.37.2024.12.05.04.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:13:06 -0800 (PST)
Date: Thu, 5 Dec 2024 14:13:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_jiaymao@quicinc.com, quic_shuaz@quicinc.com, 
	quic_zijuhu@quicinc.com, quic_mohamull@quicinc.com
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sa8775p-ride: Add firmware-name
 in BT node
Message-ID: <kgxxykbogtdfsnkyk3f5mpht54o3siqkhkfji5nqo7cyck44rf@x7kb2otqdo7n>
References: <20241205102213.1281865-1-quic_chejiang@quicinc.com>
 <20241205102213.1281865-4-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205102213.1281865-4-quic_chejiang@quicinc.com>

On Thu, Dec 05, 2024 at 06:22:13PM +0800, Cheng Jiang wrote:
> The sa8775p-ride platform uses the QCA6698 Bluetooth chip. While the
> QCA6698 shares the same IP core as the WCN6855, it has different RF
> components and RAM sizes, requiring new firmware files. Use the
> firmware-name property to specify the NVM and rampatch firmware to load.
> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index 3fc62e123..e7fe53d95 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -857,6 +857,7 @@ &uart17 {
>  
>  	bluetooth {
>  		compatible = "qcom,wcn6855-bt";
> +		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";

And the rampatch is not going to be board-specific?

>  
>  		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
>  		vddaon-supply = <&vreg_pmu_aon_0p59>;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

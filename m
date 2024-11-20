Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872215853B
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099500; cv=none; b=kqOAKvk+N7lRE4iGc9hhoo4KzlTDY+tcnEPSpjXuFNjDQVDBJcEhKGChAKSw5FivXTwdGaFhlbh0uRkaF/dRGJZztAg9JaBEmj4RtfMUASPfIK0IPPbzr4T9H4WVh9f/2lgSbWt55hbYYeoF03Q2cTgLad7Z7w3EsJjkTx1jm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099500; c=relaxed/simple;
	bh=t8rtOOyR1Sic/wfPMOnwbUSHPAhTaCWsScrHIcpxbPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDEJc99Eu/j6IUX6qv6otgYfk5+nFSq1xjh7/v43L1Gb8HffloSvx6LCKUOe0gN69ss2rgjX8q/P9YH4W8XkCuHtqxwDGPP4BO02ZS+aJvzq9ZulNUNWS7amQTYALu3bKM6sHFFV67j/qCuDrDviv5ozGUgUTK8aAwCtnRzx9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yf5ob8iv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yf5ob8iv"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53da353eb2eso6695417e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 02:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732099497; x=1732704297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi4AS2bqiAYTBYeemIAg6pMq2Y+iu6UwlnPqINFrgpM=;
        b=yf5ob8iva+5KQakqk/fttVKDvVkKSrF3Un2TW2zyY7X4QzP4Uj40/v/H2Gs7JTVZzL
         cHcXzZjDJGOz/WAC4iOq70o/Eekas5AJ9XM15xIL1iP5I44NyJe6o2V34XaNiS97lo5Q
         SwXa03q8x/OdWpXI5cIasqtgi5/9+F7dLedRA3peNJl/PX1N3IA9YdQVNOPwIOnhxGha
         EnIit227vuOc23ZkwipJjK2Lse3waNhg3QhmkwIjPyu5bD/H4WyLzgrAH/MGbqorxomh
         7kUX0rjc3FJLZlqqH4roY1pL7GBGki+++nd7P/+ZwpYnzHMPh33vCWsd/jCWI3JuUDlc
         WO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099497; x=1732704297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi4AS2bqiAYTBYeemIAg6pMq2Y+iu6UwlnPqINFrgpM=;
        b=t1X6N2fCP3TjT4W4FSwtg8TA4DtnXpeMtR7/kWcm1XmG6qrF9Dib//EFxJwDeW0rGL
         aX/o/vt3HyWedUp9FJ/DlD8XzWAFigw8sufZcHLAE09hvW1PnWX/4SCBDsSAXo02y85V
         lck5qBj5L7Re+UurBXWNN4YGu+jy6c88YMRF93/2iFJYiZy+BOWF3Gz6QIKRivQRsiMx
         5FSFbJLVBfQwGxgjw8d09BL3RaDEWsAGDkUd1TiZzVpvNujS1zVhexA7kRfKl1LyW3Vm
         R8XMmDzofnY+pXXR6q3m+GtxxFElQ2r+noWkrWsrJo1XTScaKqf9Z1XgePCinPxm6Ie+
         cyLA==
X-Forwarded-Encrypted: i=1; AJvYcCXSI0KYXCXSCcekqfjdpSJawApDnbuhuys+VkX/piJ9iv3LelQVUiUH39ebTAS9CYhuAHH9EBCjs+H/H3uFtEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0f8OMhjG980azhzXxwQFVv3GUuocEvJGvvMrgNEIRpOpT5KS
	joW8LEGT0jfggguve/F1qZj/hPkQ+bFRA7A3jFSRCEkXvxBmpem8rxpox6cJWI0=
X-Google-Smtp-Source: AGHT+IEoIfnJUDG/LMRTAC0O1sjcvijpB24W9ioyTCFzP31CzNbBxr8VZVPDrctyH9REII3PGnOH+A==
X-Received: by 2002:a05:6512:3d21:b0:533:483f:9562 with SMTP id 2adb3069b0e04-53dc1363763mr1368979e87.42.1732099496907;
        Wed, 20 Nov 2024 02:44:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dc4906408sm40174e87.201.2024.11.20.02.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:44:55 -0800 (PST)
Date: Wed, 20 Nov 2024 12:44:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, quic_zijuhu@quicinc.com, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sa8775p-ride: update BT nodes
Message-ID: <syvnrytilr4fm3zxh5i5trddqkdxgciqfh75srg4uug2qbbkyv@3ndtkit6ldhl>
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-4-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120095428.1122935-4-quic_chejiang@quicinc.com>

On Wed, Nov 20, 2024 at 05:54:27PM +0800, Cheng Jiang wrote:
> Add product-variant property to specify the IoT product line.
> Update the chip soc type, SA8775P-ride platform uses the QCA6698
> chip, which is compatible with the WCN6855. It's necessary to use this
> new SoC type to distinguish it from projects using WCN chips.

Why?

> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> index 3fc62e123689..da52f425c676 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
> @@ -856,7 +856,8 @@ &uart17 {
>  	status = "okay";
>  
>  	bluetooth {
> -		compatible = "qcom,wcn6855-bt";
> +		compatible = "qcom,qca6698-bt";
> +		qcom,product-variant = <0x20000>;
>  
>  		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
>  		vddaon-supply = <&vreg_pmu_aon_0p59>;
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

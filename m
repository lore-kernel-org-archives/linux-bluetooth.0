Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C083033D8
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234446; cv=none; b=pIGiHmp/FXuVnypWLImtpaBEv1gDemXZLDhIBTMcf91lbqx8++Sj/0+5CRDmNzOWRCOb0knEiLnnG0hUwxbNFAmlrYe3vwii3ELBtBTvZE7TG13DdwhnglUOtYaPg49Ks9yB3UHXBs2FAlo9JoomBvBeduYszinWjHqx9fXi8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234446; c=relaxed/simple;
	bh=fbjFeQKkf3We9Z0zCyJZjbfjHVJDOCBeDpY4Djg3y4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OR6X5vUrpspXrMABg96lJ3Mq24xaC3vWN0hTOafujCLL/GW2QR63zN69uTOuQpBnLMJDTn4M4nkbjPQtJrL/3vWuzzAMTr49VT68MD5PyKHqNfYAYSBLislPc12xfsRzJDBXK9/sfIsmg3/lh12YNEVLbWkHcI5gUTgZO6DPJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AnCNtG0M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hIYWTTZx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AnCNtG0M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hIYWTTZx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA5a9t294251
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NFGqFcju/HBfaEF7ZbKNU4HnJrp9Ga0LE8bLG/xknuY=; b=AnCNtG0MHmyRgtB3
	3PMNfUOyZ2r2xET0T2DicxSvHIlN1kTzx6Zpc4SnpoXk0bH52ZFkiMxo7Tmu+vmO
	hy1eHEHmWWnG/IGyyBxEsRIS91iAnvZu0hBPjWEE/AUcaHbpoPHNBguMtzytd7Y2
	dgKLKA7nMPqtOMugOUNTR89VuLY4i3EfKFwiQyY/OyCHfB5H9DlYiT7C0EOnIlk7
	L98ycHBTxudJ0xAnqPRLluHupNd61O6sjD6JI+KDp4aBqIzPaE1dezrWc9z0dwYZ
	n0y3Pj3Oe9CYbUpBbtu6S6AFVI75f/ljkAKCHhCCuqo3z4WnHeVBIKxlSvCBoJCu
	kLTamw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu6bb8krt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 13:07:24 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94ac645d5bcso876749241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773234444; x=1773839244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFGqFcju/HBfaEF7ZbKNU4HnJrp9Ga0LE8bLG/xknuY=;
        b=hIYWTTZx+GuEgYVa1u5bskA2fDltGXY3mxeYf157WooXozjtKbSQJcYXBztQN/IBbo
         xql71rOV3Gik6gCkv81HA3LsscmEXv1f6qIuKRPns3UCT3te2BkoJkh0eU2Gyaf030Rl
         XzjsAO3PphcfLNwKbNIMKkLqgxmycTUlKtt90T6x4U1SjZbtz1huOAbfLGIrzOEM6lth
         HFJqPSPmXE7Qduyv5imXQcLfyaxVwIbCvqGH8GN2HZylrOZnVE9xOvY5xT99JhoygNKg
         KDBnnSSLAaJ7BwUi1IChSDdbjfsq5szobUYp/DaS3pkpHqEGE959Hix/d72HMACbS/W5
         z8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234444; x=1773839244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFGqFcju/HBfaEF7ZbKNU4HnJrp9Ga0LE8bLG/xknuY=;
        b=mdb0W5G9PGH1gROg826dklJfg3bnZtHddGPp3NR8RsWK6SA5Qt+NwYGUJJEqm8i/oJ
         nvxMJ33cwGsMsF/S37Wkr1rb30tAyY/bHW/ng80Z4/nWAFdoTvNQbBhcRvaj5NK/h9Wn
         Yyw2ZFb+KHPUQZMb8uiqL1SSD7s8mlwR0VSn6OEzB73fQ+tnVVs0u4okH+jSYWl8cvhL
         7QhUvEv7Om9S2Wvnst367wxbCZ5dHI310XuR7iCepakkglCOVU6ZkmR7eFO2DF5Kaq2x
         HGBJ95B6eTo6KyVEjnfko7bnqpsRgEsMArrKMGn8uQsUIqZs/xg2SZrpmbvLMb8GYY1B
         c6kA==
X-Forwarded-Encrypted: i=1; AJvYcCW+fJ4zTwetdg/o6J3dNMwu6yCb3IZFnyVZUFPgr5Ig7i8aRqnnd8QTRvpTQRNQApwSrX3STqrVPDhB0gU7+/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwydUFZfq2+1n3062gTG8oHX9jv/WFy1tgpQZAXpFgIFmd2sGiD
	9jtWbiaGh/eGX89kmAkh4keC+PywhNsRKFTdg1TdFzALLU78R83S1nYlHlrUInJf8ZtYT7p4Z/T
	K4vohNKhWvW9VNT1a4fXv3Egj+tMSjliAQS9GzuCdyp4YsK3XJ7zkzyBER4UYFbXQqcea9Go=
X-Gm-Gg: ATEYQzz532JnrBagbo3Jh/c+13yl2Y+FuuyuMdaB51/ADxFK+/fiph4WRRNCFXkizz2
	BvxszPCUKM0EhGREXgV7ZedkEp2EcZnSa5mXFEtBpgOS2VE4vEeRyHTLMxIuv0Px+FAM3BxbbaU
	crl8oYCjSoZ0ezoK60bsMczhRKm9afHPxCFIo9lun4L+kBYB16QvJqIAnnrmNsNJaBj8VDQcWyC
	O9O9DRMdm/mkYQtLD9x/AWu0LiJN89euO+kGycJ2hkU9wGNC7oydiM6W+/TwmcGAo4b1ys8IXGz
	4ReV5YfM9oWndAlX9c5+6LDLiCsKibOQ0NWdeRN4iAlOUa9aJ5dwF+p/0Ccbs34xHG0gke4eY3N
	RGEgJHfVuOnvTJOL9SuticiPL1DT1dqt9xFuMaEvL/09kMCqHy0pCkwJPa5JmWiTW+Z/g9m3DSu
	JDnz0=
X-Received: by 2002:a05:6102:94d:b0:5e1:8746:85ed with SMTP id ada2fe7eead31-601def8bf46mr421402137.4.1773234443742;
        Wed, 11 Mar 2026 06:07:23 -0700 (PDT)
X-Received: by 2002:a05:6102:94d:b0:5e1:8746:85ed with SMTP id ada2fe7eead31-601def8bf46mr421391137.4.1773234443277;
        Wed, 11 Mar 2026 06:07:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631448605fsm521124a12.12.2026.03.11.06.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:07:21 -0700 (PDT)
Message-ID: <cffdb8ab-a293-4535-860c-378a4b8a3d33@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 14:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth
 over both USB and UART
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _hyhaI5PFLLlBhbUEwIfh5OrVG5cHq6q
X-Proofpoint-GUID: _hyhaI5PFLLlBhbUEwIfh5OrVG5cHq6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExMSBTYWx0ZWRfX7ClRs4dP6zN0
 t4uzFOxh/zU3lkC25FTjPI0lsMSO+HV/DaUTiAxWmaqC+tOvHxXd1OcTsda13MUgvg5PusPA/Xz
 ZqFozex2wZaOmV8ynaXBEZMrEv9j2WEznMvZ1D5XINE67SH65aO011dZ60OXN5EkK/oifC2VLPW
 Ll3QORtWmMnISRB2NFgpkjonzHhEEEa4a5zIiNFoPuvJ2KH9PavLYktQI13S2v+SSVxSXU+3Pd4
 7np65THZd8fxhGICAfX/YlUICyCAtlm02dzeNkfneHlO1iJBxr8hI5pAbMedsIywlrSA2WxLYDn
 8EeKiPVHsYAjwq99nZO0f4rFP4QV8IEELnXE6YfXcCzYLfmbS8Gj3nxjesg/khDHNdBikoMN1YC
 EXw/BzVJfxvGmAFLG7lpnxjYduf7lxYH2J5sbF1np8AhgABeVhe1iYRTiU0ibyQjKmKmjD9aV+w
 7hLQl9s6B0tfKvUz60w==
X-Authority-Analysis: v=2.4 cv=CKwnnBrD c=1 sm=1 tr=0 ts=69b1690c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=BgJLFjmsKqNP7uD8e2MA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110111

On 3/11/26 10:09 AM, Shuai Zhang wrote:
> When Bluetooth supports both USB and UART, the BT UART driver is
> always loaded, while USB is hot-pluggable. As a result, when Bluetooth
> is used over USB, the UART driver still be probed and drive BT_EN low,
> which causes the Bluetooth device on USB to be disconnected.

Is bluetooth connected over UART *and* USB simultaneously?

> Configure BT_EN as a GPIO hog so that it is controlled by the platform

What's "the platform"?

> instead of the UART driver, preventing BT over USB from being
> unintentionally powered down.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> index 630642baa435..60a0b3ecbc1b 100644
> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
> @@ -647,10 +647,9 @@ wcn7850-pmu {
>  		vddrfa1p2-supply = <&vreg_wcn_1p9>;
>  		vddrfa1p8-supply = <&vreg_wcn_1p9>;
>  
> -		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;

What if I want to power down Bluetooth now?

>  		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
>  
> -		pinctrl-0 = <&wcn_bt_en>, <&wcn_wlan_en>;
> +		pinctrl-0 = <&wcn_wlan_en>;
>  		pinctrl-names = "default";
>  
>  		regulators {
> @@ -1398,11 +1397,12 @@ wcd_default: wcd-reset-n-active-state {
>  		output-low;
>  	};
>  
> -	wcn_bt_en: wcn-bt-en-state {
> -		pins = "gpio116";
> -		function = "gpio";
> -		drive-strength = <2>;
> -		bias-disable;
> +	wcn_bt_en_hog: wcn-bt-en-state-hog {

This name is illegal (make CHECK_DTBS=1 qcom/hamoa-iot-evk.dtb)

> +		gpio-hog;
> +		gpios = <116 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		input-disable;

This property is not allowed for TLMM pins

> +		link-name = "BT_EN";

This property doesn't exist

Konrad

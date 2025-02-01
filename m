Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138446B5
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Feb 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738423156; cv=none; b=SVIZaRFAPgnutbYUyJ7AVm68kUqVUyBfjc3AfE9+kRRas3tafaPYoNwPCIpSybEfADPrEvM0e91boLl/6bcseQCpI50EYHVINfV3djIsMdlGyDX1tEAdqC/F0hZnRIOa8hgDqV1S65EbzrSg/IsekadxVln5wCHhAjg1TZHkF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738423156; c=relaxed/simple;
	bh=uDCm6Gpac1lAAIu3wdroHBl+yKA/YJHrZA4CQfVHavE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxFb0Q4NQHFuDjrjWEZR8ohE+J8Oysm7+qXPAOI3WSV8hr8dw65tNa9IaS7Rok2HdJX2HAWsczEM5eqiBTLVapKUfEF7QeXbNeygxdVX/6Nydp646fJKAUiB6sHsE8YjyoRrJizFC6CGRhImGkSiXgDgAGUitNBtfDJeMuSlxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOBxPVV2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOBxPVV2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5115WXCH018987
	for <linux-bluetooth@vger.kernel.org>; Sat, 1 Feb 2025 15:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PEQTSww2aXNU2AjLtELdUKXpPVwSbLpAhvxWBmCLBBg=; b=kOBxPVV28v2DSbdh
	qPqUCBqa86UMCgYg+cjH8QlRBazubfgfOFVHJZvta8shOaecwWcU3g9g2OpAQ9FZ
	BcBOb6vnoLRq0HRfmcxrXKM63AP/aZuAZTn/j/I3r9RTnxvUk8Vq8Zi8fo1K13M9
	Dt9kceO/PD1omGfIhvaB0gTAp5+yPGsLTzWq5rkmvMu09lvFPx83mMBxDO7z5gF3
	kITAJZG/CArRaF9D4507Dz8QrJw1V/TUSrRj4m5eiCTkiNJdMm/8/gSlovOHTLx+
	tIQSFmaebAOI2+3Pibn3ZXdqgW3EsSoUghvHqFCS7UIPRa2boTY9jhSTBf+Q9gZL
	uxT0pQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44hd7j1233-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 15:19:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e5c3a933so51970785a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Feb 2025 07:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738423146; x=1739027946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEQTSww2aXNU2AjLtELdUKXpPVwSbLpAhvxWBmCLBBg=;
        b=loZ9k0PBvjLYfSL717/gOFw78S3i6AImmPi37t5nU8FQRV07Ycc42Ja+oohnAPoq59
         gGqyTF8XKRgUMIM7GYG/GhLoDgTUFjCKsm+MSeoFOtbTfuCvKtrZXF1lmx81bpF21D2C
         dcEDAQiP2LZlrKYyCL6L/HMUoxO7w9bBf11hYfARIu8jTAxXcT3HiH2QfNH8nZVEfAOZ
         IO4jVzPyTlnLC2FojJELqYt+Oe950JQEmDaIfXMGZ4Owr8P3kP6fZu+nxG6cvcMdr66n
         olESV3XTuNp2o3HK3DDfBO77xckXvqKHAa/gkP3rxD3wkv+crRzuQPQ1Px/FuiV2c0+z
         UGAg==
X-Gm-Message-State: AOJu0YwpykQBYHqbtb00rHXfQzmmQL87ojFW7HnSaZY3vkjSOs3mtXHm
	OdPZICI1GCa3WHvjO/8Jt6qtibvPplwjXBQWLzeR9GVRfL9j5d4Xt+3YlDU6ZP/xzG8ZIu4C1MI
	3XLsrHnKwi0AQCSUXSjiqcqUEmZ8g8O9ToF91aD+/GNIbb1IF6YG8TY8UljqHeK+3Njg=
X-Gm-Gg: ASbGnct0rruGqHxrLZVuzNOVWovy3cqHzuwuivveuXRa4uu0mCBZYCK4h59Xt3n1G47
	3zYhCGjDbr78qU287mIyLAOEc2he3bfB3Q6ZuLdJsRPsrU4h/NYtBCQLnc7UO9IfPs+RsdrL4VQ
	3CF/B9kq3RvRz4jz1OIbZ1WeREw0uCd1SI1hF/0++f+hk3qOZpTdLTN7FXJcp9aqStiY1GzjkgX
	a9n9rAItz2BhZCD0OIsABRKddZSw4m0TuHqNi0y3jwh3PSIjmNua6XBnM1tsHC+WN2KEU4ujLQm
	WpHWWexIz2T5kZ9E0RJQHraQvMvJ99aRoVp033pwHG07Ig9F8UzlWPakjW8=
X-Received: by 2002:a05:620a:2adf:b0:7bf:ff64:3370 with SMTP id af79cd13be357-7bfff64352dmr575819885a.15.1738423145689;
        Sat, 01 Feb 2025 07:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOXhYLp+IidxtotJdXrWGpPFoUNa342Y0Jz9qWiUBMSPcNnWKDVyH/4q2qfJ/OsTgC5Q+7ug==
X-Received: by 2002:a05:620a:2adf:b0:7bf:ff64:3370 with SMTP id af79cd13be357-7bfff64352dmr575819085a.15.1738423145317;
        Sat, 01 Feb 2025 07:19:05 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a59855sm452028766b.180.2025.02.01.07.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:19:04 -0800 (PST)
Message-ID: <55195890-b7d2-4df8-b8c5-fa2768e90094@oss.qualcomm.com>
Date: Sat, 1 Feb 2025 16:19:01 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: qcm2290: add UART3 device
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250201-rb1-bt-v1-0-ae896c4923d8@linaro.org>
 <20250201-rb1-bt-v1-3-ae896c4923d8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250201-rb1-bt-v1-3-ae896c4923d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kj4sTq--qqBE0FbzGUVvjohGV41XqHtG
X-Proofpoint-GUID: kj4sTq--qqBE0FbzGUVvjohGV41XqHtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502010133

On 1.02.2025 10:18 AM, Dmitry Baryshkov wrote:
> On QCM2290-based devices the SE3 is used for the Bluetooth chips. Add
> corresponding device node.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index f0746123e594d5ce5cc314c956eaca11556a9211..5f92eb16482a0ea5f8436cfa7e55849f171ebd24 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -1239,6 +1239,21 @@ &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
>  				status = "disabled";
>  			};
>  
> +			uart3: serial@4a8c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x04a8c000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				clock-names = "se";
> +				interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
> +						 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
> +						<&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
> +						 &config_noc MASTER_APPSS_PROC RPM_ALWAYS_TAG>;

This path doesn't look quite right.. there'MASTER_APPSS_PROC is only
on one of these.

+ RPM_ACTIVE_TAG

Konrad

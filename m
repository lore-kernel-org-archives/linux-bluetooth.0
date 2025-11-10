Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762230CD8D
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775403; cv=none; b=HXxd4gXeJE9RQYwIS0g5gAGHD9oxrPGFLx1nes38D1WWJxc9b0fFyDcryhv+cDqLMXV9RxAjEISGQNoZzgKtO3wLOTpErHSOwz51WAAuv+173+HSXIE6dOiz9UGY7Qmxlk1yD3V+kAusOTSKgTpOGcMAc73mVGt+yqfICgYYuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775403; c=relaxed/simple;
	bh=PbfOgtPT0n2UXrEeiTGt3mSbUyFEmdqiEYouVpjeTQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mptusTkvtWN7NX7178vOurdnfuk60rNzkLQRSbx6/9VzTm+OSPfRYeZ4uYWV1H7jv4ZOZlNZMHREXX2olKhsR4Yfj3hH4vGv8TlCzBx5pm0PLER6CBcRJ4BS+KYgCbCO8SWPFPFw6kAf+hkCfnDr0TsMPIkIyKjEERxGI4tg5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gk76Bm0H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvx5R2QP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gk76Bm0H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvx5R2QP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AABZgaT3271132
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 11:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	toGXLTCJlydVt4OAEmWhLmfjiiINqMpQruYYZvrtmdI=; b=gk76Bm0HEIR3QPsF
	p7UsJGZS/mEfyH6qsxu3gXJ1AhsXIYhbfNQg94YOOVS6o8U+T8h5Sek35YtId91i
	cqj7Gj5N77/fYFyyw4EeC7KvyVPlkTSAzOMj9OLvf66DoA9hxsP/IM4bc/0JD2hG
	8RONuhFUHeg5hLuJHdjoJWcGeIL8P+QU0wlD+o2/KDiDkst/UXG7WGXItqYXjCW6
	5W0BQfPmLHk+Wx2Ygy7+mvpRdbebCFsDvDo3LE6IXZBODMirnJRHjLyRCRG83Dkm
	UGiMb7fYn/bsJEIgYcKKKcUwUBFa7ic1wERFslFeSMTEEb8t3uU4DvJginSUOso4
	6AIrTQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafr107-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 11:50:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b25f8d38efso66011585a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 03:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762775400; x=1763380200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toGXLTCJlydVt4OAEmWhLmfjiiINqMpQruYYZvrtmdI=;
        b=kvx5R2QP6T4yRuayO5k5s6nvc9Balhe/8wpNMPyn7BFeA0dLjbAp4pLoTNFkss2dTC
         nESxj2KPlakZtFHJTm7KAlKF5uItfjNVeOHI+tfSrh3y9Z692EExyk7bfHbQsgIWCRTH
         9k0n8pENWYSehv+Q0GL+DUzv1mNaFK6mfjDbP2uTjLwKu10hSSHxRIaXtb0exuiIze1x
         ibVx0ENVa0EBxD0tS/pF/c0nEZXnN7/a+nDvsjLuWWCB0MzdDuxiLY9kKFFuhWyuLIZW
         EGpq7TNbe6TGcB6WaMBzhbzndmec8yVDUU+EMlym0o4g8piGt3aSrgvJdcvuDp3ni7rR
         73WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775400; x=1763380200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toGXLTCJlydVt4OAEmWhLmfjiiINqMpQruYYZvrtmdI=;
        b=O2trnjoBdrmm5gV5bSXSMWmdXj+KLEiiRydMIbdSuWWAWcF9GYd4XvDDnKQmvwHPc1
         kqNCd8Xjbd2tN9DXXAl8NxrfOLkqypSMyZlsOzz+4zDm5vH9FoI4zTBa4Y03yLTXIM/H
         Lqy7+i2mpEXiDwm4CmvpzEYQZ4LQ4pl4FNLWv2vJW+EO0lVYCndgk/SIaNyckiKGv8oW
         pSBpheuvXaqNS7XDDTXOoSx9cFm7gcEixClneK7btsSow+L6QpYjr8Xinc/JsI6syUYY
         6InbKLjDsnDcLZhI3x282u5ZJIDDOrb0I1091m9vG+PBIW2TwN3B3DCXZhSTC4HUhPpz
         80xg==
X-Forwarded-Encrypted: i=1; AJvYcCWCr39wkPVfeAvTmijgg2gnYY0hVFMRkOHYSV3peZbGZwRGGxd+szefSqK75jwJ81W2C0VLnnr2ndbKw2EXs5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7HgE9kH85bnFEv4qconvcJ37VOiYtTud4jZsYffM1W7JPV5y2
	dfFnrcFFiZejLphPunUugSmtuCm2mo3UwQeuMl/P8zbc7MDgvATHIklkmGn2vFj51iX5GbhXL/Z
	aOUQqrP+gq3GIs0iVSp7pKs8S12NWY3eJWWklw3tqI3xNEXs1MIXUYQbMQ8xDzVdtCB1f6sU=
X-Gm-Gg: ASbGncuANdAmA98iIx9nlLp8amt0FIZF/AzQ5SsyGs4WKBjgpSf1zk6UQprUGpVby+k
	wIWfH8r8xgUIuBSeWUa5mw3ClTq0Vn17TYB/COacMPquQo27RVYtFosxTRYPrtkLuP8LYO5ZqyB
	ZpiZLmRMNZ+iQ7BtVeDA7VAFJHP6wKKpeP0HqhA1gA0NYZ1APbWrxlmoyUF2CWzIn3qio3BdoOb
	L9Mx8zsuJRjipMeKJ+SMxRJhoDAZayzvfxLyOjoMJGddW7owd9Z1IvDEFC8aR4CaKukd0Jd/rNm
	pSgBBMu6sVfkwC32+bEBybT2UhQVTszScEBbql/NzlFA/xhzGk8zQcMYdCH2ioV5d36hMdygYWm
	0EReeP6Loegy0u60tbyzzh9IHA30j3WrFMsxH3NnbcffSvDFdTeGe0dgM
X-Received: by 2002:a05:620a:28d0:b0:8a2:a5b2:e3bf with SMTP id af79cd13be357-8b257f06a92mr604941085a.6.1762775400420;
        Mon, 10 Nov 2025 03:50:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVjQGFZFRM2pmp/M8zDXVLETjOwEc3uxHXPygKZvWFAmQzq7WVw+Rm1obV6L2pDPnFYmJtbg==
X-Received: by 2002:a05:620a:28d0:b0:8a2:a5b2:e3bf with SMTP id af79cd13be357-8b257f06a92mr604939685a.6.1762775399998;
        Mon, 10 Nov 2025 03:49:59 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbce8f9sm1072113366b.2.2025.11.10.03.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:49:59 -0800 (PST)
Message-ID: <28ffece5-29b7-4d6f-a6cf-5fdf3b8259ef@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 12:49:57 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Enable Bluetooth support
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_jiaymao@quicinc.com, quic_chezhou@quicinc.com,
        quic_shuaz@quicinc.com
References: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110055709.319587-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3bT9cL05vcy2ZROp_ASdwbQ48kQQz9MZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwMyBTYWx0ZWRfX3J3WJW9AEMxl
 uR/eU46rShadPSLAqh93nDzslFun3nyLXkKoUUytrwgVPGIo+zblyL570NaQMX5WFtRdTj5NIFQ
 1vBYG1Rpa6mnhwCz04cG9slRNeHCrU4gsDfjvSZX0V2NHy/6MFxtIndBqznHpRxHhYxmx8diL9s
 g8k9pFF4IGY8bDeLThBZdpof+il1AKPfP2I01iHTCqmOXPJ6XsUGL7pb7+2tT5jBCJ8WZ64O1eS
 NomSoBMBQk+kgDS6lkG1WuPfPAHx1iIcJ8GlCz4zVbt+e7DVimBFgg06U1EEUz1sfAA4ZMhIsjt
 r0FKcVwnGxk3IsYSp/TGumS+V06oqzXbc+/ac6FV+qDYEV1PlDA0nFvvLV4OeM6v8aqwCDR0q28
 CIvfjzNnKwS8HOBMrPbrMoIU16ujgQ==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=6911d169 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=b7yh_2p2DTCkp5fgmd0A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 3bT9cL05vcy2ZROp_ASdwbQ48kQQz9MZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100103

On 11/10/25 6:57 AM, Wei Deng wrote:
> There's a WCN6855 WiFi/Bluetooth module on an M.2 card. To make
> Bluetooth work, we need to define the necessary device tree nodes,
> including UART configuration and power supplies.
> 
> Since there is no standard M.2 binding in the device tree at present,
> the PMU is described using dedicated PMU nodes to represent the
> internal regulators required by the module.
> 
> The 3.3V supply for the module is assumed to come directly from the
> main board supply, which is 12V. To model this in the device tree, we
> add a fixed 12V regulator node as the DC-IN source and connect it to
> the 3.3V regulator node.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---

[...]

>  &apps_rsc {
> @@ -627,6 +708,22 @@ &qupv3_id_2 {
>  	status = "okay";
>  };
>  
> +&qup_uart17_cts {
> +	bias-disable;
> +};
> +
> +&qup_uart17_rts {
> +	bias-pull-down;
> +};
> +
> +&qup_uart17_tx {
> +	bias-pull-up;
> +};
> +
> +&qup_uart17_rx {
> +	bias-pull-down;
> +};

This is notably different than all other platforms' bluetooth pin
settings - for example pulling down RX sounds odd, since UART signal
is supposed to be high at idle

see hamoa.dtsi : qup_uart14_default as an example

Konrad

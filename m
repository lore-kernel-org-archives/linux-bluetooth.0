Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26CE3A168D
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567434; cv=none; b=HU1ck5tfiO9I6olnNEz7Uqc8DVl6VVlQeLWBKlBdgnI6c4KeZIU9f/jJ5nQpBco1t1OxYbAtYnTInnOqltcoVEa8DYMuRvTJ5uJZuqtMj9fBP5l027+1wi0FrlBXTdYXTMrwvMijXfHUkC1hvUYs3IQ5w0uYiceQG5VCIKmw6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567434; c=relaxed/simple;
	bh=ra6xEjPGUd082pwekDXPZRBJqACOOs2yzIRqYTjPovE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdsWHYD7ujEc/M/n4Ca4SO30hBHwdNGTD22GVyQjAQwr5PQcyaRxBX3ehVKNF1wOBsawQ2kc7PuhhMaPmxp9jnkolh+Nd6yT8ES3uPoZiHaProgQ033Rd4vFqL7fgA5Mb9wKzG1pM7nyKPL/9kPdPgIglQlvAGdAjpTL5+DKWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i3OUms9G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gl06eJ9O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i3OUms9G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gl06eJ9O"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637D3ciB492494
	for <linux-bluetooth@vger.kernel.org>; Tue, 7 Apr 2026 13:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S2wMrZ/z2PzZnfeKqTuUJmhmmuTVpcpoive3zz4Ny2Y=; b=i3OUms9GyBpWNaZ1
	EoshCvAi43BYzbLs2Bjk8/7c/8W5m8GSvAA5xuCF0AzvL2RoDCRLXmJgGfcqrZ9d
	256buWjegjZAuvNo+Zvsg2toXA8lLvNYDTBqXK5m06XCmWu5wr8HmvqIYa7DDedx
	pBItUVl8pkzgvmJbPALM+G1FsjKH9lbJnc/tUnP7DVNOduNumuRfGT1VqsLN2YXm
	zWqHsS5IYwhGP8Q0ip2EkPN+B9yPdWRgbsDlPVJRVUlbSNrV+zKpkXKWQ6X5bYIW
	QY+7np6KSy8iI5m3zhCq4hyKiqJ0z53fyn5gBWid1k7PnKJWbcCo2BGKoGEgzvC1
	aZZ2EQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8tsjs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 13:10:32 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-604e29ad4aeso278286137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567431; x=1776172231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2wMrZ/z2PzZnfeKqTuUJmhmmuTVpcpoive3zz4Ny2Y=;
        b=Gl06eJ9OPUzhlsjZj0Uu98hV+EDCcSwGLdMjd9KWkUuVl1zea7LWRweBZURF+nV6IE
         VbnlIuyjcnOVw/OER/TRbYjOMfWleykIU26an47zvbibhbH1bxX2dglxUHVpZsOkZfI5
         WwEK5KieWpRz01idKjX1L1RFZD76MesnDYnw8yW0Nv6R2MO96qwLfnU3j5wJiwQNdQ7S
         LTC85ByOdH37HeJDLVulMDl4wXDbEkAu0bh9aZckpjEVUUb5O9uZwj1vro2cCRNYfi5t
         MRRxsljYkG52lTaeSW8Zgu+/LInv0Qwc2s1QlKj/X2SlGAaFhW3VnRnusq4mm8Opmjf6
         yA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567431; x=1776172231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2wMrZ/z2PzZnfeKqTuUJmhmmuTVpcpoive3zz4Ny2Y=;
        b=gwW7k7ENtx0nG+FId6AlmhlaRqB36o5cr71RhPzA4z06jbIeq6S5CY1HpIoNJZ0VHG
         RkWf1LwutmbdtiWkmGkGzbQmbeWsbIk8EXwTTK/SClyp1gS79dK5J7adAtmVGqP9RP9f
         CmQm3jpfAXQYJQ++nbT0NEGQ4x11sbh5dvS2abtQWblt1EnlmDmSFhCOcPKVuEVFKITg
         DFYYW/5BJugQjm/pLPSQfXhce29Y/CCCHXTulp7u/unDF83XF+vVM3zIWZhMr92klOe2
         PgqZEuXYVQ+cIKUVVjF6i3E8NZWf1VzQaOBMjxIukieuLHK+PimatJc6qbYgq+Pfy9bL
         2Ctg==
X-Forwarded-Encrypted: i=1; AJvYcCWU2ESFZFWBSWt0UBE+ZfSd65FQLmr7WFL4RwNQssZZp/bIUiprafltvqhU0yGjK3zN12QJFhGebEWcMcrPK2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWywx8AeKP6MQivhm62LP/8VCF1RTjH4CjOcETGwD7z7zTImAV
	gKZhJl0JI2NWWLCDr/Kg5thSH4EYTrtPCZeyWnhBDCw3CTU2znLmyr+uY9lsanzV4rchufWApmW
	LkxHz7vcBXkwEqWbX2BZA2C7fd+2l7wTPy33K5JiRE2fV+4xVWW1N1QV735n5YPeFgLZyqp8=
X-Gm-Gg: AeBDiev6v1sbzFaaiyOghSE+zObfgIlcy82AJik0PU5COuouHpGXeZebqSGjbDLQqeP
	tWiAk/qgmc10/WgihWBfLCy6+dsKL/DIb2BoAYjHKb9R10Fk6GnjArzLMd3+NJ/ZFUwpUN3fH9x
	GRQ0fh2Tfg50Av/H6soJNJ72cU6VhrfNPEv1/yOeHv0jEWq7wVbAliLYFPtyFihJYQJ+2GD+bde
	SG1mh6KHmStNAVqFE3UBwjl+h2a4GdLxXJjU3N2bBmEI/sUN6nDkVcfTlGTC7H9cu2CBIfVxLkg
	h5iBEbYqRKoVyPZ3k+tZr4WlmW+V2aPv4/O7Wttzi9fVgnH8zZ5Xz1R/tdN2hOK5RWXtot9vCzY
	ssMyySkC2eIa0WzgasExG5G6BBL553gMm957eEtYGqAwCU1jXzoA/gEcD0uMYSfPJQ6D1Ui16ya
	9QL2s=
X-Received: by 2002:a05:6102:21ac:b0:5ff:d9e2:3f7a with SMTP id ada2fe7eead31-605a4967393mr2047987137.0.1775567431123;
        Tue, 07 Apr 2026 06:10:31 -0700 (PDT)
X-Received: by 2002:a05:6102:21ac:b0:5ff:d9e2:3f7a with SMTP id ada2fe7eead31-605a4967393mr2047949137.0.1775567430625;
        Tue, 07 Apr 2026 06:10:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6c31sm558300166b.37.2026.04.07.06.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 06:10:29 -0700 (PDT)
Message-ID: <dc2dbc10-e1d6-4b1c-8903-7c8c612517ab@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:10:26 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: milos-fairphone-fp6: Enable
 Bluetooth
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alexander Koskovich <AKoskovich@pm.me>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-6-393322b27c5f@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-6-393322b27c5f@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Cx3ycg8WMNItfwrpsXH4WZxW-XvC0tMv
X-Proofpoint-ORIG-GUID: Cx3ycg8WMNItfwrpsXH4WZxW-XvC0tMv
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d50248 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=fx5w4MVDiXKpHOpY66wA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNCBTYWx0ZWRfX+FHDSwiGMql+
 BtB4kvDFZNSkOzn+YYMIs740b5riWqDAyoZ2w2JwRV7hrzdephPV62WmS/fwyqnUubbfAYr72Np
 MDxjAjq6cfDyzmkPwhiZm+AHeDZjx9CNvH033uamQxoBWdOrqR21JWhpUMWdZXgAYaMY8a/vX1w
 aK1tm9jCoFIbUNhYi3XuBh7RxjodVTc5yX1AcMplsyREwWgTdVLVU/iU2IYGiD4Kv+J7flkzkG8
 ZUVu2aaPAM7FrxBuwGTk4Pp78wSTFNJRj2Ps+O0ZX5YNj3L8vaGSRTopGHKHlf8vja7h0J0IfK5
 Qk+Bh8I8NaTp8FMcoX0k/bnwm05J0tO7MnWl4hsiSvYF2QU5pYFv4c8KP7xUY3kk3ExKY7L7Ir1
 CrPBh9hEKlfeb2dI5v2dIF4vADLuNMW46viOsSicdbaS0IFcqYnNLM2u1iX2nS3D6m3DB4+x/qJ
 2tUij7nIYRG6agU0TEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070124

On 4/3/26 3:52 PM, Luca Weiss wrote:
> Add the nodes to describe the WCN6755 chip with its PMU and Bluetooth
> parts.
> 
> Thanks to Alexander Koskovich for helping with the bringup, adding
> 'clocks' to the PMU node to make Bluetooth work.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +	wcn6750-pmu {
> +		compatible = "qcom,wcn6755-pmu", "qcom,wcn6750-pmu";
> +
> +		vddaon-supply = <&vreg_s3b>;
> +		vddasd-supply = <&vreg_l7b>;
> +		vddpmu-supply = <&vreg_s3b>;
> +		vddrfa0p8-supply = <&vreg_s3b>;
> +		vddrfa1p2-supply = <&vreg_s2b>;
> +		vddrfa1p7-supply = <&vreg_s1b>;
> +		vddrfa2p2-supply = <&vreg_s1j>;
> +
> +		bt-enable-gpios = <&tlmm 53 GPIO_ACTIVE_HIGH>;
> +
> +		clocks = <&rpmhcc RPMH_RF_CLK1>;

nit: I should have caught this.. intriguing order of properties where
supplies are topmost during r3g2 review, which is presumably where
this originated from.. not a big deal though..

[...]

> +	bluetooth_enable_default: bluetooth-enable-default-state {
> +		pins = "gpio53";
> +		function = "gpio";
> +		output-low;
> +		bias-disable;

nit: you shouldn't need to initially actively drive the pin, a
pull-down should be sufficient

(if insist you do, output-foo is usually below bias properties)

with or without changes:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

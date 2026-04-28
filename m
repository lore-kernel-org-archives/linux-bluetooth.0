Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C73BBA1D
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368724; cv=none; b=VObEbTgp5Vul+saLWvv3zlONAl0BGuw+mMml7be8/hXSqI0IMAtnaOyWT5+D2Ryx+TVRWEM+E9a203oL9KycrBcXtYl5EGH8ZlXrQh6jUDtbC4q/75pQbwNReG7gHAiMHz04GPRyMXmTrrEkfS+BCRo5XLKETE1I5Y1jYjYQ+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368724; c=relaxed/simple;
	bh=RTNGG1oBjylw5WInHSS/Bhmq34TlF2xruXPC1zPQYu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAmqB4aI7CLOj8rmIqhv0etZPsaHVrCQm9tRr2KgojE7LkGbroBf8fYOqA/iRHEhc920YVKHdcBZYoLTGdnyULfWJUHXi3aznOpxH8vVRiHMnRI2vEBPho6tlWXieOkOtXEeJh+9IRmwEOU2sFcAdGdZ32RfL1Fu0R37S8OAnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KGmRWLkp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YR9adaM1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KGmRWLkp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YR9adaM1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5VaNO2383024
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 09:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dCix2WwSQZTaFU6BabqTi+usW62DHqdG6ZVKuM7pkp4=; b=KGmRWLkpxgKDdl5U
	azdoUMZIS15OpVD9UdTI2seB2A+pveRUqgyL5htkHzur4xDEkw5ZB1US99e7xBvp
	8EpsPzFMtjLMQV9ZKB6Cn9rK9d7Ln7tKKYlu5SSei2Xm83P7ClcXCR2ghw42lP5M
	0JNWMyboMFPA9HVv3SabqhOU4MZ5CPl2SezQeaGvNA1j4kzrNXExhJscifDEgEcX
	BucXH1MTrT9eA6SzdgISXaZhxR4lxfVDHPmBuNw1tZDtHWLHWxEK79DOYF9RzfaK
	XIDC8HDzHJM5b2sxwyEgOQcFF0422eXbf5N6WY+J7QjaLFBfdxe1pDdcxJL8dizG
	SE3flg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xvbew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 09:32:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a016b99579so39615366d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777368719; x=1777973519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCix2WwSQZTaFU6BabqTi+usW62DHqdG6ZVKuM7pkp4=;
        b=YR9adaM1mpGa5JilD6BI/H8bWRDHvD+QvLroolE29xQa7hvMovEjJ3QGpiWPTGjBWb
         oBKYN/pw8U3lZnMbrqdwwog1lsheyehtEEBt9IdfKNtcw3Y4Dt6vRf5ZHtupvxjr4Ijr
         dHsBq1k8PPJklouFFU1mxjsLptvThcvgc5JNlQMwhS0zgUH7kgZ/KYYNBqgpTIp3xLRk
         8AC4H9YIZkYykCLh+g+qqFBZvCUP3aFEfEbPdvKKlKIo50/9NbDLUOVzITpF6L9oF0bV
         83krT6GtMWOmJLBTNXCY3vbnbLf+aKzBJJq4HMX22bWpk01iQFMaJ4sAqsN6ihODuNDC
         MFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368719; x=1777973519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCix2WwSQZTaFU6BabqTi+usW62DHqdG6ZVKuM7pkp4=;
        b=p/4ZLkWadcLRRnK49PeP0ikE+tdqtCsT2lupgTjpDRsFIg0Ig3Logh32Yf8SM8osqA
         WnUCB1DhB9DmoENtGyRwIo3xgfzCqLsphoPW2+WbmtoouHcu68CTR7uV/u1otv7kyxBA
         fXUeTQOcSiJJ5LB0iR2VSBMNUVmN+TKzbQQz2qhPqTmhqy8V5ZArQPpnLyCwsb5c2SzO
         w6b8/NfAW2nVxxwtZnPiiNRVdZeJIFb0gfIKkEjb1dJcsAzMIY9SnURgNZF8RwQYDouO
         /kxYKZimYJF7jiIH2CUIu2pxImGDHywOaQjZE6qzjaXQGccx46AAHYZbORl9i7U9MT2Q
         iCuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NfVT1gZMzHVWPuMt22iTsTwJPNcokPO6z6xMmpgaIdbktlBWx5fHZQpi88nQ7Mlmq9GPMx5Ql9gY8bLDAmDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpg7F3Kf4NJl8yv61LhXQ7DtLj/nJ9D8XePog5ovbQnhetDv3u
	RgUzX/EtABlMPGBadiEF9Orx4gragdnYesPzZwK0DH0Xd8sVJDD+rN+e6oxeG0shscJ+Ln5YRM4
	h+BDyMHnWJ/PoBhqOrLJgLciXMczCrI14AZCA7IHma7PeFlZm5bBGvHeaw1TC1KRTxW91y+s=
X-Gm-Gg: AeBDiesvQG7MIQ3O0XrzdptLqXb/yGZDT3089bBpaMSHggspZ8eZW4e7BDOmL9dD6nF
	G0xxUwJyxL+akf4OqPM7q0aFSIXRed9q82u3qsoiQ3n48NfNYae5GDeVUcwCGAsS6sBMnUHkbS3
	6DHi0Rmqpg4SbSaHWoKaIcTdMdSZwbo4B0vgu5pOAh5JnLVnqBZizakhz6d0FZtaPoEAMC09uEP
	Pl/pkbBvsy8VFbBJMT2nPETwEJXPsPUjLSec77dmiktrL5sPDlAsxCOkgcAnJnAmiYI6DrbnTfx
	ZK0dxS+Ep+3rSajCTcN8xY5KEP6vFA8l40AUFLzymF3RzD/z1f5Q5h2uq9Y9jFrADyh23GvtWiP
	ZoRPPnRq1geGhBVOSnouOYGK1JLCb5LnDxho7WmKx2Hy06C2FUyvJlWVda9bJSR3/MJFToFB2r1
	xstRLaoFJyKFs1YQ==
X-Received: by 2002:a05:6214:629:b0:89a:4741:2147 with SMTP id 6a1803df08f44-8b3e2a0dfa3mr28573756d6.8.1777368718954;
        Tue, 28 Apr 2026 02:31:58 -0700 (PDT)
X-Received: by 2002:a05:6214:629:b0:89a:4741:2147 with SMTP id 6a1803df08f44-8b3e2a0dfa3mr28573486d6.8.1777368718524;
        Tue, 28 Apr 2026 02:31:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c081c40sm74244866b.55.2026.04.28.02.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:31:57 -0700 (PDT)
Message-ID: <828c59ee-c30e-4a47-9ff8-6fbbe05bbdde@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 11:31:54 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: monac-arduino-monza: Add Bluetooth UART
 node
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
References: <20260428025652.662502-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428025652.662502-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69f07e92 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=U7gHpUSv1cUObH_NKCQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: hjh7XZWjryEQ_ZBNnofo4c7Ij-3GC0oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MyBTYWx0ZWRfXyEf5vwK43z4y
 eCrIxFpPgSAPQbyb/6t9Uik6t+ffvSGceA9wyIZV5l3t1I4nMPUtnLYwZIKJhaw6RtEj+oASZ1b
 NGJESkJP0RXERBj9yIi7xaU7Pp89wvxeORbMruZYsZu7tpF01ZjpPzVFb2Qb0PEQInXvHmWBgKF
 QD8a6C/BxdtA8XQnvOLCtZ9by6wFIDvOxvq+MkvjhEq409X5epVpA42RmXXCEQWEHX5fbaRpCFW
 I47zJzF2Y2Szz17wJmRqeUakTBCgWZywi1O7E6ta2ACn9XZ6ts8LV6bGqobvVc9Ye8yGsd40fsd
 y/Ac/iQym4meWYqb8yYKzasCH5Ir/JLMMjJba1klGD4MnMJJJSCJDbwET/Dk1OgJbrIV2yFTHpN
 0XDs+yhvmEmvx7DUJqBMvV/KpWdZovlDljviyFvRn3GJ73b9qSIYO1R9UV1SmVfS1UxWM/ITk/w
 vN2biccGoHFs6lVo5CA==
X-Proofpoint-GUID: hjh7XZWjryEQ_ZBNnofo4c7Ij-3GC0oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280083

On 4/28/26 4:56 AM, Shuai Zhang wrote:
> enable bt on monac-arduino-monza
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

This sign-off chain is invalid as-is - should this patch have
"From: Loic"? Who is the author?

> ---
>  arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> index ca14f0ea4..092ca0b59 100644
> --- a/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> +++ b/arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts
> @@ -21,6 +21,7 @@ aliases {
>  		ethernet0 = &ethernet0;
>  		i2c1 = &i2c1;
>  		serial0 = &uart7;
> +		serial1 = &uart10;
>  	};
>  
>  	chosen {
> @@ -454,6 +455,16 @@ &uart7 {
>  	status = "okay";
>  };
>  
> +&uart10 {
> +	status = "okay";
> +	bluetooth: bluetooth {

Please keep a \n above the subnode definition

> +		compatible = "qcom,qca2066-bt";
> +		max-speed = <3200000>;
> +		enable-gpios = <&tlmm 55 GPIO_ACTIVE_HIGH>;
> +		status = "okay";

The node is enabled already, because nothing disabled it. Drop the
status line.

Konrad

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB835950
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383873; cv=none; b=dt6bJ93wVngYkHfZVRha6/FRDK38zR9cvXNELYKmmeTzKFyCWDEZBNDiB5yphnacaQJNnHA5K+OuTqlXwAYZYSSw6EWuvTcyBZBvDrOgzU7ZyDhBj0PhUUPE9fHw6fjWIVsvF860wEhZ0B+KaK9GoHMP3kz/aYDERNLqpPWGTUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383873; c=relaxed/simple;
	bh=eXX32EnsrJtXZeC6ghwpSOVoFw7cQHT1FJ4A99lykxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaJu0FxPl0xV0uNl1sOqh2U6W7yh521CAuyR4LTM/CbZM3Q7qel+6OKvgrqQv4JJ/xwrSUs81EF4BVi2K9jx8zaq0Zg/hA2f+H/HWDMjdsTxw5qbwqW+mFSSco4PvMAeuzSRIm5KDmXUEtxpjjzq0r3wCuYoooJ3AXXjfibCxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Czp3QzsG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=krT1uXL7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Czp3QzsG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="krT1uXL7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tbau3466761
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 06:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hEawz2/uulbkXKFxTMF08cT7BTaaWL0evQAKbAWCYMI=; b=Czp3QzsGCX64RXvk
	vGDXoHip8AhYmX03hJL+8vhjfRSAuykAyJgvUasng8zdXR6NWXZ8zo7JDjz/MlHf
	+IMGphMB++A9Y2SNQ0BovRd1IsrZoiZMa9noIraVvHuyR5bfNLzdKOzn66otKWsF
	57/DfnreXS346qP1cCBujaj7Lu9ujwjvOlASJrEPr2rqCKRjWzbzYrB/JQe6wTgW
	nRiGMHbtKkOSvwvNH8zbzlVJStUtSxuq5QpCCiV9++ndYzY4XYgZ+LtmxxrVWQTj
	O1w9iREFs1Wmjk1xoH7HKnORlbVZCZkWdBZmTEO73+kkdcLC5CxUzIZWQa3J/f8/
	6LKhuA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh60mu5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 06:37:50 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-466f0785d24so8335740b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 23:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773383870; x=1773988670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEawz2/uulbkXKFxTMF08cT7BTaaWL0evQAKbAWCYMI=;
        b=krT1uXL7JTJ8ZfvZjE9q0gpMImAN+oTnt4ofC0GHKBzByYGwW+R9mTMRt9tKRibSRR
         iulcIdI/99ODD18sOvSliZ+PR+Bizy7ip/zvYFXXToUvEaO8AFi1+pzTrvqEUkfAr3In
         1lCGQMwdZ4ajB4Pv/QYhKtKrgAlAbM/dgHiyoaA0pgR34NxKTweuDmkeVQ0NoJXSOfkd
         KgWSLJSGVEJYKb56NV3MgKy3T0ne7r41fI6TVypA5bO60hZLkNy1noURyop63wUR/3nU
         MgWKlrBTA+A7HTprxmG6MJaMJvv/e0KwxvEb5o1IBv+6vTPvO1+87Q413HIcoFPhg0wB
         KBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773383870; x=1773988670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEawz2/uulbkXKFxTMF08cT7BTaaWL0evQAKbAWCYMI=;
        b=hNZijodRZkKsWMuPadER/HsPaD8F0Vs7+ZHu+H1J8biLXtIIFSPCBTvG9awK2g7dLu
         ssoOJG6OAEYND05v9RKGaTWh1RDTJ5B1FN5vUsys8OucriJSv0vYE50KX4HvpdJtMos9
         iZDu7YIzjDHzWiAUJbDRNRM4WZZsOpfIMaQL6JQzjElbmfi51n/zkLiAQVIfS6xFMl4y
         PDWOhxxi20iBMGvNd+Fti0umuqLHHRc7c7nZXB3OUl79QAGZ6UiWX3KUxsX0txsQUv3u
         clnoTCmic7WE0ym8ATUqfoXbaRGvDChJONfWKE0w3gT7lHYfPjcp8uIsx/P7+A0cz1cw
         lLnw==
X-Forwarded-Encrypted: i=1; AJvYcCU639zE5uaLopnrgGAedEoIv6EEdQRJJns1CHuSwa9navMbxeDgh8Jb701DNgielQ6at/JlBxl4He3DLWrJFpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdnFtZfVT5zFPOeaCYL7c6jsFKpYaDI4wYAbO/0yAE779d/PW
	SdJ7sQNhDoDwV87SGmc3tbqUO1775zrOAWMLpbmPRz/R/XGAHsyH8zaW8fPAbsMpIm5zcNsJMVJ
	8RbV9hkzXXE4snzI6AxTRTP5pla7/6EM+nqqjNH1AyjRaE9eUefxZ5ybe/in9x7u8PqjNhzc=
X-Gm-Gg: ATEYQzxGsolc8z/vjwsQ+My+g4TEbaXN9ABhmQ0BYZADAugtV4NTSClrbZVvMeLN7r9
	nfJ5kYIIda12ndt3Fc+infKXjqhH2Qyv/IIzmYXuWbtk6Is0F+76LJ6X/3EcHKENDKDaAzQYWYF
	dUXHp3IIddnSHvqCXGL4D6rRq/jZgeAK4PMwDqqpI5yKfXSwmr5AFXe7JYqFmWNNy743lXBcUAU
	BPGk2dxHKL7G7veCz9Yh/ZWMvU5IsHrZBzVE3eIYydwTzbKQmwACvicqeZSyk79+V7Wui+57QjQ
	htm4w62yfu8TvOOWCIuq59O7i1gQ0VWHH8DClWYW+8ysFGIM110T3w+gmYDmu3fCwSxRrdDhPqF
	92ivLxTz/tZmAOHQGRoybE4oe82KwZ3H1ZFpvmawMJxXyJ2Y=
X-Received: by 2002:a05:6808:344c:b0:467:1c9e:2121 with SMTP id 5614622812f47-46757037223mr1168930b6e.1.1773383870289;
        Thu, 12 Mar 2026 23:37:50 -0700 (PDT)
X-Received: by 2002:a05:6808:344c:b0:467:1c9e:2121 with SMTP id 5614622812f47-46757037223mr1168922b6e.1.1773383869856;
        Thu, 12 Mar 2026 23:37:49 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46743aca62fsm2856962b6e.2.2026.03.12.23.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 23:37:49 -0700 (PDT)
Message-ID: <97a3f3f2-e9e2-44ac-a682-0e0f0c100a45@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 14:37:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth
 over both USB and UART
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <cffdb8ab-a293-4535-860c-378a4b8a3d33@oss.qualcomm.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <cffdb8ab-a293-4535-860c-378a4b8a3d33@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C0lcqzYXTxixPlsKFJGuQAXRW5H25P_q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MSBTYWx0ZWRfX5OT1yrrnWpC/
 qD0tebziljr+TCx5O79kgLS2fj+LIK3CmfVlDj8c+OigIfOiTHKYAtbtSvfna4bLtGU/LRKsYex
 zMIffZOTJz1C9RHsq2MkK3bhwSh+PVc3vSFkKaw1D1TsBF2FBiG7IYLAiqCkODSKnt5Xg6HiUar
 GdEuWCcnn2yWIb+PO9EEqx0CufZ6CKs23SZ+ZsmeY0cJnVXVOHZ3rRzSmgW80y51YohZGwFr3VE
 ahCk89T8+UPW3AvtqCKEINzvY8mvDg+Le5UsQ5iZ4Li0cLNDOuYKR/xf3Ou4woDWfzHKAyyeq/F
 Q0R9IYfgGk05m+QBi8faMsSB71SRX0etO3gLfOiiVEqtysXkEQ8jmCmk35Ms0NVQHpJXJ7NhHO7
 KjJB7CtuSYSIHIwDHqaED5hkT0FM95TcoG0xhk6jWec1WCT3tGTkh5X8CCLuyfZbzJOIkR8fijF
 7vK94JT8QdhVUwTQ7Xw==
X-Authority-Analysis: v=2.4 cv=DsRbOW/+ c=1 sm=1 tr=0 ts=69b3b0be cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Zpc01jWA_6A4uBNqY6kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: C0lcqzYXTxixPlsKFJGuQAXRW5H25P_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130051

Hi Konrad

On 3/11/2026 9:07 PM, Konrad Dybcio wrote:
> On 3/11/26 10:09 AM, Shuai Zhang wrote:
>> When Bluetooth supports both USB and UART, the BT UART driver is
>> always loaded, while USB is hot-pluggable. As a result, when Bluetooth
>> is used over USB, the UART driver still be probed and drive BT_EN low,
>> which causes the Bluetooth device on USB to be disconnected.
> Is bluetooth connected over UART *and* USB simultaneously?
BT uses either UART or USB, never both at the same time.

On platforms supporting both, the UART driver is always probed, while 
USB is hot‑pluggable.

As a result, when BT runs over USB, the UART driver still probes and 
pulls BT_EN low,

unintentionally powering off the USB BT device.

>
>> Configure BT_EN as a GPIO hog so that it is controlled by the platform
> What's "the platform"?

hamoa-evk


>
>> instead of the UART driver, preventing BT over USB from being
>> unintentionally powered down.
>>
>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> index 630642baa435..60a0b3ecbc1b 100644
>> --- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> @@ -647,10 +647,9 @@ wcn7850-pmu {
>>   		vddrfa1p2-supply = <&vreg_wcn_1p9>;
>>   		vddrfa1p8-supply = <&vreg_wcn_1p9>;
>>   
>> -		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
> What if I want to power down Bluetooth now?


It cannot be pulled low because it is not possible to determine whether 
the inserted M.2 card is UART‑based or USB‑based.

Identifying whether the interface is USB or UART would allow control of 
the UART probe accordingly;

however, no reliable solution is available so far. Additional approaches 
are still being explored.


>
>>   		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
>>   
>> -		pinctrl-0 = <&wcn_bt_en>, <&wcn_wlan_en>;
>> +		pinctrl-0 = <&wcn_wlan_en>;
>>   		pinctrl-names = "default";
>>   
>>   		regulators {
>> @@ -1398,11 +1397,12 @@ wcd_default: wcd-reset-n-active-state {
>>   		output-low;
>>   	};
>>   
>> -	wcn_bt_en: wcn-bt-en-state {
>> -		pins = "gpio116";
>> -		function = "gpio";
>> -		drive-strength = <2>;
>> -		bias-disable;
>> +	wcn_bt_en_hog: wcn-bt-en-state-hog {
> This name is illegal (make CHECK_DTBS=1 qcom/hamoa-iot-evk.dtb)


|I will use tlmm to control|


>
>> +		gpio-hog;
>> +		gpios = <116 GPIO_ACTIVE_HIGH>;
>> +		output-high;
>> +		input-disable;
> This property is not allowed for TLMM pins
>
>> +		link-name = "BT_EN";
> This property doesn't exist


I  will remove it;


>
> Konrad


thanks,
Shuai


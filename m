Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492922FDC3E
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763471928; cv=none; b=ENzBMTBXCn/gdvV2HjlPCHkGU0DqVqrGBlHtaBz+jlaGtqZXryrxkFDbKbKWEo454GaoywkpwPyn3i3sKrPmC9YFF8emcnvAJYiHkYklEBQOqMMyrtVMVmLsgHzLrxroA7AZVSKz9LyeLSha19t9IkoK8fqPrpZ4sY+bkO6aJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763471928; c=relaxed/simple;
	bh=u2vHa0N2GrM/Gfb7w7/BVAD+L7hu6GXEgmGEDsZWBK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLz4TX0+LxgSJkIkfPjbRXMMIQ1NqbfriqAA3ntWjsHsaG3N4RiBZHsRN16Wf/jUBV3SwQuz2aQqkrZg+8R3JREGNvPwRRotH/DQ4WNT/ixeAGqff+32EQzydD2rjF+o9ulMCxG66PQalW1XUiBUqJjPPWbRZ+D6T4Tgy0EQeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6U/BYrB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JJ/adGoz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6U/BYrB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JJ/adGoz"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6fOUs2272037
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aav7xLblBgNOadCerIxkavKUB+3nM4sCZ/1UyQhFsXc=; b=Y6U/BYrBqchGWx5W
	oT5goJ7zKfTrrXGH/yOyYp5MXRAn6bu+bryDlOIOIFx5hOceh9WYacCSAWu7IxYb
	cdwdVBY5YIXlYsN+bzuPlbZevA+XmvS2EOFk/F8MHo4xqsj/6p9AQWp2Xu1EpjlD
	ibhA6SMo8+Gcnl7TcDAGfrSBKXv6vo3zmmssAXOeaWVfAgPXKoAsWcu/nF6SduXn
	97FFmMnC7U/rKXkNbValsFhV5onpTsk4siSb9iWTjmkafS1NaLV6MrZV6a9AfD/H
	jg453ho8Y3TXps37xBDfmdow0p7wca00HyJHMS+TtgU0k6wFliymzFIZGWGq3Xv3
	rhNeiQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agkrmh43r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 13:18:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-882416e9d9fso13570876d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 05:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763471923; x=1764076723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aav7xLblBgNOadCerIxkavKUB+3nM4sCZ/1UyQhFsXc=;
        b=JJ/adGozZLN5ZbkQHk+Cf8GOdNLbAOQ/szHHpm7YeBs0lG0HoCCvWrjqWzrq28D0Dy
         wDZ+1YZKwq+vhH+HUP9TNbbHhHVVil4D3sIdF0m++RUT+1znx42g75ngeyiB5Rj6aqnh
         gcYxLzNT0V394Q3Cto1YYN5Ej131XXWLlItFVvFGshxvL8PtHJEN3WqTGz4w6asuKbrM
         rMvbHqzeKnpil5/wchKupLoLJ/yWF898bfb1Gs3BZGxIhDtNKVZFzn1fjeniw6izF78W
         m52CKSvqCHQKLq+Cd/GiA/X3Ow2ihx/b+7B1GcgtTlEKP+A/fcpiFX0JxsMfpn3wmK38
         L3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763471923; x=1764076723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aav7xLblBgNOadCerIxkavKUB+3nM4sCZ/1UyQhFsXc=;
        b=Iw4lmW5Y+qztSut5cWOzDl6/6GV5TjOzdoxXCr7zzWLuRZYde8NKxnKgriGbBWUBrs
         ymcU5ctxvcr1Sc+yjqZScm10AeHx+CJ6Iapu4FTb2Y2ifx4LDfIeo2HENcdKI0T6SRfE
         kWeND4dVBCIVyTlZcIYxwD++8P3q4xdehkYphYIsaF7ZySWdRiOCCyrqUzRhYqQZR6YH
         +wuhlwQFzSRHn4tkJIynyP1pXZdcrKFS3z5w31Ypq5hrKlmcJJqPN8mZdm4wZk70DQMt
         gMGIBI6Js4IFpDOZdDOT4XaxXbth2/suggYghMhCP0vrNoap73l2CfywZYy/FYN5HbsC
         0fWw==
X-Forwarded-Encrypted: i=1; AJvYcCVj4PqcW1JSU+z6aukLP7BGYysQlljZkHzaJsSLaVEcTrjIl4cN4s4EgSKZ1EZE6dJpNfz7IFT+os6ydJSNyc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOQAZ+5w0vlO5Dz5fBwjClpNuf5/qU7DvaedxdmbOMGfm51bw
	mHqwa1jC1t3foFVFFKjWnf4lkSmrJ9IcQKiFbtUcIkUeySmuNhG46CtW4fbDv8bEbTKgsZwDsp4
	BE5tvtlxtjPftW5iG2OxCO4PyE/gylGbjcEc1nAIw0TGHVmK4xdeQfhzf+0qxov80DkSzkLg=
X-Gm-Gg: ASbGncu5WPaEWfvVbf0HbSWVvlDp9gRldEHK8cS6fm0RlMLrBuLDgMGfOufLO0sZDXW
	P3LLEFBMvO+XZMMoGUiEQK4cv9IJbCr1rzZUqUoNLiaIRP2QHZ9OS1tmi4/6+jwtbELQ0/ctwz9
	xfa5OPvug4F4dBzGp4J8wAI6wCH4DIYyIuDc04MU/5OLiYk/fvKdkPYMO7vgBJ2hq4spbbaJ3sZ
	IRemwE4GKeauDfjwvEIRl3y4UiS2U5NQZJdwkOBnUZumHXuoeB9rcsK4ftN8u0w4JoCgkeFmMXC
	HbmPrWEo/prIcIbUlelNPZKLWGchle+e71RbbW6HTFIQ40jiGZv4gOL/YBJyQK2jWZ5tsQ39WyM
	P96P0Aa9JA8y6h86FcyCOWRAJTXWbL5Fvr2B6wxciEryBMO6CEhmLKQy7uKzZYe85u8x2Gw==
X-Received: by 2002:a05:6214:5293:b0:880:4bab:466f with SMTP id 6a1803df08f44-88453a568fcmr25309836d6.0.1763471923387;
        Tue, 18 Nov 2025 05:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYqYNyYlpyKAS/uLzFkpcNv03+YatsNppSG0jkXgvsRgaloSBb8+VMXEFY8ZIBMcGEVBXgLA==
X-Received: by 2002:a05:6214:5293:b0:880:4bab:466f with SMTP id 6a1803df08f44-88453a568fcmr25308716d6.0.1763471921736;
        Tue, 18 Nov 2025 05:18:41 -0800 (PST)
Received: from [10.111.165.185] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828630e991sm114484716d6.15.2025.11.18.05.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 05:18:41 -0800 (PST)
Message-ID: <b47e6b6e-6cec-4470-9bfc-93008bd44a5f@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 21:18:35 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth support
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_jiaymao@quicinc.com,
        quic_chezhou@quicinc.com, quic_shuaz@quicinc.com
References: <20251113130942.2661069-1-wei.deng@oss.qualcomm.com>
 <8f22f268-988b-4504-a4c0-7cc9021dc8c9@kernel.org>
 <26841765-171b-475f-8019-2c349958af7d@kernel.org>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <26841765-171b-475f-8019-2c349958af7d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEwNiBTYWx0ZWRfXy2ae3/nO9mMG
 lz9Sl+QTaxd2uBxYv3ZdRFjSpZGA1OXQnSBsMz5eXKD/Zs7clCPyRJ/LB4lPzdFjFL8ZMgfx60N
 lSQkV6T/v64fpSyu/rf11eKJj3BWQEFr4Xhf6VN9CkKd/s+HTbuoAql2epkXxoAvwiCP2fX8jd1
 hA9YAo+NP9b0a5+XaLVyTKINKIprP2KeoZuB4y4tMop5dk9rEOrdO9+fcQDO5OG/2ZyjYKuX4LD
 46CH8o7eSK5p5sk+/5Q8HZKTUbX33e/IyVEnaBFPvYmRvDvc8aJWZMLQYMHSqRFk1Jyv0zv4I0V
 xttFypoahd3ABtIkxFx3tTX/+jP57GOULMYVswNzmtchRYsH6EQhx8lcqvNhMDcvH1HJmgXQKQ8
 pp/Jt4QFyQMMpkLq4ZIvO2x0ZQ5BYA==
X-Proofpoint-ORIG-GUID: 9xZ8AE7UMm8JSeaF0_7GCQHeqHCDAp1h
X-Proofpoint-GUID: 9xZ8AE7UMm8JSeaF0_7GCQHeqHCDAp1h
X-Authority-Analysis: v=2.4 cv=JfWxbEKV c=1 sm=1 tr=0 ts=691c7235 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=5TMoWVwS_HVFom52XzQA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180106

Hi Krzysztof,
Thanks for your comments.

On 11/13/2025 9:38 PM, Krzysztof Kozlowski wrote:
> On 13/11/2025 14:37, Krzysztof Kozlowski wrote:
>> On 13/11/2025 14:09, Wei Deng wrote:
>>> Enable BT on qcs8300-ride by adding a device tree node for BT.
>>>
>>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>>> ---
>>> This patch depends on:
>>> - WLAN
>>> https://lore.kernel.org/all/20251113055148.2729943-1-wei.zhang@oss.qualcomm.com/
>>
>> And that patch depends on something else.
>>
>> You make it very difficult to review and even more difficult to merge.
>>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 28 +++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>>> index cd8800a59700..08b705fe4eea 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
>>> @@ -18,6 +18,7 @@ / {
>>>  	aliases {
>>>  		serial0 = &uart7;
>>>  		mmc0 = &sdhc_1;
>>
>> There is no such alias?
> 
> Ah there is, found now added by Sayali Lokhande <quic_sayalil@quicinc.com>.
> 
> Anyway, organize your work in reasonable patchsets not 3 or more
> one-patchers spread all over the mailing list.
> 

OK, will re-organize my work in reasonable patchsets. Will send new patch.

> Best regards,
> Krzysztof

-- 
Best Regards,
Wei Deng


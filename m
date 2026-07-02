Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA848BD4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987001; cv=none; b=QXTv+TAyQTVRjpaK3ULBmCFOnYKn4qSz7r9NuEpXhfE8xrZOOZl3m3FsgXSlKt3vlMp99IPKN3p7RlAah9xqMhmrdty3WhdtFHBLwYoGM06BWeTUgngBLNqzX1cxoZ01StJbYaxr/hCZslH6cjHWysk7xYufT2+90iiU+jawGvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987001; c=relaxed/simple;
	bh=XGpnaKbkzUa2p3KOJeURMXlv+E7yeceJMBpe/i+afX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+ei1k+KdSgHCj825aTvi+iesyW5bGXfYxVoJ+u7qWv7z4DlYxCD3lgdAUPE9pM3k68PZ8bQwCfGSPk85Pjc6MMrRDRzP6wU9AVM9gErwAO92e6010T0cApk1r5HIAJW8DW9C7VUJKAtaUPC5pnp26CxRfC5QzG7K7VxlCtQsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+/rs3Mz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7mARuup; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+/rs3Mz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7mARuup"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nPST4139534
	for <linux-bluetooth@vger.kernel.org>; Thu, 2 Jul 2026 10:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3SiEZ9xl+02b9shIMVkNO87y8eMfhcAz2ipEbxm25/c=; b=E+/rs3MzCH9NHvNe
	otUuXRD39oCtLyesfeGCpu3HCPXw3Y28nSlRaHiM6rGOQudjEiLTFPL0ENG3rdH4
	XPwEmbJ0F9XSEp932E6ucZ1TSZtOT/8vcEN1h7cLsyoqyC/WcmOf5qoxtjqr3Ad0
	3v4whlrnN2yQxMoK//WwW5Adz00VXGM/A858Ol68BmB8eTjc8T2jJBU/MdlWorBR
	ZiIL11V4mWSQoJntBZuXT9UxSj8+fAWkwe3NSPJPX4YSKLq/aDTEH+fKEtRp300f
	203mi3OKpszN6KntaqFyVzrarScL68CORcl3lCHyN2wuEgsotTLSL+/NIZZ4f3/H
	LuGYpg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr82pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 10:09:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c9b1b608e2so28860245ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782986999; x=1783591799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SiEZ9xl+02b9shIMVkNO87y8eMfhcAz2ipEbxm25/c=;
        b=D7mARuupxCNszz44QiNkKuqj5KgeADPVqGEOmRXcq7nIAq8EkZUGW7oA9FVeS7JkIj
         rs/OCEbdEn0eW6WC4mMCLDavdBk9ltoJOEXlZce84mnb+bfZfxFOJx+NVH9pdiKRE2Rt
         /eBY4I+0kynuDQ7aPN2aO6jpFUfe8Lirr4dH0lvr8spoThjbVbjpmdoE4H8T+rV7hlni
         m66cAFKr6eEOj0VcR5OJqiXwYPY9X1JgK6a2XaQwhlteeFFvYdlFU0TRbL4/M9a4j5RV
         wcjNPbe4dutTy1NZR0/1me8ljfmWP85zzZS21FYngnP+Acow7L6V4iVJuC+uTe3SCIM6
         jk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782986999; x=1783591799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SiEZ9xl+02b9shIMVkNO87y8eMfhcAz2ipEbxm25/c=;
        b=eO6vF0Ar3+ug2JSIAlhqEoKwpJQ5et7RrWSh376oc/mlSypSJttpaE3+GQqclR6nhA
         gEWpATGAc0KN8XrA2LckpLDv2013pVge2bKvHghOIqn2Dq2p/Xuq2MSQFgW6N2tNujkT
         h7GlXKUlBi2xCC28r32N8Pm3+cZnzXfGr6Kr9xjLcI3pFWHLPY4xTeSOFy/z82p565PZ
         usTiQAzGBqIuVj8ovg/7AqHerjqNDH5IIS63qcv3KkzXCokwn6NMAKyVDQB+sG7h9PRm
         iPqF9tSuwbqW788sFpSBmtabTiqL5CbWPj0XmuHdyDwUFDvDPRBKfz7SwumiPjm5GATc
         yrLA==
X-Forwarded-Encrypted: i=1; AHgh+RqX0M63gtZRynDCngyQNLktpaE/zlda1crVsHT4rh+P193G63IRvLlCgVXvkrb9M4MDZ7GvmaDSXZtmEikK4Js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xhmfvjugiPEDkwO4gim//mamq7GbiV6VQJph8QAsz+V0VwBX
	NUC96W3/myftUoOzeSmdlr52zDJF+fOgYWufvt0BMyxI2fUELvxyBx9av1d9HtP6YtkzooCrzA7
	t9sns6NozlLjC5WKIHXLVHrp6Dzmj7pyjCCdH+q2pD4F7GeAyRWdVpWchZQeleCRcjCW3nX8=
X-Gm-Gg: AfdE7clNNbqGtZ7qzRktCPwvLj85xr8L7ZBlN8J6FCLTScJmW6qtPCZJv1RTkcz6MJT
	7MHQwSGL435oM9kmpBDTHzIOMCpfOuSeIbjnYFND2ue40mfd+wTeSenFzwfv8y+StzKC1NbzI52
	W8VNDg5AesNk/5hpjNCnKS0QQNBZNdJ38cE9Sv7GbgXB9jRy0nJEpWQgdY9kc1kFPyyXLebPu1G
	1Qrpad7JmG473SI+fd13jKiCg/AbanM5Odzkp3Isl4KwWAt+DKIKEZX2q5S3o9CwTaVIVoPoRKS
	VE8ljdp5CGxoJYdCpLlmZBijx3j4GCvPYzuDs7/ZqymFQXGuBwRQ7sabYgsvVJmYyCMmUhGPX5W
	DoE+pfU93gQ0RmqWRZXW60QmnknjAmn4InfkLknJr
X-Received: by 2002:a17:902:cccf:b0:2ca:329:3da0 with SMTP id d9443c01a7336-2ca7e682ae3mr57362215ad.3.1782986998731;
        Thu, 02 Jul 2026 03:09:58 -0700 (PDT)
X-Received: by 2002:a17:902:cccf:b0:2ca:329:3da0 with SMTP id d9443c01a7336-2ca7e682ae3mr57361885ad.3.1782986998206;
        Thu, 02 Jul 2026 03:09:58 -0700 (PDT)
Received: from [10.218.39.201] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8fc200sm11364315ad.19.2026.07.02.03.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:09:57 -0700 (PDT)
Message-ID: <fbd3c1d6-2142-4268-b88d-898850b0e5fe@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:39:33 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings
 for QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, rahul.samana@oss.qualcomm.com,
        harshitha.reddy@oss.qualcomm.com, dishank.garg@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com>
 <20260530-funky-mackerel-of-current-878e2a@quoll>
 <6c06e372-85b4-4207-9bb6-270bd654c287@oss.qualcomm.com>
 <mcn4ysrxrfqo36tr7khsxnjase3priskimkgxuacgma7jcpa46@bgla2znqhyfl>
 <9448dfe8-4d9d-4344-be2b-ace371c37975@kernel.org>
Content-Language: en-US
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
In-Reply-To: <9448dfe8-4d9d-4344-be2b-ace371c37975@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Bt5dmQUnTjy2uJITVEDCCsobp-BKd8MQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwNSBTYWx0ZWRfX8McG0ja96MFR
 5Ei6zpUWKZJhbZIhp4eyIbkPrMPkM/xl3Un7mkYhxNU5GXayFrmu0hEOPFstpx45tSpKU7ov+2Z
 DSp48kg5GOHGuUxa6gLhzK5H94L3G3g=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a4638f7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=opGXe0OTB6Gl6oJtH14A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Bt5dmQUnTjy2uJITVEDCCsobp-BKd8MQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwNSBTYWx0ZWRfX7JSSZ3rboeKL
 RhsXdZCvfWSnQ9ZxeeBrlMKmf3zFL4IRtBbK+abTyaNjKoZ+t/stsQ9Pl7M5CqjecC52wI03pmL
 5+qUgGXjJgjcCMz9VupCzJsYE0COUp0dT9jcfu8nVAID03WLdGz9YqGCQqLS9MX9IwxKTc6KRto
 NlqzRHNObmSxKtk5kCTlT5iiW9sMzM3iPHrtWbbKBm9ULZTVH8pCVYDY56cgBYADDr8wEEKAY8w
 hGNKVnm2Ze76i0EOWDnK2VfbdpT9p7Qhytu2fYwDMjam28xK0Q31tWF/AxRPo0ALHr2sqSd8siQ
 zINXK2BwbFw3bfEocvfog5Zx4LH5kmXQRK3B5MtPzTmDwI2LoRUPEyXJ1qi54OrkXWMORvQ9hJH
 vvpQZ2A05kMErJUUPSlnz4VYo18E3WUbELCTpCbTamcqmJt/iu2zXCYEqlVQi2Pklc1td7Tpriz
 ryjmWCUlnXNGYi37c4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020105



On 6/1/2026 1:49 PM, Krzysztof Kozlowski wrote:
> On 01/06/2026 09:52, Dmitry Baryshkov wrote:
>> On Mon, Jun 01, 2026 at 12:50:00PM +0530, Yepuri Siddu wrote:
>>>
>>>
>>> On 5/30/2026 6:04 PM, Krzysztof Kozlowski wrote:
>>>> On Fri, May 29, 2026 at 11:23:42PM +0530, Yepuri Siddu wrote:
>>>>> Document the YAML binding schema for the Qualcomm QCC2072 UART-based
>>>>> Bluetooth controller.
>>>>
>>>> Where is the rest?
>>>>
> 
> I repeat the question.
> 
> 
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - qcom,qcc2072-bt
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +
>>>>
>>>> Looks heavily incomplete. Devices do not work without power for example.
>>>
>>> The module receives power through the M.2 edge connector and manages its
>>> own power sequencing internally. Unlike bare Qualcomm Bluetooth SoCs, it
>>> requires no external voltage regulators, enable GPIOs, or clock supply
>>> from the host, so no power-related properties are needed in the binding.
>>
>> If this is a purely M.2 device, then it should not be a part of DT.
>>
> 
> Exactly. And even PCI devices need power sequencing, unless this is a
> simple (BT only) device.
> 

QCC2072 is an M.2 E-key chip. As M.2 Power Sequencing changes are being 
upstreamed, we will reupdate our existing patches to align with M.2 
power sequencing approach.
This includes aligning the bindings, DT and also BT driver changes.

Thanks,
Siddu

> Best regards,
> Krzysztof


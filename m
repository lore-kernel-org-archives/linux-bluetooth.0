Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B3367F44
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666396; cv=none; b=q706bVn/paxXkJkvJ6wHflV3S/kHezqU5NfV9iJCFJWA0qvw2UnsLM6NcmoGJZCvWGCrgrHGl9u8F1luPFot5o3+4jwgHe5PWpDhgj9Vx8W1BlS9Ny6U21s7K5RplxGLjAuk4Cm36yySii/XmxH/uzm8TOrgFs0UF3Uj1grNb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666396; c=relaxed/simple;
	bh=iQIRxC59jsCtUUev3q4ukw7SPqloSvC2P9snWv9dK8U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p18CCSKTv7YnuR1GLyBZO9jegsTUGMxiLVVfGTkZOyil2DQmuHb8G7PFw5ZEvTSEahhyRVCp0Q6ofD7PEYc3HBdCFe1tCD20sQfgm57s0s0hkYYEh5q5pEsCWz9gheyFfMr+6Xz8uQu2uunIUgOuXZj4JquJ6oct9JwMyKrw0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9VHpPWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c6HJnP0v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9VHpPWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c6HJnP0v"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2oxbd2033509
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bIAmugmdeE6Ey5gFhbPBTRkR0fme+bf1kupAQ5YM7yM=; b=j9VHpPWKYnLVo7vl
	k0NdKRcdbD1Nhty66HpVYlkOIO54ugeVmsMOnWXVsdFqEp7hLfkDzyBbm2kqx/QH
	27AP4BYmvI6e4xZ5gpsZJ2nsDvNyNdQKPGzBfRIUzKH8olVJzPMwbBOfX6sfnk26
	F6HqdoOKG9doeti1gbS5MXHDjll4wAfSEzTDHDrxYqModtaJwdee3r8OZXv/2a3f
	pvSTbzMVnwU8CBYLKlk7lBV0YZba8Yd6Z+Uy1WxzoHxc4WK159gSlJihsXov6ND3
	/81BNPRtHzn3TG7RzEHJ3oWeOYzfFtJNYqCA+PPWqP8hoNUo4QW4yTgQLrmbML9p
	/DJa0A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bytqy17d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:59:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a13be531b2so5893165ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 21:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769666392; x=1770271192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bIAmugmdeE6Ey5gFhbPBTRkR0fme+bf1kupAQ5YM7yM=;
        b=c6HJnP0vCFhIpc65uN295Dmj6llNtv8FEAU8x0UkiaIP5Qh/D+4tyPrG/ZndayBsBh
         3g1bLxUNBKGPTezMirLA12juyYGUlyh7IRlBHCoe1ELwemBrtVRkS+JeE4HZYVxbtqDR
         GoW1qXAOXKo1tBzzJesf4pPj3eJxVFtx11zu/h7w/lfjJBMKbUb74lOKGr1RLXlRmCjk
         4lvtSr5uDdLhi+bZ1HEvoS+EqpP4eeXpI5xojo16bDJe/3lddixYDhFKaM7bORJ6nuWQ
         TfdXdxFOETb57s5GE33enDVvOS55b7OkcVqRbZcXYWGheud0x6GfNgovDXJYW0TPUcjf
         ViXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769666392; x=1770271192;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIAmugmdeE6Ey5gFhbPBTRkR0fme+bf1kupAQ5YM7yM=;
        b=iCvx0Fm+fKLjbHgMz2tJuJJDRXTfgd2LAJ6NqMrYCxU5dUf/kRTCo2RUp9rAGjH1br
         cXibBPOZ7ZD0cdeQCDVTzH9QPHrpjGOvIi+UKj+ejLxlfqCY49NuGNukzEcFJZIqubRX
         omxThWCdStHmYJP7y/LxDG8FsBpWZ9nkvcbhgZ1iUs2lfcFwfKvJpKaeQM5W6VU5LqAr
         p3dvkLVM//WitIiRcrlQDfVL5M9yYCjdJvNbUTkfsss9BjLVBwgfNPWOu3zJV5mEZpNw
         wxON3Pf7V0cM7sTMnPKglxEmn3vnQfohubk66HitmJ0bOzBDnJRz+IuDHCUHZWD0BXp3
         G4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWftZH56LADLlGOJ0vFJqoGSoIyEkhitlpsnhFtaNwtN/3bKx+E4AmV1vGa50enMoZULay7xm80MUZTvXjw7TE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIq1CbpMscOvr5qEqtG/gT2RraeHRTixra1RmhxdCIQU39skV
	rzhvHKYONmxGHchsgdCntI0hvUbYKPuCDxkt4PB4zRTB01kGKTaHW7nwNWo61nV/hqUn/+wewoH
	irS1kemhilfGFtFPL9tkBci88KtCbL+H6LrlFF++DIapwFO8F7gUPVToXJXAGVWoz5GrfBlY=
X-Gm-Gg: AZuq6aKNMmsZJWIGKwsGG7To2TKmMspOtMVVLD0YV+Ii+bEax9Yl4v1TTUjzeaSZaxi
	VqHmDvZq/Vc8yEBR818eS0rdW2DV9XHbpZOM2PRqXuQg+SmeOky4xPO8WK5GMPlqzXzCJJrP+FF
	GYWSHwWJDZMSBJUGtNekWUO9Rmt1fpxKN0RaWhXvD9MYbr19RBbkO7+XN67gIORb4GlJWWFJVLo
	V799blafzYfjxE5MIg+k/W57pn8RGpTkQZGBkh6kzNGMafCkElJ4Vgp9iQ9L0woZQz3jv+G3S43
	6uzQAkBnevjCun8mUJRAl5tScFztXrV33+t0duDb/HoHa0bk0pVxxqyFivz+Y6rez+XixyYV8rJ
	tqeE4CIMiYP+mhgPWIBJ/DqkbOhH00RVd0pN4
X-Received: by 2002:a17:902:ea0c:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2a870d59351mr78348625ad.6.1769666391636;
        Wed, 28 Jan 2026 21:59:51 -0800 (PST)
X-Received: by 2002:a17:902:ea0c:b0:27e:ec72:f67 with SMTP id d9443c01a7336-2a870d59351mr78348255ad.6.1769666391141;
        Wed, 28 Jan 2026 21:59:51 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm41926115ad.93.2026.01.28.21.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:59:50 -0800 (PST)
Message-ID: <fdc9cc27-aa12-4b62-bece-8bcc8c680ace@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 11:29:45 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] DT: add bindings for QCC2072 Add DT compatible string
 "qcom,qcc2072-bt" to yaml file.
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Balakrishna Godavarthi (QUIC)" <quic_bgodavar@quicinc.com>,
        "Rocky Liao (QUIC)" <quic_rjliao@quicinc.com>,
        "Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>,
        "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
References: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
 <d180711b-7957-4252-b34b-81312705555b@molgen.mpg.de>
 <BY5PR02MB6946637904902544E6767829F189A@BY5PR02MB6946.namprd02.prod.outlook.com>
 <279d96ed-865c-4f15-a67c-ee1a94ea2c3e@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <279d96ed-865c-4f15-a67c-ee1a94ea2c3e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzNSBTYWx0ZWRfX/BgqprIR9aPs
 CBKoByjPgF0wcz5i+tS5OfPPXIL8+SFy+8Xm3wkuNfoUmfbsCeBK97Wed7H6w/NE9PMFArdMhsD
 XgIlEK31ABRoWMzs6bMb1YJSpa4VjcWC/iEjHp3OdsEAwIoKxrrahuScbbj1lXmiJHnKqw/OZuV
 gzrRdcUQ54XpgNk/1miyZN/IKWG6yhgKsef6qaBkIpzi8UvGsK3huVZXVKqcYlq7eXvuBvowWia
 btEa2miuGnxOktyUwGGRrvb/prLkslG061GYzAZIuEk8j5mrTav9Et4Kre5lolrQYlvsRxzBmLx
 opSBeaggxfwTX/EaCSSvPmncvgHaoaAW9FKafn/Jno863l3/F+nBA62GIAXivg0Y3OgnU7UWD46
 WXU727fMFKUxu1IeLyOQAg7wN6AJIL+6TEYzoLijukeG6XVtsSziH6cATGQSXUjqsyUF7LQWxLs
 0C2F1UXOJ+zu6eQhpgQ==
X-Authority-Analysis: v=2.4 cv=Je2xbEKV c=1 sm=1 tr=0 ts=697af758 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=9EePW-ua0pc5qcVAYZwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=M-Yerj1wOn-OpK7r_3ei:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZJiLxgrYaUuAm8Ns4YFXn20oAYW7w1Rd
X-Proofpoint-GUID: ZJiLxgrYaUuAm8Ns4YFXn20oAYW7w1Rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290035


On 1/20/2026 3:38 PM, Vivek Sahu wrote:
>> ________________________________
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: 17 December 2025 19:44
>> To: Vivek Sahu <vivesahu@qti.qualcomm.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz 
>> <luiz.dentz@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof 
>> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; 
>> Bartosz Golaszewski <brgl@bgdev.pl>; Balakrishna Godavarthi (QUIC) 
>> <quic_bgodavar@quicinc.com>; Rocky Liao (QUIC) 
>> <quic_rjliao@quicinc.com>; Mohammed Sameer Mulla (QUIC) 
>> <quic_mohamull@quicinc.com>; Harish Bandi (QUIC) 
>> <quic_hbandi@quicinc.com>; linux-bluetooth@vger.kernel.org 
>> <linux-bluetooth@vger.kernel.org>; devicetree@vger.kernel.org 
>> <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org 
>> <linux-kernel@vger.kernel.org>; linux-arm-msm@vger.kernel.org 
>> <linux-arm-msm@vger.kernel.org>
>> Subject: Re: [PATCH 1/2] DT: add bindings for QCC2072 Add DT 
>> compatible string "qcom,qcc2072-bt" to yaml file.
>>
>> WARNING: This email originated from outside of Qualcomm. Please be 
>> wary of any links or attachments, and do not enable macros.
>>
>> Dear Vivek,
>>
>>
>> Thank you for your patch. The formatting is off, and the summary/title
>> (subject) has two statements – look yourself in the archive [1]. Also
>> the prefix seems wrong.
>>
>> Am 17.12.25 um 12:28 schrieb Vivek Kumar Sahu:
>>> Signed-off-by: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>
>> Please elaborate by giving more context, why it is compatible, and I’d
>> like to see how you tested this.
>
> The compatible string "qcom,qcc2072-bt" is defined in target dtsi file 
> and it was tested on the hardware. The corresponding target specific 
> dtsi file is currently merged in downstream.
Please let me know if above statement gets you the answer of your question.
>
>>
>>> ---
>>> .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml 
>>> b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml 
>>>
>>> index 6353a336f382..197248d6f7b8 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>>> +++ 
>>> b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>>> @@ -28,6 +28,7 @@ properties:
>>>          - qcom,wcn6750-bt
>>>          - qcom,wcn6855-bt
>>>          - qcom,wcn7850-bt
>>> +      - qcom,qcc2072-bt
>> Lacking more lines, I am not certain, but I maybe this should be sorted.
> I'll address it in next patch of this commit.
I just checked that "qca_btsoc_type" enum contains all the soc type 
which need to be enabled

for BT enablement on the target device. There are few places where logic 
of framing packets transferring

between SoC  and Host depends on the which generation of the chip it is, 
refer api "qca_read_soc_version".

Do you still suggest to sort it here ?

>>
>>>      enable-gpios:
>>>        maxItems: 1
>>
>> Kind regards,
>>
>> Paul
>>
>>
>> [1]:
>> https://lore.kernel.org/all/20251217112850.520572-1-vivesahu@qti.qualcomm.com/ 
>>

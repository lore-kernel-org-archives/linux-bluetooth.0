Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB42443A83
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513113; cv=none; b=MKtRYCLv8XS90BxO7h9ETJ9Vv6OdoWAHiJrafV15cTmTsLCiVRPVFAAO1VMWEC8aw/GGAsoX4uCek+ORt669toGQz+WPkwIcyjCrNUnZoCb0nFm1XC7FVoh+OiomkZ3/FiVeDFXHI3DN5fo3P4lrdgZeXceC6kGp1gqkIKNLzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513113; c=relaxed/simple;
	bh=Ke0LS3rjOyacmL/2Ljca8GlNVK+OSTiqtU8XN2ScZFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXlY+YHrvDePEGgnWtiu1vemAOzePbARC6uWx51zOweYlDnTsH+4PSYopbc2jwaspaT2nJe5SGn2AL7QcEu3D68k4JP5fMGWTfdE0oPdkUhUqfC0+4VHoW5E5Qu2kG9vHQ3FDZhcyvxORK+qCluTbqwcG4AvnwTBN76ihuVlIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OrYDzGi6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KbitnMvY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OrYDzGi6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KbitnMvY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOcxX206235
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dx/1EpRGGyRtaev6kJtjhh1/W+ifVv+QJ9YIOAi4Sow=; b=OrYDzGi6C3YvoKJi
	JCfWGY1rToaOWRPpInKhAXtyKZSxb4iGQC5e3A21Q8u52plnR0afeH3f/t7nO1Dq
	pvagzn0sq+wr5sYJb5gx+ZKeRVfFRLjsNoLJADGkgd182C3XiQPdAWrt4qIxpjNo
	+wmihVrBO8qvCSHjTIC6bwj9qJZXN3wKLSGd5fqTpZaHLGes/+NMgKulGmTqfAUr
	ckWWrCWTqfWppW+6w+Ug/I+0ipU7MHO48iYUaeKAst/b6eHScanTM0CsIYqQzTT1
	kUuXSQZd9uG2ifEwnMpC6zMfdzstmYBSdegLRcGKg7lIOGZi8kfuV41fZmDx0fDQ
	+OTZJg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dh34y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:51:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so1696423a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785513108; x=1786117908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dx/1EpRGGyRtaev6kJtjhh1/W+ifVv+QJ9YIOAi4Sow=;
        b=KbitnMvYVsv6pulEsoGYPCAa1AYaa+mMSrxl2JOut4OD7EA7/0QIgC3apdG/jkAY9C
         m5Ig2B5d53v7EUsUHGbcId3pbA5dLpC+ydDtP13IXNMSs36oA9QgGg+cpcKgpU851WH8
         EVpMdVXIToRYcaSGGeyN3NqhWNIqYPtgGJ5ng+zLdrpulQ+dXXPAUulhYZxVwHq3F6Dr
         2Y4KpkzTdI2xairzhieZENoE7O3ShEqXcAOFt/Te+Ym2kE1TB5WiHdG+Sdfj2mDozFV5
         BVK4T4HGbsjFIYFDGYNyiOZckRUnJMp1uFJSosm3wSLRd7oVmgy9XvV+7DGdP2I0HeIF
         idnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513108; x=1786117908;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dx/1EpRGGyRtaev6kJtjhh1/W+ifVv+QJ9YIOAi4Sow=;
        b=gmwKib9W2lvzVrcGfSwZoW4U74w6NKAddHXbD+T5GYeAOUbVXEMPqWuPzQ4RI1uZxP
         9eMI4JvspFIiNjcem/JntwnSkMbP7x1VWcvuEVkPwBq3rNbNtXu36Mj6GPTv8fWrsIzb
         6a5LtcJadcUUi7Zm/DBxrVoZIScb282gnNxpS2HfU1vhjH0nfFC5GKV3CxOlvQYDo7iI
         w3WG55QOKYt+RYw2FL+E9QwnMK66c1+tUYWki5Q5EITWTfw7zKBEJUNLZqEfek40rKji
         oAVIIwRf4atWiY8w6XFEPqBCQscY7Hsi95K+W/TSacm8eUYiNFNTNfFVyg4qO1DvecFa
         mWng==
X-Forwarded-Encrypted: i=1; AHgh+RrUBfLuT3yWvaQ7hz2FFc6NdOcObql+Xa7PnjpUD+dchQM1Iv2N6Zk9VSthTH0hFsr3G/woWr/rgdv/TqpW0ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqI71MEM+O9ydPpS/j72gPgT1eGZebbOSrPWwcgQ31+5iWZTce
	tCqUcW1SeE71vxslkJ7lxqjNAzir9aG1bY9NLz84A0V7LDTO0Do63cc3tpdW7z08fRsQsMn8UgM
	XpqcbywG39x1RsGhPD2egw862n9WQ5qApMardxRSOiNPhmtYuQYCmI+Yh3qemU75+JuBoQ0A=
X-Gm-Gg: AR+sD12L67D6XyVR2jMwRPLT6qH9o1W4QN/hcZudLUsErpUz0YNLmgHJpgU0CD1rRzA
	2yf67bFirLdDI9Ery0JWUcCm8ODWaCz744i0mz3boOyfz8VYXSbTo+X4l5Y26+0yySTeIBaXwdO
	lpNY9hBntQXm2cwGsyYxIyEp4iXSxtiHh4hid3zwpiwDm61lQvRc9b7a+O0+u9f4a15PrmDcnxH
	w52ADH6QoNmsCVXwK3iaWXbIkR/XPCJStJDB9UdO0CRBQrF3cnGyrirnnPtjmFXoqx5IkHXa5xL
	mj0JdXCzI3TvO0f4F4EihmBDJQVXYkGqs4zJ9yd6yHDLrAGpEhqousoYt7WedihDrwX/xLfOxzL
	1uwTwxS27h+6nI4wcGEemO3VARhwW2NXM
X-Received: by 2002:a17:90b:57e6:b0:381:85c0:1d9d with SMTP id 98e67ed59e1d1-38fbc4e591dmr376395a91.27.1785513108184;
        Fri, 31 Jul 2026 08:51:48 -0700 (PDT)
X-Received: by 2002:a17:90b:57e6:b0:381:85c0:1d9d with SMTP id 98e67ed59e1d1-38fbc4e591dmr376364a91.27.1785513107655;
        Fri, 31 Jul 2026 08:51:47 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab14475asm4577282c88.5.2026.07.31.08.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:51:47 -0700 (PDT)
Message-ID: <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 21:21:39 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
 <20260731-first-righteous-bear-dd72ed@quoll>
 <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
 <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SAVlgLOiB1u9LKuaDUfh-dS7i0tvbqXo
X-Proofpoint-GUID: SAVlgLOiB1u9LKuaDUfh-dS7i0tvbqXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEyMSBTYWx0ZWRfXw8QZH7/CZk8X
 0QD6GE09eILpG99br+oFrFI3L1zXor5WDpJ1p+gDX3RagNGyKGrryBaQMYrvbbi9mA2cMsTpy+I
 7W3ko+kiJaXECNoVjg25mMyd7ovZzstFXedbv9eG/Cx5cSWQ9XvOOJqXcDNGb4qd+xQk6xDak+V
 G5WbyBFnXe43vktc9xLhDh2Ek+87SVmokjbMpCZxFmiRxT4HuKw5hkEUI4uYaioY/Z6tCoZiPcL
 ETkS/x9bxM5+49yhU9NV+Zr0dVa4DihKs6QCmK4fHU/yo8WDNm5yCkJ26eNDLX1cIIzbma8YLyZ
 5Z1yumN7lyHZYR1Ic1SLXnXZfZwc4nibDIf58IZ0e6SPMr579iPiRVkYPQVDLbvke/LqMAa3xOt
 PMH17cd53piLmBdILWnCSLI/0xxvkMcBLJFRMN+Ma7X583XgPrWi3ST/2NiWFn9f8F7jAAcSetf
 sLGhI4eaKRpjFMcs8Aw==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6cc495 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=v5cH2FmtzX6wFw8OzbkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEyMSBTYWx0ZWRfX8GAJ8ZPwoGxf
 KCAboho18bpJRoXAQsdrClKzR2lePgRSmP89QMCEFyfWqRocWc5IeitVZnV1USzgWqJ+XT0IpBA
 trl1TTdZS/VDptxZYNZ+npW3VDDljwY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310121



On 31-07-2026 20:34, Krzysztof Kozlowski wrote:
> On 31/07/2026 16:45, Rahul Samana wrote:
>>
>>
>> On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
>>> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
>>>> QCC2072 can be used on M.2 E-key cards where the card power resources are
>>>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
>>>> sequencing provider creates the Bluetooth serdev child after matching the
>>>> QCC2072 PCI function.
>>>>
>>>> Integrated non-M.2 designs need board-specific power resources. Document
>>>> only the compatible for now and leave those properties to be added with
>>>> matching driver support.
>>>>
>>>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
>>>> controllers connected over UART.
>>>>
>>>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
>>>
>>> NAK, exactly same comments as before.
>>>
>>> Nothing got improved, although what is weird - original SoB is gone, so
>>> this is legally dubious work.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hi Krzysztof,
>>
>> Thanks for the review.
>>
>> For the binding contents, I tried to capture the current scope in the binding
>> description itself. This series supports QCC2072 only as an M.2 E-key card,
>> where the card power resources are described by the pcie-m2-e-connector node
>> and the M.2 pwrseq provider creates the Bluetooth serdev child.
>>
>> The binding also says:
>>
>>   Integrated non-M.2 designs require board-specific power resources. Those
>>   properties, together with a static devicetree example, should be added when
>>   integrated non-M.2 support is added.
> 
> Bindings must be complete and your driver support is irrelevant here.
> 
> If you claim this is a PCI device thus you do not need any resources,
> then the binding is not needed either. PCI devices are enumerable. And
> to prove it: look at your DTS. Do you see qcom,qcc2072-bt being used? No.
> 
>>
>> We do not currently have an integrated non-M.2 QCC2072 design, so I do not
>> have board-specific regulator supplies to document for that topology.
>>
>> Could you please suggest how you would prefer this binding to be handled for
>> the current M.2-only use case? 
> 
> Drop the binding, you do not need it.
> 
> Anyway the problem is that more comments were ignored.
> 

Hi Krzysztof,

Just to clarify the reason for adding this binding in v2: 
v1 did not add a binding because this series only targets the M.2 use case.

I added the minimal binding in v2 because checkpatch reported
qcom,qcc2072-bt as an undocumented compatible, and I interpreted the request
to fix the checkpatch warnings as requiring this compatible to be documented.
I also had the earlier feedback in mind, where the indirect
qcom,qcc2072-bt compatible was pushed back because it was undocumented:

https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/

Based on your clarification here, I will drop the binding patch in v3 and
keep qcom,qcc2072-bt only as the pwrseq-created child compatible for this
M.2 case.

> And why this is sent so many times?
> 
> https://lore.kernel.org/all/20260218114955.3970974-2-vivek.sahu@oss.qualcomm.com/
> 
> https://lore.kernel.org/all/20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com/
> 
> and now by you.
> 
> How many times this will be sent in separate patchsets and asking for
> separate review ignoring previous review?
> 

Regarding the repeated submissions, the reason for carrying this forward from
the earlier QCC2072 work is documented in the cover letter. This series was
intended to continue that work for the RB3 Gen 2 Industrial M.2 use case, not
to ignore the earlier reviews. 

Regards,
Rahul

> Best regards,
> Krzysztof


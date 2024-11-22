Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EDA1D86C4
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280915; cv=none; b=t4O/McF7RH3mFrKVRhN3YsnFmQduGObcYauXtMcspqA0EhHlPbpjGHNWm9za0EnmZpuekYyk3FqkSgWLdzne9O4M+wxee00Y7P6f/01p7nwiRRnBommYdI9onnoHW7bLqYnxLo46BsBjMpWAmpGXzCxZfGAZ6oXm8wwPNlbfItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280915; c=relaxed/simple;
	bh=8zfgkMOB71xvZWMcB6lgkVdCix5c+VyWkiNbl8wuEYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnaMy0tzj1UHUij1VHrtFpoJe2XE4V9D7yi8U9uErsY5e4QU+U7lVUFU6jK8BXBLPIMx1IOGM8uKfIr81qbnA6VcHHMJadGXP/EVmcF8i+LR1jn4ysXRc3SM1rMGqfwrKctwLTC8Cm89rC/AtMM+/LVTSTSjed9v3hhMKIZKmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WaG0JXXO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WaG0JXXO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM6HkmZ007165
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 13:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b3r6S/P72MB1YXDPyc+d2GlJ4kjhnFJ66UPTclc/4bI=; b=WaG0JXXO8wZvJMLk
	cSOf4jtjbXR3WTSPii3ruWrAG7WTbY/XUkstk2fnHX8zCYWGZn69KrJq/94nKwil
	Beh6eEABFkkY52TfojsdO+7a+7SYg/fbYJmOC/Dybzgn4XTCJZ6bJ6j5JZiSR419
	9lOJsfyw54y3FaOnJEzzLKTHRToa8mWb1gWtGb2nuU3fqael2hNpNOVOACKhMSd4
	9Ild67borkGsZHm4IqNXZYNdGUx552i5CvuEPDxarnjgKb2NjYENyazuPR8kS8WH
	2H6C/E/NfYz1pb7nbWx4/8JvTRf2u9XSrjCPyLoevl4jlGRP3sIMWtq1rl29xlwl
	sKIWBQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432mjh90t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 13:08:32 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d41f5ab991so4561956d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 05:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280912; x=1732885712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3r6S/P72MB1YXDPyc+d2GlJ4kjhnFJ66UPTclc/4bI=;
        b=Z8WQYPBwygWdOlflTM+sB+Ih4EOYRvAtXBasYQi8z9j06lCRdrdmHHGD4n1clZ4sv/
         +CCfUOKO8AMJQWMXnLmoFCG6dK+yBJ09TTh71yh1TmS0+niYjMvxhiY1K+Du1RFDz+Ng
         8jdZP1d74o/4zg6N2rABzKSa2WDj2zT/1Y4OJ1mr7rh43APk8MTQMYkz9YsXoN1CEeko
         v/QuN9zsMHDxlWCKwjWgIcCs4nMcoTt1ahbm0vvYM6CV0HKtGcovDD2VbAD/zY1Z0/a+
         XSerCrJuRa3rCxeRO4a1CZ4BvxAmdWeC9d2imRJo/GDHzTr+yw+aDh5aO202e4LnqRaP
         QyTg==
X-Gm-Message-State: AOJu0Yw0+21MKla9ndgTD34U58rcd5AR1vV7zn11z2GUMin9OzcHOx7A
	StW5J4XVAfLT0G1K+mclw1K4tuNVyZQdzFFToCnHRYZdz9nXMSCPM/CUaPDwRZbpQTRUXHO2DXu
	yiu2bfGJAkMa5lTBhQ7ZvqmPA4xroOaakKeqlNsrYsYPSTO1Ds0cSfuwzjBuWvXC6GRQ=
X-Gm-Gg: ASbGncsK3neAZ4JRmleJcwnYyb5reepvatIAAgD2V6cEPsxc1SmZPCjpwsXsJTlY3nx
	Y2GVdrdMtifKRoTA3Z0XzYxAoys/OFThYIJHPd5B7SJZIV5ewi/OJM/IfGpcK96QsOuf18rMH2N
	Tsi9TJQ5NMTyhMHSvdX8b7fDX6JZe/8WT1OqQVkt29FMh4v9ox2Bn94Vsf27x3GiJ2SfsYNQHOk
	G1eDRaYH2rbergQk6XVVhkrD6rubdoiMHuV+XdG2fmXv6DzVezs/cqvizgPqx+aRq5sQr5Y8Qqq
	3MIM11WaZ0ymIjq3lBBQcwzZDMTAIGk=
X-Received: by 2002:a05:620a:1a04:b0:7b1:444a:b679 with SMTP id af79cd13be357-7b5144fad6fmr158600785a.6.1732280911809;
        Fri, 22 Nov 2024 05:08:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg0PllgxIaZL6+sOj+lXoG4EAwCbAT0zkzQ+OpASPnOcskLg8opeQF2CNdVsHxer0rtYzHww==
X-Received: by 2002:a05:620a:1a04:b0:7b1:444a:b679 with SMTP id af79cd13be357-7b5144fad6fmr158598385a.6.1732280911470;
        Fri, 22 Nov 2024 05:08:31 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52f92fsm98770266b.107.2024.11.22.05.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 05:08:31 -0800 (PST)
Message-ID: <37b16448-b62b-4839-ba48-ae599977d71f@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 14:08:28 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add 'qcom,product-variant'
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Cheng Jiang <quic_chejiang@quicinc.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_zijuhu@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_mohamull@quicinc.com
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-2-quic_chejiang@quicinc.com>
 <083d53c7-58d9-4e36-93b1-36e5696dd495@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <083d53c7-58d9-4e36-93b1-36e5696dd495@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ez_hxPPbs6dnrV2tujzEWu7m27jIenwo
X-Proofpoint-ORIG-GUID: Ez_hxPPbs6dnrV2tujzEWu7m27jIenwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220111

On 22.11.2024 1:49 PM, Konrad Dybcio wrote:
> On 20.11.2024 10:54 AM, Cheng Jiang wrote:
>> Several Qualcomm projects will use the same Bluetooth chip, each
>> focusing on different features. For instance, consumer projects
>> prioritize the A2DP SRC feature, while IoT projects focus on the A2DP
>> SINK feature, which may have more optimizations for coexistence when
>> acting as a SINK. Due to the patch size, it is not feasible to include
>> all features in a single firmware.
>>
>> Therefore, the 'product-variant' devicetree property is used to provide
>> product information for the Bluetooth driver to load the appropriate
>> firmware.
>>
>> If this property is not defined, the default firmware will be loaded,
>> ensuring there are no backward compatibility issues with older
>> devicetrees.
>>
>> The product-variant defines like this:
>>   0 - 15 (16 bits) are product line specific definitions
>>   16 - 23 (8 bits) are for the product line.
> 
> Product lines don't exist in the kernel. Please describe the actual
> differences between those files instead.

Ok, so it seems to be feature set. This definitely should be
userspace-toggleable. We can always reset the device and reload firmware
at runtime, so I see no point in having to educate the kernel about this.

I'd say A2DP SRC is probably preferred to be the deafult, as we have
people running bare upstream on laptops and other consumer devices.

Konrad

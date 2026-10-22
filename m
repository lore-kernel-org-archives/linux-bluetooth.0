Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792675023;
	b=14NB9aO5JMLuvzjDNPSuQIWLwJ5IkZZoDTNdTAZ7b6skr8T5I1Hb0YyC6xGci2gW1IaE
	 /zBZbXCOsfZRMHFDlXVMPDQJgl8hZ2/nyu5maHYXrghMrWAa73mJr/V8ajGP5IcJmVhQx
	 81Bcy5S8LIYVmip2c7stZh+zxCYPNd9Y9Hr1taQpYSuHJpUXgejoE/h/9RYFKMb1Upl1/
	 +nCL+Uaw8EHAg59UwH6YiIDS004F/DeGhPEJOwRpRMmsqPkFyioPDnHmilprb12EwM6hI
	 LfRyuYTIIBEVhS+tYL6IZKSR3DxP2ntjYMkjTv8W4jd4o/3Bq5senQCuetVIBSRik9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675023;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XHogjjLeWyeXgDWwoK6G0mFCe502abfVqfNNBKQPSw4=;
	b=T8Kh9+jrI+zqqYukNfqZrDYUtJbvRqZnt+q8J6jew6Xw89OGNzFPoqf2Dk7HjqGVLJFx
	 ijeEqLBkfHlE7cXa53aREflDQy/tO8SCyZ4ANjP233lf0I+xJOpub9+oxRUgSp8xPmhdg
	 sXLU6dRq0iHGjgrT8nBrpJ/unngSToOHyocj6Z+7McoGSJuAYCRYdHqYbym8a+bV1Yz4o
	 OYVmBj8fpAPg9jJCw+1mtrkX/VNSknO2Lr6NmDXmbkXyg2DmSNZmqfOQS1g+8FZGS4K/f
	 IQwnE88N5V6HVfosRtzWxp5awMe/lv0GlPbEbw4mf9z14gYp8bVTGQ3LUvouMbjW1cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Htisf5nt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bsRdZ23T;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5CC606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC5CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Htisf5nt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bsRdZ23T
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xt0D3478854
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XHogjjLeWyeXgDWwoK6G0mFCe502abfVqfNNBKQPSw4=; b=Htisf5nttZX6+P9C
	q/ThzSJassydYAZaByeoerQywISTTBPBODEVQu7cwEWbvOIn2MmfD6h7h2/sUcaq
	wkVJFtpbkP+8DZoJRKQ4JI7ME9UfqdKIVBuywb5qn03QjHPNSTJSSRYxnYDMfFH6
	JnFaQEecUO7/LcF49suyOv0gOiDb1apnoVrZnmsR947Ksfhv/7N+KxqtdyNz3bpD
	0i7ImNdSO/nj2t3yt6q/vHYfJwAqHZ1A8a/4d6Z9SCHv5HFeLK7c9ijIFYRaJXQZ
	viEqHh6rXaCcmF5TLq6/jcrIQYKBmlODSZPyyN4X0Ouix9ikKB6XjqoMOflAGSN3
	Ugzt/w==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a3nk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 13:16:57 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5eacd73e83bso101220e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792675016; x=1793279816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XHogjjLeWyeXgDWwoK6G0mFCe502abfVqfNNBKQPSw4=;
        b=bsRdZ23TMX1PgEXN/usj3Ify/MN9xyrL07PSSz4Sw4i6DKY5IuT6gU9upDqg58fkZr
         MJooRTmamSwhzvsIL794ZltjNdpYHWR4yBzgnwpgBQUOgdmZJjONjfV6QZZuLvQBZaTN
         ett88t7BTkUSk5h/UzXCZDqaFugxSz482oszUiad9q75nyBrer5EzASlCTNLWt9USPfJ
         reAuJLSZvctTSIa/qcWZPTq0aIcBl6gIlkuXTNyL/N24oejSrs5vxaoCbilqrs985Nu5
         n4yg4IgncTQHYCrV/sfq26ZPWZ8KkqvZMj6GoP9aZxNntGFS/0+uPzKYJga46i588xXW
         uNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675016; x=1793279816;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHogjjLeWyeXgDWwoK6G0mFCe502abfVqfNNBKQPSw4=;
        b=kDrqIXf4o+mgJaPB0a+hgvj3wT++2HtmfG1IAA7C1fLFyUPAL5mas5jynRyP3oF2Ji
         Cd8oEnumtHJ/dB4RDTKYs50O3LXbbRGzz0HheoXx2Bn9Z1rZOZOGprf0kgRSGumOJT9R
         tuRG60tiiHrc8mTB4Rsd+9rAt8+UVslnVo/nMYwpIHl+/WjNYv1v3fL6mBMTEKRLJXGB
         vLLrZAT/gJoiedUM2gb84NkTxCBpJbAcVSHqiwjASH/yi1EHKszcB/8K1KbxGLJA+70T
         ECEnQzdWJtdqJdZtipy7oVZcia/pu1BbaIce4wimiovKGK4VTl71F5vvlz5x2vHNFSex
         D36g==
X-Forwarded-Encrypted: i=1; AKwUvBydfeFov9dYWixsyYbjgL0xrW2AN9VojOvOyagdcWWLVay5lA5ADQ6mNkNVtHtyy7Pr8CW/ls0YQhAh1+PosIQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfX7fe2AIC37/fRKg2Y9ufLJ3n4hQ/yGbhM2FqfZlidq7o0pbg
	GCr7HGqpq+V5CmD9ZuOlx15Fpqzk8UKlO3I7zMc+4X4WIcwYxDgQBC7TL4C0FBtqKm7ZyOaQgLD
	twrOnV6db01mOY2UuE+VJLThoF6PdDJfnD3+skuoI8KmH1nlzNPJkv4q2IiPH2MCTDidiLfsQ5L
	AO4EQ=
X-Gm-Gg: AYBFou0UmmWRHqBAU7jKinLNLpmlIokiuhhMfjngQ1m+Ry1y36B16yK/UFRIgz4ICHk
	dBw4S0wTe82+jiGfNtQv4HTKvEkERUa394KTOoENR6jvUNz16KX8vOXUi2yw8hVYGGK1YH9I576
	RqUch2hBu6TLvKki6ISouk0AkP5nwm7Za7zXd0blcZ8yQzDhwNP8ip82f96EeycNXG88JSzVqgX
	csd3wMmgulo92uA7s1h/Q09kYJq1rOaIKfDGkvU4map1RYWPb90uNvRVFQPeT0Pq0AmhvCM9XoA
	1GIxFnviipinfKAd13Ots+OLUgnbvbYnQmKcoA0N01RonOInJKNY36K12MJoK/JbFb6zm7zknA3
	N/BqLER7Z6s9zXecSSMcr5Q==
X-Received: by 2002:a05:6102:1626:b0:7cb:fef7:3763 with SMTP id ada2fe7eead31-7cc92623e94mr1737866137.3.1792675016059;
        Thu, 22 Oct 2026 06:16:56 -0700 (PDT)
X-Received: by 2002:a05:6102:1626:b0:7cb:fef7:3763 with SMTP id ada2fe7eead31-7cc92623e94mr1737835137.3.1792675015533;
        Thu, 22 Oct 2026 06:16:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a1eecbcsm105632466b.7.2026.10.22.06.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 06:16:54 -0700 (PDT)
Message-ID: <b18e5577-9d16-40d9-891c-35af4c653108@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:16:46 +0200
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2
 Key E connector
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
 <20260825092715.5794-1-wei.deng@oss.qualcomm.com>
 <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
 <83b67ab2-ab68-427a-94aa-881454f457ba@oss.qualcomm.com>
 <CAFEp6-2KDxDrfTZLN7KPRg=aavj8nqQr7ftna23n9C1Cpbwwbg@mail.gmail.com>
 <e26f0360-aaed-4e40-b1b2-956c92d34db5@oss.qualcomm.com>
 <CAFEp6-0b15kV6ehMN4Pv24UmMo7xFYr=H396dvdD1Teh7h+K+w@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAFEp6-0b15kV6ehMN4Pv24UmMo7xFYr=H396dvdD1Teh7h+K+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MiBTYWx0ZWRfXwND7qDdjbVOt
 MB+Wwr7ZLc5a0K+4ESQhcWkIjbgNZvD18XMZE6z9Q1ZkRJ1YV500VkLIHTqgmf0mzGxyx+5DQ3Q
 LdsiEyCzpApTdNJyppp7Qb9ufMk/r44PYrNFTTM7bPA4mpb06Q08jlF+UKuPeghK1DbRcDKbSD3
 yHhWQ6ev11WWJ3J1s+M1OtdB9dagW7Mo+70+LBZWFlrTpxRLGcUpyZo1OX4vjiPQC0iKf++fogp
 AEbNYubJ215rhAYcVfoq0j2N9nL9pNr/pFphXTLejfkvKvatpP79HF8bpQnv43WZUS/kKcVXADU
 hivIRMW5NZCUbaW9dtpudcVVCbpxJLvXRYraEwCKEPzG3XCZD6SNDpeBs6GoMHTZ/qAflj9WziR
 Sip8npMjczzjOB/j6aP2lS+O+X0M2l7C/TYLzYo0M5ARXor8ODrA5aflef6yxdy+mRtuowWBHDF
 ZHHlca8GIcfHiQZIzBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MiBTYWx0ZWRfXxZAsEXbiUrTh
 nSs6u8eaby7a/TBoxffLuBvprkENowilTv7oGwnzm4tsd5iz8ll6lV2hP5gp4YIq1bKnWdDDHkU
 Mk7ioP5PLpa+iaBFNTZgkg14XzOFpmA=
X-Proofpoint-GUID: e7qN4Nfomob_S_g1eIquuG9bHg77LQsG
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada0cc9 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5fzcQa2O_f0PTkyQNbAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: e7qN4Nfomob_S_g1eIquuG9bHg77LQsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220052

On 10/22/26 3:08 PM, Loic Poulain wrote:
> On Thu, Oct 22, 2026 at 11:34 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 10/13/26 10:13 AM, Loic Poulain wrote:
>>> Hi Folks,
>>>
>>> On Mon, Sep 21, 2026 at 2:38 PM Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> [...]
>>
>>>>>> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
>>>>>> suggested moving the port/endpoint anchor nodes to the SoC DTSI
>>>>>> (monaco.dtsi) for clean DTS layering, so that board files only need to
>>>>>> fill in remote-endpoint for boards that actually have an M.2 connector.
>>>>>>
>>>>>
>>>>> This means, the dummy port/endpoint node will always be present even when the
>>>>> M.2 connector is not used. I don't see a compelling reason to do so.
>>>>
>>>> I don't really see a compelling reason to defer re-defining them to each
>>>> device DT either..
>>>
>>> Adding an empty port/endpoint at the SoC level is problematic for
>>> uart, port is not always expected, this depends if the uart is exposed
>>> through a connector or to an onboard device. So we may end with an
>>> unconnected endpoint but still have a bluetooth subnode, which can be
>>> a bit confusing... Also why adding a port/endpoint only for a specific
>>> uart in the dts, and not for the others? This is a board/SoC level
>>> choice to use a specific uart for M2 or not.
>>
>> From my perspective it's removing boilerplate. Currently all USB and
>> PCIe hosts already define their ports and endpoints in the SoC DTSI
>> and if they're unconnected, then simply nothing happens.
>>
>> Both 'ports' and 'endpoints' are an abstract property that signify
>> 'X can be related to Y' and I don't see how that's a problem here given
>> UART is very much expected to be connected "somewhere" (with the
>> "somewhere" perhaps being external/a pin header)
> 
> Yes, but in the UART case, where the connection can be represented in
> different ways, we can end up with devices being described as both
> unconnected (no remote endpoint) and connected (via a child device).
> We can probably live with that, but if we go in this direction, we
> should consider adding a port/endpoint definition for every UART
> instance in the DTSI for consistency. The same would apply to I2C once
> endpoint support is available there as well.

Guess so!

Konrad

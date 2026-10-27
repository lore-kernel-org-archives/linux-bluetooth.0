Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100088;
	b=wMX7fgCowbMbQOQrjwGeh9ZM2clY9EeMf8IjvfbThHfMK6By8AyBMILuo6awkZW+h3Vp
	 +aoQOdafFHa9Pz5TRpejG04lBDt8niMS7X1lE7etnhk4Huw3TWyFRMMF5UnZKNFFsyKOs
	 hm5Sbyfu1rvTsnmaytiauL5ld+15VQe/YMI9CL1CBBfLIhCfJDCoFknULrOnLx0kV0nNT
	 3lGFPqNUSrnl3h0tnUa0Ujh7m6wfZ1vPkKY3Xv1LHdsTl5y4E/gpHT6D6dxXSjpEbym2u
	 pTiLfBkf7vmmT/bIhN08B5ZdR4No6oYxe8TYC+dB40YGlFxIKKZJJJD6avGLDot30IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100088;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FxapVRMKpDEsmmZXHetp6RGC0wXUKkGAJ98ScQHvhUE=;
	b=RFbrHH9toLuo85td9dlVUFiJ+3UNfAJeSBeGEhjRq1ZTOW8496RXEbSyUKUUByKx8y70
	 lPXjVrtD4RT8sQFrmHAk1GMnvQyxaykIhLE+Q+Sfn6k1gK1jCZyHZvsyb9iL/uYQrDn4B
	 nMVkj7ioo0YpkEGFaYInWBGNvP5eKn6pIt/tddIj4x5G+q8rwLFj16WA3m95/8EcyBN7+
	 BEURtgYiBZMQEBuqMghdZ3ANGxttglsCKuOJKtM2QVP0d8uwBnsmkA9Q3r3NhkjGEBS5u
	 b8kQ6SwRhLYEMIQU76+pyPZcgVao/xPjryzHdSCVfOWbIEWtrlwl3H0vavXLdMaPWRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cTm+q2if;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZRlnZO2G;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD925606A31D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 11:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD925606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cTm+q2if;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZRlnZO2G
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe85V1935974
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 11:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FxapVRMKpDEsmmZXHetp6RGC0wXUKkGAJ98ScQHvhUE=; b=cTm+q2ifSDhFLe38
	o5RQrj2a7BeytWINEZrGxgVix/c9KLH0ChWmpYI1ZVcfBpQfui1+Ojr1QOVeFB5F
	tKfb37U+IoqhxwoXDsT2tyPxlK6eg/6cgwTUsNLKJCeTrz+2YntAq4Xy/9oANJI2
	OpnNlENmOmxJ9/6AQDoXZIKBfAtutNJj34ogYSpqtoP2TNQKSpeFBpg1C7lzLgjK
	6koiyGGzPcII5dwagV2WQeieCMPgx4Ka3CDIWse/6SnKoDb5seuoc6zff5WjlMIM
	LqYqaD6KEf2dgBMTW2VtmBpADBVAU9Wzi7Dl4hGUh+JKGac41qcD+LHuktvhRiVL
	VQdl8Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavtjdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 11:21:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-536708d1a3eso15742561cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793100086; x=1793704886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxapVRMKpDEsmmZXHetp6RGC0wXUKkGAJ98ScQHvhUE=;
        b=ZRlnZO2G8o++1Pw68odli4RtmINIpboM5Ab10jMnEtkJ8FPuO2B9vq2DO+N6cdPhgx
         d1Uld7atEk2VpaPfwTE6yEsfscDLulZngmp8nkyxgMlS8zymj1Zjr+t7uKf1WtKh6+q5
         qBLXnWlGFRWh59rgxImgmsIMsB6RlY6G+4euubjs3wothqiFaTDNeElqw1oe5b7LUPn9
         RNr6JfSqg43KKWZB0IVZWe56jxXP/INm7iechKS2FRIPiW2gTriT7m0xoHXaLKo4ipi4
         Z1owamNkEp/24MdFd1UC6t3I6WMqDcnXEiKHvUCFdRlY1k4kMwKl8h3ANYbbIAH6PPnV
         UbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793100086; x=1793704886;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FxapVRMKpDEsmmZXHetp6RGC0wXUKkGAJ98ScQHvhUE=;
        b=lmySvwsx9Abs+5FCB0WArcg5NRlgEt1H+z4JioIfPR4wU5yD2XlDPl/Dcopdf1lcgK
         LLVRpci5VHN4LXAHQUchLdt2rqImxwZMQnuAccOJJeraOHFqlkJCk/wHtwuwPWgAWheq
         0YK2MxMKQeHbGCyLZLlRfhkeZmnPkr47IhbCJIk6MkAl7++tGrHjwfC1AhDYu1VxkeJZ
         wf3yPMT6ztvLSU1IX73Uujk5fgk1ZMUWRkvE/JbhSkbzOoFug6SvJrWREoLTZ8riAVex
         Ur3hpZBpqG096k5IXId+ZQqG0H5Ffl8q93NsGWdEB1mjsVa2j6MBCpknnQgDw6JkoVir
         qxgQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4PgWQ1xdLu5ByPe1PUEp7wfwTPEKUA6eeko3N7SC2BmoKPNPZTZYOlPBgSaV4Q9sVQh6gdzZyhyuMq2elS1Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJR8Ry8XBNnfhBi2ThkQdXXA3b5hxVagjtU/L2YcZ2lU4Lq965I
	eQLfEXlaIbAonnMyzAJoVKxgQG/BGMzQMQBXWeailHTvpWcA7vtxC1z1G+xFeL2Js1KCRZnkdCQ
	lORSM9ltHELaZoO5gSkCkxv2IS4qRl/+2bpeP/6NwaQgkKTQj0zPdIIY1uNlZEFCV5AqjaHc=
X-Gm-Gg: AYBFou2mgoO8EG8l8uoTVZlka0+f09uSG55X7jXUitDrPEy8wiReJoNUDUCWHOhzEDo
	WEzPc1lQmGYq9LOlRPKJYAhoc915eh//2Zy1972dX7yIghfzwnmyzXl+pPUS02r5rzJ1FPFMv1M
	fsOuVuijOX+A7mTDeg8jKMDAiF8qijOUISB2V5DxUPjifm4x25JyzQ2oewFnl8asGLwBbMDUOqv
	ST4ErZHEnYdyq9YWIF1BeUEMzEQilqVR7p2mddATx8w8Cej0uwtNhwf2d7/g8QA02WHtfJm/yiR
	MHwEr9VnKtcltEQ9bpyvTaikyKAP/JmGS3aOK/aRx/Q5EjHN5Salpu2h/2y4kOYSmqTVBTZJ6MN
	iduOEV6CMUdjyTU9d5bcwNg==
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id af79cd13be357-940ef672271mr1462774585a.0.1793100085798;
        Tue, 27 Oct 2026 04:21:25 -0700 (PDT)
X-Received: by 2002:a05:620a:8703:10b0:93e:5a3f:ac13 with SMTP id af79cd13be357-940ef672271mr1462769585a.0.1793100085311;
        Tue, 27 Oct 2026 04:21:25 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a4e208d1sm118196666b.85.2026.10.27.04.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 04:21:24 -0700 (PDT)
Message-ID: <44dc3838-63f9-4718-9aa5-aaac223a81f1@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:21:21 +0100
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
To: Manivannan Sadhasivam <mani@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Wei Deng <wei.deng@oss.qualcomm.com>, andersson@kernel.org,
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
 <at9Dn2N-PmLOPaeq@debian>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <at9Dn2N-PmLOPaeq@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WTek4onR-0-3tWKSM6llTEX6dEioCCfe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX5N4vHvBzD9W3
 JHIH0EBaqpj80io7rTb0Y92H1OB5llkhAV1eUiYOY/0pDdxwmIOX8Wy34J85rIVPCwsVun6Gv9L
 aajTum+LTuVtV1FKeNZ/DTaV6N/tXTQ=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae08936 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5fzcQa2O_f0PTkyQNbAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: WTek4onR-0-3tWKSM6llTEX6dEioCCfe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX/hYFTvQRjg7N
 8kodtMzwpIgnm4rk4XTBsYlOH85pwy/HmHiEyGzIWp3isI6OoB1tRnY2QHmtHWi5bHa/K3ziUeM
 woClFaDJOdp2SahvfB/ylZ/9ni3tN8mr38PNIax6OGNdJz2OZW4Ncm1sqAvxIrxh3jNQgdit9A8
 /bcnZEv5CKZxL7OEPenvJfLORYkl3Q5Jh3E/L98H+opUf1QQMV9VK5/T2zZ754hQTTcABL9awwx
 CSV0wBge8uZLAQcanzBVQOW7CL6hV6Q9WNYc9CsfP7gRdAP92Axv7beknoo8c72yzJHKgHP8YDH
 ihs/tzGrRoobL8B9izARgc4vAYSTX+5KMrpXKwSfeCXn1838jofTe8yg4VYvhr54HmbDYhF05WM
 Q5e9c/yw88Njrf5DR5+lSXzPh6/31ZV6sbEnjA4wlbJZRb5jMkHqv9XybAJ2ZPZeezGTb67eARo
 0g4+2OAZHoxIAkp4hGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270045

On 10/26/26 1:13 PM, Manivannan Sadhasivam wrote:
> On Thu, Oct 22, 2026 at 03:08:44PM +0200, Loic Poulain wrote:
>> On Thu, Oct 22, 2026 at 11:34 AM Konrad Dybcio
>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>
>>> On 10/13/26 10:13 AM, Loic Poulain wrote:
>>>> Hi Folks,
>>>>
>>>> On Mon, Sep 21, 2026 at 2:38 PM Konrad Dybcio
>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>
>>> [...]
>>>
>>>>>>> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
>>>>>>> suggested moving the port/endpoint anchor nodes to the SoC DTSI
>>>>>>> (monaco.dtsi) for clean DTS layering, so that board files only need to
>>>>>>> fill in remote-endpoint for boards that actually have an M.2 connector.
>>>>>>>
>>>>>>
>>>>>> This means, the dummy port/endpoint node will always be present even when the
>>>>>> M.2 connector is not used. I don't see a compelling reason to do so.
>>>>>
>>>>> I don't really see a compelling reason to defer re-defining them to each
>>>>> device DT either..
>>>>
>>>> Adding an empty port/endpoint at the SoC level is problematic for
>>>> uart, port is not always expected, this depends if the uart is exposed
>>>> through a connector or to an onboard device. So we may end with an
>>>> unconnected endpoint but still have a bluetooth subnode, which can be
>>>> a bit confusing... Also why adding a port/endpoint only for a specific
>>>> uart in the dts, and not for the others? This is a board/SoC level
>>>> choice to use a specific uart for M2 or not.
>>>
>>> From my perspective it's removing boilerplate. Currently all USB and
>>> PCIe hosts already define their ports and endpoints in the SoC DTSI
>>> and if they're unconnected, then simply nothing happens.
>>>
>>> Both 'ports' and 'endpoints' are an abstract property that signify
>>> 'X can be related to Y' and I don't see how that's a problem here given
>>> UART is very much expected to be connected "somewhere" (with the
>>> "somewhere" perhaps being external/a pin header)
>>
>> Yes, but in the UART case, where the connection can be represented in
>> different ways, we can end up with devices being described as both
>> unconnected (no remote endpoint) and connected (via a child device).
>> We can probably live with that, but if we go in this direction, we
>> should consider adding a port/endpoint definition for every UART
>> instance in the DTSI for consistency. The same would apply to I2C once
>> endpoint support is available there as well.
>>
> 
> Yeah, that's also one of the thing I really hate. For getting rid of
> boilerplate, we will be just introducing dead nodes :/

I disagree about this being a problem, but I won't block further.

Konrad

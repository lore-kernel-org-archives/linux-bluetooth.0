Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B829D0D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798703; cv=none; b=ksDwTOBStOMfnYZoDDnwcrThVH0fYqpoR+PzQEfI4AoCjcfU9XiWze9c9RV3kSRe0nJMjYOc8oVklLyTP6hP0HPaf3LXugmNKW5+D0nDCzXGs3/HLU9PN5yhZbDEF/PFNwSlWEGQlIjtVvxcIo7PuRf8IoUDsuHFz9ZKdIbwCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798703; c=relaxed/simple;
	bh=2q83QnAPZfpFgPafBP7XU6Up/noCHicxS0L2OSGBamM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRiNsJYICLoXewD5Y1xQZkTtRBFdEUA2x5VB4Nf1GTEK+yZcgXwuDgm3AKFdjdFBuLprQffzO1aovFnvZ4Vu7dJ2Jzg4GWECfefbaG/t5toI2Vm5Swp4NxOi1TQqldtR+HtPFSVciBpqHRsftNbMbPi444tgqvaw1NbC38vnQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FxX5+zQS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FxX5+zQS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9e9sa006654
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 14:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uPJzTv/LsbZH/DP7GxqrDBaJiP6VaHmRqwcYKmkvw5s=; b=FxX5+zQSKgQwSpee
	DKs21uj/O5Lev5GgRujGmcE/cCI0YwWEKXcUavyVuNxsaYJKN+dx3KBr56Fu2x5p
	SDhX7uxRHUcBlLMNmozeAa6hXE/KZ+23T+kexG/KW5558LVCF54WJsFoGIdf2u0t
	en4z+rNyS80nEO69dimXS/O6rVik4Z3ggvlryiE8PvfjqpDyvJWlPM2yt3CeeATE
	uSCW9UdRYD5p2g7GTM51YNe87BZbvX4DvC12GtK/5mnBrIkitYgfTVSFjFQtsoxv
	7KVPMlBymws6Lhjryr8SmkDsK8JtwZuE1/5RQXYCImlohoiukd1TChEGCbDH/CC0
	6ACgbQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr8hw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 14:18:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7deca3ef277so114300585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 07:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753798700; x=1754403500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPJzTv/LsbZH/DP7GxqrDBaJiP6VaHmRqwcYKmkvw5s=;
        b=nrDYTzfvGRiMgScuGXX1kOXuTPKP788sejQvYoMvgyPeK3Z/qepzFNyy3k2wOreiQC
         w0LOt03mUT2c1/7dUS4uNoAXDxZ+9+4WfYSFmxjhsciha5+5SrnUFeAe7ItnTvKojOJL
         kW1QaV1f5SqOpNNDdDiqW/fjz0luN2FFnAAX7dXso2iZ2nMC4tQmq+Uc/duL6Axjq9Hb
         8PQWamYyQ0/P1bT7yfye8Ih6GeJdn6jcaUwoD/IdcHJ7J2qZB5+Z6Ze8gd9yAm6sKUvD
         KYAtPYAVxBJi+ejOF1/OpY+ZlVYl6sMIq706FG4hD4v76/dM5HV11LjNhWlI2uVzb5Mf
         c/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWIUs3sFPx+awfPVdMejk48IktCPhlfhEGs7VaUDbZtZ6NGy06Bn4iekziK6ALFqfKcueAn2RyqGX7r819eFnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd9m3uSR5DKq8XWpT5q5wm2YDtzbzVO4IqOppL+25Bc+M+0VGz
	fmwk836x6ZGUqheMEaHlpfLV1e0RSvmAy4JE2LD5pEI+FU9sX+VGGtpUyAb0UTXdbw5PtB3yAvZ
	+WGI+xFb8+twoBVYrlEdmEOz7r3n4MTdjIY4fkB7cahiqFGsZ4l/2oJGbBTbvUgJZ3ZVceeI=
X-Gm-Gg: ASbGncvYaTNJPtTGuBqQNM4zB5vuBT0L5v0ZS8SVd26Psyp7BHIEzV7fwmW1J2Pxpt6
	q50VQOlsWh4zK1LVZRBXsd1y5Ci02KlsQkaYnsJ9bXaJwzMh0EXIGuDuin1I+HE+7xstq0ejnQE
	Mzcz9yauKPfPFVBZhXK99ww146h9X8dyRpD3IiA+uprcAL2xXlTnmtQlZypKKvOKTqT6e2iQzFe
	ZTwwZ79PyELZycb0i+Wka9/rC+ov/4YC7NnGKUkqSMaYZtGNtJdwyHRWlB+hnQEdrtNxCtgaprQ
	GU1XH8vJyQqVg9rLX6bhhXM1BcavDYSvndo7mja6mW0Ahx1TjUi4j2qfMDq4tBsjBnHgUyBNcGm
	WYSGN3xRq19DzaUK6Dg==
X-Received: by 2002:a05:620a:2544:b0:7e6:67b5:f92d with SMTP id af79cd13be357-7e66d4ee20emr11556185a.6.1753798699844;
        Tue, 29 Jul 2025 07:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNcpUDTrukrGA/Ku3+zfham3Jn5WZovcxGRPs2Xx7mhoe+YWNAI0qwzjx7TtdhTwzEwh7/Tw==
X-Received: by 2002:a05:620a:2544:b0:7e6:67b5:f92d with SMTP id af79cd13be357-7e66d4ee20emr11552085a.6.1753798699019;
        Tue, 29 Jul 2025 07:18:19 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635adb093sm595797166b.124.2025.07.29.07.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 07:18:17 -0700 (PDT)
Message-ID: <341a7e85-9d4e-4ac8-8fa1-1000281eeed9@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 16:18:15 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver: bluetooth: hci_qca: fix ssr fail when BT_EN
 is pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250715051618.724475-1-quic_shuaz@quicinc.com>
 <20250715051618.724475-2-quic_shuaz@quicinc.com>
 <ee84aeb0-728a-4642-9686-3abb9588bb24@oss.qualcomm.com>
 <e7e700e4-e87c-4e2c-8df1-634870ba91b2@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e7e700e4-e87c-4e2c-8df1-634870ba91b2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwOSBTYWx0ZWRfX67Cc8rsVri8b
 pRr9xrUatwQSDCYHqsGsNW1Q0iw4LSn+5zkAUUlrcow5dQ5KesiqDjMukTXppFK665aAnYO8qyI
 b/FyUf5Xt6oNa09+zYMmK2ENKbw+96hUCcWM6vUv1eXBigoScb2Nt0U0nWs0rBAHB/2kZEL2tpG
 VIDQKj0wMXseIr+ZOp3dsZh7U9Z9VEcv4cF7OMmWC3D/fyyxaEzJ5tO7K6b6tI3MHAY1mabmXY/
 5nW+bIM1U2uJ6ifxCG4gTgEPoEwDkIZJsjsAHrtgN1meQRTOy1GnYaU6tckU5zkeLiGkPE+VFGj
 ecA6KMDB4buHbmZe381O5cJqQL+FPexShAV9lGyoOkY6rXj6Xb1edz2XxMIbOjBoPvkIN/nMRGX
 ekBKjEDqGEHJ0xHLieNFRseH3OAjrqRKJ4ACou7KnhQ/sqmcd43Ovl02i734CjkYwE4AsJmd
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=6888d82c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=1VU-nOPUZsXZC3zCpdYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8vMJ6E-AgEZAtklJ2bZn2fBsi3kWN50y
X-Proofpoint-ORIG-GUID: 8vMJ6E-AgEZAtklJ2bZn2fBsi3kWN50y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290109

On 7/19/25 1:32 AM, Shuai Zhang wrote:
> Hi Konrad 
> 
> On 7/15/2025 5:11 PM, Konrad Dybcio wrote:
>> On 7/15/25 7:16 AM, Shuai Zhang wrote:
>>> the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
>>> This leads to reset command timeout.
>>
>> This is a description of what goes wrong in terms of the code of
>> this driver, and it doesn't explain why you gate the code addition
>> with HCI_QUIRK_NON_PERSISTENT_SETUP, please share more details about
>> what you're doing, and more importantly, why.
>>
> 
> The problem encountered is that when the host actively triggers ssr 
> and collects the coredump data, the bt will send a reset command to 
> the controller. However, due to the aforementioned flag not being set, 
> the reset command times out.
> 
> I'm not clear whether you want to ask about the function of 
> HCI_QUIRK_NON_PERSISTENT_SETUP or why the changes are placed 
> under if(!HCI_QUIRK_NON_PERSISTENT_SETUP).
> 
> Regarding the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, 
> you can refer to this commit. 740011cfe94859df8d05f5400d589a8693b095e7
> 
> As for why it's placed in if(!HCI_QUIRK_NON_PERSISTENT_SETUP), 
> since HCI_QUIRK_NON_PERSISTENT_SETUP is related to BT_EN, it can be 
> used to determine if BT_EN exists in the DTS.

What I'm saying is that you should put this information in the
commit message

> 
>>>
>>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>>> ---
>>>  drivers/bluetooth/hci_qca.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index 4e56782b0..791f8d472 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1653,6 +1653,18 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>>>  		skb_queue_purge(&qca->rx_memdump_q);
>>>  	}
>>>  
>>> +	/* If the SoC always enables the bt_en pin via hardware and the driver
>>> +	 * cannot control the bt_en pin of the SoC chip, then during SSR,
>>
>> What is the "SoC" here? Bluetooth chip? MSM?
> 
> yes, Bluetooth chip on qcs9075-evk platform
> 
>>
>> What does "enabling the pin via hardware" refer to? Do we ever expect
>> that a proper platform description skips the bt_en pin?
>>
>> Also:
>>
>> /*
>>  * If the..
>>
> 
> Sorry, I’m not quite sure I follow—could you clarify what you meant?
> Here is my understanding.

The comment style.

> 
> Enabling pins through hardware refers to "the pin is  pulled up by hardware".
> qcs9075-evk platform use the m.2 connective card, the bt_en always pull up.

This is not conclusive either. Does the firmware of the bluetooth chip
configure the pin, or is the reset pin connected to an always-on PCIe
supply or similar?

> 
> 
>>> +	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.

At a glance, they're only cleared in qca_setup(), regardless of their state

>>> +	 * This leads to a reset command timeout failure.
>>> +	 * Also, add msleep delay to wait for controller to complete SSR.
>>
>> Googling "bluetooth SSR" yields nothing, so it's fair for me to ask
>> you to explain that acronym.. it's used a number of times across the
>> driver, so perhaps a comment somewhere at the top in a separate commit
>> would be good as well. I'm guessing "subsystem reset"?
> 
> Just to clarify, SSR is short for Subsystem Restart

Please write it down somewhere

Konrad

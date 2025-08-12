Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405552E6125
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990220; cv=none; b=EP5troG9kfFL1pZmppiqlP0nxDqCatbVA1z17w5GLMvvAFDMxgoOk0M8kvY/ymY3aAmfCMo5JkKfGLmqIPr1ffQhlJ8WXMsMgSYxxWXZnTBlGzdhYcLSXVtJPzKcw4XiI+V5st262KEKYz3zu8OoNS6ymc3QtQRl8wyrHFuNiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990220; c=relaxed/simple;
	bh=3vxrRJAh+EqyzgyBhex5r9Yo+PAKpEu68mEfY7pR1MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOvFRlHAQtH4oqjAFPtfINF8/3ToAv/UwJYIncd/Na1i+CLfpGlQIwSuM4tC7vRruJVqkwUQQKim0cUl/Be1eaUHt3Upi3SYbVTSxPOAIWRrEi0egpk81EoaLEIlkioY6Ib1SO8pku1rxEYXXFEKfmjyqMoL4LhMs8Mx6bePSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MsSwylZJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MsSwylZJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5gvVQ018312
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 09:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	szoFZFn3zyipQklF/BzIbtuPr+6uKdGBAsaMiBXKvR8=; b=MsSwylZJY+3ibgJC
	fNiPBU4FTg9cssCQ9U9HILeP2nJG9HKbc449cq+p5EpjhqxahasZoA8p37wZ3BCt
	crVxwJil8Rb/mdyxf2dKW+Ewz0S0j2MnDyB+gVd+7ut44WnExaWQ4VA5JMr6/HFp
	oB8WhuSjgB/mxAOoIFF6X3wUdPLc9Z5Vui1mjbu1n9ucTfruGgP2G/ia0+BgbV4N
	x/W4/Dgl54U+5nNjbs+1D4+bzOYSj6LbP2w1m1mDtAPjtoyVMIYcIJiN2zdkn4Oz
	wIhqjn/G91h0etISHReHyovTc9CceS7rietBqhshanuVQS8tQreIWesG1GSH1yJ2
	zBb+sg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g7gck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 09:16:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073ec538e2so17574116d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 02:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990217; x=1755595017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szoFZFn3zyipQklF/BzIbtuPr+6uKdGBAsaMiBXKvR8=;
        b=AKoiBeuTPAvZ51WxHho039LFqXHNWRrygk5srqQJQaj37g9sZ5GWuWFjuRhyDyYiTi
         8Eg4KYhlZj9U4lpuKUzzRYde9aIvhdQtmHKONXAU4IrSFOuHbHyn5Gj4DJI+vl0HuVUu
         9XBNzdWI4eFxaRP25CIPpG4K+bP7WsOAD3+mALEnfn8hGdvv7OKiPY0e80w1DOwCHnBT
         8r7W0OhpMmJ1d2aNdMMf+h5ahXCobXsZBd0Cm/Ba/1KLVoQ4G+PTtziuYdsMK7NDrAds
         z69HQj59ITOSLjdvXofqDKoLgT/HNxcy8wtCImkbT0ty2eS2YvOjgGiNB4Zg6WgsQqKC
         UDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW30tVb3hyLV3BaSU369qeCiQI3+Sy1D2iRPo7LdYmkUpoLl8TuOqFoV6zzkA5h5rVS2y29/ZbwbzUprTwb0OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyobhPyygEUwsGnsaz/Oiw68PiqaYoO1D5BTTRzX7TLcQVn8mgb
	wEXNnOm7mN4zaHIPF/UQBV5cnOQmanE7liAH/pRnhXw/DriyCytnedNbMjH543gCS/wWJ+URC7N
	nblb+6eKdDuTRO/281Asv18L/iw2M4SpexDM9HopGikqn5u4skYCe5MkxZivkQF1AyuJn56Y=
X-Gm-Gg: ASbGncueMeJdixo+5o8rXQgMVaYvvm7Sr8FIsFCvumrZ/5jt1IjUFxkV0/Y1ZOhwzGL
	aWVXBbW9u9ywwIHPKv2BTk7RNRp4iJES6tGFFs6u9xetwIcIibGCBU9WUW7TXVVJLcUrJvoc7ne
	S0OSrECbQCOS23nTdpiqYa3D8fwM+GAE+W41xVCT5BVlq602KRMGjx/HZY/HTRhb2uXqWMWnfGX
	C0tPLhtnW97QRMvYIeiiigb0/cx2A1ur3+8wZtvfq5oSi6+Ex1nzXLyFgwjidlLMUTm58cvkXMF
	iL7evP03kEbwuIzQVVWrOrz+3KE4jKdHJNZj9EQOsw/Mbf04YUvj7F8hik+QkhOUWMi9M8PTwQA
	0TGnSjvl7FXAR8uhmSg==
X-Received: by 2002:a05:622a:1a29:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4b0f48fa006mr2988651cf.3.1754990216638;
        Tue, 12 Aug 2025 02:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb8BIOiMB2aaszVUO5sc5ldVeAaDIfkEujTFUEDPXKgEEwpNoWILRyxCr9Ql2Svsw3ZJzZXQ==
X-Received: by 2002:a05:622a:1a29:b0:4a9:a320:f528 with SMTP id d75a77b69052e-4b0f48fa006mr2988531cf.3.1754990216019;
        Tue, 12 Aug 2025 02:16:56 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ecfsm2165172566b.94.2025.08.12.02.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:16:55 -0700 (PDT)
Message-ID: <3f712fec-a4c6-41a3-9b7a-34b9edc1d9b0@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:16:54 +0200
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
 <0a6d6ae7-67f2-4974-b005-f36ee8707c67@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <0a6d6ae7-67f2-4974-b005-f36ee8707c67@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b068a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=TmvEoTIt-G6_DD21KxUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX4CNm/zPGyGKv
 YbJo5J03OB/xnMPMFAg2/yuGMH3zHhu8U9itxcwuMldA/SjH4YLbHaCWsij99IMI7JYPqLaK23n
 xpJMNTkbKw/hbzV5N5tE7bonkcC2iJCqQX7CLKMu4zr+2UUQ9inyIHySSeLZjryTZxxe3Jh/gTT
 MayS8JW/BIYAHwpN5lC3U266KLAsA40NWL48sDdcRW9USwV+j8J+LngA3Pc8CBcO0Q9AZXhlN9V
 rgidFDVCwCfmzVbfoaQq3ugF3B8dhplvrd58CGZxx1PTJXnDCwjyHffVTokQu6lUfO3X9BOY8o2
 21GZ4Rd9RJY6bWEafTKyq60TRUI2GOx/cR5i5RZ5N5Rjcdnl9t07LTdFmeIIecS7UMOe1Sc40ip
 glqOr2QR
X-Proofpoint-GUID: ZNxh18MXcMcRbe-fB9q60GGFYa55j_be
X-Proofpoint-ORIG-GUID: ZNxh18MXcMcRbe-fB9q60GGFYa55j_be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/12/25 10:03 AM, Shuai Zhang wrote:
> Hi Konrad
> 
> On 7/19/2025 7:32 AM, Shuai Zhang wrote:
>> Hi Konrad 
>>
>> On 7/15/2025 5:11 PM, Konrad Dybcio wrote:
>>> On 7/15/25 7:16 AM, Shuai Zhang wrote:
>>>> the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
>>>> This leads to reset command timeout.
>>>
>>> This is a description of what goes wrong in terms of the code of
>>> this driver, and it doesn't explain why you gate the code addition
>>> with HCI_QUIRK_NON_PERSISTENT_SETUP, please share more details about
>>> what you're doing, and more importantly, why.
>>>
>>
>> The problem encountered is that when the host actively triggers ssr 
>> and collects the coredump data, the bt will send a reset command to 
>> the controller. However, due to the aforementioned flag not being set, 
>> the reset command times out.
>>
>> I'm not clear whether you want to ask about the function of 
>> HCI_QUIRK_NON_PERSISTENT_SETUP or why the changes are placed 
>> under if(!HCI_QUIRK_NON_PERSISTENT_SETUP).
>>
>> Regarding the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, 
>> you can refer to this commit. 740011cfe94859df8d05f5400d589a8693b095e7
>>
>> As for why it's placed in if(!HCI_QUIRK_NON_PERSISTENT_SETUP), 
>> since HCI_QUIRK_NON_PERSISTENT_SETUP is related to BT_EN, it can be 
>> used to determine if BT_EN exists in the DTS.
>>
>>>>
>>>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>>>> ---
>>>>  drivers/bluetooth/hci_qca.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>> index 4e56782b0..791f8d472 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -1653,6 +1653,18 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>>>>  		skb_queue_purge(&qca->rx_memdump_q);
>>>>  	}
>>>>  
>>>> +	/* If the SoC always enables the bt_en pin via hardware and the driver
>>>> +	 * cannot control the bt_en pin of the SoC chip, then during SSR,
>>>
>>> What is the "SoC" here? Bluetooth chip? MSM?
>>
>> yes, Bluetooth chip on qcs9075-evk platform
>>
>>>
>>> What does "enabling the pin via hardware" refer to? Do we ever expect
>>> that a proper platform description skips the bt_en pin?
>>>
>>> Also:
>>>
>>> /*
>>>  * If the..
>>>
>>
>> Sorry, I’m not quite sure I follow—could you clarify what you meant?
>> Here is my understanding.
>>
>> Enabling pins through hardware refers to "the pin is  pulled up by hardware".
>> qcs9075-evk platform use the m.2 connective card, the bt_en always pull up.
>>
>>
>>>> +	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
>>>> +	 * This leads to a reset command timeout failure.
>>>> +	 * Also, add msleep delay to wait for controller to complete SSR.
>>>
>>> Googling "bluetooth SSR" yields nothing, so it's fair for me to ask
>>> you to explain that acronym.. it's used a number of times across the
>>> driver, so perhaps a comment somewhere at the top in a separate commit
>>> would be good as well. I'm guessing "subsystem reset"?
>>
>> Just to clarify, SSR is short for Subsystem Restart
>>
>>>
>>> Konrad
>>>
>>>> +	 */
>>>> +	if (!test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>>> +		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>>>> +		clear_bit(QCA_IBS_DISABLED, &qca->flags);
>>>> +		msleep(50);
>>>> +	}
>>>> +
>>>>  	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
>>>>  }
>>>>  
>>
>> Shuai
>>
> 
> Please let me know if there are any updates. Thank you.

You're expected to address the review comments in a subsequent patchset
revision, in this case please put the answers to the questions I asked
in the commit message, or in the comments, so that someone else can
make sense of the change

Konrad

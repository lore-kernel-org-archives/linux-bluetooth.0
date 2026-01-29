Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E478367F4D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666100; cv=none; b=dkx7jkveVQYnoR8g785OfzXXk7NzK+OPyyeBsIHJ1UvkF2xrGWYz/tvw3T1TePygloB4NGbED8f2YMwjEqIsHML34hTd3j3LymdNifnjBUyoQPb5ia5F3KEaOzUXccDUaGi8wrH5BaCt7oWsvOY4jijRAwEa8miuQ2eVu9Rs7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666100; c=relaxed/simple;
	bh=r3XA5Og69LNwTAiWa13ToEZC9YnQgaU5zqvoo8NeXdc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iPKhiNT+Guk2qC3PUtBFAPp1vbtkBZ2CHGWksxBfTIbSYRvhjhM7zihjd1pCCEf6k09JYM00ry3H4RRirT9RUZRuxjkVrEY0S67sKbl+zfrBG+x06iO+nPatv9oIT1eVt+ph6wUk4xGBJWcI1aXm1enKcLjMmB5ZfXVyTXK1PUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KHRbICd1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W07s7npN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KHRbICd1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W07s7npN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T2olX53143787
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7s/3ecR4fInHAhmiie0O8GBVJeP++a9f0MC03yZDWZY=; b=KHRbICd1t1a0+C2Y
	0q9aNBEWALAkxWRUHtHGFxeo0LXzJYmUT/UTySP8SmDWsjdu2uVY3xLrtgnxPvMl
	MwGhHL+ID9McXdSBUNda7LVT0sDJ0THSmfIFkU9EbRw4x6RProIzBPmXVqb9VPTo
	ueNuKeTC1FJyRsIhZ0O9uxtd9CosFGyw32pntlYGPyyIaeIdqMVpCrxdhQakcO+n
	AID3ANK1rxhjjikAfC3emnDJYRsPiiLlBfLxIazeKXEXw3v9fPIoFvmqaLzViqxv
	q7wBCVwG5kRGqCkK5XT2OQebWCKbs8ssUvmaANVaB5tidZSDkyOW++BWKyKif9dN
	6fRr2g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byqpxhqc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 05:54:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81fdfafe6e9so274154b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 21:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769666097; x=1770270897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7s/3ecR4fInHAhmiie0O8GBVJeP++a9f0MC03yZDWZY=;
        b=W07s7npNKcVuZ0E+nIj5R6x1J1lZv4QeaKIKsVy8yFnMdQ7GxHXOZElL4wTocswLwn
         X8N2YRbZF80c4hraHjTCZXjgRscaiRS21WEhFjPnHxOjE81bV5myOy8bRxtN9i8FAhHg
         pFj25tfCVQel6Z6Xrv2+ilEVRngzqlNbEm1GDjURxB/H/XXoUR/N+mE3c3Rz4PO1nSlw
         I26vKqUIi/95QG2EhV4G0wqZjR2qXb4JbjHiApONO5SPFFIVWy6uFHMCZ4VX7Tz+9VdC
         FdwBelY6ew6SETPloOwNMSCOvARCQ8IXIK9/T8A8bkxkRb6J9wbRFBjivP0wGJMUPwxw
         ByWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769666097; x=1770270897;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7s/3ecR4fInHAhmiie0O8GBVJeP++a9f0MC03yZDWZY=;
        b=E2eCB0uzLTSF9Fq8m5VW+5txXzMSs4mP0v+EU8i/Mh37q+qj3uNUz2ZQ96eVIBPfb7
         euPmn4Z991T0qQiCdJuM1A71DzY3piy/XSavYn+eR2Ijw3hDzpLSNX35vjlDjl4oYl9o
         l6yLr6Qxs9eHQcNB4g1MAVjmfRGlCab0DiIuVPRVgOY9CuS6daLYr8hNkiwJ3IvFNEMa
         SYDFfw3vHQMWOR1rtBdxV4g9UvlpPVDAZ/e8JV3g31OdZZsxcxs+bGXX9VAnM8c2ibQY
         /Vy9kqajEpBFEq2OU/KYwosIlI0p6C1vKrX5GwmVpCnyj167UoibHSlXw9SITo+Swm6j
         EYsw==
X-Forwarded-Encrypted: i=1; AJvYcCVX2pPaGQCWF6Kopl+eGptcKIWl6jD9woPK7qLFa4WtH3Y1AHxG8vhfmZ9WRl3lv/2q6sUCT0H4LiqznsDOUbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpHPRtLQJvVG+NE0HKbMD3hSc1xHQGP2Eh6bDlQr2ibh0/fRlm
	thnHSclvxWOQA+V7HAfsYfxK4GdMZ1tHksdmgmAPRnyIE7+ykiezlGX8BSACWGPjqtjF7Psb4Dg
	Exjtt1AM4hRW/kiAifci4OQt2rAss88J2bDlw9z76pPxKLQaPUPrIkUlNfQh8hKq14SBuTMU=
X-Gm-Gg: AZuq6aIHQ4Rgf0PCIH9W2m0HN0kR7KtH9eDQsTwAICfM/3ZovnGYaqy3AaZTNWb7TdG
	uyFt/b2DrVjBLXP2c9gud2XTaIyrHZ53khoS3cibqq+MsI9O82W8dvVk1AJtFi96IAx/z34dxGn
	xZJ2/FmEIOqsF0pRvSUxs+x6K67O7MvMRhzIwiFxZOY2bY10L5YuOyKh7in1cCcfdp4uixt0l6W
	0Lakd9cyzgHxwVIy/jncZtV8IB0CN/6JRK4K6nBnCSp78Lp8YwT5EXbFufnRQ7xPXu+JpLA70Eg
	HhOAtgeP2DIgbHanbkDDsSuWCvxPw89mmEHIKAw/EFfsb7foMhvD6Ai6CVbYtKIQjpYf7U55W53
	2pIiJUHukeVM+VVMzNFfPZH2FjQYjjHQv/34c
X-Received: by 2002:a05:6a00:9515:b0:81f:9b0a:812a with SMTP id d2e1a72fcca58-8236914d103mr8247034b3a.14.1769666097007;
        Wed, 28 Jan 2026 21:54:57 -0800 (PST)
X-Received: by 2002:a05:6a00:9515:b0:81f:9b0a:812a with SMTP id d2e1a72fcca58-8236914d103mr8247009b3a.14.1769666096548;
        Wed, 28 Jan 2026 21:54:56 -0800 (PST)
Received: from [10.218.16.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22672sm4148529b3a.51.2026.01.28.21.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:54:56 -0800 (PST)
Message-ID: <b57e8263-b7f9-4389-b3e0-468e97a86c53@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 11:24:50 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: [PATCH 2/2] Bluetooth: hci_qca: QCC2072 enablement
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        quic_janathot@quicinc.com
References: <20251217112850.520572-1-vivesahu@qti.qualcomm.com>
 <20251217112850.520572-2-vivesahu@qti.qualcomm.com>
 <xv7zlaoymcuq5kirrgu3thp3trmbdry5maraz34v4tkekinyaf@wgrfk7ukiilk>
 <BY5PR02MB69467A78CA2F2929B6618343F186A@BY5PR02MB6946.namprd02.prod.outlook.com>
 <baa1a047-0866-4e5f-b550-97d43d825c8c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <baa1a047-0866-4e5f-b550-97d43d825c8c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -3da4GfHMGg1EzwD4kUAe09I6xWyL9kG
X-Proofpoint-ORIG-GUID: -3da4GfHMGg1EzwD4kUAe09I6xWyL9kG
X-Authority-Analysis: v=2.4 cv=dfSNHHXe c=1 sm=1 tr=0 ts=697af632 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=cVxSA6WL1EjVwi2A-scA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=M-Yerj1wOn-OpK7r_3ei:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzNCBTYWx0ZWRfX2a7Aa9A1oYhC
 mKmxIaMkcj+XrO1jjhVVThYAsNf/mTqY/EShFf196qRP1OudQO2QLybKCl8caJztHWHFQ0HE3IC
 6mY3U7s8c2YhhX28sGg6uUQis3Y29vfBCKfKKdt5vlJ9+hpgOJc8dZoxjPZBtrX+j2+4cFFL/pz
 UT2A3tFWoaWfZhNtk5cqidcul8yKO3lHOs3/PXuYLnyf/dQ6R5ZOx6tLkE5/yH5MOXEtS7//Fwl
 pqAXLwEiuU7UwPjkSxZHFlBaNrWxpKGvouVn+NrpHYbL7BIOmIMWg4dKHNhsqGrXk3mzrAykvCu
 v4Ijlalyoitv3Y0yskUFIv5AVh3ztG2GgQ4ykzc5vdQSba26sKuBICWJ6UjjUZbsrffK1tLbTPM
 wWBVJEgoXVr6LbCZs37rSod4IvCKok9Rgf4rtEs/dKP5xVw7kezmeOe34ZH9oIwRSld+sXtL3w/
 7zqt5luVONXGjPLdUDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290034


On 1/7/2026 12:50 PM, Vivek Sahu wrote:
>> From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Sent: 17 December 2025 19:59
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
>> Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: QCC2072 enablement
>>
>> On Wed, Dec 17, 2025 at 04:58:50PM +0530, Vivek Kumar Sahu wrote:
>>> Adding support for BT SoC QCC2072.
>>> Set appropriate configurations for BT UART
>>> transport.
>> Read Documentation/process/submitting-patches.rst
>
>
> I'll make the commit message more clear in the next patch set of this 
> commit.
>
>
>>
>>> Signed-off-by: Vivek Kumar Sahu <vivesahu@qti.qualcomm.com>
>>> ---
>>>   drivers/bluetooth/btqca.c   |  8 ++++++++
>>>   drivers/bluetooth/btqca.h   |  1 +
>>>   drivers/bluetooth/hci_qca.c | 17 +++++++++++++++++
>>>   3 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>>> index 7c958d6065be..7eb095db4a1d 100644
>>> --- a/drivers/bluetooth/btqca.c
>>> +++ b/drivers/bluetooth/btqca.c
>>> @@ -854,6 +854,10 @@ int qca_uart_setup(struct hci_dev *hdev, 
>>> uint8_t baudrate,
>>>                         snprintf(config.fwname, sizeof(config.fwname),
>>>                                  "qca/hmtbtfw%02x.tlv", rom_ver);
>>>                         break;
>>> +             case QCA_QCC2072:
>> Please keep the file sorted. Find a correct place to insert your changes
>> rather than randomly sticking them to the end. This applies to _all_ the
>> changes you've made here.
>
>
> I'll address this in the next patch set of this commit.

I just checked that "qca_btsoc_type" enum contains all the soc type 
which need to be enabled

for BT enablement on the target device. There are few places where logic 
of framing packets transferring

between SoC  and Host depends on the which generation of the chip it is, 
refer api "qca_read_soc_version".

And this applies to all the places in the file where i made the changes. 
So can we not sort it ? or you want

me to sort in the switch cases where this chip set is added.

>
>>
>>> + snprintf(config.fwname, sizeof(config.fwname),
>>> +                              "qca/ornbtfw%02x.tlv", rom_ver);
>> I hope to see the firmware being submitted to linux-firmware.
>
>
> "YES", firmware is being submitted.
We have up-streamed the firmware.
>
>
>>
>>> +                     break;
>>>                 default:
>>>                         snprintf(config.fwname, sizeof(config.fwname),
>>>                                  "qca/rampatch_%08x.bin", soc_ver);
>>> @@ -929,6 +933,10 @@ int qca_uart_setup(struct hci_dev *hdev, 
>>> uint8_t baudrate,
>>> qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
>>>                                  "hmtnv", soc_type, ver, rom_ver, 
>>> boardid);
>>>                         break;
>>> +             case QCA_QCC2072:
>>> +                     snprintf(config.fwname, sizeof(config.fwname),
>>> +                              "qca/ornnv%02x.bin", rom_ver);
>> No board-specific NVMEM dumps?
>
>
> "NO", for this BT SoC there is no board specific NVM.
>
>
>>
>>> +                     break;
>>>                 default:
>>>                         snprintf(config.fwname, sizeof(config.fwname),
>>>                                  "qca/nvm_%08x.bin", soc_ver);
>> -- 
>> With best wishes
>> Dmitry

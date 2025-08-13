Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189C23A9AD
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084780; cv=none; b=MfswGV/jucbkYxYfkvPeb7CtJHLWczEQy+rV2B/+Gd/dYZ0LvieF9X66kOEucUbPEO0hx+BTHMKTEpb5L4fux5XK+Y04+mukG4ngaM1b1AZEflj1PFejMq21fQLRFP8y+QNNemFcOJs07LST7WU7rW0NGlSDmYet7cbtdOsgVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084780; c=relaxed/simple;
	bh=/DK8EjIStFJVMNf85xjTr56IMYlO/g4hrr904vleQb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSE3JfbdXm66j+P3tBRJjv/5sffkgBjm0vRCT1T5pz2On/SMUKV+W8iZzszdoo6uBPcV/60+X37iyNZlISZgTr9EG0wSfxC8oGNROHBskM7Qhos68Q6Hi8dKFc5MfV83f1dQwfASdh2x2CKZzRyhMrHRWxwR+Jbyhgomsg9xkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMyzAkIF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMyzAkIF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLeHE025642
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R+WCWb0xAT3kZeVfcQ25akRiZu79Igey9h0WmKab37w=; b=MMyzAkIFPircYJEM
	sTI2DM/GzzpmtqjMC3pcW3Khns7BGhAE0qoyNiZyQRVAiDuOmxevb2Wjuihcc8Bo
	sT9DDkKxv/9YnP0ClNVkqmA/Kge7ITIvROSxRaGuHBjx57BclZA98BI2vtcdh+Al
	D6GecvNN97sv/gt6p+9uiFn5haAEUmU1uW1Bf72oAhpnPnfrZj6QgwOUGBqYYBt8
	WzVJ5vvXlzHuWLs3eWBuoDacfmbvZ73Y552QcvziWxdzyeeuGAR+W8G0fb5IwCjR
	E1wJNmGSE2QEiPgoQEjNd/45Ig0IsXh/wJ/SmEpPeKZtrtjhiP7hnxNvvDpCvY6F
	TBvMGw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gbjt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 11:32:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07b805068so14823711cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 04:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755084777; x=1755689577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+WCWb0xAT3kZeVfcQ25akRiZu79Igey9h0WmKab37w=;
        b=DpYDmGpCtNcg5XlFGcxOePoqetiAmInUGOePEK3XIuyz/cV99fkrSHDaRRwT4z31xe
         dKSVE1IZaQowaTvKcQqw4GBA3bpfTz1WkzpXMUoDO7nX4R/x4fPzkuRTy7WMfDuQTYg2
         gSjLrY3VhQukfgiKVOrPht7PXNEfHjwDxJhdHk1nj3CNYPWGjtBJwLHRAZP5hGU5VlzT
         z73jS7hJALmRUtce9Yz3GlfMY2a2BbsM9O5LrQhHZTJWT5sbSrziBuL2TjhDq5f26ElL
         BzDuWfMw1fQ8drf2SeRTRVIvxwHVueV8cUrMjsUD7karoMOffKqAPuUbocUFFvD5bvw1
         oK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoRDYkt+w0qH7tN6cZ8mhTKHhMV+KLSTqB8YDEUA9jJawKiGE/LMOcYSQSmtzF5eD9xr0xv0X2sSdDL4gdk8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/TOlMMwxP0AR4U1gZtt0ehEYUod1lCZXjA4Af9pM+Cg1SXko
	LSyQmyr/RxJN7yLn+SihiPqyku180Pna5AMRbL3gkSPdZFdaJw8wMzFD5Z07ExMfaEh804gfxCg
	RUA+HchEHNq5sYV+uqO5+3OFBWKcpxUenYYJ2ky9obB30Ys9R5hbteivsIucDcF84hylXTpo=
X-Gm-Gg: ASbGncsFWlTdadXOY01wOX8XTr1o5NdJQGX9xvNnOQL4AE8iZNh84qdsScMXOmHdPPO
	3Y7eWtGjob1GK2tw+OOTiEkDIxJ6TxzlSgKmcj2H5+uZrxoK1wSX1UgDAcpeGQ1pa4U09c7Iyea
	RQpSS4/XEXhG5zlGsyhi89xYthCbdrij3PMP/tw6x0PcFkZsAInRPUVj/V/kKn4wJ4zQ8QmVbPD
	4SkKlXj8jd/PTaf2Q+CQ5L1Xl1mItQCHDzNFsRJ3c6KxgncwxJL+FOwEHvIsTbd8UVdOnrQLspF
	NoJnyJfVtRSZtwaMHCPmMYxoT3inzH514WpzUqqCBwDDVd4oFpRef5nPc75U1/laI0SCHhVJZCJ
	Hn35MakNf9MJLs3GSVA==
X-Received: by 2002:ac8:5816:0:b0:4a9:e46d:ca65 with SMTP id d75a77b69052e-4b0fc68e540mr16953221cf.3.1755084776773;
        Wed, 13 Aug 2025 04:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL7Gt+vlJwdtBhKpm+LovS/uNMV3gu7X/kPBN7TkUPHIGctsx82OloJMBlgBn7gBMnWyXNyg==
X-Received: by 2002:ac8:5816:0:b0:4a9:e46d:ca65 with SMTP id d75a77b69052e-4b0fc68e540mr16953011cf.3.1755084776263;
        Wed, 13 Aug 2025 04:32:56 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3bd2sm2365143966b.54.2025.08.13.04.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 04:32:55 -0700 (PDT)
Message-ID: <c2493fca-dd5f-4721-b2e6-17fdcd8ebe81@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:32:54 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] driver: bluetooth: hci_qca: fix ssr fail when
 BT_EN is pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc: quic_bt@quicinc.com
References: <20250813033505.3868781-1-quic_shuaz@quicinc.com>
 <20250813033505.3868781-2-quic_shuaz@quicinc.com>
 <77881d50-c044-4aae-bd0a-5265e0db51cc@oss.qualcomm.com>
 <532d8aa9-34be-486b-b477-dd72389d8703@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <532d8aa9-34be-486b-b477-dd72389d8703@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689c77ea cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=kcVZ-7Km3AzTPoQvaRQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX2N7gM3MVFzq2
 22ff9FTiojrB/1quFn8kZKuMt2dI7v4zvWCci1Ng313qvbFwYnIphOQDmV2b5rx70KoZ6sUQo7Z
 SfJ1QItKK7lC5jLajhoZ3X6UspOsLMzW6Cr/x3QL3RJ6YAtcFeRhX+/9Ddcx2Uwlm1x0tVYOO8a
 HzokO6Ij63RJ/LyaiPVPZiO8QpoRzUES7GUSR3SYXL7ewNA1oK9vDHi202wvQOMKQriJrFNH05E
 SSgQ2V0HBXRZjrumdyWANtZm9TqE4k4OaMwntPka80dvlt2xtFbBk1bNcXpeynNq+VPHRF2DTMZ
 B/71UESyHE8vPh6au+USe4FKI1PZHqN3aoMVC3k3UfAi3wbNiws7YDPdNMjgztZriVYjTZlAUSD
 4FB/mysm
X-Proofpoint-GUID: VD9h82NnnVLmxqb_NegjQEo16-0k_k5J
X-Proofpoint-ORIG-GUID: VD9h82NnnVLmxqb_NegjQEo16-0k_k5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/13/25 1:28 PM, Shuai Zhang wrote:
> Hi, Konrad
> 
> On 8/13/2025 7:05 PM, Konrad Dybcio wrote:
>> On 8/13/25 5:35 AM, Shuai Zhang wrote:
>>> When the host actively triggers SSR and collects coredump data,
>>> the Bluetooth stack sends a reset command to the controller. However,due
>>> to the inability to clear the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits,
>>> the reset command times out.
>>>
>>> For the purpose of HCI_QUIRK_NON_PERSISTENT_SETUP, please refer to
>>> commit: 740011cfe94859df8d05f5400d589a8693b095e7.
>>>
>>> The change is placed under if (!HCI_QUIRK_NON_PERSISTENT_SETUP)
>>> because this quirk is associated with BT_EN, and can be used to
>>> determine whether BT_EN is present in the device tree (DTS).
>>>
>>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>>> ---
>>>  drivers/bluetooth/hci_qca.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index 4e56782b0..14b2d1bee 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1653,6 +1653,19 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
>>>  		skb_queue_purge(&qca->rx_memdump_q);
>>>  	}
>>>  
>>> +	/* If the BT chip's bt_en pin is always pulled high by a dedicated 3.3V
>>> +	 * power supply via hardware the driver
>>
>> weird line break
>>
>>> +	 * cannot control the bt_en pin of the SoC chip, then during SSR,
>>
>> "System on a Chip chip"
> 
> I will modify.
> 
>>
>>> +	 * the QCA_SSR_TRIGGERED and QCA_IBS_DISABLED bits cannot be cleared.
>>> +	 * This leads to a reset command timeout failure.
>>> +	 * Also, add msleep delay to wait for controller to complete SSR.
>>
>> 50 is a random value, I also see 300, 100 across the driver.. where does it
>> come from?
>>
> The controller requires 50ms to stabilize after power-on,
> so we wait 50ms after the coredump completes

Is that common for all controllers supported by this driver?

Please #define this value somewhere

Konrad

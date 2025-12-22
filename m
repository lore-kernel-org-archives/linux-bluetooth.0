Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9F2D879F
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431699; cv=none; b=d7HsOIl6FdpUdQoOGXKYxykq7GOuAmY8qonYmsbfBpQidHhXvGI6nJLd1vwfNTBziwZxB9RSDgZ1HH6ktIlVzZIh5tkxBhWrVis9aMJ11Zb8QOGsOw7ZBgcOY1WgxdC65KXL4IIm5qo8a0xADfgRUjKWCI5crNgQ5seu5Q36NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431699; c=relaxed/simple;
	bh=2k635sB6PprnXrGvbgqCgB4yo1zDiRQXxMZw7CMedoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZOXmadrivbe5PK2WTF1bdhCniY+fYIPdWU90vOYwgGZHesiXUUrnGZe8639LaR1vgFXDAq+OE/NiSnuP1q7Lm2NumrRiLSdnwDFS5hoRG6QTsHKtt4gL8QBF8W8ZVbztL99Ah1CyJgW0i9HMlPJVsa05nJGngqvezFVwFpYKUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=deMNAui7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fbd8eH0f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="deMNAui7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fbd8eH0f"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMEC9rb1351363
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 19:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UFzCzI/VJABVQYE45JCIOqixdIa6UaPkAQLrfUq3110=; b=deMNAui7Vpat/0/u
	JjvEqjgjX7GY5MurwqOTDFUKPIWCidXh73DNcWHQBa1/C89+Yfhq0lW65dDFH/dB
	iMsLUvJZNscR+3thf9Nw0ZLK0FH1ugsmNTNYFBrpdieaGKTmsXCv8Cy0ZW2st0d8
	D/VvRFpA8KYm7N4gsdKrrghsWptXUzOWG9wutyle1uu+BNc1frNN20DhuGrJdtlV
	OI9Qwd1ZNxAIOV+BU1k2Rp0nIF1jY9Vn+zszV99koBUt7Qx6gVqEqH+51dYaDH+V
	c51ovsJxyLlPwj2mQ0weMPAjsdGr8DlPwIr755tfopj6AZfGXAyij7ViHnCvVKHl
	fg1+6A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b69ahmcad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 19:28:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7c240728e2aso9111070b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 11:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766431696; x=1767036496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFzCzI/VJABVQYE45JCIOqixdIa6UaPkAQLrfUq3110=;
        b=fbd8eH0fLkhbJ0GN6bZdw98ZWArd+uPvUx1KQ719kDv0ID8qoVh6ZNC3/oVP91L+Qr
         fX8kO/6cQ206Pns1t0WWfj21NWsuDjKjTBcQyIdYRhyoq2L+4unD+k5ZqoAeu63xWWt5
         V23oRIRCqJDPbH3GWS9Yx0iBy7rw6zTR/wmPz0W7/08koDhzngwMmZmUPh8xrOZS/dO2
         HrEWgI5OZKiqjHUlmLSesQoTn+M/Fwq1df99oALRmv9sjpX1aIbZhoSqfRxZKQrrUjUV
         X2qYq1npwLTPMYQmeX5BB/sXwZC5p8M2vtjzL0Ro5Kx5HbO3OQaEwcj7nOSdJV2nDbKX
         60+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766431696; x=1767036496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFzCzI/VJABVQYE45JCIOqixdIa6UaPkAQLrfUq3110=;
        b=pId8uiy3Bq1xEjzu55+lNBjyaRq+bfdEjB7sIlUewwpMk9omiu/ErCHitTMmf/QfCs
         HMIVCbxvLTTKgPv2D26/rJZEgrw91cy3OJpaQKepgVGsLLOJAss4TIl29hQLCRnTZrl3
         tPbQjFKwQp8awCTMKdkExDHhF5PMoVJUMGilZXNSCjHx7m32xn4zfSj7hw9HF+SDv09x
         YYJxER11HnLDMyCk82yhXYCw3uN773eZtaSmvKveRj+uK4fZLxmFdubrtFgPLKT7x3gW
         jnSuMlUeB2eN8uFViB1bzIcSzp4Siy1Usi2OJ2cyOs+mUNODWWdfS6jNyNFg0jHHqShP
         6hCg==
X-Forwarded-Encrypted: i=1; AJvYcCUKKOqcXD7JGd6ymSAhpPmSdeNqQ3RxIhluFO5IjhiUu6FLIkWXvsLkpRNC2TWJLEm4sq2pcHRJFSVJgWIZqpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNqf0cXktxTQKwa+TcGp75hPPkjRnq4jA9EiSlRjrOdGs2RZk
	50agkFP9nJAanKl+YwCXYIotTGOaK207JFAJ4BFrLln4e6X00C+BVQzgU+fvOStEB5+JGGd5nOv
	PqmaCZhMHJYJRswqqnW3zhl3tDUGKOSI7klgfsY3Rc3ECYOm+dC5U7bypapkenUGpXk0pUBKgl8
	Kc6Y8=
X-Gm-Gg: AY/fxX5ppBaKeoHHl1JyoVnW8Vws18vF5TJfgFWKKFQak2TLx1W4iU4u+xUllaEfBB8
	CVibzsg8ua7SgWBDGAkcPCJdP1LDeuOPg+UrKz9mnTLEeScGHncehPMEr/sAXGlN0zYYC5wZKNW
	cfKZQ68DjDK9h7TP6YH8q6/SzPJj+7cfIepW/aPsQp4q/OiInsxoVZ53yKaPVWWwuB19bySWV8J
	CJ/HARjVc+sb6FPrgBdJmEtvoZFo4TPuVQCuaY5FnI+OSFLeOrSsn/8/N/23bVNdgedkDD+46o9
	hwjl2FzAv0u0KEI+yhpdswh/l/MhP/l8dQNdcmX94IWh77uFAAqALgdIm8YcNeJxaampiISPGOS
	2ePAKKvMKLUblzeAhxYSTipVXaKMa8NvE7ywh
X-Received: by 2002:a05:6a00:348a:b0:7e1:730a:613b with SMTP id d2e1a72fcca58-7ff64ec6724mr10458279b3a.31.1766431696097;
        Mon, 22 Dec 2025 11:28:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi25zmLmXjhuithVs2qJ0N0NGT2etsD8/rLv2pbTf7SyPONxiaX/1t22yB2ch/zWHj/NUPog==
X-Received: by 2002:a05:6a00:348a:b0:7e1:730a:613b with SMTP id d2e1a72fcca58-7ff64ec6724mr10458261b3a.31.1766431695547;
        Mon, 22 Dec 2025 11:28:15 -0800 (PST)
Received: from [10.216.63.63] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cd07sm11249751b3a.46.2025.12.22.11.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 11:28:15 -0800 (PST)
Message-ID: <4e8a2486-ac33-496d-9862-9b69afc2ff5d@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 00:57:57 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fixup! Bluetooth: hci_sync: Add LE Channel Sounding
 HCI Command/event structures
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20251219162820.320823-1-luiz.dentz@gmail.com>
 <CABBYNZLuSFMttw2XU+F8+-YGL=yfhoWE1=jj3b5Dq9QYG4rAZw@mail.gmail.com>
 <CABBYNZJEe3ow1xNRgFrUcJCZgTyGEvgtTZpTzxenmnChxijL+g@mail.gmail.com>
Content-Language: en-US
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
In-Reply-To: <CABBYNZJEe3ow1xNRgFrUcJCZgTyGEvgtTZpTzxenmnChxijL+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JuH8bc4C c=1 sm=1 tr=0 ts=69499bd1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9R54UkLUAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=6K7NGPEXEEqZGr8oa4cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5hNPEnYuNAgA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=YTcpBFlVQWkNscrzJ_Dz:22
X-Proofpoint-ORIG-GUID: GjLuLJqQvFbZkXmT1XL-2KAwBVy8oH2M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE3OCBTYWx0ZWRfX74jMYtVlE1V/
 nbySH3LcR8nwlc6PP0XwetJ+mg5BCdY7gdztNeiUY/umnsodpaJUaGI+fGaedgfu8B3JXRGNieb
 n03knDZwEHJlBHVtxcSkbw/m4KEJX/qE20uo7lIHUnhj7yX0EyxoVoR74oAUpAG0uFpJ9JXpiLj
 eBxKvz9oYVmRfIIVRSDXascqZd4q0a0s8DM100lU8EgBspg5ZCH7ZfyhRvE4ysOyqCqFUQomM2v
 rZZDSvFJPZ+IPUwFtrIX1HPI44FGHaJoQ8ZhqRWAVwV+d1D4/7P3jMGZktgrTg9wjLVHcbKpN0z
 MoiYdluuOnMayJG3lCxakAFG8qg8ndO8WxesEksCHqFGeFAWsjfiatSCfngAQ49K5l10Z0Fwim7
 mGmGU5+3c+feBmsxDycne18n3i+T7NhyiXVCR64acPuhOt+zimguYY8/3N8GKfcnBL2HT/zWn7G
 lUuVZbml3/ca4rcADKg==
X-Proofpoint-GUID: GjLuLJqQvFbZkXmT1XL-2KAwBVy8oH2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220178

Hi Luiz,

The patch looks good, we have checked internally on the setup as well.

Thanks and Regards,
Bhavani

On 12/22/2025 8:23 PM, Luiz Augusto von Dentz wrote:
> Hi Naga,
> 
> On Fri, Dec 19, 2025 at 11:30 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Naga,
>>
>> On Fri, Dec 19, 2025 at 11:28 AM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>>
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> ---
>>>  net/bluetooth/hci_sync.c | 38 +++++++++++++++++++++++++++-----------
>>>  1 file changed, 27 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>> index 5de98be752bc..ab0b68faa61c 100644
>>> --- a/net/bluetooth/hci_sync.c
>>> +++ b/net/bluetooth/hci_sync.c
>>> @@ -4570,27 +4570,43 @@ static int hci_set_le_support_sync(struct hci_dev *hdev)
>>>  }
>>>
>>>  /* LE Set Host Feature */
>>> -static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
>>> +static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u8 bit, u8 value)
>>>  {
>>>         struct hci_cp_le_set_host_feature cp;
>>>
>>> -       if (!iso_capable(hdev))
>>> -               return 0;
>>> -
>>>         memset(&cp, 0, sizeof(cp));
>>>
>>>         /* Connected Isochronous Channels (Host Support) */
>>> -       cp.bit_number = 32;
>>> -       cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
>>> -
>>> -       /* Channel Sounding (Host Support) */
>>> -       cp.bit_number = 47;
>>> -       cp.bit_value = le_cs_capable(hdev) ? 0x01 : 0x00;
>>> +       cp.bit_number = bit;
>>> +       cp.bit_value = value;
>>>
>>>         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
>>>                                      sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>>>  }
>>>
>>> +/* Set Host Features, each feature needs to be sent separately since
>>> + * HCI_OP_LE_SET_HOST_FEATURE doesn't support setting all of them at once.
>>> + */
>>> +static int hci_le_set_host_features_sync(struct hci_dev *hdev)
>>> +{
>>> +       int err;
>>> +
>>> +       if (iso_capable(hdev)) {
>>> +               /* Connected Isochronous Channels (Host Support) */
>>> +               err = hci_le_set_host_feature_sync(hdev, 32,
>>> +                                                  (iso_enabled(hdev) ? 0x01 :
>>> +                                                   0x00));
>>> +               if (err)
>>> +                       return err;
>>> +       }
>>> +
>>> +       if (le_cs_capable(hdev))
>>> +               /* Channel Sounding (Host Support) */
>>> +               err = hci_le_set_host_feature_sync(hdev, 47, 0x01);
>>> +
>>> +       return err;
>>> +}
>>> +
>>>  /* LE Controller init stage 3 command sequence */
>>>  static const struct hci_init_stage le_init3[] = {
>>>         /* HCI_OP_LE_SET_EVENT_MASK */
>>> @@ -4618,7 +4634,7 @@ static const struct hci_init_stage le_init3[] = {
>>>         /* HCI_OP_WRITE_LE_HOST_SUPPORTED */
>>>         HCI_INIT(hci_set_le_support_sync),
>>>         /* HCI_OP_LE_SET_HOST_FEATURE */
>>> -       HCI_INIT(hci_le_set_host_feature_sync),
>>> +       HCI_INIT(hci_le_set_host_features_sync),
>>
>> Let me know if you have any comments regarding this change, I'm
>> planning to amend the original change since it hasn't been pushed to
>> next-next yet, this has been found by:
>>
>> https://netdev-ai.bots.linux.dev/ai-review.html?id=999e331e-1161-4eec-ad26-fafc3fea6cfd
> 
> Any feedback?
> 
>>
>>>         {}
>>>  };
>>>
>>> --
>>> 2.52.0
>>>
>>
>>
>> --
>> Luiz Augusto von Dentz
> 
> 
> 


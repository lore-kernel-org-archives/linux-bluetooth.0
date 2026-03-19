Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7FE3A169B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773906099; cv=none; b=XNLddx1mClZu8NXDXkQxR3DfDrz5dghWxKKeYmL8qgRWZL6KaFdgLWr0GHh9V3245tkqs4ZCIJ7KMJZ0jJ9AkmA7wnsY+Cuse67ZeRKmGYW259ayFS1VrWhIfarDGbNdyUWaHGj7DZI/rmFj/1wsySaI2m+HqWOK9zuUpVmT8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773906099; c=relaxed/simple;
	bh=4XY4jhDNLOeV30flJno2DJ0Bwr/A5l+U4+9fRcDaERc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nk3+bWG4htZb4oogjUCHSySmLjMErqkJIYNH2aCcBmpVGRtX8WKwHpiuyKTR0RBHMS9PzpEstYTmCo77+dkNpHbtIt8vBC/2GAGTH0oW2a2Ni+Buhjiew5vmXy5C9i/mqVf/YMtm71bM8D0VcQQ0Apk6Mgs0Vl99xVF1Hk9W3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJhSKKrD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dzwGCzXC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJhSKKrD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dzwGCzXC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J73w983368480
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 07:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DOdtLeifiZXyGLwU/u9IRGKQWOfb3XrDub6omvdNpvU=; b=bJhSKKrDKeY8h6R4
	poHFwovSXWwe2AfU2HGk/EgQSojQdNP/Rb8fPnNK8VhmrbpZtkZQ1wByyX1oLLpE
	aGAB3SarfIp2jVy4TmpDUwHyvt8Cpj4YD/Gx6SHOgXQASUjT+65hbOUdnu5KJFZh
	+FwnKXYMqYsFTrwM3EquIvgzZszLtUBMnY9Bk6LHrz2mlS1JFZ6rAJXYoVWb6d1E
	ycwGwRCOLtfOKvr1ULuKLf/v1c8S3BkMGvwaLxanNdj7q/5zqigCV0AnVW6pbU+X
	xnihnfv5MECrnrU8EsEDcVhpHpGblysxCh6WjZI4tnRw2devAzOQPK7dLHj28BlR
	fxICZg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9j88c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 07:41:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bead0a9123so19950182eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 00:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773906095; x=1774510895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOdtLeifiZXyGLwU/u9IRGKQWOfb3XrDub6omvdNpvU=;
        b=dzwGCzXCrBN5oQEE3R77W16QPEb68oO5xgcpxKX4K7yHvqtaWhmjq4UQL2G6Juw4zr
         YV0usRiVLnB7MhBK45lyTHeWXiDq1vXZfj1Rnx9JGsl7RF5P+cPc2tfAHaMU0eTp5kVB
         /61ZmFdKEazCAXsFaYS9tWZBNj30Cu0CuxqCd2rVyiLlTPjp5sPFfWIC4oAfovfRxOvz
         Ahw3Uj0xV1mWgFfBgjKWbqKK+XLbs18Q5JeJpVLM6oCNm8n5rxsbjU5vB+F2mMqm6iRp
         x14B2HGpCwolz+ePngptLI2TYY3zIPwFYGmRmGQmsG7mGDnTkg92CtEIC1fQqvUKA/jk
         rOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773906095; x=1774510895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOdtLeifiZXyGLwU/u9IRGKQWOfb3XrDub6omvdNpvU=;
        b=rHomUf4D+rCEhItDxFsdZEiJmVq55NFew/izvzs6W/sOGkMuGfgLyNHaGn2rGwRHmn
         zWXrxvBPc3bvfqsHRmexosFcWBpvA2tnBdoHtfOzO1EnalXZOFvLAPAGn58EL/2vC8tF
         v/HKXUiT2yJ5oZX4x5inrJ50jiiMvd2vXsAOq+ujNhCRdGBiD+6cySOmW4rS949cwdIO
         l0tVwidadAYGrPJZK/WvTgF4VxZRb0mNSjGd5lBOmqJZsf5yQ/PJj7lUVC1UncNTZIo0
         5Gh8ZwRo0v1tMXUbr4ylhVBsprtOCIDRNTvfmAihACSa1wHBCbEiL1MFTtx1v/5QGMXW
         /xQg==
X-Forwarded-Encrypted: i=1; AJvYcCUb3J5SI3L+o6oAA8en04444FqDS4dCIT+gwOS6XqoqXUQhdag8Kpm3XpvLrzpdZzI7DdhIvd+K5VEAv9YJip4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qRrkRUuy4FdVJrve2cCGcYDlT6ELEsrO1jU1bVxJiv/HPySu
	wJ2bO8rM3AJAIbELDhbiutJIuB0fvfkmI489H8HXKF3j2zOMlR/m79Zupp2dLZwJ3GAGhxUR0IR
	dSd8pDdSoVB6avWkphOnVV3hbqA0mNveE1fHNVEBqUfa/CFpNGGXVQWVJHzFCZ2l0NKXiP+Y=
X-Gm-Gg: ATEYQzyCKqXBKHo/AdKGcnkuX8nCIM12s3hbbRAlPkgfKbyNcMfWXDviMeeIus9UmYh
	7bXyJ+RIHNJpP+1P3CIviyyclstRi90hCZhyc4wODXuuaa0YVnHHHeCvJYYFEEQ5CEsivShYjHb
	i/pOQAu4/ze4TXjoDgLzPoWsswYi7rJkIWXrM34SF2XVhSdY6lcTyEqB71nLV2v5ZEYnsFOxES/
	9TyFzoXgH5+kDDwzS1g+Wd1Rn5+3afLgXUqeUVe33gyQc02TQtomwcFLfOLFs18CGIGGg0XJmHc
	JEknw620T6Co/fMG4k1XB1fma+mbh/vnSQImL81CnE4MFFEJLPSCaR1GLreHCsoRT5odsqdhCae
	l0P6wsWt11/sA/GlfcXMfrSw0Hhb/uQECYrG+P2GD5fQBwuF4Sa2QCYyyTyl9akFD0grofxGM8B
	g=
X-Received: by 2002:a05:7301:168b:b0:2be:1544:5c40 with SMTP id 5a478bee46e88-2c0e508312amr3097568eec.31.1773906094962;
        Thu, 19 Mar 2026 00:41:34 -0700 (PDT)
X-Received: by 2002:a05:7301:168b:b0:2be:1544:5c40 with SMTP id 5a478bee46e88-2c0e508312amr3097552eec.31.1773906094396;
        Thu, 19 Mar 2026 00:41:34 -0700 (PDT)
Received: from [10.110.94.9] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55a0d4asm7167389eec.20.2026.03.19.00.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 00:41:33 -0700 (PDT)
Message-ID: <6c0fef1c-9c81-4586-81b2-54702a5b0bd7@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 15:41:29 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: disable power control for WCN7850
 when bt_en is not defined
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260319031040.4096297-1-shuai.zhang@oss.qualcomm.com>
 <mcjloavd6jhinb2wgfwihsdtbay5n7zv52tn63kzrabcqwyp26@mh5aet76kl7t>
 <1603a5b0-8edd-4c31-b2d1-344ee7df10ac@oss.qualcomm.com>
 <whqo7o6fu6mytf3hpdrrirptx3fpprnp25as3dnam6n4fo7tjq@dolksuaq4irz>
 <4d6d2597-df3f-4421-8760-ea59a46a3b39@oss.qualcomm.com>
 <qc543ugvjtqp6wbsrtycne25xwiyx37blqq3wj6herzwpcuj6k@p3ydpkh3emld>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <qc543ugvjtqp6wbsrtycne25xwiyx37blqq3wj6herzwpcuj6k@p3ydpkh3emld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA1OSBTYWx0ZWRfX0SPhGbmMklSi
 LFd+9wXHZcuXyj+6wxeNJYDVXujgcK8lBBgfNvw29TQCThiutmy76/FCTYIsb1HA5a7wf/QqZ+m
 VEKxXKyLhlRipMwQ+950jiYxK7luIuF7+SA7sXe94RWQFzv6X/epggTa6Z9xLTPLy9yOQUdd/ef
 xW6WIZsdjrsJbq/+SwSsbStB3rx2FPvP690bfgeDZGT28HAKxa45m91DuklcTsr1ARgQBXsqZBg
 oaKlulzu8nNhcxxJMCAceY1L+SNPT3w8A+ZwYFjUGR54qFAoyXtGbs/CpQVqiVOYrEtM0HMJWmj
 psAwG3sfXknjdupWobpflu7DyDQvcKC/8GT5sK+61jet5/bDd8RsWKidckCq7Dp33Kw6az/hm4o
 93WLVI1MkWO5CWJ2IyuqfB4+YmxupgLblLCf3Df3R9yxxBZpcOFWRdIgFsO95+jWXXtVbD81Nyz
 NsrMfnJTUxTXMy3acbw==
X-Proofpoint-GUID: bC37sdUXx-GbS8NhjD7NvZsneK2XMZ4O
X-Proofpoint-ORIG-GUID: bC37sdUXx-GbS8NhjD7NvZsneK2XMZ4O
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bba8b0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=AjXXxhxKq0fdEwWQdOQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190059


On 3/19/2026 2:44 PM, Dmitry Baryshkov wrote:
> On Thu, Mar 19, 2026 at 02:06:49PM +0800, Shuai Zhang wrote:
>> On 3/19/2026 1:42 PM, Dmitry Baryshkov wrote:
>>> On Thu, Mar 19, 2026 at 01:21:58PM +0800, Shuai Zhang wrote:
>>>> Hi  Dmitry
>>>>
>>>> On 3/19/2026 11:51 AM, Dmitry Baryshkov wrote:
>>>>> On Thu, Mar 19, 2026 at 11:10:40AM +0800, Shuai Zhang wrote:
>>>>>> For platforms where the bt_en GPIO is not defined, software-based power
>>>>>> control should be disabled when power is managed by hardware.
>>>>> What does it mean for this chip, managing the power in hardware?
>>>> bt_en is pulled high by hardware,
>>> In which cases is it applicable?
>>
>> On platforms using an M.2 slot with both UART and USB support, bt_en is
>> pulled high
>>
>> by hardware. The current platforms are Lemans‑EVK and Monaco‑EVK.
> This needs to be a part of the commit message.


I will update.


>
>>
>>>> or described in the device tree as a
>>>> regular always-on GPIO.
>>> Why?
>>
>> This is equivalent to bt_en being pulled high by hardware,
>>
>> and it applies to the same scenarios and platforms mentioned above.
> No, DT would not describe the GPIO as always-on in this case.


Yes, understood. In this case, bt_en is pulled high by hardware and is
not described as an always-on GPIO in the device tree.


>
>>
>>>>>> Add QCA_WCN7850 to the existing condition so that power_ctrl_enabled is
>>>>>> cleared when bt_en is absent, aligning its behavior with WCN6750 and
>>>>>> WCN6855.
>>>>>>
>>>>>> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
>>>>>> ---
>>>>>>     drivers/bluetooth/hci_qca.c | 3 ++-
>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>>>> index c17a462aef55..4512ff7cd0c0 100644
>>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>>> @@ -2484,7 +2484,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>>>     		if (!qcadev->bt_en &&
>>>>>>     		    (data->soc_type == QCA_WCN6750 ||
>>>>>> -		     data->soc_type == QCA_WCN6855))
>>>>>> +		     data->soc_type == QCA_WCN6855 ||
>>>>>> +		     data->soc_type == QCA_WCN7850))
>>>>>>     			power_ctrl_enabled = false;
>>>>>>     		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>

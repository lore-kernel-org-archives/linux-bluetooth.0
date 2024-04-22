Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09211175AB
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765663; cv=none; b=JX6s5lhEBou7ZsLgoOFBCGGyX1VvlzX5g0YnKjYIWMJUzMqymXUl2Yaf8J8icmJKtrOinrA1Kagw3rYgyqH4ZK+iOVm69WzCfPpP3FCu+7brT5h20eg0Dn0coQQi4FWdGpBPckMkG6ogYzJRwBH5WYm/Syz19fio3pQWdMcjtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765663; c=relaxed/simple;
	bh=vsBsDFPk2EyFSL8oSu4sfbqfCJYCnbysUhYNGLQIexY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lWaVWv69AJ/ab+bfZ87IcsOGvlSBq4ZQJZ4WsY4UjI5DGNVESvbWV2M6BebVipUkNFdyB4lg2U+i96+4YQpatvyRqzDwua1tSTdvghsNBCFYpfSQ8Hz5IWD4kWhVev6wzbFSZS5LkDJpxpIFg3PqHvwunj6TW2AWcMtipac1RCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oO94mBpB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oO94mBpB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M3nc2S027616;
	Mon, 22 Apr 2024 06:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rgSOq3Phu/uBp++uMXCbBLO0hqPkS6qMTB0mj8ZSpzk=; b=oO
	94mBpBStzAgg0LcL+mCYM56d9e6aVXnffYvH4Bb071WkE2i5d1pfzSnrxPR1U3wv
	EqGHWQu+Y1sxTqLL+PMY6daEItYhYjzv2OV7uXJTAJb6qjHjsNimPu4FN4eGy4En
	qgfasdC78A9ffW5ePz8lMf6vsbHgW7fSb9cgeQsWDKsfREQPSdzNvieUjeW1s1VQ
	z669Oiek2uyLfMrbICmvp2vnV6s7KK1k/laN2kHWsrlu7GW8dE4pkYEKEIb19yrr
	f4ImHh8oNOgb6d0GaRjY+QNmwVzr/E1/skZhDm4JBbZZ/yYR5DZb/teK5cj/BpVl
	0qXQfVxN0TOpyD0axToA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5sx3ceq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 06:00:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M60i8C008672
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 06:00:44 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 21 Apr
 2024 23:00:42 -0700
Message-ID: <d31eeab2-d66c-4e9e-a66a-747e24497ba1@quicinc.com>
Date: Mon, 22 Apr 2024 14:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix two regression issues for QCA controllers
To: Krzysztof Kozlowski <krzk@kernel.org>, Wren Turkal <wt@penguintechs.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <regressions@lists.linux.dev>
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org>
 <a6ae69ad-b602-4cfc-9f76-8932f357d30b@kernel.org>
 <c0f7036d-c129-400b-85a2-1414ec3d2622@quicinc.com>
 <2bd1f1bf-f867-4430-8ce5-c691485665e1@kernel.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2bd1f1bf-f867-4430-8ce5-c691485665e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2dlWpggMJq94OdNpl22ho8tOidIj_2wX
X-Proofpoint-GUID: 2dlWpggMJq94OdNpl22ho8tOidIj_2wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_03,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220027

Hi Krzysztof,

could you list questions i need to explain within commit message based
on current v4 patch sets ?

let me send v5 patch sets with updated commit messages.

On 4/22/2024 1:52 PM, Krzysztof Kozlowski wrote:
> On 22/04/2024 02:14, quic_zijuhu wrote:
>> On 4/22/2024 2:41 AM, Krzysztof Kozlowski wrote:
>>> On 21/04/2024 09:44, Wren Turkal wrote:
>>>> On 4/20/24 3:06 PM, Zijun Hu wrote:
>>>>> This patch series are to fix below 2 regression issues for QCA controllers
>>>>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>>>>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
>>>>
>>>> @Zijun @Krzysztof and @Bartosz Would it be helpful for me to test these 
>>>> to ensure they fix the issues I reported?
>>>>
>>>
>>> I look forward to someone testing these on other hardware, not yours. On
>>> the hardware where the original issues were happening leading to this
>>> changes, e.g. RB5.
>>>
>>> Anyway, the problem here is poor explanation of the problem which did
>>> not improve in v3 and v4. Instead I receive explanations like:
>>>
>>> "this is shutdown of serdev and not hdev's shutdown."
>>> Not related...
>>>
>> this is the reply for secondary issue. i believe i have given much
>> explain for my fix for the 2nd issue as shown by below links.
> 
> No, you did not.
> 
>> let me add a bit more explanation within the ending "For the 2nd issue"
>> section, supposed you known much for generic flag
>> HCI_QUIRK_NON_PERSISTENT_SETUP, otherwise, see header comment for the
>> quirk. also supposed you see commit history to find why
>> qca_serdev_shutdown() was introduced for QCA6390.
>> https://lore.kernel.org/all/fe1a0e3b-3408-4a33-90e9-d4ffcfc7a99b@quicinc.com/
> 
> You did not answer my questions.
> 
> Let's quote:
> 
> "i don't explain much since these HCI_QUIRK_NON_PERSISTENT_SETUP and
> HCI_SETUP is generic flag."
> 
> Srsly, what is such answer?
> 
> 
> 
> 
> 
>>> "now. you understood why your merged change as shown link of 4) have
>>> problems and introduced our discussed issue, right?"
>>>
>> this is the reply for the first issue as shown by below link. it almost
>> have the same description as the following "For 1st issue:" section.
>> i believe it have clear illustration why the commit have bugs.
>> https://lore.kernel.org/all/2166fc66-9340-4e8c-8662-17a19a7d8ce6@linaro.org/
>>> No. I did not understand and I feel I am wasting here time.
>>>> Code could be correct, could be wrong. Especially second patch looks
>>> suspicious. But the way Zijun Hu explains it and the way Zijun Hu
>>> responds is not helping at all.
>>>
>>> Sorry, with such replies to review, it is not worth my time.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi luiz,marcel
>>
>> it is time for me to request you give comments for our discussion
>> and for my fixes, Let me explain the 1st issue then 2nd one.
> 
> You keep pushing and pushing even though I stated my remarks.
> 
> 
>>
>> For 1st issue:
>> 1) the following commit will cause serious regression issue for QCA
>> controllers, and it has been merged with linus's mainline kernel.
>>
>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>> with gpiod_get_optional()").
>>
>> 2) the regression issue is described by [PATCH v4 1/2] commit message
>>   as following:
>>   BT can't be enabled after below steps:
>>   cold boot -> enable BT -> disable BT -> warm reboot -> BT enable
>> failure if property enable-gpios is not configured within DT|ACPI for
>> QCA_QCA6390.
>>   i will verify and confirm if QCA_QCA2066 and QCA_ROME also are impacted.
>>
>> 3) let me explain the bug point for commit mentioned by 1), its
>>    commit message and bug change applet are shown below.
>>
>> The optional variants for the gpiod_get() family of functions return
>> NULL if the GPIO in question is not associated with this device. They
>> return ERR_PTR() on any other error. NULL descriptors are graciously
>> handled by GPIOLIB and can be safely passed to any of the GPIO consumer
>> interfaces as they will return 0 and act as if the function succeeded.
>> If one is using the optional variant, then there's no point in checking
>> for NULL.
>>
>>  		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>  					       GPIOD_OUT_LOW);
>> -		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>> +		if (IS_ERR(qcadev->bt_en)) {
>>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>  			power_ctrl_enabled = false;
>>  		}
>>    3.1) we only need to discuss how to handle case "qcadev->bt_en ==
>> NULL" since this is only difference between the commit and BT original
>> design.
>>    3.2) BT original design are agree with the point of above commit
>> message that case "qcadev->bt_en == NULL" should not be treated as
>> error, so BT original design does not do error return for the case and
>> use dev_warn() instead of dev_err() to give.
>>    3.3) the commit misunderstands BT original design and wrongly think
>> BT original design take "qcadev->bt_en == NULL" as error case,
>> so change the following flag power_ctrl_enabled set logic and cause
>> discussed issue.
>>
>> For the 2nd issue:
>> 1) the following commit will cause below regression issue for QCA_QCA6390.
>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>     serdev")
>>
>> 2) the regression issue is described by [PATCH v4 2/2] commit message
>>   as following:
>>   BT can't be enabled after below steps:
>>   cold boot -> enable BT -> disable BT -> warm reboot -> BT enable
>> failure if property enable-gpios is not configured within DT|ACPI for
>> QCA_QCA6390.
> 
> You did not address original issue of crash during shutdown and did not
> clarify my questions.
> 
>>
>> 3) qca_serdev_shutdown() is serdev's shutdown and not hdev's shutdown()
>> it should not and also never get chance to be invoked even if BT is
>> disabled at above 2) step.  qca_serdev_shutdown() need to send the VSC
>> to reset controller during warm reset phase of above 2) steps.
> 
> Anyway, any explanation providing background how you are fixing this
> issue while keeping *previous problem fixed* is useful but should be
> provided in commit msg. I asked about this two or three times.
> 
> BTW, provide here exact kernel version you tested this patches with.
> Also the exact hardware.
> 
> 
> Best regards,
> Krzysztof
> 


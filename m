Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4544158A39
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951607; cv=none; b=R7muSiYgOq7zCJ5SLKk4VNmYyulmXIe9YFe47ODWWIJSmC7mdn32CuW1w5a/PfOZd/Aa7SzF4MZLfsCv5Cfphj4/1munOI1tzcQ0th3Aakfj1t/AHcLlspiFYXW1LxqO7rv5FFyhh6pB8TOV1YJ8VehvkC3zFY4/mCvZwjDejjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951607; c=relaxed/simple;
	bh=k02VL5M9Kpdt+vEDex9ip+a6AUaL17FOmiPyP/Z34fs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mqcZADEtblgoZnpmxEr58bHWJH9Jc8LZBd+ipTWK4pWdmkP1k+o8ue/3pJQ0Duak/JsltOw0DvHhq8LxwspUdzgSUYMYg4kgA8qW+H85Aa7U9WNMaNSqGnMhtw1hmPpSJFfYQ+vBJQqJ3O9N85nJqLqOCYIAHUOiBdNV3C6pStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W2uyjn0T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W2uyjn0T"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6XoJ5017535;
	Wed, 24 Apr 2024 09:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7pjQyNml58Li82tlGgEzCvvWNJctybg3hWRNYHFGEms=; b=W2
	uyjn0TBAnLPIR5K8OdEpvgttuqMJHP8a/l7LhplPjlZsZTT/T8bMzoOABo8S2WiU
	V3ogjRAWIqHOMVyyxMHUWaysD4CMilLroVva+i4u15S3+MYe/49SGaR480Up+JPc
	5mXwVDVp2/P3IfdQnL1oEZUd45BMm6ZdcbAPYc5H4xnMug0wYC7VGRo28jSbg32m
	rnkXT0yR0oUxUhCQfsrPQcNUQLcLS4X7HuD96AaW6kw471/armqKjT4dgIL/SGgL
	LPO2p1bcJumtEtvGEmXD65CNKakpTfGscm431bkhGhK5wHWXPaXgUQs0P00/rRIv
	P8CBoauBNaGnroIXXg4A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fgf17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:39:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9dZ0b005543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:39:35 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:39:28 -0700
Message-ID: <b3d8e1de-3beb-46a2-817d-ee0fdd614b0a@quicinc.com>
Date: Wed, 24 Apr 2024 17:39:26 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
From: quic_zijuhu <quic_zijuhu@quicinc.com>
To: Wren Turkal <wt@penguintechs.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <regressions@lists.linux.dev>, <kernel@quicinc.com>,
        <gregkh@linuxfoundation.org>, <stable@vge.kernel.org>
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
 <a8a7e3df-44c6-4fa6-a576-da384c02e9ac@linaro.org>
 <067db05d-56bc-4ca3-aef1-bc3bae47667c@quicinc.com>
 <c1fc9c28-25df-4d41-9ae6-c5d079ea805d@penguintechs.org>
 <0db77c30-5be2-41b5-adf0-fb4436b9107b@quicinc.com>
 <c9bf22a3-2549-4cf1-898e-8a9adcd2f0f6@penguintechs.org>
 <d77455b2-4fb9-4ffc-acf9-c24b5a0f4a45@quicinc.com>
Content-Language: en-US
In-Reply-To: <d77455b2-4fb9-4ffc-acf9-c24b5a0f4a45@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CODFupZpRRNiuRke86eVUqRJiJZGU1tI
X-Proofpoint-GUID: CODFupZpRRNiuRke86eVUqRJiJZGU1tI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240041

On 4/24/2024 2:01 PM, quic_zijuhu wrote:
> On 4/24/2024 1:49 PM, Wren Turkal wrote:
>> On 4/23/24 10:46 PM, quic_zijuhu wrote:
>>> On 4/24/2024 1:37 PM, Wren Turkal wrote:
>>>> On 4/23/24 10:02 PM, quic_zijuhu wrote:
>>>>> On 4/24/2024 12:30 PM, Krzysztof Kozlowski wrote:
>>>>>> On 24/04/2024 06:26, Zijun Hu wrote:
>>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>> with gpiod_get_optional()") will cause below serious regression
>>>>>>> issue:
>>>>>>>
>>>>>>> BT can't be enabled any more after below steps:
>>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>>>> if property enable-gpios is not configured within DT|ACPI for
>>>>>>> QCA6390.
>>>>>>>
>>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for
>>>>>>> this
>>>>>>> case as shown by its below code applet and causes this serious issue.
>>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>>                                                  GPIOD_OUT_LOW);
>>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>>         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>>>      power_ctrl_enabled = false;
>>>>>>>     }
>>>>>>>
>>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>>
>>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>> with gpiod_get_optional()")
>>>>>>> Cc: stable@vge.kernel.org
>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>> Link:
>>>>>>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>>> ---
>>>>>>> Changes:
>>>>>>> V6 -> V7: Add stable tag
>>>>>>
>>>>>> Stop sending multiple pathchsets per day. I already asked you to first
>>>>>> finish discussion and then send new version. You again start sending
>>>>>> something while previous discussion is going.
>>>>>> you concern is wrong and i am sure it don't block me sending new patch
>>>>> sets to solve other issue. so i send this v7.
>>>>>
>>>>> i have give reply for Bartosz' patch.
>>>>>
>>>>> i hop you as DTS expert to notice my concern about DTS in the reply.
>>>>
>>>> Are you saying here (1) that you identified a problem in the DTs that
>>>> you hope Krzysztof notices or (2) that you want Krzysztof to notice how
>>>> your description of way that DT declares the gpio as required affects
>>>> your proposed change. As a native American English speaker, I am finding
>>>> your text hard to follow.
>>>>
>>> 1) is my purpose. i have given my concern about DTS for Bartosz' patch
>>> and hope DTS expert notice the concern.
>>>
>>> my change don't have any such concern about DTS usage. that is why i
>>> changed my fix from original reverting the whole wrong commit to now
>>> focusing on QCA6390.
>>
>> Let me try to parse this. If #1 is the correct interpretation, does that
>> mean that the DTs are wrong and need to be changed? Do you expect K to
>> do that since he's the "DTS expert"?
>>
> for your 1) question, NO
> for your 2) question, need DTS expert notice or suggest how to handle
> case that a DTS property is marked as required but not be configed by user.
> 
>>>> I think you are saying #2.
>>>>
>>>> I just want to make sure I am following the discussion here.
>>>>
>>>> wt
>>>
>>
> 
Hi Krzysztof, bartosz.

do you have any concern for this patch serials?


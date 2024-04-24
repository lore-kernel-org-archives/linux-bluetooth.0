Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BC15B0FE
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952484; cv=none; b=GhKWzfGzoFsSatExjfbFihBA3QUaKOmtIJDS+JydkB5wksCfbrHJcvbMMugje/pMlC0oAZZB/DU/xkNHfLfNTb4AjiTv04zb/xEJDeQkigj3viFMeap1Gg3v+ILhUKxUIaFnEFmSAo3FrNkDPefR3JLkbh5zI+11aoQsZ9uLJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952484; c=relaxed/simple;
	bh=GtJ9qbIf8qOQlm087aSF1ACf6Gxa4voXkL67hQmqgGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WjKmIRXAnHrW4ZqgBWEcymm0HtLeQqnTyISTNhgHXe7jg5vEpw6OCSdp3JmyQ/l550WiLVdN4hT2BJqCiXp1W38snQi4Peu6To3KV8beyVSzk3/SwXbmlmxxDQsVirXHwTtHQ7Wvt9919gH7I5KGD1DtXF03j5xV394Le/4cuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eGZfrNHi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eGZfrNHi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6XxnD016973;
	Wed, 24 Apr 2024 09:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bHcS+bF2hbPtSstQ0fZ6ZgTFExxQA+fRwUntmDafLuI=; b=eG
	ZfrNHinA7/eueDmYxzlZGW2poxkKq1CxMN2ySNXJ3UhptL8DBigrRO0A/S/hya3B
	pZDwZ1flHgOyL4eNiR1M5Hd5L8X6SrvSd2P/7Q24piCGIvcnAj+BtjArG65+EXio
	O/q1blqx2aJYrPz3FLO4jD2//OTbK7ByJ8neC+8ZsUUtlGHWFoXMhAvonaGgBemE
	gC9epS/bQ+f39tmpeYEuP/AMZejZSO8pebiTF454xTeSzlSINfBT8vuJ8E4A7aI/
	B7jU4OfIBR+5hEegOkuJSSAFXKlYBAdcidjNe1h92Y8QgGhJM1fE4D7vLktKVy8I
	ZTIdwQeMDZSo1E1ZLDoQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e0fxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:54:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9sWOf005272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:54:32 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:54:27 -0700
Message-ID: <3052bc86-dc47-40d0-95ac-988c9c9df48e@quicinc.com>
Date: Wed, 24 Apr 2024 17:54:25 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wren Turkal
	<wt@penguintechs.org>, <luiz.dentz@gmail.com>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
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
 <b3d8e1de-3beb-46a2-817d-ee0fdd614b0a@quicinc.com>
 <9e8e8607-dc12-4371-af4e-16786b13a13e@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <9e8e8607-dc12-4371-af4e-16786b13a13e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OvlGKyJlCf8G8ssWUhen9M_d7HHCFM5Q
X-Proofpoint-ORIG-GUID: OvlGKyJlCf8G8ssWUhen9M_d7HHCFM5Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240041

On 4/24/2024 5:48 PM, Krzysztof Kozlowski wrote:
> On 24/04/2024 11:39, quic_zijuhu wrote:
>> On 4/24/2024 2:01 PM, quic_zijuhu wrote:
>>> On 4/24/2024 1:49 PM, Wren Turkal wrote:
>>>> On 4/23/24 10:46 PM, quic_zijuhu wrote:
>>>>> On 4/24/2024 1:37 PM, Wren Turkal wrote:
>>>>>> On 4/23/24 10:02 PM, quic_zijuhu wrote:
>>>>>>> On 4/24/2024 12:30 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 24/04/2024 06:26, Zijun Hu wrote:
>>>>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>>>> with gpiod_get_optional()") will cause below serious regression
>>>>>>>>> issue:
>>>>>>>>>
>>>>>>>>> BT can't be enabled any more after below steps:
>>>>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>>>>>> if property enable-gpios is not configured within DT|ACPI for
>>>>>>>>> QCA6390.
>>>>>>>>>
>>>>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for
>>>>>>>>> this
>>>>>>>>> case as shown by its below code applet and causes this serious issue.
>>>>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>>>>                                                  GPIOD_OUT_LOW);
>>>>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>>>>         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>>>>>      power_ctrl_enabled = false;
>>>>>>>>>     }
>>>>>>>>>
>>>>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>>>>
>>>>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>>>> with gpiod_get_optional()")
>>>>>>>>> Cc: stable@vge.kernel.org
>>>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>>>> Link:
>>>>>>>>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>>> ---
>>>>>>>>> Changes:
>>>>>>>>> V6 -> V7: Add stable tag
>>>>>>>>
>>>>>>>> Stop sending multiple pathchsets per day. I already asked you to first
>>>>>>>> finish discussion and then send new version. You again start sending
>>>>>>>> something while previous discussion is going.
>>>>>>>> you concern is wrong and i am sure it don't block me sending new patch
>>>>>>> sets to solve other issue. so i send this v7.
>>>>>>>
>>>>>>> i have give reply for Bartosz' patch.
>>>>>>>
>>>>>>> i hop you as DTS expert to notice my concern about DTS in the reply.
>>>>>>
>>>>>> Are you saying here (1) that you identified a problem in the DTs that
>>>>>> you hope Krzysztof notices or (2) that you want Krzysztof to notice how
>>>>>> your description of way that DT declares the gpio as required affects
>>>>>> your proposed change. As a native American English speaker, I am finding
>>>>>> your text hard to follow.
>>>>>>
>>>>> 1) is my purpose. i have given my concern about DTS for Bartosz' patch
>>>>> and hope DTS expert notice the concern.
>>>>>
>>>>> my change don't have any such concern about DTS usage. that is why i
>>>>> changed my fix from original reverting the whole wrong commit to now
>>>>> focusing on QCA6390.
>>>>
>>>> Let me try to parse this. If #1 is the correct interpretation, does that
>>>> mean that the DTs are wrong and need to be changed? Do you expect K to
>>>> do that since he's the "DTS expert"?
>>>>
>>> for your 1) question, NO
>>> for your 2) question, need DTS expert notice or suggest how to handle
>>> case that a DTS property is marked as required but not be configed by user.
>>>
>>>>>> I think you are saying #2.
>>>>>>
>>>>>> I just want to make sure I am following the discussion here.
>>>>>>
>>>>>> wt
>>>>>
>>>>
>>>
>> Hi Krzysztof, bartosz.
>>
>> do you have any concern for this patch serials?
> 
> What? Amount of noise coming with this constant ping and dispersed
> discussions is really annoying.
> 
sorry for ping you. i really hope this fix can be merged ASAP since the
wrong commit have been drifted into kernel mainline, i have talked about
this fix with you and bartosz too much for this only total 7 line
change. i really hope got your code review results, accept or rejected
or neutral?

> Best regards,
> Krzysztof
> 
> 


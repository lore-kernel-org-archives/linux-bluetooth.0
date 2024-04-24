Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE715B15C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966825; cv=none; b=e6KAeX3vOI+n1a99MYnncUOx4DJBY6hBwr00uxlK8U7WFUz5Q8EYj01v1XMBAzf+IPZ7LHt9u1Wr00uh69Gdw5pVyREgQhtcfrhPG3Qi3GD46cEe9HS7oZB+qXAIsaTxUn3ucKX/HHwMKLwwtKwtZlbX5zCsRTGDTqOEj6qSyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966825; c=relaxed/simple;
	bh=iMccbFzSb4k+De5lA6iDY6So/y0kD4nl14xw5NLAhpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bNLo9TN8BpR1XPoBm2VGqk9U3Soin9qkA1SIbijUy+QWZi/Ql2YzTf/nUmW26sKrZtdouT3itLYjP3gL51ni6nhdtw8fSCmOIr6JdxZ6NoTrHdRWJJHaKzxcLdLll/stakFQjKmN3iOFam52vBaKYm/Py92uXtId28I4IgfwO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MGT5JXvw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MGT5JXvw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OCI50L010538;
	Wed, 24 Apr 2024 13:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zJFerHqVA1ze3S9j9MlPtcLOtXkt7FfzZAIAd7b1OB4=; b=MG
	T5JXvwC/9R6d74FDi17qq87dyz1EZKuWYOTn2jyeD6KjE+Wi0eLDyX9yQkQ2G2+i
	9tl3g1v5q2bJ2dhMsWkmGvpwNc0ePDShTGmp72CPVR397wbP6ptP4zkoPeX5XNV1
	n4SJuu0yCWmCCHBZM64fVKmt9tmggnYzzbbluNpFVjL/VUjmFBnnDlb1067MJBf/
	WgyX5ddtwy2mMObPJoakbflrBb4OtSCx6Au0pqUxdCJUT8rS81N3XRWyvUpV7Zqk
	5Bs/Hc1qpaaYM+KnIFmPRjYmMA5D45olmj4W7h0GemI0jpOVDNqT9yuZaxLj470c
	tg0S1YbAmyYbJMbbb3rw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e0yfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:53:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ODrZHf006916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:53:35 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 06:53:29 -0700
Message-ID: <38736db8-eec4-4ebd-b4c4-4b404cea6e42@quicinc.com>
Date: Wed, 24 Apr 2024 21:53:27 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "Luiz Augusto von
 Dentz" <luiz.dentz@gmail.com>
CC: Wren Turkal <wt@penguintechs.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
 <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
 <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
 <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
 <CACMJSeuWQE4t2KDCRP7n-DeHN9Ndn1bE_KCRc-X2kmM9L2i7_Q@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSeuWQE4t2KDCRP7n-DeHN9Ndn1bE_KCRc-X2kmM9L2i7_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AXB7axKjtV57IV7omVatta0mobrxCk_9
X-Proofpoint-ORIG-GUID: AXB7axKjtV57IV7omVatta0mobrxCk_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240047

On 4/24/2024 9:52 PM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 15:49, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Wren,
>>
>> On Wed, Apr 24, 2024 at 1:04 AM Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> On 4/23/24 9:31 PM, Krzysztof Kozlowski wrote:
>>>> On 24/04/2024 06:18, quic_zijuhu wrote:
>>>>> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
>>>>>> On 24/04/2024 06:07, quic_zijuhu wrote:
>>>>>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 24/04/2024 02:46, Zijun Hu wrote:
>>>>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>>>>>>>
>>>>>>>>> BT can't be enabled any more after below steps:
>>>>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>>>>>
>>>>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>>>>>>>> case as shown by its below code applet and causes this serious issue.
>>>>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>>>>                                                 GPIOD_OUT_LOW);
>>>>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>>>>          dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>>>>>  power_ctrl_enabled = false;
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>>>>
>>>>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>>
>>>>>>>> No, Bartosz' patch should go.
>>>>>>>>
>>>>>>> what is Bartosz' patch.
>>>>>>
>>>>>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
>>>>>> mailing lists do you receive that you lost track of them?
>>>>>>
>>>>> Bartosz' patch have basic serious mistook and logic error and have no
>>>>> any help for QCA6390, and it is not suitable regarding DTS usage.
>>>>
>>>> Really? Why you did not respond with comments then? Considering how
>>>> imprecise and vague you are in describing real issues, I have doubts in
>>>> your judgment here as well.
>>>
>>> Please slow down here. Zijun's patch works and Bartosz's patch does not.
>>> I don't think Zijun means any ill intent. I am replying to Bartosz's
>>> patch right now.
>>
>> Ok, that is great feedback, so I might be picking up the Zijun v7 set
>> if we don't find any major problems with it.
>>
> 
> Luiz,
> 
> Please consider my alternative[1] also tested by Wren. Zijun's usage
> of GPIO API is wrong.
>
why is it wrong ?

> Bart
> 
> [1] https://lore.kernel.org/linux-bluetooth/CAMRc=MfJ1v3pAB+Wvu1ahJAUvDfk3OsN5nieA-EYgTXPwMzqyg@mail.gmail.com/T/#mbf94795476d21df0a24441470ce02def9d2970a7


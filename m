Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF915D5D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966711; cv=none; b=CvVcZSKClc47L7vlh0gjiN89VxIHD767caxFLS0H9Qbv/oAv2o55/70AqWrzeH019DcEqsC+WWgT7OfaxPJxb1qcA68vI4svxfcXTp84tGr4eEYpWIyLXhMdDuIM3XYWC9RKVTc4DZ7ncROopIcTtiuggcnu4x5Oypx3YWayJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966711; c=relaxed/simple;
	bh=ZICW/Zn6kXqORCiQ6XtyX8SwAO5B06fgYS1H4pGwQrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JFj8fGkrgHXO5Ln9k402A22iuXgPbikp8xxMNYY3uAFSQH1ODtosEyR4pMUjEmsjC5s6YMIK6H+s3xPjjV/AyDjKq7SdcpoQOdbex4ynLhVRA4/AyzfN1D3tsEs82rTuIIkKiOGPVzhGplCtBLXtfv3WRcQMS228WsENC18ugho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mPt88pTa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mPt88pTa"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OBxAY8015100;
	Wed, 24 Apr 2024 13:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xzq5BnhbUGPOzbGh0tVnRBnGsc+sAfEZgvPTLSJRBcw=; b=mP
	t88pTa542x3puc3rF0tTZCcN3fvJv71l44I1BLn5koLwMVXWjvJ39bXVhrp+jiFx
	TV4Ep1BwLRRBJ/4o5A2U0GWgxAKU3dFHPf2WcZRGOrdQFRADf+4olaNEtUB1iHoL
	6u/09PbEFruErxLxbzIMAnofGm73OmPcAl7RPE7Maph82RQMB5lMSX/dMiriF3E9
	fHJCwH+7Ro+WzA+HIfOSZkIJcXOE5uSppIl4GAG1LuGkiLBKzfjXtAOfTAR5ZRQB
	3j4QMrbzjgwat5i5NWeYNaeYBWZFaVD/VXrSlxh+l5kKi7pd57fDu+A+kQQMYslg
	czfGP+lea1EO83IB+V4g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9ph01w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:51:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ODpfUH010002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:51:41 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 06:51:35 -0700
Message-ID: <bbfbe6a7-a689-4c8c-8adc-1b4488bdce7c@quicinc.com>
Date: Wed, 24 Apr 2024 21:51:33 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Wren Turkal
	<wt@penguintechs.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <regressions@lists.linux.dev>, <kernel@quicinc.com>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
 <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
 <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
 <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZJLCPaLTaFEfeTEn+2FpxLS8Z-W2kT1ry4jKB_W=XYNjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D-4jZkdp1eTa5dfwElRZT1IOQMppljE-
X-Proofpoint-ORIG-GUID: D-4jZkdp1eTa5dfwElRZT1IOQMppljE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240047

On 4/24/2024 9:49 PM, Luiz Augusto von Dentz wrote:
> Hi Wren,
> 
> On Wed, Apr 24, 2024 at 1:04 AM Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 4/23/24 9:31 PM, Krzysztof Kozlowski wrote:
>>> On 24/04/2024 06:18, quic_zijuhu wrote:
>>>> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
>>>>> On 24/04/2024 06:07, quic_zijuhu wrote:
>>>>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 24/04/2024 02:46, Zijun Hu wrote:
>>>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>>>>>>
>>>>>>>> BT can't be enabled any more after below steps:
>>>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>>>>
>>>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>>>>>>> case as shown by its below code applet and causes this serious issue.
>>>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>>>                                                 GPIOD_OUT_LOW);
>>>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>>>          dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>>>>  power_ctrl_enabled = false;
>>>>>>>>    }
>>>>>>>>
>>>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>>>
>>>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>
>>>>>>> No, Bartosz' patch should go.
>>>>>>>
>>>>>> what is Bartosz' patch.
>>>>>
>>>>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
>>>>> mailing lists do you receive that you lost track of them?
>>>>>
>>>> Bartosz' patch have basic serious mistook and logic error and have no
>>>> any help for QCA6390, and it is not suitable regarding DTS usage.
>>>
>>> Really? Why you did not respond with comments then? Considering how
>>> imprecise and vague you are in describing real issues, I have doubts in
>>> your judgment here as well.
>>
>> Please slow down here. Zijun's patch works and Bartosz's patch does not.
>> I don't think Zijun means any ill intent. I am replying to Bartosz's
>> patch right now.
> 
> Ok, that is great feedback, so I might be picking up the Zijun v7 set
> if we don't find any major problems with it.
> 
thank you, we will start to fix this issue for other product customer
have reported to us with different fix.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> --
>> You're more amazing than you think!
> 
> 
> 


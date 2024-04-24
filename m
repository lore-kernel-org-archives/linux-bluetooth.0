Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141B13D8AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932352; cv=none; b=j618NJ94Sh8R3luZzgeTdOeuoABKOuBhL/oTpEdlW17DGOplwk3r01sSRfZUN7N9mUeqQ6fPSJZwPBwOX0S0BK539uKM95pFwTzub8rdi7PxuHsjgw75sYOCcPCOF5OVFlpmX8RCHlWCwpdEUrcfkHAFPrRfP1OAb1k00IHhTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932352; c=relaxed/simple;
	bh=t6Vs+Adi7U9dYly8XLt2We68w/CsrEUp7MRF9zippVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OpzgtR218WI8xVFzsctFeUvo5M4VJChgdnxgJxEKjQBixnls7kfwL2iPMAvhUhWp51UiyPkMg3wzP2xd8e/R1UKRfj1kt3ba9bURii+PICcd7K1ywC1/p1ppvWbIycIXzrYN6znCjHA5S69IbLDLFCh4a6dSYS1EpVzAGC0q0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DY+YvcyJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DY+YvcyJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O3vB5x000655;
	Wed, 24 Apr 2024 04:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WYLGRBsYPZNz11GramX6LhfryD/0GD9Bdl6ZrSIW50U=; b=DY
	+YvcyJ4Choac2JbHyHISjiL1qJSU+/1qSa9wz775vse4gtNhbwHCGTDus+HSFVXv
	eVmY+jNUGHtFnAzir3Eh3tauNa20fxwqKv23rybrEQAWpy4565Um3ZWrf44GsYtX
	BCI3553yyBg44EjY2GtxCsWv+R1M9KGCxX7/6nCjrAcf6JK5eN6L90PXX4Tdcpkk
	mQx6jkZLptYJK/cRTuDplONaoebnOx/byN8OUZe9L/mx/675nwVRt83gq9ErxA5y
	UTvRWfkppk5h7mzPRTk2QFxz/Fz7aVvBXOp341YWV/pDXgVXZqMUpAegq03Oz4tA
	Ez8/wIRRW9VS9ebuH5qw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtncg7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:19:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O4J2rd025683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:19:02 GMT
Received: from [10.253.72.119] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 21:18:56 -0700
Message-ID: <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
Date: Wed, 24 Apr 2024 12:18:54 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
 <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S0Yu5egBUGLWe9YRniQ7pBYbJVlAR8Qk
X-Proofpoint-ORIG-GUID: S0Yu5egBUGLWe9YRniQ7pBYbJVlAR8Qk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_01,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=977 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404240017

On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
> On 24/04/2024 06:07, quic_zijuhu wrote:
>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>>> On 24/04/2024 02:46, Zijun Hu wrote:
>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>>
>>>> BT can't be enabled any more after below steps:
>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>
>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>>> case as shown by its below code applet and causes this serious issue.
>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>                                                GPIOD_OUT_LOW);
>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>   	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>> 	power_ctrl_enabled = false;
>>>>   }
>>>>
>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>
>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>
>>> No, Bartosz' patch should go.
>>>
>> what is Bartosz' patch.
> 
> Srsly? You were Cc'ed on it. How many upstream patches on upstream
> mailing lists do you receive that you lost track of them?
> 
Bartosz' patch have basic serious mistook and logic error and have no
any help for QCA6390, and it is not suitable regarding DTS usage.
if below link is Bartosz' patch
https://patchwork.kernel.org/project/bluetooth/patch/20240422130036.31856-1-brgl@bgdev.pl/


do you really code review for Bartosz' patch before give your
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> Best regards,
> Krzysztof
> 


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AF28EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933236; cv=none; b=CsonJSWGT0u8Cxk9i+rXCWprSEPNMih0PhJnVOgeJUh8Dji8Ndg55vte3GjWUotR0iZ9xVrIaNckO4BGqZob90DUwaN/AlvL2lJuwToYjBMDjulcbeJuYTBM+8FTiMZo9p0SJGlEO7LaLzDvmEOqRRNj13AtThPm02YxDpKv5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933236; c=relaxed/simple;
	bh=qJjvU9FghQa+BRvERA6jaEaxICFi5lAHc3Tny7rCchY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SSyl0GEQsrfgWmbsmYi5SySB2hXrIYP2iaUvABcXG59RcXpigoMgx9R1IB7I5of0hgUT15IJUeUKfv4QRoqXYyFKDREnNQU7abXirWYzi9A/ei7dxREvYdHVZmX9D9wPcmBTGamQGL9rGYRbNwrTgZr2Hdgbi0ZUBA+7iXMWpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TBr1CtkU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TBr1CtkU"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O2RD3P016118;
	Wed, 24 Apr 2024 04:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6841+HhpC7c49E8pR4qcVJzGEbZv8LlpapEAr5MWKcE=; b=TB
	r1CtkUtB7KJlOEJwaWFfD7sLOp1w76/Mtzzm6ZzIzolmb3knLxIpcs4Qg7DkqDQW
	TPDOwYJjIw7c4MxEtiv+fs2SwNaCsni/92CXmbSKaUwS79NTl+BaV+eQlGlbFQ1y
	9JekKCQ4oTt+f4xxGEhGOO0/hmuAMesWA0ZCAZAbJPzn/AUmQRiY1Caxm79ULTEY
	HV2Ebp72W0qIw3XKWVwX3YQu+aKd+5kYEbnp0+cPV4Y2b1FCPzEYjS0EL6ZowDOo
	2AEzAcwsazVW0XL5cuD2Dqu/Bdl+UhfeVZObRMk1KQsSjWpXaVrT74YQ0ui1HZt9
	MPDexaEJCvfGfN/U61Dg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp6n2kchx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:33:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O4XkcA025391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:33:46 GMT
Received: from [10.253.72.119] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 21:33:41 -0700
Message-ID: <e01e19f5-f8fc-4cf4-9882-bc687b338f30@quicinc.com>
Date: Wed, 24 Apr 2024 12:33:39 +0800
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
 <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NNJcHcMnkPjOG2pxocBIzAPnq_bRWUT6
X-Proofpoint-ORIG-GUID: NNJcHcMnkPjOG2pxocBIzAPnq_bRWUT6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_01,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240018

On 4/24/2024 12:31 PM, Krzysztof Kozlowski wrote:
> On 24/04/2024 06:18, quic_zijuhu wrote:
>> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
>>> On 24/04/2024 06:07, quic_zijuhu wrote:
>>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>>>>> On 24/04/2024 02:46, Zijun Hu wrote:
>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>>>>
>>>>>> BT can't be enabled any more after below steps:
>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>>
>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>>>>> case as shown by its below code applet and causes this serious issue.
>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>                                                GPIOD_OUT_LOW);
>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>   	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>> 	power_ctrl_enabled = false;
>>>>>>   }
>>>>>>
>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>
>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>
>>>>> No, Bartosz' patch should go.
>>>>>
>>>> what is Bartosz' patch.
>>>
>>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
>>> mailing lists do you receive that you lost track of them?
>>>
>> Bartosz' patch have basic serious mistook and logic error and have no
>> any help for QCA6390, and it is not suitable regarding DTS usage.
> 
> Really? Why you did not respond with comments then? Considering how
> imprecise and vague you are in describing real issues, I have doubts in
> your judgment here as well.
> let me give comments for this change now.
> Best regards,
> Krzysztof
> 


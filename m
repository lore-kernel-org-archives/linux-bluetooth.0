Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF51879
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714099533; cv=none; b=uXrgQMQxCCmDxm6aEuKzT4vBM2KdQFLU/UyFbwF2A9wPwKmOZfRvZKaPKDezSV+sOar75G6itH3fDTMySwC8CuInMDFj/6VsKIh8s5x8LBKirHvu9lL764MRQ7JKd11rm0EeBHovJ66KaaxaULX7GOllQ2PL1D/Kj6vJpfzXI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714099533; c=relaxed/simple;
	bh=Uh15HOXdVPTXlOc1wcePfZ+aybRFyXt+28ErjxGscc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZOa/AswP8bCwNc9w3zmrZ54eBFu4P6hhWqBtXPerADaAXreYrMjLa1UaILu9BNsp41XudwCS8rSxLvpllKZKu4+0sAKlYz9Q5777BW7lotUlAHH4ck1Ekj7OvLYEYAJi6G5qXLUo39KUQuN6LEahQEpnLoA4fG/5IQQB/yxRuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HZAsBwMR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HZAsBwMR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q1BdDQ028099;
	Fri, 26 Apr 2024 02:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DI7GxnJPjKmih5BwPgdk3yn0NGBLhLa/++djMIvNyTU=; b=HZ
	AsBwMRSHJzLmFBqpCqNW1NhCGLEcN0K74fmJ7kc1J6ouv6NSBdogoDW/f3A7ZJBt
	wt2CzVhaHaugGaEkImc9ipRRjo4xHrB7tFCYxmnjhZcxHs4s+RUDRTvPNJhMKvmb
	qpjlf8a42ChB1qpCuTuG5mZhMPGjwqE0hfWwpM1clckLvamkeyGClRy+g+vCFBUZ
	jFuvEm+00fjJEn29eqTrHGVLcYaLReV4MIhnJlnWaLP1bUWAls1QaggBl/RrhJk+
	0iP2BOh/00z/b4WybHZNwIPP3jgp4qB35K0I6OVT21+ugZMMp0wgaEiB1c1KiKVb
	nwWZVcm/ENKNV0P+cRPw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenh46j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 02:45:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q2jIGF006187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 02:45:18 GMT
Received: from [10.253.14.224] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 19:45:12 -0700
Message-ID: <3d61680a-79da-4a5b-a5c8-feb6f41bd5a6@quicinc.com>
Date: Fri, 26 Apr 2024 10:45:09 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Elliot Berman <quic_eberman@quicinc.com>
CC: Wren Turkal <wt@penguintechs.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
        <bartosz.golaszewski@linaro.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>, Greg KH
	<gregkh@linuxfoundation.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
 <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
 <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
 <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <053f51ae-1eb7-4ea8-bb04-38bfa1e0b8f5@quicinc.com>
 <20240425103329807-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20240425103329807-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uLgcg69HNtqgMPCt2htnuzPCT_DOcMq_
X-Proofpoint-GUID: uLgcg69HNtqgMPCt2htnuzPCT_DOcMq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_03,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260015

On 4/26/2024 1:37 AM, Elliot Berman wrote:
> Hi Zijun,
> 
> On Wed, Apr 24, 2024 at 01:33:50PM +0800, quic_zijuhu wrote:
>> On 4/24/2024 1:04 PM, Wren Turkal wrote:
>>> On 4/23/24 9:31 PM, Krzysztof Kozlowski wrote:
>>>> On 24/04/2024 06:18, quic_zijuhu wrote:
>>>>> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
>>>>>> On 24/04/2024 06:07, quic_zijuhu wrote:
>>>>>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 24/04/2024 02:46, Zijun Hu wrote:
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
>>>>>>>>> case as shown by its below code applet and causes this serious
>>>>>>>>> issue.
>>>>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>>>>                                                 GPIOD_OUT_LOW);
>>>>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>>>>        dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>>>>>     power_ctrl_enabled = false;
>>>>>>>>>    }
>>>>>>>>>
>>>>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>>>>
>>>>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
>>>>>>>>> IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>>>> Link:
>>>>>>>>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
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
>>>
>> this is reporter's latest verification results. actually i don't have
>> much time for kernel upstream. i really hope my fix is able to merged
>> ASAP, it will help us to solve other possible impacted QCA controllers.
> 
> I saw you were planning to slow down for a minute. When you're ready to
> work on these patches again, let's get them reviewed internally first.
> Please check go/upstream for some helpful hints.
> 
thank you @Elliot for your reminder. i will learn go/upstream again
before next upstream, and i will request for internal code review before
do external upstream for further upstream.
thank you Elliot again.

> Thanks,
> Elliot
> 


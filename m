Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4363215AAB6
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967290; cv=none; b=RV4GQrkIwqkWChefIUmbWMafQVzAt4GvTNyoxozyGa+UyxOzJO2czhP7NihDDlrOCrMvwqxXHv3n93iiPyA3VEcTTPo35MlUklwEBUwDKbfs76RgurVfhj4xhLFTtoMISFgftoNapwkMP0EPEX5L5GDPzUbb4cxr3UGfFsIqPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967290; c=relaxed/simple;
	bh=7MCNlQZNO/H2j4+y2b+SuQnyHfs0kWQJkM8HBCHjWt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YhAikGH8ke6c9MoaDwcxrNESS+9G0Ef4a2oPrVWrEkfRbCDsOOOyzBS+MazYRDYeJkiXcWAFt5G7Lt7JphPcxbZysfJTQCAshIR+jWwZfJImBT7thUBVrFrt4hXKOGeQvw40jgwX6/vtlfit60ezCOpHSBQ/P5kp3TAIUZzwESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KMDaxt0m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KMDaxt0m"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O7R28e004204;
	Wed, 24 Apr 2024 14:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OGM/GXqUBWbOgXV/+FQ/XTWjCBOPQDHvAgZ7TZgQ0Bk=; b=KM
	Daxt0mHNeWdSEcqLJDp0CtLbCF3CLkiIm2nd4KsEWhruK4ZV8OoqVf4fwF4CHXOU
	97GC+ZKiAuktLk5y4CF/sO2noKCVw7wL5D3fYQaB9R9QBlZDy92uBuLHAs48BCZO
	FySoAxD5eSRmlmgdciM7OkAkKbLAmMjaGFC9jRT+aJA3qphANxbiGFimH/eGkiEJ
	4ax6QYF6x3Uos1wBPA1LOtpi2Tu33y5os0J0NYiZXtdSbriVuhECXREEFmy7odWF
	mXj7TCR0LpTwFUL0SgGtQ78t3/eqgBCt69uyTK93JxRy7ktCKR2dE+8uw5CyQYB9
	iNeMmgsc8/LM4oX7WvHw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9ks0te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:01:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OE18ra024704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:01:08 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 07:01:02 -0700
Message-ID: <734d9e8e-77d9-4282-8d17-3a6b632191cb@quicinc.com>
Date: Wed, 24 Apr 2024 22:01:00 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Wren Turkal <wt@penguintechs.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <regressions@lists.linux.dev>, <kernel@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
 <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
 <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
 <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
 <2020a858-c3d9-48a7-ad59-3691c6b98fb2@penguintechs.org>
 <053f51ae-1eb7-4ea8-bb04-38bfa1e0b8f5@quicinc.com>
 <CABBYNZKt0B9bKfAsP+wUJAeSoc93Otm8NFpos15AgoLV0hwrCA@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZKt0B9bKfAsP+wUJAeSoc93Otm8NFpos15AgoLV0hwrCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 76uCiEg0SCN7eIppbEZuC8ycg2-G7jZ4
X-Proofpoint-GUID: 76uCiEg0SCN7eIppbEZuC8ycg2-G7jZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240049

On 4/24/2024 9:56 PM, Luiz Augusto von Dentz wrote:
> Hi Quic_zijuhu,
> 
> On Wed, Apr 24, 2024 at 1:33 AM quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
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
>>>>>>>>>                                                 GPIOD_OUT_LOW);
>>>>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>>>>        dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>>>>>     power_ctrl_enabled = false;
>>>>>>>>>    }
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
> Well I really hope we get some more support upstream because things
> don't look quite clean right now and it should be a lesson that you
> guys need to spend more time reviewing what goes upstream otherwise
> things escalate since there isn't much documentation about your
> hardware we can rely on.
> 
thanks for your reminder. i will push company setup bluez team for QCA
BT driver.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>
> 
> 


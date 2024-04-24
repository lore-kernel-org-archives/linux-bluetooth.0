Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE6134A8
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988986; cv=none; b=cSw2V1YKjFv2YTgjWOFKChp4Cte7SHSxR3J1Ozwk4fyRFVy0ONdn2a54B3hD9zS1YLgmZTnuXaiTV47Bry4+6T4IAFT4/qH/4vLKbMMYC01L0jFDrU26oXpxUg/Lw8a4KNVmVWmYrY2H1qMIyrCN4u8GVYcw+mOYbjk2kxfbX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988986; c=relaxed/simple;
	bh=N40hfdbL/D0L1a+ZMxtnqX+BObKjaVRlNWw2IY3fAtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A3+QwuEiMFf1uuVpikiJG1Sev41XfQSiBGjy8onOz8EDgpDUjyTk+Vne+1jj26EEiu6/V+bexassbyN1gr9l2OPml3YUENVyU8qdEwfnqDGCn5ZdYq4o5pT9fm9ejc+lxaOcEBk2/7uwUHJJO5mqRnD/qeH7kM1MgGaFVcH0gt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=olZ/t02s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="olZ/t02s"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OJQLdY005747;
	Wed, 24 Apr 2024 20:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6rdWQJJeueWdIXfv14dIJkTA02fUOGCvZx6LG5EU1yQ=; b=ol
	Z/t02scrZA9n26u2J3J2eFvqzP0knAksiwzHfnD7tkUaus661USjRHLZZts4XAFw
	SjJxZgCx3UU0+W4dxkP2w1HpUKgVKbSwsKSefqv9rV85bhzMUGFTjzm4Xv6TNmzO
	K2+cLSsbqrQEcRPDcxA7eLDpgMr4KA/7iTTs+V6WYezKWRYbThFD39tPu9b4dTme
	DTF+f0bD2XLyDJ1H2OjMz1I3+DVf8TnDHuCgC7VVRxII9TMHn5449sm7T+LaXGDB
	D5bc92/qafKgkpps0GNip/unrlWY6woSRCxFi+NmGUlHqXz9QSnHcQqRSEDAGs1J
	D4G5ytdOLy+kgtqWrXfQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e23s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:02:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OK2pwr002486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 20:02:51 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 13:02:49 -0700
Message-ID: <caf0c221-eb4f-4487-bfe4-b4224974b27a@quicinc.com>
Date: Thu, 25 Apr 2024 04:02:47 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling
 logic for WCN6750 and WCN6855
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
 <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
 <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5-LZF4Cq9HNmFgHWGLexKMFiHEa1cobH
X-Proofpoint-ORIG-GUID: 5-LZF4Cq9HNmFgHWGLexKMFiHEa1cobH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_17,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240099

On 4/25/2024 3:12 AM, Krzysztof Kozlowski wrote:
> On 24/04/2024 11:22, quic_zijuhu wrote:
>> On 4/24/2024 4:44 PM, Krzysztof Kozlowski wrote:
>>> On 24/04/2024 10:35, Zijun Hu wrote:
>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>> with gpiod_get_optional()") has wrong logic for below case:
>>>>
>>>> property enable-gpios is not configured for WCN6750 and WCN6855
>>>
>>> As I said before, bindings say this property is required. I already
>>> asked you to provide rationale describing hardware and update the
>>> bindings if they bindings are not correct.
>>>
>> 1)
>> you ever given below reply at below link
>> https://lore.kernel.org/linux-bluetooth/52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org/
>>
>> "The pin is required on 6750, 6855 and maybe others. You cannot not have
>> the GPIO"
>>
>> 2) for property enable-gpios, they are required for WCN6750 and WCN6855
>> in my opinion,  i am a member of BT team.
> 
> If they are required, then your commit msg is not precise and code looks
> incorrect.
> 
>>
>> 3) only care about the case property enable-gpios is not configured,
>> the original BT driver design logic indeed matches with binging spec's
>> requirements before bartosz's wrong change
> 
> What? There is no such case according to bindings. I told you already
> two times: Either change bindings or this is not valid.
> 
>>
>> 4) please ask dts owner for help if you suspect current bindings spec
>> has something wrong. it is not my responsibility for providing such
>> info, that maybe involve CCI.
> 
> What?
> 
> What or who is DTS owner?
> 
> I do not suspect bindings are wrong. You are implying it. Anyway, if
> making driver correct according to bindings is not your responsibility,
> then this patch is just bogus.
> 
>>
>> 5) gentle reminder, please realize that there are many lunched products
>> already when you try to change some important logic, i don't suggest
>> change important logic or setting if there are no actual issue reported.
> 
> What?
> 
as you maybe noticed, this change is meaningless after below fix was
selected and merged, so don't need to discuss this change any more.
Commit: 48a9e64a533b ("Bluetooth: qca: set power_ctrl_enabled on NULL
returned by gpiod_get_optional()")

thanks
> Best regards,
> Krzysztof
> 


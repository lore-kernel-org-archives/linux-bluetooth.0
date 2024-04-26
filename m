Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAEB13A41D
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114779; cv=none; b=tOzs0na76DmDSCIBFcutKl+WUKqiQaizdOMKpvutpo6E4EHC4vS6aS2aMvtNWpOZKHDHIa+cmw3bjv34U3DJlYrQpTd/YSnfqBqW+fJw89hJ8eNBS868ymAOrF3qGS0JyV+e1zHay2yt/wDKQ7aECKHcIz3tHzPoxC50nb/ZUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114779; c=relaxed/simple;
	bh=sGpoENG8W3ulMICo9ijIQv6HB3Tbm8xlx16YStJK4pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iPFeoUp1xL2kzxMmxCa6tRQwCtcsc107Y5k98wR+Kov6yaaG+cb1CAGH1+uHb9x7ub7xA1RoeCw+n/BFkHUhWiOLqRuzy/BGpV659QRxaQgUMr0ob/KKkwYXZJmHVq+moAeljMKbjx0Gk9IJaudpyJlTqCZyzoqSJmNglYtsvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AjUGU2k7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AjUGU2k7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q5jj2J023782;
	Fri, 26 Apr 2024 06:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HGOkpDhMe6znNmvaVmxhy1ehF9LFTfF3jXUF5ejTYvg=; b=Aj
	UGU2k7mibYnHJcLlyX/hl0sL60dCIf0ll35rL2Qgy75n9puG9s20nQnTwXsB/hgE
	0H3jI0h6PkeB7W/3/FpZgi1Re7a8H6aoSoFaXbcLtBlbPox3ENMg4kzTS8ZODlxg
	gE7aOO7bSoMLCYWsmdJUp7TijG980CMGr5bYa5h9+VMlOt3PeXLhNtKQy2eY8wkP
	v/AmLWyZXOeqod4uatDdnw2yaTfOJedrjeVHaLQUSXPrq5WPNMUPzymsuPgegQYN
	uUW9ahStT58/fb48nuHaXxn+3TnJRDxKyda5fhf7TslDZMN8IJgMvBMiZQjGYz6a
	J4yJ+oHU5iqSUf7m6UjA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr35910s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:59:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q6xQDO011539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:59:26 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 23:59:20 -0700
Message-ID: <2e0972d9-e7ec-4edd-b37b-583210e84c39@quicinc.com>
Date: Fri, 26 Apr 2024 14:59:17 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling
 logic for WCN6750 and WCN6855
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Wren Turkal <wt@penguintechs.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <luiz.dentz@gmail.com>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <kernel@quicinc.com>
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
 <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
 <49cf0a3d-5f52-41a1-9858-692f48d06b88@kernel.org>
 <c1632816-f754-42c6-8448-2daff8221b58@penguintechs.org>
 <368e70e0-edc2-44fd-a9a2-72efa0d9f864@linaro.org>
 <f372c661-d82a-4f6f-b2de-8dd241d6b107@penguintechs.org>
 <CACMJSesk+DYFDwM7hUoPs9Xy+i1q8w+5CFu4_RdreUXudk18zw@mail.gmail.com>
 <d4c65299-d3af-4741-adc8-aafc1ab34369@linaro.org>
 <28f245c0-e81c-403b-ae7c-94fbd727998a@quicinc.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Content-Language: en-US
In-Reply-To: <28f245c0-e81c-403b-ae7c-94fbd727998a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eG_4UarNHq3x1DKz4JWcX0lpQkEsaBty
X-Proofpoint-ORIG-GUID: eG_4UarNHq3x1DKz4JWcX0lpQkEsaBty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260042



On 4/25/2024 6:28 PM, quic_zijuhu wrote:
> On 4/25/2024 5:14 PM, Krzysztof Kozlowski wrote:
>> On 25/04/2024 10:30, Bartosz Golaszewski wrote:
>>> On Thu, 25 Apr 2024 at 08:30, Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> On 4/24/24 11:05 PM, Krzysztof Kozlowski wrote:
>>>>> On 25/04/2024 00:01, Wren Turkal wrote:
>>>>>>>>
>>>>>>>> 3) only care about the case property enable-gpios is not configured,
>>>>>>>> the original BT driver design logic indeed matches with binging spec's
>>>>>>>> requirements before bartosz's wrong change
>>>>>>>
>>>>>>> What? There is no such case according to bindings. I told you already
>>>>>>> two times: Either change bindings or this is not valid.
>>>>>>
>>>>>> @krzysztof, I'm curious. There is no entry in the binding specifically
>>>>>> for qca6390. Should there be?
>>>>>
>>>>> qca6390 is documented in the bindings, but you are right that it lacks
>>>>> if:then: entry narrowing/choosing specific supplies and pins. It should
>>>>> have one, indeed.
>>>>
>>>> Would creating an entry for the qca6390 hardware fix the issue you are
>>>> worried about?
>>>>
>>>> Again, sorry for all the, what I assume are, basic questions. I am so
>>>> far out of my depth here. I am just trying to figure out how to move
>>>> forward. I really do appreciate your guidance here.
>>>>
>>>
>>> Wren, Krzysztof: I cannot stop you from doing this but I'm afraid this
>>> will complicate the power sequencing work unnecessarily. The QCA6390
>>> PMU bindings I'm proposing[1] are consumers of the BT enable GPIOs. In
>>> my series I also create an entry for QCA6390 Bluetooth[2] but without
>>> enable-gpios and with the inputs from the PMU, not host. Please
>>> consider that if you decide to go with this.
>>
>> I don't have a near plan to describe QCA6390 supplies and pins, so don't
>> worry. I also don't think Qualcomm BT understand what are bindings, so I
>> don't expect patches from them.
>>
> 
> For property enable-gpios of QCA6390, it is optional so not marked as
> required by the dts spec, dts spec is right, i would like to share
> history about QCA6390.
History information/links can be given like the change log under --- for
the initial patch set.
It will benefit the reviewers know the histories.
> 
> 1) it was firstly brought-up by Rocky Liao who is the same team as me.
> e5d6468fe9d8 Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC
> QCA6390
> 
> 2) for its first product at that time, there are no H/W pin for
> enable-gpios, so has issue that BT enable failure after warm reboot. so
> i submitted below commit to solve it.
> Commit: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure
> after warm reboot")
> 
> 3) then Krzysztof Kozlowski submitted below commit to solve
> use-after-free issue but also introduced the regression issue
> Commit: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev")
Fixes tag can be given in the commit message for a specific commit id.
> 
> 4) the issue is reported by Wren recently by below link, and i was
> notified to notice this issue and co-work with you to solve it.
> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> https://bugzilla.kernel.org/show_bug.cgi?id=218726
It is suggested to add the Link into the commit message itself.
> 
> 5) i known the root cause when i saw the issue description and have
> below formal fix [v7,2/2] and it is verified several times and can
> solve the issue reported. and the first debugging change included the
> fix logic.
> https://patchwork.kernel.org/project/bluetooth/list/?series=847290
> 
> 6) it does not matter if my fix is not expected, please wait for other
> good fix.
> 
> 7) i really don't want to discuss any more since i really talk two much
> as shown by below link, i will disappear for a short of time.
> https://lore.kernel.org/linux-bluetooth/1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com/#t
> 
>> Best regards,
>> Krzysztof
>>
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719FC1DFEB
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970012; cv=none; b=IxC4YxX1Frk9/hqteFlQzncKW+g1pgyuWvouzn7ytxFcNLiXBb8KcGFIB80XnpkmoZVabCpKgz8NEyXbHXtaamTA8yYqT+Rgcq/ebLtndeTubWJstUbh8EzVsSboZultMx3bEd4its0JHciMWS927t4/A9HUs5Zg+TA+UaU+qaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970012; c=relaxed/simple;
	bh=l7W3Za2l7dFFJ5qPbBTjeqOMr3uUcUMehptQJuJeu4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fpk7v3iZAsJb3TOsVQ4HXK/TzHlnIbK7/BW1jg1KHRn3YOtul67kQR8hqpgJvKP7ZIZHTOeC45u0nCHuFr7IMCbPnHR4zjMEYbucMVcPZukWmQYEYmsZ2r53UDive9QrxHVYhdNrRL8GnNV1Mav/wTP7eYo36Fk+sm0pHbDFP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lxSyprrs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lxSyprrs"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6XYEa016785;
	Wed, 24 Apr 2024 14:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kMahKhpTZaw/vwmerS953kRIxiDFemw77PXxILTKshs=; b=lx
	Syprrs3oBNmqDPX5xflzIRVwnM6ryCC/OUPWhzKwC+UEDS+Zb0uidEgbGKoGg6B7
	4ZHwxpsB8Xlo/ar7+PfGBElwLoFNHc2woDznbJGcfGt+JbCDll3ikLB1Eh23VDIg
	hBVuEmhTUXAbXE04W6Tc+D9Th9B8MzciiDWTMZ06eTwX9U2lvgRzHKsktnzFU9tY
	4R/EVfLIAK0V3gRgag3tyMxEfuvsqSHOjgbavZ97j21RrA0oYoU/jcszJSbvMfFj
	E2vwyXHOy8zigsCLEi7XMwCmdxTiJi3KWndw2ZzIngxnPVDZBNWN2KfVLQKRVw5+
	PiFxIuGKPLxhuvoBmACQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gh4pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:46:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OEkfJC025726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:46:41 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 07:46:35 -0700
Message-ID: <34091f3a-9711-445d-a369-540bcfc49b29@quicinc.com>
Date: Wed, 24 Apr 2024 22:46:33 +0800
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
 <38736db8-eec4-4ebd-b4c4-4b404cea6e42@quicinc.com>
 <CACMJSev8=gBCw9o-ur87fMMj9K=ZWY-ECzxZjyvERYQ8P=VS7A@mail.gmail.com>
 <CABBYNZ+PvZb6azHoXAbO2czqK2zQnZ1ddcKRb_YX-zGSVfy+KQ@mail.gmail.com>
 <CACMJSeue3kM-G1UvO0REEAJbhU9vOqbeEzy0Qny5udKLB97e8g@mail.gmail.com>
 <2805ad96-6383-45b3-9b68-66578461bb5f@quicinc.com>
 <CACMJSeuyumcmkO8pYiWk6Gccd7njpke23NdboYrxNZxHx6XjAQ@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSeuyumcmkO8pYiWk6Gccd7njpke23NdboYrxNZxHx6XjAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1tu1glyTkbrwtluWf8iUl4K8AdAKvC3T
X-Proofpoint-GUID: 1tu1glyTkbrwtluWf8iUl4K8AdAKvC3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240053

On 4/24/2024 10:41 PM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 16:25, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 4/24/2024 10:19 PM, Bartosz Golaszewski wrote:
>>> On Wed, 24 Apr 2024 at 16:08, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>>
>>>> Hi Bartosz,
>>>>
>>>> On Wed, Apr 24, 2024 at 10:00 AM Bartosz Golaszewski
>>>> <bartosz.golaszewski@linaro.org> wrote:
>>>>>
>>>>> On Wed, 24 Apr 2024 at 15:53, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>>>>>
>>>>>>>>>
>>>>>>>>> Please slow down here. Zijun's patch works and Bartosz's patch does not.
>>>>>>>>> I don't think Zijun means any ill intent. I am replying to Bartosz's
>>>>>>>>> patch right now.
>>>>>>>>
>>>>>>>> Ok, that is great feedback, so I might be picking up the Zijun v7 set
>>>>>>>> if we don't find any major problems with it.
>>>>>>>>
>>>>>>>
>>>>>>> Luiz,
>>>>>>>
>>>>>>> Please consider my alternative[1] also tested by Wren. Zijun's usage
>>>>>>> of GPIO API is wrong.
>>>>>>>
>>>>>> why is it wrong ?
>>>>>>
>>>>>
>>>>> I have already told you that at least three times. But whatever, let
>>>>> me repeat again: gpiod_get_optional() returns NULL if the given GPIO
>>>>> is not assigned to the device in question OR a pointer to a valid GPIO
>>>>> descriptor. Anything else returned by it is an error and the driver
>>>>> must abort probe().
>>>>
>>>> Ok, but there are other fixes on top of it:
>>>>
>>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
>>>>
>>>> I guess that could go in but it would really help if you guys could
>>>> work together so we don't have more competing solutions.
>>>>
>>>
>>> These threads with their 7 patch versions from Zijun within 2 days or
>>> so have become very chaotic. Let me summarize: there are two
>>> regressions: one caused by my commit 6845667146a2 ("Bluetooth:
>>> hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qca_serdev_probe") and a
>>> second caused by Krzysztof's commit 272970be3dab ("Bluetooth: hci_qca:
>>> Fix driver shutdown on closed serdev"). The patch I linked here is how
>>> I propose to fix my regression only. These fixes don't seem to
>>> conflict with one another.
>>>
>> it is not conflict issue, from my perspective, you fix are wrong.
>> do you see my patch change log?
>>
>>> We (Krzysztof and I) have provided feedback to Zijun but he refused to
>>> address it and instead kept on resending his patches every couple
>>> hours. Zijun's patch 1/2 proposed to revert my commit 6845667146a2. I
>>> disagreed and proposed a way forward by fixing the regression. This
>>> fix was incorrect as pointed out by Wren, so I submitted v2 which
>>> works.
>>>
>> v2 is not right from my point as i commented with your solution.
>>
>> you don't answer my questions commented within your solution.
>>
>> what is your question i don't answer?
>>
>>> Bartosz
>>
> 
> Luiz,
> 
> This is an example of how Zijun will borrow any attempt at meaningful
> communication under a heap of incomprehensible emails. Krzysztof has
> already given up and I think I will stop too now. As the GPIO
> maintainer I suggest you take my fix for this regression. I can't make
> you though and I've already wasted way too much time on it. Your call.
> 
how about GPIO maintainer? it is your change about GPIOs causes serious
regression issue.

i maybe send many mails. but dos it have any relevant my change's rightness.

do you find anything my change have wrong usage about GPIO about the
case i care about?

> Bartosz


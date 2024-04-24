Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86915E1FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967964; cv=none; b=dFV0b6hJw7UsHFEAp70JY+kApaQglb6Dti+evv7l3KJTU/STvio69EGUP/E62OpacqRE4fCUaO6Q7VZ6TrinxNZhGmekXn7nG3qyZiNJFW9DZybq/0attVm1QncHrCFlyzND5vOGb5g68BXWSECBVXRhx2L2U8YAGI83FcH4J34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967964; c=relaxed/simple;
	bh=oBp0/Dz2+7CpeHDray/VGZuBo/F2G1ZYuAhRmzaS/7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZdAPIyorlPjooMvRP70Ityfr9wUAxvEdr8c0yhXbWgk1GKA096Hlnd/yGYY0pf+GEkRZH1qOaPOep29fN/Ck8LtlRLMktPG2+ADn4bH3Uzyml3Is/QKG9FYAIGWHB/8U9K9R7E1BUsRFmZQ30UMZlJNB6dSc9RoYxZIwdHtGXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C4mbwfEA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C4mbwfEA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6X6Rp016591;
	Wed, 24 Apr 2024 14:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gCycoNIoseDh9+tOJ5tdXj6uVXeRk+bqN8QmnwxyCLw=; b=C4
	mbwfEAAyKliYBrkhkxUatOHV6aKZryOLn/DMCMH4G4f5urZMDitotFn0R8nDKROd
	LKIobfvlJ0kPxdO+FYUEpLgeIA1RF40kJ9XFBani/7OZt08UMRPxY2nrZ58NfIqv
	QyN7IZsc/R9mhcuoWJFc7xkakXUT52LwrFSS5CKweRvH+MhQW5OgyEb57VEnTjUs
	Xqsj4IAK36S7d4x/qPADMB+ny+w/RJ1dnJLFJJoEcL+Fui116g1K4g5Vf9+IHkZq
	b30MRV5G1IYf2ZHQJkftzR0FO+O6zXAZW18fTMkXV+B8vppiSLPQHE3rVIu2HhDy
	QxTqWToYc+MJTbRXBExw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9ks1xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:12:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OECXGw007118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:12:33 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 07:12:28 -0700
Message-ID: <e292bbcb-4abd-4845-88a0-776c4ed3684b@quicinc.com>
Date: Wed, 24 Apr 2024 22:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CABBYNZ+PvZb6azHoXAbO2czqK2zQnZ1ddcKRb_YX-zGSVfy+KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4xXVzfTH3OgjEi34ot-jGbta4I9jJxDY
X-Proofpoint-GUID: 4xXVzfTH3OgjEi34ot-jGbta4I9jJxDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=848 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240050

On 4/24/2024 10:08 PM, Luiz Augusto von Dentz wrote:
> Hi Bartosz,
> 
> On Wed, Apr 24, 2024 at 10:00 AM Bartosz Golaszewski
> <bartosz.golaszewski@linaro.org> wrote:
>>
>> On Wed, 24 Apr 2024 at 15:53, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>>
>>>>>>
>>>>>> Please slow down here. Zijun's patch works and Bartosz's patch does not.
>>>>>> I don't think Zijun means any ill intent. I am replying to Bartosz's
>>>>>> patch right now.
>>>>>
>>>>> Ok, that is great feedback, so I might be picking up the Zijun v7 set
>>>>> if we don't find any major problems with it.
>>>>>
>>>>
>>>> Luiz,
>>>>
>>>> Please consider my alternative[1] also tested by Wren. Zijun's usage
>>>> of GPIO API is wrong.
>>>>
>>> why is it wrong ?
>>>
>>
>> I have already told you that at least three times. But whatever, let
>> me repeat again: gpiod_get_optional() returns NULL if the given GPIO
>> is not assigned to the device in question OR a pointer to a valid GPIO
>> descriptor. Anything else returned by it is an error and the driver
>> must abort probe().
> 
> Ok, but there are other fixes on top of it:
> 
as i commented with Bartosz's solution, it maybe break lunched product's
BT functionality for his solution.

> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
> 
> I guess that could go in but it would really help if you guys could
> work together so we don't have more competing solutions.
> 
>>
>> Bart
> 
> 
> 


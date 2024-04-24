Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7715D5A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967718; cv=none; b=mwFPFxp9Z0hSgazmmeA2iYKQMbi3vMBgVTniIT4KtH8qRqKmuWq2XWDFeQ098Vt2ExcyKj0l/ancQsS0dj2MZUd0liXfejtVUbvpgCmJ/ersZ5ELfS7Y1j4uB2LYu1CdnENFpdGW8HWBl4ekNeUkF3te1aJQapZ+Vy0B3qjwk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967718; c=relaxed/simple;
	bh=XyL/CBsCg7SlZMIXGqDEzWpWfTOOl6eHcTFgFZIIqws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AgkBrR4KWhQYO/yw+3R7NLGIiZgl37uuV379TaDDrM6TDcCFY0VUNHUnwPcRwevS3KRwkOWb+CZ6fxEU7vAuxquQUd8h5Ifg2yONChNuo4ZSfR5PLYmZrH7LpekfCJt+nwWRTRInccmYUq56rXlKNL3mHxPyz821PUzw80/WDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CT7W8Q/e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CT7W8Q/e"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OBfa08020876;
	Wed, 24 Apr 2024 14:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qhd61wABaIdGF63VT5vGKxOovTaxOsEVwvsndO3ctu4=; b=CT
	7W8Q/e6mXg0/d2JHA+Sv1Jpjq9QQ/bMK591p73D/0a3NEQ4DFF37jOM3Q5h9aEqr
	DORblUlxT3wijaYaTyLtNnmkxhBagK2dp0YyTiLjCE9aUuAjccstnUP6fHs/WkNi
	Sj4fItqtskNHHJn4viIZJtI+hhuD8V/81zaoaX+0TKL78B9cd9s9fguVRAp8vg74
	iuJvRkpc+YIIgYURUMNX5y7qQj8Y4+qkSj/PYD+PbCJo/6pr1M7bvJCCYMMHDxgj
	fqm/lRot8YB6wDyZMDGrEDB6/LcyqOUyIUp3xqZAVyhi6J9SlMN7SDpTk1tzW8GZ
	qGz8TAe5hx68TXeF1nWg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9gs0vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:08:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OE8Lwh002288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:08:21 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 07:08:16 -0700
Message-ID: <6932c239-8bbe-4170-aaf7-c4fd580caebb@quicinc.com>
Date: Wed, 24 Apr 2024 22:08:13 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Wren Turkal
	<wt@penguintechs.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSev8=gBCw9o-ur87fMMj9K=ZWY-ECzxZjyvERYQ8P=VS7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4PoqDmQTA_uc5cJ0l7hhszKIhA-FVq66
X-Proofpoint-ORIG-GUID: 4PoqDmQTA_uc5cJ0l7hhszKIhA-FVq66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=756
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240049

On 4/24/2024 10:00 PM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 15:53, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>>>>>
>>>>> Please slow down here. Zijun's patch works and Bartosz's patch does not.
>>>>> I don't think Zijun means any ill intent. I am replying to Bartosz's
>>>>> patch right now.
>>>>
>>>> Ok, that is great feedback, so I might be picking up the Zijun v7 set
>>>> if we don't find any major problems with it.
>>>>
>>>
>>> Luiz,
>>>
>>> Please consider my alternative[1] also tested by Wren. Zijun's usage
>>> of GPIO API is wrong.
>>>
>> why is it wrong ?
>>
> 
> I have already told you that at least three times. But whatever, let
> me repeat again: gpiod_get_optional() returns NULL if the given GPIO
> is not assigned to the device in question OR a pointer to a valid GPIO
> descriptor. Anything else returned by it is an error and the driver
> must abort probe().
> 
notice that i talked many times for you. the only different between my
fix and present kernel code is that how to handle NULL case.

for QCA6390. the GPIO is not marked as required by DTS binding spec.
so, we don't need to take the case the gpio is not configured(return
NULL) as error.

i don't need to care about how to  handle gpiod_get_optional() returning
error case since my change don't change current handle logic for it. i
currently only care about the issue reported.


> Bart


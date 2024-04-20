Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F57465
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590741; cv=none; b=msdCB4BShaN6vLHFYmd3YOxB7CXrsN+OEONCvf02yxtyglr88WfJ15SO0WalZwdi9dVXsF5c7GuJ6XuowJt4imSt10zLgeYdECIJ208oOl61UNSeKKz1umt99DpOLtsyp1siBiWNBaApo+dbQKUw9dnLiah6xl5SEgCJnuDsEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590741; c=relaxed/simple;
	bh=lGFczjtsapCTxHAwcyOF1V2OVOm0TrJiSLCIRbNOez0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rLJVia2XwlxV7VHa5knCQE0GxSqBbldpuFDqdsUvuA1R8P3LgWGvGPhx9V/Wxe4z9qWI8LFOjEWYCRMwbHfz7OvJglhDr0o2fKmtOzwPvHfpznw5w9XHDnhrM0fRtCFJZjQ5/5XHwBAfVKVlQ4fTdiaqkA2KvLSefw42XQxhOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oD05gF+w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oD05gF+w"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K4w7x0016418;
	Sat, 20 Apr 2024 05:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/N/0n5D55ZVLW1oydfxvgPgd7Adow40GKXHHRL/eSKw=; b=oD
	05gF+w/Y98N9e9wltyIqpaUiQWDCLgIhICW+57TBFGrP6Y8Y56+7N2FIYup4qUjg
	7UXdUbEZexHyJF8QSEpkTqyA78zuxC3X/6U+wELZp0NohQmwLl+NaEHvODwfBXe6
	cgptowG1iEZWtlX3RC57gUS/i+6FevyEvbkLgYj8Bjou6XQ7wW99OaAv1FVtq9Ia
	kdf46qUY1agZjr9lVG+OX9KLwEBF/SS5neZJHbmsbsQ91XeigFhi4zbfJolnyUza
	3FRfidp4kfWhd5gi2r3yWTg2ogvcLrwJdCbdwD9oBuUC1oerQI1hJoABKu2xmwcP
	oCOZWhRGadBXiT+KCS2A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5x68423-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 05:25:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K5PTcW028272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 05:25:29 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 22:25:27 -0700
Message-ID: <01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com>
Date: Sat, 20 Apr 2024 13:25:25 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <bartosz.golaszewski@linaro.org>, <",kernel"@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
 <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
 <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
 <0dca7c9b-6a97-4171-9b0c-5b806a4e8a60@quicinc.com>
 <4e4d8ee0-fbbe-4dc7-b40b-b983f9f39539@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <4e4d8ee0-fbbe-4dc7-b40b-b983f9f39539@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3hJAt0H6lF6sOVJ3uJKvORXJat7NTqXD
X-Proofpoint-GUID: 3hJAt0H6lF6sOVJ3uJKvORXJat7NTqXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200037

On 4/19/2024 9:49 PM, Krzysztof Kozlowski wrote:

Hi Krzysztof,bartosz,

let me summarize our discussion here in order to reduce unneccessary
disagreements here.

1) i only revert your change IS_ERR() to my change IS_ERR_OR_NULL.

2) your change will cause serious regression issues for many lunched
products

3) we only need to discuss how to handle devm_gpiod_get_optional(...,
"enable", ...) returning NULL since this is only difference between your
change and mine.

4) your change doesn't solve any actual issue and the reason you
submitted is that "The optional variants for the gpiod_get() family of
functions return NULL if the GPIO in question is not associated with
this device, and should not treat it as error".

code applet of your merged change is shown by below link
https://patchwork.kernel.org/project/bluetooth/patch/20240208164017.26699-1-brgl@bgdev.pl/#25705104

qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
+		if (IS_ERR(qcadev->bt_en)) {
 			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
 			power_ctrl_enabled = false;
 		}

5) Original BT driver design agree with your point mentioned at 4), so
for case "qcadev->bt_en == nullptr", qca_serdev_probe() don't do error
return for this scenario and use dev_warn() instead of dev_err() to give
user prompt.

6) your wrong fix changes flag power_ctrl_enabled set logic and will
cause serious BT regression issue, hope you will realize this point.


i would like to give below extra comments even if these comments are
irrelevant to the critical point of this issue mentioned at above 3)

A) you need to investigate it is a) the prompting approach or message
 error or b) the if condition error even if if dev_err() is used to give
prompt instead of dev_warn() in above 4).

B) don't talk about how about devm_gpiod_get_optional() returning error
case since it is meaningless as explained by above 3). also don't
require a fix to fix another unreported issue. a fix is a good fix
if it fix the issue in question and don't introduce new issue.

C) per DTS property enable-gpios of BT, different soc types have
different requirements, many are required and another many are NOT
mandatory as shown be below link.
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml.

for a soc type which are attached to 3rd platform, customer doesn't
would like to or are not able to congfig BT reset pin within DTS for QCA
driver even if QC strongly suggest customer config it and also be marked
as required within above DTS bindings spec link. i often meet this
scenario. there are many of such lunched products.

i will try to fix this issue due your change product by product in new
patch thread based on this DTS comment.

D) you maybe ping me offline about this issue if you are a member of QC
since you known "go/upstream"

> On 19/04/2024 01:17, quic_zijuhu wrote:
>> On 4/19/2024 6:37 AM, Krzysztof Kozlowski wrote:
>>> On 18/04/2024 23:16, quic_zijuhu wrote:
>>>> On 4/19/2024 12:52 AM, Krzysztof Kozlowski wrote:
>>>>> On 18/04/2024 16:06, Zijun Hu wrote:
>>>>>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>>>>>
>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>> with gpiod_get_optional()") will cause serious regression issue for
>>>>>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>>>>>
>>>>> The pin is required on 6750, 6855 and maybe others. You cannot not have
>>>>> the GPIO.
>>>>>
>>>>> This is no correct fix. You provide wrong DTS and, instead fixing it,
>>>>> try to revert kernel code.
>>>>>
>>>>> No, fix your DTS first.
>>>>>
>>>> no. your point is not right.
>>>>
>>>> 1) do you have any evidence that the hci_qca driver must use reset GPIO?
>>>
>>> I think we talk here about enable-gpios, right? Then the evidence are
>>> bindings.
>>>
>> yes. properties within bindings only means driver supporting it, don't means user must
>> config it. the gpio is got by devm_gpiod_get_optional() variant. that means it is optional
>> about if user need to config it.
> 
> No. Read writing bindings and other presentations explaining what are
> Devicetree bindings.
> 
> You miss entirely the point and use downstream narrative. This won't
> work and it was told so many times, that I expect you to do the homework
> first.
> 
> Use "go/upstream" before posting more on this topic.
> 
> 
>>>> 2) why does original design do error return when get GPIO error if GPIO is mandatory?
>>>
>>> If GPIO is mandatory, then it is expected to return error. What is the
>>> problem here?
>>>
>> sorry, i miss a NOT for my question. my question is that
>> 2) why does original design NOT do error return when get GPIO error if GPIO is mandatory?
>>>
>>>> 3) i meet many customer cases that BT are working fine without hci_qca operating the GPIO,
>>>> there is why HCI_QUIRK_NON_PERSISTENT_SETUP are introduced.
>>>
>>> Bindings tell different story and nothing in the commit msg explained
>>> this. You did not correct bindings either.
>>>
>> don't need to correct bindings. i believe bindings does not say enable gpio
>> must be configured.
> 
> They say. Read the bindings. Test your DTS. Or better: upstream your DTS
> and prove to us that dtbs_check allows lack of enable-gpios.
> 
> 
>>>
>>>> 4) does the reverted change solve the issue your mentioned ?
>>>
>>> ??? I did not mention any issue. I am saying that your rationale is
>>> either not complete or not correct.
>>>
>> do you suggest about how to make it complete?
> 
> Yes, read what are bindings and then describe your change including
> that: what is the issue, how it can be reproduced, what is the hardware,
> why the bindings are not correct (if they are not correct) etc.
> 
> 
> Best regards,
> Krzysztof
> 


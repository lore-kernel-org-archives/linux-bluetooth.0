Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAE7465
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590874; cv=none; b=XJinuEuf/TEHn6n6xOb7aDXTkpsEMyhGQKJA7JE+16Yn2wwBaa5GHRpEDkYxkkpNz6QbDmRltZO97y0G/a88HWMJKZKkoLPqYAFUbB2J+vWTXlA2k3FA/K1m9XIW+TmRG3vsqaXxBLORnyW3Smx24rgJuPKu9gzkn3wTFmFNit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590874; c=relaxed/simple;
	bh=yNW0WuoqQ8uB7upqcELciKwpwZA26ScuxYWX9LygHGM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=K+KiiaCmB79ED2k1dpl7caYAAFj8dXycBe2evuYWbk5JeJDK/L/PZoZLiZE+iXNdtU9QF4gJl6c0bQBu7g50JwzoFkYVXbvIbqZk51piaHGNqLHp24XZWPhmrDmg9JZXsAPNF59v+f5fwm8x/Gy216Opwfbd/kd3PAvGfPLlf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gmHzdaB6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gmHzdaB6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K58fPF010188;
	Sat, 20 Apr 2024 05:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Tl9F5c0bRyo20Kgy/oRUkR8N8mxnKEorQMH6BWEt25Q=; b=gm
	HzdaB64BGBQGD0OfnMyJgWbxzSAYXGfMH+v9dTUupZdHUYc6lfYP0jUTL4vlWfUq
	9G/rjFo88tLj+JVvGoqKyI/fNE/mvrNnVy4/xeVCVwEt0AKoGOEQQrrSuNPnvvSm
	n4oe40/lWLuozWbpTZhcP8AyroJuj0oPulmtqT2b/ZJ2GqfuYEvQgJJm2s5C4x8r
	jnRwRkQR6GXZbAz1aSAbDnL35K8IfWiDBekMQEp1p2bvWxrmW5mGK8Pf+nE2g8jp
	iWyNBAoYeo+W2IU4vbDCX3piIkEDVI0AW947sf60+iUbXy7OpYwXg1llzj8yV5aK
	/Gc9jlEfsTxHjaQRbaqQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm49ng8h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 05:27:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K5RjFw025687
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 05:27:45 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 22:27:40 -0700
Message-ID: <c1138d6a-83a9-43ec-9c49-62d59884b41c@quicinc.com>
Date: Sat, 20 Apr 2024 13:27:37 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
From: quic_zijuhu <quic_zijuhu@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <bartosz.golaszewski@linaro.org>, <kernel@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
 <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
 <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
 <0dca7c9b-6a97-4171-9b0c-5b806a4e8a60@quicinc.com>
 <4e4d8ee0-fbbe-4dc7-b40b-b983f9f39539@linaro.org>
 <01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com>
Content-Language: en-US
In-Reply-To: <01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U1YopQ5GDgcDosdbHjvepYn-kvJ7Q0_3
X-Proofpoint-GUID: U1YopQ5GDgcDosdbHjvepYn-kvJ7Q0_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404200037

On 4/20/2024 1:25 PM, quic_zijuhu wrote:
> On 4/19/2024 9:49 PM, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,bartosz,
> 
> let me summarize our discussion here in order to reduce unneccessary
> disagreements here.
> 
> 1) i only revert your change IS_ERR() to my change IS_ERR_OR_NULL.
> 
> 2) your change will cause serious regression issues for many lunched
> products
> 
> 3) we only need to discuss how to handle devm_gpiod_get_optional(...,
> "enable", ...) returning NULL since this is only difference between your
> change and mine.
> 
> 4) your change doesn't solve any actual issue and the reason you
> submitted is that "The optional variants for the gpiod_get() family of
> functions return NULL if the GPIO in question is not associated with
> this device, and should not treat it as error".
> 
> code applet of your merged change is shown by below link
> https://patchwork.kernel.org/project/bluetooth/patch/20240208164017.26699-1-brgl@bgdev.pl/#25705104
> 
> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>  					       GPIOD_OUT_LOW);
> -		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> +		if (IS_ERR(qcadev->bt_en)) {
>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>  			power_ctrl_enabled = false;
>  		}
> 
> 5) Original BT driver design agree with your point mentioned at 4), so
> for case "qcadev->bt_en == nullptr", qca_serdev_probe() don't do error
> return for this scenario and use dev_warn() instead of dev_err() to give
> user prompt.
> 
> 6) your wrong fix changes flag power_ctrl_enabled set logic and will
> cause serious BT regression issue, hope you will realize this point.
> 
> 
> i would like to give below extra comments even if these comments are
> irrelevant to the critical point of this issue mentioned at above 3)
> 
> A) you need to investigate it is a) the prompting approach or message
>  error or b) the if condition error even if if dev_err() is used to give
> prompt instead of dev_warn() in above 4).
> 
> B) don't talk about how about devm_gpiod_get_optional() returning error
> case since it is meaningless as explained by above 3). also don't
> require a fix to fix another unreported issue. a fix is a good fix
> if it fix the issue in question and don't introduce new issue.
> 
> C) per DTS property enable-gpios of BT, different soc types have
> different requirements, many are required and another many are NOT
> mandatory as shown be below link.
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml.
> 
> for a soc type which are attached to 3rd platform, customer doesn't
> would like to or are not able to congfig BT reset pin within DTS for QCA
> driver even if QC strongly suggest customer config it and also be marked
> as required within above DTS bindings spec link. i often meet this
> scenario. there are many of such lunched products.
> 
> i will try to fix this issue due your change product by product in new
> patch thread based on this DTS comment.
> 
> D) you maybe ping me offline about this issue if you are a member of QC
> since you known "go/upstream"
> 
>> On 19/04/2024 01:17, quic_zijuhu wrote:
>>> On 4/19/2024 6:37 AM, Krzysztof Kozlowski wrote:
>>>> On 18/04/2024 23:16, quic_zijuhu wrote:
>>>>> On 4/19/2024 12:52 AM, Krzysztof Kozlowski wrote:
>>>>>> On 18/04/2024 16:06, Zijun Hu wrote:
>>>>>>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>>>>>>
>>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>> with gpiod_get_optional()") will cause serious regression issue for
>>>>>>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>>>>>>
>>>>>> The pin is required on 6750, 6855 and maybe others. You cannot not have
>>>>>> the GPIO.
>>>>>>
>>>>>> This is no correct fix. You provide wrong DTS and, instead fixing it,
>>>>>> try to revert kernel code.
>>>>>>
>>>>>> No, fix your DTS first.
>>>>>>
>>>>> no. your point is not right.
>>>>>
>>>>> 1) do you have any evidence that the hci_qca driver must use reset GPIO?
>>>>
>>>> I think we talk here about enable-gpios, right? Then the evidence are
>>>> bindings.
>>>>
>>> yes. properties within bindings only means driver supporting it, don't means user must
>>> config it. the gpio is got by devm_gpiod_get_optional() variant. that means it is optional
>>> about if user need to config it.
>>
>> No. Read writing bindings and other presentations explaining what are
>> Devicetree bindings.
>>
>> You miss entirely the point and use downstream narrative. This won't
>> work and it was told so many times, that I expect you to do the homework
>> first.
>>
>> Use "go/upstream" before posting more on this topic.
>>
>>
>>>>> 2) why does original design do error return when get GPIO error if GPIO is mandatory?
>>>>
>>>> If GPIO is mandatory, then it is expected to return error. What is the
>>>> problem here?
>>>>
>>> sorry, i miss a NOT for my question. my question is that
>>> 2) why does original design NOT do error return when get GPIO error if GPIO is mandatory?
>>>>
>>>>> 3) i meet many customer cases that BT are working fine without hci_qca operating the GPIO,
>>>>> there is why HCI_QUIRK_NON_PERSISTENT_SETUP are introduced.
>>>>
>>>> Bindings tell different story and nothing in the commit msg explained
>>>> this. You did not correct bindings either.
>>>>
>>> don't need to correct bindings. i believe bindings does not say enable gpio
>>> must be configured.
>>
>> They say. Read the bindings. Test your DTS. Or better: upstream your DTS
>> and prove to us that dtbs_check allows lack of enable-gpios.
>>
>>
>>>>
>>>>> 4) does the reverted change solve the issue your mentioned ?
>>>>
>>>> ??? I did not mention any issue. I am saying that your rationale is
>>>> either not complete or not correct.
>>>>
>>> do you suggest about how to make it complete?
>>
>> Yes, read what are bindings and then describe your change including
>> that: what is the issue, how it can be reproduced, what is the hardware,
>> why the bindings are not correct (if they are not correct) etc.
>>
>>
>> Best regards,
>> Krzysztof
>>
> 


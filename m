Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8D11CB4
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482266; cv=none; b=ONeB6QNc7p3HCgIsecFLuPFNqxu9wW43qlyr6Ka8NIkzKGYweFZeJAt2YJWzKu5I6q4cB2gpiI3FI4Isy4LI2mlPSmgk+rVboAjGli95EylPdETTX7E5hRf3DBot77WCkNNWIn+4/pbmFOiVF1tmDgXgLusvs3a5uudQ075em8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482266; c=relaxed/simple;
	bh=YmaIxzVcKJVAK+/IKD3j1CIS5dw0tmCoJ0gt+c1+8iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uwomMRfobqKwwIwVoQhJ9282haBgt9h5VCHB3xFguwi2zSSTgNE+v2/NxttpDPAbE4eKQlIeeXylhd57PXRELko8CaglRiRivuFzNhnEeIbjm50dwWVUKRCOuztspxb+EAOEpHHWHLz8kZZiw/kM5ACHBwjxUVM9X59AAD5SZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cetCd1zL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cetCd1zL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IMdiRE001650;
	Thu, 18 Apr 2024 23:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nUcUXmRBrcv0feeRnornqav2YVm0Gz0iTxZmaX6xbOI=; b=ce
	tCd1zL4bJycuTkLuJ2rQ13jB+oL0N9cCcsTppog8jCHbYDqX2iOHa6QpIDlLOn51
	U3DtTlaskitBuheJLGbe0eEep4Vo7ePOr+5nABbYVJ17WIq02tgpsK5efe3klAgz
	92zFiwazuw0R/reKjHG40yh8HxVVxlXw4J2i2h23Z9mJVne8uNFXbAdAzVZ4PPgt
	eNXswBLAIOc+BqOKGdS1dwsKhmyYByHPc3INZiVRj6AdkroK+mtRHwnEUEzt6EeR
	H2TRk9KCCmuTqZ1yfTva3AC1JMq8unoBGeAEcX7HMg6tXilRAZbJtLVg/Y9TRZ9X
	+SDPWsRIHqyk7D29yxoQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk06n1vcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 23:17:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43INHax7011127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 23:17:36 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 16:17:34 -0700
Message-ID: <0dca7c9b-6a97-4171-9b0c-5b806a4e8a60@quicinc.com>
Date: Fri, 19 Apr 2024 07:17:32 +0800
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
        <bartosz.golaszewski@linaro.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
 <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
 <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OUEk1qcqZYXgWpu8WM4clG0r9kidPUa1
X-Proofpoint-GUID: OUEk1qcqZYXgWpu8WM4clG0r9kidPUa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180168

On 4/19/2024 6:37 AM, Krzysztof Kozlowski wrote:
> On 18/04/2024 23:16, quic_zijuhu wrote:
>> On 4/19/2024 12:52 AM, Krzysztof Kozlowski wrote:
>>> On 18/04/2024 16:06, Zijun Hu wrote:
>>>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>>>
>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>> with gpiod_get_optional()") will cause serious regression issue for
>>>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>>>
>>> The pin is required on 6750, 6855 and maybe others. You cannot not have
>>> the GPIO.
>>>
>>> This is no correct fix. You provide wrong DTS and, instead fixing it,
>>> try to revert kernel code.
>>>
>>> No, fix your DTS first.
>>>
>> no. your point is not right.
>>
>> 1) do you have any evidence that the hci_qca driver must use reset GPIO?
> 
> I think we talk here about enable-gpios, right? Then the evidence are
> bindings.
> 
yes. properties within bindings only means driver supporting it, don't means user must
config it. the gpio is got by devm_gpiod_get_optional() variant. that means it is optional
about if user need to config it.
>> 2) why does original design do error return when get GPIO error if GPIO is mandatory?
> 
> If GPIO is mandatory, then it is expected to return error. What is the
> problem here?
> 
sorry, i miss a NOT for my question. my question is that
2) why does original design NOT do error return when get GPIO error if GPIO is mandatory?
> 
>> 3) i meet many customer cases that BT are working fine without hci_qca operating the GPIO,
>> there is why HCI_QUIRK_NON_PERSISTENT_SETUP are introduced.
> 
> Bindings tell different story and nothing in the commit msg explained
> this. You did not correct bindings either.
>
don't need to correct bindings. i believe bindings does not say enable gpio
must be configured.
>
>> 4) does the reverted change solve the issue your mentioned ?
> 
> ??? I did not mention any issue. I am saying that your rationale is
> either not complete or not correct.
> 
do you suggest about how to make it complete?

> Specifically, the enable-gpios ARE currently required, so whatever you
> claim here is not correct till they are required. Make them optional and
> then your arguments could have sense.
> 
> Best regards,
> Krzysztof
> 


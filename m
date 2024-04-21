Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735543232
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713691836; cv=none; b=h06c9RqAZgV86ftq7LAxY4vRDMHfjuYsiJdsz8nU1XNVrORGa++Z2sWEXiuo6owQ4i+d/7lzqkbildkitcONgo9WEoIbjl8M54LhSIGFconRSU00DwWBQwMml/XvznKdQYYMtH4oaEP5uQjfsw9o6g9Ub63tYbI+STn+xh5IC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713691836; c=relaxed/simple;
	bh=YnJwEz5nCa4WeQV5wKasjzZaVk9PTqffYKFvSl6dotI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R7gPrBXOfn0h661DViyZidnuQbvTYWkXTHj3jK4H0CifXqYRLJcZEEB+O4pKeOwHpctTLQ1eF+tGBRRSzobo3eKSI/fU4/Vvaggld+qjpOo7nbMp5davY4AmV6hDYzBC1r9V1sbaWWFUfUNM23IPxhc7mz5M1CktVRdiOl2JtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mk/Ew6eJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mk/Ew6eJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43L9EclA013539;
	Sun, 21 Apr 2024 09:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZaIxilT4jMpwjexiqLIjD2yxUoZjIPfhy7ClvN+oNa8=; b=mk
	/Ew6eJUGG34Vgy+aLYh/uE0tBEuAMzaVwSYE5KqZ8YZcD4wm6MDDORJlIK1Cvsth
	0v2MtyM3AVt/mRSnJPrwGk0G8xNG3/cEfUFADKL8C0daFqO2DUU7Ir1XbwsqcFfM
	5g3rJlosswYV/zmZrijsrrufwUEHkDSngY/w8qKhrz42E+oGtacvr9YPEpgEEkLm
	Uh5LrBgzIbKDSoq6htQwD+KxCjLm3a/unhfoGhIjn9IxisJ4hWmWSN83n94gSEFq
	vJ/hloeJWxf48aRI0nQV1/EQMdAcMMqEo9wf4pYuOrfAvCG0EOIpBiNae3GIcy6p
	FUMzpvrIF1Z99wfCzqIw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4wx21y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Apr 2024 09:30:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43L9UQ5d026909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Apr 2024 09:30:26 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 21 Apr
 2024 02:30:24 -0700
Message-ID: <892ceba6-b38c-4d0d-a98a-b6eb5f2e6269@quicinc.com>
Date: Sun, 21 Apr 2024 17:30:21 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix two regression issues for QCA controllers
To: Wren Turkal <wt@penguintechs.org>, <luiz.dentz@gmail.com>,
        <luiz.von.dentz@intel.com>, <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <krzysztof.kozlowski@linaro.org>
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GhmQ_sgCaNv6ujbxnk1fgh7Lz8wDgXD8
X-Proofpoint-ORIG-GUID: GhmQ_sgCaNv6ujbxnk1fgh7Lz8wDgXD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_08,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=983
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404210060

On 4/21/2024 3:44 PM, Wren Turkal wrote:
> On 4/20/24 3:06 PM, Zijun Hu wrote:
>> This patch series are to fix below 2 regression issues for QCA
>> controllers
>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
> 
> @Zijun @Krzysztof and @Bartosz Would it be helpful for me to test these
> to ensure they fix the issues I reported?
> 
Hi Wren,
for QCA6390. this updated patch sets is the same as the patch sets you
ever tested.
sure. if you would like to test this one.
>> the links for these issues are shown below:
>> https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>
>> Changes:
>> V3 -> V4: Correct code stype and commit message
>> V2 -> V3: Wrong patch sets are sent
>> V1 -> V2: Remove debugging logs
>>
>> Zijun Hu (2):
>>    Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
>>    Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable
>>      then warm reboot
>>
>>   drivers/bluetooth/hci_qca.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> 


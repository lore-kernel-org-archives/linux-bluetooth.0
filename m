Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAA84D1F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931663; cv=none; b=strV61V1fkVFUOneBgpqLwZU5sTffQlwrGKiwv8ICH0Xwzgvk+exzDYB3KDxhyC7TWMNNy7Iqbzt/kGqYtiQ3/Tpm3/4wOOp7wF1L9bMlVTmpYZRb3AdoFMMdF9HS3dbRdSN2nRj6bpu1OAwX//LcGh5PV2aYzoBkF4X6dLua9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931663; c=relaxed/simple;
	bh=39Aqo+0p4yp1ag9gauTzIhyA5u71CmK9Kuy6S/S0npo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LyYxUSSubyyXQkU97cAsGAy9NVtCOg3b0LbWt4unv2J20vuMgbecNxUINAxvKnE60KPG3OjViiUsjD0cBeW265n6qZv1MXzk3Cnv//XDqarv3IQLbGwcm0QY0L74jgUl4F0k11MM2bi23Ma2UVxD1M6U3CKTQ1hjwjLBpPENA9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pvlL0kw0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvlL0kw0"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O37cuL000461;
	Wed, 24 Apr 2024 04:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=o6p7eSYgE44ujsXv2G2MJ2ia2CXZb9SRR+YctUhrod4=; b=pv
	lL0kw0y1TV6CA9XKY/0udQ2Ujf3nw6kf6VIiUOosdwB0MyeZrW2d99kFJCmP5cXh
	qnJB++wvUKMzKytrg+8wDa6vgI0NQkgBxmjfosB65cVYA4zTZXNQ3wFpSEgwEt93
	6vFf5C5S8V2bF6oHB4XgYa5UQSea66gfkmpuYxk8pMtHrxir7sP4lJxAZt3gzZ1I
	JkG7lOMfHozAnUpDOkBwI5jZ5nZ22U9+zUirbx44KwsS5e2/GNtMvbcbp7U1oml3
	tSSq/4mbhkXd0h/3igL6UCkpzvY5xcUOwqcs7iDn1+t7XUv3h1yniNiuykVErHPb
	Hvy5OzZo+BhX95a+mDXw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtncfpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:07:33 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O47WMu010158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 04:07:32 GMT
Received: from [10.253.72.119] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 21:07:26 -0700
Message-ID: <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
Date: Wed, 24 Apr 2024 12:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qg2e9BbOd6gcc7Qrob7ZMEstRz-Tsp5g
X-Proofpoint-ORIG-GUID: qg2e9BbOd6gcc7Qrob7ZMEstRz-Tsp5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_01,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=942 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404240017

On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
> On 24/04/2024 02:46, Zijun Hu wrote:
>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>> with gpiod_get_optional()") will cause below serious regression issue:
>>
>> BT can't be enabled any more after below steps:
>> cold boot -> enable BT -> disable BT -> BT enable failure
>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>
>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>> case as shown by its below code applet and causes this serious issue.
>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>                                                GPIOD_OUT_LOW);
>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>> + if (IS_ERR(qcadev->bt_en)) {
>>   	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>> 	power_ctrl_enabled = false;
>>   }
>>
>> Fixed by reverting the mentioned commit for QCA6390.
>>
>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> Tested-by: Wren Turkal <wt@penguintechs.org>
> 
> No, Bartosz' patch should go.
> 
what is Bartosz' patch.

> Best regards,
> Krzysztof
> 


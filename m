Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B3158A1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950548; cv=none; b=IR7j0dDahHzE5Xdo+0pEMleJxYmnhJ+yZLLKAX29FD3kqPA6vAXtisPmjs9LpgKw5IwxSD78rZMm0rVqe9DI3HrC+uLyY7LsX/BDdCeSolf2a5MmrTnHIPYUkbKej7SiRoCd15v4HRtRSMJ1frpyxM5MOqmNoGxxjClBAhepqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950548; c=relaxed/simple;
	bh=StDUdojlwo1qWzZBipNVZoiR4DT4qoXbymf91IDx0K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pzZvk6/dvjbLl4hQ4diSiy/AgM2LdHOOh4iLZj8KMs/J1OL4d882NLlZzhmLCFgnm8ZKiQbPEMnYfVrhL6fS9Gxazj3/ZcZvAHjyECLz7rKtIH59MLOzs3HVo9SjVraXJPCuPoZ2VT3921BJAbjIU/+aF6mlRuzozp1VMLNl320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WjvzfY7M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WjvzfY7M"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6gVdX003342;
	Wed, 24 Apr 2024 09:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5m1FHQepmOLUWPDnWSjuGQElwwZ3TIwLVPZ82IzZtGA=; b=Wj
	vzfY7Mfv71NJy+PLPwgffFPhk2+aueM7Zobrpe6VF2GbiNI8g0WccLRLojQrabLA
	3rPko4F3kvyVJB46LBlnYHLLO6zmcRlPoHsnPpFDT/UD94FbEOoIm5J7MZDIcQcU
	M1P+PP/z48Fsj+mhrjZsBInHDPE/JQxZZ5iwsPPlvzjsKylT0r9NCp3ZgmVS9PFr
	xpWZwX8JJ6G2aLG5SOtopnMV6gBoGKI+47lHUZ7zNJmYWAfsGhCmqNKJogtHnkx+
	lJ5CDsidXTUKqV1MyZlw3vjO/aUNoSznxTx1BqZ+WfAHdfAL1jEMrQp/yUMoVcgm
	HdtIEt1yNfPIgrCKsRdg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e0dxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:22:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O9MICA026123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 09:22:18 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 02:22:12 -0700
Message-ID: <0cba3838-917b-48af-ba8b-2ef60714943a@quicinc.com>
Date: Wed, 24 Apr 2024 17:22:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Correct property enable-gpios handling
 logic for WCN6750 and WCN6855
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>, <kernel@quicinc.com>
References: <1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com>
 <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <af004bcd-0649-4a82-8f09-36d6addd0e1e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RTsKe1EfRN14klZZor3YlYFRyhMwZbq3
X-Proofpoint-ORIG-GUID: RTsKe1EfRN14klZZor3YlYFRyhMwZbq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_06,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240040

On 4/24/2024 4:44 PM, Krzysztof Kozlowski wrote:
> On 24/04/2024 10:35, Zijun Hu wrote:
>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>> with gpiod_get_optional()") has wrong logic for below case:
>>
>> property enable-gpios is not configured for WCN6750 and WCN6855
> 
> As I said before, bindings say this property is required. I already
> asked you to provide rationale describing hardware and update the
> bindings if they bindings are not correct.
> 
1)
you ever given below reply at below link
https://lore.kernel.org/linux-bluetooth/52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org/

"The pin is required on 6750, 6855 and maybe others. You cannot not have
the GPIO"

2) for property enable-gpios, they are required for WCN6750 and WCN6855
in my opinion,  i am a member of BT team.

3) only care about the case property enable-gpios is not configured,
the original BT driver design logic indeed matches with binging spec's
requirements before bartosz's wrong change

4) please ask dts owner for help if you suspect current bindings spec
has something wrong. it is not my responsibility for providing such
info, that maybe involve CCI.

5) gentle reminder, please realize that there are many lunched products
already when you try to change some important logic, i don't suggest
change important logic or setting if there are no actual issue reported.

> Best regards,
> Krzysztof
> 


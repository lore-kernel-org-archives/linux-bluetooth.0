Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57282C6A3;
	Wed, 30 Oct 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281510; cv=none; b=rFjLu/01qGUUzeuAlhxZogNURFBCX+9J90AKqelVrCKTNu3ApaR4u0OROx+fR72D/xF8eQTTHqoAimxLUSTsFg8a+UDdOV9CxS4DHvzKOvdNGPBT7LRG13J/ZmdBb7r1ZUdzhRbnxO0gw85b0peMU8NNHD6jGV67AKH3F/PTbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281510; c=relaxed/simple;
	bh=DcfLXZMdyguicjxslWmG0tQU/gpyKc8jDYUhtVhpXMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aukYg6scMcjfNjy8HyUGLH+X0h/6IN+X1PaVqwx7nveVmFbgmSY53zblsZ5UTETXbvB4oBDwzjT8tERs5Y8TOi7wqGdW9fxkC6z3k7YjSJkjAzBs1wGpJd3BqidJ7U9ZkDzo8qBMEBB8v5E784I9qtaa3c5NeMEW/kGf8hWZw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RYNDBJnU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RYNDBJnU"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TNeRu8009284;
	Wed, 30 Oct 2024 09:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ecNXfS87uQXt17NqlNBGsyUw3SzU4L6dRLMjRUbAHEY=; b=RYNDBJnU6ZVuEFw1
	T/LQKerNr3CCgkO3xaUUfZddcz5x7q72qtzgk9TZ6p6u1BxQRv+J5rxRLPKuVkpN
	mAXLeIsX/sG3xZR3Ai3GrhEFj1HGi7fl5gm2XF4HRZJebZy/Ed2PYZiDtSsvT2fx
	WA0yqloAly2QPKnORS8m5In5ExVe8vmMyvBiYYKjpXgy0oSDMphqL5bIKz9jwJl7
	LqU52R6bnBvkd5Ed6Cdiz4QF1qD05QNfJuA16Zugdrm5qOKytDmYpCxBFh/1b4Ip
	dDfk0cwlOCVYvj3qPw3VO0QoiHhg2ouni06ARnIKx5VBhpwDUKLDZQihf91uIQXc
	d4lb+Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42jxa8baq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 09:45:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U9j1c9025614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 09:45:01 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 02:44:58 -0700
Message-ID: <1c7fb392-101e-4c28-be4c-dc8534a5b28a@quicinc.com>
Date: Wed, 30 Oct 2024 17:44:55 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: bluetooth: Add qca6698 compatible string
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Balakrishna Godavarthi
	<quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241030085714.1712454-1-quic_chejiang@quicinc.com>
 <1e7d2b10-f170-4996-9ac5-3104cfff21d5@kernel.org>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <1e7d2b10-f170-4996-9ac5-3104cfff21d5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7kHAdUd9E0h8QqZTC8QoSf7XEIEXG1CD
X-Proofpoint-ORIG-GUID: 7kHAdUd9E0h8QqZTC8QoSf7XEIEXG1CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300075

Hi Krzysztof,

Sorry, I miss the compatibility part and will submit a new version. 

On 10/30/2024 5:26 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 09:57, Cheng Jiang wrote:
>> Add QCA6698 qcom,qca6698-bt compatible strings.
>>
>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
>> ---
>>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml    | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> index 7bb68311c609..8ae1827e6a70 100644
>> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
>> @@ -24,6 +24,7 @@ properties:
>>        - qcom,wcn3991-bt
>>        - qcom,wcn3998-bt
>>        - qcom,qca6390-bt
>> +      - qcom,qca6698-bt
> 
> This looks incomplete. Does this device has really all these supplies?
> Look at the binding.
> 
> Best regards,
> Krzysztof
> 


Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D402837A;
	Thu, 26 Dec 2024 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735193492; cv=none; b=KkK3P5okjg4k1mgJnoS+W99SHEJF/KuScksI0iRmYdnlCaJPWltZgWqJlMuSrQ3jkIt0uPT7nQXPphtPaNuIUHzP81Rz/9RosSR8fPAUiofE9Vnh9cHy76x1M/arn8Pbx6upfMqbLDYMtqo4iVxkWkhdBCwpv8Pwk3+sXWYcdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735193492; c=relaxed/simple;
	bh=7O++P0aQf7wFU5QoM+xjjCNc5NEzxopzZkrF4QZNE7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YhyREetrxEVFViAV/R7dQ3bmPfn0xlD3PXMNSHOdQKtKXqNfCa7C8/JUFmYbBDyUnCFqKuHUdJho2uBS88FbGOos1TUVe4wjpWP41kmllQ8Tk4h5Ce5FQFTjnp6s4N8yf1YVbEzstapFPfEFQUGVPDeXLMIQiSQbEMpbAoR4IDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=emhNFb6C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="emhNFb6C"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BPNxEEQ001037;
	Thu, 26 Dec 2024 06:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DioB1hbHyxjdLfhJQEneqmDqR8TYk531i72cDCBbjBA=; b=emhNFb6CPR87mg+u
	kYx2hpK/2xGqKuwZxEx/Gg3L4qISZFjK30vhMuC3nIdAjg7DyEX0RBGXVC6+i1wE
	2D3c6jkeEqO27ZbI+m4H7huPEaVUhIsWdJGQKK8f4n5mtN8Liso0BBJvHLZhuKM9
	a5/D5Eo7F9hEFlVoq0FGglUCRi0W0zSxsm6zDWLO6U8XyZ7iDv0HuE8socMfLcSF
	DiLn+80+AIOz26bJndmtxObhW8WRIiTnqYi4gfHLM2TDuOABdl3gaBvs8P+0wVAW
	+ShvizsNaK3m6TbcP7FEYygB3UK+DN7elfb5VYdZTVlDjy4WA+9ZJFEoKGtCwuM1
	lUScRw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43rmamtr68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 06:11:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BQ6BBUi014308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Dec 2024 06:11:11 GMT
Received: from [10.219.1.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Dec
 2024 22:11:07 -0800
Message-ID: <d7b75672-4885-491c-9797-906261979e15@quicinc.com>
Date: Thu, 26 Dec 2024 11:41:04 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] dt-bindings: bluetooth: update the wcn6750
 required properties
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Balakrishna
 Godavarthi" <quic_bgodavar@quicinc.com>,
        Rocky Liao
	<quic_rjliao@quicinc.com>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241223135700.22660-1-quic_janathot@quicinc.com>
 <20241223135700.22660-2-quic_janathot@quicinc.com>
 <mzfad53v2paz7cawaepvaqeht2rr5spxyctqrlniiqgyfyyqlv@ixhxcksd3guz>
 <c87b12d2-06cd-4982-838d-ecaa97572369@quicinc.com>
 <31ddcb1f-4606-4c5b-893a-179718ed6339@kernel.org>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <31ddcb1f-4606-4c5b-893a-179718ed6339@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WvRWxVka2AYCxMFSuwQ6ZsSzBtAaptzY
X-Proofpoint-GUID: WvRWxVka2AYCxMFSuwQ6ZsSzBtAaptzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=830 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412260053



On 12/24/2024 6:57 PM, Krzysztof Kozlowski wrote:
> On 24/12/2024 12:51, Janaki Ramaiah Thota wrote:
>>
>>
>> On 12/24/2024 2:46 PM, Krzysztof Kozlowski wrote:
>>> On Mon, Dec 23, 2024 at 07:27:00PM +0530, Janaki Ramaiah Thota wrote:
>>>
>>> Subject: everything is an update... say something useful, e.g. use PMU
>>> abstraction for WCN6750
>>>
>>
>> Sure will correct it in next patch.
>>
>>>> Drop the inputs from the host and instead expect the Bluetooth node to
>>>> consume the outputs of the internal PMU.
>>>
>>> On which device?
>>>
>>
>> It is for BT module wcn6750 attached on qcs6490-rb3gen2 board.
>> will update same on next commit message.
>>
>>> But anyway I have doubts this is correct. enable GPIO is a pin going
>>> from the host, not from PMU.
>>>
>>
>> Yes you are correct, enable GPIO is out pin of host, but here updated
>> the entries required for Bluetooth node from PMU, not from host to PMU.
> 
> Hm? No, you removed for example enable-gpios, which is input from the
> host. Sorry, I don't understand the reason behind this patch and commit
> msg does not help me there.
> 

We are migrating to powerseq for the WCN6750. As per Dmitry’s 
suggestion, we are now using the on-chip PMU, which necessitates the 
removal of some entries that are not mandatory to avoid binding errors. 
For example, the enable GPIO is now handled by the PMU with property 
bt-enable-gpios, as shown in the patch linked below
https://lore.kernel.org/linux-arm-msm/20241209103455.9675-3-quic_janathot@quicinc.com/

Thanks,
Janakiram

Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032818E75A;
	Tue, 24 Dec 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735041093; cv=none; b=HvXV2sBVS/LSXW6WMhd0KoR4QSKXmkXp7qMhVtUdmuoIFUvX9ao3/knyTAoIdOA7g0MoSuIWf2h1r9SqLazle5sz1mig/Gcht+8dmYUG3ItfvH0Nw6e/G5HmOUP4t1LnS/yBVU8ulCt6oN9+k9HdihResS8zlwFnBkLeJazue2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735041093; c=relaxed/simple;
	bh=0D5Yp5heyCqPfTeRqkmfQevGoryrBJWym/J7AzLVbCY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=PKkLvcLbxuGjYhcXNgkj0/o4rUdeUBdE8fnH2ocHHFeltfPW7GMpNg/Qrtx+W+uH76n97tVb3axvnKkFeDQJSE5lDLAbc4Ghn2iUQTwK60m+u+Hz5nEwC8/cE2Aw8LiBaDSJ461qXAhOdYSgjpORORIqdhdO/UjkukhaCug+sBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HtL85CEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HtL85CEi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOBLmgt027689;
	Tue, 24 Dec 2024 11:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dx9FvFiqMuEqQlgNnpYkKZE+IacEZdrYyV29vVTcyjM=; b=HtL85CEi4D2L/FP6
	m1NAPO4G2E1FwcvBxHzAopXSabxB4QR3VvptiOFejJ0ihCUv+OatlhWd4+wFfCs5
	loepMQc1e/VL3StK4WqFXV8xR7jCpQVb5f2Bb++7vzzzOg1hr8Hl6BfFUKhRDKg0
	Ir7moAXQ90FopCFPV2NAb4wWVU7uSHhwEMGsmNJW/pLgMHfFNkuFqmt2O3c5tVMf
	gcKRBLkCDYRHz5qkEa2EqUWc5eJ6cTwg6tlcMkLTatf9UlnxX/iDgA1lK5/5nTh9
	nqS94ico5rx5nIHyiUOpwS1KuWwGH+yzOv4yoBFujWBRetVM7Sz1cwsw2mivhlq2
	xATKiA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qv0wg2v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 11:51:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOBpPaT015660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 11:51:25 GMT
Received: from [10.219.0.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Dec
 2024 03:51:20 -0800
Message-ID: <c87b12d2-06cd-4982-838d-ecaa97572369@quicinc.com>
Date: Tue, 24 Dec 2024 17:21:18 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
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
Content-Language: en-US
In-Reply-To: <mzfad53v2paz7cawaepvaqeht2rr5spxyctqrlniiqgyfyyqlv@ixhxcksd3guz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0_R5hiU1t7U3_wgL9Fxx1HmcWbmFubvF
X-Proofpoint-ORIG-GUID: 0_R5hiU1t7U3_wgL9Fxx1HmcWbmFubvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=822 spamscore=0
 bulkscore=0 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240101



On 12/24/2024 2:46 PM, Krzysztof Kozlowski wrote:
> On Mon, Dec 23, 2024 at 07:27:00PM +0530, Janaki Ramaiah Thota wrote:
> 
> Subject: everything is an update... say something useful, e.g. use PMU
> abstraction for WCN6750
> 

Sure will correct it in next patch.

>> Drop the inputs from the host and instead expect the Bluetooth node to
>> consume the outputs of the internal PMU.
> 
> On which device?
> 

It is for BT module wcn6750 attached on qcs6490-rb3gen2 board.
will update same on next commit message.

> But anyway I have doubts this is correct. enable GPIO is a pin going
> from the host, not from PMU.
> 

Yes you are correct, enable GPIO is out pin of host, but here updated 
the entries required for Bluetooth node from PMU, not from host to PMU.

>>
>> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
>> ---
>>   .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 -----
>>   1 file changed, 5 deletions(-)
>>
> 
> I don't understand why this is v6 of previous patchset. There was no
> such patch before.
> 

Just to maintain the previous patch series history named as v6.
Updated the cover letter with previous v5 history:
https://lore.kernel.org/linux-arm-msm/20241209103455.9675-1-quic_janathot@quicinc.com/

Thanks,
Janakiram

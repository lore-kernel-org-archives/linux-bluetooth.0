Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094B1E2319;
	Wed, 30 Oct 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283507; cv=none; b=DHigkjXz4cSFxGX1foJIGpBSqvIASY7eIBzy38CwouWIWlQF/56/mFsGAcToSd9RaE+ii+fDSMaE4lui5PDevs61F5Ftp0tJw0SzHwQbSu5X1rQngFpo4/ZZzZyRK012tunQrHVpEm9Xz34OUfbhHsi14EEbQivbS3/Wel9CEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283507; c=relaxed/simple;
	bh=pIZSgVBZoGsma32kCIjCsfYl1up3iXfBigKifYHJFzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qmm2MaiYWw3hyptkQJ0kupO9pSSrT6j37g1QWRHoTKOCYqzrE+RTDZ2STcffakStU2qFnxUDepK5G5WGrHmEEyEocALlJSL6Mt4nbknFU0+uhear7b+i905CyozCyOHRf3ec9NvaSbijYnbglUTH3PHyh/cjMVlJ2Hjkm3B0lpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QRfPMiXb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QRfPMiXb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UA6mmY014001;
	Wed, 30 Oct 2024 10:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LorPk2tnTgKVbzoXRQEjKhPGcCO7bzXOz7gGLsK2SF0=; b=QRfPMiXb6md/6mdF
	elL7HuMOSve0sfF/6qt6THSqKRbXW2LD1xm9javWKTVQNZOeprrIuSdgJxtkWUZg
	xqUXQcqJVpFdEmY1dY/Q9JzI02/CPsGJdUm7vkF2Iuw5VBLOQldtac4CNJJB/PLT
	ZY1Ftk9yozhwQu/rmNLVMhDN6R6dmYwhRwh0IogtQ1MCG9t/Cv/7PHQWjgKN8MYU
	M//Nig76VUKS1Aen6OyYAY0BpzTQPuuQMf4uq+mQ8HDyO5q49hhCPZFJDvob6h/H
	dmgZ9tkucAJiaHXT/fXbtRJXrS4+6+DMlK5QCwJYWToTpQlMJLYS2Do03I+MCE5B
	QQs4/Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqe63gx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:18:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49UAIGdL032205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 10:18:16 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 30 Oct
 2024 03:18:13 -0700
Message-ID: <1bc7432e-8032-4af1-8551-75ca53811a18@quicinc.com>
Date: Wed, 30 Oct 2024 18:18:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: bluetooth: Add qca6698 compatible string
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
References: <20241030094728.1714034-1-quic_chejiang@quicinc.com>
 <331435ea-87ac-4fae-bf0b-3e6ae19dc3dc@kernel.org>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <331435ea-87ac-4fae-bf0b-3e6ae19dc3dc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9B_N646mXawUCccUYf_6jdzvo6W1MX1a
X-Proofpoint-ORIG-GUID: 9B_N646mXawUCccUYf_6jdzvo6W1MX1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=965 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300080

Hi Krzysztof,

We have a new chip(qca6698) to attach on sa8775p-ride board. 


On 10/30/2024 6:00 PM, Krzysztof Kozlowski wrote:
> On 30/10/2024 10:47, Cheng Jiang wrote:
>> Add QCA6698 qcom,qca6698-bt compatible strings.
>>
>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
>> ---
>> Changes in v2:
>> - Add the compatibility for qcom,qca6698-bt
>>
>> ---
>>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Please wait with v2, v3 and so on.
> 
> Where is any user of this? Nothing in commit msg explains why this patch
> is needed without users.
> 
> Best regards,
> Krzysztof
> 


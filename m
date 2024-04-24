Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2D13C82F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935135; cv=none; b=CjBSX9/EdQI+zgNwdMSxWNeL8sEoAXIknGBgpY5evP/99xh90UseGRK95cbAK/m5n91leKvxdZtzlxeqC+lJwMhlblqikVUUH/89O/Nm/x6L2pojnufpNXrmhIAimn555C/qZnxNPsBVoz6QJaiLxEW3wtbO/QmdOfqRHIh3tqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935135; c=relaxed/simple;
	bh=BbE/ObOUncunUSPx9PyZFUuFa7k/79A7IjqeS6/g5j4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=f458TImV+Q9EZwe0Y70i/nIWukaoER+yN/ND7016Qv6q5cyAK15bljrmtC6v7BZxbkyPt2CjkXa5t9X7UEq6xYgjHrpjgNf1O+a4Hr7xigH++d38fKsF0C9SNvkXnJYrVlweKxMOBNzu2fpKv5AD1BW1Bg2g9RxN0avHEvJ6b88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YIzG4feu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YIzG4feu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O4DN0d025309;
	Wed, 24 Apr 2024 05:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JqK6/7a4B4OxAtoNpQFpWIgYCtXc7vRpz7k6BGU+sM0=; b=YI
	zG4feu1mikbAM4B4oWznmmKbUt0lgWXID3Qek2Sqq9tKV8kCmfHTTCi73FRwHLM6
	7QyxEfvB/ro3BApEV1LMUdOkChQdRM9444lSVHDdSsxS5uG+FiI2o9Q+Oxj/KNMq
	d5XOzAEfscJeKRnsattdU072Hdp4xeYyLwQFdJde0lpqIOZIi1H5Ge8lGGFGkgY2
	X4N9RqW4xVR6XcSskjSzG9vn9ukCo4pwT1E32HYTyjZjdwAMhjRHHBbmWtSIkghO
	AJo49AAc+HV0ywXF+1oxiEtICp2ELhiIY8pTD63UdKYlXOsxk2uFqMA3KqjoAeX5
	5B8bpxvQzBTrSpQN2+FA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9c0k4cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 05:05:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O55PCT007559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 05:05:25 GMT
Received: from [10.253.72.119] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 22:05:20 -0700
Message-ID: <4c69d951-b402-49b2-9c42-478d2e79311a@quicinc.com>
Date: Wed, 24 Apr 2024 13:05:16 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
From: quic_zijuhu <quic_zijuhu@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>, <regressions@lists.linux.dev>,
        <kernel@quicinc.com>, <gregkh@linuxfoundation.org>,
        <stable@vge.kernel.org>
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
 <a8a7e3df-44c6-4fa6-a576-da384c02e9ac@linaro.org>
 <067db05d-56bc-4ca3-aef1-bc3bae47667c@quicinc.com>
Content-Language: en-US
In-Reply-To: <067db05d-56bc-4ca3-aef1-bc3bae47667c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4upj-raGk_rrRnel2wRIuhpLKF3HK_Di
X-Proofpoint-ORIG-GUID: 4upj-raGk_rrRnel2wRIuhpLKF3HK_Di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_02,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=680 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240021

On 4/24/2024 1:02 PM, quic_zijuhu wrote:
>> you concern is wrong and i am sure it don't block me sending new patch
> sets to solve other issue. so i send this v7.
> 
> i have give reply for Bartosz' patch.
> 
> i hop you as DTS expert to notice my concern about DTS in the reply.

sorry to correct a typo error.

Hi Krzysztof.
you concern is wrong and i am sure it don't block me sending new patch
sets to solve other issue. so i send this v7.

i have give reply for Bartosz' patch.

i hop you as DTS expert to notice my concern about DTS in the reply.



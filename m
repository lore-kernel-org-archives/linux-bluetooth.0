Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AADE573;
	Thu, 14 Nov 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573563; cv=none; b=OFAglT7lWkMSK22efYLFm92zOs5mhc6GOKwyVbIwciHM5tf+o3fbp2C/Jcn20fYsJXHzeXld2fxcG/DZxLp2nePhFSjKdqc5lJnYAfErSbamvxxoQM1OyClJfafqnb8lXZOWeBWqYe9F5OwVwtHpUsX+RSqAiUUxreAIZERYxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573563; c=relaxed/simple;
	bh=EBwtDwOsKCH6CTYObYd2v+L0jvmdAmZGhmhGmfNULGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K/HEJSaEESF82XV2H3QTbA/ZXbDQjHoEtKOKuHEMxqF0Brf806M8WB0hqaEk8Z+4AU7zpUqrgqZ74DoD0yNYWmA5trO9koZYFdPDA3XMyfx67Qc6P+As0XcO9R9cqsePLtRs+uGpLjSgOl9C+2/Uz8KzH2fGUvLqGUswNxe9jY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dmwqnYs2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dmwqnYs2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE6YaaY021963;
	Thu, 14 Nov 2024 08:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FyY8ubka/aZn6sXZqqVpJQXMCCbOKwtKPci4X6ZG1wo=; b=dmwqnYs2vpPR9EaO
	62eUMM3YlTjh/JfmIL+wKGEpIFLVk1gn2uMdBXCBi6gSBqGuEI+u7EFiSVlV6it9
	2SFW2JTREUMLCUZfuLoMzCtbsvvNPARyjprMPlDlLa4/L2rlsvRkkqKcaY9nS0a4
	iAa0oyZFw0aXHXlGVVH3Jdy/7ytF3d2ZF0z5nkid9SStK7jjEe1uSKPBN/yyo6jU
	fFH2MJW/uft0rmKMNUjFaNXIzawKshH14Loda0u+QhRMgXoMzVyUivN7sBXiFpoV
	H4933aMVU9N2DySL3b73kW+dm3zij7i0Vcvddb53XHN5Hbfbj5idapQMS53u3pQt
	2ZHANw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vsg545b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:39:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE8d7Lo016197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 08:39:07 GMT
Received: from [10.253.78.176] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 14 Nov
 2024 00:39:05 -0800
Message-ID: <8b04138e-c03d-4058-8663-2d3a0c48749b@quicinc.com>
Date: Thu, 14 Nov 2024 16:39:02 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA NVM file for the X13s (WCN6855)
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Johan Hovold <johan@kernel.org>, Tim Jiang <quic_tjiang@quicinc.com>,
        Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
 <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
 <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
 <f1b45d7d-27e0-4ad7-976c-670a0e0d136b@quicinc.com>
 <ZjOfdK41yLwkH25T@hovoldconsulting.com>
 <5549d7e4-06cb-4305-8cec-10e93e5fbbff@quicinc.com>
 <c23fe4b8-04ae-41fb-a166-0b8a84e2ef70@molgen.mpg.de>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <c23fe4b8-04ae-41fb-a166-0b8a84e2ef70@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Om8kNtR7hOMzsRB7qOk8dczwz7olGvJV
X-Proofpoint-ORIG-GUID: Om8kNtR7hOMzsRB7qOk8dczwz7olGvJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 clxscore=1011
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=1 mlxlogscore=208 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140065

On 11/14/2024 4:27 PM, Paul Menzel wrote:
>>>> let me try to find out the right person who will push this task at
>>>> next monday.
>>>> there are some other internal procedures before we can push BT firmware
>>>> into linux-firmware.
>>
>> have up-streamed 22 NVM files which come from WOS into linux-firmware as
>> shown by below link, both hpnv21g.b8c and hpnv21.b8c are also contained.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-
>> firmware.git/commit/?id=77a11ffc5a0aaaadc870793d02f6c6781ee9f598
>>
>> (^^)(^^).
> 
> Thank you. Could you please enlighten me, what WOS is?

WoS is Windows on Snapdragon, and which is preinstalled with windows OS.


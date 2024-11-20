Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B3A939
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113456; cv=none; b=t3VaeF3p6laM0Nr+dIygoCcdLf/D2FjqPNJAYkJlFRwDB5INKrwMcH34w6eXmwuyetiGQWAhsWSTE35AN6CWlcvpY0LSZImtCZTUR4Jw/F6Nb2fCyb7hkMaIdAHONRmNMU0UsZWt+IOTkHxAVUUM0vQT0hAxIPInChHeP84b63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113456; c=relaxed/simple;
	bh=su7WJmUIZ9jKE5Bez5z4iqyaWrwaXyXQAG01t2jjdJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lNLgkoQG8ncNAE9P0s2X9gR1+tQU3kK+x4c2vpO/wh589znPLm9PNsSuiqGeVHu9mk/5rU0x+Uk3I7JZR9ExytO0LxJCNQIKg/kfZHLCXmGJj6AOavit917tIPgv2Gdha6v/EtrdkD2Xt7D1qV/+3IMMpnnUUpL/6LWrsf2UE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S0UYudvY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S0UYudvY"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FJXF029732;
	Wed, 20 Nov 2024 14:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AGsU/RdNr7SLDLOKICRVFd66QweLovoaU2c/yIlIvbo=; b=S0UYudvYPHJkBhtq
	UVrdXf0d26yEa50ZyvHKhZMDr+Cp5uqnUYUQLon1SqwmK2LlAbAcXeOphYJQoVLb
	LNCrW6CqV2as4ayqL662VssgH6FjJpY2HanCe+eL/omMGnbCNdXVHxXDRX7e5Lmo
	3FzdNwvehLLx9H/wmxasjq5WiXaHto0eNUk+CiDRc9z07EvZE46/kIp1aIyQP9xZ
	SOE5s1nZvQ9G2W6c/kf2ShZ/Uo8bsQ0Dyb5iWB/q8XUY7n258iu5YN0ZqB8DbIUn
	UEqr/tEKZyyROcCw9vNR3fivJjcU+E4znRoB/jveuajdOaw33V67fgaTmKWo2u3c
	tw++yg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4319529dc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:37:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKEbV1t030558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:37:31 GMT
Received: from [10.253.9.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 06:37:30 -0800
Message-ID: <54817cb6-8e52-491f-b977-77ad712c7588@quicinc.com>
Date: Wed, 20 Nov 2024 22:37:27 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] att: Check security level before setting
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <20241120080447.233393-1-quic_jiaymao@quicinc.com>
 <CABBYNZJympX_P4vO1Vg6Y-RKZYJDrSrHRh79NmttyDY8hQRSOQ@mail.gmail.com>
Content-Language: en-US
From: Jiayang Mao <quic_jiaymao@quicinc.com>
In-Reply-To: <CABBYNZJympX_P4vO1Vg6Y-RKZYJDrSrHRh79NmttyDY8hQRSOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gCRYXM1c2s5Oxty9nvW5ubuUrT5LKK1Z
X-Proofpoint-GUID: gCRYXM1c2s5Oxty9nvW5ubuUrT5LKK1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=928 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200097

Hi Luiz,

On 2024/11/20 22:20, Luiz Augusto von Dentz wrote:
> Hi Jiayang,
> 
> On Wed, Nov 20, 2024 at 3:18 AM Jiayang Mao <quic_jiaymao@quicinc.com> wrote:
>>
>> bt_gatt_client_set_security could fail if the security level in
>> kernel is already BT_ATT_SECURITY_MEDIUM but long term key is not
>> ready. So, get and check the security level before setting it.
> 
> Ive already pushed a similar fix.

I just saw your fix. Thank you very much for the update!

> 
>> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
>> ---
>>   src/shared/att.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/src/shared/att.c b/src/shared/att.c
>> index 4a406f4b9..dabbdb431 100644
>> --- a/src/shared/att.c
>> +++ b/src/shared/att.c
>> @@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct bt_att_chan *chan, int level)
>>   {
>>          struct bt_security sec;
>>
>> +       if (level == bt_att_chan_get_security(chan))
>> +               return true;
>> +
>>          if (chan->type == BT_ATT_LOCAL) {
>>                  chan->sec_level = level;
>>                  return true;
>> --
>> 2.25.1
>>
>>
> 
> 


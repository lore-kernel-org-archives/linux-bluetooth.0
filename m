Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29A1EA90
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986604; cv=none; b=iVhJCoqvXiJ67t5HGvRys2Iu70zYBZyylCSl37yN0+wUY9dQQdGxj+ceDwdBYL3E5AYvRg5pzU59iY33kMBHQkKsIZxgSxE13NsLT2BdfHwpBoKZo1iWelFtsMmEu66kaLMV0Xz8+M45oVbXVNZLmdavVE56yKckttRj+uvIt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986604; c=relaxed/simple;
	bh=2jNVecL0wlljCj5IuGdrYLSq/mZcver6DeQnCanvVDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dpQcuJVfJZ8Noppb/RL96RI6Wu8HQzNPpym0Lw67yqE1gOch6rcybOQrmAJVf0yUo2ytLR7epr+hs39FixKzmDrEXYt+jhNkBYZVEfqSlAiRKoeUaWzMHUdnLIXA980T59F0TR1HT8cJ4Faun/zTliJXUf9sXuqEBj9AqL9eisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KWJZ8GrL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KWJZ8GrL"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGLn4M011441;
	Tue, 19 Nov 2024 03:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ojzSOYUnaGd8aVfldc+kNPIrsxYzZhjI5DcUl0qEtDU=; b=KWJZ8GrLhYe3sT9g
	akNhx9bmSBqM+gNdc8A+jqL8it2rO4To9pLOMv3Zx++xMoYUCFEAS5UpfboBHp6o
	Hp9bQanKS4OjcClkWlWGViYsDBx2RRBSHt/EWNDpNo+HEtBIESxHah6F9OjrgEoJ
	HoPSnC/aK9jiNiXF7G05BnvhknnccOz5RKpcYSLNTG60r33BwH10vkyXAWwoV62Y
	KgnbpIcoFPETN1fKvnHIIYWOnQ8PjM6YvToauac2BGAdQmA3knCaVolgr+lB3dFV
	a+6f9HIo/jz/Lk69fi873tJH2sd8cHhAhY9Y9/o6mCoS2jkm9mDJurFxnc/Noj+e
	JmdVeQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43091m98xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 03:23:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ3MJxc026392
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 03:22:19 GMT
Received: from [10.253.76.47] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 19:22:06 -0800
Message-ID: <421ab7ec-dc32-4bac-a3c0-9ed2d48a902c@quicinc.com>
Date: Tue, 19 Nov 2024 11:22:01 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hog: Check security level before setting
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_chejiang@quicinc.com>,
        "Jiayang
 Mao (QUIC)" <quic_jiaymao@qualcomm.com>
References: <20241118094907.2673431-1-quic_jiaymao@quicinc.com>
 <CABBYNZK9Z2fKiFmfnptUsX+yrvaKNW+b_BfQyidM=z2YU499nQ@mail.gmail.com>
Content-Language: en-US
From: Jiayang Mao <quic_jiaymao@quicinc.com>
In-Reply-To: <CABBYNZK9Z2fKiFmfnptUsX+yrvaKNW+b_BfQyidM=z2YU499nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5kcClsmJJTf_JAvzi-DqZP3_ZmSQ57mh
X-Proofpoint-GUID: 5kcClsmJJTf_JAvzi-DqZP3_ZmSQ57mh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190027

Hi Luiz,

On 2024/11/18 23:13, Luiz Augusto von Dentz wrote:
> Hi Jiayang,
> 
> On Mon, Nov 18, 2024 at 4:49 AM Jiayang Mao <quic_jiaymao@quicinc.com> wrote:
>>
>> bt_gatt_client_set_security could fail if the security level is
>> already BT_ATT_SECURITY_MEDIUM. So, get and check the security
>> level before setting it.
> 
> Seems a bit strange that this is not handled by the kernel, can you
> elaborate on the conditions to trigger it?
> 

In the kernel, the failure happens when smp_sufficient_security() in
'net/bluetooth/smp.c' returns true. In some cases, when security level
is already MEDIUM but long term key is not ready, setting security level
will fail. Checking security level before setting it can prevent this
failure.

>> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
>> ---
>>   profiles/input/hog.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> index 017e320f0..011cc0a88 100644
>> --- a/profiles/input/hog.c
>> +++ b/profiles/input/hog.c
>> @@ -191,8 +191,10 @@ static int hog_accept(struct btd_service *service)
>>                          return -ECONNREFUSED;
>>
>>                  client = btd_device_get_gatt_client(device);
>> -               if (!bt_gatt_client_set_security(client,
>> -                                               BT_ATT_SECURITY_MEDIUM))
>> +               if (BT_ATT_SECURITY_MEDIUM !=
>> +                       bt_gatt_client_get_security(client) &&
>> +                   !bt_gatt_client_set_security(client,
>> +                                                BT_ATT_SECURITY_MEDIUM))
>>                          return -ECONNREFUSED;
> 
> 
> Definitely not the right way to fix this since there might be other
> places that do attempt to set the security, so Id got with something
> like the following:
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 4a406f4b91a4..dabbdb4315eb 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct
> bt_att_chan *chan, int level)
>   {
>          struct bt_security sec;
> 
> +       if (level == bt_att_chan_get_security(chan))
> +               return true;
> +
>          if (chan->type == BT_ATT_LOCAL) {
>                  chan->sec_level = level;
>                  return true;
> 
>>          }
>>
>> --
>> 2.25.1
>>
>>
> 
> 


Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19A16EB56
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090372; cv=none; b=iL2NjWaG0pC/4+d83yOm4CpS3htrHn/+KgbATfbj4YU+prb0wNVnHgiEpQ4PmPwYoio6qfYUJoNiFjN1x4u6brmDdO+sOrDV7lVImF3Pw5XsdPu/BQ93dOHqpatWU6HNjlaDJ22AMPy9qPcsW3r0vLlNVadugrMoLXqN/bOq0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090372; c=relaxed/simple;
	bh=bo5J1qgrQN5+yTu9mqP9TrSXSPr6rddUjpsjjww5gIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WxuMVXqh/2+8ccfOaQXrlZOCnreDGxQnQuvLxq94FUVzedQx+Qk0AQ/4FfZS21A9ImB7fKDomah9WpQSblOdFsbR9G8zO8h0OEpKOI+0dybIjqnR5KlRzEJTlXvD+sfMzWA5/75DBUKEU+MLRBQZZvq0L8EaYXPFW5tsXL1e8rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iwy8EUhl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iwy8EUhl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK7xSoP019448;
	Wed, 20 Nov 2024 08:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fJxq5Q3DxPOqulg/M6YoZ7ZFZrvByMZnwGc2oyQoEqY=; b=iwy8EUhlISQA/qEI
	wuKT0lKRUXnYRASVo9GCr4//svrqlJQzMSTiNRRwhl8KGLIMTp1lSnH5riyJnKaA
	Pcj5pSTB0cVE4e0HmwXmingK2d21ZPMmDRHKqkMRGkQP+OlX+aG0ZpFrtDO5HkIS
	SbZeTDwJV8S6tYxwVWcwLFZbT4+WFgHgtQkqK++waFvPrwzkiEnN8dWIeDZf8DOV
	+Uldtn8UUoow2SFdJvq+72l9ueqWb9/e+SJXebzdqObHi6dRW8UpqvgHGehW/1Rg
	15RygWHKQ8LN1jhCJv6AqMnyypJdslI3eLIToUBvCBI3YvSXQlMfMFW7W6ZZJb9X
	wR2PGg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431bv78105-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 08:12:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AK8CmTa018090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 08:12:48 GMT
Received: from [10.253.9.184] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 00:12:46 -0800
Message-ID: <4ac30d08-8d65-42c4-8701-ac9974a384dc@quicinc.com>
Date: Wed, 20 Nov 2024 16:12:44 +0800
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
 <421ab7ec-dc32-4bac-a3c0-9ed2d48a902c@quicinc.com>
 <CABBYNZJdvSj0cTRjeR2WeCvv92xeWiXMFjnGC3inZik-D0iefg@mail.gmail.com>
Content-Language: en-US
From: Jiayang Mao <quic_jiaymao@quicinc.com>
In-Reply-To: <CABBYNZJdvSj0cTRjeR2WeCvv92xeWiXMFjnGC3inZik-D0iefg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ol8l9uU0HiAFQHHTaQ8cxIPZ-ZdmoRlC
X-Proofpoint-GUID: ol8l9uU0HiAFQHHTaQ8cxIPZ-ZdmoRlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200058

Hi Luiz,

On 2024/11/20 0:23, Luiz Augusto von Dentz wrote:
> Hi Jiayang,
> 
> On Mon, Nov 18, 2024 at 10:23 PM Jiayang Mao <quic_jiaymao@quicinc.com> wrote:
>>
>> Hi Luiz,
>>
>> On 2024/11/18 23:13, Luiz Augusto von Dentz wrote:
>>> Hi Jiayang,
>>>
>>> On Mon, Nov 18, 2024 at 4:49 AM Jiayang Mao <quic_jiaymao@quicinc.com> wrote:
>>>>
>>>> bt_gatt_client_set_security could fail if the security level is
>>>> already BT_ATT_SECURITY_MEDIUM. So, get and check the security
>>>> level before setting it.
>>>
>>> Seems a bit strange that this is not handled by the kernel, can you
>>> elaborate on the conditions to trigger it?
>>>
>>
>> In the kernel, the failure happens when smp_sufficient_security() in
>> 'net/bluetooth/smp.c' returns true. In some cases, when security level
>> is already MEDIUM but long term key is not ready, setting security level
>> will fail. Checking security level before setting it can prevent this
>> failure.
> 
> Hmm, is this about encryption change happening before the LTK is
> distributed? Ive seen that sometimes remote devices also have this
> problem e.g. GATT read return encryption required error but the link
> is already encrypted.
> 
> Btw, I assume the problem is in this following code:
> 
> https://github.com/torvalds/linux/blob/master/net/bluetooth/l2cap_sock.c#L931
> 
> That would fail with 1 because smp_sufficient_security would return
> true but we assume that to be an error, well it is an error but I
> guess it should have been -EALREADY that way one does not need to
> check the error again:
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 18e89e764f3b..ada0915c7421 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -919,6 +919,11 @@ static int l2cap_sock_setsockopt(struct socket
> *sock, int level, int optname,
>                          break;
>                  }
> 
> +               if (chan->sec_level == sec.level) {
> +                       err = -EALREADY;
> +                       break;
> +               }
> +
>                  chan->sec_level = sec.level;
> 
>                  if (!chan->conn)
> 
> Anyway I think it is safer to do that on userspace first so it acts
> properly with older kernels.
> 

Thanks. Following your previous suggestion, I updated another patch to
move the change to att.c:
[v1] att: Check security level before setting

>>>> Signed-off-by: Jiayang Mao <quic_jiaymao@quicinc.com>
>>>> ---
>>>>    profiles/input/hog.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>>>> index 017e320f0..011cc0a88 100644
>>>> --- a/profiles/input/hog.c
>>>> +++ b/profiles/input/hog.c
>>>> @@ -191,8 +191,10 @@ static int hog_accept(struct btd_service *service)
>>>>                           return -ECONNREFUSED;
>>>>
>>>>                   client = btd_device_get_gatt_client(device);
>>>> -               if (!bt_gatt_client_set_security(client,
>>>> -                                               BT_ATT_SECURITY_MEDIUM))
>>>> +               if (BT_ATT_SECURITY_MEDIUM !=
>>>> +                       bt_gatt_client_get_security(client) &&
>>>> +                   !bt_gatt_client_set_security(client,
>>>> +                                                BT_ATT_SECURITY_MEDIUM))
>>>>                           return -ECONNREFUSED;
>>>
>>>
>>> Definitely not the right way to fix this since there might be other
>>> places that do attempt to set the security, so Id got with something
>>> like the following:
>>>
>>> diff --git a/src/shared/att.c b/src/shared/att.c
>>> index 4a406f4b91a4..dabbdb4315eb 100644
>>> --- a/src/shared/att.c
>>> +++ b/src/shared/att.c
>>> @@ -727,6 +727,9 @@ static bool bt_att_chan_set_security(struct
>>> bt_att_chan *chan, int level)
>>>    {
>>>           struct bt_security sec;
>>>
>>> +       if (level == bt_att_chan_get_security(chan))
>>> +               return true;
>>> +
>>>           if (chan->type == BT_ATT_LOCAL) {
>>>                   chan->sec_level = level;
>>>                   return true;
>>>
>>>>           }
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>>
>>>
>>
> 
> 


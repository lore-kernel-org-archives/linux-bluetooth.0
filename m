Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492F8488
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Sep 2024 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726797377; cv=none; b=kqluZ3bu8Yxz69vZFeK11GYaoXVfxTWkxY8BIWH4y2vhbRkiQdxokTsxaHHKy2PBkVQi4jY569MRhouitdh0FsoUhl7IKmOqL+k768o1yC+ZsByR4Vi3wolAgtk08MdXhcgftKAmq6c39fuwTApWmOA+byqHU8z5VOHrlDhnavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726797377; c=relaxed/simple;
	bh=R6nGU3aX4SP4EOxy+G8aTatHAmzZwS/j+OFQzM6SbEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X2WSGi046V805vSbs8EV3YYsC2ad0XC3wSCgYeNRk3bqKZqu9qnt2ZsZoRSE8i6gJ0tz/jC8BnH/tsn3u8BaPGIT++sqt+lt6kmIhmwRJsHCJG/WT525/9mbaBjzGRp8viR1XB7dwRJObG2dIKquqNeO/eVW4Ogq+KGn+dBM1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BVb6ecDU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BVb6ecDU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ3unn017175;
	Fri, 20 Sep 2024 01:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2naC9ylN1yd1YUFBR9GuBkS4inv8C4kuVXfQ1JB9ogY=; b=BVb6ecDUL9faqIi7
	YAr1p+9rNmIXO3TJD7tQdq+P7f3fW26Hlykw6yXI1VL17GSLuHNx4UJDRNF1n0Z4
	bZCZf0Wnsaz9BZCDssfPmVRnQShmjhkswJ4mnN0Wihx6YZZbg/AGQWcZRtMb3P1D
	bl9EjQRAHxcp7zGxM0UT/3lpmS4Tpo4Wcd+pZtcKy8nfJXWSsffViK8yf+IrPUmG
	aIolXX/o+P7+bzyf0S7YgqufYNB04df6gD3W/9qE3mqrZooYnLITUj7JnqtjyjW9
	1nRuhTneqsMvSNTppk8XtATA7OZTQKQw7lmgBOR9ZYDZWEIlys4oF+btux7jizv0
	H9ZKqw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hhfc28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 01:56:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K1u71T004821
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 01:56:07 GMT
Received: from [10.253.79.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Sep
 2024 18:56:06 -0700
Message-ID: <240299f7-f5dd-4fab-af01-93af5a90d1b8@quicinc.com>
Date: Fri, 20 Sep 2024 09:56:04 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] adapter: Cancel the service authorization when remote
 is disconnected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <20240826090044.560142-1-quic_chejiang@quicinc.com>
 <CABBYNZLOawJZgtm89QKBpbMdS1_NgXOzHgh2ftBzPyNRKfx+Sw@mail.gmail.com>
 <aa242203-72c1-4503-8487-3f45b46a5ace@quicinc.com>
 <CABBYNZKatMoepAJriVOwFUrehDyABV26gU374xFyFY3CNnxWTw@mail.gmail.com>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZKatMoepAJriVOwFUrehDyABV26gU374xFyFY3CNnxWTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SYLR6oNch74_cZrG-JyBMxKo_sbHbvBL
X-Proofpoint-ORIG-GUID: SYLR6oNch74_cZrG-JyBMxKo_sbHbvBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200013

Hi Luiz,

Sorry for the delay, will send the new patch soon. 


On 9/20/2024 3:53 AM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Mon, Aug 26, 2024 at 10:30 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>
>> Hi Luiz,
>>
>> Thank you for your feedback. Please check the comment inline.
>>
>> On 8/26/2024 9:43 PM, Luiz Augusto von Dentz wrote:
>>> Hi Cheng,
>>>
>>> On Mon, Aug 26, 2024 at 5:01 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>>>
>>>> If the remote device drops the connection before DUT confirm the
>>>> service authorization, the DUT still must wait for service
>>>> authorization timeout before processing future request.
>>>>
>>>> Cancel the service authorization request when connection is dropped.
>>>> ---
>>>>  src/adapter.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/src/adapter.c b/src/adapter.c
>>>> index 245de4456..3ad000425 100644
>>>> --- a/src/adapter.c
>>>> +++ b/src/adapter.c
>>>> @@ -8502,6 +8502,25 @@ static void disconnect_notify(struct btd_device *dev, uint8_t reason)
>>>>         }
>>>>  }
>>>>
>>>> +static void adapter_cancel_service_auth(struct btd_adapter *adapter,
>>>> +                                       struct btd_device *device)
>>>> +{
>>>> +       struct service_auth *auth;
>>>> +       GList *l;
>>>> +
>>>> +       auth = NULL;
>>>> +       for (l = adapter->auths->head; l != NULL; l = l->next) {
>>>> +               auth = l->data;
>>>> +               if (auth->device == device)
>>>> +                       break;
>>>> +       }
>>>> +       if (auth != NULL) {
>>>> +               DBG("Cancel pending auth: %s", auth->uuid);
>>>> +               g_queue_remove(auth->adapter->auths, auth);
>>>> +               service_auth_cancel(auth);
>>>> +       }
>>>> +}
>>>> +
>>>>  static void dev_disconnected(struct btd_adapter *adapter,
>>>>                                         const struct mgmt_addr_info *addr,
>>>>                                         uint8_t reason)
>>>> @@ -8516,6 +8535,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
>>>>         device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
>>>>         if (device) {
>>>>                 adapter_remove_connection(adapter, device, addr->type);
>>>> +               adapter_cancel_service_auth(adapter, device);
>>>
>>> This shall probably be placed together with
>>> device_cancel_authentication in adapter_remove_connection but we need
>>> to track in what bearer the authorization is for and remove all
>>> authorization requests like in btd_adapter_remove_device:
>> Yes. It can be put in device_cancel_authentication, but the condition to call
>> this function in adapter_remove_connection need change. device_is_authenticating
>> is only true when request, notify or confirm pincode/passkey.
>> As for bearer, the service authorize is only happened on BDADDR_BREDR. So it
>> can be called when the address type is BDADDR_BREDR in dev_disconnected.
>>>
>>>     l = adapter->auths->head;
>>>     while (l != NULL) {
>>>         struct service_auth *auth = l->data;
>>>         GList *next = g_list_next(l);
>>>
>>>         if (auth->device != dev) {
>>>             l = next;
>>>             continue;
>>>         }
>>>
>>>         g_queue_delete_link(adapter->auths, l);
>>>         l = next;
>>>
>>>         service_auth_cancel(auth);
>>>    }
>>>
>>> I'd probably move the above code to a helper function so it can be
>>> called from different places, as for doing this on a per bearer basis
>>> would probably need to add bearer information to btd_service but I
>>> guess that can be treated separately.
>> Yes, it's great. Need use the above code to cancel all pending authorize.
> 
> Looks like you never send another version of this one, are you still
> planning on having this fixed?
> 
>>>
>>>
>>>>                 disconnect_notify(device, reason);
>>>>         }
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


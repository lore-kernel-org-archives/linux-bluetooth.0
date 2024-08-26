Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730D3CF5E
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682661; cv=none; b=LNtV47HcJfDBhORVVRJ1L9lCOGB0ZFdUy/3nnDALKWiljZNnwy7KObVIWfdTr+ychx5jSNC7op0EUeB8DsXfzoKcCjiN+vLAvdESA+IBi4r89OL7MLXo+WkZMndjAlgggE/SdcwmBsw5V1Y8/WDsoITVOLZdFNuADq2D4z+WO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682661; c=relaxed/simple;
	bh=FIR298YRcDYGIU3NvWMG/6BHadAyiv3cZvL54mf/azI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dbRmoNonxhCFMWSGlxC9+mbyRUT4JX4/z40oCo6TtoM+h3Kl98dDUsyUerF17pzHoYyZ9wiupx3wI8UitbQj45oXHQGpQ/kmWi0b8oCXPetAqW65syFTPICmeO0sDqDg2cjumKwMPoZG8l1wb6tPSCnWMGBH2B/Eg0gJ13+Co0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ktoAJ+QO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ktoAJ+QO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q8MQ2B017727;
	Mon, 26 Aug 2024 14:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ig4zsVmzZwsV+PVYGWw3cA0G99iT5yW/SdZtcq/1Sqs=; b=ktoAJ+QOQXuNqUTy
	qLog2boStMtj+fw/iW5myH/z36+lxxO21bKH+DN6ytVwKjtXVpf/xQkFSjCmmc7G
	QqimcH77iw3nTscUUv3Z4PBFsS7mC1nprw3uPJXp5KslL2WYWBiJUlWRMyWhRtGb
	snfxC0A3YOuQ5hG3X/Vo8TCfCF2Eun/eH/8IMl84q0rOczlIWPI0WYABjIHqY8nA
	0tlVK+SlYUaCColwIuavjnutAyjcqDXrXn5YrF5SXvwhRVbu6DgE2m/oc6AtN/Hh
	Kw7PJadS28CLww/ATuEhrrrcdlrK6EfUDgUxdlf/vWOO2Wbsu0HH/tdm1vjbKzNt
	7x1F+Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179a1uuvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 14:30:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47QEUuge011761
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 14:30:56 GMT
Received: from [10.253.34.208] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 26 Aug
 2024 07:30:55 -0700
Message-ID: <aa242203-72c1-4503-8487-3f45b46a5ace@quicinc.com>
Date: Mon, 26 Aug 2024 22:30:52 +0800
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
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZLOawJZgtm89QKBpbMdS1_NgXOzHgh2ftBzPyNRKfx+Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V8QqKRG43JnDPjqwE9e3t2vocPEjyKyz
X-Proofpoint-ORIG-GUID: V8QqKRG43JnDPjqwE9e3t2vocPEjyKyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_11,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260111

Hi Luiz,

Thank you for your feedback. Please check the comment inline. 

On 8/26/2024 9:43 PM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Mon, Aug 26, 2024 at 5:01 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>
>> If the remote device drops the connection before DUT confirm the
>> service authorization, the DUT still must wait for service
>> authorization timeout before processing future request.
>>
>> Cancel the service authorization request when connection is dropped.
>> ---
>>  src/adapter.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index 245de4456..3ad000425 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -8502,6 +8502,25 @@ static void disconnect_notify(struct btd_device *dev, uint8_t reason)
>>         }
>>  }
>>
>> +static void adapter_cancel_service_auth(struct btd_adapter *adapter,
>> +                                       struct btd_device *device)
>> +{
>> +       struct service_auth *auth;
>> +       GList *l;
>> +
>> +       auth = NULL;
>> +       for (l = adapter->auths->head; l != NULL; l = l->next) {
>> +               auth = l->data;
>> +               if (auth->device == device)
>> +                       break;
>> +       }
>> +       if (auth != NULL) {
>> +               DBG("Cancel pending auth: %s", auth->uuid);
>> +               g_queue_remove(auth->adapter->auths, auth);
>> +               service_auth_cancel(auth);
>> +       }
>> +}
>> +
>>  static void dev_disconnected(struct btd_adapter *adapter,
>>                                         const struct mgmt_addr_info *addr,
>>                                         uint8_t reason)
>> @@ -8516,6 +8535,7 @@ static void dev_disconnected(struct btd_adapter *adapter,
>>         device = btd_adapter_find_device(adapter, &addr->bdaddr, addr->type);
>>         if (device) {
>>                 adapter_remove_connection(adapter, device, addr->type);
>> +               adapter_cancel_service_auth(adapter, device);
> 
> This shall probably be placed together with
> device_cancel_authentication in adapter_remove_connection but we need
> to track in what bearer the authorization is for and remove all
> authorization requests like in btd_adapter_remove_device:
Yes. It can be put in device_cancel_authentication, but the condition to call
this function in adapter_remove_connection need change. device_is_authenticating
is only true when request, notify or confirm pincode/passkey.
As for bearer, the service authorize is only happened on BDADDR_BREDR. So it 
can be called when the address type is BDADDR_BREDR in dev_disconnected. 
> 
>     l = adapter->auths->head;
>     while (l != NULL) {
>         struct service_auth *auth = l->data;
>         GList *next = g_list_next(l);
> 
>         if (auth->device != dev) {
>             l = next;
>             continue;
>         }
> 
>         g_queue_delete_link(adapter->auths, l);
>         l = next;
> 
>         service_auth_cancel(auth);
>    }
> 
> I'd probably move the above code to a helper function so it can be
> called from different places, as for doing this on a per bearer basis
> would probably need to add bearer information to btd_service but I
> guess that can be treated separately.
Yes, it's great. Need use the above code to cancel all pending authorize. 
> 
> 
>>                 disconnect_notify(device, reason);
>>         }
>>
>> --
>> 2.25.1
>>
>>
> 
> 


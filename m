Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4B4A3E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Sep 2024 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314268; cv=none; b=f6YZilc0hCGlztEaE+FIK/RNGRkVPFKEpJA4xkUs70rxN+hOAviFmZJfF7Y514dWXJeXkDmaCnFoQ4/NsmLuETXJe6hT6KUGW6uoUwkPSnyfqg0KHz3EIF1c9GFQepJwmhm30/UuwjcMWWjgXt7T95zWXcBpMXxwkWCYq9VF+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314268; c=relaxed/simple;
	bh=4UQ9xc8Wzy5A/QcW8z/qGbGjmh1o40oypZozrH9izyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HfMoyGtp4Yecp45pitoaEiNDGS5rNNvz4aCuCMY5XGQkBrfRt/lLkJWalu0tZBT0Q3owdskdhhu/xf29cmKhE23xNTEx4KV1pJene2IH34Pvi0fEWceTD6mygNAE6muxuQkIJj6ENFeNZFnwCF/X4Pvfa/VrIaItXXeS4wPURGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JL5xV1kC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JL5xV1kC"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48PH5C0Z005943;
	Thu, 26 Sep 2024 01:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sYKy/vTRRmmn03qIDz+o+RhZk9kwWjtzME2Y8bv8NBY=; b=JL5xV1kC8RIW7BOK
	c5s2XFJPYWFDByCXKlVb4zv7IgeA3Zo9XXIrC01LcK0vcJkOpsOmMe8Eq7clcbzX
	sM9pSbgV/VT9xVHVQVzsbs/jkIlruPhEKU6biEphXO7dr/aJFgJd1McBqOkL4y1U
	JssXqWS1N0H5gPIQkIFHa2MYcuWAQyepEt1to0QGOK6GcikpZ52ICHChckODgr+q
	dJ0Z5K+R8hYL9HNrhCi4WxBKytQEWwOS5pmj8S+01oC5ZSCmDX/9vlw8RUHJKiB7
	w9YIp7WZQb2P8a75wciVPwwucRW18mkLlq3dxm5PRZsS2YalRE1b6NPx0e2uZhVt
	T9/ARA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqe9dn6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 01:31:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48Q1V2JN011357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 01:31:02 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Sep
 2024 18:31:00 -0700
Message-ID: <3a1dcec4-551f-434e-84e0-3d08924cb2af@quicinc.com>
Date: Thu, 26 Sep 2024 09:30:58 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] device: Remove device after all bearers are
 disconnected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_jiaymao@quicinc.com>
References: <20240925090948.1540589-1-quic_chejiang@quicinc.com>
 <CABBYNZJF0qMkEAE5rKz5GQB7ABkAHzSsMbn1Fdp3J8PdywOWtA@mail.gmail.com>
Content-Language: en-US
From: Cheng Jiang <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZJF0qMkEAE5rKz5GQB7ABkAHzSsMbn1Fdp3J8PdywOWtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rEndUdWhtCqkm1skK5dILEBg3tdc3s4T
X-Proofpoint-GUID: rEndUdWhtCqkm1skK5dILEBg3tdc3s4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=921 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409260007

Hi Luiz, 

On 9/25/2024 10:56 PM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Wed, Sep 25, 2024 at 5:10 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>
>> For a combo mode remote, both BR/EDR and BLE may be connected.
>> RemoveDevice should be handled after all bearers are dropped,
>> otherwise, remove device is not performed in adapter_remove_connection.
>> ---
>>  src/device.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/device.c b/src/device.c
>> index f8f61e643..c25bf6b60 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -3492,8 +3492,18 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
>>                 DBusMessage *msg = device->disconnects->data;
>>
>>                 if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
>> -                                                               "RemoveDevice"))
>> +                                                       "RemoveDevice")) {
>> +
>> +                       /* Don't handle the RemoveDevice msg if device is
>> +                        * connected. For a dual mode remote, both BR/EDR
>> +                        * and BLE may be connected, RemoveDevice should
>> +                        * be handled after all bearers are disconnects.
>> +                        */
>> +                       if (device->bredr_state.connected ||
>> +                                       device->le_state.connected)
>> +                               break;
> 
> While this seems to make sense further down there is the same state:
> 
> line 3531: if (device->bredr_state.connected || device->le_state.connected)
> 
> So what this is doing is just to avoid removing the msg from
> device->disconnects but perhaps I'm missing something.
Yes, it is used to avoid remove the msg. If BR/EDR and BLE are connected, when user perform
remove operation, the BR/EDR connection is disconnect first. Then it set the "remove_device"
to True, and remove the msg from device->disconnects, but BLE is still connected, so this function
(device_remove_connection) will return without set the *remove to True.
Then the BLE is disconnected, but at this time, msg is already removed from device->disconnects, so
"remove_device" is not set to True. And accordingly *remove is not true. The device is not removed for
adapter in adapter_remove_connection. Need to wait for temporary device timeout to remove the device. 

> 
>>                         remove_device = true;
>> +               }
>>
>>                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
>>                 device->disconnects = g_slist_remove(device->disconnects, msg);
>> --
>> 2.25.1
>>
>>
> 
> 

